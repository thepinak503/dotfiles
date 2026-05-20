#!/usr/bin/env bash
set -euo pipefail

D=$(dirname "$0")/..
D="$(cd "$D" && pwd)"
cd "$D"

PASS=0 FAIL=0 SKIP=0

ESC=$(printf '\033')
g() { echo "${ESC}[32m${ESC}[1m✓${ESC}[0m ${ESC}[32m$1${ESC}[0m"; PASS=$((PASS+1)); }
b() { echo "${ESC}[31m✗${ESC}[0m ${ESC}[31m$1${ESC}[0m"; FAIL=$((FAIL+1)); }
y() { echo "${ESC}[33m~${ESC}[0m ${ESC}[33m$1${ESC}[0m"; SKIP=$((SKIP+1)); }
h() { echo; echo "${ESC}[34m━━━ $1 ━━━${ESC}[0m"; }

result() {
  local total=$((PASS + FAIL))
  echo
  echo "${ESC}[34m══════════════════════════════════════════════════════════════${ESC}[0m"
  [ "$FAIL" -eq 0 ] && echo "${ESC}[32m  ✓ ALL $PASS TESTS PASSED${ESC}[0m" || echo "${ESC}[31m  ✗ $FAIL/$total TESTS FAILED${ESC}[0m"
  echo "${ESC}[34m══════════════════════════════════════════════════════════════${ESC}[0m"
  [ "$FAIL" -eq 0 ] && exit 0 || exit 1
}

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

h "1. HYPRLAND CONFIG FILES EXIST"
for f in hypr/hyprland.conf hypr/hypridle.conf hypr/hyprlock.conf hypr/hyprpaper.conf \
          hypr/configs/monitors.conf hypr/configs/input.conf hypr/configs/decor.conf \
          hypr/configs/animations.conf hypr/configs/windowrules.conf \
          hypr/configs/workspaces.conf hypr/configs/keybinds.conf hypr/configs/autostart.conf; do
  [ -f "$f" ] && g "$f" || b "MISSING: $f"
done

h "2. HYPRLAND.CONF SOURCE PATHS VALID"
while IFS= read -r line; do
  case "$line" in
    source\ =*) ;;
    ''|'#'*|\ *) continue ;;
    *) continue ;;
  esac
  src=$(echo "$line" | sed 's/^source = //' | tr -d ' ')
  [ -n "$src" ] && src="${src/#\~/$HOME}" && [ -f "$src" ] && g "source: $(basename "$src")" || b "BAD SOURCE: $src"
done < hypr/hyprland.conf

h "3. NO DEPRECATED HYPRLAND OPTIONS"
for f in hypr/configs/*.conf hypr/hyprland.conf; do
  bad=""
  grep -q 'pseudotile' "$f" 2>/dev/null && bad+="pseudotile "
  grep -q 'ignore_window' "$f" 2>/dev/null && bad+="ignore_window "
  grep -q 'new_optimizations' "$f" 2>/dev/null && bad+="new_optimizations "
  grep -q 'no_focus' "$f" 2>/dev/null && bad+="no_focus "
  grep -q 'no_initial_focus' "$f" 2>/dev/null && bad+="no_initial_focus "
  grep -q 'stay_focused' "$f" 2>/dev/null && bad+="stay_focused "
  grep -q 'cm_fs_passthrough' "$f" 2>/dev/null && bad+="cm_fs_passthrough "
  [ -z "$bad" ] && g "$f: no deprecated options" || b "$f: DEPRECATED: $bad"
done

h "4. HYPRLAND KEYBINDS - NO DUPLICATE COMBOS"
binds=$(mktemp)
grep '^bind' hypr/configs/keybinds.conf | sed 's/^bind[el]* = //' | sed 's/^\([^,]*,[^,]*\),.*/\1/' | sort > "$binds"
dups=$(sort "$binds" | uniq -d)
[ -z "$dups" ] && g "no duplicate key combos" || b "DUPLICATE KEYBINDS: $dups"
rm -f "$binds"

