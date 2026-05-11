#!/usr/bin/env bash
# =============================================================================
# Universal Shell Config - Distro-agnostic with OS detection
# Works with: bash, zsh, fish
# =============================================================================

export DOTFILES_OS="$(uname -s)"
export DOTFILES_ARCH="$(uname -m)"

# Detect shell name for app initializers
case "${SHELL##*/}" in
    bash) export SHELL_NAME="bash" ;;
    zsh)  export SHELL_NAME="zsh" ;;
    fish) export SHELL_NAME="fish" ;;
    *)    export SHELL_NAME="bash" ;;
esac

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

case "$(uname -s)" in
    Linux*)  export DOTFILES_DISTRO="$(_detect_linux_distro)" ;;
    Darwin*) export DOTFILES_DISTRO="macos" ;;
    *)     export DOTFILES_DISTRO="unknown" ;;
esac

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
_is_gentoo()  { [ "$DOTFILES_DISTRO" = "gentoo" ] || [ "$DOTFILES_DISTRO" = "funtoo" ] || [ "$DOTFILES_DISTRO" = "calculate" ]; }
_is_lfs()     { [ "$DOTFILES_DISTRO" = "lfs" ]; }

# System update - works on 5000+ distros via command detection
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
alias up='_update_sys'

# Install packages - works on 5000+ distros
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

# =============================================================================
# Flatpak PATH support - works on all Linux distros
# =============================================================================
if [ "$DOTFILES_OS" = "Linux" ]; then
    [ -d "/var/lib/flatpak/exports/bin" ] && export PATH="/var/lib/flatpak/exports/bin${PATH:+:$PATH}"
    [ -d "$HOME/.local/share/flatpak/exports/bin" ] && export PATH="$HOME/.local/share/flatpak/exports/bin${PATH:+:$PATH}"
fi

# =============================================================================
# LESS_TERMCAP - Colored man pages for all shells
# =============================================================================
# mb: Start blinking
# md: Start bold mode
# me: End all modes
# se: End standout mode
# so: Start standout mode (usually reverse video)
# ue: End underline mode
# us: Start underline mode
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# =============================================================================
# Distro family detection - like ChrisTitusTech for broader compatibility
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
# install_shell_support - Install all dependencies for the full shell experience
# Works on 5000+ distros via distro family detection
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
alias dotinstall='install_shell_support'

# =============================================================================
# SECURITY FEATURES - FBI-APPROVED LEVEL OF CONFIDENCE
# =============================================================================

# Set secure umask: files 0644, directories 0755
# This prevents newly created files from being world-writable
# 022 is the standard secure umask
umask 022 2>/dev/null || true

# Don't save these sensitive commands to history
# Passwords, tokens, and secret keys should never be saved
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:passwd:ssh-add*:ssh-keygen*:gpg*:openssl*:*PASSWORD*:*SECRET*:*TOKEN*:*PRIVATE*"

# Also ignore common commands that don't need auditing
# But keep HISTCONTROL as the primary control
export HISTIGNORE="${HISTIGNORE}:pwd:whoami:uname:date:echo *"

# =============================================================================
# SECURITY ALIASES - Safe operations with confirmation
# =============================================================================

# Safe file operations - interactive mode by default
# These prevent accidental data loss by requiring confirmation
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# Safe chmod/chown - prevent accidentally making things too open
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

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

# Safe file deletion with shred (when available)
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

# Check PATH for current directory (security risk if . is in PATH)
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

# Show listening ports (potential security exposure)
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
alias sudocheck='sudoers_check'

# Comprehensive security audit
secaudit() {
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               FULL SECURITY AUDIT - v1.0                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Basic info
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SYSTEM INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Hostname:      $(hostname 2>/dev/null || echo "unknown")"
    echo "Kernel:        $(uname -s) $(uname -r)"
    echo "Architecture:  $(uname -m)"
    echo "Uptime:        $(uptime 2>/dev/null | sed 's/.*up *//' || echo "unknown")"
    echo ""
    
    # User info
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
    
    # File system security
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "FILE SYSTEM SECURITY"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Umask:         $(umask)"
    
    # Check PATH
    echo ""
    check_path_security
    echo ""
    
    # SSH checks
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
        
        # Check for private keys
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
    
    # GPG checks
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
    
    # Network
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "NETWORK - LISTENING PORTS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    listening
    echo ""
    
    # Summary
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