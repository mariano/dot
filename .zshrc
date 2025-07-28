export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7    # update every 7 days

COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion.

plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
#export LC_CTYPE=C 
export EDITOR='vim'

[ -f ~/.env.zsh ] && source ~/.env.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

. "$HOME/.cargo/env"

export PATH="$PATH:${HOME}/.local/bin"
