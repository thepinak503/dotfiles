#!/usr/bin/env sh
DOTFILES_OS="$(uname -s)"
export DOTFILES_OS

# Robust Distro Detection
_detect_distro() {
    if [ "$DOTFILES_OS" = "Darwin" ]; then
        echo "macos"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif type lsb_release >/dev/null 2>&1; then
        lsb_release -si | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo "$DISTRIB_ID" | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    else
        echo "unknown"
    fi
}
DOTFILES_DISTRO="$(_detect_distro)"
export DOTFILES_DISTRO

_detect_pkg() {
    if [ "$DOTFILES_OS" = "Darwin" ]; then
        command -v brew >/dev/null 2>&1 && { echo brew; return; }
    fi
    command -v yay         >/dev/null 2>&1 && { echo yay;    return; }
    command -v paru        >/dev/null 2>&1 && { echo paru;   return; }
    command -v pacman      >/dev/null 2>&1 && { echo pacman; return; }
    command -v apt-get     >/dev/null 2>&1 && { echo apt;    return; }
    command -v dnf         >/dev/null 2>&1 && { echo dnf;    return; }
    command -v brew        >/dev/null 2>&1 && { echo brew;   return; }
    command -v zypper      >/dev/null 2>&1 && { echo zypper; return; }
    command -v xbps-install>/dev/null 2>&1 && { echo xbps;   return; }
    command -v apk         >/dev/null 2>&1 && { echo apk;    return; }
    echo unknown
}
DOTFILES_PKG="$(_detect_pkg)"
export DOTFILES_PKG

# Laptop Detection
DOTFILES_IS_LAPTOP=0
if [ -d /sys/class/power_supply/BAT0 ] || [ -d /sys/class/power_supply/BAT1 ] || [ -d /sys/class/power_supply/battery ]; then
    DOTFILES_IS_LAPTOP=1
elif [ "$DOTFILES_OS" = "Darwin" ]; then
    command -v pmset >/dev/null 2>&1 && pmset -g batt 2>/dev/null | grep -q "InternalBattery" && DOTFILES_IS_LAPTOP=1
fi
export DOTFILES_IS_LAPTOP

DOTFILES_ARCH="$(uname -m)"
export DOTFILES_ARCH
