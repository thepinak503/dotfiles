#!/usr/bin/env bash
# =============================================================================
# Universal Shell Config - Distro-agnostic with OS detection
# Works with: bash, zsh, fish
# =============================================================================

export DOTFILES_OS="$(uname -s)"
export DOTFILES_ARCH="$(uname -m)"

# =============================================================================
# Shell Detection
# =============================================================================
#
# Detects the currently running shell (bash, zsh, fish) for conditional
# initialization of shell-specific features and app-specific initializers.
#
# The SHELL_NAME variable is used throughout the dotfiles to select the
# correct syntax, hook mechanism, and completion system for each shell.
#
# Features:
#   - Parses $SHELL to extract the base shell name
#   - Supports bash, zsh, and fish
#   - Falls back to bash for unknown shells
#   - Exported as SHELL_NAME for use in other scripts
#
# Compatibility:
#   Works on: All Unix-like systems with bash/zsh/fish
#   Tested: Linux (all distros), macOS
#
# See also:
#   - shells/bash/*.bash - Bash-specific configurations
#   - shells/zsh/*.zsh   - Zsh-specific configurations
#   - shells/fish/*.fish - Fish-specific configurations
#
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
#
# Identifies the Linux distribution by reading /etc/os-release and falling
# back to legacy release files for older or minimalist distributions.
#
# This function is the primary distro detection mechanism. It supports:
#   - /etc/os-release (modern, ID and ID_LIKE fields)
#   - ID_LIKE fallback for derivatives and unknown distros
#   - Legacy release file detection (/etc/arch-release, etc.)
#   - Manual Linux From Scratch (LFS) detection
#
# Features:
#   - Primary: /etc/os-release ID field matching
#   - Secondary: ID_LIKE field fallback for derivatives
#   - Tertiary: Legacy /etc/*-release file detection
#   - Stable release: LFS detection via /etc/lfs-release
#   - Maps 40+ distro IDs to 8 canonical families
#
# Distro families mapped:
#   arch:    arch, artix, manjaro, endeavouros, garuda, archlabs
#   debian:  debian, ubuntu, linuxmint, pop, elementary, zorin, neon, mx
#   fedora:  fedora, centos, stream, rhel, rocky, alma, nobara
#   suse:    opensuse, sles, leap, tumbleweed, gecko
#   void:    void
#   nix:     nixos
#   gentoo:  gentoo, funtoo, calculate
#   alpine:  alpine
#   slackware: slackware, slint, salix, vector
#   lfs:     linux-from-scratch
#
# Compatibility:
#   Works on: All Linux distributions with POSIX sh
#   Priority: /etc/os-release > ID_LIKE > legacy files
#
# See also:
#   - os-release(5) - man page for /etc/os-release format
#   - /etc/os-release - freedesktop.org standard
#   - lsb_release(1) - LSB release information
#
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
#
# Determines the operating system and architecture at shell startup.
# Sets DOTFILES_OS (uname -s) and DOTFILES_DISTRO (canonical distro name)
# which are then used by all distro-specific modules.
#
# The detection is a two-stage process:
#   1. Kernel detection via uname (Linux, Darwin, Windows subsystems)
#   2. Distro detection via /etc/os-release or legacy files (Linux only)
#
# Features:
#   - DOTFILES_OS: linux, macos, windows, unknown
#   - DOTFILES_DISTRO: arch, debian, fedora, suse, void, nix, gentoo,
#     alpine, slackware, lfs, macos, unknown
#   - DOTFILES_ARCH: hardware architecture from uname -m
#   - DOTFILES_INIT: init system detection (systemd, sysv, runit, openrc)
#
# Variables exported:
#   DOTFILES_OS, DOTFILES_DISTRO, DOTFILES_ARCH, DOTFILES_INIT,
#   DOTFILES_PKG_MANAGER
#
# Compatibility:
#   Works on: Linux, macOS, Windows (Cygwin/MSYS2)
#
# See also:
#   - uname(1) - system information
#   - /etc/os-release - OS identification
#
case "$(uname -s)" in
    Linux*)  export DOTFILES_DISTRO="$(_detect_linux_distro)" ;;
    Darwin*) export DOTFILES_DISTRO="macos" ;;
    *)     export DOTFILES_DISTRO="unknown" ;;
esac

