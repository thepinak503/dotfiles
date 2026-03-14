#!/usr/bin/env bash
# =============================================================================
# BASH MAIN CONFIGURATION
# Simplified structure with 3 tiers: basic, advanced, ultra-nerd
# =============================================================================

# Fastfetch on start (if installed)
if command -v fastfetch &>/dev/null; then
    fastfetch 2>/dev/null
fi

DOTFILES_DIR="${HOME}/.dotfiles"
[[ ! -d "$DOTFILES_DIR" ]] && DOTFILES_DIR="${HOME}/git/dotfiles"
export DOTFILES_DIR
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"

# Core (always loaded)
[[ -f "$DOTFILES_DIR/.bash/00-core.bash" ]] && source "$DOTFILES_DIR/.bash/00-core.bash"
[[ -f "$DOTFILES_DIR/.bash/00-aliases-unified.bash" ]] && source "$DOTFILES_DIR/.bash/00-aliases-unified.bash"
[[ -f "$DOTFILES_DIR/.bash/01-functions.bash" ]] && source "$DOTFILES_DIR/.bash/01-functions.bash"

# Mode-specific
case "$DOTFILES_MODE" in
    basic)
        [[ -f "$DOTFILES_DIR/.bash/02-mode-basic.bash" ]] && source "$DOTFILES_DIR/.bash/02-mode-basic.bash"
        ;;
    advanced)
        [[ -f "$DOTFILES_DIR/.bash/03-mode-advanced.bash" ]] && source "$DOTFILES_DIR/.bash/03-mode-advanced.bash"
        ;;
    ultra-nerd)
        [[ -f "$DOTFILES_DIR/.bash/03-mode-advanced.bash" ]] && source "$DOTFILES_DIR/.bash/03-mode-advanced.bash"
        [[ -f "$DOTFILES_DIR/.bash/04-mode-ultra-nerd.bash" ]] && source "$DOTFILES_DIR/.bash/04-mode-ultra-nerd.bash"
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
