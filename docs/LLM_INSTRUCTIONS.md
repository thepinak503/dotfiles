# LLM Instructions for Dotfiles Repository

## Repository Overview

This is **thepinak503/dotfiles** v3.0.0 - The Ultimate Universal Shell Configuration
- **280+ checklist items** - comprehensive dotfiles system
- **4 shells**: Bash, Zsh, Fish, Nushell
- **50+ modern CLI tools** configured
- **Hyprland Wayland desktop** environment
- **1000+ aliases** across all modes

## Repository Structure

```
~/.dotfiles/
├── .bashrc, .zshrc, .bash_profile          # Main shell configs
├── install.sh (v3.0.0 - strict mode)       # Main installer with double confirmation
├── install_dotfiles.sh                     # Package installer for all shells
├── uninstall.sh                            # Clean removal script
├── Makefile                               # Management commands
│
├── bash/                                  # Modular bash configs (16 files)
│   ├── 00-core.sh                        # Environment, PATH, XDG dirs
│   ├── 01-functions.sh                   # 50+ utility functions
│   ├── 02-aliases-core.sh               # Essential aliases (all modes)
│   ├── 03-aliases-extended.sh           # Advanced aliases
│   ├── 04-aliases-nerd.sh               # Ultra-nerd aliases
│   ├── 05-distro-detection.sh           # Universal distro support
│   ├── 06-package-managers.sh           # Package manager aliases
│   ├── 07-modern-tools.sh               # eza, bat, fzf, zoxide
│   ├── 08-development.sh                # Git, Docker, K8s, DevOps
│   ├── 09-shell-options.sh              # shopt, bind, history
│   ├── 10-prompt.sh                     # Starship & fallback prompts
│   ├── 20-docker.sh                     # Docker/K8s aliases
│   ├── 21-direnv.sh                     # Directory environments
│   ├── 22-lang-versions.sh              # nvm, pyenv, rbenv, rustup
│   ├── 23-cloud-cli.sh                  # AWS, Azure, GCP, Terraform
│   ├── 24-filemanagers.sh               # Ranger, nnn, lf
│   └── 25-monitoring.sh                 # Btop, htop, fastfetch
│
├── fish/                                 # Fish shell config
│   ├── config.fish
│   ├── conf.d/aliases.fish
│   ├── conf.d/development.fish
│   ├── conf.d/modern-tools.fish
│   └── functions/utilities.fish
│
├── nushell/                              # Nushell config
│   ├── config.nu
│   └── env.nu
│
├── config/                               # Application configs
│   ├── alacritty/alacritty.toml
│   ├── kitty/kitty.conf
│   ├── wezterm/wezterm.lua
│   ├── tmux/.tmux.conf
│   ├── zellij/config.kdl
│   ├── nvim/                            # Full Lua Neovim config
│   │   ├── init.lua
│   │   └── lua/{config,plugins}/
│   ├── micro/settings.json
│   ├── fastfetch/config.jsonc
│   ├── starship.toml
│   ├── hypr/hyprland.conf               # Wayland compositor
│   ├── waybar/{config,style.css}
│   ├── wofi/{config,style.css}
│   ├── swaylock/config
│   ├── swaync/{config.json,style.css}
│   ├── gtk-3.0/settings.ini
│   ├── qt5ct/qt5ct.conf
│   └── Code/{settings.json,keybindings.json}
│
├── git/                                  # Git configuration
│   ├── .gitconfig
│   └── .gitignore_global
│
├── ssh/                                  # SSH templates
│   ├── config
│   └── config.template
│
├── scripts/                              # Utility scripts
│   ├── backup.sh
│   ├── sysupdate.sh
│   ├── sysinfo.sh
│   ├── install-themes.sh
│   └── dynamic-modules.sh
│
├── docs/                                 # Documentation
│   ├── cheatsheet.md
│   ├── logo.md
│   └── OPTIMIZATION_ANALYSIS.md
│
└── .github/workflows/                    # CI/CD
    ├── ci.yml
    ├── test.yml
    └── release.yml
```

