#!/usr/bin/env sh
batdir="$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1)"
[ -z "$batdir" ] && { printf 'No battery detected\n'; exit 0; }
getfile() { [ -f "$1" ] && cat "$1" 2>/dev/null || printf '' ; }
full=""
design=""
full="$(getfile "$batdir/charge_full")"
design="$(getfile "$batdir/charge_full_design")"
if [ -z "$full" ] || [ -z "$design" ]; then
    full="$(getfile "$batdir/energy_full")"
    design="$(getfile "$batdir/energy_full_design")"
fi
if ([ -z "$full" ] || [ -z "$design" ]) && command -v upower >/dev/null 2>&1; then
    upath="$(upower -e 2>/dev/null | grep -i battery | head -n1)"
    if [ -n "$upath" ]; then
        full="$(upower -i "$upath" 2>/dev/null | awk '/energy-full:/ {print $2}')"
        design="$(upower -i "$upath" 2>/dev/null | awk '/energy-full-design:/ {print $2}')"
    fi
fi
clean_num() {
    printf '%s' "$1" | sed -E 's/[^0-9.]//g'
}
full_c="$(clean_num "$full")"
design_c="$(clean_num "$design")"
if [ -n "$full_c" ] && [ -n "$design_c" ] && [ "$design_c" != "0" ]; then
    health=$(awk "BEGIN{printf \"%d\", ($full_c/$design_c)*100}")
    printf '%s%%\n' "$health"
else
    printf 'N/A\n'
fi
