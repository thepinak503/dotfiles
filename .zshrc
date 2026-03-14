#!/usr/bin/env zsh
# =============================================================================
# ZSH MAIN CONFIGURATION
# Simplified structure with 3 tiers: basic, advanced, ultra-nerd
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"

# Enable autocd
setopt AUTO_CD

# History
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Editor
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
elif command -v vim &>/dev/null; then
    export EDITOR="vim"
    export VISUAL="vim"
fi
export PAGER="less"

# XDG
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# PATH
_path_prepend() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1${PATH:+:$PATH}"
}
_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.cargo/bin"

# Source bash aliases (compatible)
[[ -f "$DOTFILES_DIR/.bash/00-aliases-unified.sh" ]] && source "$DOTFILES_DIR/.bash/00-aliases-unified.sh"
[[ -f "$DOTFILES_DIR/.bash/01-functions.sh" ]] && source "$DOTFILES_DIR/.bash/01-functions.sh"

# Mode-specific
case "$DOTFILES_MODE" in
    basic)
        ;;
    advanced|ultra-nerd)
        # Starship
        if command -v starship &>/dev/null; then
            eval "$(starship init zsh)"
        fi
        # Zoxide
        if command -v zoxide &>/dev/null; then
            eval "$(zoxide init zsh)"
        fi
        ;;
esac

# Oh-My-Zsh (if installed)
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="robbyrussell"
    plugins=(git)
    source "$ZSH/oh-my-zsh.sh"
fi

# Scripts
alias install-shells="$DOTFILES_DIR/scripts/install_shell_support.sh"
[[ -f "$DOTFILES_DIR/scripts/install_shell_support.sh" ]] && source "$DOTFILES_DIR/scripts/install_shell_support.sh"
[[ -f "$DOTFILES_DIR/scripts/autoupdate.sh" ]] && source "$DOTFILES_DIR/scripts/autoupdate.sh"

# Commands
alias dotfiles-update='dotfiles_update'
alias dotfiles-status='cd "$DOTFILES_DIR" && git status'

# Clear
alias c='clear'
alias cl='clear'
alias cls='clear'

# Local
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
