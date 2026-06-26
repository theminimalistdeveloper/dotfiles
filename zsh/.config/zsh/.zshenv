 # ~/.config/zsh/.zshenv
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR="nvim"
export VISUAL="nvim"

export GPG_TTY=$(tty)

export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# Personal binaries/scripts
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
