# Agents.md — Policy for AI & Automated Agents

> This file is **authoritative**. Any change that weakens these rules must be reviewed and approved by a human maintainer.
> Read `CLAUDE.md` for full project context before making any edits.

---

## Purpose

- Enforce quality, safety, and consistency for any automated agent (AI, CI, or script) editing this repository.
- Prevent low-quality, untested, hallucinated, or unsafe AI-generated changes ("AI slop").
- Ensure all contributions match the hand-crafted, zero-generated-code standard of this project.

---

## Scope

Applies to every file in this repository. See [Critical Files](#critical-files) for the highest-risk subset.

---

## Project Snapshot (from `tree -A`)

```
34 directories, 166 files (excl. .git, zcompiled, wallpapers, logs, scratch)

alacritty/alacritty.toml
apps/atuin/config.toml
apps/brew/Brewfile
apps/fastfetch/{battery_health.sh,config.jsonc,os_age.sh}
apps/git/gitconfig
apps/lazygit/config.yml
apps/tmux/tmux.conf
apps/{inventory.baseline.json,starship-linux.toml,starship-mac.toml}
bin/{benchmark_shell.sh,build_data.js,build_docs_data.sh,check_startup.sh}
bin/{diagnostic.sh,dots,dots-doctor,dotupdate_bg.sh,dotupdate.sh}
bin/{health_check.sh,inventory_check.sh,setup_hooks.sh,test_all.sh,test_repo.sh}
core/{aliases.sh,arch_aliases.sh,battery.sh,__cache.sh,debian_aliases.sh}
core/{fedora_aliases.sh,functions.sh,logging.sh,macos_aliases.sh,os_detect.sh}
core/{ssh-agent.sh,system-detect.sh,tools.sh,universal.sh}
docs/{architecture,bash,diagnostics,faq,fastfetch,features,fish,index,install,
      performance,reference,starship,zsh}.html + data.js + style.css
hypr/animations/{default,fast,smooth}.lua
hypr/configs/{animations,autostart,decor,devices,env,input,keybinds,
               monitors,theme,windowrules,workspaces}.lua
hypr/scripts/{animations-menu,blur-toggle,brightness,changeLayout,diagnose,
              diagreload,gamemode,gpu-detect,keyhints,keyhints-yad,nightlight,
              refresh,screenrecord,screenshot,set-env,settings-menu,touchpad,
              transparency,volume,wallpaper-fetch,waybar-reload}
hypr/{apply.sh,hypridle.conf,hyprland.lua,hyprlock.conf,hyprpaper.conf,uninstall.sh}
install/{fonts-install.sh,install.sh,uninstall.sh}
kitty/{kitty.conf,nord.conf}
rofi/themes/nord.rasi  rofi/{config-full,config}.rasi
shells/bash/{aliases.bash,detect_apps.bash,exports.bash}
shells/fish/{aliases,config,detect_apps,exports,functions}.fish
shells/gpu-env.sh
shells/zsh/modes/{minimal,standard,supreme,ultimate,ultra-nerd}.zsh
shells/zsh/{aliases,detect_apps,exports}.zsh
shells/zsh/{.zshrc,.zprofile}      (symlinked to ~/.zshrc, ~/.zprofile)
swaync/{config.jsonc,style.css}
swayosd/{config.toml,style.css}
systemd/user/{wallpaper-fetch.service,wallpaper-fetch.timer}
tests/run_tests.sh
themes/{alacritty,fastfetch,hyprlock,kitty,rofi,swaync,swayosd,waybar,wlogout}-{dark,light}.*
themes/{dark,light}.lua  themes/theme.sh
waybar/scripts/{battery-info,calendar,media,net-speed,power,power-profile-cycle,theme}.sh
waybar/{config-bottom,config}.jsonc  waybar/style.css
wlogout/{layout,style.css}
{Agents.md,CLAUDE.md,install.sh,README.md,REFERENCE.md}
```

---

## Architecture (Must Understand Before Editing)

### Shell sourcing flow
```
.zshrc
 ├─ shells/zsh/exports.zsh
 ├─ core/__cache.sh
 ├─ core/universal.sh          ← POSIX only, distro/PM detection
 ├─ shells/zsh/detect_apps.zsh
 ├─ core/aliases.sh            ← 1600+ aliases, all shells
 ├─ shells/zsh/aliases.zsh
 ├─ core/functions.sh          ← 2909 lines
 ├─ core/{arch,debian,macos,fedora}_aliases.sh
 ├─ core/{system-detect,os_detect,logging,ssh-agent,battery,tools}.sh
 └─ shells/zsh/modes/ultimate.zsh   ← always sourced last
```

### Hyprland config flow
```
hypr/hyprland.lua  (only require() calls)
 ├─ configs/theme.lua      ← Nord color table → global `theme` + `theme_rgb`
 ├─ configs/env.lua        ← GPU vars (pcall — optional/generated)
 ├─ configs/monitors.lua
 ├─ configs/input.lua
 ├─ configs/decor.lua
 ├─ configs/animations.lua
 ├─ configs/windowrules.lua
 ├─ configs/workspaces.lua
 ├─ configs/keybinds.lua
 ├─ configs/autostart.lua
 └─ configs/devices.lua
```

### Theme system flow
```
themes/theme.sh {dark|light}
 → copies theme variant files into active config locations:
   hypr/configs/theme.lua  waybar/style.css  rofi/themes/nord.rasi
   swaync/style.css  wlogout/style.css  swayosd/style.css
   kitty/nord.conf  hypr/hyprlock.conf  alacritty/alacritty.toml (sed)
   apps/fastfetch/config.jsonc (sed)
 → GTK: gsettings + ~/.config/gtk-3.0/settings.ini
 → Reloads: hyprctl, waybar, swaync, swayosd, kitty @ set-colors
```

---

## Rules for Every Agent

### 1 — Confirm intent before editing
Do not modify files without an explicit task. If uncertain, report what you plan to change and why before doing it.

### 2 — Understand the architecture first
Read `CLAUDE.md` for full context. Understand which layer a file belongs to (installer, core shared, shell-specific, Hyprland, theme system, waybar, docs) before touching it.

### 3 — No AI slop
Never commit code that is:
- Hallucinated or unverified
- Not tested with the appropriate linter/syntax checker
- Generic boilerplate that doesn't match the repository's style
- Missing required function-level documentation

### 4 — Shell invariance for `core/`
Files in `core/` must be **POSIX-compatible sh** — sourced by bash, zsh (`emulate sh`), and fish. Forbidden: `[[`, arrays, `((...))` arithmetic, `$BASH_*`, `$ZSH_*`.

### 5 — Theme compliance
All visual configs must use the **Nord 16-color palette** exclusively. In Lua configs: always use `theme.*` keys, never hardcode hex. In CSS/TOML/JSONC: use the hex values from the Nord table in `CLAUDE.md §10`.

### 6 — Hyprland Lua API only
This repo uses the `hl.*` Lua API — **not** the `.conf` format. Never write `bind = SUPER, ...` or `exec-once = ...` style config. Always use `hl.bind(...)`, `hl.exec_cmd(...)`, `hl.config({...})`, `hl.window_rule({...})`.

### 7 — Never edit theme-managed files directly
Do not manually edit: `kitty/nord.conf`, `rofi/themes/nord.rasi`, `waybar/style.css`, `swaync/style.css`, `wlogout/style.css`, `swayosd/style.css`, `hypr/hyprlock.conf`. These are overwritten by `themes/theme.sh`. Edit the source in `themes/` instead.

### 8 — Never edit `hyprland.lua`
It contains only `require()` calls. If you need to add config, create or edit the appropriate `configs/*.lua` file.

### 9 — Documentation on every function
For every new shell function or Lua function block, add:
- A single concise comment **above** the function: purpose, inputs, outputs, usage
- Inline comments for non-obvious or safety-critical lines only
- No redundant comments (`x=1 # set x to 1` is unacceptable)

### 10 — Network safety
Never use `curl | sh` or `wget | sh`. Always: download to temp file → verify it's non-empty + has a valid shebang → run. Document the source URL.

### 11 — Idempotence
Installer scripts must be fully idempotent. No destructive action without an explicit guard and user confirmation.

### 12 — Verify before committing
Run verification in this order:
```bash
bash bin/test_repo.sh     # syntax + sourcing (~5s)
bash tests/run_tests.sh   # 30-section integrity suite (~5s)
dots doctor               # health score (if Hyprland running)
```
Fix every ✗ failure. ∼ warnings are acceptable if they are in the known-acceptable list below.

### 13 — Atomic commits
One logical change per commit. Descriptive commit message. Do not bundle unrelated changes. Do not auto-merge — request human review.

### 14 — No temp files outside workspace
Use `scratch/` for temporary scripts. Never write to `/tmp`, `/home`, or paths outside the repository without explicit user approval.

---

## Critical Files

Files that must never contain slop, untested code, or unreviewed changes:

### Installation
- [`install.sh`](file:///home/pinak/.local/share/dotfiles/install.sh) — bootstrap entrypoint
- [`install/install.sh`](file:///home/pinak/.local/share/dotfiles/install/install.sh) — 996-line cross-distro installer
- [`install/uninstall.sh`](file:///home/pinak/.local/share/dotfiles/install/uninstall.sh)
- [`install/fonts-install.sh`](file:///home/pinak/.local/share/dotfiles/install/fonts-install.sh)

### Core shared layer
- [`core/universal.sh`](file:///home/pinak/.local/share/dotfiles/core/universal.sh) — 1677 lines, POSIX, sourced by all shells
- [`core/aliases.sh`](file:///home/pinak/.local/share/dotfiles/core/aliases.sh) — 1600+ aliases
- [`core/functions.sh`](file:///home/pinak/.local/share/dotfiles/core/functions.sh) — 2909 lines
- [`core/os_detect.sh`](file:///home/pinak/.local/share/dotfiles/core/os_detect.sh)
- [`core/system-detect.sh`](file:///home/pinak/.local/share/dotfiles/core/system-detect.sh)
- [`core/ssh-agent.sh`](file:///home/pinak/.local/share/dotfiles/core/ssh-agent.sh)

### Shell startup
- [`shells/zsh/.zshrc`](file:///home/pinak/.local/share/dotfiles/shells/zsh/.zshrc)
- [`shells/zsh/.zprofile`](file:///home/pinak/.local/share/dotfiles/shells/zsh/.zprofile)
- [`shells/bash/.bashrc`](file:///home/pinak/.local/share/dotfiles/shells/bash/.bashrc) (not present in tree — bash startup file if added)
- [`shells/fish/config.fish`](file:///home/pinak/.local/share/dotfiles/shells/fish/config.fish)
- [`shells/zsh/modes/ultimate.zsh`](file:///home/pinak/.local/share/dotfiles/shells/zsh/modes/ultimate.zsh) — always sourced last

### Hyprland (Lua)
- [`hypr/hyprland.lua`](file:///home/pinak/.local/share/dotfiles/hypr/hyprland.lua) — entry point (only require())
- [`hypr/configs/keybinds.lua`](file:///home/pinak/.local/share/dotfiles/hypr/configs/keybinds.lua)
- [`hypr/configs/autostart.lua`](file:///home/pinak/.local/share/dotfiles/hypr/configs/autostart.lua)
- [`hypr/configs/windowrules.lua`](file:///home/pinak/.local/share/dotfiles/hypr/configs/windowrules.lua)
- [`hypr/configs/theme.lua`](file:///home/pinak/.local/share/dotfiles/hypr/configs/theme.lua)

### CLI tools
- [`bin/dots`](file:///home/pinak/.local/share/dotfiles/bin/dots) — 425-line CLI controller
- [`bin/dots-doctor`](file:///home/pinak/.local/share/dotfiles/bin/dots-doctor) — 310-line health diagnostic
- [`bin/dotupdate.sh`](file:///home/pinak/.local/share/dotfiles/bin/dotupdate.sh)

### Theme system
- [`themes/theme.sh`](file:///home/pinak/.local/share/dotfiles/themes/theme.sh) — 179-line atomic theme switcher

---

## Verification Reference

```bash
# Always run before committing
bash bin/test_repo.sh        # BASH/ZSH/FISH syntax + core/ sourcing check
bash tests/run_tests.sh      # 30 checks: config files, JSON, CSS, scripts, dirs
dots doctor                  # 100-pt health score (requires Hyprland)
```

`tests/run_tests.sh` checks (30 sections):
1–3: Hyprland Lua files exist, source paths valid, no deprecated options
4: No duplicate keybind combos
5–7: Window rules, exec-once, hypr scripts exist+executable
8–10: Waybar JSON valid, CSS covers all modules, scripts executable
11–12: Rofi @theme refs, wlogout label↔CSS match
13–16: SwayNC JSON, kitty font, alacritty TOML, wallpapers count
17–20: Hyprpaper preload path, Nord color vars, battery device, network interface
21: Shell syntax (bash -n, zsh -n, fish -n) for ALL scripts
22–23: .gitignore secrets coverage, systemd unit files
24–27: Directory structure (24 required dirs), install+bin executables, rofi theme refs
28–30: CSS GTK validity, wallpaper-fetch fallback chain, profile files

---

## Known Acceptable Failures

These `tests/run_tests.sh` failures are pre-existing and acceptable:

| Failure | Reason |
|---------|--------|
| `wlogout: MISSING #Lock…` | Test checks uppercase `#Lock`, CSS uses lowercase |
| `hyprpaper preload: $HOME/…` | Literal `$HOME` not expanded in hyprpaper.conf |
| `install/install.sh: SYNTAX ERROR` | `bash -n` false positive on sh-style heredoc |
| `MISSING DIR: profiles` | Generated on-demand by `dots profile`, intentionally uncommitted |
| `.gitignore MISSING *.key/pem/env…` | Soft warnings only |

---

## Reviewer Checklist

Before approving any agent-produced change:

- [ ] Did the agent read `CLAUDE.md` and demonstrate understanding of the affected layer?
- [ ] Is every new shell function documented with a one-line usage comment?
- [ ] Did `bash bin/test_repo.sh` pass with exit 0?
- [ ] Did `bash tests/run_tests.sh` produce no new ✗ failures?
- [ ] Are all colors from the Nord palette? No hardcoded hex in Lua?
- [ ] Are all `core/` changes POSIX-compatible (no `[[`, no arrays)?
- [ ] Are theme-managed files untouched (edit the `themes/` source instead)?
- [ ] Is every network download download→verify→run (no `curl | sh`)?
- [ ] Is the change atomic and the commit message descriptive?

---

## Contact / Escalation

If unsure whether a change is safe:
- Do NOT push to `main`
- Open an issue with labels `security` or `installer`
- Request explicit human review

---

*Last updated: 2026-05-26 — from live `tree -A` + full source inspection*
