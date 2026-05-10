#!/usr/bin/env bash

# Homebrew (Linuxbrew on Linux, Homebrew on macOS)
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Login shell detection
if [ -n "$ZSH_VERSION" ]; then
    export DOTFILES_DIR="$HOME/.local/share/dotfiles"
    [[ -f ~/.zshrc ]] && source ~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
    export DOTFILES_DIR="$HOME/.local/share/dotfiles"
    [[ -f ~/.bashrc ]] && source ~/.bashrc
fi