#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
THEMES_DIR="$REPO_DIR/themes"
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hyprland-theme"

usage() {
    echo "Usage: $0 {dark|light}"
    echo "  dark   — Apply Nord dark theme"
    echo "  light  — Apply light theme"
    exit 1
}

if [ $# -ne 1 ]; then usage; fi

case "$1" in
    dark|light) THEME="$1" ;;
    *) usage ;;
esac

echo "→ Switching to $THEME theme..."

# ---------------------------------------------------------------------------
# 1. Hyprland Lua config — replace theme.lua
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/$THEME.lua" "$REPO_DIR/hypr/configs/theme.lua"

# ---------------------------------------------------------------------------
# 2. Waybar
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/waybar-$THEME.css" "$REPO_DIR/waybar/style.css"

# ---------------------------------------------------------------------------
# 3. Rofi
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/rofi-$THEME.rasi" "$REPO_DIR/rofi/themes/nord.rasi"

# ---------------------------------------------------------------------------
# 4. Swaync
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/swaync-$THEME.css" "$REPO_DIR/swaync/style.css"

# ---------------------------------------------------------------------------
# 5. Wlogout
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/wlogout-$THEME.css" "$REPO_DIR/wlogout/style.css"

# ---------------------------------------------------------------------------
# 6. SwayOSD
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/swayosd-$THEME.css" "$REPO_DIR/swayosd/style.css"

# ---------------------------------------------------------------------------
# 7. Kitty
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/kitty-$THEME.conf" "$REPO_DIR/kitty/nord.conf"

# ---------------------------------------------------------------------------
# 8. Hyprlock
# ---------------------------------------------------------------------------
cp "$THEMES_DIR/hyprlock-$THEME.conf" "$REPO_DIR/hypr/hyprlock.conf"

# ---------------------------------------------------------------------------
# 9. Alacritty — swap import line
# ---------------------------------------------------------------------------
ALACRITTY_CFG="$REPO_DIR/alacritty/alacritty.toml"
if [ "$THEME" = "dark" ]; then
    sed -i 's|import = \["~/.local/share/dotfiles/themes/alacritty-light.toml"\]|import = ["~/.local/share/dotfiles/themes/alacritty-dark.toml"]|' "$ALACRITTY_CFG"
    sed -i 's|decorations_theme_variant = "Light"|decorations_theme_variant = "Dark"|' "$ALACRITTY_CFG"
else
    sed -i 's|import = \["~/.local/share/dotfiles/themes/alacritty-dark.toml"\]|import = ["~/.local/share/dotfiles/themes/alacritty-light.toml"]|' "$ALACRITTY_CFG"
    sed -i 's|decorations_theme_variant = "Dark"|decorations_theme_variant = "Light"|' "$ALACRITTY_CFG"
fi

# ---------------------------------------------------------------------------
# 10. Fastfetch — update 256-color codes
# ---------------------------------------------------------------------------
FASTFETCH_CFG="$REPO_DIR/apps/fastfetch/config.jsonc"
if [ "$THEME" = "dark" ]; then
    sed -i 's/"keys": "38;5;24"/"keys": "38;5;110"/g; s/"title": "38;5;23"/"title": "38;5;152"/g' "$FASTFETCH_CFG"
else
    sed -i 's/"keys": "38;5;110"/"keys": "38;5;24"/g; s/"title": "38;5;152"/"title": "38;5;23"/g' "$FASTFETCH_CFG"
fi

# ---------------------------------------------------------------------------
# 11. Wallpaper — pick appropriate wallpaper for the theme
# ---------------------------------------------------------------------------
if [ "$THEME" = "light" ]; then
    WALLPAPER=$("$REPO_DIR/hypr/scripts/wallpaper-fetch" --light --quiet 2>/dev/null || true)
else
    WALLPAPER=$("$REPO_DIR/hypr/scripts/wallpaper-fetch" --dark --quiet 2>/dev/null || true)
fi
if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    WALLPAPER="$(find "$REPO_DIR/wallpapers" -name 'nord_*.png' -not -name 'nord_light.png' | head -1)"
fi
if [ -z "$WALLPAPER" ]; then
    WALLPAPER="$REPO_DIR/wallpapers/nord_default.png"
fi

# ---------------------------------------------------------------------------
# 12. GTK theme — affects Firefox, OnlyOffice, Nautilus, and other GTK apps
# ---------------------------------------------------------------------------
if command -v gsettings >/dev/null 2>&1; then
    if [ "$THEME" = "dark" ]; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true
    else
        gsettings set org.gnome.desktop.interface color-scheme 'default' 2>/dev/null || true
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' 2>/dev/null || true
    fi
fi

# Also write GTK settings.ini as a fallback
GTK3_CFG="$HOME/.config/gtk-3.0/settings.ini"
mkdir -p "$(dirname "$GTK3_CFG")"
if [ "$THEME" = "dark" ]; then
    cat > "$GTK3_CFG" << EOF
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-font-name=Noto Sans 10
EOF
else
    cat > "$GTK3_CFG" << EOF
[Settings]
gtk-application-prefer-dark-theme=0
gtk-theme-name=Adwaita
gtk-font-name=Noto Sans 10
EOF
fi

# ---------------------------------------------------------------------------
# 13. Save state
# ---------------------------------------------------------------------------
echo "$THEME" > "$STATE_FILE"

# ---------------------------------------------------------------------------
# 14. Restart / reload services
# ---------------------------------------------------------------------------
echo "→ Reloading services..."

# Hyprland
hyprctl reload 2>/dev/null || true

# Waybar
if pgrep -x waybar >/dev/null 2>&1; then
    killall waybar 2>/dev/null || true
    sleep 0.3
    waybar &
fi

# Swaync
if pgrep -x swaync >/dev/null 2>&1; then
    swaync-client --reload-css 2>/dev/null || true
fi

# SwayOSD
if pgrep -x swayosd-server >/dev/null 2>&1; then
    killall swayosd-server 2>/dev/null || true
    sleep 0.3
    swayosd-server &
fi

# Kitty — set colors in running instances
if command -v kitty >/dev/null 2>&1 && [ -S /tmp/kitty 2>/dev/null ] || [ -S /tmp/kitty-* 2>/dev/null ]; then
    KITTY_SOCKET=$(ls /tmp/kitty-* 2>/dev/null | head -1)
    if [ -n "$KITTY_SOCKET" ]; then
        kitty @ --to "unix:$KITTY_SOCKET" set-colors --all "$REPO_DIR/kitty/nord.conf" 2>/dev/null || true
    fi
fi

# Alacritty — send SIGHUP to reload config (if live_config_reload is not on)
if command -v alacritty >/dev/null 2>&1; then
    pkill -HUP alacritty 2>/dev/null || true
fi

echo "✓ $THEME theme applied"
