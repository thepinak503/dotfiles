#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
LAST_CHECK_FILE="$DOTFILES_STATE_DIR/last_update_check"
ROLLBACK_TAG="dotfiles-rollback-$(date +%s)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

AUTO_YES=0
for arg in "$@"; do [ "$arg" = "--yes" ] || [ "$arg" = "-y" ] && AUTO_YES=1; done

cd "$DOTFILES_DIR" || { echo -e "${RED}✗ $DOTFILES_DIR not found${NC}"; exit 1; }

echo -e "${CYAN}Checking for dotfiles updates...${NC}"

# Ensure it's a git repo
if [ ! -d .git ]; then
    echo -e "${RED}✗ Not a git repository${NC}"; exit 1
fi

# Check for remote
if ! git remote -v | grep -q fetch; then
    echo -e "${YELLOW}⚠ No git remote configured, skipping update${NC}"; exit 0
fi

# Detect current branch
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
if [ -z "$BRANCH" ]; then
    echo -e "${RED}✗ Detached HEAD — cannot update automatically${NC}"; exit 1
fi

# Stash dirty worktree
HAS_STASH=0
if ! git diff --quiet HEAD 2>/dev/null; then
    echo -e "${YELLOW}⚠ Uncommitted changes detected, stashing...${NC}"
    git stash push -u -m "dotupdate-auto-stash-$(date +%s)" || true
    HAS_STASH=1
fi

git fetch --quiet origin "$BRANCH" 2>/dev/null || {
    echo -e "${RED}✗ Failed to fetch from origin/$BRANCH${NC}"
    [ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
    exit 1
}

LOCAL=$(git rev-parse @ 2>/dev/null || echo "")
REMOTE=$(git rev-parse "@{u}" 2>/dev/null || echo "")
BASE=$(git merge-base @ "@{u}" 2>/dev/null || echo "")

if [ -z "$LOCAL" ] || [ -z "$REMOTE" ]; then
    echo -e "${RED}✗ Cannot determine revision state${NC}"
    [ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
    exit 1
fi

if [ "$LOCAL" = "$REMOTE" ]; then
    echo -e "${GREEN}✓ Dotfiles are up to date.${NC}"
    [ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
    date +%s > "$LAST_CHECK_FILE"
    exit 0
fi

if [ "$LOCAL" = "$BASE" ]; then
    echo -e "${YELLOW}⚡ Updates available!${NC}"
    echo -e "\n${BOLD}New commits:${NC}"
    git log --oneline --graph --decorate --color HEAD..@{u}

    if [ "$AUTO_YES" = 0 ]; then
        echo -e "\nPull updates? [y/N] "
        read -r response
    else
        response="y"
    fi

    if [[ "$response" =~ ^[yY] ]]; then
        # Tag for rollback
        git tag -f "$ROLLBACK_TAG" HEAD 2>/dev/null || true

        if git pull --rebase --autostash -X theirs origin "$BRANCH"; then
            echo -e "${GREEN}✓ Updated to latest ($(git rev-parse --short HEAD))${NC}"
            git tag -d "$ROLLBACK_TAG" 2>/dev/null || true
        else
            echo -e "${RED}✗ Update failed! Rolling back...${NC}"
            git reset --hard "$ROLLBACK_TAG" 2>/dev/null || true
            git tag -d "$ROLLBACK_TAG" 2>/dev/null || true
            echo -e "${YELLOW}⚠ Rolled back to previous version${NC}"
            [ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
            exit 1
        fi
    fi
else
    echo -e "${RED}⚠ Local and remote have diverged${NC}"
    git tag -f "$ROLLBACK_TAG" HEAD 2>/dev/null || true
    if git pull --rebase --autostash -X theirs origin "$BRANCH"; then
        echo -e "${GREEN}✓ Auto-fixed via rebase${NC}"
        git tag -d "$ROLLBACK_TAG" 2>/dev/null || true
    else
        echo -e "${RED}✗ Cannot auto-rebase. Manual fix needed.${NC}"
        echo -e "${YELLOW}  Rollback: git reset --hard $ROLLBACK_TAG${NC}"
        echo -e "${YELLOW}  Or: git merge origin/$BRANCH${NC}"
        [ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
        exit 1
    fi
fi

[ "$HAS_STASH" = 1 ] && git stash pop 2>/dev/null || true
date +%s > "$LAST_CHECK_FILE"
