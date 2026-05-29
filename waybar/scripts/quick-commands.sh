#!/usr/bin/env bash
# =============================================================================
# QUICK COMMANDS — Bottom bar action buttons
# =============================================================================
# Displays interactive quick-action icons in the waybar bottom bar.
# Click actions are configured in config-bottom.jsonc.
# =============================================================================

# Get current nightlight state
NIGHT=$(cat /tmp/nightlight-mode 2>/dev/null || echo "off")
if [ "$NIGHT" = "on" ]; then
    NIGHT_ICON=""
else
    NIGHT_ICON=""
fi

# Get current gamemode state
GM=$(cat /tmp/hypr-gamemode 2>/dev/null || echo "off")
if [ "$GM" = "on" ]; then
    GM_ICON="🎮"
else
    GM_ICON=""
fi

echo "{\"text\":\"           ${GM_ICON} ${NIGHT_ICON}  \",\"tooltip\":\"Quick actions: Power | Settings | Search | Windows | Theme | Game | Night\",\"class\":\"\"}"
