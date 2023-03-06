export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7    # update every 7 days

COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion.

plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="/Users/mariano/Code/tactic/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH";

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
