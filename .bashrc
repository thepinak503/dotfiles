#!/usr/bin/env bash
# =============================================================================
# DOTFILES - UNIVERSAL SHELL CONFIGURATION
# Version: 2.0.0
# Description: World's most advanced dotfiles for all distros
# Modes: basic | advanced | ultra-nerd
# =============================================================================

# Exit if not running interactively
[[ $- != *i* ]] && return

# =============================================================================
# STARTUP PROFILING (Optional)
# Set DOTFILES_PROFILE=1 to enable profiling
# =============================================================================
if [[ "${DOTFILES_PROFILE:-0}" == "1" ]]; then
    PS4='+ [$(date "+%s.%N")] '
    exec 3>&2 2>/tmp/dotfiles-profile.log
    set -x
fi

# =============================================================================
# CONFIGURATION MODE SELECTOR
# Set DOTFILES_MODE in ~/.bashrc.local or environment
# Options: basic, advanced (default), ultra-nerd
# =============================================================================
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# =============================================================================
# OPTIMIZED LOADING BASED ON MODE
# =============================================================================

# Fast path for basic mode - load only essentials
if [[ "$DOTFILES_MODE" == "basic" ]]; then
    # Load only core components for minimal startup time
    source "$DOTFILES_DIR/lib/colors.sh" 2>/dev/null || true
    source "$DOTFILES_DIR/bash/00-core.sh"
    source "$DOTFILES_DIR/bash/02-aliases-core.sh"
    
    # Load local customizations
    [[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
    
    # End profiling if enabled
    if [[ "${DOTFILES_PROFILE:-0}" == "1" ]]; then
        set +x
        exec 2>&3 3>&-
    fi
    
    # Basic mode welcome (suppressed for cleaner startup)
    # echo -e "\033[38;5;33m✓ Dotfiles loaded in \033[1mBASIC\033[0m\033[38;5;33m mode\033[0m"
    return 0
fi

# =============================================================================
# STANDARD LOADING FOR ADVANCED/ULTRA-NERD MODES
# =============================================================================

# Source all modular bash components
_dotfiles_load() {
    local component="$1"
    local file="$DOTFILES_DIR/bash/${component}.sh"
    
    if [[ -f "$file" ]]; then
        source "$file"
    else
        echo "Warning: Component not found: $file" >&2
    fi
}

# Load shared library first
source "$DOTFILES_DIR/lib/colors.sh" 2>/dev/null || true

# Load order matters - essential components first
_dotfiles_load "00-core"           # Core settings & environment
_dotfiles_load "01-functions"      # Utility functions library
_dotfiles_load "02-aliases-core"   # Essential aliases (all modes)

# Load extended features for advanced/ultra-nerd
if [[ "$DOTFILES_MODE" != "basic" ]]; then
    _dotfiles_load "03-aliases-extended"
    _dotfiles_load "05-distro-detection"
    _dotfiles_load "06-package-managers"
    _dotfiles_load "07-modern-tools"
    _dotfiles_load "08-development"
    _dotfiles_load "09-shell-options"
fi

# Ultra-nerd mode only
if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    _dotfiles_load "04-aliases-nerd"
fi

# Always load prompt last
_dotfiles_load "10-prompt"

# Load optional components if they exist
[[ -f "$DOTFILES_DIR/bash/20-docker.sh" ]] && _dotfiles_load "20-docker"
[[ -f "$DOTFILES_DIR/bash/21-direnv.sh" ]] && _dotfiles_load "21-direnv"
[[ -f "$DOTFILES_DIR/bash/22-lang-versions.sh" ]] && _dotfiles_load "22-lang-versions"
[[ -f "$DOTFILES_DIR/bash/23-cloud-cli.sh" ]] && _dotfiles_load "23-cloud-cli"
[[ -f "$DOTFILES_DIR/bash/24-filemanagers.sh" ]] && _dotfiles_load "24-filemanagers"
[[ -f "$DOTFILES_DIR/bash/25-monitoring.sh" ]] && _dotfiles_load "25-monitoring"

# =============================================================================
# LOCAL CUSTOMIZATIONS (Load last to override)
# =============================================================================
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# =============================================================================
# END PROFILING
# =============================================================================
if [[ "${DOTFILES_PROFILE:-0}" == "1" ]]; then
    set +x
    exec 2>&3 3>&-
    echo "Profile saved to: /tmp/dotfiles-profile.log"
fi

# =============================================================================
# WELCOME MESSAGE (suppressed in basic mode)
# =============================================================================
if [[ -z "${DOTFILES_QUIET:-}" ]]; then
    if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
        echo -e "\033[38;5;82m✓ Dotfiles loaded in \033[1mULTRA-NERD\033[0m\033[38;5;82m mode\033[0m"
    elif [[ "$DOTFILES_MODE" == "advanced" ]]; then
        echo -e "\033[38;5;208m✓ Dotfiles loaded in \033[1mADVANCED\033[0m\033[38;5;208m mode\033[0m"
    fi
fi
