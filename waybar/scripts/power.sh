#!/usr/bin/env bash
# ============================================================================
# Waybar Power Module — shows power button and launches wlogout on click
# ============================================================================
# Displays power icon in waybar, opens wlogout power menu on click
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
WLOGOUT_CMD="${WLOGOUT_CMD:-wlogout}"
WLOGOUT_LAYOUT="${WLOGOUT_LAYOUT:-$HOME/.local/share/dotfiles/wlogout/layout}"

# ---------------------------------------------------------------------------
# Check dependencies
# ---------------------------------------------------------------------------
if ! command -v "$WLOGOUT_CMD" &>/dev/null; then
    # Even if wlogout is not available, still show the button
    true
fi

# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------
case "${1:-}" in
    click|open)
        if pgrep -x "$WLOGOUT_CMD" &>/dev/null; then
            pkill -x "$WLOGOUT_CMD" 2>/dev/null || true
        else
            "$WLOGOUT_CMD" &
        fi
        ;;

    status|"")
        # Waybar JSON output — triggers on-click action
        printf '{"text":"","tooltip":"Power Menu — Shutdown / Reboot / Lock / Logout","class":"power","alt":"power"}\n'
        ;;

    --help|-h)
        echo "Usage: $(basename "$0") [click|open|status]"
        exit 0
        ;;

    *)
        printf '{"text":"","tooltip":"Power Menu","class":"power","alt":"power"}\n'
        ;;
esac
