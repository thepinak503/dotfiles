#!/usr/bin/env zsh
# =============================================================================
# ADVANCED MODE - Full features
# =============================================================================

# Only load if mode is advanced or ultra-nerd
[[ "$DOTFILES_MODE" != "advanced" && "$DOTFILES_MODE" != "ultra-nerd" ]] && return 0

# -----------------------------------------------------------------------------
# DEVELOPMENT
# -----------------------------------------------------------------------------

# Docker (additional)
if command -v docker >/dev/null 2>&1; then
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
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi

# Tmux
if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
fi

# -----------------------------------------------------------------------------
# MODERN TOOLS (already loaded in prompt, but ensure they're active)
# -----------------------------------------------------------------------------

# Starship prompt (already loaded in 03-prompt.zsh)
# Zoxide (already loaded in 03-prompt.zsh)

# FZF
if command -v fzf >/dev/null 2>&1; then
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
