#!/usr/bin/env bash
# ============================================================================
# Disk Usage — shows root partition usage percentage for waybar
# ============================================================================
# Reads from `df` (universally available). Supports warning/critical states.
# ============================================================================

set -euo pipefail

MOUNT="${1:-/}"
LABEL="${2:-root}"

# Get disk usage — df works on all platforms
if command -v df &>/dev/null; then
    line=$(df -h "$MOUNT" 2>/dev/null | tail -1) || {
        printf '{"text":"󰋊 ?","tooltip":"Disk: %s — unavailable","class":"error"}\n' "$LABEL"
        exit 0
    }
    used_pct=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    used=$(echo "$line" | awk '{print $3}')
    total=$(echo "$line" | awk '{print $2}')
    avail=$(echo "$line" | awk '{print $4}')
else
    printf '{"text":"","tooltip":"df not available","class":"disabled"}\n'
    exit 0
fi

# Validate percentage
if ! [[ "$used_pct" =~ ^[0-9]+$ ]]; then
    printf '{"text":"󰋊 ?","tooltip":"Disk: %s — parse error","class":"error"}\n' "$LABEL"
    exit 0
fi

# Determine icon and class
if   [ "$used_pct" -ge 90 ]; then icon=""; cls="critical"
elif [ "$used_pct" -ge 75 ]; then icon=""; cls="warning"
elif [ "$used_pct" -ge 50 ]; then icon=""; cls="normal"
else                              icon=""; cls="normal"
fi

printf '{"text":"%s %d%%","tooltip":"%s: %s used / %s total (%s avail)","class":"%s","alt":"%s"}\n' \
    "$icon" "$used_pct" "$LABEL" "$used" "$total" "$avail" "$cls" "$LABEL"
