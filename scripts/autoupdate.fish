#!/usr/bin/env fish
# =============================================================================
# DOTFILES AUTO-UPDATE SCRIPT - Fish Version
# Checks for updates periodically and auto-updates dotfiles
# =============================================================================

# Configuration
set -g DOTFILES_UPDATE_INTERVAL 86400  # Default: 1 day
set -g DOTFILES_AUTO_UPDATE true
set -g DOTFILES_UPDATE_BRANCH main

function dotfiles_autoupdate
    set -l dotfiles_dir "$DOTFILES_DIR"
    test -z "$dotfiles_dir"; and set dotfiles_dir "$HOME/.dotfiles"
    
    set -l last_update_file "$dotfiles_dir/.last-update"
    set -l current_time (date +%s)
    set -l last_update 0
    
    # Check if git is available
    if not type -q git
        return 1
    end
    
    # Check if dotfiles is a git repo
    if not test -d "$dotfiles_dir/.git"
        return 1
    end
    
    # Check last update time
    if test -f "$last_update_file"
        set last_update (cat "$last_update_file")
    end
    
    set -l time_diff (math "$current_time - $last_update")
    
    # Check if enough time has passed
    if test "$time_diff" -lt "$DOTFILES_UPDATE_INTERVAL"
        return 0
    end
    
    # Save current directory
    set -l original_dir (pwd)
    cd "$dotfiles_dir"
    
    # Fetch latest changes
    git fetch origin "$DOTFILES_UPDATE_BRANCH" 2>/dev/null
    
    # Check if there are changes
    set -l local_hash (git rev-parse HEAD 2>/dev/null)
    set -l remote_hash (git rev-parse "origin/$DOTFILES_UPDATE_BRANCH" 2>/dev/null)
    
    if test "$local_hash" != "$remote_hash" -a -n "$remote_hash"
        if test "$DOTFILES_AUTO_UPDATE" = "true"
            echo "🔄 Updating dotfiles..."
            
            # Stash local changes if any
            git stash -q 2>/dev/null
            
            # Pull latest changes
            git pull origin "$DOTFILES_UPDATE_BRANCH" -q
            
            # Update submodules if any
            git submodule update --init --recursive -q 2>/dev/null
            
            # Update last update time
            echo "$current_time" > "$last_update_file"
            
            echo "✅ Dotfiles updated! Restart your shell or run 'exec fish' to apply changes."
        else
            echo "📦 Dotfiles update available! Run 'cd $dotfiles_dir && git pull' to update."
        end
    end
    
    # Update last check time
    echo "$current_time" > "$last_update_file"
    
    # Return to original directory
    cd "$original_dir" 2>/dev/null
end

# Manual update function
function dotfiles_update
    set -gx DOTFILES_VERBOSE true
    set -gx DOTFILES_AUTO_UPDATE true
    dotfiles_autoupdate
end

# Check for updates on shell startup (non-blocking)
if test "$DOTFILES_AUTO_UPDATE" != "false"
    dotfiles_autoupdate &
end
