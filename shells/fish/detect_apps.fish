#!/usr/bin/env fish
# =============================================================================
# Application Detection Module - Fish
# =============================================================================


# =============================================================================
# Helper Function
# =============================================================================


function _detect_app
    type -q $argv[1]
end

# =============================================================================
# EDITORS
# =============================================================================


if _detect_app nvim
    set -gx EDITOR 'nvim'
    set -gx VISUAL 'nvim'
else if _detect_app vim
    set -gx EDITOR 'vim'
    set -gx VISUAL 'vim'
else if _detect_app code
    set -gx EDITOR 'code'
    set -gx VISUAL 'code'
else if _detect_app helix
    set -gx EDITOR 'hx'
    set -gx VISUAL 'hx'
else if _detect_app micro
    set -gx EDITOR 'micro'
    set -gx VISUAL 'micro'
else if _detect_app kak
    set -gx EDITOR 'kak'
    set -gx VISUAL 'kak'
end

# =============================================================================
# FZF - Fuzzy Finder
# =============================================================================


if _detect_app fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

# =============================================================================
# Zoxide - Smart cd Command
# =============================================================================


if _detect_app zoxide
    zoxide init fish | source
end

# =============================================================================
# Atuin - History Synchronization
# =============================================================================


if _detect_app atuin
    atuin init fish | source
end

# =============================================================================
# Starship - Cross-Shell Prompt
# =============================================================================


if _detect_app starship
    starship init fish --print-full-init | source
end

# =============================================================================
# Fastfetch - System Information
# =============================================================================


if _detect_app fastfetch
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
end

# =============================================================================
# Find The Command - Command Discovery
# =============================================================================


if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish noprompt quiet
end
