#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/local/share/.dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
LAST_CHECK_FILE="$DOTFILES_STATE_DIR/last_update_check"
AUTO_UPDATE_LOG="$DOTFILES_STATE_DIR/autoupdate.log"
# How often to notify (seconds). Default: 1 day.
UPDATE_INTERVAL=${DOTFILES_UPDATE_INTERVAL:-86400}

mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null || true
cd "$DOTFILES_DIR" || exit
# Fetch latest remote main
git fetch origin main &>/dev/null || exit

# Compare local HEAD to origin/main (robust even without branch tracking)
LOCAL=$(git rev-parse --verify HEAD 2>/dev/null || echo "")
REMOTE=$(git rev-parse --verify origin/main 2>/dev/null || echo "")
if [ -n "$LOCAL" ] && [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
    NOW=$(date +%s)
    LAST_CHECK=$(cat "$LAST_CHECK_FILE" 2>/dev/null || echo 0)
    if (( NOW - LAST_CHECK > UPDATE_INTERVAL )); then
        printf '%s\n' "UPDATE_READY" > "$DOTFILES_STATE_DIR/update_ready"
        printf '%s\n' "$NOW" > "$LAST_CHECK_FILE"
        printf '%s - update ready: %s -> %s\n' "$(date -Iseconds)" "$LOCAL" "$REMOTE" >> "$AUTO_UPDATE_LOG" 2>/dev/null || true
    fi
fi
