#locker
*locker* is a shell script to protect a text file by AES encryption.

##How to use
- Change the permissions of shell script to executable.
```Shell
chmod +x <script file path>
alias locker='<script file path>'
```
- Create a new file and encode.
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
- You can display help information.
```Shell
locker help
```