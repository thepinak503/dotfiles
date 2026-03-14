# Dotfiles v4.0.0 - The Ultimate Universal Shell Configuration

<p align="center">
  <img src="docs/logo.png" alt="Dotfiles Logo" width="200">
</p>

<p align="center">
  <strong>Complete development environment with one command</strong><br>
  <strong>Now with unified shell configs + auto-update!</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#shells">Shells</a> •
  <a href="#hyprland">Hyprland</a> •
  <a href="#documentation">Docs</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Version-4.0.0-blue.svg" alt="Version">
  <img src="https://img.shields.io/badge/Shells-4-green.svg" alt="Shells">
  <img src="https://img.shields.io/badge/Tools-50+-orange.svg" alt="Tools">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>

---

## 🎉 What's New in v3.0.0

- **🎨 Complete Hyprland Setup** - Full Wayland desktop environment
- **🎨 Catppuccin Mocha Theme** - Applied across all tools
- **🛡️ Strict Installer** - Double confirmation for safety
- **☁️ Cloud CLI Tools** - AWS, Azure, GCP, Terraform
- **🔧 Language Managers** - nvm, pyenv, rbenv, rustup
- **📦 Backup System** - Automated backup & restore
- **🔄 CI/CD Pipeline** - GitHub Actions testing
- **📊 280+ Checklist Items** - 100% Complete!

---

## 🚀 Quick Start

```bash
# One-line installer (recommended)
curl -fsSL https://is.gd/install_dotfiles | sh

# With dependencies (modern tools)
curl -fsSL https://is.gd/install_dotfiles | sh -s -- --install-deps

# Or clone and install
git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## ✨ Features

### 🐚 **4 Shells Supported**
- **Bash** - Modular loading with 11 config files
- **Zsh** - Oh-My-Zsh + Powerlevel10k support
- **Fish** - User-friendly with completions
- **Nushell** - Structured data processing
- **Cross-compatibility** - Same aliases/functions everywhere

### 🎨 **Hyprland Wayland Desktop**
Complete desktop environment including:
- ✅ Hyprland config with animations & blur
- ✅ Waybar status bar (CPU, RAM, network, battery)
- ✅ Wofi application launcher
- ✅ Swaync notification center
- ✅ Swaylock screen lock
- ✅ Swidle idle management
- ✅ Grimblast screenshot tool
- ✅ Catppuccin Mocha theme throughout

### 🎯 **1000+ Aliases & 50+ Functions**
- **System**: Navigation, files, processes, system info
- **Development**: Git, Docker, K8s, cloud, databases
- **Package Managers**: Universal aliases for all distros
- **Media**: Audio/video, images, documents
- **Network**: SSH, ping, speedtest, security

### 🛠️ **50+ Modern Tools**
- **Eza** - Modern ls with icons
- **Bat** - Syntax-highlighting cat
- **Ripgrep** - Fast grep
- **FD** - User-friendly find
- **FZF** - Fuzzy finder
- **Zoxide** - Smart cd with learning
- **Delta** - Beautiful git diffs
- **Dust** - Disk usage analyzer
- **Btop** - System resource monitor
- **Starship** - Cross-shell prompt

### 💻 **Development Stack**
- **Editors**: Neovim (Lua), VS Code:, Micro, Nano, Vim
- **Terminals**: Alacritty, WezTerm, Kitty
- **Multiplexers**: Tmux, Zellij, Screen
- **Languages**: nvm, pyenv, rbenv, rustup, jenv
- **Cloud**: AWS CLI, Azure CLI, GCloud, Terraform
- **Containers**: Docker, Kubernetes, Helm

### 📦 **Universal Package Support**
- Arch (pacman/yay)
- Debian/Ubuntu (apt)
- Fedora (dnf)
- openSUSE (zypper)
- Alpine (apk)
- macOS (brew)

### 🔄 **Auto-Update**
- Automatic update check on shell startup
- Configurable update interval (default: 1 day)
- Manual update with `dotfiles-update`
- Non-blocking background updates

### 🔒 **Safety First**
- ✅ Double confirmation (type 'yes' then 'INSTALL')
- ✅ Automatic backup before changes
- ✅ Dry-run mode for testing
- ✅ Restore script included
- ✅ Comprehensive logging

## 📋 Installation

### Prerequisites
- Git
- curl or wget
- bash

### Options

```bash
# Quick install (POSIX compatible - recommended!)
curl -fsSL https://is.gd/install_dotfiles | sh

# Quick install with dependencies
curl -fsSL https://is.gd/install_dotfiles | sh -s -- --install-deps

# Interactive mode (recommended) - requires double confirmation
./install.sh

# Advanced mode with auto-install
./install.sh -m advanced -i -y

# Select specific shells only
./install.sh -s bash,zsh

# Dry run (preview changes without applying)
./install.sh --dry-run

