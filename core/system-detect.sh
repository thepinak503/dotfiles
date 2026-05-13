#!/usr/bin/env sh
# =============================================================================
# System Detection Module
# =============================================================================
#
# Lightweight system detection that exports DOTFILES_OS, DOTFILES_DISTRO,
# DOTFILES_PKG, DOTFILES_IS_LAPTOP, and DOTFILES_ARCH at source time.
#
# Unlike os_detect.sh (which provides functions for lazy detection),
# this module detects everything immediately upon source and exports
# the results as environment variables. This trade-off means faster
# access (variables vs function calls) but slightly slower shell startup.
#
# Variables exported:
#   DOTFILES_OS        - uname -s output (Linux, Darwin, etc.)
#   DOTFILES_DISTRO    - Canonical distro name (arch, debian, macos, etc.)
#   DOTFILES_PKG       - Primary package manager
#   DOTFILES_IS_LAPTOP - 1 if running on a laptop, 0 otherwise
#   DOTFILES_ARCH      - Hardware architecture (x86_64, aarch64, etc.)
#
# Design principles:
#   - Immediate execution: all detection runs on source
#   - POSIX sh compatible
#   - Multiple fallback layers for distro detection
#   - Laptop detection via power supply sysfs
#
# Compatibility:
#   Works on: Linux (all distros), macOS
#   Shell: sh, bash, zsh, dash
#
# See also:
#   - core/os_detect.sh - Function-based detection (alternative)
#   - core/universal.sh - Extended detection (AUR helpers, etc.)
#   - core/battery.sh - Battery status functions (requires laptop detection)
#
# =============================================================================
# OS Detection
# =============================================================================
#
# Sets DOTFILES_OS from uname -s. This is the most basic detection and
# serves as the gateway for platform-specific logic throughout the
# dotfiles.
#
# Possible values:
#   Linux  - Any Linux distribution
#   Darwin - macOS
#   Other  - FreeBSD, Windows (Cygwin/MSYS2), etc.

DOTFILES_OS="$(uname -s)"
export DOTFILES_OS

# =============================================================================
# Distribution Detection
# =============================================================================
#
# Robust multi-method distribution detection with fallback chain:
#
#   1. Darwin (macOS) -> immediate "macos" return
#   2. /etc/os-release -> parsed ID field (POSIX . command)
#      This covers 99% of modern Linux installations
#   3. lsb_release -> LSB standard command (some distros)
#   4. /etc/lsb-release -> Legacy LSB file
#   5. /etc/debian_version -> Debian/Ubuntu legacy
#   6. /etc/redhat-release -> RHEL/Fedora legacy
#   7. Unknown -> "unknown"
#
# Features:
#   - Returns lowercase distro ID
#   - Detects macOS explicitly
#   - Falls back through 6 methods
#   - Never fails: worst case returns "unknown"
#
# Variables set:
#   DOTFILES_DISTRO - Canonical distro identifier

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

# =============================================================================
# Package Manager Detection
# =============================================================================
#
# Scans PATH for known package manager binaries and returns the first
# match. On macOS, Homebrew (brew) is checked first; on Linux, AUR
# helpers (yay, paru) are checked before system managers.
#
# Detection order:
#   macOS:   brew
#   Linux:   yay -> paru -> pacman -> apt-get -> dnf -> brew -> zypper
#            -> xbps-install -> apk
#
# Features:
#   - AUR helper detection (yay, paru) prioritized on Arch
#   - Homebrew detection on both Linux and macOS
#   - Returns immediately on first match (lowercase)
#   - Returns "unknown" if no manager found
#
# Variables set:
#   DOTFILES_PKG - Package manager name (lowercase)
#
# See also:
#   - core/universal.sh - _get_pkg_manager() with distro-based detection
#   - core/os_detect.sh - get_pkg_manager() with simpler detection
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

# =============================================================================
# Laptop Detection
# =============================================================================
#
# Determines if the current system is a laptop by checking for battery
# power supply entries in sysfs (/sys/class/power_supply/). This is a
# reliable indicator since desktop systems rarely have battery hardware.
#
# Detection methods:
#   Linux: Check for BAT0, BAT1, or "battery" in
#          /sys/class/power_supply/
#   macOS: Check pmset output for "InternalBattery"
#
# Features:
#   - Detects multiple battery device names (BAT0, BAT1, battery)
#   - Works on both Linux and macOS
#   - macOS uses pmset -g batt to find internal batteries
#
# Variables set:
#   DOTFILES_IS_LAPTOP - 1 if laptop, 0 if desktop/server/VM
#
# Usage in other scripts:
#   if [ "${DOTFILES_IS_LAPTOP:-0}" = "1" ]; then
#       echo "Running on battery power"
#   fi
#
# See also:
#   - core/battery.sh - Battery percentage and charging status
#   - /sys/class/power_supply/ - Linux power supply interface
#   - pmset(1) - macOS power management
DOTFILES_IS_LAPTOP=0
if [ -d /sys/class/power_supply/BAT0 ] || [ -d /sys/class/power_supply/BAT1 ] || [ -d /sys/class/power_supply/battery ]; then
    DOTFILES_IS_LAPTOP=1
elif [ "$DOTFILES_OS" = "Darwin" ]; then
    command -v pmset >/dev/null 2>&1 && pmset -g batt 2>/dev/null | grep -q "InternalBattery" && DOTFILES_IS_LAPTOP=1
fi
export DOTFILES_IS_LAPTOP

# =============================================================================
# Architecture Detection
# =============================================================================
#
# Captures the hardware architecture using uname -m. This is used for
# downloading the correct binary packages, configuring compilation
# flags, and system information display.
#
# Common values:
#   x86_64   - AMD64/Intel 64-bit (most modern systems)
#   aarch64  - ARM 64-bit (Apple Silicon, Raspberry Pi 4/5, servers)
#   armv7l   - ARM 32-bit (older Raspberry Pi, embedded)
#   i686     - Intel/AMD 32-bit (older/legacy systems)
#
# Variables set:
#   DOTFILES_ARCH - Architecture string from uname -m
#
# See also:
#   - uname(1) - System information command
#   - arch(1) - Machine architecture display
#   - DPkg::Architecture - Debian/Ubuntu architecture setting

DOTFILES_ARCH="$(uname -m)"
export DOTFILES_ARCH
