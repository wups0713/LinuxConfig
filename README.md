- [bash.rc](#bash-rc)
- [bash completion](#bash-completion)
- [git](#git)
- [ssh](#ssh)
- [nano](#nano)
- [tmux](#tmux)

## bash.rc<a id="bash-rc"></a>

- Customize bash prompt
- History search backward/forward

## bash completion<a id="bash-completion"></a>

- dotnet

## git<a id="git"></a>

- http.sslVerify = false
- submodule.recurse = true
- advice.detachedHead = false

## ssh<a id="ssh"></a>

Connect to remote with key pair.

1. Create key pair.

   ```shell
   $ ssh-keygen -f ~/.ssh/keys/<user>@<remote>
   ```

2. Copy public key to remote.

   ```shell
   $ ssh-copy-id -i ~/.ssh/keys/<user>@<remote>.pub <user>@<remote>
   $ rm ~/.ssh/keys/<user>@<remote>.pub
   ```

## nano<a id="nano"></a>

- tabsize = 4
- autoindent

## tmux<a id="tmux"></a>

- Mouse support
- Customize status bar
- Customize shortcut
  - Ctrl + b, r  
    Rename current window.
  - Ctrl + b, m  
    Move current window.
  - Ctrl + b, ,  
    Move to previous window.
  - Ctrl + b, .  
    Move to next window.
  - Ctrl + b, /  
    Swap windows.
  - Ctrl + b, Shift + ,  
    Swap with previous window.
  - Ctrl + b, Shift + .  
    Swap with next window.
  - Ctrl + b, [  
    Split window horizontally.
  - Ctrl + b, ]  
    Split window vertically.
  - Ctrl + b, =  
    Tiled layout.
  - Ctrl + b, -  
    Even-vertical layout.
  - Ctrl + b, \  
    Even-horizontal layout.
  - Ctrl + b, Shift + -  
    Main-vertical layout.
  - Ctrl + b, Shift + \  
    Main-horizontical layout.
  - Ctrl + b, s  
    Synchronize windows input(on/off).
  - Ctrl + b, Ctrl + c  
    Enter copy mode
  - (in copy mode) Ctrl + c  
    Copy selection and end copy mode.
  - Ctrl + v  
    Paste buffer.
- Cursor control similar to VS Code in copy mode