# CLAUDE.md — Full Project Context for AI Assistants

> Read this before editing **anything** in this repository.
> Generated from live `tree -A` output + source inspection.

---

## 1. What This Repo Is

**Pinak's Dotfiles** — a cross-distro, cross-shell unified dotfiles distribution.

| Property | Value |
|---|---|
| Version | 1.0.0 (dots CLI v2.0.0, installer v2.0.0) |
| Shells | Zsh (primary), Bash (fallback), Fish |
| WM | Hyprland — configured via **Lua API** (`hl.*`), not `.conf` |
| Theme | Nord 16-color palette (dark default, light variant) |
| Terminal | Kitty (primary), Alacritty (secondary) |
| Font | CaskaydiaCove Nerd Font Mono (terminal), Noto Sans (GTK) |
| Repo path | `~/.local/share/dotfiles` (`$DOTFILES_DIR`) |
| State path | same as repo (`$DOTFILES_STATE_DIR`) |

---

## 2. Exact File Tree

```
~/.local/share/dotfiles/           (34 dirs, 166 files shown — excludes .git, zcompiled, wallpapers, logs, scratch)
│
├── alacritty/
│   └── alacritty.toml             # Alacritty terminal — imports theme from themes/
│
├── apps/
│   ├── atuin/
│   │   └── config.toml            # Shell history daemon (fuzzy, compact UI)
│   ├── brew/
│   │   └── Brewfile               # Homebrew bundle manifest (macOS)
│   ├── fastfetch/
│   │   ├── battery_health.sh      # Battery health helper for fastfetch
│   │   ├── config.jsonc           # 20-module system info display
│   │   └── os_age.sh              # OS install age calculator
│   ├── git/
│   │   └── gitconfig              # Git: delta pager (Nord), 50+ aliases, rebase auto-stash
│   ├── lazygit/
│   │   └── config.yml             # Lazygit TUI (Nord theme)
│   ├── tmux/
│   │   └── tmux.conf              # C-a prefix, vi nav, Nord statusbar, 10K history
│   ├── inventory.baseline.json    # Package inventory baseline
│   ├── starship-linux.toml        # Starship: Tokyo Night, 40+ modules, git/cloud/battery
│   └── starship-mac.toml          # Starship: macOS variant
│
├── bin/
│   ├── benchmark_shell.sh         # Shell startup benchmarker
│   ├── build_data.js              # JS docs data builder
│   ├── build_docs_data.sh         # Docs builder
│   ├── check_startup.sh           # Startup time checker
│   ├── diagnostic.sh              # Full system diagnostic (349 lines)
│   ├── dots                       # ★ Main CLI controller (425 lines) — see §5
│   ├── dots-doctor                # Health diagnostic (310 lines, A–F scoring)
│   ├── dotupdate_bg.sh            # Background git updater (disowned from .zshrc)
│   ├── dotupdate.sh               # Foreground dotfiles updater
│   ├── health_check.sh            # Quick health check
│   ├── inventory_check.sh         # Package inventory audit
│   ├── setup_hooks.sh             # Git hooks installer
│   ├── test_all.sh                # Cross-shell test runner
│   └── test_repo.sh               # Syntax + sourcing tests (fast, run first)
│
├── core/                          # Cross-shell POSIX-compatible shared layer
│   ├── aliases.sh                 # 1600+ universal aliases (sourced by all 3 shells)
│   ├── arch_aliases.sh            # Arch/yay/paru-specific aliases
│   ├── battery.sh                 # Battery query helpers
│   ├── __cache.sh                 # Internal caching layer
│   ├── debian_aliases.sh          # apt-specific aliases
│   ├── fedora_aliases.sh          # dnf-specific aliases
│   ├── functions.sh               # 2909 lines — shared functions
│   ├── logging.sh                 # Colored log helpers (info/warn/error)
│   ├── macos_aliases.sh           # brew-specific aliases
│   ├── os_detect.sh               # POSIX OS detection
│   ├── ssh-agent.sh               # SSH agent management
│   ├── system-detect.sh           # Hardware/compositor/GPU detection
│   ├── tools.sh                   # Command availability checks
│   └── universal.sh               # 1677 lines — OS/distro/PM detection, pkg mgmt fns
│
├── docs/                          # HTML documentation (15 pages)
│   ├── architecture.html
│   ├── bash.html
│   ├── data.js
│   ├── diagnostics.html
│   ├── faq.html
│   ├── fastfetch.html
│   ├── features.html
│   ├── fish.html
│   ├── index.html
│   ├── install.html
│   ├── performance.html
│   ├── reference.html
│   ├── starship.html
│   ├── style.css
│   └── zsh.html
│
├── hypr/                          # Hyprland WM (Lua API — NOT .conf syntax)
│   ├── animations/                # Animation presets
│   │   ├── default.lua
│   │   ├── elastic.lua            # Physics-based bouncy animations
│   │   ├── fast.lua
│   │   └── smooth.lua
│   ├── configs/                   # Sub-configs required by hyprland.lua
│   │   ├── animations.lua         # Bezier curves + animation speeds
│   │   ├── autostart.lua          # exec-once: waybar×2, swaync, hyprpaper, hypridle…
│   │   ├── decor.lua              # Rounding=10, gaps 5/8, gradient borders, blur
│   │   ├── devices.lua            # Device-specific overrides
│   │   ├── env.lua                # GPU env vars (auto-generated, pcall'd)
│   │   ├── input.lua              # KB=us, touchpad (natural, tap-to-click, gestures)
│   │   ├── keybinds.lua           # 153 lines — all SUPER+key bindings
│   │   ├── monitors.lua           # Monitor auto-detect
│   │   ├── theme.lua              # Nord color table → global `theme` + `theme_rgb`
│   │   ├── windowrules.lua        # Tag-based opacity + float rules
│   │   └── workspaces.lua         # Dwindle/master layout, binds, misc, xwayland
│   ├── scripts/                   # Hyprland helper scripts (all executable, no .sh ext)
│   │   ├── animations-menu        # Animation picker menu (rofi)
│   │   ├── blur-toggle            # Toggle blur on/off
│   │   ├── brightness             # swayosd brightness (--inc/--dec)
│   │   ├── changeLayout           # Toggle dwindle ↔ master
│   │   ├── diagnose               # Hyprland diagnose helper
│   │   ├── diagreload             # Diagnose + reload
│   │   ├── gamemode               # Toggle performance/game mode
│   │   ├── gpu-detect             # GPU detection helper
│   │   ├── keyhints               # Keybind cheatsheet (rofi)
│   │   ├── keyhints-yad           # Keybind cheatsheet (yad)
│   │   ├── nightlight             # Toggle night light / color temp
│   │   ├── refresh                # Refresh Hyprland compositor
│   │   ├── screenrecord           # wf-recorder + slurp region select
│   │   ├── screenshot             # grim+slurp (--now/--area/--window/--swappy)
│   │   ├── set-env                # Generate GPU env vars → configs/env.lua
│   │   ├── settings-menu          # Settings launcher menu
│   │   ├── touchpad               # Toggle touchpad enable/disable
│   │   ├── transparency           # Toggle window transparency
│   │   ├── volume                 # swayosd volume (--inc/--dec/--toggle)
│   │   ├── wallpaper-fetch        # Wallpaper fetch (Unsplash → GitHub → local fallback)
│   │   └── waybar-reload          # Kill + restart waybar
│   ├── apply.sh                   # Apply Hyprland config
│   ├── hypridle.conf              # Idle: 5min dim → 10min lock → 15min DPMS → 30min suspend
│   ├── hyprland.lua               # ★ Main entrypoint — only require() calls
│   ├── hyprlock.conf              # Lock screen (Nord dark, CaskaydiaCove clock)
│   ├── hyprpaper.conf             # Wallpaper daemon config
│   └── uninstall.sh               # Hyprland config uninstaller
│
├── install/
│   ├── fonts-install.sh           # Nerd Font installer (Meslo + CaskaydiaCove)
│   ├── install.sh                 # ★ Main installer v2.0 (996 lines, cross-distro)
│   └── uninstall.sh               # Dotfiles uninstaller
│
├── kitty/
│   ├── kitty.conf                 # CaskaydiaCove 11pt, 85% opacity, cursor trail, powerline tabs
│   └── nord.conf                  # Nord 16-color palette (swapped by themes/theme.sh)
│
├── rofi/
│   ├── themes/
│   │   └── nord.rasi              # Nord theme file (swapped by themes/theme.sh)
│   ├── config-full.rasi           # Full launcher (5-col, 60% width)
│   └── config.rasi                # Compact launcher (2-col, 30% width)
│
├── shells/
│   ├── bash/
│   │   ├── aliases.bash           # Bash-specific aliases
│   │   ├── detect_apps.bash       # Dynamic app detection for bash
│   │   └── exports.bash           # Bash environment exports
│   ├── fish/
│   │   ├── aliases.fish           # Fish aliases
│   │   ├── config.fish            # Fish config (225 lines, distro detection)
│   │   ├── detect_apps.fish       # App detection for fish
│   │   ├── exports.fish           # Fish exports
│   │   └── functions.fish         # 1500+ functions (6502 lines)
│   ├── zsh/
│   │   ├── modes/
│   │   │   ├── minimal.zsh        # Minimal mode
│   │   │   ├── standard.zsh       # Standard mode
│   │   │   ├── supreme.zsh        # Supreme mode
│   │   │   ├── ultimate.zsh       # Ultimate mode (always sourced last in .zshrc)
│   │   │   └── ultra-nerd.zsh     # Ultra-nerd mode
│   │   ├── aliases.zsh            # Zsh-specific aliases
│   │   ├── detect_apps.zsh        # Dynamic app detection for zsh
│   │   └── exports.zsh            # Zsh environment exports
│   └── gpu-env.sh                 # GPU environment variable setup
│
├── swaync/
│   ├── config.jsonc               # SwayNC notification daemon config
│   └── style.css                  # Nord notification CSS
│
├── swayosd/
│   ├── config.toml                # On-screen display config
│   └── style.css                  # Nord OSD theme
│
├── systemd/user/
│   ├── wallpaper-fetch.service    # Daily wallpaper fetch systemd service
│   └── wallpaper-fetch.timer      # OnCalendar=daily timer
│
├── tests/
│   └── run_tests.sh               # ★ 30-section full system integrity suite
│
├── themes/                        # Dark/light theme variant files (managed by theme.sh)
│   ├── alacritty-dark.toml
│   ├── alacritty-light.toml
│   ├── dark.lua                   # Hyprland Nord dark color table
│   ├── fastfetch-dark.jsonc
│   ├── fastfetch-light.jsonc
│   ├── hyprlock-dark.conf
│   ├── hyprlock-light.conf
│   ├── kitty-dark.conf
│   ├── kitty-light.conf
│   ├── light.lua                  # Hyprland light color table
│   ├── rofi-dark.rasi
│   ├── rofi-light.rasi
│   ├── swaync-dark.css
│   ├── swaync-light.css
│   ├── swayosd-dark.css
│   ├── swayosd-light.css
│   ├── theme.sh                   # ★ Theme switcher (179 lines — all apps at once)
│   ├── waybar-dark.css
│   ├── waybar-light.css
│   ├── wlogout-dark.css
│   └── wlogout-light.css
│
├── waybar/
│   ├── scripts/
│   │   ├── battery-info.sh        # Battery info popup (yad)
│   │   ├── calendar.sh            # Calendar popup
│   │   ├── media.sh               # playerctl → JSON output
│   │   ├── net-speed.sh           # Network speed → JSON (2s interval)
│   │   ├── power-profile-cycle.sh # Cycle power profiles daemon
│   │   ├── power.sh               # Power menu
│   │   └── theme.sh               # Waybar-specific theme helper
│   ├── config-bottom.jsonc        # Bottom bar config
│   ├── config.jsonc               # ★ Top bar (workspaces+window | media | stats+clock)
│   └── style.css                  # Nord Waybar CSS
│
├── wlogout/
│   ├── layout                     # 6 buttons: lock, logout, suspend, reboot, shutdown, hibernate
│   └── style.css                  # Nord wlogout theme
│
├── Agents.md                      # Agent policy (rules for AI/CI editing this repo)
├── CLAUDE.md                      # This file
├── install.sh                     # Bootstrap entrypoint (curl | sh)
├── README.md                      # Project readme
└── REFERENCE.md                   # Prompt engineering reference

# Also present (gitignored):
# zcompiled/   — .zsh + .zwc compiled function caches
# wallpapers/  — 38 wallpapers (nord_*.png/jpg + fetch_*.png/jpg)
# logs/        — doctor.log, dots.log
# scratch/     — temp scripts
# errors.log, install_date, last_update_check
```