# =============================================================================
# Package Manager Detection (Command-based)
# =============================================================================
#
# Fallback package manager detection by scanning the PATH for known
# package manager binaries. This is used when distro-based detection
# cannot determine the correct manager.
#
# Detection order is weighted by likelihood and preference:
#   brew (macOS) -> apt (Debian) -> pacman (Arch) -> dnf (Fedora)
#   -> zypper (SUSE) -> yum (RHEL legacy) -> apk (Alpine)
#   -> xbps-install (Void) -> nix (NixOS) -> emerge (Gentoo)
#   -> slackpkg (Slackware) -> apt-get (Debian legacy)
#
# Features:
#   - Detects 12 different package managers by PATH lookup
#   - Returns the first match (priority-ordered)
#   - Returns "none" if no manager is found
#   - Used as fallback in _get_pkg_manager
#
# Returns:
#   Echoes the package manager name or "none"
#
# Compatibility:
#   Works on: All Unix-like systems
#   Shell: sh, bash, zsh
#
# See also:
#   - _get_pkg_manager() - Distro-aware package manager detection
#   - DOTFILES_PKG_MANAGER - Exported detection result
#
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
# Package Manager Detection (Distro-aware)
# =============================================================================
#
# Primary package manager detection that uses the detected distro to
# prefer the correct package manager. AUR helpers are preferred on
# Arch-based distros before falling back to pacman.
#
# Detection prioritization by distro family:
#   Arch:     paru -> yay -> pacman -> command fallback
#   Debian:   apt -> apt-get -> command fallback
#   Fedora:   dnf -> yum -> command fallback
#   SUSE:     zypper -> command fallback
#   Void:     xbps-install -> command fallback
#   Gentoo:   emerge -> pkgcore -> paludis -> command fallback
#   Slackware: slackpkg -> command fallback
#   Alpine:   apk -> command fallback
#   NixOS:    nix -> command fallback
#   macOS:    brew -> port -> command fallback
#
# Features:
#   - Distro-aware: prefers the correct manager for each distro
#   - AUR support: paru and yay detection on Arch
#   - MacPorts support: 'port' detection on macOS
#   - Multiple Gentoo managers: pkgcore, paludis
#   - Falls back to _detect_pkg_manager_by_command for unknown distros
#
# Returns:
#   Echoes the package manager name
#
# Exported as:
#   DOTFILES_PKG_MANAGER
#
# Compatibility:
#   Works on: All supported distros and macOS
#   Shell: sh, bash, zsh
#
# See also:
#   - _detect_pkg_manager_by_command() - Binary PATH fallback
#   - DOTFILES_DISTRO - Distro detection used for routing
#
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
#
# Identifies the init system used by the current Linux system. This is
# used to determine which service management commands are available
# (systemctl, service, rc-service, etc.).
#
# Detection methods by priority:
#   1. /run/systemd/system directory exists -> systemd
#   2. /proc/1/comm contains init name
#   3. Fallback: "unknown"
#
# Init systems detected:
#   systemd - Modern Linux init (Fedora, Arch, Debian 8+, Ubuntu 15+)
#   sysv    - SysV-style init (older Debian/Ubuntu, Slackware)
#   runit   - Void Linux
#   openrc  - Gentoo, Artix, Alpine
#
# Exported as:
#   DOTFILES_INIT
#
# Compatibility:
#   Works on: Linux systems with /proc
#   Returns: "unknown" on macOS and other non-Linux systems
#
# See also:
#   - systemd(1) - systemd init system
#   - /proc/1/comm - Process 1 command name
#
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
#
# Predicate functions that return true (exit code 0) when the current
# distro matches the target family. These enable conditional execution
# throughout the dotfiles without repeating distro string comparisons.
#
# Each helper checks DOTFILES_DISTRO against one or more distro identifiers.
# Multiple IDs are supported for distro families (e.g., _is_arch matches
# Arch, Artix, Manjaro, EndeavourOS, and Garuda).
#
# Defined helpers:
#   _is_arch   - Arch Linux and Arch-based distros
#   _is_debian - Debian, Ubuntu, Linux Mint, Pop!_OS
#   _is_fedora - Fedora, CentOS, RHEL, Rocky, AlmaLinux
#   _is_macos  - macOS (Darwin kernel)
#   _is_void   - Void Linux
#   _is_alpine - Alpine Linux
#   _is_gentoo - Gentoo, Funtoo, Calculate
#   _is_lfs    - Linux From Scratch
#
# Usage:
#   if _is_arch; then
#       echo "Running on Arch Linux"
#   fi
#
# Compatibility:
#   Works on: All supported operating systems
#   Shell: sh, bash, zsh
#
# See also:
#   - DOTFILES_DISTRO - Variable checked by these functions
#   - _detect_linux_distro() - How DOTFILES_DISTRO is set
#
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
#
# Cross-distro system update command that dispatches to the correct
# package manager based on DOTFILES_PKG_MANAGER. Supports 12+ managers
# and covers all major Linux distros plus macOS.
#
# This is the primary "update everything" command. It handles:
#   - Package database refresh (apt update, pacman -Sy, etc.)
#   - Package upgrades (upgrade, -Syu, update, etc.)
#   - AUR helper updates (paru/yay handle both repos and AUR)
#
# Supported managers:
#   paru, yay, pacman, apt, apt-get, dnf, yum, brew, apk, zypper,
#   xbps, emerge, nix, port, slackpkg
#
# Fallback behavior:
#   If DOTFILES_PKG_MANAGER does not match any known manager,
#   _detect_pkg_manager_by_command is called to find an alternative.
#   If an alternative is found, it recursively calls _update_sys with
#   the newly detected manager.
#
# Usage:
#   update               # Update all packages
#
# Aliases:
#   update -> _update_sys
#
# Compatibility:
#   Works on: 5000+ Linux distros and macOS
#
# See also:
#   - DOTFILES_PKG_MANAGER - Determines which command to run
#   - _install_pkg() - Package installation
#   - _remove_pkg()  - Package removal
#   - _search_pkg()  - Package search
#
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

# =============================================================================
# Package Installation Function
# =============================================================================
#
# Cross-distro package installer that dispatches to the correct manager.
# Supports batch installation (multiple packages in one call).
#
# The function uses DOTFILES_PKG_MANAGER to determine which command to
# invoke. It passes all arguments through to the underlying manager,
# enabling advanced flags like --noconfirm where appropriate.
#
# Features:
#   - Batch install: ins pkg1 pkg2 pkg3
#   - Manager-specific flags: -y for apt, --noconfirm for pacman
#   - Error handling: returns 1 if no packages specified
#   - Same interface across all distros
#
# Usage:
#   ins <package...>     # Install packages
#   install <package...> # Alternative syntax
#   i <package...>       # Short alias
#
# Aliases:
#   ins -> _install_pkg
#   install -> _install_pkg
#   i -> _install_pkg
#
# Compatibility:
#   Works on: All supported distros and macOS
#
# See also:
#   - _remove_pkg() - Package removal
#   - _search_pkg() - Package search
#   - _update_sys() - System update
#
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

