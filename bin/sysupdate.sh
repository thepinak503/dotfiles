#!/usr/bin/env bash

# Cross-platform, safe system update script
echo "🔄 Starting System Update..."

if command -v paru >/dev/null 2>&1; then
    paru -Syu
elif command -v yay >/dev/null 2>&1; then
    yay -Syu
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu
elif command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt upgrade -y
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf upgrade -y
elif command -v zypper >/dev/null 2>&1; then
    sudo zypper update -y
elif command -v brew >/dev/null 2>&1; then
    brew update && brew upgrade
else
    echo "❌ No supported package manager found!"
    exit 1
fi

echo "✅ Update Complete!"
echo "🚀 Generating System Summary..."
sleep 1
clear
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
elif command -v neofetch >/dev/null 2>&1; then
    neofetch
fi
