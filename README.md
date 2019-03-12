# locker
*locker* is a shell script to protect a text file by AES encryption.

## Install
You can install *locker* via [Homebrew](http://brew.sh/).
```Shell
brew tap morishin/morishin
brew install locker
```
## Usage
- Create a new text file and encode.

  ```shell
  locker lock <filename>
  (Edit file...)
  Input password:
  Input password again:
  '<filename>' created.
  ```

<img src="https://cloud.githubusercontent.com/assets/1413408/17423459/c6c48200-5af5-11e6-826e-a5ce86a87030.png" width="640"/>

- Open a encoded file.

  ```shell
  locker open <filename>
  Input password:
  (Display file content)
  ```

  <img src="https://cloud.githubusercontent.com/assets/1413408/17423475/d2607d4e-5af5-11e6-979f-b60ae10308d6.gif" width="640"/>

- You can edit content of a encoded file.

  ```shell
  locker edit <filename>
  Input password:
  (Edit file...)
  '<filename> edited.'
  ```

- And you can change password.

  ```shell
  locker chpass <filename>
  Input password:
  Input NEW password:
  Password updated.
  ```
- More help information.

  ```shell
  locker help
  ```
