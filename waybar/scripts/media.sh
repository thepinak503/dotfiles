#!/usr/bin/env bash
# ============================================================================
# Waybar Media Module — shows currently playing track with controls
# ============================================================================
# Supports: playerctl status, metadata, play/pause/next/prev actions
# Uses custom formatting with truncation for waybar display
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
MAX_LENGTH="${MAX_LENGTH:-40}"           # Max characters for waybar label
TRUNCATION_SUFFIX="${TRUNCATION_SUFFIX:-…}"

# ---------------------------------------------------------------------------
# Detect available players and get status
# ---------------------------------------------------------------------------
playerctl_status=$(playerctl status 2>/dev/null || echo "")

# If no player is playing, check for paused players
if [[ -z "$playerctl_status" ]]; then
    printf '{"text":"","class":"stopped","alt":"Stopped"}\n'
    exit 0
fi

# ---------------------------------------------------------------------------
# Get metadata
# ---------------------------------------------------------------------------
artist=$(playerctl metadata artist 2>/dev/null || echo "")
title=$(playerctl metadata title 2>/dev/null || echo "")
album=$(playerctl metadata album 2>/dev/null || echo "")
player_name=$(playerctl metadata --format "{{ playerName }}" 2>/dev/null || echo "")
length=$(playerctl metadata mpris:length 2>/dev/null || echo "0")
position=$(playerctl position 2>/dev/null || echo "0")

# ---------------------------------------------------------------------------
# Status icon
# ---------------------------------------------------------------------------
case "$playerctl_status" in
    "Playing") status_icon="" ;;
    "Paused")  status_icon="" ;;
    *)         status_icon="" ;;
esac

# ---------------------------------------------------------------------------
# Format the media string
# ---------------------------------------------------------------------------
if [[ -n "$artist" ]]; then
    text="$artist — $title"
else
    text="$title"
fi

# Truncate if needed
if [[ ${#text} -gt $MAX_LENGTH ]]; then
    text="${text:0:$MAX_LENGTH}$TRUNCATION_SUFFIX"
fi

# ---------------------------------------------------------------------------
# Progress indicator
# ---------------------------------------------------------------------------
progress_text=""
if [[ "$length" != "0" ]] && [[ "$length" != "" ]]; then
    length_sec=$(( length / 1000000 ))
    pos_sec=${position%.*}
    if [[ "$length_sec" -gt 0 ]] && [[ "$pos_sec" -ge 0 ]]; then
        progress=$(( pos_sec * 100 / length_sec ))
        progress_text=" $progress%%"
    fi
fi

# ---------------------------------------------------------------------------
# Tooltip with rich info
# ---------------------------------------------------------------------------
tooltip=" $title"
[[ -n "$artist" ]] && tooltip="$tooltip\n $artist"
[[ -n "$album" ]] && tooltip="$tooltip\n $album"
[[ -n "$player_name" ]] && tooltip="$tooltip\n $player_name"
tooltip="$tooltip\n $playerctl_status"

# ---------------------------------------------------------------------------
# Output JSON for waybar
# ---------------------------------------------------------------------------
class=$(echo "$playerctl_status" | tr '[:upper:]' '[:lower:]')
alt="$playerctl_status"

printf '{"text":"%s %s%s","tooltip":"%s","class":"%s","alt":"%s"}\n' \
    "$status_icon" \
    "$text" \
    "$progress_text" \
    "$tooltip" \
    "$class" \
    "$alt"
