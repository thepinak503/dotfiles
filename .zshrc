#!/usr/bin/env zsh
# =============================================================================
# ZSH MAIN CONFIGURATION
# Unified entry point - sources all shell configs
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"

# Source unified aliases FIRST (modern CLI with fallbacks)
[[ -f "$DOTFILES_DIR/.bash/00-aliases-unified.sh" ]] && source "$DOTFILES_DIR/.bash/00-aliases-unified.sh"

# Source zsh-specific configs
for file in "$DOTFILES_DIR/.zsh/"*.zsh; do
    [[ -f "$file" ]] && source "$file"
done

# Source shared bash configs (compatible parts)
[[ -f "$DOTFILES_DIR/.bash/00-core.sh" ]] && source "$DOTFILES_DIR/.bash/00-core.sh"
[[ -f "$DOTFILES_DIR/.bash/01-functions.sh" ]] && source "$DOTFILES_DIR/.bash/01-functions.sh"

# Source mode-specific configs
if [[ "$DOTFILES_MODE" != "basic" ]]; then
    [[ -f "$DOTFILES_DIR/.bash/03-aliases-extended.sh" ]] && source "$DOTFILES_DIR/.bash/03-aliases-extended.sh"
    [[ -f "$DOTFILES_DIR/.bash/05-distro-detection.sh" ]] && source "$DOTFILES_DIR/.bash/05-distro-detection.sh"
    [[ -f "$DOTFILES_DIR/.bash/06-package-managers.sh" ]] && source "$DOTFILES_DIR/.bash/06-package-managers.sh"
    [[ -f "$DOTFILES_DIR/.bash/07-modern-tools.sh" ]] && source "$DOTFILES_DIR/.bash/07-modern-tools.sh"
    [[ -f "$DOTFILES_DIR/.bash/08-development.sh" ]] && source "$DOTFILES_DIR/.bash/08-development.sh"
fi

[[ "$DOTFILES_MODE" == "ultra-nerd" ]] && [[ -f "$DOTFILES_DIR/.bash/04-aliases-nerd.sh" ]] && source "$DOTFILES_DIR/.bash/04-aliases-nerd.sh"

# Local customizations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Dotfiles scripts
alias emoji="$DOTFILES_DIR/scripts/emoji-picker"
alias calc="$DOTFILES_DIR/scripts/calc"
alias keys="$DOTFILES_DIR/scripts/keybinding-helper"
alias check-errors="$DOTFILES_DIR/scripts/check-errors"
alias clipboard="$DOTFILES_DIR/scripts/clipboard-manager"
alias dropdown="$DOTFILES_DIR/scripts/dropdown-terminal"

# Install shell support command
alias install-shells="$DOTFILES_DIR/scripts/install_shell_support.sh"

# Load install_shell_support function
[[ -f "$DOTFILES_DIR/scripts/install_shell_support.sh" ]] && source "$DOTFILES_DIR/scripts/install_shell_support.sh"

# Auto-update dotfiles
[[ -f "$DOTFILES_DIR/scripts/autoupdate.sh" ]] && source "$DOTFILES_DIR/scripts/autoupdate.sh"

# Manual update commands
alias dotfiles-update='dotfiles_update'
alias dotfiles-status='cd "$DOTFILES_DIR" && git status'

# Shell shortcuts
alias c='clear'
alias cl='clear'
alias cls='clear'
