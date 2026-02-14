#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH CONFIGURATION
# Auto-generated based on detected tools
# =============================================================================

# Source dynamic configuration
if [[ -f "$HOME/.dotfiles/generated/dynamic-bash.sh" ]]; then
    source "$HOME/.dotfiles/generated/dynamic-bash.sh"
fi

# Source local customizations
if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi


# Load dynamic library
[[ -f "$HOME/.dotfiles/lib/dynamic.sh" ]] && source "$HOME/.dotfiles/lib/dynamic.sh"
