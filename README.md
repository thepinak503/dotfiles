# Pinak's Dotfiles

Unified, modular shell configuration ecosystem supporting Bash, Zsh, and Fish with feature parity across all environments.

## Overview

This repository implements a high-performance shell architecture with native support for Bash, Zsh, and Fish. Features and logic are manually synchronized to ensure peak performance and zero-dependency operation across every shell environment.

## Core Features

- **Universal Design**: Native implementation of aliases, exports, and functions across all major shell dialects.
- **Operational Modes**: Native support for cumulative configuration levels: `minimal`, `standard`, `supreme`, and `ultra-nerd`.
- **Automated Maintenance**:
    - `dotupdate`: Check for upstream changes and view feature history since installation.
    - `dotfix`: Verified repair and re-linking of configuration files.
    - `dotmode <level>`: Dynamic switching of environment complexity.
- **Self-Diagnostics**: Integrated health check utility (`bin/health_check.sh`) and startup benchmarker (`bin/benchmark_shell.sh`).
- **Modern Tool Integration**: Pre-configured hooks for Atuin, Direnv, Mise, Starship, Zoxide, and FZF.
- **Developer Experience**: Professional configurations for Tmux, Lazygit, and Git (including Delta integration).

## Installation

### One-line Bootstrap
```sh
curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | sh
```
or 
```
curl -fsSL https://is.gd/install_dotfiles | sh
```

### Manual Installation
```sh
git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

## Structure

- `shells/`: Source configuration files (Bash, Zsh, Fish).
- `bin/`: Shell utility scripts for maintenance and diagnostics.
- `apps/`: Dedicated configurations for external tools (Git, Tmux, Lazygit, Starship).
- `install/`: Distro-agnostic installation logic with Homebrew support.

## Maintenance Workflow

All modifications are maintained natively within each shell's source directory (Bash, Zsh, Fish). Git hooks are used to validate syntax before every commit.

## License

MIT
