#!/usr/bin/env bash
# ============================================================================
# Waybar Network Speed — real-time upload/download speed monitor
# ============================================================================
# Monitors /proc/net/dev for accurate byte counts
# Supports: auto-detect interface, configurable interval, format toggling
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
INTERVAL="${INTERVAL:-1}"                # Sampling interval in seconds
INTERFACE=""                              # Auto-detect if empty

# ---------------------------------------------------------------------------
# Auto-detect default network interface
# ---------------------------------------------------------------------------
auto_detect_interface() {
    local iface
    iface=$(ip route show default 2>/dev/null | awk '{print $5; exit}')
    if [[ -z "$iface" ]]; then
        # Fallback: find any non-loopback, running interface
        iface=$(ip -o link show 2>/dev/null | grep -v 'LOOPBACK\|docker\|veth\|br-\|virbr' | grep 'state UP' | awk -F': ' '{print $2}' | head -1)
    fi
    echo "${iface:-lo}"
}

if [[ -z "$INTERFACE" ]]; then
    INTERFACE=$(auto_detect_interface)
fi

# ---------------------------------------------------------------------------
# Format bytes to human-readable
# ---------------------------------------------------------------------------
format_speed() {
    local speed=$1
    local unit="${2:-B}"

    if [[ "$speed" -ge 1073741824 ]]; then
        printf "%.2fG%s/s" "$(awk "BEGIN { printf \"%.2f\", $speed / 1073741824 }")" "$unit"
    elif [[ "$speed" -ge 1048576 ]]; then
        printf "%.1fM%s/s" "$(awk "BEGIN { printf \"%.1f\", $speed / 1048576 }")" "$unit"
    elif [[ "$speed" -ge 1024 ]]; then
        printf "%.0fK%s/s" "$(awk "BEGIN { printf \"%.0f\", $speed / 1024 }")" "$unit"
    else
        printf "%d%s/s" "$speed" "$unit"
    fi
}

# ---------------------------------------------------------------------------
# Get interface traffic stats from /proc/net/dev
# ---------------------------------------------------------------------------
get_traffic() {
    local iface="$1"
    grep "$iface" /proc/net/dev 2>/dev/null || return 1
}

# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------
# Get initial sample
line=$(get_traffic "$INTERFACE")
if [[ -z "$line" ]]; then
    # Interface not found — try auto-detect
    INTERFACE=$(auto_detect_interface)
    line=$(get_traffic "$INTERFACE")
    if [[ -z "$line" ]]; then
        # No network interface available
        printf '{"text":"󰤭 ","alt":"no interface","tooltip":"No network interface","class":"down"}\n'
        exit 0
    fi
fi

rx1=$(echo "$line" | awk '{print $2}')
tx1=$(echo "$line" | awk '{print $10}')

# Wait for interval
sleep "$INTERVAL"

# Get second sample
line=$(get_traffic "$INTERFACE")
if [[ -z "$line" ]]; then
    printf '{"text":"󰤭 ","alt":"lost interface","tooltip":"Network interface lost","class":"down"}\n'
    exit 0
fi

rx2=$(echo "$line" | awk '{print $2}')
tx2=$(echo "$line" | awk '{print $10}')

# Calculate speeds
rx_speed=$(( (rx2 - rx1) / INTERVAL ))
tx_speed=$(( (tx2 - tx1) / INTERVAL ))

# Format
down=$(format_speed "$rx_speed")
up=$(format_speed "$tx_speed")

# Total for tooltip
total_down=$(format_speed "$rx2")
total_up=$(format_speed "$tx2")

# ---------------------------------------------------------------------------
# Network state detection
# ---------------------------------------------------------------------------
# Check connectivity by pinging a reliable host
online="true"
if ! ping -c 1 -W 1 1.1.1.1 &>/dev/null && ! ping -c 1 -W 1 8.8.8.8 &>/dev/null; then
    online="false"
fi

# ---------------------------------------------------------------------------
# Output JSON
# ---------------------------------------------------------------------------
if [[ "$online" == "true" ]]; then
    printf '{"text":" %s  %s","tooltip":"Interface: %s\\n Download: %s\\n Upload: %s\\n Total DL: %s\\n Total UL: %s","alt":"online","class":"up"}\n' \
        "$down" "$up" "$INTERFACE" "$down" "$up" "$total_down" "$total_up"
else
    printf '{"text":"󰤭 %s  %s","tooltip":"Interface: %s (offline)\\n Download: %s\\n Upload: %s","alt":"offline","class":"down"}\n' \
        "$down" "$up" "$INTERFACE" "$down" "$up"
fi
