#!/usr/bin/env bash
# =============================================================================
# MODE: ULTRA-NERD - Maximum productivity power user mode
# All features enabled, keyboard-driven workflow, maximum efficiency
# =============================================================================

# Note: Ultra-nerd mode includes ALL advanced mode features
# This file adds power-user specific features

# =============================================================================
# POWER USER ALIASES
# =============================================================================

# Super-quick navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -='cd -'

# Quick editor access
alias bconf='"$EDITOR" ~/.bashrc'
alias zconf='"$EDITOR" ~/.zshrc'
alias fconf='"$EDITOR" ~/.config/fish/config.fish'
alias sbrc='source ~/.bashrc'
alias reload='source ~/.bashrc'

# Process management
alias psg='ps aux | grep -v grep | grep -i'
alias killi='kill -9'

# Quick package installs (Arch)
if command -v pacman &>/dev/null; then
    alias install='sudo pacman -S'
    alias search='pacman -Ss'
    alias remove='sudo pacman -Rns'
    alias update='sudo pacman -Syu'
    alias list='pacman -Q'
fi

# Quick package installs (Debian)
if command -v apt &>/dev/null; then
    alias install='sudo apt install'
    alias search='apt search'
    alias remove='sudo apt remove'
    alias update='sudo apt update && sudo apt upgrade'
    alias list='apt list --installed'
fi

# Quick package installs (Fedora)
if command -v dnf &>/dev/null; then
    alias install='sudo dnf install'
    alias search='dnf search'
    alias remove='sudo dnf remove'
    alias update='sudo dnf upgrade'
fi

# =============================================================================
# FILE MANAGERS
# =============================================================================

# Yazi file manager with cd on exit
if command -v yazi &>/dev/null; then
    function y() {
        local tmp; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        local cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd" || return
        fi
        rm -f -- "$tmp"
    }
fi

# Ranger file manager with cd on exit
if command -v ranger &>/dev/null; then
    function ranger-cd() {
        local tempfile; tempfile="$(mktemp -t ranger-cd.XXXXXX)"
        ranger --choosedir="$tempfile" "$@"
        if [[ -f "$tempfile" ]]; then
            local dir; dir="$(<"$tempfile")"
            rm -f "$tempfile"
            if [[ -d "$dir" && "$dir" != "$PWD" ]]; then
                cd "$dir" || return
            fi
        fi
    }
    alias r=ranger-cd
fi

# nnn with cd on exit
if command -v nnn &>/dev/null; then
    function nnn-cd() {
        nnn "$@"
        if [[ -f "$NNN_FIFO" ]]; then
            cd "$(cat "$NNN_FIFO")" || return
        fi
    }
    alias n=nnn-cd
fi

# =============================================================================
# GIT POWER FEATURES
# =============================================================================

# Interactive git add
alias gap='git add -p'

# Git undo (soft reset last commit)
alias gundo='git reset --soft HEAD~1'

# Git reset to last commit
alias greset='git reset --hard HEAD'

# Git stash with message
alias gsm='git stash push -m'

# Git log with stats
alias glogstat='git log --oneline --graph --decorate --stat'

# Git branches sorted by date
alias gbsort='git branch --sort=-committerdate'

# Git quick commit and push
alias gcpush='git add -A && git commit -m'

# =============================================================================
# SYSTEM POWER FEATURES
# =============================================================================

# Force remove (use with caution!)
alias rmf='rm -rf'
alias cpf='cp -rf'
alias mvf='mv -f'

# Quick file info
alias llh='ls -lh'
alias lla='ls -la'

# Memory info
alias meminfo='free -h && echo "" && cat /proc/meminfo | head -20'

# CPU info
alias cpuinfo='lscpu'

# Disk info
alias diskinfo='lsblk && echo "" && df -h'

# Network speed test
alias netspeed='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# Quick archive
alias mkzip='zip -r'
alias mktar='tar -czvf'
alias mktxz='tar -cJvf'

# =============================================================================
# DEVELOPER POWER FEATURES
# =============================================================================

# Python virtual environment
alias venv='python3 -m venv'
alias vact='source .venv/bin/activate'
alias reqinstall='pip install -r requirements.txt'

# Node.js
alias nrd='npm run dev'
alias nrs='npm run start'
alias nrb='npm run build'

# Rust
alias crun='cargo run'
alias cbld='cargo build'
alias ctst='cargo test'
alias crel='cargo run --release'

# Go
alias gor='go run .'
alias gob='go build .'
alias got='go test ./...'

# Docker compose shortcuts
alias dcup='docker-compose up -d'
alias dcdn='docker-compose down'
alias dcrs='docker-compose restart'
alias dcls='docker-compose logs -f'

# =============================================================================
# CONVENIENCE SHORTCUTS
# =============================================================================

# Quick HTTP server on port
alias serve8000='python3 -m http.server 8000'
alias serve8080='python3 -m http.server 8080'
alias serve3000='python3 -m http.server 3000'

# Weather shortcuts
alias wtr='curl -s wttr.in'
alias wtrc='curl -s wttr.in?format=3'

# Clipboard
if command -v xclip &>/dev/null; then
    alias xcopy='xclip -selection clipboard'
    alias xpaste='xclip -selection clipboard -o'
fi

# Quick edit configs
alias editbash='"$EDITOR" ~/.bashrc'
alias editzsh='"$EDITOR" ~/.zshrc'
alias editfish='"$EDITOR" ~/.config/fish/config.fish'
alias editgit='"$EDITOR" ~/.gitconfig'
alias editstarship='"$EDITOR" ~/.config/starship.toml'

# =============================================================================
# ENABLE ALL SHELL OPTIONS
# =============================================================================

# Enable all useful shell options
shopt -s autocd 2>/dev/null
shopt -s autocd 2>/dev/null
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null
shopt -s dotglob 2>/dev/null
shopt -s cdspell 2>/dev/null
shopt -s dirspell 2>/dev/null
shopt -s checkwinsize 2>/dev/null
shopt -s histappend 2>/dev/null
shopt -s lithist 2>/dev/null
shopt -s cmdhist 2>/dev/null
shopt -s fullpath 2>/dev/null
shopt -s extglob 2>/dev/null
shopt -s globasciiranges 2>/dev/null

# Maximum history
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=erasedups:ignorespace:ignoredups
export HISTTIMEFORMAT="%F %T "
