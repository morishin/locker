#!/bin/sh

cmd=`basename $0 .sh`

function usage() {
  echo "usage: $cmd <command> [<args>]"
  echo
  echo "$cmd commands are:"
  echo "    help               Display help information"
  echo "    open   <filename>  Decode a file"
  echo "    lock   <filename>  Encode a file by password"
  echo "    edit   <filename>  Edit content of a encoded file"
  echo "    chpass <filename>  Change password an encoded file"
}

function check_file_exists() {
  if [ ! -e $1 ]; then
    echo "'$1' does not exist"
    exit 1
  fi
}

which openssl > /dev/null
if [ $? -ne 0 ]; then
    echo "$cmd requires 'openssl' command installed"
    exit 1
fi

if [ $# -eq 0 ]; then
  usage
  exit 1
fi

if [ $# -eq 1 ]; then
  case $1 in
    open)
      echo "usage: $cmd open <filename>"
      exit 1
      ;;
    lock)
      echo "usage: $cmd lock <filename>"
      exit 1
      ;;
    edit)
      echo "usage: $cmd edit <filename>"
      exit 1
      ;;
    chpass)
      echo "usage: $cmd chpass <filename>"
      exit 1
      ;;
    help)
      usage
      exit 0
      ;;
    *)
      echo "$cmd: '$1' is not a locker command. See '$cmd help'."
      exit 1
      ;;
  esac
fi

if [ $# -eq 2 ]; then
  filename=$2
  case $1 in
    open)
      check_file_exists $filename
      printf "Input password: "
      stty -echo
      read password
      stty echo
      echo
      decoded=`openssl enc -aes-256-cbc -d -base64 -in $filename -pass pass:$password 2> /dev/null`
      if [ $? -ne 0 ]; then
        echo "Incorrect password"
        exit 1
      else
        less <<_EOT_
$decoded
_EOT_
        exit 0
      fi
      ;;
    lock)
      if [ "$EDITOR" ]; then
        $EDITOR $filename
      else
        vim $filename
      fi
      printf "Input password: "
      stty -echo
      read password
      stty echo
      echo
      encoded=`openssl enc -aes-256-cbc -e -base64 -in $filename -pass pass:$password`
      if [ $? -ne 0 ]; then
        echo "Encode error"
        exit 1
      else
        printf "" > $filename
        for line in $encoded;do
          echo $line >> $filename
        done
        echo "'$filename' created."
      fi
      ;;
    edit)
      check_file_exists $filename
      printf "Input password: "
      stty -echo
      read password
      stty echo
      echo
      TMP_FILE_NAME=".locker_tmp_file"
      openssl enc -aes-256-cbc -d -base64 -in $filename -pass pass:$password > $TMP_FILE_NAME 2> /dev/null
      if [ $? -ne 0 ]; then
        echo "Incorrect password"
        exit 1
      else
        if [ "$EDITOR" ]; then
          $EDITOR $TMP_FILE_NAME
        else
          vim $TMP_FILE_NAME
        fi
        encoded=`openssl enc -aes-256-cbc -e -base64 -in $TMP_FILE_NAME -pass pass:$password`
        rm $TMP_FILE_NAME
        if [ $? -ne 0 ]; then
          echo "Encode error"
          exit 1
        else
          printf "" > $filename
          for line in $encoded;do
            echo $line >> $filename
          done
          echo "'$filename' edited."
          exit 0
        fi
      fi
      ;;
    chpass)
      check_file_exists $filename
      printf "Input password: "
      stty -echo
      read password
      stty echo
      echo
      TMP_FILE_NAME=".locker_tmp_file"
      openssl enc -aes-256-cbc -d -base64 -in $filename -pass pass:$password > $TMP_FILE_NAME 2> /dev/null
      if [ $? -ne 0 ]; then
        echo "Incorrect password"
        exit 1
      else
        printf "Input NEW password: "
        stty -echo
        read password
        stty echo
        echo
        encoded=`openssl enc -aes-256-cbc -e -base64 -in $TMP_FILE_NAME -pass pass:$password`
        rm $TMP_FILE_NAME
        if [ $? -ne 0 ]; then
          echo "Encode error"
          exit 1
        else
          printf "" > $filename
          for line in $encoded;do
            echo $line >> $filename
          done
          echo "Password updated."
        fi
        exit 0
      fi
      ;;
    help)
      usage
      exit 1
      ;;
    *)
      echo "$cmd: '$1' is not a locker command. See '$cmd help'."
      exit 1
      ;;
  esac
fi
