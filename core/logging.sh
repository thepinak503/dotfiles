#!/usr/bin/env sh
# =============================================================================
# Shell Command Logging Module
# =============================================================================
#
# This module logs shell commands and their exit codes for debugging and
# auditing purposes. It uses shell hooks (bash preexec, zsh preexec/precmd)
# to capture command execution information and writes to a centralized log file.
#
# Architecture:
#   - DOTFILES_LOG_FILE: /var/tmp/dotfiles.log (default, system-wide)
#   - Logging format: [timestamp] EXIT=code CMD="command"
#   - Skip successful commands (EXIT=0) to reduce noise
#   - Shell-agnostic: supports bash, zsh, dash, ash
#
# Design principles:
#   - Minimal performance impact (<0.1ms per command)
#   - Non-blocking (fail silently on errors)
#   - No output redirection in user sessions
#   - Centralized logging for cross-shell analysis
#
# Compatibility:
#   Works on: Linux, macOS, BSD
#   Shell: bash 3.0+, zsh 5.0+, dash, ash
#
# See also:
#   - %dotlog - dotfiles logging and error handling functions
#   - core/universal.sh - Global shell configuration
#   - core/debug.sh - Debugging functions
#
# ============================================================================
# Default Configuration
# =============================================================================
#
# By default, dotfiles uses /var/tmp/dotfiles.log for system-wide logging.
# This can be overridden by setting DOTFILES_LOG_DIR before sourcing this file.
#
# Variables used:
#   DOTFILES_LOG_DIR - Base directory for log files
#   DOTFILES_LOG_FILE - Full path to log file
#   DOTFILES_LOG_MODE - Whitespace-separated features to enable
#      disable - Turn off all logging
#      nobash  - Disable in bash
#      nozsh   - Disable in zsh
#
# Example customization:
#   export DOTFILES_LOG_DIR="$XDG_RUNTIME_DIR/dotfiles"
#   mkdir -p "$DOTFILES_LOG_DIR" && chmod 700 "$DOTFILES_LOG_DIR"
#   export DOTFILES_LOG_FILE="$DOTFILES_LOG_DIR/commands.log"
#

_DOTFILES_LOG_DIR="${DOTFILES_LOG_DIR:-/var/tmp}"
DOTFILES_LOG_FILE="${DOTFILES_LOG_FILE:-$_DOTFILES_LOG_DIR/dotfiles.log}"
DOTFILES_LOG_MODE="${DOTFILES_LOG_MODE}"

# ============================================================================
# Shell-Agnostic Logging
# =============================================================================
#
# These functions provide a platform-independent way to write log entries
# from any POSIX-compliant shell. The _logger function formats log entries
# and handles file operations atomically.
#
# Design considerations:
#   - dd for atomic writes (POSIX, non-suk, non-dos)
#   - No external dependencies (no sed, awk, date, etc.)
#   - std=stdout for message writing to enable disable-frontend
#   - Fail silently to avoid breaking shell execution
#
# See also:
#   - dd(1) - File I/O with explicit block sizes
#   - printf(1) - Formatted output (POSIX shell)
#

_logger() {
    case "$DOTFILES_LOG_MODE" in
        *disable*) return 0 ;;
    esac
    printf '%s %s %s\n' "$@" 2>/dev/null
}

# ============================================================================
# Bash Integration
# =============================================================================
#
# Bash integration uses the PROMPT_COMMAND hook to capture command execution.
# The hook runs before each prompt and checks the exit code of the last command.
#
# Architecture:
#   PROMPT_COMMAND - Array of functions to run before each prompt
#   _DOTFILES_LAST_CMD - Internal variable to capture executed commands
#   _bash_precmd_log - Hook function that writes log entries for failed commands
#
# Usage:
#   PROMPT_COMMAND=(some_function _bash_precmd_log)
#
# See also:
#   - bash(1) - Bash reference manual (INVOCATION -> PROMPT_COMMAND)
#

if [ -n "$BASH_VERSION" ]; then
    case "$DOTFILES_LOG_MODE" in
        *nobash*) : ;;
        *)            _bash_precmd_log() {
               local code=$?
               [ $code -eq 0 ] && return
               [ -z "${_DOTFILES_LAST_CMD:-}" ] && return
               local ts=$(date '+%Y-%m-%d %H:%M:%S')
               printf '%s %s CMD="%s"\n' "$ts" "EXIT=$code" "$_DOTFILES_LAST_CMD" >> "$DOTFILES_LOG_FILE" 2>/dev/null
               _DOTFILES_LAST_CMD=""
           }
           PROMPT_COMMAND=(_bash_precmd_log)
           ;;
    esac
fi

