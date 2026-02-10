# Dotfiles Quick Reference

## Installation (One-Time Setup)

```bash
# Method 1: One-liner (with confirmation)
curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | bash

# Method 2: Clone and install
git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh

# Method 3: Install packages + configure
./install_dotfiles.sh --all  # Install all packages
./install.sh                 # Configure dotfiles
```

## Daily Commands

### Navigation
| Alias | Command | Description |
|-------|---------|-------------|
| `..` | `cd ..` | Go up one level |
| `...` | `cd ../..` | Go up two levels |
| `-` | `cd -` | Previous directory |
| `mkcd dir` | `mkdir && cd` | Make and enter directory |
| `up 3` | `cd ../../../` | Go up N levels |
| `z dir` | `zoxide jump` | Smart directory jumping |

### File Operations
| Alias | Command | Description |
|-------|---------|-------------|
| `l` | `ls -la` | List all files |
| `ll` | `ls -l` | List long format |
| `lt` | `tree view` | Tree listing |
| `lsize` | `sort by size` | List by size |
| `ltime` | `sort by time` | List by time |
| `extract file` | `auto-detect` | Extract any archive |
| `bak file` | `cp file.bak.1234` | Backup with timestamp |

### Git (Most Used)
| Alias | Full Command | Description |
|-------|--------------|-------------|
| `g` | `git` | Git shortcut |
| `ga` | `git add` | Stage files |
| `gaa` | `git add --all` | Stage all |
| `gc` | `git commit` | Commit |
| `gcm "msg"` | `git commit -m "msg"` | Commit with message |
| `gco` | `git checkout` | Switch branch |
| `gd` | `git diff` | Show changes |
| `gl` | `git log --oneline --graph` | Pretty log |
| `gp` | `git push` | Push commits |
| `gpl` | `git pull` | Pull changes |
| `gs` | `git status -sb` | Short status |
| `lazyg "msg"` | `add && commit && push` | Quick commit |

### Docker
| Alias | Description |
|-------|-------------|
| `d` | docker |
| `dc` | docker-compose |
| `dps` | docker ps (formatted) |
| `dpa` | docker ps -a |
| `di` | docker images |
| `dex` | docker exec -it |
| `dr` | docker run -it --rm |
| `dprune` | Clean up Docker |

### Kubernetes
| Alias | Description |
|-------|-------------|
| `k` | kubectl |
| `kg` | kubectl get |
| `kd` | kubectl describe |
| `kl` | kubectl logs |
| `kgp` | kubectl get pods |
| `kgd` | kubectl get deployment |

### System
| Alias | Description |
|-------|-------------|
| `myip` | Show internal/external IPs |
| `serve` | Start HTTP server |
| `passgen` | Generate password |
| `weather` | Show weather |
| `sysinfo` | System information |
| `c` | Clear screen |
| `reload` | Reload .bashrc |

### Package Managers (Auto-Detected)
| Task | Arch | Debian | Fedora |
|------|------|--------|--------|
| Install | `pacs pkg` | `apti pkg` | `dnfi pkg` |
| Remove | `pacr pkg` | `aptr pkg` | `dnfr pkg` |
| Update | `pacu` | `aptu` | `dnfu` |
| Search | `pacss pkg` | `apts pkg` | `dnfs pkg` |

## Configuration Modes

```bash
# Set mode in ~/.bashrc.local
export DOTFILES_MODE=basic        # ~200 aliases
export DOTFILES_MODE=advanced     # ~600 aliases (default)
export DOTFILES_MODE=ultra-nerd   # ~1000+ aliases
```

## Shell-Specific Commands

### Bash
```bash
source ~/.bashrc      # Reload config
bconf                 # Edit .bashrc
```

### Zsh
```bash
source ~/.zshrc       # Reload config
zconf                 # Edit .zshrc
```

### Fish
```bash
source ~/.config/fish/config.fish  # Reload
fconf                              # Edit config
```

## Utility Functions

```bash
# File operations
mkcd directory           # mkdir && cd
cpg src dest             # cp && cd to dest
mvg src dest             # mv && cd to dest
up 3                     # cd ../../../
bak file                 # Backup with timestamp
swap file1 file2         # Swap two files
touchp path/to/file      # mkdir -p && touch

# Search
ff filename              # Find file by name
fd dirname               # Find directory
ftext pattern            # Search text in files

# Network
myip                     # Show IPs
serve [port]             # HTTP server
sslcheck host [port]     # Check SSL cert
dl url [output]          # Download with progress

# Process
psgrep pattern           # Find process
killp pattern            # Kill process
memhogs [count]          # Top memory users
cpuhogs [count]          # Top CPU users

# Development
lazyg "message"          # Git add, commit, push
gitsetup url             # Setup new repo
docker_clean             # Clean Docker
json file/string         # Pretty print JSON

# Data
calc expression          # Calculate
b64 string               # Base64 encode
b64 -d string            # Base64 decode
urlencode string         # URL encode
urldecode string         # URL decode
passgen [length]         # Generate password

# Info
weather [location]       # Weather
sysinfo                  # System info
```

## Maintenance

```bash
# Update dotfiles
cd ~/.dotfiles && git pull && make update

# Backup current config
make backup
# or
./scripts/backup.sh

# Health check
dotfiles-doctor

# Uninstall
./uninstall.sh
```

## Makefile Targets

```bash
make install        # Install dotfiles (interactive)
make install-fast   # Fast install with defaults
make update         # Pull and reload
make backup         # Create backup
make clean          # Uninstall
make test           # Test syntax
make lint           # Run shellcheck
make docker         # Docker test
make stats          # Show statistics
```

## Troubleshooting

```bash
# Slow startup?
DOTFILES_PROFILE=1 bash -i -c exit
cat /tmp/dotfiles-profile.log

# Missing tools?
./install_dotfiles.sh --all

# Broken symlinks?
make check-links

# Reset to defaults?
./install.sh -f -m basic
```

## Keyboard Shortcuts (Hyprland)

| Key | Action |
|-----|--------|
| `Super + Enter` | Open terminal |
| `Super + R` | Application launcher |
| `Super + Q` | Close window |
| `Super + M` | Exit Hyprland |
| `Super + [1-0]` | Switch workspace |
| `Super + Shift + [1-0]` | Move to workspace |
| `Super + Arrow Keys` | Change focus |
| `Super + Shift + Arrow` | Move window |
| `Super + Shift + S` | Screenshot |
| `Super + L` | Lock screen |
| `Super + F` | Toggle floating |
| `Super + T` | Toggle split |
| `Super + Mouse Left` | Move window |
| `Super + Mouse Right` | Resize window |

## Resources

- **Repository**: https://github.com/thepinak503/dotfiles
- **Issues**: Create GitHub issue
- **Docs**: See `docs/` directory
- **Cheatsheet**: `docs/cheatsheet.md`

---

*Print this page for desk reference*
*Last Updated: 2026-02-10*
