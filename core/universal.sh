#!/usr/bin/env bash
# =============================================================================
# Universal Shell Config - Distro-agnostic with OS detection
# Works with: bash, zsh, fish
# =============================================================================

export DOTFILES_OS="$(uname -s)"
export DOTFILES_ARCH="$(uname -m)"

_detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "${ID:-linux}"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-version ]; then
        echo "fedora"
    elif [ -f /etc/SuSE-release ]; then
        echo "suse"
    else
        echo "linux"
    fi
}

case "$(uname -s)" in
    Linux*)  export DOTFILES_DISTRO="$(_detect_linux_distro)" ;;
    Darwin*) export DOTFILES_DISTRO="macos" ;;
    *)     export DOTFILES_DISTRO="unknown" ;;
esac

_get_pkg_manager() {
    case "$DOTFILES_DISTRO" in
        arch|artix|manjaro|endeavouros|garuda)
            command -v yay >/dev/null 2>&1 && echo "yay" && return
            command -v pacman >/dev/null 2>&1 && echo "pacman" && return
            echo "none" ;;
        debian|ubuntu|linuxmint|pop|zorin)
            command -v apt >/dev/null 2>&1 && echo "apt" && return
            command -v apt-get >/dev/null 2>&1 && echo "apt-get" && return
            echo "none" ;;
        fedora|centos|rhel|rocky|alma)
            command -v dnf >/dev/null 2>&1 && echo "dnf" && return
            command -v yum >/dev/null 2>&1 && echo "yum" && return
            echo "none" ;;
        opensuse|sles)
            command -v zypper >/dev/null 2>&1 && echo "zypper" && return
            echo "none" ;;
        void)
            command -v xbps >/dev/null 2>&1 && echo "xbps" && return
            echo "none" ;;
        gentoo)
            command -v emerge >/dev/null 2>&1 && echo "emerge" && return
            echo "none" ;;
        alpine)
            command -v apk >/dev/null 2>&1 && echo "apk" && return
            echo "none" ;;
        nixos)
            command -v nix >/dev/null 2>&1 && echo "nix" && return
            echo "none" ;;
        macos)
            command -v brew >/dev/null 2>&1 && echo "brew" && return
            command -v port >/dev/null 2>&1 && echo "port" && return
            echo "none" ;;
        *)
            echo "none" ;;
    esac
}

export DOTFILES_PKG_MANAGER="$(_get_pkg_manager)"

_get_init_system() {
    if [ -d /run/systemd/system ]; then
        echo "systemd"
    elif [ -f /proc/1/comm ]; then
        cat /proc/1/comm 2>/dev/null
    else
        echo "unknown"
    fi
}
export DOTFILES_INIT="$(_get_init_system)"

# =============================================================================
# Distro-specific Aliases
# =============================================================================

_is_arch()    { [ "$DOTFILES_DISTRO" = "arch" ] || [ "$DOTFILES_DISTRO" = "artix" ] || [ "$DOTFILES_DISTRO" = "manjaro" ] || [ "$DOTFILES_DISTRO" = "endeavouros" ] || [ "$DOTFILES_DISTRO" = "garuda" ]; }
_is_debian()  { [ "$DOTFILES_DISTRO" = "debian" ] || [ "$DOTFILES_DISTRO" = "ubuntu" ] || [ "$DOTFILES_DISTRO" = "linuxmint" ] || [ "$DOTFILES_DISTRO" = "pop" ]; }
_is_fedora()  { [ "$DOTFILES_DISTRO" = "fedora" ] || [ "$DOTFILES_DISTRO" = "centos" ] || [ "$DOTFILES_DISTRO" = "rhel" ] || [ "$DOTFILES_DISTRO" = "rocky" ] || [ "$DOTFILES_DISTRO" = "alma" ]; }
_is_macos()   { [ "$DOTFILES_DISTRO" = "macos" ]; }
_is_void()    { [ "$DOTFILES_DISTRO" = "void" ]; }
_is_alpine()   { [ "$DOTFILES_DISTRO" = "alpine" ]; }
_is_gentoo()  { [ "$DOTFILES_DISTRO" = "gentoo" ]; }

# System update - works on any distro
_update_sys() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman)      sudo pacman -Syu ;;
        apt)           sudo apt update && sudo apt upgrade ;;
        dnf)           sudo dnf upgrade ;;
        brew)          brew update && brew upgrade ;;
        apk)           apk update && apk upgrade ;;
        zypper)        sudo zypper update ;;
        xbps)          sudo xbps-install -S ;;
        emerge)        sudo emerge -DuDaN world ;;
        nix)          nix-env -uall ;;
        *)            echo "No supported package manager found" ;;
    esac
}
alias update='_update_sys'

