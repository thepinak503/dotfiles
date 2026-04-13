#!/usr/bin/env sh
# =============================================================================
# lib/logging.sh — Lightweight error logger
# Appends shell errors with timestamps to ~/.local/share/dotfiles/errors.log
# Compatible with bash and zsh (sourced at startup).
# =============================================================================

DOTFILES_LOG_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_LOG_FILE="$DOTFILES_LOG_DIR/errors.log"
export DOTFILES_LOG_FILE

# Keep log under 5 MB; rotate if needed
_log_rotate() {
    [ -f "$DOTFILES_LOG_FILE" ] || return 0
    local size
    size="$(wc -c < "$DOTFILES_LOG_FILE" 2>/dev/null || echo 0)"
    if [ "$size" -gt 5242880 ]; then
        mv "$DOTFILES_LOG_FILE" "${DOTFILES_LOG_FILE}.old"
    fi
}

mkdir -p "$DOTFILES_LOG_DIR" 2>/dev/null
_log_rotate

# Bash: use ERR trap
if [ -n "$BASH_VERSION" ]; then
    _dotfiles_err_trap() {
        local code=$?
        local cmd="${BASH_COMMAND}"
        local ts
        ts="$(date '+%Y-%m-%d %H:%M:%S')"
        # Ignore trivial exits
        [ $code -eq 0 ] && return
        # Ignore intentional non-zero (e.g. grep with no match)
        [[ "$cmd" =~ ^(grep|test|\[) ]] && return
        printf '[%s] EXIT=%s CMD=%s\n' "$ts" "$code" "$cmd" >> "$DOTFILES_LOG_FILE" 2>/dev/null
    }
    # Only trap in interactive shells to avoid noise
    [[ $- == *i* ]] && trap '_dotfiles_err_trap' ERR
fi

# Zsh: use preexec / precmd approach
if [ -n "$ZSH_VERSION" ]; then
    _zsh_preexec_log() { _DOTFILES_LAST_CMD="$1"; }
    _zsh_precmd_log() {
        local code=$?
        [ $code -eq 0 ] && return
        [ -z "${_DOTFILES_LAST_CMD:-}" ] && return
        local ts
        ts="$(date '+%Y-%m-%d %H:%M:%S')"
        printf '[%s] EXIT=%s CMD=%s\n' "$ts" "$code" "$_DOTFILES_LAST_CMD" >> "$DOTFILES_LOG_FILE" 2>/dev/null
        _DOTFILES_LAST_CMD=""
    }
    autoload -Uz add-zsh-hook 2>/dev/null
    add-zsh-hook preexec _zsh_preexec_log 2>/dev/null
    add-zsh-hook precmd  _zsh_precmd_log  2>/dev/null
fi

# Public helpers
dotlog_show() { [ -f "$DOTFILES_LOG_FILE" ] && tail -50 "$DOTFILES_LOG_FILE" || echo "No errors logged."; }
dotlog_clear() { > "$DOTFILES_LOG_FILE" && echo "Log cleared."; }

unset -f _log_rotate 2>/dev/null || true
