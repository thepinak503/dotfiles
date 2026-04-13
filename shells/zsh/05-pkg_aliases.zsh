#!/usr/bin/env zsh
# =============================================================================
# .zsh/05-pkg_aliases.zsh — Cross-distro package manager wrappers
# Uses DOTFILES_PKG set by lib/system-detect.sh.
# =============================================================================

# Re-detect at function call time so it works even without system-detect.sh
_pkg() {
    if   command -v pacman      >/dev/null 2>&1; then echo pacman
    elif command -v apt-get     >/dev/null 2>&1; then echo apt
    elif command -v dnf         >/dev/null 2>&1; then echo dnf
    elif command -v yum         >/dev/null 2>&1; then echo yum
    elif command -v zypper      >/dev/null 2>&1; then echo zypper
    elif command -v xbps-install>/dev/null 2>&1; then echo xbps
    elif command -v apk         >/dev/null 2>&1; then echo apk
    elif command -v emerge      >/dev/null 2>&1; then echo emerge
    elif command -v brew        >/dev/null 2>&1; then echo brew
    else echo unknown
    fi
}

pm_install() {
    local pkgs="$*"
    case "$(_pkg)" in
        pacman) sudo pacman -S --noconfirm $pkgs ;;
        apt)    sudo apt-get install -y $pkgs ;;
        dnf)    sudo dnf install -y $pkgs ;;
        yum)    sudo yum install -y $pkgs ;;
        zypper) sudo zypper install -y $pkgs ;;
        xbps)   sudo xbps-install -S $pkgs ;;
        apk)    sudo apk add $pkgs ;;
        emerge) sudo emerge $pkgs ;;
        brew)   brew install $pkgs ;;
        *)      echo "No supported package manager found"; return 1 ;;
    esac
}

pm_update() {
    case "$(_pkg)" in
        pacman) sudo pacman -Syu ;;
        apt)    sudo apt-get update && sudo apt-get upgrade -y ;;
        dnf)    sudo dnf upgrade -y ;;
        yum)    sudo yum update -y ;;
        zypper) sudo zypper refresh && sudo zypper update -y ;;
        xbps)   sudo xbps-install -Su ;;
        apk)    sudo apk update && sudo apk upgrade ;;
        emerge) sudo emerge --update --deep --newuse @world ;;
        brew)   brew update && brew upgrade ;;
        *)      echo "No supported package manager found" ;;
    esac
}

pm_search() {
    local term="$1"
    case "$(_pkg)" in
        pacman) pacman -Ss "$term" ;;
        apt)    apt-cache search "$term" ;;
        dnf)    dnf search "$term" ;;
        yum)    yum search "$term" ;;
        zypper) zypper search "$term" ;;
        xbps)   xbps-query -Rs "$term" ;;
        apk)    apk search "$term" ;;
        emerge) emerge -s "$term" ;;
        brew)   brew search "$term" ;;
        *)      echo "No supported package manager found" ;;
    esac
}

pm_remove() {
    local pkgs="$*"
    case "$(_pkg)" in
        pacman) sudo pacman -Rns $pkgs ;;
        apt)    sudo apt-get remove -y $pkgs ;;
        dnf)    sudo dnf remove -y $pkgs ;;
        yum)    sudo yum remove -y $pkgs ;;
        zypper) sudo zypper remove -y $pkgs ;;
        xbps)   sudo xbps-remove -R $pkgs ;;
        apk)    sudo apk del $pkgs ;;
        emerge) sudo emerge --unmerge $pkgs ;;
        brew)   brew uninstall $pkgs ;;
        *)      echo "No supported package manager found"; return 1 ;;
    esac
}

pm_list() {
    case "$(_pkg)" in
        pacman) pacman -Q ;;
        apt)    dpkg -l ;;
        dnf)    dnf list installed ;;
        yum)    yum list installed ;;
        zypper) zypper se --installed-only ;;
        xbps)   xbps-query -l ;;
        apk)    apk list --installed ;;
        emerge) equery list '*' ;;
        brew)   brew list ;;
        *)      echo "No supported package manager found" ;;
    esac
}

# Chaotic-AUR helpers (Arch only — NOT auto-executed)
chaotic_setup() {
    command -v pacman >/dev/null 2>&1 || { echo "Arch-only feature."; return 1; }
    grep -qE '^\[chaotic-aur\]' /etc/pacman.conf 2>/dev/null && { echo "Chaotic-AUR already configured."; return 0; }
    echo "Chaotic-AUR manual setup steps:"
    echo "  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com"
    echo "  sudo pacman-key --lsign-key 3056513887B78AEB"
    echo "  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'"
    echo "  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'"
    echo "  echo -e '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf"
    echo "  sudo pacman -Syu"
}

chaotic_install() {
    [[ -z "$1" ]] && { echo "Usage: chaotic_install <pkg>"; return 1; }
    if command -v yay &>/dev/null; then
        yay -S "chaotic-aur/$1"
    elif command -v paru &>/dev/null; then
        paru -S "chaotic-aur/$1"
    else
        sudo pacman -S "chaotic-aur/$1"
    fi
}

unset -f _pkg
