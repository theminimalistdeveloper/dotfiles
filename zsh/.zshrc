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
alias ls='exa --icons'

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
# Remove all branches but master
alias gca='git branch | grep -v master | xargs git branch -D'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function aws-sts {
    # awscli and jq is required
    if [[ $1 ]]; then
        dst_profile=$1
        sts_profile="sts"

        arn=$(aws configure get role_arn --profile $dst_profile)
        creds_json=$(aws --output json --profile $dst_profile sts assume-role --role-arn $arn --role-session-name t1p-iam-central-sts)

        STS_AWS_ACCESS_KEY_ID=`echo ${creds_json} | jq -r '.Credentials.AccessKeyId'`
        STS_AWS_SECRET_ACCESS_KEY=`echo ${creds_json} | jq -r '.Credentials.SecretAccessKey'`
        STS_AWS_SESSION_TOKEN=`echo ${creds_json} | jq -r '.Credentials.SessionToken'`
        STS_AWS_EXPIRATION=`echo ${creds_json} | jq -r '.Credentials.Expiration'`
        echo "For Copy&Paste"
        echo ""
        echo "export AWS_ACCESS_KEY_ID=${STS_AWS_ACCESS_KEY_ID}"
        echo "export AWS_SECRET_ACCESS_KEY=${STS_AWS_SECRET_ACCESS_KEY}"
        echo "export AWS_SESSION_TOKEN=${STS_AWS_SESSION_TOKEN}"
        echo "export AWS_EXPIRATION=${STS_AWS_EXPIRATION}"
        echo "export AWS_DEFAULT_REGION=eu-west-1"

        aws configure set aws_access_key_id $STS_AWS_ACCESS_KEY_ID --profile $sts_profile
        aws configure set aws_secret_access_key $STS_AWS_SECRET_ACCESS_KEY --profile $sts_profile
        aws configure set aws_session_token $STS_AWS_SESSION_TOKEN --profile $sts_profile
        echo ""
        echo "aws profile $sts_profile is set with temporary credentials"
    else
        echo 'enter aws profile $1'
    fi
}

function load_dotenv {
    if [ ! -f .env ]
    then
        export $(cat .env | xargs)
    fi
}
