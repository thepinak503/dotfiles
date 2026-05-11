#!/usr/bin/env zsh
# =============================================================================
# ULTIMATE MODE - v1.0 - All features always enabled
# =============================================================================

# =============================================================================
# NAVIGATION ALIASES (from ultra-nerd)
# =============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'

# =============================================================================
# FILE MANAGERS (from ultra-nerd)
# =============================================================================
if command -v ranger >/dev/null 2>&1; then
    alias r='ranger'
fi

if command -v nnn >/dev/null 2>&1; then
    alias n='nnn'
fi

# =============================================================================
# DEVELOPMENT SHORTCUTS (from ultra-nerd)
# =============================================================================
alias v='vim'
alias sv='sudo vim'

# =============================================================================
# GIT SHORTCUTS (merged from standard, supreme, ultra-nerd)
# =============================================================================
alias gst='git status'
alias gpl='git pull'
alias gps='git push'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gstash='git stash'
alias gstd='git stash drop'

# =============================================================================
# DOCKER SHORTCUTS (merged from supreme, ultra-nerd)
# =============================================================================
if command -v docker >/dev/null 2>&1; then
    alias d='docker'
    alias dc='docker compose'
    alias docker-compose='docker compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dstop='docker stop $(docker ps -q)'
    alias drm='docker rm $(docker ps -aq)'
    alias dprune='docker system prune -af'
fi

# =============================================================================
# KUBERNETES (from supreme)
# =============================================================================
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi

# =============================================================================
# TMUX (from supreme)
# =============================================================================
if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
fi

# =============================================================================
# FZF (from supreme)
# =============================================================================
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

# =============================================================================
# NETWORK ALIASES (merged from standard, supreme)
# =============================================================================
alias ports='netstat -tulanp 2>/dev/null || ss -tuln'
alias ipl='ip -br link 2>/dev/null || ifconfig 2>/dev/null'
alias ipa='ip -br addr 2>/dev/null || ifconfig 2>/dev/null'

alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'

# =============================================================================
# SYSTEM ALIASES (merged from all)
# =============================================================================
alias cpuinfo='lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string 2>/dev/null'
alias meminfo='free -h 2>/dev/null || vm_stat 2>/dev/null'

alias psg='ps aux | grep -v grep | grep -i'

alias update='sudo apt update && sudo apt upgrade -y 2>/dev/null || sudo dnf upgrade -y 2>/dev/null || sudo pacman -Syu 2>/dev/null || brew update && brew upgrade 2>/dev/null'
alias cleanup='sudo apt autoremove -y 2>/dev/null || sudo dnf autoremove -y 2>/dev/null || sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || brew cleanup 2>/dev/null'

# =============================================================================
# TOOL ALIASES (merged from all)
# =============================================================================
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias path='echo $PATH | tr ":" "\n" | nl'

# =============================================================================
# HISTORY ALIASES (from ultra-nerd)
# =============================================================================
alias h='history'
alias hg='history | grep'

# =============================================================================
# QUICK EDIT / RELOAD (from ultra-nerd)
# =============================================================================
alias bconf='$EDITOR ~/.zshrc'
alias szrc='source ~/.zshrc'
alias reload='source ~/.zshrc'

# =============================================================================
# STARSHIP PROMPT (from supreme - with cross-platform support)
# =============================================================================
if command -v starship >/dev/null 2>&1; then
    if [[ "$(uname)" == "Darwin" ]]; then
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    fi
fi

# =============================================================================
# ZOXIDE (from standard, supreme)
# =============================================================================
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# ENHANCED HISTORY (MAX from ultra-nerd - HISTSIZE=100000, HISTTIMEFORMAT)
# =============================================================================
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T "

# =============================================================================
# ALL SHELL OPTIONS (merged from all modes)
# =============================================================================
setopt AUTO_CD
setopt CD_SILENT
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt GLOB_COMPLETE
setopt GLOB_DOTS
setopt HASH_LISTALL
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# =============================================================================
# DOTFILES SYNC FUNCTION (from supreme)
# =============================================================================
dot_sync() {
  local repo_root="${DOTFILES_DIR:-$HOME/.dotfiles}"
  if [[ -z "$repo_root" || ! -d "$repo_root/.git" ]]; then
    echo "Dotfiles repo not found."
    return 1
  fi
  echo "Syncing dotfiles in $repo_root..."
  git -C "$repo_root" fetch --all --prune
  git -C "$repo_root" pull --rebase --autostash || git -C "$repo_root" pull --ff-only
}
alias dsync='dot_sync'
