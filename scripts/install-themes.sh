#!/bin/bash
# Theme Installation Script
# Installs Catppuccin themes for GTK, Icons, and Cursors

set -e

echo "Installing Catppuccin Mocha Theme..."

# Check if yay or paru is available
if command -v yay &>/dev/null; then
    AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
    AUR_HELPER="paru"
else
    echo "Warning: No AUR helper found. Install yay or paru first."
    echo "Skipping theme installation..."
    exit 0
fi

# Install Catppuccin GTK Theme
echo "Installing Catppuccin GTK theme..."
$AUR_HELPER -S --needed --noconfirm catppuccin-gtk-theme-mocha

# Install Papirus Icon Theme
echo "Installing Papirus icon theme..."
$AUR_HELPER -S --needed --noconfirm papirus-icon-theme

# Install Catppuccin Cursor Theme
echo "Installing Catppuccin cursor theme..."
$AUR_HELPER -S --needed --noconfirm catppuccin-cursors-mocha

# Install Kvantum theme engine for Qt
echo "Installing Kvantum..."
$AUR_HELPER -S --needed --noconfirm kvantum-qt5

# Install Catppuccin Kvantum theme
echo "Installing Catppuccin Kvantum theme..."
$AUR_HELPER -S --needed --noconfirm catppuccin-kvantum-theme-mocha

echo ""
echo "Themes installed successfully!"
echo ""
echo "To apply themes:"
echo "  - GTK: lxappearance or nwg-look (Wayland)"
echo "  - Qt: qt5ct"
echo "  - Icons: Already configured in dotfiles"
echo ""
echo "Note: You may need to log out and log back in for all changes to take effect."