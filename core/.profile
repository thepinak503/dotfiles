# ~/.profile: sourced by the command login shell
# This file is shell-agnostic and works for sh, bash, and zsh.

# 1. Detect DOTFILES_DIR
if [ -z "$DOTFILES_DIR" ]; then
    if [ -d "$HOME/git/dotfiles" ]; then
        export DOTFILES_DIR="$HOME/git/dotfiles"
    elif [ -d "$HOME/.dotfiles" ]; then
        export DOTFILES_DIR="$HOME/.dotfiles"
    fi
fi

# 2. Basic PATH and Environment
if [ -n "$DOTFILES_DIR" ] && [ -f "$DOTFILES_DIR/shells/bash/exports.bash" ]; then
    # Bash exports are mostly POSIX-compliant; good enough for initial login
    . "$DOTFILES_DIR/shells/bash/exports.bash"
fi

# 3. Source shell-specific RC if interactive (safeguard)
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    # Zsh typically uses .zprofile -> .zshrc flow
    [ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"
fi
