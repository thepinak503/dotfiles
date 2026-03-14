#!/usr/bin/env bash
# =============================================================================
# BASH MAIN CONFIGURATION
# Simplified structure with 3 tiers: basic, advanced, ultra-nerd
# =============================================================================

DOTFILES_DIR="${HOME}/.dotfiles"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"

# Core (always loaded)
[[ -f "$DOTFILES_DIR/.bash/00-core.sh" ]] && source "$DOTFILES_DIR/.bash/00-core.sh"
[[ -f "$DOTFILES_DIR/.bash/00-aliases-unified.sh" ]] && source "$DOTFILES_DIR/.bash/00-aliases-unified.sh"
[[ -f "$DOTFILES_DIR/.bash/01-functions.sh" ]] && source "$DOTFILES_DIR/.bash/01-functions.sh"

# Mode-specific
case "$DOTFILES_MODE" in
    basic)
        [[ -f "$DOTFILES_DIR/.bash/02-mode-basic.sh" ]] && source "$DOTFILES_DIR/.bash/02-mode-basic.sh"
        ;;
    advanced)
        [[ -f "$DOTFILES_DIR/.bash/03-mode-advanced.sh" ]] && source "$DOTFILES_DIR/.bash/03-mode-advanced.sh"
        ;;
    ultra-nerd)
        [[ -f "$DOTFILES_DIR/.bash/03-mode-advanced.sh" ]] && source "$DOTFILES_DIR/.bash/03-mode-advanced.sh"
        [[ -f "$DOTFILES_DIR/.bash/04-mode-ultra-nerd.sh" ]] && source "$DOTFILES_DIR/.bash/04-mode-ultra-nerd.sh"
        ;;
esac

# Scripts
alias install-shells="$DOTFILES_DIR/scripts/install_shell_support.sh"
[[ -f "$DOTFILES_DIR/scripts/install_shell_support.sh" ]] && source "$DOTFILES_DIR/scripts/install_shell_support.sh"
[[ -f "$DOTFILES_DIR/scripts/autoupdate.sh" ]] && source "$DOTFILES_DIR/scripts/autoupdate.sh"

# Commands
alias dotfiles-update='dotfiles_update'
alias dotfiles-status='cd "$DOTFILES_DIR" && git status'

# Ensure clear works
alias clear='/usr/bin/clear'
alias c='/usr/bin/clear'
alias cl='/usr/bin/clear'
alias cls='/usr/bin/clear'

# Local
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
