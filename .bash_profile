#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH PROFILE
# =============================================================================

# Run fastfetch on login (interactive only)
if [[ -x "$(command -v fastfetch 2>/dev/null)" ]]; then
    fastfetch 2>/dev/null
fi

# Source .bashrc
if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi

# Source local customizations
if [[ -f "$HOME/.bash_profile.local" ]]; then
    source "$HOME/.bash_profile.local"
fi

