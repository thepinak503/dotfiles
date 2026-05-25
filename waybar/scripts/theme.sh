#!/usr/bin/env sh
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hyprland-theme"
THEME_SCRIPT="$HOME/.local/share/dotfiles/themes/theme.sh"

if [ "$1" = "toggle" ]; then
    if [ -f "$STATE_FILE" ]; then
        CURRENT=$(cat "$STATE_FILE")
        if [ "$CURRENT" = "dark" ]; then
            exec "$THEME_SCRIPT" light
        else
            exec "$THEME_SCRIPT" dark
        fi
    else
        exec "$THEME_SCRIPT" dark
    fi
    exit 0
fi

if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="dark"
fi

if [ "$CURRENT" = "dark" ]; then
    echo '{"text":"  ","tooltip":"Dark mode — click to toggle","class":"dark"}'
else
    echo '{"text":"  ","tooltip":"Light mode — click to toggle","class":"light"}'
fi