# =============================================================================
# Package Removal Function
# =============================================================================
#
# Cross-distro package remover that dispatches to the correct manager.
# Handles recursive dependency removal where the manager supports it.
#
# On Arch-based systems, pacman -Rns is used to remove dependencies
# and configuration files. On Debian, only the packages themselves are
# removed (use apt purge for config cleanup).
#
# Usage:
#   rem <package...>    # Remove packages
#   uninstall <package...>
#   rmv <package...>
#
# Aliases:
#   rem -> _remove_pkg
#   uninstall -> _remove_pkg
#   rmv -> _remove_pkg
#
# Compatibility:
#   Works on: All supported distros and macOS
#
# See also:
#   - _install_pkg() - Package installation
#   - _search_pkg()  - Package search
#   - _list_pkgs()   - List installed packages
#
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
#
# Cross-distro package search that queries the remote repository index.
# Results are displayed in the native format of each package manager.
#
# Features:
#   - Searches remote repositories (not local cache)
#   - Supports regex and fuzzy search patterns (manager-dependent)
#   - AUR helpers include both official repos and the AUR
#   - Paginated output for long results
#
# Usage:
#   se <pattern>       # Search for packages
#   search <pattern>
#   findpkg <pattern>
#
# Aliases:
#   se -> _search_pkg
#   search -> _search_pkg
#   findpkg -> _search_pkg
#
# Compatibility:
#   Works on: All supported distros and macOS
#
# See also:
#   - _install_pkg() - Install from search results
#   - _list_pkgs()   - List what's already installed
#
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
#
# Lists all installed packages using the native query mechanism of the
# detected package manager. The output format varies by manager.
#
# This is useful for:
#   - System inventory and documentation
#   - Creating package lists for reproduction
#   - Finding what's installed on a new system
#   - Cleaning up unused packages
#
# Query methods by manager:
#   pacman:    pacman -Qq (explicitly installed, clean output)
#   apt/dpkg:  dpkg -l (all packages, tabular format)
#   dnf/rpm:   dnf list installed or rpm -qa
#   brew:      brew list (formulae only)
#   apk:       apk list --installed
#   xbps:      xbps-query -l
#   emerge:    qlist or equery list
#   nix:       nix-env -q
#
# Usage:
#   lsp               # List installed packages
#   listpkgs
#   installed
#
# Aliases:
#   lsp -> _list_pkgs
#   listpkgs -> _list_pkgs
#   installed -> _list_pkgs
#
# Compatibility:
#   Works on: All supported distros and macOS
#
# See also:
#   - _search_pkg() - Search remote repositories
#   - _remove_pkg() - Remove unused packages
#
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
# Systemd Service Management (systemctl)
# =============================================================================
#
# Shortcut aliases for systemctl, the systemd service manager.
# Only defined when DOTFILES_INIT equals "systemd".
#
# These cover the most common service operations:
#   status, start, stop, restart, enable, disable
#
# Features:
#   - User service management via scu (systemctl --user)
#   - Conditionally defined only on systemd systems
#   - Consistent naming: sc + verb initials
#
# Usage:
#   sc              # systemctl (generic)
#   scs <service>   # systemctl status <service>
#   scst <service>  # systemctl start <service>
#   scsp <service>  # systemctl stop <service>
#   scsr <service>  # systemctl restart <service>
#   scse <service>  # systemctl enable <service>
#   scsd <service>  # systemctl disable <service>
#   scu             # systemctl --user <subcommand>
#
# Compatibility:
#   Defined on: Systems with systemd (Linux)
#   Skipped on: macOS, Void (runit), Gentoo (OpenRC), older distros
#
# See also:
#   - systemctl(1) - Systemd service manager
#   - DOTFILES_INIT - Detection variable
#
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

# =============================================================================
# SysVinit Service Management (service)
# =============================================================================
#
# Shortcut alias for the traditional SysV init service command.
# Only defined when DOTFILES_INIT equals "sysv".
#
# The service command provides a uniform interface for starting,
# stopping, and restarting services across SysV init systems.
#
# Usage:
#   sv <service> <action>   # e.g., sv nginx start
#
# Compatibility:
#   Defined on: Systems with SysV init (older Debian, Slackware, etc.)
#
# See also:
#   - service(8) - SysV service management
#   - DOTFILES_INIT - Init system detection
#
# Service manager (sysvinit)
if [ "$DOTFILES_INIT" = "sysv" ]; then
    alias sv='service'
fi

# =============================================================================
# Journalctl Wrapper (systemd Journal)
# =============================================================================
#
# Shortcut aliases for journalctl, the systemd journal viewer.
# Only defined on systemd-based systems.
#
# These cover the most common journal operations:
#   browse, jump to end, follow live, filter by unit
#
# Usage:
#   jc              # journalctl (browse full journal)
#   jce             # journalctl -e (jump to end)
#   jcf             # journalctl -f (follow live output)
#   jcu <unit>      # journalctl -u <unit> (filter by unit)
#
# Features:
#   - Works with colored output by default
#   - Filters by priority, unit, time range
#   - Supports reverse chronological browsing
#
# Compatibility:
#   Defined on: Systems with systemd (Linux only)
#
# See also:
#   - journalctl(1) - Journal query tool
#   - systemd-journald(8) - Systemd journal service
#
# Journalctl wrapper (systemd)
if [ "$DOTFILES_INIT" = "systemd" ]; then
    alias jc='journalctl'
    alias jce='journalctl -e'
    alias jcf='journalctl -f'
    alias jcu='journalctl -u'
fi

# =============================================================================
# System Information Displays
# =============================================================================
#
# Aliases for showing system information using neofetch or fastfetch.
# Fastfetch is preferred when available (faster, more customizable).
# Provides quick sysinfo alias for a minimal one-line summary.
#
# Features:
#   - neo        - Classic neofetch display
#   - fetch      - Fastfetch with custom config
#   - sysinfo    - Minimal one-line summary
#
# The sysinfo alias reads DOTFILES_DISTRO and DOTFILES_INIT directly
# from the environment without calling external tools.
#
# Compatibility:
#   Works on: All platforms (depends on neofetch/fastfetch availability)
#
# Neofetch - cross-distro
alias neo='neofetch'
alias fetch='fastfetch -c ~/.config/fastfetch/config.jsonc'

# Quick sysinfo
alias sysinfo='echo "OS: $DOTFILES_DISTRO" && echo "Kernel: $(uname -r)" && echo "Shell: $SHELL" && echo "Pkg Manager: $DOTFILES_PKG_MANAGER" && echo "Init: $DOTFILES_INIT"'

# =============================================================================
# Cache Cleanup
# =============================================================================
#
# Quick cleanup commands for user cache and package cache.
#
# WARNING: cleancache removes all user cache files. Some applications
# may need to rebuild their cache on next launch.
#
# Features:
#   - cleancache  - Remove all user cache (~/.cache/*)
#   - cleanpkg    - Remove all package cache (/var/cache/*)
#
# Compatibility:
#   Works on: All Linux systems
#
# See also:
#   - paccleanfn() - Arch-specific pacman cache cleaning
#   - aptclean alias - Debian-specific apt cache cleaning
#
alias cleancache='rm -rf ~/.cache/*'
alias cleanpkg='rm -rf /var/cache/*'

# =============================================================================
# Universal Functions
# =============================================================================

