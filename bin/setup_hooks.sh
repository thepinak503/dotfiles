#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
HOOK_FILE="$DOTFILES_DIR/.git/hooks/pre-commit"
if [ -f "$HOOK_FILE" ]; then
    echo "Removing old pre-commit hook (auto-stage was a security risk)..."
    rm -f "$HOOK_FILE"
fi
echo "Pre-commit hook removed. Use 'git add' manually for all files."
