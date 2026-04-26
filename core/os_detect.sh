#!/usr/bin/env sh
# =============================================================================
# OS/Distro Detection - Shared across all shells
# =============================================================================

detect_os() {
    case "$(uname -s)" in
        Linux*)     _os="linux" ;;
        Darwin*)   _os="macos" ;;
        CYGWIN*)   _os="windows" ;;
        MINGW*)   _os="windows" ;;
        *)        _os="unknown" ;;
    esac
    echo "$_os"
}

detect_distro() {
    case "$_os" in
        linux)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                case "$ID" in
                    arch|artix|manjaro|endeavouros|garuda|archlabs)
                        _distro="arch" ;;
                    debian|ubuntu|linuxmint|pop|elementary)
                        _distro="debian" ;;
                    fedora|centos|stream|rhel)
                        _distro="fedora" ;;
                    opensuse|sles)
                        _distro="suse" ;;
                    arch ARTIX*)
                        _distro="artix" ;;
                    void)
                        _distro="void" ;;
                    nixos)
                        _distro="nix" ;;
                    gentoo)
                        _distro="gentoo" ;;
                    alpine)
                        _distro="alpine" ;;
                    *)
                        _distro="$ID" ;;
                esac
            elif [ -f /etc/arch-release ]; then
                _distro="arch"
            elif [ -f /etc/debian_version ]; then
                _distro="debian"
            else
                _distro="linux"
            fi
            ;;
        macos)
            _distro="macos" ;;
        *)
            _distro="unknown" ;;
    esac
    echo "$_distro"
}

get_pkg_manager() {
    case "$_distro" in
        arch|artix)
            if command -v yay >/dev/null 2>&1; then
                echo "yay"
            elif command -v pacman >/dev/null 2>&1; then
                echo "pacman"
            else
                echo "none"
            fi ;;
        debian|ubuntu|linuxmint|pop)
            if command -v apt >/dev/null 2>&1; then
                echo "apt"
            elif command -v apt-get >/dev/null 2>&1; then
                echo "apt-get"
            else
                echo "none"
            fi ;;
        fedora|centos|rhel)
            if command -v dnf >/dev/null 2>&1; then
                echo "dnf"
            elif command -v yum >/dev/null 2>&1; then
                echo "yum"
            else
                echo "none"
            fi ;;
        suse)
            if command -v zypper >/dev/null 2>&1; then
                echo "zypper"
            else
                echo "none"
            fi ;;
        void)
            if command -v xbps >/dev/null 2>&1; then
                echo "xbps"
            else
                echo "none"
            fi ;;
        nix)
            if command -v nix-env >/dev/null 2>&1; then
                echo "nix"
            else
                echo "none"
            fi ;;
        gentoo)
            if command -v emerge >/dev/null 2>&1; then
                echo "emerge"
            else
                echo "none"
            fi ;;
        alpine)
            if command -v apk >/dev/null 2>&1; then
                echo "apk"
            else
                echo "none"
            fi ;;
        macos)
            if command -v brew >/dev/null 2>&1; then
                echo "brew"
            else
                echo "none"
            fi ;;
        *)
            echo "none" ;;
    esac
}

get_init_system() {
    if [ -d /run/systemd/system ]; then
        echo "systemd"
    elif [ -f /sbin/init ] && /sbin/init --version 2>/dev/null | grep -q systemd; then
        echo "systemd"
    elif [ -f /etc/init.d/cron ]; then
        echo "sysv"
    elif [ -f /proc/1/comm ]; then
        case "$(cat /proc/1/comm 2>/dev/null)" in
            systemd) echo "systemd" ;;
            init) echo "sysv" ;;
            runit) echo "runit" ;;
            openrc) echo "openrc" ;;
            *) echo "unknown" ;;
        esac
    else
        echo "unknown"
    fi
}