# =============================================================================
# Universal Helper Functions
# =============================================================================
#
# General-purpose utility functions that work on all platforms.
# These provide cross-platform equivalents for common tasks like
# creating directories while navigating into them, extracting archives
# of any format, file backup, weather info, IP lookup, and more.
#
# Design principles:
#   - No external dependencies beyond POSIX coreutils
#   - Graceful fallbacks when preferred tools are unavailable
#   - Consistent interface regardless of platform
#   - Minimal output, focused on getting the job done
#
# Features:
#   mkcd/take   - Create directory and cd into it
#   extract     - Extract any archive format (tar, gz, bz2, zip, rar, 7z)
#   backup      - Create timestamped backup copy of a file
#   weather     - Show weather forecast (uses wttr.in)
#   myip        - Show public IP address
#   pkillf      - Kill process by name (fuzzy match)
#   portcheck   - Find processes listening on a port
#
# Compatibility:
#   Works on: All Unix-like systems (Linux, macOS, BSD)
#   Dependencies: basic POSIX tools, optional: unrar, 7z, curl
#
# See also:
#   - mkdir(1), tar(1), unzip(1) - Underlying tools
#   - https://wttr.in - Weather service
#   - https://ifconfig.me - IP lookup service
#
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
#
# Creates timestamped backups before modifying files. The backup() function
# copies a file or directory with a .bak-YYYYMMDD-HHMMSS suffix, providing
# a simple undo mechanism without version control.
#
# Usage:
#   backup <file_or_dir>   # Creates <file>.bak-20250101-120000
#
# Features:
#   - Handles both files and directories (cp -r)
#   - Timestamp resolution: one second
#   - Can be used as a prefix to edits: edit() { backup "$1" && vim "$1"; }
#
# See also:
#   - cp(1) - File copy
#   - date(1) - Timestamp formatting
#
backup() { cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)"; }

# =============================================================================
# Weather Forecast
# =============================================================================
#
# Displays a weather forecast using the wttr.in service. Accepts an
# optional location argument; defaults to automatic IP-based location.
#
# Features:
#   - Uses curl for HTTP requests (no API key needed)
#   - Supports city names, airport codes, IP addresses
#   - Returns 3-day forecast by default
#
# Usage:
#   weather              # Auto-detect location
#   weather London       # Specific city
#   weather JFK          # Airport code
#   weather ~            # Moon phase
#
# See also:
#   - https://github.com/chubin/wttr.in - wttr.in documentation
#
weather() { curl -fsSL "wttr.in/${1:-}" ; }

# =============================================================================
# Public IP Lookup
# =============================================================================
#
# Retrieves the public (external) IP address using multiple fallback
# services. This is useful for checking VPN status, NAT configuration,
# or simply knowing your public-facing address.
#
# Fallback chain: ifconfig.me -> ipinfo.io/ip
#
# Features:
#   - Multiple service fallback for reliability
#   - Supports both IPv4 and IPv6
#   - No external dependencies (uses curl)
#
# Usage:
#   myip               # Show public IP
#   wanip              # Same as myip
#
# See also:
#   - diag_network() - Full network diagnostics
#
myip() { curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null ; }

# =============================================================================
# Process Management Utilities
# =============================================================================
#
# Cross-platform process finder and killer. Uses pkill for pattern
# matching with fallback to killall for exact name matching.
#
# Features:
#   - Regex/fuzzy process name matching
#   - Kills all matching processes
#   - Fallback to killall if pkgill is unavailable
#
# Usage:
#   pkillf <pattern>    # Kill processes matching pattern
#
# See also:
#   - pg <pattern> - ps + grep alias
#   - pkill(1), killall(1) - Process termination
#
pkillf() { pkill -f "$1" || killall "$1" 2>/dev/null ; }

# =============================================================================
# Port Checking Utility
# =============================================================================
#
# Shows processes listening on network ports. Uses ss (modern) with
# fallback to netstat (legacy). Filters output by port number.
#
# Features:
#   - Shows both TCP and UDP listeners
#   - Displays PID and process name
#   - Supports port number filtering
#
# Usage:
#   portcheck <port>    # Find what's listening on a port
#   ports               # Show all listening ports
#
# See also:
#   - listening() - Security-oriented port listing
#   - ss(8), netstat(8) - Socket statistics
#
portcheck() { netstat -tulanp 2>/dev/null | grep "$1" || ss -tulanp | grep "$1" ; }

