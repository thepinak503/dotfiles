# Pinak's Dotfiles — Prompt Engineering Reference

Use this document to give an LLM full context about this dotfiles repository.

---

## File Tree

```
dotfiles/
├── install.sh                          # Bootstrap: clones repo, runs install/
├── Agents.md                           # Agent instructions
├── README.md                           # Project readme
├── REFERENCE.md                        # This file
├── errors.log                          # Runtime errors (gitignored)
├── install_date                        # Install timestamp (gitignored)
├── last_update_check                   # Update check cache (gitignored)
│
├── alacritty/
│   └── alacritty.toml                  # Alacritty terminal config (Nord)
│
├── apps/                               # Third-party app configs
│   ├── atuin/config.toml               # Shell history (daemon-fuzzy, compact)
│   ├── brew/Brewfile                   # Homebrew bundle manifest
│   ├── fastfetch/
│   │   ├── config.jsonc                # System info display (20 modules)
│   │   ├── battery_health.sh           # Battery health script
│   │   └── os_age.sh                   # OS install date script
│   ├── git/gitconfig                   # Git config (delta, Nord, 50+ aliases)
│   ├── inventory.baseline.json         # Package inventory baseline
│   ├── lazygit/config.yml              # Lazygit TUI config (Nord)
│   ├── starship-linux.toml             # Starship prompt (Tokyo Night, 1204 lines)
│   ├── starship-mac.toml               # Starship prompt (macOS variant)
│   └── tmux/tmux.conf                  # Tmux config (Nord, C-a prefix)
│
├── bin/                                # Utility scripts
│   ├── benchmark_shell.sh              # Shell startup benchmark
│   ├── build_data.js                   # Docs data builder
│   ├── build_docs_data.sh              # Documentation builder
│   ├── check_startup.sh               # Startup time check
│   ├── diagnostic.sh                   # Full system diagnostic (349 lines)
│   ├── dotupdate_bg.sh                # Background dotfiles updater
│   ├── dotupdate.sh                   # Dotfiles update manager
│   ├── health_check.sh                # Dotfiles health check
│   ├── inventory_check.sh             # Package inventory audit
│   ├── setup_hooks.sh                 # Git hooks installer
│   ├── test_all.sh                    # Cross-shell test runner
│   └── test_repo.sh                   # Repository tests
│
├── core/                               # Cross-shell shared layer
│   ├── aliases.sh                      # Universal aliases (1601 lines)
│   ├── arch_aliases.sh                 # Arch Linux pacman/yay/paru aliases
│   ├── battery.sh                      # Battery query utilities
│   ├── __cache.sh                      # Internal caching layer
│   ├── debian_aliases.sh               # Debian/Ubuntu apt aliases
│   ├── fedora_aliases.sh               # Fedora dnf aliases
│   ├── functions.sh                    # Shared functions (2909 lines)
│   ├── logging.sh                      # Colored logging utilities
│   ├── macos_aliases.sh                # macOS brew aliases
│   ├── os_detect.sh                    # POSIX OS detection
│   ├── ssh-agent.sh                    # SSH agent management
│   ├── system-detect.sh                # Hardware/compositor detection
│   ├── tools.sh                        # Command availability checks
│   └── universal.sh                    # Universal setup (1244 lines)
│
├── docs/                               # HTML documentation (15 pages)
│   ├── architecture.html
│   ├── bash.html
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
├── hypr/                               # Hyprland WM config
│   ├── apply.sh                        # Apply script
│   ├── configs/
│   │   ├── animations.conf             # Bezier curves + animation speeds
│   │   ├── autostart.conf              # exec-once services
│   │   ├── decor.conf                  # Gaps, borders, shadows, blur, rounding
│   │   ├── input.conf                  # KB layout, touchpad, mouse, gesture
│   │   ├── keybinds.conf               # 50+ keybindings (184 lines)
│   │   ├── monitors.conf              # Monitor auto-detect
│   │   ├── windowrules.conf           # Tag-based opacity rules (34 lines)
│   │   └── workspaces.conf            # Dwindle/master layout, misc, render
│   ├── hypridle.conf                   # Idle: 5min dim → 10min lock → 15min DPMS → 30min suspend
│   ├── hyprland.conf                   # Main entry (sources configs/, Nord colors)
│   ├── hyprlock.conf                   # Lock screen (blurred screenshot, clock, date)
│   ├── hyprpaper.conf                  # Wallpaper daemon config
│   ├── scripts/
│   │   ├── brightness                  # swayosd brightness control
│   │   ├── changeLayout               # Toggle dwindle/master
│   │   ├── gamemode                   # Toggle performance mode
│   │   ├── keyhints                   # Rofi keybind cheatsheet
│   │   ├── screenrecord               # wf-recorder with slurp
│   │   ├── touchpad                   # Toggle touchpad
│   │   ├── volume                     # swayosd volume control
│   │   └── wallpaper-fetch            # Wallpaper downloader
│   └── uninstall.sh                   # Hyprland uninstall
│
├── install/                            # Installation scripts
│   ├── fonts-install.sh               # Nerd Font installer (Meslo + Cascadia)
│   ├── install.sh                      # Main installer v2.0 (cross-distro)
│   └── uninstall.sh                   # Dotfiles uninstaller
│
├── kitty/
│   ├── kitty.conf                      # Kitty terminal (CaskaydiaCove, Nord, 85% opacity)
│   └── nord.conf                       # Nord 16-color palette
│
├── rofi/
│   ├── config-full.rasi               # Full launcher (5-col, 60% width)
│   ├── config.rasi                     # Compact launcher (2-col, 30% width)
│   └── themes/nord.rasi               # Nord theme (91 lines)
│
├── shells/                             # Shell configs
│   ├── bash/
│   │   ├── .bashrc                     # Main bashrc
│   │   ├── aliases.bash               # Bash-specific aliases
│   │   ├── detect_apps.bash           # App detection
│   │   └── exports.bash               # Environment variables
│   ├── fish/
│   │   ├── aliases.fish               # Fish aliases
│   │   ├── config.fish                # Fish config (225 lines, distro detection)
│   │   ├── detect_apps.fish           # App detection
│   │   ├── exports.fish               # Environment variables
│   │   └── functions.fish             # 1500+ functions (6502 lines)
│   └── zsh/
│       ├── .zshrc                      # Main zshrc
│       ├── .zprofile                   # Zsh login profile
│       ├── aliases.zsh                # Zsh-specific aliases
│       ├── detect_apps.zsh            # App detection
│       ├── exports.zsh                # Environment variables
│       └── modes/
│           ├── minimal.zsh            # Minimal mode
│           ├── standard.zsh           # Standard mode
│           ├── supreme.zsh            # Supreme mode (default)
│           ├── ultimate.zsh           # Ultimate mode (7.0K lines)
│           └── ultra-nerd.zsh         # Ultra-nerd mode
│
├── swayosd/
│   ├── config.toml                     # On-screen display config
│   └── style.css                       # OSD Nord theme
│
├── systemd/user/
│   ├── wallpaper-fetch.service        # Daily wallpaper service
│   └── wallpaper-fetch.timer          # OnCalendar=daily timer
│
├── tests/run_tests.sh                 # Test runner
│
├── wallpapers/                         # 11 wallpaper images
│   ├── nord_default.png               # Generated Nord gradient
│   └── fetch_*.png/jpg                # Fetched wallpapers
│
├── waybar/
│   ├── config.jsonc                    # Waybar config (net-speed, battery, media)
│   ├── scripts/
│   │   ├── battery-info.sh            # Battery popup (yad)
│   │   ├── calendar.sh                # Calendar popup
│   │   ├── media.sh                   # Playerctl media display
│   │   └── net-speed.sh               # Network speed monitor
│   └── style.css                      # Waybar Nord theme
│
├── wlogout/
│   ├── layout                         # 6-button layout (lock, logout, suspend, reboot, shutdown, hibernate)
│   └── style.css                      # Wlogout Nord theme
│
└── .gitignore                         # Ignores: __pycache__, errors.log, install_date, backups/, scratch/, zcompiled/
```

