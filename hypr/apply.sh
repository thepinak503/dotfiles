#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.local/share/dotfiles"

echo ":: Detecting package manager for dependencies..."
if command -v pacman >/dev/null 2>&1; then
    PM="pacman"
    INSTALL_CMD="sudo pacman -S --needed --noconfirm"
    PKGS="waybar rofi hyprlock hypridle hyprpaper swww dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol network-manager-applet polkit-gnome wl-clipboard otf-firamono-nerd ttf-jetbrains-mono-nerd imagemagick"
elif command -v apt-get >/dev/null 2>&1; then
    PM="apt"
    INSTALL_CMD="sudo apt-get install -y"
    PKGS="waybar rofi hyprlock hypridle hyprpaper dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol network-manager policykit-1-gnome wl-clipboard fonts-firacode fonts-jetbrains-mono imagemagick"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
    INSTALL_CMD="sudo dnf install -y"
    PKGS="waybar rofi hyprlock hypridle hyprpaper dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol network-manager-applet polkit-gnome wl-clipboard fira-code-fonts jetbrains-mono-fonts ImageMagick"
elif command -v zypper >/dev/null 2>&1; then
    PM="zypper"
    INSTALL_CMD="sudo zypper install -y"
    PKGS="waybar rofi hyprlock hypridle hyprpaper dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol NetworkManager-applet polkit-gnome wl-clipboard fira-code-fonts jetbrains-mono-fonts ImageMagick"
elif command -v apk >/dev/null 2>&1; then
    PM="apk"
    INSTALL_CMD="sudo apk add"
    PKGS="waybar rofi hyprlock hypridle hyprpaper dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol network-manager-applet polkit-gnome wl-clipboard font-fira-code font-jetbrains-mono imagemagick"
elif command -v xbps-install >/dev/null 2>&1; then
    PM="xbps"
    INSTALL_CMD="sudo xbps-install -y"
    PKGS="waybar rofi hyprlock hypridle dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol NetworkManager polkit-gnome wl-clipboard nerd-fonts imagemagick"
elif command -v emerge >/dev/null 2>&1; then
    PM="emerge"
    INSTALL_CMD="sudo emerge --ask=n"
    PKGS="gui-apps/waybar x11-misc/rofi gui-apps/hyprlock gui-apps/hypridle gui-apps/hyprpaper x11-misc/dunst gui-apps/grim gui-apps/slurp gui-apps/wl-clipboard media-sound/playerctl sys-apps/brightnessctl media-sound/pavucontrol gnome-extra/polkit-gnome media-gfx/imagemagick"
elif command -v nix-env >/dev/null 2>&1; then
    PM="nix"
    INSTALL_CMD="nix profile install"
    PKGS="nixpkgs.waybar nixpkgs.rofi nixpkgs.hyprlock nixpkgs.hypridle nixpkgs.hyprpaper nixpkgs.dunst nixpkgs.wlogout nixpkgs.grim nixpkgs.slurp nixpkgs.cliphist nixpkgs.playerctl nixpkgs.brightnessctl nixpkgs.pavucontrol nixpkgs.networkmanagerapplet nixpkgs.polkit_gnome nixpkgs.wl-clipboard nixpkgs.fira-code-nerdfont nixpkgs.jetbrains-mono nixpkgs.imagemagick"
else
    echo ":: Unsupported package manager. Please install dependencies manually:"
    echo "waybar rofi hyprlock hypridle hyprpaper swww dunst wlogout grim slurp cliphist playerctl brightnessctl pavucontrol network-manager-applet polkit-gnome wl-clipboard fonts imagemagick"
    PM="manual"
fi

if [ "$PM" != "manual" ]; then
    echo ":: Installing dependencies via $PM..."
    $INSTALL_CMD $PKGS
fi

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
