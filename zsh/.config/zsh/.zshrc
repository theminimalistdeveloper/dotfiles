# ~/.config/zsh/.zshrc
export PATH=$HOME/bin:/usr/local/bin:$PATH
source $ZDOTDIR/api-keys.zsh

# Settings
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

export EDITOR='nvim'
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

bindkey -v

## History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Applications
source $ZDOTDIR/nvm.zsh
source $ZDOTDIR/zoxide.zsh
source $ZDOTDIR/starship.zsh
source <(fzf --zsh)

# Plugins
plugins=(aws git tmux)

# Themes
source $ZDOTDIR/theme.zsh
source $ZDOTDIR/aliases.zsh

