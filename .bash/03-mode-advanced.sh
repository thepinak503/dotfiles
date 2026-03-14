#!/usr/bin/env bash
# =============================================================================
# ADVANCED MODE - Full features
# =============================================================================

# -----------------------------------------------------------------------------
# DEVELOPMENT
# -----------------------------------------------------------------------------

# Docker
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dstop='docker stop $(docker ps -aq)'
    alias drm='docker rm $(docker ps -aq)'
fi

# Kubernetes
if command -v kubectl &>/dev/null; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi

# Tmux
if command -v tmux &>/dev/null; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
fi

# -----------------------------------------------------------------------------
# MODERN TOOLS
# -----------------------------------------------------------------------------

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# FZF
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

# -----------------------------------------------------------------------------
# ADDITIONAL ALIASES
# -----------------------------------------------------------------------------

# Network
alias ports='netstat -tulanp'
alias ipl='ip -br link'
alias ipa='ip -br addr'

# System
alias cpuinfo='lscpu'
alias meminfo='free -h && cat /proc/meminfo'

# Git (additional)
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstd='git stash drop'

# Docker (additional)
alias dprune='docker system prune -af'

# Tools
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias path='echo $PATH | tr ":" "\n" | nl'
