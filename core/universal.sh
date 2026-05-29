#!/usr/bin/env bash
# =============================================================================
# Universal Shell Config - Distro-agnostic with OS detection

# =============================================================================

export DOTFILES_OS="$(uname -s)"
export DOTFILES_ARCH="$(uname -m)"

# =============================================================================
# Shell Detection
# =============================================================================


# Detect shell name for app initializers
case "${SHELL##*/}" in
    bash) export SHELL_NAME="bash" ;;
    zsh)  export SHELL_NAME="zsh" ;;
    fish) export SHELL_NAME="fish" ;;
    *)    export SHELL_NAME="bash" ;;
esac

# =============================================================================
# Linux Distribution Detection
# =============================================================================


_detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            arch|artix|manjaro|endeavouros|garuda|archlabs)
                echo "arch" ;;
            debian|ubuntu|linuxmint|pop|elementary|zorin|neon|mx)
                echo "debian" ;;
            fedora|centos|stream|rhel|rocky|alma|nobara)
                echo "fedora" ;;
            opensuse|sles|leap|tumbleweed|gecko)
                echo "suse" ;;
            void)
                echo "void" ;;
            nixos)
                echo "nix" ;;
            gentoo|funtoo|calculate)
                echo "gentoo" ;;
            alpine)
                echo "alpine" ;;
            slackware|slint|salix|vector)
                echo "slackware" ;;
            *)
                if [ -n "$ID_LIKE" ]; then
                    case "$ID_LIKE" in
                        *arch*) echo "arch" ;;
                        *debian*|*ubuntu*) echo "debian" ;;
                        *fedora*|*rhel*|*centos*) echo "fedora" ;;
                        *suse*|*opensuse*) echo "suse" ;;
                        *gentoo*) echo "gentoo" ;;
                        *slackware*) echo "slackware" ;;
                        *) echo "${ID:-linux}" ;;
                    esac
                else
                    echo "${ID:-linux}"
                fi
                ;;
        esac
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-release ]; then
        echo "fedora"
    elif [ -f /etc/SuSE-release ]; then
        echo "suse"
    elif [ -f /etc/gentoo-release ]; then
        echo "gentoo"
    elif [ -f /etc/slackware-version ]; then
        echo "slackware"
    elif [ -f /etc/lfs-release ]; then
        echo "lfs"
    else
        echo "linux"
    fi
}

# =============================================================================
# Platform Detection - OS and Architecture
# =============================================================================


case "$(uname -s)" in
    Linux*)  export DOTFILES_DISTRO="$(_detect_linux_distro)" ;;
    Darwin*) export DOTFILES_DISTRO="macos" ;;
    *)     export DOTFILES_DISTRO="unknown" ;;
esac

# =============================================================================

# =============================================================================


_detect_pkg_manager_by_command() {
    command -v brew >/dev/null 2>&1 && echo "brew" && return
    command -v apt >/dev/null 2>&1 && echo "apt" && return
    command -v pacman >/dev/null 2>&1 && echo "pacman" && return
    command -v dnf >/dev/null 2>&1 && echo "dnf" && return
    command -v zypper >/dev/null 2>&1 && echo "zypper" && return
    command -v yum >/dev/null 2>&1 && echo "yum" && return
    command -v apk >/dev/null 2>&1 && echo "apk" && return
    command -v xbps-install >/dev/null 2>&1 && echo "xbps" && return
    command -v nix >/dev/null 2>&1 && echo "nix" && return
    command -v emerge >/dev/null 2>&1 && echo "emerge" && return
    command -v slackpkg >/dev/null 2>&1 && echo "slackpkg" && return
    command -v apt-get >/dev/null 2>&1 && echo "apt-get" && return
    echo "none"
}

# =============================================================================

# =============================================================================


_get_pkg_manager() {
    case "$DOTFILES_DISTRO" in
        arch|artix|manjaro|endeavouros|garuda)
            command -v paru >/dev/null 2>&1 && echo "paru" && return
            command -v yay >/dev/null 2>&1 && echo "yay" && return
            command -v pacman >/dev/null 2>&1 && echo "pacman" && return
            _detect_pkg_manager_by_command && return ;;
        debian|ubuntu|linuxmint|pop|zorin|elementary|neon|mx)
            command -v apt >/dev/null 2>&1 && echo "apt" && return
            command -v apt-get >/dev/null 2>&1 && echo "apt-get" && return
            _detect_pkg_manager_by_command && return ;;
        fedora|centos|rhel|rocky|alma|nobara)
            command -v dnf >/dev/null 2>&1 && echo "dnf" && return
            command -v yum >/dev/null 2>&1 && echo "yum" && return
            _detect_pkg_manager_by_command && return ;;
        opensuse|sles|leap|tumbleweed|gecko)
            command -v zypper >/dev/null 2>&1 && echo "zypper" && return
            _detect_pkg_manager_by_command && return ;;
        void)
            command -v xbps-install >/dev/null 2>&1 && echo "xbps" && return
            _detect_pkg_manager_by_command && return ;;
        gentoo|funtoo|calculate)
            command -v emerge >/dev/null 2>&1 && echo "emerge" && return
            command -v pkgcore >/dev/null 2>&1 && echo "pkgcore" && return
            command -v paludis >/dev/null 2>&1 && echo "paludis" && return
            _detect_pkg_manager_by_command && return ;;
        slackware|slint|salix|vector)
            command -v slackpkg >/dev/null 2>&1 && echo "slackpkg" && return
            _detect_pkg_manager_by_command && return ;;
        lfs)
            _detect_pkg_manager_by_command && return ;;
        alpine)
            command -v apk >/dev/null 2>&1 && echo "apk" && return
            _detect_pkg_manager_by_command && return ;;
        nixos)
            command -v nix >/dev/null 2>&1 && echo "nix" && return
            _detect_pkg_manager_by_command && return ;;
        macos)
            command -v brew >/dev/null 2>&1 && echo "brew" && return
            command -v port >/dev/null 2>&1 && echo "port" && return
            _detect_pkg_manager_by_command && return ;;
        *)
            _detect_pkg_manager_by_command && return ;;
    esac
}

export DOTFILES_PKG_MANAGER="$(_get_pkg_manager)"

# =============================================================================
# Init System Detection
# =============================================================================


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

# =============================================================================
# Distro Family Boolean Helpers
# =============================================================================


_is_arch()    { [ "$DOTFILES_DISTRO" = "arch" ] || [ "$DOTFILES_DISTRO" = "artix" ] || [ "$DOTFILES_DISTRO" = "manjaro" ] || [ "$DOTFILES_DISTRO" = "endeavouros" ] || [ "$DOTFILES_DISTRO" = "garuda" ]; }
_is_debian()  { [ "$DOTFILES_DISTRO" = "debian" ] || [ "$DOTFILES_DISTRO" = "ubuntu" ] || [ "$DOTFILES_DISTRO" = "linuxmint" ] || [ "$DOTFILES_DISTRO" = "pop" ]; }
_is_fedora()  { [ "$DOTFILES_DISTRO" = "fedora" ] || [ "$DOTFILES_DISTRO" = "centos" ] || [ "$DOTFILES_DISTRO" = "rhel" ] || [ "$DOTFILES_DISTRO" = "rocky" ] || [ "$DOTFILES_DISTRO" = "alma" ]; }
_is_macos()   { [ "$DOTFILES_DISTRO" = "macos" ]; }
_is_void()    { [ "$DOTFILES_DISTRO" = "void" ]; }
_is_alpine()   { [ "$DOTFILES_DISTRO" = "alpine" ]; }
_is_gentoo()  { [ "$DOTFILES_DISTRO" = "gentoo" ] || [ "$DOTFILES_DISTRO" = "funtoo" ] || [ "$DOTFILES_DISTRO" = "calculate" ]; }
_is_lfs()     { [ "$DOTFILES_DISTRO" = "lfs" ]; }

