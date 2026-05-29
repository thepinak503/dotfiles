#!/usr/bin/env bash
# ============================================================================
# Battery Info — detailed battery status display for waybar and popup
# ============================================================================
# Supports: YAD info popup, waybar JSON output, charge thresholds,
#           multiple batteries, time remaining estimation, health monitoring
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
BAT_PATHS=()
# Find all battery devices
for dir in /sys/class/power_supply/BAT*; do
    [[ -d "$dir" ]] && BAT_PATHS+=("$dir")
done
ADAPTER_PATH="/sys/class/power_supply/AC"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
notify() { notify-send -a "Battery" -r 9999 "$@"; }

usage() {
    cat <<EOF
Usage: $(basename "$0") [--info|--notify-low|--notify-critical|--check|--waybar]

Options:
  --info             Show detailed battery info popup (YAD)
  --notify-low       Send low battery notification
  --notify-critical  Send critical battery notification
  --check            Check battery status (exit 0=ok, 1=low, 2=critical)
  --waybar           Output JSON for waybar module (default)
  --help             Show this help

EOF
    exit 1
}

# ---------------------------------------------------------------------------
# Read battery attribute safely
# ---------------------------------------------------------------------------
read_sys() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cat "$file" 2>/dev/null | xargs
    else
        return 1
    fi
}

read_sys_num() {
    local val
    val=$(read_sys "$1" || echo "0")
    val="${val//[!0-9-]/}"
    echo "${val:-0}"
}

get_battery_summary() {
    local total_capacity=0
    local total_energy=0
    local total_energy_full=0
    local total_energy_design=0
    local status="Unknown"
    local count=0

    for bat in "${BAT_PATHS[@]}"; do
        local cap=$(read_sys_num "$bat/capacity")
        local ef=$(read_sys_num "$bat/energy_full")
        local efd=$(read_sys_num "$bat/energy_full_design")
        local st=$(read_sys "$bat/status" || echo "Unknown")
        local c=$(read_sys_num "$bat/cycle_count")

        # Fallback to charge_* if energy_* not available
        if [[ "$ef" == "0" ]]; then
            ef=$(read_sys_num "$bat/charge_full")
        fi
        if [[ "$efd" == "0" ]]; then
            efd=$(read_sys_num "$bat/charge_full_design")
        fi

        total_capacity=$(( total_capacity + cap + 0 ))  # +0 ensures numeric
        total_energy=$(( total_energy + ef + 0 ))
        total_energy_full=$(( total_energy_full + ef + 0 ))
        total_energy_design=$(( total_energy_design + efd + 0 ))
        status="$st"
        count=$(( count + 1 ))
    done

    # Average capacity if multiple batteries
    if [[ "$count" -gt 0 ]]; then
        total_capacity=$(( total_capacity / count ))
    fi

    local health=0
    if [[ "$total_energy_design" -gt 0 ]]; then
        health=$(( total_energy_full * 100 / total_energy_design ))
    fi

    local on_ac="false"
    if [[ -f "$ADAPTER_PATH/online" ]]; then
        local ac=$(read_sys_num "$ADAPTER_PATH/online")
        [[ "$ac" == "1" ]] && on_ac="true"
    fi

    # Estimate time remaining
    local time_remaining=""
    local bat="${BAT_PATHS[0]:-}"
    if [[ -n "$bat" ]] && [[ "$status" == "Discharging" || "$status" == "Charging" ]]; then
        local rate=0
        local current=0
        if [[ -f "$bat/power_now" ]]; then
            rate=$(read_sys_num "$bat/power_now")
            if [[ "$status" == "Discharging" ]]; then
                current=$(read_sys_num "$bat/energy_now")
            elif [[ "$status" == "Charging" ]]; then
                local energy_full=$(read_sys_num "$bat/energy_full")
                local energy_now=$(read_sys_num "$bat/energy_now")
                current=$(( energy_full - energy_now ))
            fi
        elif [[ -f "$bat/current_now" ]]; then
            rate=$(read_sys_num "$bat/current_now")
            if [[ "$status" == "Discharging" ]]; then
                current=$(read_sys_num "$bat/charge_now")
            elif [[ "$status" == "Charging" ]]; then
                local charge_full=$(read_sys_num "$bat/charge_full")
                local charge_now=$(read_sys_num "$bat/charge_now")
                current=$(( charge_full - charge_now ))
            fi
        fi

        if [[ "$rate" -gt 0 ]] && [[ "$current" -gt 0 ]]; then
            local total_mins=$(( current * 60 / rate ))
            local hours=$(( total_mins / 60 ))
            local mins=$(( total_mins % 60 ))
            if [[ "$hours" -gt 48 ]]; then
                time_remaining=">48h"
            else
                time_remaining="${hours}h${mins}m"
            fi
        fi
    fi

    # Status icon
    local icon=""
    if [[ "$on_ac" == "true" ]]; then
        if [[ "$total_capacity" -ge 97 ]]; then
            icon=""
        elif [[ "$total_capacity" -ge 80 ]]; then
            icon=""
        else
            icon=""
        fi
    else
        if [[ "$total_capacity" -ge 90 ]]; then
            icon=""
        elif [[ "$total_capacity" -ge 70 ]]; then
            icon=""
        elif [[ "$total_capacity" -ge 40 ]]; then
            icon=""
        elif [[ "$total_capacity" -ge 15 ]]; then
            icon=""
        else
            icon=""
        fi
    fi

    # Output as associative array-like string
    cat <<BATDATA
capacity=$total_capacity
health=$health
status=$status
on_ac=$on_ac
time_remaining=$time_remaining
icon=$icon
battery_count=$count
BATDATA
}

# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------
if [[ ${#BAT_PATHS[@]} -eq 0 ]]; then
    # No battery detected — desktop system
    case "${1:-}" in
        --waybar|"")
            printf '{"text":"","tooltip":"Desktop — no battery","class":"charging"}\n'
            ;;
        --info)
            notify -u low "Battery" "No battery detected"
            ;;
    esac
    exit 0
fi

# Get battery data
eval "$(get_battery_summary)"

case "${1:-}" in
    --info)
        # Collect detailed info for first battery
        bat="${BAT_PATHS[0]}"
        manufacturer=$(read_sys "$bat/manufacturer" 2>/dev/null || echo "Unknown")
        model=$(read_sys "$bat/model_name" 2>/dev/null || echo "Unknown")
        technology=$(read_sys "$bat/technology" 2>/dev/null || echo "Unknown")
        cycle_count=$(read_sys "$bat/cycle_count" 2>/dev/null || echo "N/A")
        voltage=$(read_sys "$bat/voltage_now" 2>/dev/null || echo "0")
        raw_temp=$(read_sys "$bat/temp" 2>/dev/null || echo "0")

        voltage=$(awk "BEGIN { printf \"%.3f\", $voltage / 1000000 }")
        temp="N/A"
        if [[ "$raw_temp" != "0" ]]; then
            temp=$(awk "BEGIN { printf \"%.1f\", $raw_temp / 10 }")
        fi

        yad --title="Battery Info" \
            --center --fixed --undecorated --skip-taskbar --on-top \
            --borders=20 \
            --button="Close":0 \
            --text="<span font='14'><b>${manufacturer} ${model}</b></span>\n\n\
<span font='12'>\
<b>Status:</b>      ${icon} ${status}\n\
<b>Capacity:</b>    ${capacity}%%\n\
<b>Health:</b>      ${health}%%\n\
<b>Cycles:</b>      ${cycle_count}\n\
<b>Voltage:</b>     ${voltage} V\n\
<b>Temp:</b>        ${temp} °C\n\
<b>Technology:</b>  ${technology}\n\
<b>Plugged:</b>     ${on_ac}\n\
<b>Time Left:</b>   ${time_remaining:-N/A}\
</span>" \
            --buttons-layout=center
        ;;

    --notify-low)
        notify -u normal -i battery-caution "Battery Low" \
            "${capacity}% remaining — plug in charger soon"
        ;;

    --notify-critical)
        notify -u critical -i battery-empty "Battery Critical" \
            "${capacity}% remaining — system will suspend soon!"
        ;;

    --check)
        if [[ "$capacity" -le 5 ]]; then
            exit 2  # Critical
        elif [[ "$capacity" -le 15 ]]; then
            exit 1  # Low
        else
            exit 0  # OK
        fi
        ;;

    --waybar|"")
        class=""
        if [[ "$on_ac" == "true" ]]; then
            class="charging"
        elif [[ "$capacity" -le 10 ]]; then
            class="critical"
        elif [[ "$capacity" -le 20 ]]; then
            class="warning"
        else
            class="normal"
        fi

        tooltip="Battery: ${capacity}%%"
        [[ -n "$status" ]] && tooltip="$tooltip\nStatus: $status"
        [[ -n "$time_remaining" ]] && tooltip="$tooltip\nRemaining: $time_remaining"
        [[ -n "$health" ]] && tooltip="$tooltip\nHealth: ${health}%%"

        printf '{"text":"%s %d%%","tooltip":"%s","class":"%s","alt":"%s"}\n' \
            "$icon" "$capacity" "$tooltip" "$class" "$status"
        ;;
esac
