#!/usr/bin/env bash
# =============================================================================
# 05-DISTRO-DETECTION.SH - Universal Linux Distribution Detection
# Applies to ALL modes
# =============================================================================

# =============================================================================
# DISTRO DETECTION FUNCTION
# =============================================================================

detect_distro() {
    # Method 1: /etc/os-release (systemd standard)
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        # Convert to lowercase (compatible with bash and zsh)
        export DISTRO_ID=$(echo "$ID" | tr '[:upper:]' '[:lower:]')
        export DISTRO_NAME="$NAME"
        export DISTRO_VERSION="$VERSION_ID"
        export DISTRO_CODENAME="${VERSION_CODENAME:-}"
        
        # Handle IDs like "arch", "manjaro", "endeavouros"
        case "$DISTRO_ID" in
            arch|manjaro|endeavouros|garuda|cachyos)
                export DISTRO_FAMILY="arch"
                ;;
            debian|ubuntu|linuxmint|pop|elementary|zorin|kali|parrot|mx)
                export DISTRO_FAMILY="debian"
                ;;
            fedora|rhel|centos|almalinux|rocky|ol|amzn)
                export DISTRO_FAMILY="rhel"
                ;;
            opensuse*|suse*)
                export DISTRO_FAMILY="suse"
                ;;
            alpine)
                export DISTRO_FAMILY="alpine"
                ;;
            gentoo|funtoo)
                export DISTRO_FAMILY="gentoo"
                ;;
            void)
                export DISTRO_FAMILY="void"
                ;;
            nixos)
                export DISTRO_FAMILY="nix"
                ;;
            *)
                export DISTRO_FAMILY="unknown"
                ;;
        esac
        
        return 0
    fi
    
    # Method 2: lsb_release
    if command -v lsb_release &>/dev/null; then
        export DISTRO_ID=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
        export DISTRO_NAME=$(lsb_release -sd)
        export DISTRO_VERSION=$(lsb_release -sr)
        
        case "$DISTRO_ID" in
            arch|manjaro)
                export DISTRO_FAMILY="arch"
                ;;
            debian|ubuntu|mint)
                export DISTRO_FAMILY="debian"
                ;;
            fedora|redhat*|centos|amazon)
                export DISTRO_FAMILY="rhel"
                ;;
            opensuse*)
                export DISTRO_FAMILY="suse"
                ;;
            *)
                export DISTRO_FAMILY="unknown"
                ;;
        esac
        
        return 0
    fi
    
    # Method 3: Legacy detection
    if [[ -f /etc/arch-release ]]; then
        export DISTRO_ID="arch"
        export DISTRO_NAME="Arch Linux"
        export DISTRO_FAMILY="arch"
    elif [[ -f /etc/debian_version ]]; then
        export DISTRO_ID="debian"
        export DISTRO_NAME="Debian"
        export DISTRO_FAMILY="debian"
        export DISTRO_VERSION=$(cat /etc/debian_version)
    elif [[ -f /etc/redhat-release ]]; then
        export DISTRO_ID="rhel"
        export DISTRO_NAME=$(cat /etc/redhat-release)
        export DISTRO_FAMILY="rhel"
    elif [[ -f /etc/alpine-release ]]; then
        export DISTRO_ID="alpine"
        export DISTRO_NAME="Alpine Linux"
        export DISTRO_FAMILY="alpine"
        export DISTRO_VERSION=$(cat /etc/alpine-release)
    elif [[ -f /etc/gentoo-release ]]; then
        export DISTRO_ID="gentoo"
        export DISTRO_NAME="Gentoo"
        export DISTRO_FAMILY="gentoo"
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        export DISTRO_ID="macos"
        export DISTRO_NAME="macOS"
        export DISTRO_FAMILY="macos"
        export DISTRO_VERSION=$(sw_vers -productVersion 2>/dev/null || echo "unknown")
    else
        export DISTRO_ID="unknown"
        export DISTRO_NAME="Unknown"
        export DISTRO_FAMILY="unknown"
    fi
}

# =============================================================================
# PACKAGE MANAGER DETECTION
# =============================================================================

