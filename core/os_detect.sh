#!/usr/bin/env sh
# =============================================================================
# OS/Distro Detection - Shared across all shells
# =============================================================================
#
# Provides portable OS and distribution detection functions that work
# across all POSIX shells (sh, bash, zsh, dash, etc.). These functions
# form the foundation of the dotfiles' cross-platform compatibility.
#
# Architecture:
#   The detection is a three-layer system:
#     1. detect_os()       - Kernel-level OS detection via uname
#     2. detect_distro()   - Distribution identification via /etc/os-release
#     3. get_pkg_manager() - Package manager resolution from distro
#     4. get_init_system() - Init system detection (/proc, /run)
#
# Variables referenced (must be set before calling):
#   _os     - Kernel type (linux, macos, windows, unknown)
#   _distro - Distribution type (arch, debian, fedora, etc.)
#
# Design principles:
#   - Uses POSIX sh syntax only (no bashisms)
#   - Minimal dependencies: uname, standard filesystem paths
#   - Fail-safe: returns "unknown" when detection fails
#   - Shell-agnostic: can be sourced by sh, bash, zsh, dash
#
# Compatibility:
#   Works on: Linux (all distros), macOS, Windows (Cygwin/MSYS2)
#   Shell: sh, bash, zsh, dash, ash
#
# See also:
#   - core/universal.sh - Additional detection functions
#   - core/system-detect.sh - Alternative detection with export
#   - uname(1) - System information command
#   - os-release(5) - /etc/os-release format
#
# =============================================================================
# Detection Variables and Setup
# =============================================================================
#
# Before calling the detection functions, _os must be set via detect_os.
# The functions use globals (_os, _distro) to avoid subshell overhead.
#
# Usage pattern:
#   _os=$(detect_os)
#   _distro=$(detect_distro)
#   _pkg=$(get_pkg_manager)
#
# All functions echo their result for command substitution.

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

# =============================================================================
# detect_distro - Distribution Identification
# =============================================================================
#
# Maps the operating system type to a canonical distribution name.
# For Linux, this reads /etc/os-release and matches the ID field against
# known distribution families. Falls back to legacy release files when
# /etc/os-release is not available.
#
# Detection priority:
#   1. Linux with /etc/os-release -> ID field matching
#   2. Linux with fallback files (/etc/arch-release, /etc/debian_version)
#   3. macOS -> "macos"
#   4. Other/unknown -> "unknown"
#
# Distribution families recognized:
#   arch    - Arch Linux, Artix, Manjaro, EndeavourOS, Garuda, ArchLabs
#   debian  - Debian, Ubuntu, Linux Mint, Pop!_OS, Elementary
#   fedora  - Fedora, CentOS, Stream, RHEL
#   suse    - openSUSE, SLES
#   void    - Void Linux
#   nix     - NixOS
#   gentoo  - Gentoo Linux
#   alpine  - Alpine Linux
#   other   - Any unrecognized ID (passthrough)
#   unknown - Detection failure
#
# Features:
#   - Maps 20+ distro IDs to 9 canonical families
#   - Graceful fallback chain when files are missing
#   - Returns raw ID for unrecognized distributions
#
# Returns:
#   Echoes canonical distro name to stdout
#
# Dependencies:
#   - detect_os() must be called first to set $_os
#   - Reads: /etc/os-release, /etc/arch-release, /etc/debian_version
#
# See also:
#   - detect_os() - Kernel detection (sets _os)
#   - /etc/os-release - freedesktop.org specification
#
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

# =============================================================================
# get_pkg_manager - Package Manager Resolution
# =============================================================================
#
# Determines the appropriate package manager for the detected distribution.
# Uses the distro family to prioritize the correct manager, with fallback
# to command -v detection for edge cases.
#
# Resolution by distro family:
#   arch    -> yay (AUR) > pacman
#   debian  -> apt > apt-get
#   fedora  -> dnf > yum
#   suse    -> zypper
#   void    -> xbps
#   nix     -> nix-env
#   gentoo  -> emerge
#   alpine  -> apk
#   macos   -> brew
#   others  -> "none"
#
# Features:
#   - AUR helper preferred on Arch (yay before pacman)
#   - MacPorts not checked (Homebrew is the default)
#   - Returns "none" when no manager is found
#
# Returns:
#   Echoes package manager name or "none"
#
# Dependencies:
#   - detect_distro() must be called first to set $_distro
#   - Uses command -v for PATH lookup
#
# See also:
#   - detect_distro() - Distro detection (sets _distro)
#   - core/universal.sh - Alternative _get_pkg_manager()
#   - core/system-detect.sh - Alternative _detect_pkg()
#
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

# =============================================================================
# get_init_system - Init/Service Manager Detection
# =============================================================================
#
# Identifies the init system used by the current Linux installation.
# This determines which service management commands are available
# (systemctl, service, rc-service, etc.).
#
# Detection methods (in priority order):
#   1. /run/systemd/system directory exists -> systemd
#   2. /sbin/init --version contains "systemd" -> systemd
#   3. /etc/init.d/cron exists -> sysv
#   4. /proc/1/comm content matching:
#      - systemd -> systemd
#      - init    -> sysv
#      - runit   -> runit (Void Linux)
#      - openrc  -> openrc (Gentoo, Artix)
#      - others  -> unknown
#
# Init systems detected:
#   systemd - Most modern Linux distributions
#   sysv    - Traditional SysV init (older/legacy systems)
#   runit   - Void Linux (also used by some containers)
#   openrc  - Gentoo, Artix, Alpine (older versions)
#   unknown - Detection failed or non-Linux system
#
# Features:
#   - Multiple detection methods for reliability
#   - /proc/1/comm parsing for direct PID 1 identification
#   - Does not require elevated privileges
#   - Returns immediately on first match
#
# Returns:
#   Echoes init system name: systemd, sysv, runit, openrc, or unknown
#
# Compatibility:
#   Works on: Linux systems with /proc mounted
#   Returns: "unknown" on macOS, BSD, and other non-Linux systems
#
# See also:
#   - init(1) - System initialization
#   - systemd(1) - systemd init system
#   - /proc/1/comm - Process 1 command name
#   - core/universal.sh - Alternative _get_init_system()
#
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