#!/usr/bin/env zsh
# =============================================================================
# SUPREME MODE - Full-featured configuration (Zsh)
# =============================================================================

# Docker
if command -v docker >/dev/null 2>&1; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dstop='docker stop $(docker ps -q)'
    alias drm='docker rm $(docker ps -aq)'
    alias dprune='docker system prune -af'
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

# FZF
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

# Network
alias ports='netstat -tulanp'
alias ipl='ip -br link'
alias ipa='ip -br addr'

# System
alias cpuinfo='lscpu'
alias meminfo='free -h && cat /proc/meminfo'

# Git
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstd='git stash drop'

# Tools
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    if [[ "$(uname)" == "Darwin" ]]; then
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    fi
    eval "$(starship init zsh)"
fi

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Enhanced history
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST

# Shell options
setopt AUTO_CD
setopt GLOB_COMPLETE
setopt GLOB_DOTS
setopt HASH_LISTALL
setopt HIST_VERIFY

# Dotfiles sync
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