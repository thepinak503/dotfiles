#!/usr/bin/env bash
# ============================================================================
# Date Back — shifts clock display back by 1 day (for waybar scroll)
# ============================================================================
# Uses the current system date and notifies with the previous day's date.
# ============================================================================

set -euo pipefail

notify-send -a waybar -u low -t 2000 "Date" "$(date -d '-1 day' '+%A, %B %d %Y')"
