#!/usr/bin/env sh
# =============================================================================
# PINAK'S DOTFILES BOOTSTRAP
# Installs dotfiles to ~/.local/share/dotfiles and creates symlinks in ~
# =============================================================================

set -euo pipefail
DOTFILES_REPO="https://github.com/thepinak503/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"

if [ -t 1 ]; then
    CYAN='\033[0;36m' BOLD='\033[1m' GREEN='\033[0;32m' RED='\033[0;31m' NC='\033[0m'
else
    CYAN='' BOLD='' GREEN='' RED='' NC=''
fi

clear
printf "${CYAN}${BOLD}"
printf "  ┌───────────────────────────────────────────┐\n"
printf "  │          PINAK'S DOTFILES BOOTSTRAP       │\n"
printf "  └───────────────────────────────────────────┘\n"
printf "${NC}\n"
printf "  Location: ${GREEN}$DOTFILES_DIR${NC}\n\n"

if ! command -v git >/dev/null 2>&1; then
    printf "${RED}✗ Git is missing. Please install git first.${NC}\n"
    exit 1
fi

if [ -d "$DOTFILES_DIR" ]; then
    printf "${GREEN}✓${NC} Dotfiles directory exists. Updating...\n"
    if ! (cd "$DOTFILES_DIR" && git pull --ff-only origin main); then
        printf "${RED}✗ Failed to update dotfiles. Check for uncommitted changes:${NC}\n"
        printf "  cd %s && git status\n" "$DOTFILES_DIR"
        exit 1
    fi
else
    printf "${GREEN}✓${NC} Cloning dotfiles to $DOTFILES_DIR...\n"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Validate install script exists
if [ ! -f "$DOTFILES_DIR/install/install.sh" ]; then
    printf "${RED}✗ Install script not found after clone/update.${NC}\n"
    exit 1
fi

# Make executable
chmod +x "$DOTFILES_DIR/install/install.sh"

# Run the actual installer
export DOTFILES_DIR
sh "$DOTFILES_DIR/install/install.sh"