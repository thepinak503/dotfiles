#!/usr/bin/env sh
# =============================================================================
# Shell Command Logging Module
# =============================================================================


# ============================================================================
# Default Configuration
# =============================================================================


_DOTFILES_LOG_DIR="${DOTFILES_LOG_DIR:-/var/tmp}"
DOTFILES_LOG_FILE="${DOTFILES_LOG_FILE:-$_DOTFILES_LOG_DIR/dotfiles.log}"
DOTFILES_LOG_MODE="${DOTFILES_LOG_MODE}"

# ============================================================================
# Shell-Agnostic Logging
# =============================================================================


_logger() {
    case "$DOTFILES_LOG_MODE" in
        *disable*) return 0 ;;
    esac
    printf '%s %s %s\n' "$@" 2>/dev/null
}

# ============================================================================
# Bash Integration
# =============================================================================


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
           PROMPT_COMMAND="_bash_precmd_log${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
           ;;
    esac
fi

# ============================================================================
# Zsh Integration
# =============================================================================


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

# =============================================================================


# Display last N log entries

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


dotlog_clear() { > "$DOTFILES_LOG_FILE" && echo "Log cleared."; }

# Remove log file completely
dotlog_nuke() { rm -f "$DOTFILES_LOG_FILE" && echo "Log removed."; }


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