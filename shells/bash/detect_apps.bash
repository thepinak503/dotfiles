#!/usr/bin/env bash
# =============================================================================
# Application Detection Module - Bash
# =============================================================================

# Non-interactive shells (e.g. makepkg) should not run app detection
[[ $- != *i* ]] && return

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
    eval "$(zoxide init bash 2>/dev/null)" || true
fi

# =============================================================================
# Atuin - History Synchronization
# =============================================================================


if _detect_app atuin; then
    [[ -f /usr/share/bash-preexec/bash-preexec.sh ]] && source /usr/share/bash-preexec/bash-preexec.sh
    eval "$(atuin init bash 2>/dev/null)" || true
fi

# =============================================================================
# Find The Command - Command Discovery
# =============================================================================


[[ -f /usr/share/doc/find-the-command/ftc.bash ]] && source /usr/share/doc/find-the-command/ftc.bash noprompt quiet