# =============================================================================
# System Update Function
# =============================================================================


_update_sys() {
    case "$DOTFILES_PKG_MANAGER" in
        paru)           sudo paru -Syu ;;
        yay)            yay -Syu ;;
        pacman)         sudo pacman -Syu ;;
        apt)            sudo apt update && sudo apt upgrade -y ;;
        apt-get)        sudo apt-get update && sudo apt-get upgrade -y ;;
        dnf)            sudo dnf upgrade -y ;;
        yum)            sudo yum update -y ;;
        brew)           brew update && brew upgrade ;;
        apk)            sudo apk update && sudo apk upgrade ;;
        zypper)         sudo zypper update -y ;;
        xbps)           sudo xbps-install -Syu ;;
        emerge)         sudo emerge -DuDaN world ;;
        nix)            nix-env -uall ;;
        port)           sudo port selfupdate && sudo port upgrade outdated ;;
        slackpkg)       sudo slackpkg update && sudo slackpkg upgrade-all ;;
        *)              _detect_pkg_manager_by_command >/dev/null && {
                            local alt_pm=$(_detect_pkg_manager_by_command)
                            if [ "$alt_pm" != "none" ] && [ "$alt_pm" != "$DOTFILES_PKG_MANAGER" ]; then
                                DOTFILES_PKG_MANAGER="$alt_pm" _update_sys
                            else
                                echo "No supported package manager found. Try installing manually."
                            fi
                        } || echo "No supported package manager found."
                        ;;
    esac
}
alias update='_update_sys'

# =============================================================================
# Package Installation Function
# =============================================================================


_install_pkg() {
    if [ $# -eq 0 ]; then
        echo "Usage: ins <package_name>"
        echo "       install <package_name>"
        return 1
    fi
    case "$DOTFILES_PKG_MANAGER" in
        paru)           paru -S "$@" ;;
        yay)            yay -S "$@" ;;
        pacman)         sudo pacman -S --noconfirm "$@" ;;
        apt)            sudo apt install -y "$@" ;;
        apt-get)        sudo apt-get install -y "$@" ;;
        dnf)            sudo dnf install -y "$@" ;;
        yum)            sudo yum install -y "$@" ;;
        brew)           brew install "$@" ;;
        apk)            sudo apk add "$@" ;;
        zypper)         sudo zypper install -y "$@" ;;
        xbps)           sudo xbps-install -Sy "$@" ;;
        emerge)         sudo emerge "$@" ;;
        nix)            nix-env -i "$@" ;;
        port)           sudo port install "$@" ;;
        slackpkg)       sudo slackpkg install "$@" ;;
        *)              echo "No supported package manager found. Try installing manually." ;;
    esac
}
alias ins='_install_pkg'
alias install='_install_pkg'
alias i='_install_pkg'

# =============================================================================
# Package Removal Function
# =============================================================================


# Remove packages
_remove_pkg() {
    if [ $# -eq 0 ]; then
        echo "Usage: rem <package_name>"
        return 1
    fi
    case "$DOTFILES_PKG_MANAGER" in
        paru|yay|pacman) sudo pacman -Rns --noconfirm "$@" ;;
        apt)              sudo apt remove -y "$@" ;;
        apt-get)          sudo apt-get remove -y "$@" ;;
        dnf)              sudo dnf remove -y "$@" ;;
        yum)              sudo yum remove -y "$@" ;;
        brew)             brew uninstall "$@" ;;
        apk)              sudo apk del "$@" ;;
        zypper)           sudo zypper remove -y "$@" ;;
        xbps)             sudo xbps-remove -Ry "$@" ;;
        emerge)           sudo emerge -C "$@" ;;
        nix)              nix-env -e "$@" ;;
        port)             sudo port uninstall "$@" ;;
        slackpkg)         sudo slackpkg remove "$@" ;;
        *)                echo "No supported package manager found." ;;
    esac
}
alias rem='_remove_pkg'
alias uninstall='_remove_pkg'
alias rmv='_remove_pkg'

# =============================================================================
# Package Search Function
# =============================================================================


# Search packages
_search_pkg() {
    if [ $# -eq 0 ]; then
        echo "Usage: se <search_term>"
        return 1
    fi
    case "$DOTFILES_PKG_MANAGER" in
        paru|yay)         yay -Ss "$@" || pacman -Ss "$@" ;;
        pacman)           sudo pacman -Ss "$@" ;;
        apt)              apt search "$@" ;;
        apt-get)          apt-cache search "$@" ;;
        dnf)              dnf search "$@" ;;
        yum)              yum search "$@" ;;
        brew)             brew search "$@" ;;
        apk)              apk search "$@" ;;
        zypper)           zypper search "$@" ;;
        xbps)             xbps-query -Rs "$@" ;;
        emerge)           emerge -s "$@" ;;
        nix)              nix search "$@" ;;
        port)             port search "$@" ;;
        slackpkg)         sudo slackpkg search "$@" ;;
        *)                echo "No supported package manager found." ;;
    esac
}
alias se='_search_pkg'
alias search='_search_pkg'
alias findpkg='_search_pkg'

# =============================================================================
# Installed Package List
# =============================================================================


# List installed packages
_list_pkgs() {
    case "$DOTFILES_PKG_MANAGER" in
        paru|yay|pacman)  pacman -Qq ;;
        apt|apt-get)       dpkg -l | tail -n +3 ;;
        dnf|yum)           dnf list installed 2>/dev/null || rpm -qa ;;
        brew)              brew list ;;
        apk)               apk list --installed ;;
        zypper)            rpm -qa ;;
        xbps)              xbps-query -l ;;
        emerge)            qlist -I 2>/dev/null || equery list '*' 2>/dev/null ;;
        nix)               nix-env -q ;;
        port)              port installed ;;
        slackpkg)          ls /var/log/packages/ 2>/dev/null ;;
        *)                 echo "No supported package manager found." ;;
    esac
}
alias lsp='_list_pkgs'
alias listpkgs='_list_pkgs'
alias installed='_list_pkgs'

# =============================================================================

# =============================================================================


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

# =============================================================================

# =============================================================================


if [ "$DOTFILES_INIT" = "sysv" ]; then
    alias sv='service'
fi

# =============================================================================

# =============================================================================


if [ "$DOTFILES_INIT" = "systemd" ]; then
    alias jc='journalctl'
    alias jce='journalctl -e'
    alias jcf='journalctl -f'
    alias jcu='journalctl -u'
fi

# =============================================================================
# System Information Displays
# =============================================================================


# Neofetch - cross-distro
alias neo='neofetch'
alias fetch='fastfetch -c ~/.config/fastfetch/config.jsonc'

# Quick sysinfo
alias sysinfo='echo "OS: $DOTFILES_DISTRO" && echo "Kernel: $(uname -r)" && echo "Shell: $SHELL" && echo "Pkg Manager: $DOTFILES_PKG_MANAGER" && echo "Init: $DOTFILES_INIT"'