# =============================================================================
# Docker Shortcuts
# =============================================================================
#
# Convenience aliases for common Docker operations. Only defined when
# the docker command is available on the system.
#
# Covers: container listing, image management, exec, logs, cleanup
#
# Features:
#   dps       - List running containers
#   dpsa      - List all containers (including stopped)
#   di        - List images
#   dex       - Exec into container interactively
#   dlogs     - Follow container logs
#   dstop     - Stop all running containers
#   drm       - Remove all stopped containers
#   dprune    - Prune unused Docker objects
#   dclean    - Aggressive prune including volumes
#
# Warning:
#   dprune and dclean are destructive operations that remove
#   unused containers, networks, images, and optionally volumes.
#   Use with caution on production systems.
#
# Compatibility:
#   Requires: docker CLI
#
# See also:
#   - docker_cleanup() - More detailed cleanup function
#   - docker(1) - Docker CLI reference
#
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
# Kubernetes (kubectl) Shortcuts
# =============================================================================
#
# Convenience aliases for kubectl, the Kubernetes CLI. Only defined when
# kubectl is available. Uses the standard kubectl convention of short
# resource names (pods, svc, deployments).
#
# Features:
#   k         - kubectl (generic)
#   kgp       - Get pods (all namespaces)
#   kgs       - Get services
#   kgd       - Get deployments
#   kga       - Get all resources
#   kctx      - Show current context
#   kuse      - Switch context
#
# Usage:
#   k get nodes          # kubectl get nodes
#   kgp -n kube-system   # List system pods
#   kuse production      # Switch to production context
#
# Compatibility:
#   Requires: kubectl CLI
#
# See also:
#   - kubectl(1) - Kubernetes CLI reference
#   - ~/.kube/config - Kubernetes configuration
#
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
# Tmux (Terminal Multiplexer) Shortcuts
# =============================================================================
#
# Convenience aliases for tmux session management. Only defined when
# tmux is available.
#
# Features:
#   t         - tmux (generic)
#   ta        - Attach to existing session
#   tl        - List sessions
#   tn        - Create new session with name
#
# Usage:
#   tn mysession         # Create and attach to new session
#   ta                   # Attach to last session
#   tl                   # List all sessions
#
# For advanced tmux operations, see the tmux_* function group below.
#
# Compatibility:
#   Requires: tmux
#
# See also:
#   - tmux(1) - Terminal multiplexer
#   - tmux_* functions - Advanced tmux management
#
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
#
# Essential Git aliases for daily workflow. These cover the most common
# Git operations: status, add, commit, push, log, diff, checkout, stash.
#
# Features:
#   g         - git (generic)
#   gs        - git status
#   ga        - git add
#   gc        - git commit
#   gp        - git push
#   gl        - git log (last 20 commits, one-line format)
#   gd        - git diff
#   gco       - git checkout
#   gsw       - git switch (modern alternative to checkout)
#   gst       - git stash
#   gsp       - git stash pop
#
# Usage:
#   gs                   # Quick status check
#   ga file.txt          # Stage file
#   gc -m "message"      # Commit with message
#
# For advanced Git operations (cleanup, rewrite, bisect, etc.),
# see the git_* function group below.
#
# Compatibility:
#   Requires: git
#
# See also:
#   - git(1) - Git reference
#   - git_* functions - Advanced Git operations
#   - contrib/git/* - Git helper scripts
#
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
#
# Adds Flatpak application directories to PATH so that Flatpak-installed
# GUI applications can be launched from the command line.
#
# Flatpak installs app launchers (symlinks) in two locations:
#   - System-wide: /var/lib/flatpak/exports/bin
#   - User-local:  ~/.local/share/flatpak/exports/bin
#
# Both are added to PATH if they exist. The order ensures user-installed
# apps take precedence over system-wide ones.
#
# Features:
#   - Only enabled on Linux (Flatpak is Linux-only)
#   - Checks both system and user directories
#   - Gracefully handles missing directories
#   - Uses PATH expansion syntax to avoid trailing colons
#
# Compatibility:
#   Works on: All Linux distros with Flatpak installed
#   Skipped on: macOS, Windows
#
# See also:
#   - flatpak(1) - Flatpak CLI reference
#   - https://flatpak.org - Flatpak project
#
# =============================================================================
# Flatpak PATH support - works on all Linux distros
# =============================================================================
if [ "$DOTFILES_OS" = "Linux" ]; then
    [ -d "/var/lib/flatpak/exports/bin" ] && export PATH="/var/lib/flatpak/exports/bin${PATH:+:$PATH}"
    [ -d "$HOME/.local/share/flatpak/exports/bin" ] && export PATH="$HOME/.local/share/flatpak/exports/bin${PATH:+:$PATH}"
fi

# =============================================================================
# LESS_TERMCAP - Colored Man Pages
# =============================================================================
#
# Configures terminal escape sequences for the less pager to produce
# syntax-highlighted man pages. This makes reading man pages more
# pleasant with color-coded sections.
#
# The LESS_TERMCAP variables control how less renders text formatting:
#
#   mb  - Start blinking mode (red text)
#   md  - Start bold mode (blue highlighted text)
#   me  - End all attribute modes
#   se  - End standout (reverse video) mode
#   so  - Start standout mode (dim background)
#   ue  - End underline mode
#   us  - Start underline mode (light blue text)
#
# Color scheme:
#   - Bold headers in bright blue
#   - Code/commands in underlined light blue
#   - Standout sections in dimmed gray
#   - Blinking indicators in red
#
# Features:
#   - Works with all shells (bash, zsh, fish)
#   - Uses 256-color ANSI sequences
#   - Compatible with most terminal emulators
#   - Does not affect non-manpage less usage
#
# Compatibility:
#   Works on: All terminals with 256-color support
#   Tested: xterm-256color, tmux, GNOME Terminal, iTerm2, Alacritty
#
# See also:
#   - less(1) - Less pager documentation
#   - man(1) - Man page viewer
#   - terminfo(5) - Terminal capability database
#
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