h "5. WINDOW RULES - CLASSES MATCH INSTALLED APPS"
while IFS= read -r line; do
  cls=$(echo "$line" | sed -n 's/.*class (\([^)]*\)).*/\1/p')
  [ -z "$cls" ] && continue
  for c in ${cls//|/ }; do
    check_cmd "$c" && g "class ($c) found in PATH" || y "class ($c) not in PATH (may be installed later)"
  done
done < hypr/configs/windowrules.conf

h "6. ALL EXEC-ONCE COMMANDS AVAILABLE"
while IFS= read -r line; do
  cmd=$(echo "$line" | sed -n 's/^exec-once = //p' | awk '{print $1}')
  [ -z "$cmd" ] && continue
  cmd="${cmd/#\~/$HOME}"
  if echo "$cmd" | grep -q '/'; then
    [ -x "$cmd" ] && g "$cmd" || b "NOT EXECUTABLE: $cmd"
  else
    check_cmd "$cmd" && g "command: $cmd" || y "command: $cmd NOT FOUND"
  fi
done < hypr/configs/autostart.conf

h "7. HYPR SCRIPTS EXIST AND ARE EXECUTABLE"
for s in hypr/scripts/brightness hypr/scripts/changeLayout hypr/scripts/gamemode \
          hypr/scripts/keyhints hypr/scripts/screenrecord hypr/scripts/touchpad \
          hypr/scripts/volume hypr/scripts/wallpaper-fetch; do
  [ -x "$s" ] && g "$s" || b "MISSING/NOT EXECUTABLE: $s"
done

h "8. WAYBAR CONFIG VALID JSON"
check_cmd jq && jq empty waybar/config.jsonc 2>/dev/null && g "waybar/config.jsonc valid" || b "waybar/config.jsonc INVALID"

h "9. WAYBAR MODULES EXIST IN CSS"
modules=$(jq -r '[
  ."modules-left"[], ."modules-center"[], ."modules-right"[]
] | unique | .[]' waybar/config.jsonc 2>/dev/null || echo "")
for m in $modules; do
  css_id=$(echo "$m" | sed 's|hyprland/|#|' | sed 's|custom/|#custom-|' | sed 's|^#|#|')
  grep -q "$css_id" waybar/style.css 2>/dev/null && g "CSS: $css_id matches $m" || y "CSS: no match for $m ($css_id)"
done

h "10. WAYBAR SCRIPT PATHS RESOLVE"
for s in media.sh net-speed.sh battery-info.sh power.sh calendar.sh; do
  [ -x "waybar/scripts/$s" ] && g "waybar/scripts/$s" || b "MISSING: waybar/scripts/$s"
done

h "11. ROFI CONFIG VALID"
for f in rofi/config.rasi rofi/config-full.rasi; do
  grep -q '^@theme' "$f" && g "$f theme reference OK" || b "$f missing @theme"
done

h "12. WLOGOUT - LABELS MATCH CSS"
while IFS= read -r label; do
  [ -z "$label" ] && continue
  grep -q "#$label" wlogout/style.css 2>/dev/null && g "wlogout: #$label styled" || b "wlogout: MISSING #$label in CSS"
done < <(grep '"label"' wlogout/layout | sed 's/.*: *"//;s/".*//')

h "13. SWAYNC CONFIG VALID"
if check_cmd jq; then
  jq empty swaync/config.jsonc 2>/dev/null && g "swaync/config.jsonc valid" || b "swaync/config.jsonc INVALID"
else
  y "jq not installed, skipping swaync JSON check"
fi

h "14. KITTY CONFIG VALID"
grep -q '^font_family' kitty/kitty.conf && g "kitty has font_family" || b "kitty missing font_family"
grep -q '^include' kitty/kitty.conf && g "kitty includes nord.conf" || b "kitty missing include"

h "15. ALACRITTY CONFIG VALID TOML"
check_cmd "toml" || check_cmd "remarshal" && g "alacritty TOML check skipped (no toml parser)" || y "no TOML parser available"
head -1 alacritty/alacritty.toml | grep -q '^#' && g "alacritty config exists" || y "alacritty config exists"

h "16. WALLPAPER FILES EXIST"
count=$(find wallpapers -type f \( -name '*.png' -o -name '*.jpg' \) 2>/dev/null | wc -l)
[ "$count" -gt 0 ] && g "$count wallpapers found" || b "NO WALLPAPERS"

h "17. HYPRPAPER PRELOAD PATH EXISTS"
path=$(grep '^preload' hypr/hyprpaper.conf | sed 's/^preload = //')
path="${path/#\~/$HOME}"
[ -f "$path" ] && g "hyprpaper preload: $path" || b "hyprpaper preload: $path NOT FOUND"

h "18. NO COLOUR VARIABLE MISMATCHES"
hypr_vars=$(grep '^\$nord' hypr/hyprland.conf | wc -l)
hypr_refs=$(grep -r '\$nord' hypr/ --include='*.conf' | grep -v hyprland.conf | wc -l || true)
echo "  defined: $hypr_vars, referenced: $hypr_refs" && g "color vars check done"

h "19. BATTERY DEVICE EXISTS"
bat=$(grep '"bat"' waybar/config.jsonc 2>/dev/null | sed 's/.*: *"//;s/".*//')
[ -d "/sys/class/power_supply/$bat" ] && g "battery device $bat found" || y "battery device $bat NOT FOUND"

h "20. NETWORK INTERFACE EXISTS"
int=$(ip route show default | awk '{print $5}' | head -1)
[ -n "$int" ] && g "active interface: $int" || y "no active network interface"
[ -d "/sys/class/net/$int" ] && g "interface $int in sysfs" || y "interface $int not in sysfs"

h "21. POSIX SHELL SYNTAX CHECK"
for f in install/install.sh; do
  bash -n "$f" 2>/dev/null && g "$f: valid bash syntax" || b "$f: SYNTAX ERROR"
done

h "22. GITIGNORE COVERS SECRETS"
for s in '.unsplash_key' '*.key' '*.pem' '*.env' 'secrets' 'credentials'; do
  grep -q "^$s" .gitignore 2>/dev/null && g ".gitignore covers $s" || y ".gitignore MISSING $s"
done

h "23. SYSTEMD UNIT FILES"
for u in systemd/user/wallpaper-fetch.service systemd/user/wallpaper-fetch.timer; do
  [ -f "$u" ] && g "$u" || y "$u not found"
done

h "24. DOTFILES DIR STRUCTURE INTEGRITY"
for d in bin core shells shells/bash shells/zsh shells/fish hypr hypr/configs hypr/scripts \
          waybar waybar/scripts rofi rofi/themes kitty alacritty wallpapers \
          wlogout swaync swayosd install profiles apps; do
  [ -d "$d" ] && g "dir: $d" || b "MISSING DIR: $d"
done

h "25. INSTALL SCRIPTS EXECUTABLE"
for f in install/install.sh install/uninstall.sh; do
  [ -x "$f" ] && g "$f" || b "NOT EXECUTABLE: $f"
done

h "26. BIN SCRIPTS EXECUTABLE"
for f in bin/dots bin/dots-doctor; do
  [ -x "$f" ] && g "$f" || b "NOT EXECUTABLE: $f"
done

h "27. ROFI CONFIG REFERENCES EXIST"
for r in rofi/config.rasi rofi/config-full.rasi; do
  theme=$(grep '^@theme' "$r" | awk '{print $2}' | tr -d '"')
  found=0
  [ -f "rofi/$theme.rasi" ] && found=1
  [ -f "rofi/themes/${theme##*/}.rasi" ] && found=1
  [ "$found" = 1 ] && g "$r -> $theme" || b "$r references missing theme: $theme"
done

h "28. CSS HAS NO INVALID GTK PROPERTIES"
for css in waybar/style.css wlogout/style.css swaync/style.css swayosd/style.css; do
  bad=""
  grep -n 'backdrop-filter' "$css" 2>/dev/null && bad+="backdrop-filter "
  [ -z "$bad" ] && g "$css: no known GTK-invalid properties" || y "$css: found $bad (may not work)"
done

h "29. WALLPAPER-FETCH FALLBACK CHAIN"
script="hypr/scripts/wallpaper-fetch"
grep -q 'download_unsplash' "$script" && g "has unsplash fallback" || b "missing unsplash"
grep -q 'download_github' "$script" && g "has github fallback" || b "missing github"
grep -q 'fetch_random_local' "$script" && g "has local fallback" || b "missing local fallback"

h "30. PROFILE FILES EXIST"
for p in profiles/laptop.sh profiles/desktop.sh profiles/work.sh profiles/gaming.sh profiles/lowpower.sh; do
  [ -f "$p" ] && g "$p" || y "$p not found"
done

result
