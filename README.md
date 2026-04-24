# Pinak's Dotfiles

Advanced modular dotfiles for Arch Linux, Arch-based distributions, other Linux distros, and macOS.

## Design

Pinak's Dotfiles are intended to live at `~/.dotfiles`. The bootstrap script clones or updates that directory, then `install/install.sh` symlinks shell and app configs into the expected locations under `$HOME`.

The layout keeps shell logic, app configs, installer code, and maintenance scripts separate:

- `shells/bash`, `shells/zsh`, `shells/fish`: shell entry points plus synchronized aliases, functions, exports, and modes.
- `core`: shared detection, logging, battery, SSH agent, and tool helpers.
- `apps`: Starship, Fastfetch, Git, Tmux, Lazygit, Atuin, and Homebrew configs.
- `bin`: diagnostics, benchmark, docs indexing, update, and generation utilities.
- `install`: symlink installer and uninstaller.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | sh
```

Manual install:

```sh
git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh install.sh
```

## Features

- Bash, Zsh, and Fish support with aligned aliases, functions, exports, and Starship integration.
- Nord-themed Starship prompt with date, time including seconds, Git state, runtime modules, system context, and compact multi-line layout.
- 2000+ aliases and 2000+ functions generated consistently across Bash, Zsh, and Fish.
- Opt-in export catalog with commented defaults for local customization.
- Tiered modes: `minimal`, `standard`, `supreme`, and `ultra-nerd`.
- Fastfetch profile with clean Nord-compatible colors and battery health through a linked helper script.
- Installer environment detection for Arch-family systems, Linux package managers, and macOS/Homebrew.
- Installer validation using shell execution paths such as `bash -c`, `zsh -c`, and `fish -c`.

## Regenerate Large Assets

```sh
node bin/generate_assets.js
```

This refreshes the synchronized alias/function/export payloads, the Nord Starship configs, and the Fastfetch config.

## Validation

```sh
bash bin/test_repo.sh
bash bin/test_all.sh --fast
```

The installer also runs lightweight behavior checks after linking configs.

## Notes

This setup can reasonably be called best-in-class for a personal dotfiles repo because it is modular, generated where volume would otherwise cause drift, portable across three shells, fast to load, and explicit about setup and validation. It is not universally best for every user because shell preferences, company policy, terminal fonts, package managers, and security posture vary.

Bash may fail to load Starship by default when `.bashrc` is not sourced. Login shells often read `~/.bash_profile`, `~/.bash_login`, or `~/.profile` instead. Fix it by ensuring your login startup file sources `~/.bashrc`, or by launching an interactive Bash shell that reads `~/.bashrc`. Starship must also be installed and available on `PATH`.

The aliases, functions, and exports are designed to be distro-aware and macOS-tolerant, but no 2000+ item shell catalog can be truly distro-agnostic. Many commands are guarded, harmless when missing, or useful only when the matching tool is installed. Package-manager aliases, Linux-only system paths, Docker/Kubernetes helpers, and GNU/BSD command differences can still require local adjustment.

## License

MIT
