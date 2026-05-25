#!/bin/bash
# Open calendar — fallback to xdg-open if gnome-calendar not installed
set -euo pipefail
if command -v gnome-calendar &>/dev/null; then
    gnome-calendar
else
    xdg-open 'https://calendar.google.com' 2>/dev/null || \
    notify-send -a waybar -u low "Calendar" "No calendar app found — install gnome-calendar" 2>/dev/null || true
fi