---

## 3. Shell Startup Sequence (Zsh — the primary shell)

```
~/.zprofile  (login shells only)
  └─ brew shellenv (if macOS/Homebrew present)
  └─ source ~/.zshrc

~/.zshrc  (135 lines — always for interactive)
  ├─ unset stale vars, export DOTFILES_DIR / DOTFILES_STATE_DIR / DOTFILES_NAME
  ├─ starship init zsh
  ├─ [non-interactive: return 0]
  ├─ DOTFILES_MODE  ← read from $DOTFILES_STATE_DIR/mode, default "supreme"
  ├─ XDG dirs, EDITOR=nvim, PAGER, BAT_THEME=TwoDark, HIST* (100K)
  ├─ setopt: AUTO_CD CORRECT NOMATCH AUTO_PUSHD PUSHD_IGNORE_DUPS
  ├─ setopt: HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY
  ├─ PATH prepend: ~/.local/bin  ~/.cargo/bin
  ├─ source shells/zsh/exports.zsh
  ├─ compinit  (cached 24h via zcompdump mtime check)
  ├─ zstyle completions (menu select, case-insensitive, LS_COLORS)
  ├─ bindkey emacs + custom (arrows, word-jump, kill-line, yank, undo)
  ├─ source core/__cache.sh
  ├─ source core/universal.sh          (via `emulate sh`)
  ├─ source shells/zsh/detect_apps.zsh
  ├─ source core/aliases.sh
  ├─ source shells/zsh/aliases.zsh
  ├─ [unsetopt aliases]
  ├─ source core/functions.sh
  ├─ source core/arch_aliases.sh
  ├─ source core/debian_aliases.sh
  ├─ source core/macos_aliases.sh
  ├─ source core/fedora_aliases.sh
  ├─ source core/system-detect.sh
  ├─ source core/os_detect.sh
  ├─ source core/logging.sh
  ├─ source core/ssh-agent.sh
  ├─ source core/battery.sh
  ├─ source core/tools.sh
  ├─ [restore aliases]
  ├─ source shells/zsh/modes/ultimate.zsh   (ALWAYS — the final layer)
  ├─ fastfetch (interactive only)
  └─ Background update check (7-day interval via last_update_check, disowned)
```

