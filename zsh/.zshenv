 # ~/.config/zsh/.zshenv

# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

export GPG_TTY=$(tty)

export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"
