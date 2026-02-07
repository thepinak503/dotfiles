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
# CONFIGURATION MODE SELECTOR
# Set DOTFILES_MODE in ~/.bashrc.local or environment
# Options: basic, advanced (default), ultra-nerd
# =============================================================================
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# =============================================================================
# LOAD CORE COMPONENTS
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

# Load order matters
_dotfiles_load "00-core"           # Core settings & environment
_dotfiles_load "01-functions"      # Utility functions library
_dotfiles_load "02-aliases-core"   # Essential aliases (all modes)
_dotfiles_load "03-aliases-extended" # Advanced aliases (advanced+)
_dotfiles_load "04-aliases-nerd"   # Ultra-nerd aliases (ultra-nerd only)
_dotfiles_load "05-distro-detection" # Universal distro support
_dotfiles_load "06-package-managers" # Package manager aliases
_dotfiles_load "07-modern-tools"   # eza, bat, fzf, zoxide
_dotfiles_load "08-development"    # Git, Docker, K8s, DevOps
_dotfiles_load "09-shell-options"  # shopt, bind, history
_dotfiles_load "10-prompt"         # Starship & fallback prompts

# =============================================================================
# LOCAL CUSTOMIZATIONS (Load last to override)
# =============================================================================
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# =============================================================================
# WELCOME MESSAGE
# =============================================================================
if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    echo -e "\033[38;5;82m✓ Dotfiles loaded in \033[1mULTRA-NERD\033[0m\033[38;5;82m mode\033[0m"
elif [[ "$DOTFILES_MODE" == "basic" ]]; then
    echo -e "\033[38;5;33m✓ Dotfiles loaded in \033[1mBASIC\033[0m\033[38;5;33m mode\033[0m"
else
    echo -e "\033[38;5;208m✓ Dotfiles loaded in \033[1mADVANCED\033[0m\033[38;5;208m mode\033[0m"
fi
