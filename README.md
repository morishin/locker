#locker
*locker* is a shell script to protect a text file by AES encryption.

##Install
You can install *locker* via [Homebrew](http://brew.sh/).
```Shell
brew tap morishin/morishin
brew install locker
```
##Usage
- Create a new text file and encode.
```Shell
locker lock <filename>
(Edit file...)
Input password:
'<filename>' created.
```
- Open a encoded file.
```Shell
locker open <filename>
Input password:
(Display file content)
```
- You can edit content of a encoded file.
```Shell
locker edit <filename>
Input password:
(Edit file...)
'<filename> edited.'
```
- And you can change password.
```Shell
locker chpass <filename>
Input password:
Input NEW password:
Password updated.
```
- More help information.
```Shell
locker help
```
