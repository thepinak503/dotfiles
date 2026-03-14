#!/bin/bash
# Docker and Container Configuration
# Docker, Docker Compose, and Kubernetes aliases

# Only load if docker is installed
if ! command -v docker &>/dev/null; then
    return
fi

# =============================================================================
# DOCKER ALIASES
# =============================================================================

# Basic operations
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dr='docker run'
alias drm='docker rm'
alias drmi='docker rmi'

# Container management
alias dstop='docker stop $(docker ps -q)'
alias dstopa='docker stop $(docker ps -aq)'
alias drma='docker rm $(docker ps -aq)'
alias drmiu='docker rmi $(docker images -q)'
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'

# Logs and exec
alias dl='docker logs'
alias dlf='docker logs -f'
alias dex='docker exec -it'

# Compose shortcuts
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcrestart='docker-compose restart'
alias dclogs='docker-compose logs'
alias dcb='docker-compose build'
alias dcpull='docker-compose pull'

# System
alias dinfo='docker system df'
alias dinspect='docker inspect'

# =============================================================================
# DOCKER FUNCTIONS
# =============================================================================

# Docker cleanup - remove all containers, images, volumes, networks
docker-cleanup() {
    echo "Stopping all containers..."
    docker stop $(docker ps -aq) 2>/dev/null || true
    
    echo "Removing all containers..."
    docker rm $(docker ps -aq) 2>/dev/null || true
    
    echo "Removing all images..."
    docker rmi $(docker images -q) 2>/dev/null || true
    
    echo "Removing all volumes..."
    docker volume rm $(docker volume ls -q) 2>/dev/null || true
    
    echo "Pruning system..."
    docker system prune -af --volumes
    
    echo "Docker cleanup complete!"
}

# Enter container shell
docker-shell() {
    if [ -z "$1" ]; then
        echo "Usage: docker-shell <container_name>"
        return 1
    fi
    docker exec -it "$1" /bin/bash 2>/dev/null || docker exec -it "$1" /bin/sh
}

# Show container IP
docker-ip() {
    if [ -z "$1" ]; then
        docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
    else
        docker inspect -f '{{.NetworkSettings.IPAddress }}' "$1"
    fi
}

# Search for image
docker-search() {
    if [ -z "$1" ]; then
        echo "Usage: docker-search <image_name>"
        return 1
    fi
    docker search "$1" --limit=10
}

# Show container logs with tail
docker-logs() {
    if [ -z "$1" ]; then
        echo "Usage: docker-logs <container_name> [lines]"
        return 1
    fi
    local lines=${2:-100}
    docker logs --tail="$lines" -f "$1"
}

# =============================================================================
# KUBERNETES (KUBECTL)
# =============================================================================

if command -v kubectl &>/dev/null; then
    # Basic kubectl aliases
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kdel='kubectl delete'
    alias ka='kubectl apply'
    alias kaf='kubectl apply -f'
    alias kex='kubectl exec -it'
    alias klog='kubectl logs'
    alias klf='kubectl logs -f'
    
    # Resource specific
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgd='kubectl get deployments'
    alias kgn='kubectl get nodes'
    alias kgns='kubectl get namespaces'
    alias kgi='kubectl get ingress'
    alias kgcm='kubectl get configmaps'
    alias kgsec='kubectl get secrets'
    
    # Describe resources
    alias kdp='kubectl describe pod'
    alias kds='kubectl describe svc'
    alias kdd='kubectl describe deployment'
    
    # Context and namespace
    alias kctx='kubectl config current-context'
    alias kctxs='kubectl config get-contexts'
    alias kctxu='kubectl config use-context'
    alias kns='kubectl config set-context --current --namespace'
    
    # Watch resources
    alias kgpw='kubectl get pods -w'
    alias kgnw='kubectl get nodes -w'
fi

# =============================================================================
# K9S (TUI for Kubernetes)
# =============================================================================

if command -v k9s &>/dev/null; then
    alias k9='k9s'
    alias k9a='k9s --all-namespaces'
fi

# =============================================================================
# HELM
# =============================================================================

if command -v helm &>/dev/null; then
    alias h='helm'
    alias hin='helm install'
    alias hup='helm upgrade'
    alias hdel='helm delete'
    alias hls='helm list'
    alias hrepo='helm repo'
    alias hsearch='helm search'
fi

# =============================================================================
# PODMAN (Docker alternative)
# =============================================================================

if command -v podman &>/dev/null && ! command -v docker &>/dev/null; then
    alias docker='podman'
    alias docker-compose='podman-compose'
fi
