#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.local/share/dotfiles"

echo ":: Installing dependencies..."
sudo pacman -S --needed --noconfirm \
  waybar \
  rofi \
  hyprlock \
  hypridle \
  hyprpaper \
  swww \
  dunst \
  wlogout \
  grim \
  slurp \
  cliphist \
  playerctl \
  brightnessctl \
  pavucontrol \
  network-manager-applet \
  polkit-gnome \
  wl-clipboard \
  otf-firamono-nerd \
  ttf-jetbrains-mono-nerd

echo ":: Setting up config symlinks..."
# Hyprland is sourced from the main config already
# Waybar needs symlink
[ -L "$HOME/.config/waybar" ] && rm "$HOME/.config/waybar"
[ -d "$HOME/.config/waybar" ] && mv "$HOME/.config/waybar" "$HOME/.config/waybar.bak"
ln -sf "$DOTFILES/waybar" "$HOME/.config/waybar"

# Overwrite the hyprland.conf stub
mkdir -p "$HOME/.config/hypr"
cat > "$HOME/.config/hypr/hyprland.conf" << 'EOF'
source = ~/.local/share/dotfiles/hypr/hyprland.conf
EOF

echo ":: Generating Nord wallpaper..."
mkdir -p "$DOTFILES/wallpapers"
magick -size 1366x768 gradient:'#2e3440'-'#3b4252' "$DOTFILES/wallpapers/nord_default.png"

echo ":: Done! Log out and back in, or run 'hyprctl reload'."