# Install packages - works on any distro
_install_pkg() {
    case "$DOTFILES_PKG_MANAGER" in
        yay)          yay -S "$@" ;;
        pacman)       sudo pacman -S "$@" ;;
        apt)         sudo apt install "$@" ;;
        apt-get)      sudo apt-get install "$@" ;;
        dnf)         sudo dnf install "$@" ;;
        brew)        brew install "$@" ;;
        apk)         apk add "$@" ;;
        zypper)      sudo zypper install "$@" ;;
        xbps)        sudo xbps-install -S "$@" ;;
        emerge)      sudo emerge "$@" ;;
        nix)         nix-env -i "$@" ;;
        port)        sudo port install "$@" ;;
        *)          echo "No supported package manager found" ;;
    esac
}
alias ins='_install_pkg'

# Remove packages
_remove_pkg() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman)      sudo pacman -Rns "$@" ;;
        apt)            sudo apt remove "$@" ;;
        apt-get)       sudo apt-get remove "$@" ;;
        dnf)           sudo dnf remove "$@" ;;
        brew)          brew remove "$@" ;;
        apk)           apk del "$@" ;;
        zypper)        sudo zypper remove "$@" ;;
        xbps)          sudo xbps-remove -R "$@" ;;
        emerge)       sudo emerge -C "$@" ;;
        port)         sudo port uninstall "$@" ;;
        *)            echo "No supported package manager found" ;;
    esac
}
alias rem='_remove_pkg'

# Search packages
_search_pkg() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman)      yay -Ss "$@" || pacman -Ss "$@" ;;
        apt)            apt search "$@" ;;
        apt-get)       apt-cache search "$@" ;;
        dnf)            dnf search "$@" ;;
        brew)           brew search "$@" ;;
        apk)            apk search "$@" ;;
        zypper)         zypper search "$@" ;;
        xbps)           xbps-query -Rs "$@" ;;
        port)          port search "$@" ;;
        *)             echo "No supported package manager found" ;;
    esac
}
alias se='_search_pkg'

# List installed packages
_list_pkgs() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman)      pacman -Qq ;;
        apt)            dpkg -l | tail -n +3 ;;
        dnf)            dnf list installed ;;
        brew)           brew list ;;
        apk)            apk list ;;
        zypper)         rpm -qa ;;
        xbps)           xbps-query -l ;;
        port)           port installed ;;
        *)             echo "No supported package manager found" ;;
    esac
}
alias lsp='_list_pkgs'

# Systemctl wrapper (Linux only)
if [ "$DOTFILES_INIT" = "systemd" ]; then
    alias sc='systemctl'
    alias scs='systemctl status'
    alias scst='systemctl start'
    alias scsp='systemctl stop'
    alias scsr='systemctl restart'
    alias scse='systemctl enable'
    alias scsd='systemctl disable'
    alias scu='systemctl --user'
fi

# Service manager (sysvinit)
if [ "$DOTFILES_INIT" = "sysv" ]; then
    alias sv='service'
fi

# Journalctl wrapper (systemd)
if [ "$DOTFILES_INIT" = "systemd" ]; then
    alias jc='journalctl'
    alias jce='journalctl -e'
    alias jcf='journalctl -f'
    alias jcu='journalctl -u'
fi

# Neofetch - cross-distro
alias neo='neofetch'
alias fetch='fastfetch -c ~/.config/fastfetch/config.jsonc'

# Quick sysinfo
alias sysinfo='echo "OS: $DOTFILES_DISTRO" && echo "Kernel: $(uname -r)" && echo "Shell: $SHELL" && echo "Pkg Manager: $DOTFILES_PKG_MANAGER" && echo "Init: $DOTFILES_INIT"'

# Clear cache
alias cleancache='rm -rf ~/.cache/*'
alias cleanpkg='rm -rf /var/cache/*'

# =============================================================================
# Universal Functions
# =============================================================================

mkcd() { mkdir -p "$1" && cd "$1"; }
take() { mkdir -p "$1" && cd "$1"; }

extract() {
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) printf 'unknown archive: %s\n' "$1" >&2; return 1 ;;
    esac
}

# Backup file
backup() { cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)"; }

# Weather
weather() { curl -fsSL "wttr.in/${1:-}" ; }

# My IP
myip() { curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null ; }

# Process killer
pkillf() { pkill -f "$1" || killall "$1" 2>/dev/null ; }

# Port check
portcheck() { netstat -tulanp 2>/dev/null | grep "$1" || ss -tulanp | grep "$1" ; }

# Docker shortcuts
if command -v docker >/dev/null 2>&1; then
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlogs='docker logs -f'
    alias dstop='docker stop $(docker ps -q)'
    alias drm='docker rm $(docker ps -aq)'
    alias dprune='docker system prune -af'
    alias dclean='docker system prune -af --volumes'
fi

# K8s shortcuts
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgd='kubectl get deployments'
    alias kga='kubectl get all'
    alias kctx='kubectl config current-context'
    alias kuse='kubectl config use-context'
fi

# Tmux shortcuts
if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
    alias tn='tmux new-session -s'
fi

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gd='git diff'
alias gco='git checkout'
alias gsw='git switch'
alias gst='git stash'
alias gsp='git stash pop'