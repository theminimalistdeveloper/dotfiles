################################################################################
# I3
################################################################################

# GENERAL
################################################################################

# EXPORTS
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# use RG as replacement for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# VIM BINDINGS
# Enable vi mode
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

ZSH_THEME="apple"
ZSH_DISABLE_COMPFIX=true
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# aws - Autocomplete for AWS cli
# git - list of short aliases
# yarn - List of short aliases
plugins=(
  aws
  yarn
  vi-mode
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ALIASES
################################################################################

# MISC
alias c='clear'
alias e='exit'
# open a fzf search on my code directory
alias cdc='cd $(fd . ~/code -d=5 | fzf)'

# APPLICATIONS
# Neovim
alias n='nvim '
# Tmux
alias tmux='tmux -2'
# Git
alias g='git '
# EXA - replacement for ls
alias ls='exa --icons --git'

# TMUX
# Create new session
alias tn='tmux new -s '
# Kill a session
alias tk='tmux kill-session -t '
# Attach to a session
alias ta='tmux a -t '
# List available sessions
alias tl='tmux ls'

# GIT
# Status
alias gs='git status '
# Log
alias gl='git log'
# Each entry on the log on one line
alias glo='git log --oneline'
# Diff current branch
alias gd='git diff'
# Checkout
alias go='git checkout '
# Create a new branch and checkout there
alias gob='git checkout -b '
# Checkout to previous branch
alias go-='git checkout -'

# GIT - BRANCHES
# Delete a given branch
alias gbd='git branch -D '
# Show only the name of the current branch
alias gbc='git rev-parse --abbrev-ref HEAD'
# Push a new branch
alias gpnb='git push -u origin $(gbc)'
# Push
alias gpu='git push'
# Pull
alias gp='git pull'
# Rebase a given branch
alias gr="git rebase "
# Continue a rebase
alias grc="git rebase --continue"
# Abort a rebase
alias gra="git rebase --abort"
# Soft reset the last commit, the changes will be send to stage
alias grsh='git reset --soft HEAD~1'
# !AGRESSIVE DEVELOPMENT!
# Add all the changes, commit ammend with noe edit and force push - Do this at your own risk ;)
alias ga='git add . && git commit --amend --no-edit -n && git push -f'