**Mode system**: `$DOTFILES_MODE` ∈ {`minimal`, `standard`, `supreme`, `ultimate`, `ultra-nerd`}. Read from `$DOTFILES_STATE_DIR/mode`. `ultimate.zsh` is **always** sourced regardless of mode (it's the comprehensive default layer).

---

## 4. Key Environment Variables

| Variable | Default | Set in |
|---|---|---|
| `DOTFILES_DIR` | `~/.local/share/dotfiles` | `.zshrc` |
| `DOTFILES_STATE_DIR` | `~/.local/share/dotfiles` | `.zshrc` |
| `DOTFILES_NAME` | `"Pinak's Dotfiles"` | `.zshrc` |
| `DOTFILES_MODE` | `supreme` | `.zshrc` (from mode file) |
| `DOTFILES_VERSION` | `1.0.0` | `.zshrc` |
| `DOTFILES_OS` | `uname -s` | `core/universal.sh` |
| `DOTFILES_ARCH` | `uname -m` | `core/universal.sh` |
| `DOTFILES_DISTRO` | auto-detected | `core/universal.sh` |
| `DOTFILES_PKG_MANAGER` | auto-detected | `core/universal.sh` |
| `DOTFILES_INIT` | auto-detected | `core/universal.sh` |
| `STARSHIP_CONFIG` | `~/.config/starship.toml` (XDG) | `modes/ultimate.zsh` |
| `EDITOR` / `VISUAL` | `nvim` (if available) | `.zshrc` |
| `BAT_THEME` | `TwoDark` | `.zshrc` |
| `FZF_DEFAULT_OPTS` | `--height=60% --layout=reverse --border` | `modes/ultimate.zsh` |
| `DOTFILES_NO_UPDATE` | unset | user — set to skip auto-update |

---

## 5. The `dots` CLI (`bin/dots`)

Primary management interface. Always use this for system operations.

```bash
dots doctor              # Full health check (100-pt score, A–F grade)
dots doctor --fix        # Auto-repair: fix symlinks + install missing tools
dots update              # git pull + pre-update tar.gz snapshot
dots rollback            # Restore a previous snapshot (interactive picker)
dots status              # Branch, hash, uncommitted changes, active profile
dots profile <name>      # Switch: laptop | desktop | work | gaming | lowpower
dots reload <target>     # Hot-reload: waybar | hypr | kitty | tmux | shell | all
dots logs [mode]         # all | errors | doctor | update | clear
dots install [--flags]   # Run cross-distro installer
dots docs                # Open docs/index.html in browser
dots benchmark           # Benchmark shell startup times
dots safe                # Launch minimal rescue shell (no aliases, no plugins)
```

`bin/dots-doctor` — **100-point health scoring**:
- A ≥ 90, B ≥ 80, C ≥ 70, D ≥ 60, F < 60
- Checks: dotfiles dir, git integrity, 9 core tools, config symlinks, Hyprland configs, Waybar, core/ syntax, log sizes, package manager, display server (Wayland vs X11)

---

## 6. Hyprland Configuration (Critical)

> **Format: Pure Lua via `hl.*` API — NOT traditional `.conf` syntax**

**Entry point** `hypr/hyprland.lua` (15 lines — only `require()` calls):
```lua
require("configs/theme")       -- Nord color table → global `theme` + `theme_rgb`
pcall(require, "configs/env")  -- GPU env vars (generated, optional — pcall for safety)
require("configs/monitors")
require("configs/input")
require("configs/decor")
require("configs/animations")
require("configs/windowrules")
require("configs/workspaces")
require("configs/keybinds")
require("configs/autostart")
require("configs/devices")
```

**theme.lua** — Nord color table (always reference `theme.*`, never hardcode hex):
```lua
theme = {
  bg="#2e3440", bg_alt="#3b4252", bg_surface="#434c5e", border="#4c566a",
  fg="#d8dee9",  fg_bright="#eceff4", fg_dim="#81a1c1",
  accent="#88c0d0", accent2="#8fbcbb", accent3="#81a1c1", accent4="#5e81ac",
  red="#bf616a", orange="#d08770", yellow="#ebcb8b", green="#a3be8c", purple="#b48ead"
}
-- Also theme_rgb = { ... } with comma-separated RGB values for rgba() usage
```

**decor.lua** — visual settings:
- `rounding = 10`, `gaps_in = 5`, `gaps_out = 8`, `border_size = 2`
- Active border: 45° gradient `theme.accent → theme.accent3 → theme.accent2`
- `inactive_opacity = 0.90`, shadow range=16, blur size=10 passes=3

**windowrules.lua** — tag-based system:
| Tag | Classes | Opacity (active/inactive) |
|-----|---------|--------------------------|
| `+browser` | firefox, chrome, chromium, brave, zen-beta | 0.82 / 0.65 |
| `+terminal` | kitty, alacritty, foot | 0.80 / 0.60 |
| `+projects` | code-oss, code, zed, jetbrains-* | 0.80 / 0.62 |
| `+im` | discord, ferdium, whatsapp, telegram | 0.82 / 0.68 |
| `+filemanager` | thunar, nautilus, pcmanfm, nemo | 0.80 / 0.60 |
| `+media` | mpv, vlc, audacious | 0.82 / 0.62 |
| `+settings` | pavucontrol, blueman, nm-connection-editor | float+center 60%×60% |
- PiP: float+pin, 30%×30%, position 72%/7%, opacity 0.95/0.75
- `xwaylandvideobridge`: opacity 0.0, no_anim, max_size 1×1
- Fullscreen windows: `idle_inhibit = "fullscreen"`

**keybinds.lua** (`mainMod = "SUPER"`):
```
SUPER+Return    → kitty
SUPER+D         → rofi -show drun (compact)
SUPER+Space     → rofi -show drun (full config)
SUPER+Tab       → rofi -show window (full config)
SUPER+E         → nautilus
SUPER+B         → firefox
SUPER+period    → rofi emoji
SUPER+Q         → close window
SUPER+Escape    → wlogout
SUPER+F         → fullscreen
SUPER+V         → float toggle
SUPER+L         → hyprlock
SUPER+G         → togglegroup
SUPER+H/J/K/L  → focus direction (arrow keys also work)
SUPER+SHIFT+H/J/K/L → resize window
SUPER+ALT+H/J/K/L   → move window
SUPER+1–9       → switch workspace
SUPER+SHIFT+1–9 → move window to workspace
SUPER+grave     → scratchpad toggle
SUPER+W         → wallpaper-fetch
SUPER+SHIFT+W   → wallpaper-fetch --next
SUPER+N         → nightlight
SUPER+SHIFT+T   → theme.sh light
SUPER+CTRL+SHIFT+T → theme.sh dark
SUPER+M         → fullscreen maximize (keep gaps/bar)
SUPER+O         → changeLayout (toggle dwindle ↔ master)
SUPER+SHIFT+A   → animations-menu
SUPER+ALT+O     → blur-toggle
SUPER+SHIFT+D   → diagreload (in kitty)
SUPER+SHIFT+B   → toggle waybar hidden (SIGUSR1)
SUPER+CTRL+B    → waybar-reload
Print           → screenshot --now
SHIFT+Print     → screenshot --area
CTRL+Print      → screenshot --window
SUPER+SHIFT+S   → screenshot --area
SUPER+CTRL+S    → screenshot --swappy
XF86Audio*      → volume script (locked=true)
XF86Brightness* → brightness script (locked=true)
XF86AudioPlay/Next/Prev → playerctl (locked=true)
```

**hypridle.conf** idle chain:
- 5 min → dim brightness (brightnessctl -s set 10)
- 10 min → lock session (loginctl lock-session)
- 15 min → DPMS off
- 30 min → systemctl suspend

**autostart.lua** (on `hyprland.start`):
waybar (top), waybar (bottom config), swaync, hyprpaper, wallpaper-fetch --quiet (sleep 2), hypridle, swayosd-server, polkit-gnome, xdg-desktop-portal-hyprland, nm-applet, blueman-applet, dbus-update-activation-environment, gnome-keyring-daemon, set-env

---

## 7. Installer Profiles (`install/install.sh`, 996 lines)

| Profile | Contents |
|---------|----------|
| `--minimal` | Shell tools + dev tools + git tools |
| `--standard` | Minimal + containers (default) |
| `--full` | Standard + cloud + hyprland/macOS extras |
| `--hyprland` | Wayland ecosystem only (Linux) |
| `--macos` | macOS GNU coreutils extras only |

**Package manager priority** (auto-detected):
`brew → paru → yay → pacman → apt → dnf → zypper → apk → xbps → emerge → nix → slackpkg`

**Post-install fixes**: bat→batcat symlink (Debian/Ubuntu), fd→fdfind symlink, cargo fallbacks (starship, zoxide, atuin, fastfetch), go fallback (lazygit).

---

## 8. Theme System (`themes/theme.sh`, 179 lines)

Switches **all** apps atomically in one command:

| Step | File changed |
|------|-------------|
| 1 | `hypr/configs/theme.lua` ← `themes/dark.lua` or `themes/light.lua` |
| 2 | `waybar/style.css` |
| 3 | `rofi/themes/nord.rasi` |
| 4 | `swaync/style.css` |
| 5 | `wlogout/style.css` |
| 6 | `swayosd/style.css` |
| 7 | `kitty/nord.conf` |
| 8 | `hypr/hyprlock.conf` |
| 9 | `alacritty/alacritty.toml` (sed import line swap) |
| 10 | `apps/fastfetch/config.jsonc` (sed color code swap) |
| 11 | Wallpaper via `wallpaper-fetch --dark/--light` |
| 12 | GTK via `gsettings` + `~/.config/gtk-3.0/settings.ini` |
| 13 | State saved to `~/.cache/hyprland-theme` |
| 14 | Reload: hyprctl, waybar (kill+restart both bars), swaync-client --reload-css, swayosd restart, kitty @ set-colors |

---

## 9. Waybar Layout

**Top bar** (`waybar/config.jsonc`): height=36px, margin=8px all sides
- **Left**: `hyprland/workspaces` (9 persistent, icons 1–9), `hyprland/window` (max 40 chars, rewrites Firefox/VSCode/Obsidian titles)
- **Center**: `custom/media` (playerctl JSON, click=play-pause, scroll=next/prev)
- **Right**: `tray` → `pulseaudio` → `network` → `custom/net-speed` → `cpu` → `memory` → `temperature` → `power-profiles-daemon` → `battery` (BAT0) → `clock`

**Bottom bar** (`waybar/config-bottom.jsonc`): separate secondary bar

---

## 10. Nord Color Palette Reference

| Nord | Hex | `theme.*` key | Usage |
|------|-----|---------------|-------|
| Nord0 | `#2e3440` | `theme.bg` | Darkest bg |
| Nord1 | `#3b4252` | `theme.bg_alt` | Dark surfaces |
| Nord2 | `#434c5e` | `theme.bg_surface` | Selection/inactive |
| Nord3 | `#4c566a` | `theme.border` | Muted text/borders |
| Nord4 | `#d8dee9` | `theme.fg` | Primary text |
| Nord5 | `#e5e9f0` | — | Light text |
| Nord6 | `#eceff4` | `theme.fg_bright` | Brightest text |
| Nord7 | `#8fbcbb` | `theme.accent2` | Teal accent |
| Nord8 | `#88c0d0` | `theme.accent` | **Primary accent** |
| Nord9 | `#81a1c1` | `theme.accent3` / `theme.fg_dim` | Secondary blue |
| Nord10 | `#5e81ac` | `theme.accent4` | Tertiary blue |
| Nord11 | `#bf616a` | `theme.red` | Errors/urgent |
| Nord12 | `#d08770` | `theme.orange` | Orange |
| Nord13 | `#ebcb8b` | `theme.yellow` | Warning |
| Nord14 | `#a3be8c` | `theme.green` | OK/charging |
| Nord15 | `#b48ead` | `theme.purple` | Purple |

---

## 11. Verification Commands

Run **in this order** before any commit:

```bash
# 1. Fast syntax + sourcing check (~5 seconds)
bash bin/test_repo.sh

# 2. Full 30-section system integrity suite (~5 seconds)
bash tests/run_tests.sh

# 3. Health check (if Hyprland is active)
dots doctor
```

### What `tests/run_tests.sh` checks (30 sections):
1. Hyprland Lua config files exist
2. `hyprland.lua` source paths valid
3. No deprecated Hyprland options (`pseudotile`, `no_focus`, etc.)
4. No duplicate keybind combos
5. Window rule classes match installed apps
6. exec-once commands available
7. Hypr scripts exist + executable
8. Waybar config valid JSON
9. Waybar modules have CSS selectors
10. Waybar scripts executable
11. Rofi configs have `@theme`
12. Wlogout labels match CSS IDs
13. SwayNC JSON valid
14. Kitty `font_family` + `include`
15. Alacritty TOML check
16. Wallpapers exist (count > 0)
17. Hyprpaper preload path exists
18. No Nord color variable mismatches
19. Battery device exists in sysfs
20. Network interface exists
21. Shell script syntax (`bash -n`, `zsh -n`, `fish -n`)
22. `.gitignore` covers secrets
23. Systemd unit files exist
24. Directory structure integrity (24 required dirs)
25. Install scripts executable
26. `bin/dots` + `bin/dots-doctor` executable
27. Rofi config → theme file reference valid
28. CSS no invalid GTK properties (`backdrop-filter`)
29. `wallpaper-fetch` fallback chain intact
30. Profile files exist (soft warning)

---

## 12. Conventions & Rules

### Shell scripts (`core/`, `shells/`, `bin/`)
- Shebang: `#!/usr/bin/env bash` (or `#!/usr/bin/env sh` for POSIX installers)
- `core/` files must be POSIX-compatible — no `[[`, no `((...))`, no arrays
- Every function: one-line comment above (purpose, inputs, outputs)
- Non-trivial lines: inline comment explaining *why* (intent/edge cases)
- No redundant comments (`x=1 # set x to 1`)

### Hyprland Lua configs
- Always use `theme.*` — never hardcode hex colors
- Script paths in keybinds: always full absolute `~/.local/share/dotfiles/hypr/scripts/...`
- Never edit `hyprland.lua` directly (it's only `require()` calls)
- `pcall(require, ...)` for generated/optional configs

### CSS (waybar, swaync, wlogout, swayosd)
- No `backdrop-filter` — GTK4 CSS does not support it
- Colors from Nord palette only
- New waybar module → add BOTH CSS selector AND `config.jsonc` entry

### Theme system
- Never manually edit `kitty/nord.conf`, `rofi/themes/nord.rasi`, `waybar/style.css`, etc.
- Always use `themes/theme.sh dark` or `themes/theme.sh light` to apply themes

### Wallpapers
- Naming: `nord_<description>.png|jpg` for curated, `fetch_<timestamp>.png|jpg` for fetched
- Location: `wallpapers/` only
- `wallpaper-fetch` manages Unsplash → GitHub → local fallback

---

## 13. What NOT To Do

- ❌ `curl | sh` — always download → verify → run
- ❌ Hardcode hex colors in Lua — use `theme.*`
- ❌ Use Zsh/Fish syntax in `core/` shared scripts (must be POSIX)
- ❌ Edit `hyprland.lua` content (only `require()` calls there)
- ❌ Use `.conf` Hyprland syntax — this repo is **Lua API only**
- ❌ Use `backdrop-filter` in CSS files
- ❌ Commit without running `bin/test_repo.sh`
- ❌ Manually edit theme-managed files (kitty/nord.conf, rofi/themes/nord.rasi, etc.)
- ❌ Create `profiles/` files — they are generated on demand by `dots profile`
- ❌ Place temp files outside `scratch/` or the designated workspace

---

## 14. Known Acceptable Test Failures

| Test | Reason | Severity |
|------|--------|----------|
| `wlogout: MISSING # Lock…` | Labels use Nerd Font icons, test checks CSS ID match on icon labels | Cosmetic |
| `hyprpaper preload: $HOME/…` | Literal `$HOME` in hyprpaper.conf | Cosmetic |
| `install/install.sh: SYNTAX ERROR` | `bash -n` false positive on heredoc in sh script | Cosmetic |
| `MISSING DIR: profiles` | Generated on-demand by `dots profile`, not committed | Expected |
| `.gitignore MISSING *.key…` | Soft warnings, not required | Acceptable |

---

*Last updated: 2026-05-26 — from live `tree -A` + full source inspection*
