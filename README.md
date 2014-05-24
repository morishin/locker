#locker
*locker* is a shell script to protect a text file by AES encryption.

##How to use
Change the permissions of shell script to executable.
```Shell
chmod +x locker.sh
```
Create a new file and encrypt.
```Shell
locker.sh lock <filename>
(Edit file...)
Input password:
'<filename>' created.
```
Open a encrypted file.
```Shell
locker.sh open <filename>
Input password:
(Display file content)
```
You can change password after created.
```Shell
locker.sh chpass <filename>
Input password:
Input NEW password:
Password updated.
```
You can display help information.
```Shell
locker.sh help
```