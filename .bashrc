#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH CONFIGURATION
# Auto-generated based on detected tools
# =============================================================================

# Load dynamic library first
[[ -f "$HOME/.dotfiles/lib/dynamic.sh" ]] && source "$HOME/.dotfiles/lib/dynamic.sh"

# Source all bash configuration files
for file in "$HOME/.dotfiles/bash/"*.sh; do
    [[ -f "$file" ]] && source "$file"
done

# Source local customizations
if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi

# Initialize starship prompt
eval -- "$(/usr/local/bin/starship init bash --print-full-init)"
