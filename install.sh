#!/usr/bin/env sh
DOTFILES_REPO="https://github.com/thepinak503/dotfiles.git"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
if [ -t 1 ]; then
    CYAN='\033[0;36m' BOLD='\033[1m' NC='\033[0m'
else
    CYAN='' BOLD='' NC=''
fi
clear
printf "${CYAN}${BOLD}"
printf "  ┌───────────────────────────────────────────┐\n"
printf "  │        SUPREME DOTFILES BOOTSTRAP         │\n"
printf "  └───────────────────────────────────────────┘\n"
printf "${NC}\n"
if ! command -v git >/dev/null 2>&1; then
    echo "Git is missing. Please install git first."
    exit 1
fi
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "Updating existing dotfiles in $DOTFILES_DIR..."
    (cd "$DOTFILES_DIR" && git pull origin main)
fi
if [ -f "$DOTFILES_DIR/install/install.sh" ]; then
    export DOTFILES_DIR
    sh "$DOTFILES_DIR/install/install.sh"
else
    echo "Could not find internal installer."
    exit 1
fi
