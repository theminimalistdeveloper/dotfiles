# EXPORTS
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# use RG as replacement for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

bindkey -v
KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        (vicmd)      BULLETTRAIN_PROMPT_CHAR="N" ;;
        (main|viins) BULLETTRAIN_PROMPT_CHAR="I" ;;
        (*)          BULLETTRAIN_PROMPT_CHAR="I" ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

ZSH_THEME="spaceship"
ZSH_DISABLE_COMPFIX=true
COMPLETION_WAITING_DOTS="true"

# Which lugins would you like to load?
plugins=(vi-mode aws git tmux)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ALIASES
################################################################################

# MISC
alias c='clear'
alias e='exit'
# open a fzf search on my code directory
alias cdc='cd $(fd . ~/code -d=5 | fzf)'

alias quarter="git log --shortstat --since \"01.07.2024\" --until \"today\" | \
  grep -E \"file[s]* changed\" | \
  sed -E 's/changed, ([0-9]+) deletions/changed, 0 insertions(+), \1 deletions/g' | \
  awk '{files+=\$1; inserted+=\$4; deleted+=\$6} END {print \"files changed\", files, \"lines inserted:\", inserted, \"lines deleted:\", deleted}'"

# APPLICATIONS
# Neovim
alias n='nvim '
# EXA - replacement for ls
alias ls='exa --icons'

# tmux 
alias tn="tmux new -s "
alias tl="tmux ls"
alias tk="tmux kill-session -t "
alias ta="tmux a -t "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/dia0001r/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export AWS_PROFILE=sts
# pnpm end
