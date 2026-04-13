#!/usr/bin/env sh
# =============================================================================
# lib/system-detect.sh — OS / distro / package-manager detection
# Compatible with bash, zsh (sourced at startup).
# Sets: DOTFILES_OS  DOTFILES_DISTRO  DOTFILES_PKG  DOTFILES_IS_LAPTOP
# =============================================================================

# OS (Linux | Darwin | FreeBSD | …)
DOTFILES_OS="$(uname -s)"
export DOTFILES_OS

# Distro ID (arch | debian | ubuntu | fedora | … | macos | unknown)
if [ "$DOTFILES_OS" = "Darwin" ]; then
    DOTFILES_DISTRO="macos"
elif [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    DOTFILES_DISTRO="$(. /etc/os-release && echo "${ID:-unknown}")"
else
    DOTFILES_DISTRO="unknown"
fi
export DOTFILES_DISTRO

# Primary package manager
_detect_pkg() {
    if [ "$DOTFILES_OS" = "Darwin" ]; then
        command -v brew >/dev/null 2>&1 && { echo brew; return; }
        command -v port >/dev/null 2>&1 && { echo port; return; }
    else
        command -v pacman      >/dev/null 2>&1 && { echo pacman; return; }
        command -v apt-get     >/dev/null 2>&1 && { echo apt;    return; }
        command -v dnf         >/dev/null 2>&1 && { echo dnf;    return; }
        command -v yum         >/dev/null 2>&1 && { echo yum;    return; }
        command -v zypper      >/dev/null 2>&1 && { echo zypper; return; }
        command -v xbps-install>/dev/null 2>&1 && { echo xbps;   return; }
        command -v apk         >/dev/null 2>&1 && { echo apk;    return; }
        command -v emerge      >/dev/null 2>&1 && { echo emerge; return; }
        command -v nix-env     >/dev/null 2>&1 && { echo nix;    return; }
        command -v brew        >/dev/null 2>&1 && { echo brew;   return; }
    fi
    echo unknown
}
DOTFILES_PKG="$(_detect_pkg)"
export DOTFILES_PKG
unset -f _detect_pkg 2>/dev/null || true

# Laptop detection
DOTFILES_IS_LAPTOP=0
if [ -d /sys/class/power_supply/BAT0 ] || [ -d /sys/class/power_supply/BAT1 ]; then
    DOTFILES_IS_LAPTOP=1
elif [ "$DOTFILES_OS" = "Darwin" ]; then
    command -v pmset >/dev/null 2>&1 && \
        pmset -g batt 2>/dev/null | grep -q "InternalBattery" && \
        DOTFILES_IS_LAPTOP=1
fi
export DOTFILES_IS_LAPTOP

# Architecture
DOTFILES_ARCH="$(uname -m)"
export DOTFILES_ARCH
