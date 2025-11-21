# EXPORTS
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# VARIABLES
ZSH_THEME="spaceship"
ZSH_DISABLE_COMPFIX=true
COMPLETION_WAITING_DOTS="true"

# CONFIGURATIONS
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

plugins=(aws git tmux)

# LOADING
source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/nvm.zsh

bindkey -v