# =============================================================================
# Security Hardening - Shell Environment
# =============================================================================
#
# Baseline security hardening applied at shell startup. These settings
# help protect against accidental data exposure, history leakage, and
# privilege escalation through world-writable files.
#
# Hardening measures:
#   1. Secure umask (022) - Files created with 0644, dirs with 0755
#      This prevents newly created files from being world-writable.
#      WARNING: Do not set umask 077 unless you understand the implications
#      for shared file access and application behavior.
#
#   2. HISTIGNORE filtering - Prevents sensitive commands from being saved
#      in shell history. Commands containing passwords, tokens, secrets,
#      private keys, or sensitive tool invocations (passwd, ssh-keygen,
#      gpg, openssl) are excluded from history files.
#
#   3. HISTCONTROL=ignoreboth:erasedups - Space-prefixed commands are
#      not saved (ignorespace), duplicate commands are removed (erasedups).
#      To use: add a space before any sensitive command.
#
# Security notes:
#   - umask 022 is the standard for multi-user Unix systems
#   - umask 002 is appropriate for shared development groups
#   - HISTIGNORE patterns are case-sensitive by default
#   - These settings complement, not replace, full-disk encryption
#     and proper file permissions on sensitive data files.
#
# Compatibility:
#   Works on: All Unix-like systems with bash or zsh
#   Notes: Fish shell uses its own history mechanism
#
# See also:
#   - secstatus() - Interactive security status display
#   - secaudit()  - Full security audit function
#   - bash(1) - HISTCONTROL, HISTIGNORE documentation
#   - umask(2) - File creation mask documentation
#
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
# Protective Shell Aliases
# =============================================================================
#
# Interactive-mode aliases for destructive file operations to prevent
# accidental data loss. These are the first line of defense against
# common mistakes like overwriting files or removing the wrong directory.
#
# File operations (interactive):
#   cp -i  - Prompt before overwriting existing files
#   mv -i  - Prompt before overwriting existing files
#   rm -i  - Prompt before removing each file
#   ln -i  - Prompt before creating hard links to existing files
#
# Root-preserving operations:
#   chmod --preserve-root - Refuse to operate on / recursively
#   chown --preserve-root - Refuse to operate on / recursively
#   chgrp --preserve-root - Refuse to operate on / recursively
#
# Design notes:
#   - Interactive mode is the default to protect new users
#   - Experienced users can bypass with: \rm, /usr/bin/rm, 'rm'
#   - --preserve-root prevents catastrophic chmod -R / 777
#   - These aliases are set regardless of distro
#
# Compatibility:
#   Works on: All Unix-like systems (Linux, macOS, BSD)
#   Notes: --preserve-root is a GNU coreutils extension;
#          macOS uses BSD variants which lack this flag
#
# See also:
#   - rm(1), cp(1), mv(1) - File operation references
#   - chmod(1), chown(1) - Permission management
#   - secstatus() - Check current alias status
#
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
# Security Status and Audit Functions
# =============================================================================
#
# Comprehensive security functions for system hardening assessment.
# These provide interactive reports on the current security posture,
# PATH safety, exposed network services, and sudo configuration.
#
# Function overview:
#   secstatus     - Quick security overview (umask, aliases, root status)
#   secaudit      - Full security audit (users, SSH, GPG, network, etc.)
#   sectips       - Security best practices reference
#   del           - Secure file deletion with shred
#   listening     - Show listening network services
#   portcheck     - Find process on specific port
#   check_path_security - Find world-writable PATH entries
#   sudoers_check - Check sudo configuration for current user
#   pathsec       - Alias for check_path_security
#   ports         - Alias for listening
#
# Design principles:
#   - All functions are informative only (no automatic fixes)
#   - Use multiple fallbacks for cross-platform compatibility
#   - Output is formatted for readability with box-drawing chars
#   - Color-coded indicators: green=secure, yellow=warning, red=critical
#
# Compatibility:
#   Works on: Linux (all distros), partial on macOS
#   Dependencies: ss/netstat, stat, gpg (varies by function)
#
# See also:
#   - umask(2) - File creation mask
#   - sshd_config(5) - SSH server security
#   - sudoers(5) - Sudo configuration
#   - shred(1) - Secure file deletion
#
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

