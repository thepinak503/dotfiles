#!/usr/bin/env bash

# Cross-platform, safe system cleanup script
echo "🧹 Starting System Cleanup..."

if command -v paru >/dev/null 2>&1; then
    paru -Sc --noconfirm
elif command -v yay >/dev/null 2>&1; then
    yay -Sc --noconfirm
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Rns $(pacman -Qtdq 2>/dev/null) 2>/dev/null || echo "Nothing to clean in pacman."
elif command -v apt >/dev/null 2>&1; then
    sudo apt autoremove -y && sudo apt clean
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf autoremove -y && sudo dnf clean all
elif command -v zypper >/dev/null 2>&1; then
    sudo zypper clean
elif command -v brew >/dev/null 2>&1; then
    brew cleanup
else
    echo "❌ No supported package manager found!"
    exit 1
fi

echo "✅ Cleanup Complete!"