# Show help
./install.sh --help
```

## 🐚 Shells

### Bash
```bash
source ~/.bashrc
```
- Modular loading (11 separate files)
- Cross-shell compatibility
- Universal functions

### Zsh
```zsh
source ~/.zshrc
```
- Oh-My-Zsh integration
- Powerlevel10k prompt (optional)
- Syntax highlighting
- Auto-suggestions

### Fish
```fish
source ~/.config/fish/config.fish
```
- Friendly syntax
- Web config
- Auto-completions

### Nushell
```nu
source ~/.config/nushell/config.nu
```
- Structured data
- Pipeline operations
- Cross-platform

## 🎨 Hyprland

### Installation
```bash
# Install themes first
./scripts/install-themes.sh

# Start Hyprland
exec Hyprland
```

### Keybindings
| Key | Action |
|-----|--------|
| `SUPER + Enter` | Open terminal |
| `SUPER + R` | Application launcher (Wofi) |
| `SUPER + Q` | Close window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + [1-0]` | Switch workspace |
| `SUPER + SHIFT + [1-0]` | Move to workspace |
| `SUPER + Arrow Keys` | Change focus |
| `SUPER + SHIFT + Arrow` | Move window |
| `SUPER + SHIFT + S` | Screenshot area |
| `SUPER + L` | Lock screen |
| `SUPER + F` | Toggle floating |
| `SUPER + T` | Toggle split |
| `SUPER + Mouse Left` | Move window |
| `SUPER + Mouse Right` | Resize window |

## 📁 Directory Structure

```
~/.dotfiles/
├── .bashrc, .zshrc, .bash_profile
├── .tmux.conf, .vimrc, .nanorc
├── install.sh (v4.0.0 - unified)
├── install-quick.sh (POSIX compatible)
├── uninstall.sh
├── TODO.md, PROGRESS_SUMMARY.md
│
├── bash/                   # Modular bash configs
│   ├── 00-core.sh         # Environment
│   ├── 01-functions.sh    # 50+ functions
│   ├── 02-aliases-core.sh
│   ├── 03-aliases-extended.sh
│   ├── 04-aliases-nerd.sh
│   ├── 05-distro-detection.sh
│   ├── 06-package-managers.sh
│   ├── 07-modern-tools.sh
│   ├── 08-development.sh
│   ├── 09-shell-options.sh
│   ├── 10-prompt.sh
│   ├── 20-docker.sh       # Docker/K8s
│   ├── 21-direnv.sh       # Directory envs
│   ├── 22-lang-versions.sh # nvm, pyenv, etc.
│   ├── 23-cloud-cli.sh    # AWS, Azure, GCP
│   ├── 24-filemanagers.sh # Ranger, nnn, lf
│   └── 25-monitoring.sh   # Btop, htop
│
├── fish/                   # Fish shell config
├── nushell/               # Nushell config
│
├── config/
│   ├── alacritty/
│   ├── kitty/
│   ├── wezterm/
│   ├── tmux/
│   ├── zellij/
│   ├── nvim/              # Full Lua Neovim
│   ├── micro/
│   ├── fastfetch/
│   ├── starship.toml
│   │
│   ├── hypr/              # Hyprland config
│   ├── waybar/            # Status bar
│   ├── wofi/              # App launcher
│   ├── swaylock/          # Screen lock
│   ├── swaync/            # Notifications
│   │
│   ├── gtk-3.0/           # GTK theme
│   ├── qt5ct/             # Qt theme
│   └── Code/              # VS Code: settings
│
├── git/
│   ├── .gitconfig         # Enhanced git config
│   └── .gitignore_global
│
├── ssh/
│   └── config             # SSH config with examples
│
├── scripts/
│   ├── backup.sh          # Backup system
│   ├── sysupdate.sh       # Universal updater
│   ├── sysinfo.sh         # System info
│   └── install-themes.sh  # Theme installer
│
├── docs/
│   ├── cheatsheet.md
│   └── logo.md
│
└── .github/workflows/
    ├── ci.yml             # CI pipeline
    └── release.yml        # Release automation
```

## 🔄 Backup & Restore

```bash
# Backup everything
./scripts/backup.sh

# Backup specific items
./scripts/backup.sh dotfiles
./scripts/backup.sh configs
./scripts/backup.sh home

# List backups
./scripts/backup.sh list

# Restore
./scripts/backup.sh restore-dotfiles backup_file.tar.gz
./scripts/backup.sh restore-configs backup_file.tar.gz

# Cleanup old backups
./scripts/backup.sh cleanup 10
```

## 🆕 Updates

```bash
# Update dotfiles
cd ~/.dotfiles && git pull

# Update system (universal)
./scripts/sysupdate.sh

# Install all version managers
source ~/.bashrc && install-version-managers
```

## 🧪 Testing

```bash
# Run all tests
make test

# Syntax check
make test-syntax

# Shellcheck
make test-shellcheck

# Docker test
make test-docker
```

## 🎨 Theming

### Catppuccin Mocha
Applied consistently across:
- Terminal emulators
- Editors (Neovim, VS Code:, Micro)
- GTK/Qt applications
- Hyprland ecosystem

