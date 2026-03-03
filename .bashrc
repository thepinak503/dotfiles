#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH CONFIGURATION
# Auto-generated based on detected tools
# =============================================================================

# Load dynamic library first
DOTFILES_DIR="${HOME}/.dotfiles"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR

[[ -f "$DOTFILES_DIR/lib/dynamic.sh" ]] && source "$DOTFILES_DIR/lib/dynamic.sh"

# Source all bash configuration files
for file in "$DOTFILES_DIR/bash/"*.sh; do
    [[ -f "$file" ]] && source "$file"
done

# Source local customizations
if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi
