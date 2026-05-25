#!/usr/bin/env bash
# ============================================================================
# Waybar Theme Indicator — shows current theme and toggles between modes
# ============================================================================
# Supports: dark/light detection, toggle action, theme file integration
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
STATE_FILE="$STATE_DIR/hyprland-theme"
THEME_SCRIPT="$HOME/.local/share/dotfiles/themes/theme.sh"
TEMPLOCK_FILE="$STATE_DIR/hypr-theme-lock"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $(basename "$0") [toggle|dark|light|status]

Commands:
  toggle     Toggle between dark and light themes
  dark       Set dark theme
  light      Set light theme
  status     Output current theme as waybar JSON (default)

EOF
    exit 1
}

# ---------------------------------------------------------------------------
# Detect current theme
# ---------------------------------------------------------------------------
get_current_theme() {
    cat "$STATE_FILE" 2>/dev/null || echo "dark"
}

# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------
case "${1:-}" in
    toggle)
        # Use lock file to prevent concurrent toggles
        if [[ -f "$TEMPLOCK_FILE" ]]; then
            exit 0
        fi
        touch "$TEMPLOCK_FILE"
        trap 'rm -f "$TEMPLOCK_FILE"' EXIT

        CURRENT=$(get_current_theme)
        if [[ "$CURRENT" == "dark" ]]; then
            if [[ -x "$THEME_SCRIPT" ]]; then
                exec "$THEME_SCRIPT" light
            else
                notify-send -a waybar -u critical "Theme Error" "theme.sh not found"
                exit 1
            fi
        else
            if [[ -x "$THEME_SCRIPT" ]]; then
                exec "$THEME_SCRIPT" dark
            else
                notify-send -a waybar -u critical "Theme Error" "theme.sh not found"
                exit 1
            fi
        fi
        ;;

    dark)
        if [[ -x "$THEME_SCRIPT" ]]; then
            exec "$THEME_SCRIPT" dark
        fi
        ;;

    light)
        if [[ -x "$THEME_SCRIPT" ]]; then
            exec "$THEME_SCRIPT" light
        fi
        ;;

    status|"")
        CURRENT=$(get_current_theme)
        if [[ "$CURRENT" == "dark" ]]; then
            printf '{"text":"","tooltip":"Dark Mode — click to toggle","class":"dark","alt":"dark"}\n'
        else
            printf '{"text":"","tooltip":"Light Mode — click to toggle","class":"light","alt":"light"}\n'
        fi
        ;;

    --help|-h)
        usage
        ;;

    *)
        usage
        ;;
esac
