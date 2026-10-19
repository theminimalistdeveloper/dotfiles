# Aliases

# MISC
alias c='clear'
alias e='exit'

# APPLICATIONS
# Neovim
alias n='nvim '
# EZA - replacement for ls
alias l='eza'
alias la='eza -la --icons --git --sort type'
alias t='eza --tree --icons --git'
# FZF
alias f='fzf'
# DuckDuckGo
alias s='ddgr --url-handler w3m '
# LLM - AI
alias ai='llm -m default --no-stream -t persona '
alias chat='llm chat -m default -t persona'

# Tmux 
alias tn="tmux new -s "
alias tl="tmux ls"
alias tk="tmux kill-session -t "
alias ta="tmux a -t "

# Herdr
alias h='herdr'
alias hs='herdr status'
alias hss='herdr server stop'
alias hsc='herdr server reload-config'
alias hu='herdr update'
alias hw='herdr workspace'
alias hwt='herdr worktree'
alias ht='herdr tab'
alias hp='herdr pane'
alias ha='herdr agent'
alias hac='herdr agent connect'
alias hsession='herdr session'

# Opencode
alias o="opencode"
alias oj="joyia agent opencode"

# GIT
# Status & info
alias ga='git add '
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v '
alias gca='git commit -v --amend '
alias gch='git checkout '
alias gchb='git checkout -b '
alias gcl='git clone '
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gg='git log --oneline --graph --decorate --all'
alias gi='git init'
alias gl='git log --oneline --graph'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gr='git remote -v'
alias gra='git remote add '
alias grm='git rm '
alias gs='git status'
alias gsh='git show '
# Discard / reset
alias grh='git reset HEAD '
alias grhh='git reset HEAD --hard'
# Stash
alias gst='git stash'
alias gsta='git stash apply'
alias gstl='git stash list'
alias gstp='git stash pop'
# Rebase
alias grb='git rebase '
alias grbi='git rebase -i '
# Submodule
alias gsm='git submodule '
alias gsmu='git submodule update --init --recursive'
