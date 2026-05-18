#!/usr/bin/env bash
set -e

echo ":: Removing symlinks..."
[ -L "$HOME/.config/waybar" ] && rm "$HOME/.config/waybar"
[ -d "$HOME/.config/waybar.bak" ] && mv "$HOME/.config/waybar.bak" "$HOME/.config/waybar"

echo ":: Restoring original hyprland.conf..."
if [ -f "$HOME/.config/hypr/hyprland.conf.bak" ]; then
  mv "$HOME/.config/hypr/hyprland.conf.bak" "$HOME/.config/hypr/hyprland.conf"
fi

echo ":: Done. Configs restored."