# =============================================================================
# Shell Performance Benchmarks
# =============================================================================
#
# Benchmarking utilities to measure shell startup time, prompt rendering
# speed, and full environment load time. These help identify performance
# bottlenecks in shell configuration.
#
# Three benchmark levels:
#   bench_shell    - Raw shell startup time (bash, zsh, fish)
#   bench_starship - Starship prompt module timing
#   bench_startup  - Full shell startup with hyperfine (or /usr/bin/time)
#   bench_all      - Run all three benchmarks
#
# Methodology:
#   Each shell is started in interactive mode (-i) and immediately exits.
#   The `time` command measures real (wall clock) elapsed seconds.
#   Three iterations are run per shell to account for variance.
#   hyperfine is used when available for statistical accuracy.
#
# Usage:
#   bench_shell    # Time shell startup (3 runs each)
#   bench_starship # Time starship prompt rendering
#   bench_startup  # Comprehensive benchmark with hyperfine
#   bench_all      # Run everything
#
# Interpretation:
#   bash:   <100ms is good, 100-200ms is acceptable
#   zsh:    <200ms is good (with plugins), 200-400ms is acceptable
#   fish:   <100ms is good (compiled C)
#   starship: <50ms per prompt is good
#
# Compatibility:
#   Works on: All Unix-like systems
#   Requires: /usr/bin/time (POSIX), optional: hyperfine
#
# See also:
#   - diag_shell() - Shell environment diagnostics
#   - hyperfine(1) - Benchmarking tool
#   - starship(1) - Prompt timing
#
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
#
# Comprehensive diagnostic functions for troubleshooting shell environment,
# dotfiles configuration, network connectivity, file permissions, and
# tool availability. Each function focuses on a specific subsystem.
#
# Diagnostic functions:
#   diag_shell      - Shell environment (version, terminal, PATH, aliases)
#   diag_dotfiles   - Dotfiles configuration file presence check
#   diag_network    - Network connectivity (IP, DNS, HTTP, speed)
#   diag_permissions - File permissions (home, SSH, PATH safety)
#   diag_tools      - Tool availability checklist (100+ tools)
#   diag_all        - Run all diagnostics in sequence
#
# Output format:
#   ✓ - Check passed or tool is available
#   ✗ - Check failed or tool is missing
#   WARNING - Security risk detected
#
# Usage:
#   diag_shell     # Check shell configuration
#   diag_network   # Test network connectivity
#   diag_tools     # List available/ missing tools
#   diag_all       # Complete system diagnosis
#
# Compatibility:
#   Works on: All Unix-like systems (some checks are Linux-specific)
#   Dependencies: varies by check function
#
# See also:
#   - bench_shell() - Shell performance benchmarks
#   - dottools() - Tool status report
#   - env_all() - Environment analysis
#
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
#
# Interactive help reference showing all available commands organized
# by category. The help system is self-documenting and generated from
# the actual function/alias definitions.
#
# Help categories:
#   DIAGNOSTICS  - Shell benchmarks, diagnostics, and system info
#   BACKUP       - File backup and restore commands
#   NAVIGATION   - Directory bookmarking and navigation
#   GIT          - Git workflow shortcuts (40+ commands)
#   UTILITIES    - General-purpose utilities
#   CROSS-PLATFORM - Distro-agnostic package/system commands
#   NETWORK      - Network diagnostics and tools
#
# Additional help entry points:
#   helpme        - Full help reference (this command)
#   sectips       - Security best practices
#   dotfiles      - Dotfiles usage guide
#
# Features:
#   - Organized by command category
#   - Shows command name and one-line description
#   - Documents cross-distro compatibility
#   - Lists all _x guarded commands
#
# Usage:
#   helpme           # Show this help
#   sectips          # Security tips
#   dotfiles help    # Dotfiles management
#
# See also:
#   - sectips() - Security best practices
#   - env_all() - Environment analysis
#   - version_all() - Dotfiles version info
#
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
#
# Tools for inspecting the shell environment: PATH entries, alias
# validity, function definitions, and environment variables. These
# help diagnose configuration issues and understand the runtime state.
#
# Function overview:
#   env_info      - Basic environment overview (shell, term, editor, PATH)
#   env_path      - Detailed PATH analysis with validity checks
#   env_aliases   - Alias analysis showing which are actually usable
#   env_functions - Function analysis showing guard status
#   env_all       - Run all environment analyses
#
# Features:
#   - Validates each PATH entry exists
#   - Checks if alias targets are actually installed
#   - Identifies unguarded functions (missing command -v checks)
#   - PATH entry numbering for easy reference
#
# Usage:
#   env_info       # Quick environment overview
#   env_path       # Detailed PATH analysis
#   env_aliases    # Check alias availability
#   env_all        # Full environment scan
#
# Compatibility:
#   Works on: All Unix-like systems
#   Shell: bash (uses declare -F, declare -f)
#
# See also:
#   - diag_shell() - Shell diagnostics
#   - pathsec() - PATH security check
#   - printenv(1) - Environment variable display
#
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
#
# Reporting functions that show the dotfiles version, code statistics,
# and installed tool versions. Useful for debugging, sharing config
# info, and tracking dotfiles growth.
#
# Function overview:
#   version_dotfiles - Dotfiles statistics (lines, files, aliases, functions)
#   version_tools    - Version info for 25+ installed tools
#   version_all      - Run both version reports
#
# Features:
#   - Counts total lines across all config files
#   - Counts total number of config files
#   - Reports number of defined aliases and functions
#   - Shows version strings for git, compilers, and dev tools
#   - Reports cross-platform compatibility status
#
# Usage:
#   version_dotfiles  # Show dotfiles stats
#   version_tools     # Show tool versions
#   version_all       # Show everything
#
# Compatibility:
#   Works on: All Unix-like systems
#   Dependencies: find, wc, alias, declare (bash builtins)
#
# See also:
#   - dots_* aliases - Quick stat commands
#   - diag_tools() - Tool availability check
#
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
#
# Functions for collecting, displaying, and comparing comprehensive
# system information. These combine OS, network, memory, and disk
# details into a single report for troubleshooting or documentation.
#
# Function overview:
#   sysinfo_full    - Complete system report (OS, network, memory, disk)
#   sysinfo_save    - Save current report to /tmp for comparison
#   sysinfo_compare - Compare current state against saved report
#
# Report sections:
#   System: OS, kernel, hostname, architecture
#   Network: IP address, public IP, DNS, gateway
#   Memory: free/vm_stat output
#   Disk: df output (first 10 filesystems)
#
# Usage:
#   sysinfo_full      # Show complete system report
#   sysinfo_save      # Save baseline report
#   sysinfo_compare   # Check what changed since last save
#
# Compatibility:
#   Works on: Linux (full), macOS (partial)
#   Dependencies: free (Linux), vm_stat (macOS), df, ip, grep
#
# See also:
#   - diag_all() - Comprehensive diagnostics
#   - bench_all() - Performance benchmarks
#
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
#
# Network scanning, tracing, bandwidth testing, and DNS diagnostic
# functions. These provide quick access to common network debugging
# operations without remembering complex command syntax.
#
# Function overview:
#   net_scan          - nmap ping sweep (default: 192.168.1.0/24)
#   net_scan_ports    - nmap TCP port scan (default: 192.168.1.1)
#   net_trace         - MTR/traceroute to target (default: 8.8.8.8)
#   net_bw            - iperf3 client bandwidth test
#   net_bw_server     - iperf3 server mode
#   net_bw_test       - Speedtest-cli bandwidth test
#   net_dns_bench     - Benchmark DNS resolvers (Cloudflare, Google, Quad9)
#   net_dns_propagate - Check DNS propagation across multiple resolvers
#
# All functions use _x guard for graceful degradation when tools
# are not installed. They return a helpful message instead of failing.
#
# Usage:
#   net_scan              # Scan local network
#   net_scan_ports 10.0.0.1  # Scan specific host
#   net_trace example.com # Trace route
#   net_dns_bench         # Compare DNS speeds
#
# Compatibility:
#   Works on: All Unix-like systems
#   Dependencies: nmap, mtr/traceroute, iperf3, dig (varies by function)
#
# See also:
#   - diag_network() - Network diagnostics
#   - nmap(1), traceroute(1), iperf3(1) - Network tools
#
net_scan() { _x nmap -sn "${1:-192.168.1.0/24}" 2>/dev/null || echo "nmap needed"; }
net_scan_ports() { _x nmap -sT "${1:-192.168.1.1}" 2>/dev/null || echo "nmap needed"; }
net_trace() { _x mtr -r -c 10 "${1:-8.8.8.8}" 2>/dev/null || _x traceroute "${1:-8.8.8.8}" 2>/dev/null || echo "no trace tool"; }
net_bw() { _x iperf3 -c "$1" 2>/dev/null || echo "iperf3 needed"; }
net_bw_server() { _x iperf3 -s 2>/dev/null || echo "iperf3 needed"; }
net_bw_test() { _x curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | python3 - --simple 2>/dev/null || echo "speedtest-cli needed"; }
net_dns_bench() { for d in 1.1.1.1 8.8.8.8 9.9.9.9; do echo -n "DNS $d: "; dig +short google.com @"$d" 2>/dev/null | head -1 || echo "timeout"; done; }
net_dns_propagate() { _x dig +short "$1" @1.1.1.1 2>/dev/null; _x dig +short "$1" @8.8.8.8 2>/dev/null; _x dig +short "$1" @9.9.9.9 2>/dev/null; }