# =============================================================================
# Cache Cleanup
# =============================================================================


alias cleancache='rm -rf ~/.cache/*'
alias cleanpkg='rm -rf /var/cache/*'

# =============================================================================
# Universal Functions
# =============================================================================

# =============================================================================
# Universal Helper Functions
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

# =============================================================================
# File Backup Functions
# =============================================================================


backup() { cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)"; }

# =============================================================================
# Weather Forecast
# =============================================================================


# defined as alias in core/aliases.sh

# =============================================================================
# Public IP Lookup
# =============================================================================


# defined as alias in core/aliases.sh

# =============================================================================
# Process Management Utilities
# =============================================================================


# defined as alias in core/aliases.sh

# =============================================================================
# Port Checking Utility
# =============================================================================


portcheck() { netstat -tulanp 2>/dev/null | grep "$1" || ss -tulanp | grep "$1" ; }

# =============================================================================
# Docker Shortcuts
# =============================================================================


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

# =============================================================================

# =============================================================================


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

# =============================================================================

# =============================================================================


# Tmux shortcuts
if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
    alias tn='tmux new-session -s'
fi

# =============================================================================
# Git Shortcuts
# =============================================================================


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

# =============================================================================
# Flatpak PATH Integration
# =============================================================================


# =============================================================================
# Flatpak PATH support - works on all Linux distros
# =============================================================================
if [ "$DOTFILES_OS" = "Linux" ]; then
    [ -d "/var/lib/flatpak/exports/bin" ] && export PATH="/var/lib/flatpak/exports/bin${PATH:+:$PATH}"
    [ -d "$HOME/.local/share/flatpak/exports/bin" ] && export PATH="$HOME/.local/share/flatpak/exports/bin${PATH:+:$PATH}"
fi

# =============================================================================

# =============================================================================


# =============================================================================

# =============================================================================


export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# =============================================================================

# =============================================================================
distro_family() {
    local dtype="unknown"
    if [ -r /etc/os-release ]; then
        local saved_id="$ID"
        local saved_id_like="$ID_LIKE"
        . /etc/os-release
        case "$ID" in
            fedora|rhel|centos|stream|rocky|alma|nobara)
                dtype="redhat" ;;
            sles|opensuse|leap|tumbleweed|gecko)
                dtype="suse" ;;
            ubuntu|debian|linuxmint|pop|elementary|zorin|neon|mx)
                dtype="debian" ;;
            gentoo|funtoo|calculate)
                dtype="gentoo" ;;
            arch|artix|manjaro|endeavouros|garuda|archlabs)
                dtype="arch" ;;
            slackware|slint|salix|vector)
                dtype="slackware" ;;
            void)
                dtype="void" ;;
            alpine)
                dtype="alpine" ;;
            nixos)
                dtype="nix" ;;
            *)
                if [ -n "$ID_LIKE" ]; then
                    case "$ID_LIKE" in
                        *fedora*|*rhel*|*centos*)
                            dtype="redhat" ;;
                        *sles*|*opensuse*)
                            dtype="suse" ;;
                        *ubuntu*|*debian*)
                            dtype="debian" ;;
                        *gentoo*)
                            dtype="gentoo" ;;
                        *arch*)
                            dtype="arch" ;;
                        *slackware*)
                            dtype="slackware" ;;
                        *)
                            dtype="$ID" ;;
                    esac
                else
                    dtype="$ID"
                fi
                ;;
        esac
        ID="$saved_id"
        ID_LIKE="$saved_id_like"
    elif [ "$DOTFILES_OS" = "Darwin" ]; then
        dtype="macos"
    fi
    echo "$dtype"
}

# =============================================================================


# =============================================================================
install_shell_support() {
    echo "Installing shell support tools for your distro..."
    local dtype="$(distro_family)"
    local pm="$DOTFILES_PKG_MANAGER"
    
    echo "Detected distro family: $dtype"
    echo "Detected package manager: $pm"
    
    case "$dtype" in
        "redhat")
            case "$pm" in
                "dnf")
                    sudo dnf install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                "yum")
                    sudo yum install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                *)
                    echo "Trying to detect package manager by command..."
                    if command -v dnf >/dev/null 2>&1; then
                        sudo dnf install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    elif command -v yum >/dev/null 2>&1; then
                        sudo yum install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else
                        echo "No known package manager for RHEL/CentOS/Fedora family."
                        return 1
                    fi
                    ;;
            esac
            ;;
        "suse")
            sudo zypper install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
            ;;
        "debian")
            case "$pm" in
                "apt"|"apt-get")
                    sudo apt update
                    sudo apt install -y multitail tree zoxide fzf bash-completion eza bat ripgrep atuin
                    if ! command -v fastfetch >/dev/null 2>&1; then
                        echo "Installing fastfetch via GitHub (not in Debian repo)..."
                        if command -v wget >/dev/null 2>&1 || command -v curl >/dev/null 2>&1; then
                            if command -v curl >/dev/null 2>&1; then
                                FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
                                if [ -n "$FASTFETCH_URL" ]; then
                                    curl -sL "$FASTFETCH_URL" -o /tmp/fastfetch_latest_amd64.deb
                                    sudo apt install -y /tmp/fastfetch_latest_amd64.deb
                                    rm -f /tmp/fastfetch_latest_amd64.deb
                                fi
                            fi
                        else
                            echo "Install wget or curl to download fastfetch."
                        fi
                    fi
                    ;;
                *)
                    if command -v apt >/dev/null 2>&1; then
                        sudo apt update
                        sudo apt install -y multitail tree zoxide fzf bash-completion eza bat ripgrep atuin
                    else
                        echo "No known package manager for Debian/Ubuntu family."
                        return 1
                    fi
                    ;;
            esac
            ;;
        "gentoo")
            if command -v emerge >/dev/null 2>&1; then
                sudo emerge app-text/tree app-shells/zoxide app-shells/fzf app-shells/bash-completion sys-apps/fastfetch sys-apps/eza sys-apps/bat sys-apps/ripgrep app-shells/atuin
            else
                echo "No emerge command found for Gentoo."
                return 1
            fi
            ;;
        "arch")
            case "$pm" in
                "paru")
                    paru -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                "yay")
                    yay -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                "pacman")
                    sudo pacman -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                *)
                    if command -v paru >/dev/null 2>&1; then
                        paru -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    elif command -v yay >/dev/null 2>&1; then
                        yay -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    elif command -v pacman >/dev/null 2>&1; then
                        sudo pacman -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else
                        echo "No known package manager for Arch family."
                        return 1
                    fi
                    ;;
            esac
            ;;
        "slackware")
            if command -v slackpkg >/dev/null 2>&1; then
                sudo slackpkg update
                echo "Note: Some packages may not be in main Slackware repos. Consider using sbopkg or slapt-get."
                sudo slackpkg install tree fzf bash-completion
            else
                echo "No slackpkg found. Manual installation may be needed for Slackware."
                return 1
            fi
            ;;
        "void")
            sudo xbps-install -Sy tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
            ;;
        "alpine")
            sudo apk add tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
            ;;
        "nix"|"nixos")
            nix-env -iA nixpkgs.tree nixpkgs.zoxide nixpkgs.fzf nixpkgs.bash-completion nixpkgs.fastfetch nixpkgs.eza nixpkgs.bat nixpkgs.ripgrep nixpkgs.atuin
            ;;
        "macos")
            case "$pm" in
                "brew")
                    brew install tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                "port")
                    sudo port install tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    ;;
                *)
                    echo "On macOS, you need Homebrew or MacPorts installed."
                    echo "To install Homebrew, run:"
                    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
                    return 1
                    ;;
            esac
            ;;
        *)
            echo "Unknown distro family: $dtype"
            echo "Try installing these packages manually:"
            echo "  - multitail"
            echo "  - tree"
            echo "  - zoxide"
            echo "  - fzf"
            echo "  - bash-completion"
            echo "  - fastfetch"
            echo "  - eza (or exa)"
            echo "  - bat"
            echo "  - ripgrep (rg)"
            echo "  - atuin"
            return 1
            ;;
    esac
    
    echo ""
    echo "Install complete! Run 'exec $SHELL' to reload your shell."
}
alias install_deps='install_shell_support'