### Fonts
- **Primary**: JetBrainsMono Nerd Font Mono
- **Terminal**: Caskaydiacove Nerd Font Mono

## 📊 Statistics

- **280 checklist items** - 100% Complete!
- **4 shells** fully supported
- **50+ tools** configured
- **1000+ aliases**
- **50+ functions**
- **20+ Hyprland components**
- **3 configuration modes**

## 📖 Documentation

- [Installation Guide](docs/installation.md)
- [Cheatsheet](docs/cheatsheet.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Customization](docs/customization.md)
- [TODO](TODO.md)
- [Progress](PROGRESS_SUMMARY.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open Pull Request

## 📜 License

MIT License - see [LICENSE](LICENSE)

---

## 📖 Shell Configuration Guide (v4.0.0)

### Directory Structure

```
.dotfiles/
├── .bash/              # Bash configurations
│   ├── 00-aliases-unified.sh   # Modern CLI aliases with fallbacks
│   ├── 00-core.sh              # Core environment
│   ├── 01-functions.sh         # Shell functions
│   ├── 02-aliases-core.sh      # Essential aliases
│   └── ...
├── .zsh/               # Zsh configurations
│   ├── 00-core.zsh             # Zsh environment
│   ├── 01-keybindings.zsh      # Key bindings
│   ├── 02-plugins.zsh          # Oh-My-Zsh plugins
│   └── 03-prompt.zsh           # Starship/Zoxide init
├── .fish/              # Fish configurations
│   └── config.fish     # Main Fish config
├── nushell/           # Nushell configs
├── scripts/           # Helper scripts
│   └── install_shell_support.sh  # Install modern tools
└── install.sh         # Main installer
```

### Unified Aliases

The `00-aliases-unified.sh` provides modern CLI tool aliases with automatic fallbacks:

| Command | Modern Tool | Fallback |
|---------|-------------|----------|
| `ls`, `ll`, `la` | eza | ls |
| `cat` | bat | cat |
| `find` | fd | find |
| `grep` | ripgrep | grep |
| `diff` | delta | diff |
| `ps` | procs | ps |
| `top` | btm | htop |
| `du` | dust | du |
| `df` | duf | df |

### Installation

```bash
# Full installation with dependencies
./install.sh --install-deps -s bash,zsh,fish

# Shell-specific
./install.sh -s bash    # Bash only
./install.sh -s zsh     # Zsh only
./install.sh -s fish    # Fish only

# Options
# -s, --shells    : Comma-separated shells
# -d, --default   : Set default shell
# --install-deps  : Install modern tools
# -y, --yes      : Skip confirmation
```

### Install Shell Support

Install all modern CLI tools with a single command:

```bash
# Bash/Zsh
install-shells
# or
source install_shell_support.sh && install_shell_support

# Fish
install-shells
```

**Tools installed:**
- eza (ls replacement)
- bat (cat replacement)
- starship (prompt)
- zoxide (cd replacement)
- fzf (fuzzy finder)
- delta (git diff)
- fd (find replacement)
- procs (ps replacement)
- tldr (man pages)
- yazi (file manager)

### Shell Modes

```bash
export DOTFILES_MODE=basic       # Minimal config
export DOTFILES_MODE=advanced    # Full features (default)
export DOTFILES_MODE=ultra-nerd  # Maximum productivity
```

### Auto-Update Configuration

```bash
# Update interval (default: 86400 seconds = 1 day)
export DOTFILES_UPDATE_INTERVAL=86400    # Check every day
export DOTFILES_UPDATE_INTERVAL=604800   # Check every week

# Disable auto-update
export DOTFILES_AUTO_UPDATE=false

# Manual update commands
dotfiles-update       # Check and update now
dotfiles-status       # Show git status
```

### Dynamic Loading

All shell configurations auto-detect installed tools and only initialize what's available:

**Bash/Zsh:**
```bash
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
```

**Fish:**
```bash
if type -q starship
    starship init fish | source
end
```

### Distro Support

| Distro | Package Manager |
|--------|---------------|
| Arch/Manjaro/EndeavourOS | pacman |
| Debian/Ubuntu/Pop!_OS | apt |
| Fedora/RHEL/CentOS | dnf |
| openSUSE | zypper |
| Alpine | apk |
| macOS | Homebrew |

The `update`, `upgrade`, and `cleanup` aliases auto-detect your package manager.

### Local Customizations

Create shell-specific local files:
- `~/.bashrc.local`
- `~/.zshrc.local`  
- `~/.config/fish/config.local.fish`

---

MIT License - see [LICENSE](LICENSE)

## 🙏 Credits

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Starship](https://starship.rs/)
- [Catppuccin](https://catppuccin.com/)
- [Hyprland](https://hyprland.org/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [All contributors](https://github.com/thepinak503/dotfiles/graphs/contributors)

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/thepinak503">@thepinak503</a>
</p>

<p align="center">
  <a href="https://github.com/thepinak503/dotfiles">⭐ Star on GitHub</a> •
  <a href="https://github.com/thepinak503/powerconfig">🪟 Windows Version</a>
</p>