if [ -z "$DOTFILES_DIR" ]; then
    if [ -d "$HOME/git/dotfiles" ]; then
        export DOTFILES_DIR="$HOME/git/dotfiles"
    elif [ -d "$HOME/.dotfiles" ]; then
        export DOTFILES_DIR="$HOME/.dotfiles"
    fi
fi
if [ -n "$DOTFILES_DIR" ] && [ -f "$DOTFILES_DIR/shells/bash/exports.bash" ]; then
    . "$DOTFILES_DIR/shells/bash/exports.bash"
fi
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    [ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"
fi
