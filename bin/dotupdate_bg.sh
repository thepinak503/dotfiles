#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
LAST_CHECK_FILE="$DOTFILES_STATE_DIR/last_update_check"
AUTO_UPDATE_LOG="$DOTFILES_STATE_DIR/autoupdate.log"
cd "$DOTFILES_DIR" || exit
git fetch origin main &>/dev/null || exit
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})
if [ "$LOCAL" != "$REMOTE" ]; then
    NOW=$(date +%s)
    LAST_CHECK=$(cat "$LAST_CHECK_FILE" 2>/dev/null || echo 0)
    if (( NOW - LAST_CHECK > 604800 )); then
        echo "UPDATE_READY" > "$DOTFILES_STATE_DIR/update_ready"
        echo "$NOW" > "$LAST_CHECK_FILE"
    fi
fi
