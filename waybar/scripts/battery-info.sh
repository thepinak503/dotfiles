#!/usr/bin/env bash

bat="/sys/class/power_supply/BAT0"
adapter="/sys/class/power_supply/AC"

if [ ! -d "$bat" ]; then
  notify-send "Battery" "No battery found"
  exit
fi

capacity=$(cat "$bat/capacity" 2>/dev/null || echo "N/A")
status=$(cat "$bat/status" 2>/dev/null || echo "N/A")
energy_full=$(cat "$bat/energy_full" 2>/dev/null || cat "$bat/charge_full" 2>/dev/null || echo "0")
energy_full_design=$(cat "$bat/energy_full_design" 2>/dev/null || cat "$bat/charge_full_design" 2>/dev/null || echo "0")
cycle_count=$(cat "$bat/cycle_count" 2>/dev/null || echo "N/A")
voltage=$(cat "$bat/voltage_now" 2>/dev/null || echo "0")
temp=$(cat "$bat/temp" 2>/dev/null || echo "N/A")
manufacturer=$(cat "$bat/manufacturer" 2>/dev/null || echo "Unknown")
model=$(cat "$bat/model_name" 2>/dev/null || echo "Unknown")
technology=$(cat "$bat/technology" 2>/dev/null || echo "Unknown")

power=0
if [ -f "$bat/power_now" ]; then
  power=$(cat "$bat/power_now")
  power=$(awk "BEGIN { printf \"%.1f\", $power / 1000000 }")
fi

health=0
if [ "$energy_full_design" != "0" ] && [ "$energy_full" != "0" ]; then
  health=$(awk "BEGIN { printf \"%.0f\", ($energy_full / $energy_full_design) * 100 }")
fi

if [ "$voltage" != "0" ]; then
  voltage=$(awk "BEGIN { printf \"%.3f\", $voltage / 1000000 }")
else
  voltage="N/A"
fi

on_ac="No"
if [ -f "$adapter/online" ]; then
  ac=$(cat "$adapter/online")
  [ "$ac" = "1" ] && on_ac="Yes"
fi

if [ "$cycle_count" = "N/A" ]; then
  cycles_text="N/A"
else
  cycles_text="$cycle_count"
fi

case "$status" in
  "Charging") status_icon="" ;;
  "Discharging") status_icon="" ;;
  "Full") status_icon="" ;;
  *) status_icon="" ;;
esac

yad --title="Battery Info" \
    --center \
    --fixed \
    --undecorated \
    --skip-taskbar \
    --on-top \
    --borders=16 \
    --button="Close":0 \
    --text="<span font='14'><b>${manufacturer} ${model}</b></span>\n\n\
<span font='12'>\
<b>Status:</b>      ${status_icon} ${status}\n\
<b>Capacity:</b>    ${capacity}%\n\
<b>Health:</b>      ${health}%\n\
<b>Cycles:</b>      ${cycles_text}\n\
<b>Power:</b>       ${power} W\n\
<b>Voltage:</b>     ${voltage} V\n\
<b>Technology:</b>  ${technology}\n\
<b>Plugged:</b>     ${on_ac}\
</span>" \
    --buttons-layout=center
