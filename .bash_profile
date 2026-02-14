#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH PROFILE
# =============================================================================

# Source .bashrc
if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi

# Source local customizations
if [[ -f "$HOME/.bash_profile.local" ]]; then
    source "$HOME/.bash_profile.local"
fi

