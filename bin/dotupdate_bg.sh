#!/usr/bin/env bash
# =============================================================================
# scripts/dotupdate_bg.sh — Background update checker for Pinak's Dotfiles
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
LAST_CHECK_FILE="$DOTFILES_STATE_DIR/last_update_check"
AUTO_UPDATE_LOG="$DOTFILES_STATE_DIR/autoupdate.log"

# 1. FETCH UPDATES SLYLY
cd "$DOTFILES_DIR" || exit
git fetch origin main &>/dev/null || exit

# 2. CHECK FOR CHANGES
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
    # Changes detected!
    NOW=$(date +%s)
    LAST_CHECK=$(cat "$LAST_CHECK_FILE" 2>/dev/null || echo 0)
    
    # Check if a week has passed (604800 seconds)
    if (( NOW - LAST_CHECK > 604800 )); then
        # It's time to ask/notify
        echo "UPDATE_READY" > "$DOTFILES_STATE_DIR/update_ready"
        echo "$NOW" > "$LAST_CHECK_FILE"
    fi
    
    # Auto-resolve conflicts if configured (rebase with autostash is usually best)
    # The user asked to "autoresolbe it" if changes exist.
    # We'll do this in the foreground script when they accept, or background if fully auto.
    # For now, we just notify.
fi
