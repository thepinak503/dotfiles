#!/usr/bin/env bash
set -euo pipefail

# Waybar custom clock module
# Outputs formatted date/time as JSON to avoid the broken built-in {:%x} format
# in waybar v0.15.0 with fmtlib 12.0.0

# Main display format (single line)
date_fmt=$(date '+%a %b %d  %H:%M')

# Tooltip format (multi-line)  
tooltip=$(date '+%A, %B %d %Y  %I:%M:%S %p')

printf '{"text": "%s", "tooltip": "%s"}\n' "$date_fmt" "$tooltip"
