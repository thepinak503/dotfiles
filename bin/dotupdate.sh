#!/usr/bin/env bash
# =============================================================================
# Dotfiles Auto-Update & Log Tracker
# Checks for upstream changes and summarizes updates since installation.
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
STATE_DIR="$HOME/.local/share/dotfiles"
INSTALL_DATE_FILE="$STATE_DIR/install_date"
LAST_CHECK_FILE="$STATE_DIR/last_update_check"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

cd "$DOTFILES_DIR" || exit 1

# --- 1. Fetch Latest Changes ---
echo -e "${CYAN}Checking for dotfiles updates...${NC}"
git fetch --quiet origin main

# --- 2. Check for Desync ---
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    echo -e "${GREEN}✓ Dotfiles are up to date.${NC}"
elif [ "$LOCAL" = "$BASE" ] || [ "$LOCAL" != "$REMOTE" ]; then
    echo -e "${YELLOW}⚡ Updates available!${NC}"
    echo -e "\n${BOLD}New commits since your local version:${NC}"
    git log --oneline --graph --decorate --color HEAD..@{u}
    
    [[ -f "$INSTALL_DATE_FILE" ]] && echo -e "\n${CYAN}Updates since your first install ($(cat "$INSTALL_DATE_FILE")):${NC}"
    
    echo -e "\nWould you like to pull and auto-resolve any conflicts? [y/N] "
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${CYAN}Pulling with auto-resolution (preferring upstream fixes)...${NC}"
        # --autostash handles dirty trees, -X theirs resolves conflicts by preferring incoming changes
        git pull --rebase --autostash -X theirs origin main
        
        # Remove the notification flag
        rm -f "$STATE_DIR/update_ready" 2>/dev/null
        
        echo -e "${GREEN}✓ Updated and re-synced!${NC}"
    fi
else
    echo -e "${RED}⚠ Local and Remote have diverged!${NC}"
    echo "Attempting to auto-fix via rebase..."
    git pull --rebase --autostash -X theirs origin main && echo -e "${GREEN}✓ Auto-fixed.${NC}" || echo -e "${RED}✗ Manual fix still required.${NC}"
fi

# Update last check timestamp
date +%s > "$LAST_CHECK_FILE"
