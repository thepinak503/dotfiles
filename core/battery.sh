#!/usr/bin/env sh
# =============================================================================
# Battery Status Module
# =============================================================================
#
# Provides battery percentage reading, charging status detection, and
# formatted battery display with iconography. Designed for use in
# shell prompts (PS1) or standalone status checks.
#
# Architecture:
#   The module uses internal helper functions (_bat_percent, _bat_charging)
#   for raw data acquisition, with public-facing functions (battery,
#   battery_warn, is_charging, bat_percent) for user interaction.
#
# Functions provided:
#   battery       - Display formatted battery status with icons and colors
#   battery_warn  - Show warning when battery is low (≤30%, ≤10% critical)
#   is_charging   - Returns 0 if battery is charging, 1 otherwise
#   bat_percent   - Returns raw battery percentage (0-100)
#
# Internal functions:
#   _bat_percent  - Read battery capacity from sysfs (Linux) or pmset (macOS)
#   _bat_charging - Read charging status from sysfs (Linux) or pmset (macOS)
#
# Data sources:
#   Linux: /sys/class/power_supply/BAT{0,1}/capacity and /status
#   macOS: pmset -g batt
#
# Battery icons (Nerd Fonts):
#   󰂄 Charging (cyan)
#   󰁺 Critical (red, ≤10%)
#   󰁼 Low (yellow, 11-30%)
#   󰁾 OK (green, 31-69%)
#   󰁿 Full (blue, ≥70%)
#
# Dependencies:
#   Linux: sysfs mounted at /sys/class/power_supply/
#   macOS: pmset command
#   Prompt: Nerd Fonts for battery icons
#
# Compatibility:
#   Works on: Linux (laptops with ACPI), macOS (laptops)
#   Shell: sh, bash, zsh
#
# See also:
#   - core/system-detect.sh - DOTFILES_IS_LAPTOP detection
#   - /sys/class/power_supply/ - Linux power supply interface
#   - pmset(1) - macOS power management settings
#   - ACPI (Advanced Configuration and Power Interface)
#
# =============================================================================
# Battery Percentage Reader
# =============================================================================
#
# Reads the current battery charge level from the system's power supply
# interface. Returns an empty string if no battery is detected.
#
# Data sources by platform:
#   Linux:   /sys/class/power_supply/BAT0/capacity or BAT1/capacity
#   macOS:   pmset -g batt (parses percentage from output)
#
# The function checks BAT0 first, then BAT1. This covers the common
# naming conventions for laptop batteries. Some systems may use
# different names (CMB0, etc.) which are not covered here.
#
# Returns:
#   Echoes battery percentage (0-100) or empty string
#
# See also:
#   - bat_percent() - Public alias for this function
#   - _bat_charging() - Charging status detection

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
# =============================================================================
# Battery Charging Status
# =============================================================================
#
# Checks whether the battery is currently charging. The function reads
# the battery status from the system's power supply interface and
# returns 0 (true) when the status is "Charging".
#
# Data sources by platform:
#   Linux:   /sys/class/power_supply/BAT0/status or BAT1/status
#            Returns 0 when status equals "Charging"
#   macOS:   pmset -g batt
#            Returns 0 when output contains "charging"
#
# The status file contains one of: Charging, Discharging, Full,
# or Not charging (depending on the battery controller).
#
# Returns:
#   0 (true)  - Battery is charging
#   1 (false) - Battery is discharging, full, or not detected
#
# See also:
#   - is_charging() - Public alias for this function
#   - _bat_percent() - Battery percentage reading

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
# =============================================================================
# battery - Formatted Battery Display
# =============================================================================
#
# Displays the current battery status with Nerd Font icon and color
# coding. This is designed for use in shell prompts (PS1) to provide
# at-a-glance battery awareness.
#
# Output format:
#   <icon> <percentage>%
#   e.g., "󰁾 45%" (green text)
#
# Color thresholds:
#   Charging: Cyan     (any level, icon 󰂄)
#   ≤10%:     Red      (critical, icon 󰁺)
#   11-30%:   Yellow   (low, icon 󰁼)
#   31-69%:   Green    (ok, icon 󰁾)
#   ≥70%:     Blue     (full, icon 󰁿)
#
# Features:
#   - Returns non-zero exit code when no battery is detected
#   - Works in both interactive and non-interactive shells
#   - ANSI color codes for terminal highlighting
#   - Nerd Font icons for visual distinction
#
# Usage:
#   battery          # Show formatted status
#   PS1='$(battery) $ '  # Use in prompt
#
# Returns:
#   0 - Battery status displayed
#   1 - No battery detected
#
# See also:
#   - battery_warn() - Low battery warning
#   - _bat_percent() - Raw percentage
#   - _bat_charging() - Charging check

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
# =============================================================================
# battery_warn - Low Battery Warning
# =============================================================================
#
# Prints a warning message when the battery level drops below
# configured thresholds. Designed for use in shell prompts or
# periodic cron jobs for proactive battery monitoring.
#
# Warning levels:
#   Critical (≤10%): Red text with 🔴 icon
#     "CRITICAL: Battery at 5% — plug in NOW!"
#   Low (11-30%): Yellow text with 🟡 icon
#     "Battery low: 25%"
#
# Features:
#   - Silent when battery is charging (no false warnings)
#   - Silent when no battery is detected (desktop/server)
#   - Silent when battery level is above 30%
#   - Respects DOTFILES_IS_LAPTOP flag (skips on non-laptops)
#
# Usage:
#   battery_warn     # Check and warn if battery is low
#
# Returns:
#   0 - Normal (no warning needed or charging)
#   1 - Warning displayed

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
is_charging() { _bat_charging; }
bat_percent() { _bat_percent; }
