#!/usr/bin/env zsh
# =============================================================================
# ULTRA-NERD MODE - Maximum productivity (Zsh)
# =============================================================================

# Short aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Quick navigation
alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'

# File managers
if command -v ranger >/dev/null 2>&1; then
    alias r='ranger'
fi

if command -v nnn >/dev/null 2>&1; then
    alias n='nnn'
fi

# Development
alias v='vim'
alias sv='sudo vim'

# Git shortcuts
alias gst='git status'
alias gpl='git pull'
alias gps='git push'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit'
alias gcm='git commit -m'

# Docker shortcuts
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'

# System shortcuts
alias update='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y'

# Network
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'

# Process
alias psg='ps aux | grep -v grep | grep -i'

# History
alias h='history'
alias hg='history | grep'

# Quick edit
alias bconf='$EDITOR ~/.zshrc'
alias szrc='source ~/.zshrc'
alias reload='source ~/.zshrc'

# All shell options
setopt AUTO_CD
setopt GLOB_COMPLETE
setopt GLOB_DOTS
setopt HASH_LISTALL
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

export HISTSIZE=100000
export SAVEHIST=100000
export HISTTIMEFORMAT="%F %T "