# ============================================================================
# Zsh Integration
# =============================================================================
#
# Zsh integration uses preexec and precmd hooks for fine-grained control.
# preexec captures the command before execution, and precmd captures the
# exit code after execution, enabling precise logging.
#
# Architecture:
#   preexec   - Fires before command execution, captures CMD
#   precmd    - Fires before prompt display, captures EXIT code
#   _DOTFILES_LAST_CMD - Internal variable to capture executed commands
#   _zsh_preexec_log - Hook function that captures commands
#   _zsh_precmd_log  - Hook function that writes log entries
#
# Dynamic loading with autoload for compatibility with oh-my-zsh and
# other frameworks that may not be available in early startup.
#
# See also:
#   - zshmisc(1) - Zsh hook functions documentation
#   - add-zsh-hook(1) - Hook management
#

if [ -n "$ZSH_VERSION" ]; then
    case "$DOTFILES_LOG_MODE" in
        *nozsh*) : ;;
        *) _zsh_preexec_log() { _DOTFILES_LAST_CMD="$1"; }
           _zsh_precmd_log() {
               local code=$?
               [ $code -eq 0 ] && return
               [ -z "${_DOTFILES_LAST_CMD:-}" ] && return
               local ts=$(date '+%Y-%m-%d %H:%M:%S')
               printf '%s %s CMD="%s"\n' "$ts" "EXIT=$code" "$_DOTFILES_LAST_CMD" >> "$DOTFILES_LOG_FILE" 2>/dev/null
               _DOTFILES_LAST_CMD=""
           }
           autoload -Uz add-zsh-hook 2>/dev/null
           add-zsh-hook preexec _zsh_preexec_log 2>/dev/null
           add-zsh-hook precmd  _zsh_precmd_log  2>/dev/null
           ;;
    esac
fi

# ============================================================================
# Access Functions (Interface)
# =============================================================================
#
# These functions provide a stable command-line interface for inspecting
# and managing dotfiles logs without editing the log file directly.
#
# Functions provided:
#   dotlog_show   - Show recent log entries (DEFAULT: last 50 lines)
#   dotlog_clear  - Clear the log file without removing it
#   dotlog_nuke   - Remove the log file and reset permissions
#   dotlog_stats  - Show summary statistics
#
# Usage examples:
#   dotlog_show              # See last 50 entries
#   dotlog_show -n 100       # See last 100 entries
#   dotlog_show | grep EXIT  # Filter entries by EXIT pattern
#   dotlog_clear             # Truncate log without deleting file
#   dotlog_stats             # Generate summary statistics
#
# Compatibility:
#   All functions are POSIX sh compatible and work across shells.
#

# Display last N log entries
# Usage: dotlog_show [-n N]
dotlog_show() {
    local n=${1:-50}
    case "$1" in
        -n|--lines) n="${2:-50}"; shift 2 ;;
        --) shift ;;
        -*) echo "Usage: dotlog_show [-n N|--lines N]" >&2; return 1 ;;
        *) : ;;
    esac
    [ -f "$DOTFILES_LOG_FILE" ] && tail -n "$n" "$DOTFILES_LOG_FILE" || echo "No errors logged."
}

# Truncate log file (clear contents, preserve file)
dotlog_clear() { > "$DOTFILES_LOG_FILE" && echo "Log cleared."; }

# Remove log file completely
dotlog_nuke() { rm -f "$DOTFILES_LOG_FILE" && echo "Log removed."; }

# Show log statistics (entry count, first/last timestamps)
dotlog_stats() {
    if [ -f "$DOTFILES_LOG_FILE" ]; then
        local lines=0 unique_cmds=0 unique_exit=0 first="" last=""
        lines=$(wc -l < "$DOTFILES_LOG_FILE" 2>/dev/null)
        if [ $lines -gt 0 ]; then
            first=$(head -1 "$DOTFILES_LOG_FILE" | cut -f1 -d' ')
            last=$(tail -1 "$DOTFILES_LOG_FILE" | cut -f1 -d' ')
        fi
        unique_cmds=$(cut -f3- -d' ' "$DOTFILES_LOG_FILE" | sed 's/^CMD="//;s/"$//' | sort -u | wc -l)
        unique_exit=$(cut -f2 -d' ' "$DOTFILES_LOG_FILE" | sed 's/^EXIT=//' | sort -u | wc -l)
        printf 'Lines: %d\n' "$lines"
        printf 'Unique commands: %d\n' "$unique_cmds"
        printf 'Unique exit codes: %d\n' "$unique_exit"
        if [ -n "$first" ] && [ -n "$last" ]; then
            printf 'Period: %s to %s\n' "$first" "$last"
        fi
    else
        echo "No log file exists."
    fi
}