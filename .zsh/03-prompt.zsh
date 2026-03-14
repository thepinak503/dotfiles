#!/usr/bin/env zsh
# =============================================================================
# ZSH PROMPT CONFIGURATION
# Starship and custom prompt settings
# =============================================================================

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# Zoxide (cd alternative)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# Fastfetch on start (interactive only)
if [[ -x "$(command -v fastfetch 2>/dev/null)" ]]; then
    fastfetch 2>/dev/null
fi