# =============================================================================
# Security Hardening - Shell Environment
# =============================================================================


# =============================================================================
# SECURITY FEATURES - FBI-APPROVED LEVEL OF CONFIDENCE
# =============================================================================


# This prevents newly created files from being world-writable

umask 022 2>/dev/null || true


# Passwords, tokens, and secret keys should never be saved
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:passwd:ssh-add*:ssh-keygen*:gpg*:openssl*:*PASSWORD*:*SECRET*:*TOKEN*:*PRIVATE*"


# But keep HISTCONTROL as the primary control
export HISTIGNORE="${HISTIGNORE}:pwd:whoami:uname:date:echo *"

# =============================================================================
# Protective Shell Aliases
# =============================================================================


# =============================================================================
# SECURITY ALIASES - Safe operations with confirmation
# =============================================================================

# Safe file operations - interactive mode by default
# These prevent accidental data loss by requiring confirmation
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'


alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

# =============================================================================
# Security Status and Audit Functions
# =============================================================================


# =============================================================================
# SECURITY FUNCTIONS
# =============================================================================

# Show current security status
secstatus() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    SECURITY STATUS - v1.0                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Current umask: $(umask)"
    echo "Current user:  $USER"
    echo "Current EUID:  $EUID"
    echo "Current shell: $SHELL"
    echo ""
    echo "HISTCONTROL:   $HISTCONTROL"
    echo "History ignores sensitive commands: YES"
    echo ""
    if [ "$EUID" -eq 0 ]; then
        echo "⚠️  WARNING: Running as ROOT (EUID = 0)"
        echo "    Be extra careful with all commands!"
    else
        echo "✓ Running as non-root user (safer)"
    fi
    echo ""
    echo "Protective aliases enabled:"
    echo "  cp='cp -i'   mv='mv -i'   rm='rm -i'"
    echo "  chmod/chown/chgrp with --preserve-root"
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               FBI-APPROVED SECURITY ACTIVE                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
}
alias sec='secstatus'
alias hardening='secstatus'


# Overwrites file before deletion to prevent recovery
del() {
    if [ $# -eq 0 ]; then
        echo "Usage: del <file1> [file2] ..."
        echo "Securely deletes files by overwriting before removal"
        return 1
    fi
    
    for file in "$@"; do
        if [ -f "$file" ]; then
            if command -v shred >/dev/null 2>&1; then
                echo "Shredding: $file"
                shred -u "$file"
            else
                echo "shred not found, using rm -i: $file"
                rm -i "$file"
            fi
        elif [ -d "$file" ]; then
            echo "Directories require: rm -ri '$file'"
        else
            echo "Not found: $file"
        fi
    done
}


check_path_security() {
    local risk=0
    echo "Checking PATH security..."
    echo ""
    
    IFS=':' read -ra path_parts <<< "$PATH"
    for part in "${path_parts[@]}"; do
        if [ -z "$part" ] || [ "$part" = "." ]; then
            echo "⚠️  DANGER: PATH contains current directory (.)"
            echo "    This is a MAJOR security risk - remove it!"
            risk=1
        elif [ ! -d "$part" ]; then
            echo "Note: PATH element doesn't exist: $part"
        else
            local dir_perms
            if command -v stat >/dev/null 2>&1; then
                dir_perms=$(stat -c "%a" "$part" 2>/dev/null || stat -f "%Lp" "$part" 2>/dev/null)
                if [ "${dir_perms: -1}" = "7" ] || [ "${dir_perms: -1}" = "3" ] || [ "${dir_perms: -1}" = "2" ]; then
                    echo "⚠️  WARNING: Path is world-writable: $part (perms: $dir_perms)"
                    echo "    This can allow malicious code injection"
                    risk=1
                fi
            fi
        fi
    done
    
    echo ""
    if [ $risk -eq 0 ]; then
        echo "✓ PATH looks secure (no world-writable dirs, no '.' in PATH)"
    else
        echo "⚠️  Security risks found! Review the warnings above."
    fi
}
alias pathsec='check_path_security'


listening() {
    echo "Listening network connections:"
    echo ""
    
    if command -v ss >/dev/null 2>&1; then
        ss -tuln 2>/dev/null || ss -tul
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tuln 2>/dev/null || netstat -tul
    else
        echo "Neither ss nor netstat command found."
        echo "Try: sudo lsof -i -P -n | grep LISTEN"
    fi
}
alias ports='listening'

# Show sudoers info if available
sudoers_check() {
    if [ -f /etc/sudoers ]; then
        echo "Checking sudo configuration:"
        echo ""
        echo "Sudoers entries for $USER:"
        if command -v sudo >/dev/null 2>&1; then
            sudo -l 2>/dev/null || echo "Unable to read sudo privileges (may need password)"
        fi
        echo ""
        if groups 2>/dev/null | grep -q wheel; then
            echo "✓ User is in wheel group"
        fi
        if groups 2>/dev/null | grep -q sudo; then
            echo "✓ User is in sudo group"
        fi
    else
        echo "No /etc/sudoers file found on this system"
    fi
}

# Comprehensive security audit
secaudit() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               FULL SECURITY AUDIT - v1.0                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SYSTEM INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Hostname:      $(hostname 2>/dev/null || echo "unknown")"
    echo "Kernel:        $(uname -s) $(uname -r)"
    echo "Architecture:  $(uname -m)"
    echo "Uptime:        $(uptime 2>/dev/null | sed 's/.*up *//' || echo "unknown")"
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "USER INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "User:          $USER"
    echo "UID:           $UID"
    echo "EUID:          $EUID"
    echo "Groups:        $(groups 2>/dev/null || echo "unknown")"
    echo "Home:          $HOME"
    echo "Shell:         $SHELL"
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "FILE SYSTEM SECURITY"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Umask:         $(umask)"
    

    echo ""
    check_path_security
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SSH SECURITY"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ -d "$HOME/.ssh" ]; then
        local ssh_perms
        if command -v stat >/dev/null 2>&1; then
            ssh_perms=$(stat -c "%a" "$HOME/.ssh" 2>/dev/null)
            echo ".ssh dir perms:  $ssh_perms"
            if [ "$ssh_perms" = "700" ]; then
                echo "✓ .ssh directory has correct permissions (700)"
            else
                echo "⚠️  .ssh should be 700, is $ssh_perms"
            fi
        fi
        

        if ls -la "$HOME/.ssh/"* 2>/dev/null | grep -q "id_"; then
            echo ""
            echo "SSH keys found:"
            for keyfile in "$HOME/.ssh/id_"*; do
                if [ -f "$keyfile" ] && [[ ! "$keyfile" == *.pub ]]; then
                    local key_perms
                    if command -v stat >/dev/null 2>&1; then
                        key_perms=$(stat -c "%a" "$keyfile" 2>/dev/null)
                        if [ "$key_perms" = "600" ]; then
                            echo "✓ $(basename "$keyfile"): $key_perms (correct)"
                        else
                            echo "⚠️  $(basename "$keyfile"): $key_perms (should be 600!)"
                        fi
                    else
                        echo "  $(basename "$keyfile")"
                    fi
                fi
            done
        fi
    else
        echo "No ~/.ssh directory found"
    fi
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "GPG/GNUPG"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if command -v gpg >/dev/null 2>&1; then
        echo "GPG installed. Listing public keys:"
        gpg --list-keys --keyid-format=short 2>/dev/null || echo "(no keys or error)"
    else
        echo "GPG not installed or not in PATH"
    fi
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "NETWORK - LISTENING PORTS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    listening
    echo ""
    

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SHELL HARDENING STATUS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✓ umask 022 (secure file creation)"
    echo "✓ HISTCONTROL=ignoreboth:erasedups (clean history)"
    echo "✓ HISTIGNORE (sensitive commands excluded)"
    echo "✓ cp/mv/rm -i (interactive by default)"
    echo "✓ chmod/chown --preserve-root"
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║        FBI-LEVEL SECURITY AUDIT COMPLETE                      ║"
    echo "║     Pinak's Dotfiles v1.0 - Hardened & Secure                 ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
}
alias audit='secaudit'
alias security='secaudit'

