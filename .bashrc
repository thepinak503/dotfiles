#!/usr/bin/env bash
# =============================================================================
# BASH/ZSH MAIN CONFIGURATION
# Unified entry point - sources all shell configs
# =============================================================================

DOTFILES_DIR="${HOME}/.dotfiles"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"

# Source unified aliases FIRST (so they can be overridden by more specific configs)
[[ -f "$DOTFILES_DIR/.bash/00-aliases-unified.sh" ]] && source "$DOTFILES_DIR/.bash/00-aliases-unified.sh"

# Source all other bash configs in order
for file in "$DOTFILES_DIR/.bash/"*.sh; do
    # Skip if it's the unified aliases (already sourced)
    [[ "$file" == *"00-aliases-unified.sh" ]] && continue
    [[ -f "$file" ]] && source "$file"
done

# Install shell support command
alias install-shells="$DOTFILES_DIR/scripts/install_shell_support.sh"

# Load install_shell_support function
[[ -f "$DOTFILES_DIR/scripts/install_shell_support.sh" ]] && source "$DOTFILES_DIR/scripts/install_shell_support.sh"

# Auto-update dotfiles
[[ -f "$DOTFILES_DIR/scripts/autoupdate.sh" ]] && source "$DOTFILES_DIR/scripts/autoupdate.sh"

# Manual update commands
alias dotfiles-update='dotfiles_update'
alias dotfiles-status='cd "$DOTFILES_DIR" && git status'

# Ensure clear always works (safeguard)
alias clear='/usr/bin/clear'
alias c='/usr/bin/clear'
alias cl='/usr/bin/clear'
alias cls='/usr/bin/clear'

[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
