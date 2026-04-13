#!/usr/bin/env sh
# =============================================================================
# lib/battery.sh — Battery monitoring (bash + zsh compatible)
# Thresholds:  ≤10 % critical (🔴)  ≤30 % low (🟡)  ≤69 % ok (🟢)  100 % full (🔵)
# Requires: DOTFILES_IS_LAPTOP  DOTFILES_OS  (set by system-detect.sh)
# =============================================================================

# --------------------------------------------------------------------------- #
# Internals                                                                    #
# --------------------------------------------------------------------------- #

_bat_percent() {
    local pct=""
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        pct="$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)"
    elif [ -f /sys/class/power_supply/BAT1/capacity ]; then
        pct="$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)"
    elif command -v pmset >/dev/null 2>&1; then
        pct="$(pmset -g batt 2>/dev/null | grep -o '[0-9]*%' | head -1 | tr -d '%')"
    fi
    printf '%s' "$pct"
}

_bat_charging() {
    local bat_status=""
    if [ -f /sys/class/power_supply/BAT0/status ]; then
        bat_status="$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)"
    elif [ -f /sys/class/power_supply/BAT1/status ]; then
        bat_status="$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)"
    elif command -v pmset >/dev/null 2>&1; then
        pmset -g batt 2>/dev/null | grep -q "charging" && bat_status="Charging"
    fi
    [ "$bat_status" = "Charging" ]
}

# --------------------------------------------------------------------------- #
# Public functions                                                              #
# --------------------------------------------------------------------------- #

# battery — pretty one-liner status
battery() {
    local pct icon color reset
    pct="$(_bat_percent)"
    reset='\033[0m'

    [ -z "$pct" ] && { echo "No battery detected"; return 1; }

    if _bat_charging; then
        icon="󰂄" color='\033[0;36m'          # cyan  = charging
    elif [ "$pct" -le 10 ]; then
        icon="󰁺" color='\033[0;31m'          # red   = critical
    elif [ "$pct" -le 30 ]; then
        icon="󰁼" color='\033[0;33m'          # yellow= low
    elif [ "$pct" -le 69 ]; then
        icon="󰁾" color='\033[0;32m'          # green = ok
    else
        icon="󰁿" color='\033[0;34m'          # blue  = full
    fi

    printf "${color}%s %s%%%s\n" "$icon" "$pct" "$reset"
}

# battery_warn — print a warning if charge is low (called on shell start)
battery_warn() {
    [ "${DOTFILES_IS_LAPTOP:-0}" = "1" ] || return 0
    local pct
    pct="$(_bat_percent)"
    [ -z "$pct" ] && return 0
    _bat_charging && return 0

    if [ "$pct" -le 10 ]; then
        printf '\033[1;31m🔴 CRITICAL: Battery at %s%% — plug in NOW!\033[0m\n' "$pct"
    elif [ "$pct" -le 30 ]; then
        printf '\033[0;33m🟡 Battery low: %s%%\033[0m\n' "$pct"
    fi
}

# is_charging — exit 0 if charging, 1 if not
is_charging() { _bat_charging; }

# bat_percent — just the number
bat_percent() { _bat_percent; }