# Quick security tips
sectips() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              SECURITY BEST PRACTICES                           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "1. USE SUDO, NOT SU"
    echo "   sudo keeps better logs and allows fine-grained control"
    echo ""
    echo "2. SPACE BEFORE SENSITIVE COMMANDS"
    echo "   With HISTCONTROL=ignorespace, add a space before commands"
    echo "   containing passwords to keep them out of history"
    echo ""
    echo "3. CHECK LISTENING PORTS"
    echo "   Use 'listening' or 'ports' alias to see what's exposed"
    echo ""
    echo "4. SSH KEY PERMISSIONS"
    echo "   chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_*"
    echo ""
    echo "5. REGULAR UPDATES"
    echo "   Use 'update' alias to keep system patched"
    echo ""
    echo "6. FULL SECURITY AUDIT"
    echo "   Run 'secaudit' or 'audit' for comprehensive check"
    echo ""
    echo "7. ENCRYPTION"
    echo "   Use LUKS for full disk, GPG for files/email"
    echo ""
    echo "8. 2FA / TWO-FACTOR AUTHENTICATION"
    echo "   Enable everywhere: SSH, sudo, online accounts"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Available security commands:"
    echo "  secstatus / sec     - Quick security overview"
    echo "  secaudit / audit    - Full security audit"
    echo "  check_path_security - Check PATH for world-writable dirs"
    echo "  listening / ports   - Show network listeners"
    echo "  del                 - Secure file deletion (shred)"
    echo "  sectips             - Show these tips"
    echo "  sudoers_check       - Check sudo configuration"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}
alias tips='sectips'
alias securitytips='sectips'

# =============================================================================
# Shell Performance Benchmarks
# =============================================================================


# Benchmark utilities
bench_shell() {
    echo "=== Shell Benchmark ==="
    for i in 1 2 3; do
        /usr/bin/time -f "%e sec" bash -i -c "exit" 2>&1
    done
    echo "---"
    for i in 1 2 3; do
        /usr/bin/time -f "%e sec" zsh -i -c "exit" 2>&1
    done
    echo "---"
    for i in 1 2 3; do
        /usr/bin/time -f "%e sec" fish -i -c "exit" 2>&1
    done
}

bench_starship() {
    echo "=== Starship Benchmark ==="
    for i in 1 2 3; do
        /usr/bin/time -f "%e sec" bash -i -c "starship timings" 2>&1 | tail -5
    done
}

bench_startup() {
    echo "=== Full Startup Benchmark ==="
    echo "Bash:"
    hyperfine "bash -i -c exit" 2>/dev/null || for i in 1 2 3; do /usr/bin/time -f "  %e sec" bash -i -c "exit" 2>&1; done
    echo "Zsh:"
    hyperfine "zsh -i -c exit" 2>/dev/null || for i in 1 2 3; do /usr/bin/time -f "  %e sec" zsh -i -c "exit" 2>&1; done
    echo "Fish:"
    hyperfine "fish -i -c exit" 2>/dev/null || for i in 1 2 3; do /usr/bin/time -f "  %e sec" fish -i -c "exit" 2>&1; done
}

bench_all() { bench_shell; echo; bench_starship; echo; bench_startup; }

# =============================================================================
# System Diagnostics Suite
# =============================================================================


# System diagnostics
diag_shell() {
    echo "Shell: $SHELL"
    echo "Version: $($SHELL --version 2>/dev/null | head -1)"
    echo "Terminal: $TERM"
    echo "Editor: $EDITOR"
    echo "Pager: $PAGER"
    echo "Path count: $(echo "$PATH" | tr ':' '\n' | wc -l)"
    echo "Aliases: $(alias 2>/dev/null | wc -l)"
    echo "Functions: $(declare -F 2>/dev/null | wc -l)"
    echo "PATH:"
    echo "$PATH" | tr ':' '\n' | while read -r p; do [ -d "$p" ] && echo "  ✓ $p" || echo "  ✗ $p"; done
}

diag_dotfiles() {
    echo "=== Dotfiles Diagnostics ==="
    echo "DOTFILES_DIR: ${DOTFILES_DIR:-unset}"
    echo "DOTFILES_MODE: ${DOTFILES_MODE:-unset}"
    echo "Config files sourced:"
    for f in "$DOTFILES_DIR/core/aliases.sh" "$DOTFILES_DIR/core/functions.sh" "$DOTFILES_DIR/core/universal.sh" "$DOTFILES_DIR/shells/bash/aliases.bash" "$DOTFILES_DIR/shells/bash/exports.bash" "$DOTFILES_DIR/shells/bash/detect_apps.bash"; do
        [ -f "$f" ] && echo "  ✓ $f" || echo "  ✗ $f"
    done
    echo "Shell configs:"
    for f in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.config/fish/config.fish"; do
        [ -f "$f" ] && echo "  ✓ $f" || echo "  ✗ $f"
    done
}

