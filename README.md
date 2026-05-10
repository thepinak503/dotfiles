# Pinak's Dotfiles

The strongest public dotfiles distro. 2000+ hand-written aliases, 2000+ hand-written functions per shell — zero generated code, zero conflicts, maximum stability.

## Features

- **3 shells** — Bash, Zsh, Fish — fully synchronized aliases, functions, exports
- **2000+ aliases** per shell, hand-written, no scripts/codegen
- **2000+ functions** per shell, hand-written
- **Zero name conflicts** across all 4 cross-checks (bash-internal, fish-internal, cross-shell)
- **Distro-agnostic** — detects 15+ distros, 15+ package managers, adapts automatically
- **ble.sh** — syntax highlighting, auto-complete, vim mode, fzf integration
- **Starship prompt** — minimal, fast, informative
- **Fastfetch** — clean system info on startup
- **Auto-update** — background pull checks every 7 days
- **Modular** — core shared across shells, per-distro overrides

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

## Layout

```
~/.local/share/dotfiles/
├── core/              # Aliases, functions, OS detection, universal config
├── shells/
│   ├── bash/          # .bashrc, exports, detect_apps
│   ├── zsh/           # .zshrc, .zprofile, mode profiles
│   └── fish/          # config.fish, aliases, functions, exports
├── apps/              # App configs (git, tmux, starship, fastfetch, atuin, blesh, lazygit)
├── bin/               # Utilities: test_repo, dotupdate, setup_hooks
└── install/           # Installer, uninstaller, fonts installer
```

## Validate

```sh
bash bin/test_repo.sh
```

## Version

1.0.0
