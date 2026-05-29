#!/usr/bin/env bash
# ============================================================================
# Auto Theme Switcher — toggles light/dark mode based on sun elevation
# ============================================================================
set -euo pipefail

# Default coordinates (Pune, India)
LAT=18.5211
LNG=73.8502

# Fallback hours (local time)
FALLBACK_SUNRISE_HOUR=6
FALLBACK_SUNSET_HOUR=18

# Get current state
STATE_FILE="$HOME/.cache/hyprland-theme"
CURRENT_THEME=$(cat "$STATE_FILE" 2>/dev/null || echo "")

# 1. Get coordinates
if coords=$(curl -s --max-time 5 https://ipapi.co/json/ 2>/dev/null); then
    if command -v jq &>/dev/null; then
        LAT=$(echo "$coords" | jq -r '.latitude // 18.5211')
        LNG=$(echo "$coords" | jq -r '.longitude // 73.8502')
        # Validate coordinates are valid float numbers to prevent injection/malformed input
        if [[ ! "$LAT" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then LAT="18.5211"; fi
        if [[ ! "$LNG" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then LNG="73.8502"; fi
    fi
fi

# 2. Get solar times
sunrise_str=""
sunset_str=""
if sun_times=$(curl -s --max-time 5 -H "User-Agent: Mozilla/5.0" "https://api.sunrise-sunset.org/json?lat=${LAT}&lng=${LNG}&formatted=0" 2>/dev/null); then
    if command -v jq &>/dev/null; then
        status=$(echo "$sun_times" | jq -r '.status // "FAIL"')
        if [ "$status" = "OK" ]; then
            sunrise_str=$(echo "$sun_times" | jq -r '.results.sunrise // empty')
            sunset_str=$(echo "$sun_times" | jq -r '.results.sunset // empty')
        fi
    fi
fi

theme=""
if [[ -n "$sunrise_str" ]] && [[ -n "$sunset_str" ]]; then
    # Parse timestamps using date
    sunrise_epoch=$(date -d "$sunrise_str" +%s 2>/dev/null || echo "0")
    sunset_epoch=$(date -d "$sunset_str" +%s 2>/dev/null || echo "0")
    now_epoch=$(date +%s)

    if [ "$sunrise_epoch" -gt 0 ] && [ "$sunset_epoch" -gt 0 ]; then
        echo "Coordinates: ($LAT, $LNG)"
        echo "Sunrise: $sunrise_str (Epoch: $sunrise_epoch)"
        echo "Sunset: $sunset_str (Epoch: $sunset_epoch)"
        echo "Current: $(date -u -d "@$now_epoch" '+%Y-%m-%dT%H:%M:%SZ') (Epoch: $now_epoch)"

        if [ "$now_epoch" -ge "$sunrise_epoch" ] && [ "$now_epoch" -lt "$sunset_epoch" ]; then
            theme="light"
        else
            theme="dark"
        fi
    fi
fi

if [[ -z "$theme" ]]; then
    echo "Offline or API error, running local hour fallback..."
    hour=$(date +%-H)
    echo "Current local hour: $hour"
    if [ "$hour" -ge "$FALLBACK_SUNRISE_HOUR" ] && [ "$hour" -lt "$FALLBACK_SUNSET_HOUR" ]; then
        theme="light"
    else
        theme="dark"
    fi
fi

# Apply theme
THEME_SCRIPT="$HOME/.local/share/dotfiles/themes/theme.sh"
if [ "$CURRENT_THEME" != "$theme" ]; then
    echo "Switching theme to: $theme"
    if [ -x "$THEME_SCRIPT" ]; then
        bash "$THEME_SCRIPT" "$theme"
    else
        echo "Error: theme.sh not found or not executable" >&2
        exit 1
    fi
else
    echo "Theme is already '$theme', no reload needed."
fi
