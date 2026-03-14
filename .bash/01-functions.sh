#!/usr/bin/env bash
# =============================================================================
# ESSENTIAL FUNCTIONS
# =============================================================================

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.zip)       unzip "$1"     ;;
            *.tar.xz)    tar xf "$1"    ;;
            *)           echo "Unknown: $1" ;;
        esac
    else
        echo "Not a file: $1"
    fi
}

# Make dir and cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find file
findfile() {
    if command -v fd &>/dev/null; then
        fd "$1" "${2:-.}"
    else
        find "${2:-.}" -type f -iname "*$1*" 2>/dev/null
    fi
}

# Weather
weather() {
    curl -s "wttr.in/${1:-}"
}

# Docker cleanup
docker-clean() {
    docker system prune -af
    docker volume prune -f
}

# Git cleanup
git-clean() {
    git fetch -p
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d
}