---

## Key Architecture

### Shell Layering
```
install.sh → clones repo → install/install.sh
                                    ↓
                         Symlinks ~/.bashrc, ~/.zshrc, etc.
                                    ↓
         .bashrc/.zshrc/config.fish → core/ (shared across all shells)
                                       ├── exports / universal (env, PATH)
                                       ├── aliases.sh (1601 lines, 500+ aliases)
                                       ├── functions.sh (2909 lines)
                                       ├── OS-specific (arch/debian/fedora/macos)
                                       ├── detection (os, system, tools, ssh-agent, battery)
                                       └── logging
```

### Theme: Nord (16-color palette)
| #  | Hex       | Usage                        |
|----|-----------|------------------------------|
| 00 | `#2e3440` | Darkest bg (everywhere)      |
| 01 | `#3b4252` | Dark surfaces                |
| 02 | `#434c5e` | Selection/inactive borders   |
| 03 | `#4c566a` | Muted text/borders           |
| 04 | `#d8dee9` | Primary text                 |
| 05 | `#e5e9f0` | Light text                   |
| 06 | `#eceff4` | Brightest text               |
| 07 | `#8fbcbb` | CPU/minor accent             |
| 08 | `#88c0d0` | **Primary accent**           |
| 09 | `#81a1c1` | Secondary accent             |
| 10 | `#5e81ac` | Tertiary blue                |
| 11 | `#bf616a` | Red/errors/urgent            |
| 12 | `#d08770` | Orange                       |
| 13 | `#ebcb8b` | Yellow/warning               |
| 14 | `#a3be8c` | Green/charging               |
| 15 | `#b48ead` | Purple                       |

