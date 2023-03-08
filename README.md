Developer friendly configuration files. Assumes [oh my zsh](https://ohmyz.sh/) is installed.

## tmux

Use the [.tmux.conf](.tmux.conf) configuration file. If using iterm2, Import the keymaps found 
in [iterm2.itermkeymap](iterm2.itermkeymap) for better navigation:

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

![image](https://user-images.githubusercontent.com/18598/223745905-5829cd6f-20bb-4079-a81b-9e440720a058.png)
*VIM showing omnisharp's peek definition (F5) on a vim tab (one of many), while also showing the cheatsheet (F1)*