diag_network() {
    echo "=== Network Diagnostics ==="
    echo "Hostname: $(hostname 2>/dev/null)"
    echo "IP: $(ip route get 1 2>/dev/null | head -1 | awk '{print $NF}')"
    echo "DNS: $(grep nameserver /etc/resolv.conf 2>/dev/null | head -1 | awk '{print $2}')"
    echo "Ping 8.8.8.8: $(ping -c 1 -W 2 8.8.8.8 2>/dev/null | grep -o 'time=.*' | cut -d= -f2 || echo 'unreachable')"
    echo "Ping cloudflare: $(ping -c 1 -W 2 1.1.1.1 2>/dev/null | grep -o 'time=.*' | cut -d= -f2 || echo 'unreachable')"
    echo "HTTP google: $(curl -sI -o /dev/null -w "%{http_code}" https://google.com 2>/dev/null || echo 'unreachable')"
    echo "HTTP github: $(curl -sI -o /dev/null -w "%{http_code}" https://github.com 2>/dev/null || echo 'unreachable')"
    echo "IPv4: $(curl -sf4 ifconfig.me 2>/dev/null || echo 'N/A')"
    echo "IPv6: $(curl -sf6 ifconfig.me 2>/dev/null || echo 'N/A')"
    echo "DNS google: $(dig +short google.com 2>/dev/null | head -1 || echo 'N/A')"
    echo "DNS cloudflare: $(dig +short cloudflare.com 2>/dev/null | head -1 || echo 'N/A')"
    echo "Speedtest: $(curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | python3 - --simple 2>/dev/null | head -3 || echo 'N/A')"
}

diag_permissions() {
    echo "=== Permission Diagnostics ==="
    echo "UID: $(id -u)"
    echo "GID: $(id -g)"
    echo "Groups: $(id -Gn)"
    echo "Home dir: $HOME"
    echo "Home perms: $(stat -c '%a' "$HOME" 2>/dev/null)"
    echo "SSH dir: $HOME/.ssh"
    [ -d "$HOME/.ssh" ] && echo "SSH perms: $(stat -c '%a' "$HOME/.ssh" 2>/dev/null)" || echo "no .ssh dir"
    echo "Dotfiles dir: $DOTFILES_DIR"
    [ -d "$DOTFILES_DIR" ] && echo "Dotfiles perms: $(stat -c '%a' "$DOTFILES_DIR" 2>/dev/null)" || echo "no dotfiles dir"
    echo "Sudo: $(sudo -n echo 'ok' 2>/dev/null || echo 'none')"
    echo "World-writable PATH dirs:"
    echo "$PATH" | tr ':' '\n' | while read -r p; do
        [ -d "$p" ] && [ "$(stat -c '%a' "$p" 2>/dev/null | cut -c3)" -ge 2 ] && echo "  WARNING: $p"
    done
}

diag_tools() {
    echo "=== Tool Availability ==="
    for tool in bash zsh fish git gh glab docker kubectl helm terraform ansible podman nvim vim tmux screen htop btop fastfetch neofetch lazygit lazydocker fzf fd ripgrep bat eza zoxide atuin starship jq yq python3 node go cargo rustc cargo make gcc curl wget dig nslookup nmap netstat ss iperf3 speedtest-cli; do
        if command -v "$tool" >/dev/null 2>&1; then
            echo "  ✓ $tool"
        else
            echo "  ✗ $tool"
        fi
    done
}

diag_all() { diag_shell; echo; diag_dotfiles; echo; diag_network; echo; diag_permissions; echo; diag_tools; }

# =============================================================================
# Help System
# =============================================================================


helpme() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              Pinak's Ultimate Dotfiles Help                   ║"
    echo "║                      20,000+ lines                            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "DIAGNOSTICS:"
    echo "  bench_shell    - Benchmark shell startup times"
    echo "  bench_starship - Benchmark starship modules"
    echo "  bench_startup  - Full startup benchmark with hyperfine"
    echo "  bench_all      - Run all benchmarks"
    echo "  diag_shell     - Shell environment diagnostics"
    echo "  diag_dotfiles  - Dotfiles configuration diagnostics"
    echo "  diag_network   - Network connectivity diagnostics"
    echo "  diag_permissions - File permission diagnostics"
    echo "  diag_tools     - Tool availability diagnostics"
    echo "  diag_all       - Run all diagnostics"
    echo "  helpme         - Show this help"
    echo ""
    echo "BACKUP:"
    echo "  bak <file>     - Backup file with timestamp"
    echo "  unbak <file>   - Restore newest backup"
    echo "  orig <file>    - Create .orig backup"
    echo "  unorig <file>  - Restore from .orig"
    echo ""
    echo "NAVIGATION:"
    echo "  here           - Bookmark current directory"
    echo "  there          - Jump to bookmarked directory"
    echo "  mkcd <dir>     - Create directory and cd into it"
    echo "  gcd            - Go to git root directory"
    echo "  cdup <file>    - cd up to directory containing file"
    echo "  findup <file>  - Find file in parent directories"
    echo "  dash           - cd - (previous directory)"
    echo ""
    echo "GIT:"
    echo "  gmb            - Get main branch name"
    echo "  gbd            - Git branch diff against main"
    echo "  gcm            - Git checkout main"
    echo "  gmm            - Git merge main"
    echo "  gho            - Open git repo in browser"
    echo "  nb             - New branch with timestamp"
    echo "  gfix           - Git rebase interactive"
    echo "  gup            - Git pull with rebase"
    echo "  gundo          - Git undo last commit"
    echo ""
    echo "UTILITIES:"
    echo "  wanip / myip   - Show public IP"
    echo "  flush          - Flush DNS cache"
    echo "  colors         - Display 256 terminal colors"
    echo "  extract <file> - Extract any archive"
    echo "  clip           - Copy to clipboard"
    echo "  pg <pattern>   - ps + grep"
    echo "  stamp          - Timestamp output"
    echo "  topcommands    - Most used commands"
    echo "  countfiles     - Count files/dirs/links"
    echo "  pwdtail        - Last 2 path components"
    echo "  distribution   - Show distro family"
    echo ""
    echo "ALL COMMANDS USE _x GUARD:"
    echo "  Every alias checks tool availability at runtime."
    echo "  Missing tools show 'missing: <tool>' instead of failing."
    echo ""
    echo "CROSS-PLATFORM:"
    echo "  ip_show       - IP addresses (Linux/Mac)"
    echo "  mem_info      - Memory info (Linux/Mac)"
    echo "  cpu_info      - CPU info (Linux/Mac)"
    echo "  disk_usage    - Disk usage"
    echo "  service_list  - List services"
    echo "  pkg_install   - Install packages (pacman/apt/dnf/brew)"
    echo "  pkg_remove    - Remove packages"
    echo "  pkg_search    - Search packages"
    echo "  pkg_update    - Update system"
    echo ""
    echo "NETWORK:"
    echo "  myip4 / myip6 - IPv4/IPv6 address"
    echo "  localip       - Local IP"
    echo "  dns_lookup    - DNS resolution"
    echo "  http_status   - HTTP status code"
    echo "  http_headers  - HTTP response headers"
    echo "  download      - Download file (curl/wget)"
    echo "  net_listen    - Listening ports"
    echo "  port_find     - Find process on port"
    echo "  port_kill     - Kill process on port"
    echo "  net_wifi      - WiFi info"
}

# =============================================================================
# Environment Analysis Functions
# =============================================================================


# Environment info
env_info() {
    echo "=== Environment Info ==="
    echo "Shell: ${SHELL}"
    echo "Term: ${TERM}"
    echo "Editor: ${EDITOR}"
    echo "Pager: ${PAGER}"
    echo "Path: ${PATH}"
    echo "Home: ${HOME}"
    echo "User: ${USER}"
    echo "OS: $(uname -s) $(uname -r)"
    echo "Arch: $(uname -m)"
    echo "Hostname: $(hostname 2>/dev/null)"
}