## Key Concepts

### Three Configuration Modes

1. **basic**: Essential only (~200 aliases) - minimal resource usage
2. **advanced**: Full features (~600 aliases) - **RECOMMENDED**
3. **ultra-nerd**: Everything (~1000+ aliases) - all features enabled

Set via: `export DOTFILES_MODE=advanced` in ~/.bashrc.local

### Universal Distro Support

Auto-detects and provides aliases for:
- **Arch**: pacman, yay, paru
- **Debian/Ubuntu**: apt
- **Fedora**: dnf
- **openSUSE**: zypper
- **Alpine**: apk
- **macOS**: brew

### Modern Tool Replacements

| Old Tool | Modern Replacement | Alias |
|----------|-------------------|-------|
| ls | eza/exa | ls |
| cat | bat | cat |
| find | fd | find |
| grep | ripgrep (rg) | grep |
| du | dust | du |
| ps | procs | ps |
| cd | zoxide (z) | cd |
| top | btop | top |

## Shell Loading Order

### Bash
1. .bash_profile (login shells)
2. .bashrc (interactive shells)
3. Loads modules 00-10, 20-25 sequentially
4. Sources ~/.bashrc.local last

### Zsh
1. .zshrc
2. Oh-My-Zsh initialization
3. Sources bash modules for compatibility
4. Sources ~/.zshrc.local

