# Zsh login shell profile
export DOTFILES_DIR="$HOME/.local/share/dotfiles"

# Homebrew
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

[[ -f ~/.zshrc ]] && source ~/.zshrc

# Added by Antigravity CLI installer
export PATH="/home/pinak/.local/bin:$PATH"