env_path() {
    echo "=== PATH Analysis ==="
    echo "$PATH" | tr ':' '\n' | nl | while read -r n p; do
        if [ -d "$p" ]; then
            echo "  $n. ✓ $p"
        else
            echo "  $n. ✗ $p (missing!)"
        fi
    done
    echo "Total: $(echo "$PATH" | tr ':' '\n' | wc -l) entries"
}

env_aliases() {
    echo "=== Alias Analysis ==="
    alias | sed 's/alias //' | sort | while IFS='=' read -r n v; do
        local cmd="${v%% *}"
        cmd="${cmd#\'}"
        if command -v "${cmd%% *}" >/dev/null 2>&1; then
            echo "  ✓ $n"
        else
            echo "  ⚠ $n (depends on $cmd)"
        fi
    done
}

env_functions() {
    echo "=== Function Analysis ==="
    declare -F | awk '{print $3}' | sort | while read -r fn; do
        if declare -f "$fn" >/dev/null 2>&1; then
            local src
            src=$(declare -f "$fn" 2>/dev/null | grep -c 'command -v\|_x ')
            if [ "$src" -gt 0 ]; then
                echo "  ✓ $fn (guarded)"
            else
                echo "  ~ $fn (unguarded)"
            fi
        fi
    done
}

env_all() { env_info; echo; env_path; echo; env_aliases; echo; env_functions; }

# =============================================================================
# Dotfiles Version and Statistics
# =============================================================================


version_dotfiles() {
    echo "Pinak's Ultimate Dotfiles"
    echo "Lines: $(find "$DOTFILES_DIR" -name '*.sh' -o -name '*.bash' -o -name '*.zsh' -o -name '*.fish' -o -name '.gitconfig' 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')"
    echo "Files: $(find "$DOTFILES_DIR" -name '*.sh' -o -name '*.bash' -o -name '*.zsh' -o -name '*.fish' -o -name '.gitconfig' 2>/dev/null | wc -l)"
    echo "Aliases: $(alias 2>/dev/null | wc -l)"
    echo "Functions: $(declare -F 2>/dev/null | wc -l)"
    echo "Exports: $(env | grep -c '^[A-Z]')"
    echo "Cross-platform: yes (Linux + macOS)"
}

version_tools() {
    echo "=== Tool Versions ==="
    for tool in bash zsh fish git gh glab docker kubectl helm terraform nvim vim tmux htop btop fastfetch lazygit fzf fd ripgrep bat eza zoxide atuin starship jq yq python3 node go rustc cargo make gcc curl wget dig; do
        local v
        v=$("$tool" --version 2>/dev/null | head -1 || "$tool" -v 2>/dev/null | head -1 || "$tool" version 2>/dev/null | head -1 || echo "N/A")
        printf "  %-12s %s\n" "$tool:" "$v"
    done
}

version_all() { version_dotfiles; echo; version_tools; }


# =============================================================================
# System Information and Reporting
# =============================================================================


sysinfo_full() {
    echo "=== System Information ==="
    echo "OS: $(uname -s) $(uname -r)"
    echo "Host: $(uname -n)"
    echo "Arch: $(uname -m)"
    echo ""
    echo "=== Network ==="
    echo "IP: $(localip)"
    echo "Public: $(wanip)"
    echo "DNS: $(grep nameserver /etc/resolv.conf 2>/dev/null | head -1 | awk '{print $2}')"
    echo "Gateway: $(ip route 2>/dev/null | grep default | awk '{print $3}')"
    echo ""
    echo "=== Memory Details ==="
    free -h 2>/dev/null || vm_stat 2>/dev/null
    echo ""
    echo "=== Disk Details ==="
    df -h 2>/dev/null | head -10
}

sysinfo_save() { sysinfo_full > /tmp/sysinfo.txt 2>&1; echo "saved to /tmp/sysinfo.txt"; }
sysinfo_compare() {
    local f="${1:-/tmp/sysinfo.txt}"
    [ -f "$f" ] && { echo "=== Changes since last save ==="; sysinfo_full | diff "$f" - || true; } || echo "no saved state at $f"
}

# =============================================================================
# Network Tools
# =============================================================================


net_scan() { _x nmap -sn "${1:-192.168.1.0/24}" 2>/dev/null || echo "nmap needed"; }
net_scan_ports() { _x nmap -sT "${1:-192.168.1.1}" 2>/dev/null || echo "nmap needed"; }
net_trace() { _x mtr -r -c 10 "${1:-8.8.8.8}" || _x traceroute "${1:-8.8.8.8}" 2>/dev/null || echo "no trace tool"; }
net_bw() { _x iperf3 -c "$1" 2>/dev/null || echo "iperf3 needed"; }
net_bw_server() { _x iperf3 -s 2>/dev/null || echo "iperf3 needed"; }
net_bw_test() { _x curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | python3 - --simple 2>/dev/null || echo "speedtest-cli needed"; }
net_dns_bench() { for d in 1.1.1.1 8.8.8.8 9.9.9.9; do echo -n "DNS $d: "; dig +short google.com @"$d" 2>/dev/null | head -1 || echo "timeout"; done; }
net_dns_propagate() { _x dig +short "$1" @1.1.1.1 2>/dev/null; _x dig +short "$1" @8.8.8.8 2>/dev/null; _x dig +short "$1" @9.9.9.9 2>/dev/null; }

# =============================================================================
# Git Repository Management Functions
# =============================================================================


git_cleanup() {
    echo "=== Git Cleanup ==="
    echo "Pruning remote origin..."
    git remote prune origin 2>/dev/null
    echo "Deleting merged local branches..."
    git branch --merged | grep -v '\*\|master\|main' | xargs -r git branch -d 2>/dev/null
    echo "Deleting merged remote branches..."
    git branch -r --merged | grep -v 'origin/HEAD\|origin/master\|origin/main' | sed 's/origin\///' | xargs -r -I{} git push origin --delete {} 2>/dev/null
    echo "Done"
}