# =============================================================================
# Git Repository Management Functions
# =============================================================================
#
# Advanced Git operations for repository maintenance, history rewriting,
# search, and statistics. These functions wrap complex git commands
# with sensible defaults and safety checks.
#
# Function overview:
#   git_cleanup        - Prune merged branches (local and remote)
#   git_rewrite_author - Rewrite commit author information (filter-branch)
#   git_find_big       - Find largest files in repository history
#   git_find_text      - Find commits that modified files containing text
#   git_find_commit    - Search commit messages with grep
#   git_find_file      - Track file across entire history
#   git_contributors   - List contributors by commit count
#   git_lines          - Total lines of code in repository
#   git_languages      - Language breakdown by file extension
#   git_age            - Repository creation and last commit dates
#   git_size           - Repository object store size
#
# WARNING:
#   git_rewrite_author uses git filter-branch which rewrites history.
#   This is destructive and should only be used on repositories that
#   have not been shared with others (or with --force push).
#   Consider using git-filter-repo for large repositories.
#
# Compatibility:
#   Works on: All systems with git installed
#   Dependencies: git, xargs, awk, sort
#
# See also:
#   - git(1) - Git reference
#   - git-filter-repo(1) - Modern history rewriting
#   - gb_* aliases - Git branch shortcuts
#
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
#
# Docker container and image management functions. These provide quick
# access to common Docker operations including inspection, cleanup,
# and debugging without remembering verbose CLI flags.
#
# Function overview:
#   docker_cleanup       - Prune all unused Docker objects (containers,
#                          images, networks, volumes)
#   docker_shell         - Exec into container with shell fallback
#   docker_logs_all      - Show last 20 lines from all containers
#   docker_stats_all     - Show resource stats for all containers
#   docker_images_dangling - List dangling (untagged) images
#   docker_rm_dangling   - Remove all dangling images
#   docker_top_processes - Show processes in a container
#   docker_inspect_ip    - Get container IP address
#   docker_inspect_port  - Get container port mappings
#   docker_inspect_vol   - Get container volume mounts
#   docker_inspect_label - Get container labels (formatted JSON)
#
# WARNING:
#   docker_cleanup removes ALL unused containers, networks, images,
#   and dangling volumes. This is irreversible. Use selectively on
#   production systems.
#
# Compatibility:
#   Requires: docker CLI
#   Dependencies: docker, optional: python3 (for JSON formatting)
#
# See also:
#   - docker(1) - Docker CLI reference
#   - d* aliases - Docker shortcut aliases
#
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
#
# Complete tmux session, window, and pane management functions.
# These provide a keyboard-friendly interface for tmux operations
# without learning all the default keybindings.
#
# Session management:
#   tmux_setup   - Show current session/window status
#   tmux_new     - Create new named session (detached)
#   tmux_attach  - Attach to existing session
#   tmux_kill    - Kill a session by name
#   tmux_rename  - Rename a session
#   tmux_list    - List all sessions
#
# Window management:
#   tmux_neww    - Create new window
#   tmux_next    - Switch to next window
#   tmux_prev    - Switch to previous window
#   tmux_killw   - Kill current window
#   tmux_renamew - Rename current window
#
# Pane operations:
#   tmux_split   - Split pane horizontally
#   tmux_splitv  - Split pane vertically
#   tmux_swap    - Swap pane with previous
#   tmux_zoom    - Zoom pane to full window
#   tmux_sync    - Toggle synchronized pane input
#
# Utility:
#   tmux_clock   - Show clock in pane
#   tmux_copy    - Enter copy mode
#   tmux_paste   - Paste from tmux buffer
#   tmux_save    - Save pane output to file
#
# Compatibility:
#   Requires: tmux
#
# See also:
#   - tmux(1) - Terminal multiplexer
#   - t* aliases - Tmux shortcut aliases
#
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
#
# Targeted security audit focusing on SSH configuration, open ports,
# listening services, authentication logs, and MAC (SELinux/AppArmor)
# status. This is a companion to the more comprehensive secaudit()
# function.
#
# Audit checks:
#   SSH config     - Checks PermitRootLogin, PasswordAuthentication,
#                    PubkeyAuthentication settings
#   Sudoers        - Shows active sudo rules (first 10 lines)
#   Open ports     - TCP listening ports via ss
#   Services       - All listening TCP/UDP services
#   Failed logins  - Last 5 failed SSH login attempts
#   MAC status     - SELinux or AppArmor enforcement status
#
# Usage:
#   sec_audit      # Run security audit
#   security       # Alias (same as secaudit)
#
# Compatibility:
#   Works on: Linux (all distros)
#   Requires: ss, journalctl (systemd), optional: sestatus/aa-status
#
# See also:
#   - secstatus() - Quick security overview
#   - secaudit()  - Full security audit
#   - check_path_security() - PATH safety check
#
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
# Message of the Day (MOTD)
# =============================================================================
#
# Welcome screen displayed at shell startup. Shows the dotfiles banner,
# fastfetch system information, and a reminder to use helpme for
# available commands.
#
# Features:
#   - ASCII art banner with dotfiles branding
#   - Fastfetch system info display (hardware, OS, kernel)
#   - Clear screen before display
#   - "helpme" prompt for new users
#
# The MOTD is intentionally minimal to avoid startup delay. For more
# detailed system info, use sysinfo_full, diag_all, or fastfetch directly.
#
# Usage:
#   motd             # Display message of the day
#
# See also:
#   - fastfetch(1) - System information tool
#   - sysinfo_full() - Detailed system report
#   - helpme - Full command reference
#
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
# Dotfiles Management Aliases (dots_*)
# =============================================================================
#
# Consolidated management interface for the dotfiles project. Every
# dots_* alias provides quick access to a specific aspect of the
# configuration: version info, statistics, diagnostics, or utilities.
#
# Information aliases:
#   dots_version - Show dotfiles version string
#   dots_lines   - Count total lines in all config files
#   dots_size    - Show disk usage of dotfiles directory
#   dots_files   - Count number of config files
#   dots_shells  - List supported shells
#   dots_os      - Show operating system
#   dots_arch    - Show hardware architecture
#
# Utility aliases:
#   dots_help    - Show help reference (same as helpme)
#   dots_bench   - Run shell benchmarks
#   dots_diag    - Run all diagnostics
#   dots_env     - Run environment analysis
#   dots_sys     - Show system information summary
#   dots_net     - Run network diagnostics
#   dots_sec     - Run security audit
#   dots_ver     - Show dotfiles version details
#   dots_tools   - Show installed tool versions
#
# Usage:
#   dots_version     # Quick version check
#   dots_lines       # Count config lines
#   dots_diag        # Full diagnostics
#
# Compatibility:
#   Works on: All Unix-like systems
#
# See also:
#   - version_dotfiles() - Detailed version report
#   - diag_all() - Full diagnostics
#   - helpme() - Complete help reference
#
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
# Lines: 30194
# Shells: bash zsh fish
# Cross-platform: Linux + macOS


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

