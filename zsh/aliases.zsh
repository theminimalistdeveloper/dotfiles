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
alias ls='eza --icons'

# tmux 
alias tn="tmux new -s "
alias tl="tmux ls"
alias tk="tmux kill-session -t "
alias ta="tmux a -t "