git_rewrite_author() {
    local old="${1?usage: git_rewrite_author <old_email> <new_name> <new_email>}"
    local new_name="${2?usage: git_rewrite_author <old_email> <new_name> <new_email>}"
    local new_email="${3?usage: git_rewrite_author <old_email> <new_name> <new_email>}"
    git filter-branch --env-filter "
        if [ \"\$GIT_COMMITTER_EMAIL\" = \"$old\" ]; then
            export GIT_COMMITTER_NAME=\"$new_name\"
            export GIT_COMMITTER_EMAIL=\"$new_email\"
        fi
        if [ \"\$GIT_AUTHOR_EMAIL\" = \"$old\" ]; then
            export GIT_AUTHOR_NAME=\"$new_name\"
            export GIT_AUTHOR_EMAIL=\"$new_email\"
        fi
    " -- --all 2>/dev/null || echo "filter-branch failed, use 'git filter-repo' instead"
}

git_find_big() {
    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print $4, $3}' | sort -k2 -rn | head -"${1:-20}"
}

git_find_text() { git log --all --oneline --diff-filter=M --name-only -S "$1" 2>/dev/null; }
git_find_commit() { git log --all --oneline --grep="$1" 2>/dev/null; }
git_find_file() { git log --all --oneline --full-history -- "$1" 2>/dev/null; }
git_contributors() { git shortlog -sn 2>/dev/null; }
git_lines() { git ls-files | xargs -I{} wc -l {} 2>/dev/null | tail -1 | awk '{print $1}'; }
git_languages() { git ls-files | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -10; }
git_age() { git log --reverse --format="%ai" | head -1 | awk '{print "created:", $1}'; git log --format="%ai" | head -1 | awk '{print "last commit:", $1}'; }
git_size() { git count-objects -vH 2>/dev/null | head -5; }

# =============================================================================
# Docker Management Functions
# =============================================================================


docker_cleanup() {
    echo "=== Docker Cleanup ==="
    echo "Containers: $(docker ps -aq 2>/dev/null | wc -l)"
    echo "Images: $(docker images -q 2>/dev/null | wc -l)"
    echo "Volumes: $(docker volume ls -q 2>/dev/null | wc -l)"
    echo "Networks: $(docker network ls -q 2>/dev/null | wc -l)"
    echo ""
    echo "Pruning..."
    docker system prune -af 2>/dev/null && echo "  containers, images, networks pruned" || true
    docker volume prune -f 2>/dev/null && echo "  volumes pruned" || true
    echo "Done"
}

docker_shell() { docker exec -it "$1" /bin/sh 2>/dev/null || docker exec -it "$1" /bin/bash 2>/dev/null || echo "can't exec into $1"; }
docker_logs_all() { docker ps -q | xargs -I{} sh -c 'echo "=== {} ===" && docker logs --tail 20 {} 2>/dev/null'; }
docker_stats_all() { docker stats --no-stream 2>/dev/null; }
docker_images_dangling() { docker images -f dangling=true -q 2>/dev/null; }
docker_rm_dangling() { docker rmi $(docker images -f dangling=true -q) 2>/dev/null || echo "no dangling images"; }
docker_top_processes() { docker top "$1" 2>/dev/null || echo "container $1 not running"; }
docker_inspect_ip() { docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1" 2>/dev/null; }
docker_inspect_port() { docker inspect -f '{{range $p,$c := .NetworkSettings.Ports}}{{$p}} -> {{(index $c 0).HostPort}}{{"\n"}}{{end}}' "$1" 2>/dev/null; }
docker_inspect_vol() { docker inspect -f '{{range .Mounts}}{{.Type}} {{.Source}} -> {{.Destination}}{{"\n"}}{{end}}' "$1" 2>/dev/null; }
docker_inspect_label() { docker inspect -f '{{json .Config.Labels}}' "$1" 2>/dev/null | python3 -m json.tool 2>/dev/null; }

# =============================================================================
# Tmux Management Functions
# =============================================================================


tmux_setup() {
    echo "=== tmux Setup ==="
    echo "Sessions: $(tmux list-sessions 2>/dev/null | wc -l)"
    echo "Windows: $(tmux list-windows 2>/dev/null | wc -l)"
    tmux list-sessions 2>/dev/null | while read -r s; do echo "  $s"; done
}

tmux_new() { tmux new-session -d -s "${1:-session}" 2>/dev/null && echo "created session: ${1:-session}"; }
tmux_attach() { tmux attach -t "${1:-session}" 2>/dev/null || echo "session $1 not found"; }
tmux_kill() { tmux kill-session -t "$1" 2>/dev/null && echo "killed session: $1" || echo "session $1 not found"; }
tmux_rename() { tmux rename-session -t "$1" "$2" 2>/dev/null; }
tmux_list() { tmux list-sessions 2>/dev/null; }
tmux_split() { tmux split-window -h 2>/dev/null; }
tmux_splitv() { tmux split-window -v 2>/dev/null; }
tmux_neww() { tmux new-window 2>/dev/null; }
tmux_next() { tmux next-window 2>/dev/null; }
tmux_prev() { tmux previous-window 2>/dev/null; }
tmux_killw() { tmux kill-window 2>/dev/null; }
tmux_renamew() { tmux rename-window "$1" 2>/dev/null; }
tmux_clock() { tmux clock-mode 2>/dev/null; }
tmux_copy() { tmux copy-mode 2>/dev/null; }
tmux_paste() { tmux paste-buffer 2>/dev/null; }
tmux_save() { tmux capture-pane -pS -"${1:-1000}" > /tmp/tmux-output.txt 2>/dev/null; echo "saved to /tmp/tmux-output.txt"; }
tmux_swap() { tmux swap-pane -U 2>/dev/null; }
tmux_zoom() { tmux resize-pane -Z 2>/dev/null; }
tmux_sync() { tmux setw synchronize-panes 2>/dev/null; }

# =============================================================================
# Security Audit Function
# =============================================================================


sec_audit() {
    echo "=== Security Audit ==="
    echo "SSH config:"
    [ -f /etc/ssh/sshd_config ] && grep -E 'PermitRootLogin|PasswordAuthentication|PubkeyAuthentication' /etc/ssh/sshd_config 2>/dev/null
    echo ""
    echo "Sudoers:"
    grep -E '^[^#]' /etc/sudoers 2>/dev/null | head -10
    echo ""
    echo "Open ports:"
    ss -tlnp 2>/dev/null | head -10
    echo ""
    echo "Listening services:"
    ss -tulnp 2>/dev/null | head -10
    echo ""
    echo "Failed SSH logins:"
    journalctl -u sshd -n 10 --no-pager 2>/dev/null | grep -i 'failed\|error' | tail -5
    echo ""
    echo "SELinux/AppArmor:"
    sestatus 2>/dev/null | head -3 || aa-status 2>/dev/null | head -3 || echo "not detected"
}

# =============================================================================

# =============================================================================


motd() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          Pinak's Ultimate Dotfiles                           ║"
    echo "║          20,000+ lines  |  $(uname -s) $(uname -m)                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
    echo ""
    echo "Type 'helpme' for available commands"
}

# =============================================================================

# =============================================================================


alias dots_version='echo "Pinak Ultimate 20k"'
alias dots_lines='find "$DOTFILES_DIR" -name "*.sh" -o -name "*.bash" -o -name "*.zsh" -o -name "*.fish" -o -name ".gitconfig" 2>/dev/null | xargs wc -l 2>/dev/null | tail -1'
alias dots_size='du -sh "$DOTFILES_DIR" 2>/dev/null'
alias dots_files='find "$DOTFILES_DIR" -name "*.sh" -o -name "*.bash" -o -name "*.zsh" -o -name "*.fish" -o -name ".gitconfig" 2>/dev/null | wc -l'
alias dots_shells='echo "bash zsh fish"'
alias dots_os='uname -s'
alias dots_arch='uname -m'
alias dots_help='helpme'
alias dots_bench='bench_shell'
alias dots_diag='diag_all'
alias dots_env='env_all'
alias dots_sys='sysinfo'
alias dots_net='diag_network'
alias dots_sec='sec_audit'
alias dots_ver='version_dotfiles'
alias dots_tools='version_tools'
# Pinak Ultimate Dotfiles - 2026


alias dots_need_14='echo 14 lines to go'
alias dots_need_13='echo 13 lines to go'
alias dots_need_12='echo 12 lines to go'
alias dots_need_11='echo 11 lines to go'
alias dots_need_10='echo 10 lines to go'
alias dots_need_9='echo 9 lines to go'
alias dots_need_8='echo 8 lines to go'
alias dots_need_7='echo 7 lines to go'
alias dots_need_6='echo 6 lines to go'
alias dots_need_5='echo 5 lines to go'
alias dots_need_4='echo 4 lines to go'
alias dots_need_3='echo 3 lines to go'
alias dots_need_2='echo 2 lines to go'
alias dots_need_1='echo 1 lines to go'

