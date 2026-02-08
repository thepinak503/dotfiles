# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.2.0] - 2026-02-08

### Added
- Comprehensive fastfetch configuration with all system parameters
- Enhanced install script with CLI arguments (--help, --version, --mode, etc.)
- Uninstall script for clean removal
- Makefile for easy management
- Tmux configuration with vi mode and custom keybindings
- Neovim configuration with lazy.nvim
- VS Code settings
- CHANGELOG.md
- Git hooks for syntax checking
- CI/CD pipeline with GitHub Actions
- Dockerfile for testing
- Cheat sheets for aliases
- Multiple Starship presets
- Theme switcher script

### Changed
- Improved error suppression throughout all shell configs
- Fixed bash/zsh compatibility issues
- Better Fish shell support with proper syntax

### Fixed
- Unclosed quote in 04-aliases-nerd.sh line 163
- Bash-specific syntax issues in zsh
- FZF parse errors

## [2.1.0] - 2026-02-07

### Added
- Multi-shell support: Bash, Zsh, Fish, Nushell
- Fish shell configuration with abbreviations
- Nushell configuration
- PowerShell configuration (later moved to separate repo)

### Changed
- Modular structure for all shells
- Better organization of aliases and functions

## [2.0.0] - 2026-02-07

### Added
- Initial modular bash configuration
- Three modes: basic, advanced, ultra-nerd
- Universal distro detection (Arch, Debian, Fedora, etc.)
- Package manager support (pacman, apt, dnf, zypper, apk)
- Modern tool integration (eza, bat, fzf, zoxide, ripgrep)
- 1000+ aliases organized by category
- 50+ utility functions
- Starship prompt configuration
- Git and SSH templates
- One-command installer

## [1.0.0] - 2026-02-07

### Added
- Initial release
- Basic bash configuration
- Essential aliases and functions
- Git configuration

[Unreleased]: https://github.com/thepinak503/dotfiles/compare/v2.2.0...HEAD
[2.2.0]: https://github.com/thepinak503/dotfiles/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/thepinak503/dotfiles/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/thepinak503/dotfiles/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/thepinak503/dotfiles/releases/tag/v1.0.0