detect_package_manager() {
    if command -v pacman &>/dev/null; then
        export PKG_MANAGER="pacman"
        export PKG_INSTALL="sudo pacman -S"
        export PKG_REMOVE="sudo pacman -Rs"
        export PKG_UPDATE="sudo pacman -Syu"
        export PKG_SEARCH="pacman -Ss"
        export PKG_QUERY="pacman -Q"
        export PKG_CLEAN="sudo pacman -Rns \$(pacman -Qtdq)"
    elif command -v apt &>/dev/null; then
        export PKG_MANAGER="apt"
        export PKG_INSTALL="sudo apt install"
        export PKG_REMOVE="sudo apt remove"
        export PKG_UPDATE="sudo apt update && sudo apt upgrade"
        export PKG_SEARCH="apt search"
        export PKG_QUERY="dpkg -l"
        export PKG_CLEAN="sudo apt autoremove && sudo apt clean"
    elif command -v dnf &>/dev/null; then
        export PKG_MANAGER="dnf"
        export PKG_INSTALL="sudo dnf install"
        export PKG_REMOVE="sudo dnf remove"
        export PKG_UPDATE="sudo dnf upgrade"
        export PKG_SEARCH="dnf search"
        export PKG_QUERY="dnf list installed"
        export PKG_CLEAN="sudo dnf autoremove"
    elif command -v yum &>/dev/null; then
        export PKG_MANAGER="yum"
        export PKG_INSTALL="sudo yum install"
        export PKG_REMOVE="sudo yum remove"
        export PKG_UPDATE="sudo yum update"
        export PKG_SEARCH="yum search"
        export PKG_QUERY="yum list installed"
        export PKG_CLEAN="sudo yum clean all"
    elif command -v zypper &>/dev/null; then
        export PKG_MANAGER="zypper"
        export PKG_INSTALL="sudo zypper install"
        export PKG_REMOVE="sudo zypper remove"
        export PKG_UPDATE="sudo zypper update"
        export PKG_SEARCH="zypper search"
        export PKG_QUERY="zypper search -i"
        export PKG_CLEAN="sudo zypper clean"
    elif command -v apk &>/dev/null; then
        export PKG_MANAGER="apk"
        export PKG_INSTALL="sudo apk add"
        export PKG_REMOVE="sudo apk del"
        export PKG_UPDATE="sudo apk update && sudo apk upgrade"
        export PKG_SEARCH="apk search"
        export PKG_QUERY="apk list --installed"
        export PKG_CLEAN="sudo apk cache clean"
    elif command -v xbps-install &>/dev/null; then
        export PKG_MANAGER="xbps"
        export PKG_INSTALL="sudo xbps-install -S"
        export PKG_REMOVE="sudo xbps-remove -R"
        export PKG_UPDATE="sudo xbps-install -Su"
        export PKG_SEARCH="xbps-query -Rs"
        export PKG_QUERY="xbps-query -l"
        export PKG_CLEAN="sudo xbps-remove -Oo"
    elif command -v emerge &>/dev/null; then
        export PKG_MANAGER="portage"
        export PKG_INSTALL="sudo emerge"
        export PKG_REMOVE="sudo emerge --depclean"
        export PKG_UPDATE="sudo emerge --sync && sudo emerge -uDU @world"
        export PKG_SEARCH="emerge -s"
        export PKG_QUERY="qlist -I"
        export PKG_CLEAN="sudo emerge --depclean"
    elif command -v brew &>/dev/null; then
        export PKG_MANAGER="brew"
        export PKG_INSTALL="brew install"
        export PKG_REMOVE="brew uninstall"
        export PKG_UPDATE="brew update && brew upgrade"
        export PKG_SEARCH="brew search"
        export PKG_QUERY="brew list"
        export PKG_CLEAN="brew cleanup"
    elif command -v nix-env &>/dev/null; then
        export PKG_MANAGER="nix"
        export PKG_INSTALL="nix-env -iA"
        export PKG_REMOVE="nix-env -e"
        export PKG_UPDATE="nix-channel --update && nix-env -u"
        export PKG_SEARCH="nix search"
        export PKG_QUERY="nix-env -q"
        export PKG_CLEAN="nix-collect-garbage"
    else
        export PKG_MANAGER="unknown"
        export PKG_INSTALL="echo 'No package manager found'"
        export PKG_REMOVE="echo 'No package manager found'"
        export PKG_UPDATE="echo 'No package manager found'"
        export PKG_SEARCH="echo 'No package manager found'"
        export PKG_QUERY="echo 'No package manager found'"
        export PKG_CLEAN="echo 'No package manager found'"
    fi
}

# =============================================================================
# AUR HELPER DETECTION (Arch only)
# =============================================================================

detect_aur_helper() {
    if [[ "$DISTRO_FAMILY" != "arch" ]]; then
        return 1
    fi
    
    if command -v paru &>/dev/null; then
        export AUR_HELPER="paru"
        export AUR_INSTALL="paru -S"
        export AUR_UPDATE="paru -Syu"
        export AUR_SEARCH="paru -Ss"
    elif command -v yay &>/dev/null; then
        export AUR_HELPER="yay"
        export AUR_INSTALL="yay -S"
        export AUR_UPDATE="yay -Syu"
        export AUR_SEARCH="yay -Ss"
    else
        export AUR_HELPER=""
        export AUR_INSTALL=""
        export AUR_UPDATE=""
        export AUR_SEARCH=""
    fi
}

# =============================================================================
# INITIALIZATION
# =============================================================================

detect_distro
detect_package_manager
detect_aur_helper

# Export all variables
export DISTRO_ID DISTRO_NAME DISTRO_VERSION DISTRO_CODENAME DISTRO_FAMILY
export PKG_MANAGER PKG_INSTALL PKG_REMOVE PKG_UPDATE PKG_SEARCH PKG_QUERY PKG_CLEAN
export AUR_HELPER AUR_INSTALL AUR_UPDATE AUR_SEARCH
