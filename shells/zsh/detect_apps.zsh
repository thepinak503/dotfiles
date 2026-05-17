#!/usr/bin/env zsh
# =============================================================================
# Application Detection Module - Zsh
# =============================================================================


# =============================================================================
# Helper Function
# =============================================================================


_detect_app() { command -v "$1" >/dev/null 2>&1; }

# =============================================================================
# EDITORS
# =============================================================================


if _detect_app nvim; then
    export EDITOR='nvim'
    export VISUAL='nvim'
elif _detect_app vim; then
    export EDITOR='vim'
    export VISUAL='vim'
elif _detect_app code; then
    export EDITOR='code'
    export VISUAL='code'
elif _detect_app helix; then
    export EDITOR='hx'
    export VISUAL='hx'
elif _detect_app micro; then
    export EDITOR='micro'
    export VISUAL='micro'
elif _detect_app kak; then
    export EDITOR='kak'
    export VISUAL='kak'
fi

# =============================================================================
# FZF - Fuzzy Finder
# =============================================================================


if _detect_app fzf; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

# =============================================================================
# Zoxide - Smart cd Command
# =============================================================================


if _detect_app zoxide; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# Atuin - History Synchronization
# =============================================================================


if _detect_app atuin; then
    eval "$(atuin init zsh)"
fi

# =============================================================================
# Find The Command - Command Discovery
# =============================================================================


[[ -f /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh noprompt quiet
