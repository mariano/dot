Developer friendly configuration files. Assumes [oh my zsh](https://ohmyz.sh/) is installed.

## iterm2

Import the keymaps found in [iterm2.itermkeymap](iterm2.itermkeymap) for better navigation.

Also make sure [shell integration is enabled](https://iterm2.com/documentation-shell-integration.html) with:

```bash
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
```

Make sure you have a nerd font installed:

```bash
brew tap homebrew/cask-fonts && brew install --cask font-space-mono-nerd-font
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

![image](https://github.com/mariano/dot/assets/18598/6b8ffdbe-8d23-4a61-813c-ff6d43befef6)
*vim on a vim tab (one of many), while also showing the file explorer (nerdtree), highlighted lines, splits and the cheatsheet (F1)*
