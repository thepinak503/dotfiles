# Pinak's Dotfiles

Cross-distro dotfiles for **Linux + macOS**. 2000+ hand-written aliases, 2000+ hand-written functions per shell — zero generated code, zero conflicts, maximum stability.

> **Hyprland desktop on Linux** · **Shell-only anywhere** (macOS, servers, containers, WSL)

## Distro Compatibility

| OS / Distro | Shell Config | Desktop (Hyprland) | Package Manager |
|------------|-------------|-------------------|----------------|
| **Arch Linux** / EndeavourOS / Manjaro / Garuda | ✅ | ✅ | pacman / yay / paru |
| **Debian** / Ubuntu / Pop!_OS / Mint / Zorin | ✅ | ✅ (manual build) | apt |
| **Fedora** / RHEL / Rocky / Alma | ✅ | ✅ | dnf |
| **openSUSE** (Leap/Tumbleweed) | ✅ | ✅ | zypper |
| **Void Linux** | ✅ | ✅ | xbps |
| **Gentoo** / Funtoo | ✅ | ✅ | emerge |
| **Alpine Linux** | ✅ | ✅ | apk |
| **NixOS** | ✅ | ✅ | nix |
| **Slackware** | ✅ | ✅ | slackpkg |
| **Solus** | ✅ | ✅ | eopkg |
| **macOS** (Intel + Apple Silicon) | ✅ | ❌ (N/A) | brew |
| **Any Linux** (server/container/WSL) | ✅ (shell-only) | ❌ | auto-detect |

## Features

- **3 shells** — Bash, Zsh, Fish — fully synchronized aliases, functions, exports
- **2000+ aliases** per shell, hand-written, no scripts/codegen
- **2000+ functions** per shell, hand-written
- **Zero name conflicts** across all 4 cross-checks (bash-internal, fish-internal, cross-shell)
- **Distro-agnostic** — detects 15+ distros, 15+ package managers, adapts automatically
- **Hyprland desktop** (Linux only) — waybar, wlogout, swaync, rofi, kitty, hyprlock
- **Starship prompt** — minimal, fast, informative
- **Fastfetch** — clean system info on startup
- **Auto-update** — background pull checks every 7 days
- **Modular** — core shared across shells, per-distro overrides
- **Graceful degradation** — all desktop features auto-skip when Hyprland is absent

## Quick Install

```sh
curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | sh
```

Manual:

```sh
git clone https://github.com/thepinak503/dotfiles.git ~/.local/share/dotfiles
cd ~/.local/share/dotfiles
sh install.sh
```

### Install Profiles

| Profile | What's installed |
|---------|-----------------|
| `sh install.sh --shell-only` | Shell config + core CLI tools (git, fzf, ripgrep, bat, eza, starship, etc.) |
| `sh install.sh --minimal` | Shell + dev tools + git tools |
| `sh install.sh --standard` (default) | Shell + dev + git + containers |
| `sh install.sh --full` | Everything (auto-detects Hyprland on Linux) |
| `sh install.sh --hyprland` | Only Hyprland/Wayland desktop packages |
| `sh install.sh --macos` | Only macOS extras (coreutils, findutils, gnu-sed…) |

> On **macOS**, the installer never installs Hyprland packages.
> On **Linux without Hyprland**, the installer skips desktop components.

## Layout

```
~/.local/share/dotfiles/
├── core/              # Aliases, functions, OS detection, universal config
├── shells/
│   ├── bash/          # .bashrc, exports, detect_apps
│   ├── zsh/           # .zshrc, .zprofile, mode profiles
│   └── fish/          # config.fish, aliases, functions, exports
├── apps/              # App configs (git, tmux, starship, fastfetch, atuin, lazygit)
├── hypr/              # Hyprland desktop config (keybinds, monitors, autostart, scripts)
├── waybar/            # Top & bottom bars (Linux only)
├── wlogout/           # Logout menu (Linux only)
├── swaync/            # Notification center (Linux only)
├── rofi/              # App launcher (Linux only)
├── themes/            # Dark/light theme sources for all components
├── bin/               # Utilities: test_repo, dots CLI, dotlogcat, dots-doctor
└── install/           # Cross-distro installer, uninstaller, fonts installer
```

## Validate

```sh
bash bin/test_repo.sh
bash tests/run_tests.sh
dots doctor
```

## Version

2.0.0