### Fish
1. config.fish
2. conf.d/*.fish (loaded automatically)
3. functions/*.fish
4. config.local.fish

## Critical Functions & Aliases

### Navigation
```bash
..        # cd ..
...       # cd ../..
....      # cd ../../..
-         # cd -
mkcd dir  # mkdir && cd
up 3      # cd ../../../
```

### Git
```bash
g         # git
ga        # git add
gaa       # git add --all
gcm       # git commit -m
gco       # git checkout
gd        # git diff
gl        # git log --oneline --graph
gp        # git push
gpl       # git pull
gs        # git status -sb
lazyg     # git add . && commit && push
```

### Docker
```bash
d         # docker
dc        # docker-compose
dps       # docker ps (formatted)
dpa       # docker ps -a
di        # docker images
dex       # docker exec -it
dr        # docker run -it --rm
dprune    # docker system prune -af
```

### System
```bash
myip      # Show internal/external IPs
serve     # HTTP server (python)
extract   # Universal archive extractor
bak       # Backup file with timestamp
passgen   # Generate password
weather   # Show weather
sysinfo   # System information
```

## Development Guidelines

### Adding New Aliases

**Location depends on category:**
- Essential (all modes): `bash/02-aliases-core.sh`
- Advanced: `bash/03-aliases-extended.sh`
- Nerd: `bash/04-aliases-nerd.sh`

**Format:**
```bash
# Category header
alias short='full-command'
```

### Adding New Functions

**Location:** `bash/01-functions.sh`

**Template:**
```bash
# Brief description
functionname() {
    [[ -z "$1" ]] && { echo "Usage: functionname <arg>"; return 1; }
    
    local var="$1"
    # Function body
}
```

### Adding Package Manager Support

**Location:** `bash/06-package-managers.sh`

Pattern:
```bash
if [[ "$DISTRO" == "newdistro" ]]; then
    alias pmi='sudo packagemanager install'
    alias pmr='sudo packagemanager remove'
    alias pmu='sudo packagemanager update'
fi
```

## Installation Commands

```bash
# Interactive (recommended) - double confirmation
./install.sh

# Fast mode with auto-install
./install.sh -m advanced -i -y

# Specific shells only
./install.sh -s bash,zsh

# Dry run (preview only)
./install.sh --dry-run

# Install packages first, then configure
./install_dotfiles.sh --all
./install.sh
```

## Makefile Commands

```bash
make install       # Install dotfiles (interactive)
make install-fast  # Fast install with MODE=advanced
make update        # Pull updates and reload
make backup        # Create backup
make clean         # Uninstall and restore
make test          # Test shell syntax
make lint          # Run shellcheck
make docker        # Test in Docker
make stats         # Show statistics
```

## Testing & Validation

### Syntax Checking
```bash
# Test bash syntax
bash -n bash/*.sh

# Test fish syntax
fish -n fish/config.fish

# Run all tests
make test
```

### Shellcheck
```bash
# Install: pacman -S shellcheck
shellcheck install.sh uninstall.sh bash/*.sh
```

### Docker Testing
```bash
# Build test container
docker build -t dotfiles-test .

# Run interactive test
docker run --rm -it dotfiles-test

# Run installer test
docker run --rm dotfiles-test ./install.sh --dry-run
```

## Common Issues & Solutions

### Slow Shell Startup
```bash
# Profile startup time
DOTFILES_PROFILE=1 bash -i -c exit
cat /tmp/dotfiles-profile.log

# Solution: Use basic mode or lazy loading
export DOTFILES_MODE=basic
```

### Missing Tools
```bash
# Check what's missing
dotfiles-doctor

# Install all packages
./install_dotfiles.sh --all
```

### Broken Symlinks
```bash
# Check for broken links
find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print

# Fix by reinstalling
./install.sh -f
```

### Mode Not Working
```bash
# Ensure mode is set
export DOTFILES_MODE=advanced
echo "export DOTFILES_MODE=advanced" > ~/.bashrc.local
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DOTFILES_MODE` | Configuration mode | advanced |
| `DOTFILES_DIR` | Dotfiles location | ~/.dotfiles |
| `DOTFILES_VERSION` | Version string | 2.0.0 |
| `EDITOR` | Default editor | nvim/vim/nano |
| `VISUAL` | Visual editor | nvim/vim/nano |
| `FZF_DEFAULT_OPTS` | FZF options | (extensive) |

## Version Managers Integration

### NVM (Node)
```bash
nvm install 20
nvm use 20
nvm alias default 20
```

### Pyenv (Python)
```bash
pyenv install 3.12
pyenv global 3.12
```

### Rust
```bash
rustup default stable
rustup component add rust-analyzer
```

## Hyprland Desktop

### Key Bindings
- `Super + Enter`: Terminal (kitty)
- `Super + R`: Application launcher (wofi)
- `Super + Q`: Close window
- `Super + M`: Exit Hyprland
- `Super + [1-0]`: Switch workspace
- `Super + Shift + [1-0]`: Move to workspace
- `Super + Shift + S`: Screenshot area
- `Super + L`: Lock screen

### Start Hyprland
```bash
# From TTY
exec Hyprland
```

## Maintenance Tasks

### Update Dotfiles
```bash
cd ~/.dotfiles
git pull
make update
```

### Backup Current Config
```bash
./scripts/backup.sh
# Creates: ~/.dotfiles-backup-YYYYMMDD_HHMMSS/
```

### Clean Old Backups
```bash
./scripts/backup.sh cleanup 10  # Keep last 10
```

### System Update
```bash
./scripts/sysupdate.sh  # Universal updater
```

## Security Considerations

- ✅ Double confirmation in installer
- ✅ Automatic backups before changes
- ✅ Restore script included
- ✅ No secrets in repository
- ✅ Safe file operations (-i flags)

## Contributing

1. Fork repository
2. Create feature branch: `git checkout -b feature/name`
3. Test changes: `make test`
4. Lint: `make lint`
5. Commit: `git commit -m "Add: description"`
6. Push: `git push origin feature/name`
7. Open Pull Request

## Resources

- **Main Repo**: https://github.com/thepinak503/dotfiles
- **Windows Version**: https://github.com/thepinak503/powerconfig
- **Documentation**: See docs/ directory
- **Issues**: GitHub Issues tab

## Changelog

See `CHANGELOG.md` for version history

## License

MIT License - See LICENSE file

---

*This file serves as the primary reference for LLMs working on this codebase*
*Last Updated: 2026-02-10*
*Version: 3.0.0*
