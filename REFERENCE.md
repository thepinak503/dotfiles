# Hyprland Nord — Reference

## Keybinds

`SUPER` = Windows/Command key. `SUPER` is the `$mainMod`.

### Launch Applications

| Key | Action |
|---|---|---|
| `SUPER + Return` | Open Kitty terminal |
| `SUPER + D` / `SUPER + Space` | Application launcher (rofi drun) |
| `SUPER + Tab` | Window switcher (rofi window list) |
| `SUPER + E` | Nautilus file manager |
| `SUPER + B` | Firefox browser |
| `SUPER + .` | Emoji picker (rofi emoji) |

### Window Management

| Key | Action |
|---|---|
| `SUPER + Q` | Close focused window |
| `SUPER + F` | Fullscreen toggle |
| `SUPER + V` | Toggle floating/tiling |
| `SUPER + P` | Pseudo-tile |
| `SUPER + S` | Toggle split layout (dwindle) |
| `SUPER + G` | Toggle group on focused window |
| `SUPER + SHIFT + Tab` | Cycle forward in group |
| `SUPER + CTRL + Tab` | Cycle backward in group |
| `SUPER + SHIFT + G` | Lock/unlock group focus |
| `SUPER + CTRL + G` | Move window into group |
| `SUPER + CTRL + SHIFT + G` | Move window out of group |
| `SUPER + Escape` | Power menu (wlogout) |

### Focus & Move

| Key | Action |
|---|---|
| `SUPER + H/J/K/L` | Focus window left/down/up/right |
| `SUPER + SHIFT + H/J/K/L` | Move window left/down/up/right |
| `SUPER + arrows` | Resize active window |

### Workspaces

| Key | Action |
|---|---|
| `SUPER + 1-9` | Switch to workspace N |
| `SUPER + SHIFT + 1-9` | Move window to workspace N |
| `SUPER + scroll` / `SUPER + SHIFT + ←→` | Previous/next workspace |
| `SUPER + CTRL + ←→` | Silent workspace switch (no animation) |
| `SUPER + \` (grave) | Toggle scratchpad (`magic` special workspace) |
| `SUPER + SHIFT + \`` | Move window to scratchpad |

### Window Groups

| Key | Action |
|---|---|
| `SUPER + G` | Toggle group on focused window |
| `SUPER + SHIFT + Tab` | Focus next window in group |
| `SUPER + CTRL + Tab` | Focus previous window in group |
| `SUPER + SHIFT + G` | Lock group focus (prevent leaving group) |
| `SUPER + CTRL + G` | Move window into group |
| `SUPER + CTRL + SHIFT + G` | Move window out of group |

### Media & Volume

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume +5% (swayosd) |
| `XF86AudioLowerVolume` | Volume -5% (swayosd) |
| `XF86AudioMute` | Toggle mute (swayosd) |
| `XF86MonBrightnessUp` | Brightness +5% (swayosd) |
| `XF86MonBrightnessDown` | Brightness -5% (swayosd) |
| `XF86AudioPlay` | Play/pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |

### Screenshots

| Key | Action |
|---|---|
| `Print` | Full screenshot → clipboard |
| `SHIFT + Print` | Select region → clipboard |
| `CTRL + Print` | Active window → clipboard |
| `SUPER + SHIFT + S` | Select region → clipboard |
| `SUPER + CTRL + S` | Select region → clipboard (silent) |

### Screen Recording

| Key | Action |
|---|---|
| `SUPER + SHIFT + Print` | Start/stop recording region (wf-recorder) |

### Utilities

| Key | Action |
|---|---|
| `SUPER + SHIFT + C` | Color picker (hyprpicker, copies to clipboard) |
| `SUPER + T` | Toggle touchpad on/off |
| `SUPER + SHIFT + L` | Toggle layout (dwindle ↔ master) |
| `SUPER + SHIFT + G` | Toggle **Game Mode** (disables animations/blur/shadows) |
| `SUPER + /` | Show keybind hints (rofi cheatsheet) |

### System

| Key | Action |
|---|---|
| `SUPER + CTRL + L` | Lock screen (hyprlock) |
| `SUPER + CTRL + Q` | Exit Hyprland (logout) |
| `SUPER + SHIFT + R` | Reload Hyprland config |
| `SUPER + W` | Fetch random wallpaper from internet |
| `SUPER + SHIFT + W` | Random local wallpaper from ~/wallpapers |
| `SUPER + SHIFT + V` | Clipboard history (cliphist + rofi) |

### Waybar Interactions

| Module | Click | Scroll Up | Scroll Down |
|---|---|---|---|
| Volume | Open pavucontrol | Volume +5% | Volume -5% |
| Now Playing | Play/pause | Next track | Previous track |
| Network | nm-connection-editor | — | — |

---

## Mouse & Touchpad Gestures

- **Three-finger swipe horizontally**: Switch workspaces
- Touchpad: natural scrolling enabled, tap-to-click on

---

## Window Rules

| Application | Rule |
|---|---|
| pavucontrol | Float, center, 60%×60% |
| blueman-manager | Float |
| xdg-desktop-portal | Float |
| Picture-in-Picture (any app) | Float, pinned |
| rofi / Rofi | No blur, no shadow |
| xwaylandvideobridge | Opacity 0, no animation, max size 1×1 (invisible) |
| waybar / Waybar | No blur, no shadow, no focus, no initial focus, stay focused |

---

## Screenshot & Recording

- **hyprshot**: multi-mode screenshot tool (output, region, window) — all bound to Print keys
- **wf-recorder**: screen recording via `SUPER + SHIFT + Print`, select region to record
- **hyprpicker**: color picker via `SUPER + SHIFT + C`, copies hex to clipboard

## Clipboard

