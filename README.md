Developer friendly configuration files. Assumes [oh my zsh](https://ohmyz.sh/) is installed.

## iterm2

Import the keymaps found in [iterm2.itermkeymap](iterm2.itermkeymap) for better navigation.

Also make sure [shell integration is enabled](https://iterm2.com/documentation-shell-integration.html) with:

```bash
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
```

## tmux

Use the [.tmux.conf](.tmux.conf) configuration file. Main shortcuts:

* ⌥ ⌘ ↑: move up
* ⌥ ⌘ ↓: move down
* ⌥ ⌘ ←: move left
* ⌥ ⌘ →: move right
* ^ ⌘ ↑: increase size up
* ^ ⌘ ↓: increase size down
* ^ ⌘ ←: increase size left
* ^ ⌘ →: increase size right
* ⌘ z: toggle zoom
* ⌘ |: split horizontally
* ⌘ =: split vertically

## VIM

[Plugged](https://github.com/junegunn/vim-plug) is used as the plugin manager.
If it's your first time using the [.vimrc](.vimrc) file make sure to run `PlugInstall`
on your vim command line.

![image](https://user-images.githubusercontent.com/18598/223804169-de1f44cf-b706-4461-8f1e-1f477c051fc3.png)
*tmux and vim, with vim showing omnisharp's peek definition (F5) on a vim tab (one of many), while also showing the file explorer (nerdtree) and the cheatsheet (F1)*
