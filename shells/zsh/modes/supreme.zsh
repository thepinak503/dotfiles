#!/usr/bin/env zsh
[[ "$DOTFILES_MODE" != "advanced" && "$DOTFILES_MODE" != "ultra-nerd" ]] && return 0
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
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi
if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
fi
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi
alias ports='netstat -tulanp'
alias ipl='ip -br link'
alias ipa='ip -br addr'
alias cpuinfo='lscpu'
alias meminfo='free -h && cat /proc/meminfo'
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstd='git stash drop'
alias dprune='docker system prune -af'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias path='echo $PATH | tr ":" "\n" | nl'
