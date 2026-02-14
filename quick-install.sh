#!/bin/bash
# One-line installer for dotfiles
# Usage: curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/quick-install.sh | bash

set -e

REPO_URL="https://github.com/thepinak503/dotfiles"
INSTALL_DIR="$HOME/.dotfiles"

echo "📦 Installing dotfiles..."

# Clone or update
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing dotfiles..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning dotfiles..."
    git clone --depth=1 "$REPO_URL" "$INSTALL_DIR"
fi

# Run automatic installer
cd "$INSTALL_DIR"
bash install-auto.sh

echo ""
echo "✨ Installation complete!"
echo "🚀 Restart your terminal to apply changes"