### Prominent Configs
- **Kitty**: CaskaydiaCove Nerd Font Mono 11pt, 85% opacity, infinite scroll, cursor trail, powerline tabs
- **Waybar**: Top bar (36px), workspaces + window left, media/tray/audio/network/speed/cpu/memory/battery/clock right
- **Hyprland**: 8px rounding, 4/6 gaps, Nord gradient borders, tag-based window opacity, dwindle+master layouts
- **Starship**: Tokyo Night palette, 40+ language modules, git, cloud (aws/azure/gcp/k8s/terraform), battery
- **Git**: Delta pager (Nord), 50+ aliases, `main` branch, `gh` credential helper, rebase auto-stash
- **Tmux**: `C-a` prefix, vi navigation, Nord status bar, 10K history

### Shells
- **zsh** (primary): Starship prompt, ultimate mode, history dedup, 24h compinit cache
- **bash**: Fallback, same core sourcing, atuin bash hook
- **fish**: 6502-line function library, 1500+ functions, distro-aware package management

---

## Prompt Engineering Tips

When asking an LLM to work on this repo:

1. **Reference the tree** — paste the tree above and say "work within this structure"
2. **Theme enforcement** — always say "use Nord palette colors" for any config change
3. **Cross-shell** — remind "changes must work in bash, zsh, and fish" when editing core/
4. **Distro-aware** — "ensure this works on Arch, Debian, Fedora, openSUSE, macOS" for installer changes
5. **Format** — all configs use their native format (.conf, .jsonc, .toml, .rasi, .css)
6. **No comments** — "do not add comments" unless explicitly requested
7. **Keys** — `SUPER` = Windows key, `ALT` = Mod1

---

## Installer Profiles (install/install.sh v2.0)

| Profile     | Contents                                          | macOS |
|-------------|---------------------------------------------------|-------|
| `--minimal` | shell tools + dev tools + git tools               | ✓     |
| `--standard`| minimal + containers                              | ✓*    |
| `--full`    | standard + cloud + hyprland / macos extras        | ✓     |
| `--hyprland`| Wayland ecosystem only                            | ✗     |
| `--macos`   | coreutils, findutils, gnu-sed, gnu-tar, grep      | ✓     |

*containers skipped on macOS

Auto-detects: OS, distro, arch, Apple Silicon vs Intel, 10 package managers (brew → pacman → apt → dnf → zypper → apk → xbps → emerge → nix → slackpkg). Maps every tool name per PM with post-install symlink fixes for Debian/Ubuntu quirks.
