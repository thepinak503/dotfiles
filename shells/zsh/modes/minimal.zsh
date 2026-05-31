#!/usr/bin/env zsh
# =============================================================================
# ZSH MODE: MINIMAL
# =============================================================================
# Lightweight configuration with only essential aliases and functions.
# Ideal for servers, SSH sessions, resource-constrained environments,
# or users who prefer a clean, distraction-free shell.
# =============================================================================

# =============================================================================
# FILE LISTING — Basic
# =============================================================================

alias ls='ls --color=auto 2>/dev/null || ls -G'
alias ll='ls -lh --color=auto 2>/dev/null || ls -lhG'
alias la='ls -Ah --color=auto 2>/dev/null || ls -AhG'
alias lal='ls -Alh --color=auto 2>/dev/null || ls -AlhG'
alias lsl='ls -lh --color=auto 2>/dev/null || ls -lhG'

# =============================================================================
# DIRECTORY NAVIGATION
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dots='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" 2>/dev/null || echo "Dotfiles dir not found"'
alias back='cd -'

# =============================================================================
# TEXT EDITORS
# =============================================================================

if command -v nvim >/dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
elif command -v vim >/dev/null 2>&1; then
    alias v='vim'
    alias vi='vim'
elif command -v nano >/dev/null 2>&1; then
    alias v='nano'
    alias vi='nano'
fi

if command -v nano >/dev/null 2>&1; then
    alias nano='nano'
fi

# =============================================================================
# GIT — Essential Only
# =============================================================================

alias gst='git status'
alias gss='git status --short'
alias gpl='git pull'
alias gps='git push'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gd='git diff'
alias gl='git log --oneline -10'
alias gstash='git stash'
alias gb='git branch'

# =============================================================================
# SYSTEM — Lightweight
# =============================================================================

alias cpuinfo='lscpu 2>/dev/null || cat /proc/cpuinfo | grep "model name" | head -1 || sysctl -n machdep.cpu.brand_string'
alias meminfo='free -h 2>/dev/null || vm_stat 2>/dev/null || echo "meminfo not available"'
alias diskinfo='df -h'
alias diskusage='du -sh * 2>/dev/null'
alias psg='ps aux | grep -v grep | grep -i'
alias ports='ss -tuln 2>/dev/null || netstat -tulanp 2>/dev/null'
alias ping='ping -c 5'
alias myip='curl -s ifconfig.me 2>/dev/null || wget -qO- ifconfig.me 2>/dev/null || echo "IP lookup failed"'
alias kernel='uname -a'
alias uptime='uptime'
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
alias path='echo $PATH | tr ":" "\n" | nl'
alias h='history'
alias hg='history | grep'
alias reload='source ~/.zshrc'
alias reexec='exec zsh'
alias sysinfo='cat /etc/os-release 2>/dev/null | head -5 || sw_vers 2>/dev/null || uname -a'

# =============================================================================
# PACKAGE MANAGEMENT
# =============================================================================

alias update='bash ~/.local/share/dotfiles/bin/sysupdate.sh'
alias cleanup='bash ~/.local/share/dotfiles/bin/syscleanup.sh'

# =============================================================================
# NETWORK
# =============================================================================

alias ipa='ip -br addr 2>/dev/null || ifconfig 2>/dev/null'
alias ipr='ip route 2>/dev/null || route -n 2>/dev/null'

# =============================================================================
# CALENDAR & DATE
# =============================================================================

alias calendar='cal -3'
alias calyear='cal -y'
alias today='date "+%A, %B %d, %Y"'

# =============================================================================
# TOOL INTEGRATIONS (if available)
# =============================================================================

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# SHELL OPTIONS — Conservative
# =============================================================================

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_MENU

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

mkcd() {
    mkdir -p "$1" && cd "$1"
}

ff() {
    find . -type f -name "*$1*" 2>/dev/null
}

# Minimal extract function
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz|*.tgz)  tar xzf "$1"  ;;
            *.zip)           unzip "$1"    ;;
            *.tar)           tar xf "$1"   ;;
            *.bz2)           bunzip2 "$1"  ;;
            *)               echo "Cannot extract: $1" ;;
        esac
    fi
}
