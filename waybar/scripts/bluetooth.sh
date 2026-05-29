#!/usr/bin/env bash
# ============================================================================
# Bluetooth — shows BT power status and connected device count
# ============================================================================
# Uses bluetoothctl (bluez). Gracefully handles missing controller or adapter.
# ============================================================================

set -euo pipefail

# Bail if bluetoothctl not available
if ! command -v bluetoothctl &>/dev/null; then
    printf '{"text":"","tooltip":"Bluetooth not available","class":"disabled"}\n'
    exit 0
fi

# Get BT power state
power=$(timeout 5 bluetoothctl show 2>/dev/null | grep -i "Powered:" | awk '{print $2}') || power="off"

if [ "$power" != "on" ]; then
    printf '{"text":"","tooltip":"Bluetooth OFF — click to toggle","class":"off","alt":"off"}\n'
    exit 0
fi

# Count connected devices
connected=$(timeout 5 bluetoothctl devices Connected 2>/dev/null | wc -l) || connected=0
connected=$((connected + 0))  # ensure numeric

if [ "$connected" -gt 0 ]; then
    names=$(timeout 5 bluetoothctl devices Connected 2>/dev/null | sed 's/^Device [^ ]* //' | paste -sd, -)
    printf '{"text":" %d","tooltip":"Bluetooth ON\\nConnected: %s","class":"on","alt":"on"}\n' \
        "$connected" "$names"
else
    printf '{"text":"","tooltip":"Bluetooth ON — no devices connected","class":"on","alt":"on"}\n'
fi
