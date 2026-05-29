#!/usr/bin/env bash
# ============================================================================
# Power Profile — wrapper for waybar custom/power-profile module
# ============================================================================
# Gracefully returns empty JSON if power-profiles-daemon is not available,
# preventing waybar crashes on systems without the service.
# ============================================================================

set -euo pipefail

# Bail silently if powerprofilesctl isn't available
if ! command -v powerprofilesctl &>/dev/null; then
    printf '{"text":"","tooltip":"Power profiles not available","class":"disabled"}\n'
    exit 0
fi

# Check if the daemon is actually responding
profile=$(timeout 5 powerprofilesctl get 2>/dev/null) || {
    printf '{"text":"","tooltip":"Power profiles daemon not running","class":"disabled"}\n'
    exit 0
}

# Map icons
case "$profile" in
    performance) icon="" ;;
    balanced)    icon="" ;;
    power-saver) icon="" ;;
    *)           icon="" ;;
esac

printf '{"text":"%s","tooltip":"Power Profile: %s","class":"%s","alt":"%s"}\n' \
    "$icon" "$profile" "$profile" "$profile"
