#!/usr/bin/env bash

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Login shell detection
if [ -n "$ZSH_VERSION" ]; then
    # Zsh login
    export DOTFILES_DIR="$HOME/.local/share/dotfiles"
    [[ -f ~/.zshrc ]] && source ~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
    # Bash login
    export DOTFILES_DIR="$HOME/.local/share/dotfiles"
    [[ -f ~/.bashrc ]] && source ~/.bashrc
fi