- **hyprpicker**: copies color hex to clipboard
- **cliphist + rofi**: browse clipboard history via `SUPER + SHIFT + V`
- **wl-copy / wl-paste**: low-level clipboard commands
- Images are copied to Wayland clipboard (paste in any app)

---

## CLI Commands

| Command | Description |
|---|---|
| `hyprctl reload` | Reload Hyprland config |
| `hyprctl configerrors` | Check config for errors |
| `hyprctl dispatch exit` | Exit Hyprland |
| `hyprctl dispatch exec kitty` | Open terminal from CLI |
| `hyprctl dispatch workspace 3` | Switch to workspace 3 |
| `hyprctl dispatch movetoworkspace 3` | Move window to workspace 3 |
| `hyprctl keyword general:layout master` | Switch to master layout |
| `hyprctl keyword general:layout dwindle` | Switch to dwindle layout |
| `hyprlock` | Lock screen |
| `hyprctl hyprpaper wallpaper ",<path>"` | Set wallpaper |
| `hyprshot -m output` | Full screenshot |
| `hyprshot -m region` | Region screenshot |
| `hyprshot -m window` | Window screenshot |
| `hyprpicker -a` | Pick color and copy to clipboard |
| `wf-recorder -g "$(slurp)" -f out.mp4` | Record screen region |
| `cliphist list \| rofi -dmenu \| cliphist decode \| wl-copy` | Browse clipboard history |
| `playerctl play-pause` | Toggle media playback |
| `pactl set-sink-volume @DEFAULT_SINK@ +5%` | Raise volume |
| `brightnessctl s +5%` | Raise brightness |
| `loginctl lock-session` | Lock session via systemd |
| `systemctl --user start wallpaper-fetch.service` | Fetch wallpaper now |

---

## Config File Layout

All configs are stored at `~/.local/share/dotfiles/`:

### `hypr/` — Hyprland compositor

| File | Purpose |
|---|---|
| `hyprland.conf` | Entry point, Nord colors, sources sub-configs |
| `configs/monitors.conf` | Display/monitor setup |
| `configs/input.conf` | Keyboard, mouse, touchpad, gestures |
| `configs/decor.conf` | Gaps, borders, shadows, blur, cursor |
| `configs/animations.conf` | Window/workspace animations |
| `configs/windowrules.conf` | Per-application window rules |
| `configs/workspaces.conf` | Dwindle/master layout, misc, render, debug |
| `configs/keybinds.conf` | All key bindings |
| `configs/autostart.conf` | Startup applications |
| `scripts/volume` | swayosd volume control (+5%, -5%, toggle) |
| `scripts/brightness` | swayosd brightness control (+5%, -5%) |
| `scripts/changeLayout` | Toggle dwindle ↔ master layout |
| `scripts/touchpad` | Toggle touchpad on/off |
| `scripts/wallpaper-fetch` | Download random Nord wallpaper |
| `scripts/gamemode` | Toggle game mode (kill eye candy) |
| `scripts/keyhints` | Interactive rofi keybind cheatsheet |
| `scripts/screenrecord` | Start/stop wf-recorder region recording |
| `hyprlock.conf` | Lock screen appearance |
| `hypridle.conf` | Idle/suspend timers |
| `hyprpaper.conf` | Wallpaper daemon config |

### `waybar/` — Status bar

| File | Purpose |
|---|---|
| `config.jsonc` | Bar layout, modules, interactions |
| `style.css` | Nord-themed styling |
| `scripts/media.sh` | Now-playing display script |

### `wallpapers/`

- `nord_default.png` — placeholder Nord gradient wallpaper
- Add any `.png`/`.jpg` here — `SUPER + SHIFT + W` picks one at random
- Wallpapers folder is sourced by hyprpaper for the local random wallpaper picker

---

## Tips

- **Reload config after editing**: `SUPER + SHIFT + R` or `hyprctl reload`
- **Check for errors**: `hyprctl configerrors`
- **Lock screen**: Press `SUPER + CTRL + L` or wait for idle timeout (10 min auto-lock)
- **Sleep timer**: System suspends after 30 min idle
- **Clipboard history**: `SUPER + SHIFT + V` then search/select with rofi
- **Scratchpad**: Send windows to scratchpad with `SUPER + SHIFT + \``, toggle with `SUPER + \``
- **Window groups**: Select windows and press `SUPER + G` to group them, then cycle with `SUPER + SHIFT + Tab`
- **Game mode**: Press `SUPER + SHIFT + G` before gaming — disables all eye candy for max FPS
- **Keyhints**: Press `SUPER + /` for a full interactive keybind reference
- **Screen recording**: Press `SUPER + SHIFT + Print`, select a region. Press again to stop.
- **Volume/playback control**: Use keyboard media keys or click waybar modules
- **Add new wallpapers**: Drop images into `~/.local/share/dotfiles/wallpapers/`, then `SUPER + SHIFT + W`
- **Internet wallpaper**: `SUPER + W` fetches a random Nord wallpaper from GitHub
- **Performance**: Blur passes=1, damage_tracking=2, direct_scanout=true for max smoothness
- **Arch Linux note**: Some packages may need `-git` variants from AUR (e.g., `hyprland-git`, `waybar-hyprland-git`) for latest features

### Dependencies Quick Reference

| Package | Purpose |
|---|---|
| `rofi-calc` | Calculator mode in rofi |
| `rofi-emoji` | Emoji picker (for `SUPER + .`) |
| `wf-recorder` | Screen recording |
| `swayosd` | OSD for volume/brightness |
| `hyprshot` | Screenshots (output/region/window) |
| `hyprpicker` | Color picker |
| `cliphist` | Clipboard history manager |
| `playerctl` | Media player controls |
| `dunst` | Notification daemon |
