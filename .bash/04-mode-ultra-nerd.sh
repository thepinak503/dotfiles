#!/usr/bin/env bash
# =============================================================================
# ULTRA-NERD MODE - Maximum productivity
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
if command -v ranger &>/dev/null; then
    alias r='ranger'
fi

if command -v nnn &>/dev/null; then
    alias n='nnn'
fi

# Development shortcuts
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
alias upgrade='update'
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
alias bconf='$EDITOR ~/.bashrc'
alias sbrc='source ~/.bashrc'
alias reload='source ~/.bashrc'
