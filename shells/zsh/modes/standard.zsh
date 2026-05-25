#!/usr/bin/env zsh
# =============================================================================
# ZSH MODE: STANDARD
# =============================================================================
# Balanced feature set suitable for everyday use. Includes core utilities,
# git integration, and sensible defaults without excessive visual density.
# =============================================================================

# =============================================================================
# FILE LISTING — Standard Utilities
# =============================================================================

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=auto --group-directories-first 2>/dev/null || ls --color=auto'
    alias ll='eza -l --icons=auto --group-directories-first 2>/dev/null || ls -l'
    alias la='eza -a --icons=auto --group-directories-first 2>/dev/null || ls -A'
    alias lal='eza -la --icons=auto --group-directories-first 2>/dev/null || ls -la'
    alias lsl='eza -l --icons=auto --group-directories-first 2>/dev/null || ls -l'
elif command -v exa >/dev/null 2>&1; then
    alias ls='exa --icons --group-directories-first'
    alias ll='exa -l --icons --group-directories-first'
    alias la='exa -a --icons --group-directories-first'
    alias lal='exa -la --icons --group-directories-first'
fi

# =============================================================================
# DIRECTORY NAVIGATION
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias projects='cd ~/Projects'
alias dots='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"'
alias back='cd -'

# =============================================================================
# FILE MANAGERS
# =============================================================================

if command -v ranger >/dev/null 2>&1; then
    alias r='ranger'
fi

if command -v nnn >/dev/null 2>&1; then
    alias n='nnn'
fi

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
fi

if command -v nano >/dev/null 2>&1; then
    alias nano='nano'
fi

# =============================================================================
# GIT — Core Commands
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
alias ga='git add'
alias gap='git add -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --oneline --graph -20'
alias gla='git log --oneline --graph --all -20'
alias gstash='git stash'
alias gstashp='git stash pop'
alias gstd='git stash drop'
alias gb='git branch'
alias gba='git branch -a'
alias greset='git reset --hard'

# =============================================================================
# DOCKER — Basic Commands
# =============================================================================

if command -v docker >/dev/null 2>&1; then
    alias d='docker'
    alias dc='docker compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dstop='docker stop $(docker ps -q) 2>/dev/null'
    alias dprune='docker system prune -af'
    alias dtop='docker stats --no-stream'
fi

# =============================================================================
# NETWORK
# =============================================================================

alias ports='ss -tuln 2>/dev/null || netstat -tulanp'
alias ping='ping -c 5'
alias myip='curl -s ifconfig.me 2>/dev/null || curl -s icanhazip.com 2>/dev/null'
alias ipa='ip -br addr 2>/dev/null || ifconfig'

# =============================================================================
# SYSTEM
# =============================================================================

alias cpuinfo='lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string'
alias meminfo='free -h 2>/dev/null || vm_stat'
alias diskinfo='df -h'
alias psg='ps aux | grep -v grep | grep -i'
alias top='btop 2>/dev/null || htop 2>/dev/null || top'
alias update='sudo apt update && sudo apt upgrade -y 2>/dev/null || sudo dnf upgrade -y 2>/dev/null || sudo pacman -Syu 2>/dev/null || brew update && brew upgrade'
alias cleanup='sudo apt autoremove -y 2>/dev/null || sudo dnf autoremove -y 2>/dev/null || sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || brew cleanup'
alias journal='journalctl -xe --no-pager -n 50 2>/dev/null'
alias sysinfo='fastfetch 2>/dev/null || neofetch 2>/dev/null'
alias kernel='uname -a'
alias uptime='uptime'
alias calendar='cal -3'

# =============================================================================
# DATE & TIME
# =============================================================================

alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias nowdatetime='date +"%Y-%m-%d %H:%M:%S"'
alias path='echo $PATH | tr ":" "\n" | nl'

# =============================================================================
# HISTORY
# =============================================================================

alias h='history'
alias hg='history | grep'
alias h10='history 10'
alias h20='history 20'

# =============================================================================
# CONFIG RELOADING
# =============================================================================

alias szrc='source ~/.zshrc'
alias reload='source ~/.zshrc'
alias reexec='exec zsh'

# =============================================================================
# ZOXIDE (optional)
# =============================================================================

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# HISTORY SETTINGS
# =============================================================================

export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T "

# =============================================================================
# SHELL OPTIONS
# =============================================================================

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt AUTO_MENU
setopt PROMPT_SUBST

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz)  tar xzf "$1"  ;;
            *.tar.bz2) tar xjf "$1"  ;;
            *.tar.xz)  tar xJf "$1"  ;;
            *.tar)     tar xf "$1"   ;;
            *.zip)     unzip "$1"    ;;
            *.rar)     unrar x "$1"  ;;
            *.7z)      7z x "$1"    ;;
            *)         echo "Cannot extract: $1" ;;
        esac
    fi
}

ff() {
    find . -type f -name "*$1*" 2>/dev/null
}

weather() {
    curl -s "wttr.in/${1:-}" 2>/dev/null || echo "Weather unavailable"
}

genpass() {
    local len="${1:-32}"
    openssl rand -base64 48 | tr -d '+/=' | cut -c1-"$len"
}
