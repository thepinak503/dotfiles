# =============================================================================
# DOTFILES README
# The Ultimate Universal Shell Configuration
# =============================================================================

<div align="center">

# 🔧 DOTFILES v2.0.0

**The world's most advanced dotfiles configuration**  
Universal support for all Linux distributions + macOS  
Three modes: Basic | Advanced | Ultra-Nerd

[![GitHub stars](https://img.shields.io/github/stars/thepinak503/dotfiles?style=flat-square)](https://github.com/thepinak503/dotfiles/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/thepinak503/dotfiles?style=flat-square)](https://github.com/thepinak503/dotfiles/network)
[![License](https://img.shields.io/github/license/thepinak503/dotfiles?style=flat-square)](LICENSE)

[Features](#features) • [Installation](#installation) • [Documentation](#documentation) • [Customization](#customization)

</div>

---

## ✨ Features

### 🎯 Three Configuration Modes

- **Basic** - Essential aliases, minimal setup (perfect for servers)
- **Advanced** - Full aliases, modern tools, optimized workflow (recommended)
- **Ultra-Nerd** - Everything + 1000+ aliases, all integrations (power users)

### 🐧 Universal Distro Support

Works seamlessly with:
- **Arch** (Arch Linux, Manjaro, EndeavourOS, Garuda, CachyOS)
- **Debian** (Ubuntu, Debian, Linux Mint, Pop!_OS, elementaryOS)
- **RHEL** (Fedora, CentOS, RHEL, AlmaLinux, Rocky Linux)
- **openSUSE** (Leap, Tumbleweed)
- **Alpine** (Docker containers)
- **Gentoo**, **Void**, **NixOS**
- **macOS** (with Homebrew)

### 🔧 What's Included

#### 1000+ Aliases
- **Navigation** - Smart directory jumping
- **Git** - 100+ git shortcuts (from `ga` to `gwip`)
- **Docker** - Full container management
- **Kubernetes** - Complete K8s workflow
- **Development** - Python, Node.js, Rust, Go, Java
- **Package Managers** - Universal aliases for all distros

#### 50+ Utility Functions
- `extract` - Universal archive extraction (20+ formats)
- `mkcd` - Create directory and enter it
- `myip` - Show internal/external IP addresses
- `serve` - Quick HTTP server
- `fkill` - Interactive process killer (with fzf)
- `bak` - Backup files with timestamps
- `passgen` - Generate secure passwords
- `docker_clean` - Clean up Docker resources
- And many more!

#### Modern CLI Tools
- **[Starship](https://starship.rs/)** - Cross-shell prompt
- **[eza](https://github.com/eza-community/eza)** - Modern `ls` replacement
- **[bat](https://github.com/sharkdp/bat)** - Syntax-highlighting cat
- **[fzf](https://github.com/junegunn/fzf)** - Fuzzy finder
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smarter `cd`
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - Fast grep replacement
- **[fd](https://github.com/sharkdp/fd)** - User-friendly find
- **[delta](https://github.com/dandavison/delta)** - Git diff viewer

---

## 🚀 Installation

### Quick Install (One Command)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh)
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles

# Run the installer
cd ~/.dotfiles
./install.sh
```

### Requirements

- Git
- Bash 4.0+ or Zsh 5.0+
- curl or wget

---

## 📁 Structure

```
~/.dotfiles/
├── .bashrc                    # Main Bash entry point
├── .zshrc                     # Zsh configuration
├── .bash_profile              # Login shell config
├── .profile                   # Universal profile
├── install.sh                 # One-command installer
│
├── bash/                      # Modular Bash components
│   ├── 00-core.sh            # Environment & exports
│   ├── 01-functions.sh       # 50+ utility functions
│   ├── 02-aliases-core.sh    # Essential aliases
│   ├── 03-aliases-extended.sh # Advanced aliases
│   ├── 04-aliases-nerd.sh    # Ultra-nerd aliases
│   ├── 05-distro-detection.sh # Universal distro support
│   ├── 06-package-managers.sh # Package manager aliases
│   ├── 07-modern-tools.sh    # Tool integrations
│   ├── 08-development.sh     # Dev environment
│   ├── 09-shell-options.sh   # Bash configuration
│   └── 10-prompt.sh          # Prompt setup
│
├── config/                    # Config files
│   └── starship.toml         # Starship prompt config
│
├── git/                       # Git configuration
│   ├── .gitconfig            # Git settings
│   └── .gitignore_global     # Global gitignore
│
└── ssh/                       # SSH templates
    └── config.template       # SSH config template
```

---

## 🎨 Customization

### Select Your Mode

After installation, set your preferred mode:

```bash
# Basic mode (servers, minimal setup)
echo 'export DOTFILES_MODE="basic"' >> ~/.bashrc.local

# Advanced mode (default, recommended)
echo 'export DOTFILES_MODE="advanced"' >> ~/.bashrc.local

# Ultra-nerd mode (maximum features)
echo 'export DOTFILES_MODE="ultra-nerd"' >> ~/.bashrc.local
```

### Local Customizations

Create `~/.bashrc.local` or `~/.zshrc.local` for machine-specific settings:

```bash
# ~/.bashrc.local
export DOTFILES_MODE="advanced"
export EDITOR="vim"
alias myproject='cd ~/projects/myproject'
```

### Switching Shells

Both Bash and Zsh configurations share the same aliases and functions:

```bash
# Switch to Zsh
chsh -s $(which zsh)

# Switch back to Bash
chsh -s $(which bash)
```

---

## 📚 Documentation

### Alias Categories

#### Git Aliases
- `ga` → `git add`
- `gc` → `git commit`
- `gp` → `git push`
- `gl` → `git log --oneline --graph --decorate`
- `gs` → `git status -sb`
- `gco` → `git checkout`
- `gcb` → `git checkout -b`
- `lazyg` → `git add . && git commit -m && git push`

#### Docker Aliases
- `d` → `docker`
- `dc` → `docker-compose`
- `dps` → `docker ps` (formatted)
- `dex` → `docker exec -it`
- `dl` → `docker logs -f`
- `dprune` → `docker system prune -af`

#### Kubernetes Aliases
- `k` → `kubectl`
- `kg` → `kubectl get`
- `kgp` → `kubectl get pods`
- `kgd` → `kubectl get deployment`
- `kl` → `kubectl logs -f`
- `h` → `helm`

#### Package Manager Aliases (Auto-detected)

**Arch Linux:**
- `pacs` → `sudo pacman -S`
- `pacr` → `sudo pacman -Rs`
- `pacu` → `sudo pacman -Syu`

**Debian/Ubuntu:**
- `apti` → `sudo apt install`
- `aptr` → `sudo apt remove`
- `aptu` → `sudo apt update && sudo apt upgrade`

**Fedora:**
- `dnfi` → `sudo dnf install`
- `dnfr` → `sudo dnf remove`
- `dnfu` → `sudo dnf upgrade`

### Functions Reference

#### File Operations
- `mkcd <dir>` - Create directory and cd into it
- `extract <archive>` - Extract any archive format
- `bak <file>` - Backup file with timestamp
- `swap <file1> <file2>` - Swap two files

#### Search & Find
- `ftext <pattern>` - Fuzzy text search in files
- `ff <name>` - Find files by name
- `fd <name>` - Find directories by name

#### Network
- `myip` - Display internal and external IP
- `serve [port]` - Start HTTP server
- `sslcheck <host>` - Check SSL certificate

#### Development
- `lazyg <message>` - Git add, commit, push in one command
- `docker_clean` - Clean up Docker resources
- `mkvenv` - Create Python virtual environment
- `passgen [length]` - Generate secure password

---

## 🔧 Troubleshooting

### Bash: command not found

```bash
# Reload your shell configuration
source ~/.bashrc
```

### Starship not showing

```bash
# Install Starship
curl -sS https://starship.rs/install.sh | sh
```

### Some aliases don't work

Check that the underlying tool is installed:

```bash
# Check if eza is installed
command -v eza

# If not, install it
# Arch: sudo pacman -S eza
# Ubuntu: manual install from GitHub releases
```

### Mode not changing

```bash
# Edit your local configuration
$EDITOR ~/.bashrc.local

# Add or modify:
export DOTFILES_MODE="advanced"

# Reload
source ~/.bashrc
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) - Amazing Zsh framework
- [Starship](https://starship.rs/) - Cross-shell prompt
- [eza](https://github.com/eza-community/eza) - Modern ls replacement
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- All the amazing open-source projects that make this possible

---

<div align="center">

**Made with ❤️ by [thepinak503](https://github.com/thepinak503)**

⭐ Star this repo if it helps you!

</div>
