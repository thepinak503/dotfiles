#!/usr/bin/env bash
# =============================================================================
# Application Detection Module - Bash
# =============================================================================
#
# This module detects installed applications and configures environment
# variables accordingly. It follows the Arch Wiki style of comprehensive
# documentation with usage examples and technical details.
#
# Architecture:
#   - _detect_app() - Helper function to check command availability
#   - Conditional exports - Only set variables when app is installed
#   - Fallback chains - Try multiple apps for same functionality
#
# Design principles:
#   - No errors on missing apps (command -v check)
#   - XDG Base Directory compliance
#   - Shell-agnostic configuration where possible
#   - Performance: only initialize what's installed
#
# Compatibility:
#   Works on: Linux, macOS, BSD
#   Shell: bash 4.0+
#
# See also:
#   - core/universal.sh - Core detection functions
#   - core/os_detect.sh - OS/distro detection
#   - shells/zsh/detect_apps.zsh - Zsh equivalent
#   - shells/fish/detect_apps.fish - Fish equivalent
#
# =============================================================================
# Helper Function
# =============================================================================
#
# Checks if a command is available in PATH.
#
# Usage:
#   _detect_app <command>
#
# Returns:
#   0 if command exists, 1 otherwise
#
# Example:
#   _detect_app nvim && echo "Neovim is installed"
#

_detect_app() { command -v "$1" >/dev/null 2>&1; }

# =============================================================================
# EDITORS
# =============================================================================
#
# Editor detection follows a priority chain. Neovim is preferred for its
# modern architecture and LSP support. Vim serves as fallback for systems
# where Neovim is not available.
#
# Environment variables set:
#   EDITOR  - Primary editor command
#   VISUAL  - Visual editor command (same as EDITOR)
#
# Editor choices:
#   nvim - Neovim: modern, async, LSP support
#   vim  - Vim: vi-compatible, extensive plugin ecosystem
#   code - VS Code: GUI editor with integrated terminal
#   helix - Helix: modal editor written in Rust
#   micro - Micro: modern terminal editor
#   kak - Kakoune: modal editor with selection-first approach
#
# See also:
#   - nvim(1) - Neovim documentation
#   - vim(1) - Vim documentation
#   - https://neovim.io - Neovim project
#   - https://www.vim.org - Vim project
#

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
#
# FZF is a general-purpose command-line fuzzy finder. It can be used with
# any list of strings: files, directories, history, processes, git commits,
# etc.
#
# Features:
#   - Interactive filtering with preview window
#   - Customizable key bindings and layout
#   - Integration with shell (Ctrl-T, Ctrl-R, Alt-C)
#   - Vim/Neovim plugin available
#
# Usage examples:
#   fzf                    # Browse files in current directory
#   fzf --height 100%      # Full screen
#   fzf --layout=reverse   # Results at top
#   fzf --preview 'cat {}' # Preview with cat
#
# Shell integration:
#   Ctrl-T - Paste selected file path
#   Ctrl-R - Search command history
#   Alt-C  - Change directory
#
# See also:
#   - fzf(1) - FZF documentation
#   - https://github.com/junegunn/fzf - GitHub repository
#

if _detect_app fzf; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

# =============================================================================
# Zoxide - Smart cd Command
# =============================================================================
#
# Zoxide is a fast and modern replacement for cd. It learns your habits
# and helps you navigate directories quickly using frecency (frequency + recency).
#
# Features:
#   - Automatic directory learning
#   - Frecency-based ranking
#   - Tab completion
#   - Shell prompt integration
#
# Usage examples:
#   z                    # cd to home
#   z foo                # cd to most frecent dir containing "foo"
#   z foo bar            # cd to dir containing both "foo" and "bar"
#   z -l                 # List matches with scores
#   z -r foo             # Match by rank (frequency)
#   z -t foo             # Match by time (recency)
#
# See also:
#   - zoxide(1) - Zoxide documentation
#   - https://github.com/ajeetdsouza/zoxide - GitHub repository
#

if _detect_app zoxide; then
    eval "$(zoxide init bash 2>/dev/null)"
fi

# =============================================================================
# Atuin - History Synchronization
# =============================================================================
#
# Atuin is a tool that syncs your shell history across machines via a
# personal database. It provides search, filtering, and history analysis.
#
# Features:
#   - End-to-end encrypted history sync
#   - Search history with fuzzy finder
#   - Statistics and insights
#   - Automatic upload/download
#
# Usage examples:
#   atuin search "git"   # Search history for "git"
#   atuin search -i      # Interactive search
#   atuin upload         # Manually upload history
#   atuin download       # Manually download history
#   atuin stats          # Show history statistics
#
# See also:
#   - atuin(1) - Atuin documentation
#   - https://github.com/atuinsh/atuin - GitHub repository
#

if _detect_app atuin; then
    [[ -f /usr/share/bash-preexec/bash-preexec.sh ]] && source /usr/share/bash-preexec/bash-preexec.sh
    eval "$(atuin init bash 2>/dev/null)"
fi

# =============================================================================
# Find The Command - Command Discovery
# =============================================================================
#
# Find The Command (FTC) helps you discover available commands on your
# system. It provides a shell function to search through installed
# commands and their descriptions.
#
# Features:
#   - Search commands by name or description
#   - Shell integration (ftc function)
#   - Tab completion
#
# Usage examples:
#   ftc git              # Search for git-related commands
#   ftc video            # Search for video tools
#   ftc download         # Search for download utilities
#
# See also:
#   - ftc(1) - Find The Command documentation
#   - https://github.com/jeffreytse/find-the-command - GitHub repository
#

[[ -f /usr/share/doc/find-the-command/ftc.bash ]] && source /usr/share/doc/find-the-command/ftc.bash noprompt quiet
