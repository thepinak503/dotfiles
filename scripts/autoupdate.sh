#!/usr/bin/env bash
# =============================================================================
# DOTFILES AUTO-UPDATE SCRIPT
# Checks for updates periodically and auto-updates dotfiles
# =============================================================================

DOTFILES_UPDATE_INTERVAL="${DOTFILES_UPDATE_INTERVAL:-86400}"  # Default: 1 day
DOTFILES_AUTO_UPDATE="${DOTFILES_AUTO_UPDATE:-false}"
DOTFILES_UPDATE_BRANCH="${DOTFILES_UPDATE_BRANCH:-main}"

dotfiles_autoupdate() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local last_update_file="$dotfiles_dir/.last-update"
    local current_time
    local last_update
    local time_diff
    
    # Check if git is available
    if ! command -v git &>/dev/null; then
        [[ "$DOTFILES_VERBOSE" == "true" ]] && echo "Git not found, skipping update check"
        return 1
    fi
    
    # Check if dotfiles is a git repo
    if [[ ! -d "$dotfiles_dir/.git" ]]; then
        [[ "$DOTFILES_VERBOSE" == "true" ]] && echo "Dotfiles is not a git repo, skipping update check"
        return 1
    fi
    
    current_time=$(date +%s)
    
    # Check last update time
    if [[ -f "$last_update_file" ]]; then
        last_update=$(cat "$last_update_file")
    else
        last_update=0
    fi
    
    time_diff=$((current_time - last_update))
    
    # Check if enough time has passed
    if [[ $time_diff -lt $DOTFILES_UPDATE_INTERVAL ]]; then
        [[ "$DOTFILES_VERBOSE" == "true" ]] && echo "Update check skipped. Next check in $(( (DOTFILES_UPDATE_INTERVAL - time_diff) / 3600 )) hours"
        return 0
    fi
    
    # Save current directory
    local original_dir
    original_dir=$(pwd)
    
    cd "$dotfiles_dir" || return 1
    
    # Check for updates
    local has_updates=false
    
    # Fetch latest changes
    git fetch origin "$DOTFILES_UPDATE_BRANCH" 2>/dev/null
    
    # Check if there are changes
    local local_hash remote_hash
    local_hash=$(git rev-parse HEAD 2>/dev/null)
    remote_hash=$(git rev-parse "origin/$DOTFILES_UPDATE_BRANCH" 2>/dev/null)
    
    if [[ "$local_hash" != "$remote_hash" ]] && [[ -n "$remote_hash" ]]; then
        has_updates=true
    fi
    
    if [[ "$has_updates" == "true" ]]; then
        if [[ "$DOTFILES_AUTO_UPDATE" == "true" ]]; then
            echo "🔄 Updating dotfiles..."
            
            # Stash local changes if any
            git stash -q 2>/dev/null || true
            
            # Pull latest changes
            git pull origin "$DOTFILES_UPDATE_BRANCH" -q
            
            # Update submodules if any
            git submodule update --init --recursive -q 2>/dev/null || true
            
            # Update last update time
            echo "$current_time" > "$last_update_file"
            
            echo "✅ Dotfiles updated! Restart your shell or run 'source ~/.bashrc' to apply changes."
            
            # Notify about shell restart
            echo "ℹ️  Run 'source ~/.bashrc' or 'source ~/.zshrc' to reload config"
        else
            echo "📦 Dotfiles update available! Run 'cd $dotfiles_dir && git pull' to update."
        fi
    else
        [[ "$DOTFILES_VERBOSE" == "true" ]] && echo "✓ Dotfiles are up to date"
    fi
    
    # Update last check time even if no updates
    echo "$current_time" > "$last_update_file"
    
    # Return to original directory
    cd "$original_dir" 2>/dev/null || true
}

# Start update daemon in background (optional)
dotfiles_update_daemon() {
    local check_interval="${DOTFILES_UPDATE_INTERVAL:-86400}"
    
    while true; do
        dotfiles_autoupdate
        sleep "$check_interval"
    done
}

# Manual update function
dotfiles_update() {
    DOTFILES_VERBOSE=true DOTFILES_AUTO_UPDATE=true dotfiles_autoupdate
}

# Check for updates on shell startup (non-blocking)
if [[ "$DOTFILES_AUTO_UPDATE" != "false" ]]; then
    # Run in background, suppress all output and job notification
    dotfiles_autoupdate &>/dev/null &
    setopt NO_HUP 2>/dev/null || true
fi
