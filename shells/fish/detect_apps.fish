#!/usr/bin/env fish
# =============================================================================
# Application Detection Module - Fish
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
#   - No errors on missing apps (type -q check)
#   - XDG Base Directory compliance
#   - Shell-agnostic configuration where possible
#   - Performance: only initialize what's installed
#
# Compatibility:
#   Works on: Linux, macOS, BSD
#   Shell: fish 3.0+
#
# See also:
#   - core/universal.sh - Core detection functions
#   - core/os_detect.sh - OS/distro detection
#   - shells/zsh/detect_apps.zsh - Zsh equivalent
#   - shells/bash/detect_apps.bash - Bash equivalent
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
#   true if command exists, false otherwise
#
# Example:
#   _detect_app nvim; and echo "Neovim is installed"
#

function _detect_app
    type -q $argv[1]
end

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

if _detect_app fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

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

if _detect_app zoxide
    zoxide init fish | source
end

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

if _detect_app atuin
    atuin init fish | source
end

# =============================================================================
# Starship - Cross-Shell Prompt
# =============================================================================
#
# Starship is a minimal, customizable, and extremely fast prompt that works
# with any shell. It displays useful information about your current context:
# Git status, Python virtualenv, Node.js version, etc.
#
# Features:
#   - Shell-agnostic (works with bash, zsh, fish, etc.)
#   - Highly customizable via config file
#   - Fast performance (Rust-based)
#   - Integrates with many tools (Git, Docker, Kubernetes, etc.)
#
# Configuration file:
#   ~/.config/starship.toml
#
# Usage examples:
#   starship prompt                # Show current prompt
#   starship prompt --cmd-duration 100 --status 0  # Mock prompt
#   starship config              # Edit config
#
# See also:
#   - starship(1) - Starship documentation
#   - https://starship.rs - Project website
#   - https://github.com/starship/starship - GitHub repository
#

if _detect_app starship
    starship init fish --print-full-init | source
end

# =============================================================================
# Fastfetch - System Information
# =============================================================================
#
# Fastfetch is a fast, feature-rich system information tool. It displays
# system information in a beautiful, customizable format with icons and
# colors.
#
# Features:
#   - Fast performance (C-based, parallel processing)
#   - Highly customizable output
#   - Support for many system information sources
#   - Multiple output formats (ASCII, JSON, etc.)
#
# Configuration file:
#   ~/.config/fastfetch/config.jsonc
#
# Usage examples:
#   fastfetch                    # Show system info
#   fastfetch --help             # Show help
#   fastfetch -c custom.jsonc    # Use custom config
#   fastfetch --json             # Output as JSON
#
# See also:
#   - fastfetch(1) - Fastfetch documentation
#   - https://github.com/fastfetch-cli/fastfetch - GitHub repository
#

if _detect_app fastfetch
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
end

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

if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish noprompt quiet
end
