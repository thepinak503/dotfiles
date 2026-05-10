#!/usr/bin/env bash
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_NAME DOTFILES_FASTFETCH_ON_STARTUP
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_NAME="Pinak's Dotfiles"

# Homebrew
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

# ble.sh -- Bash Line Editor (syntax highlighting, autocomplete, vim mode, etc.)
[[ -f /usr/share/blesh/ble.sh && $- == *i* ]] && source /usr/share/blesh/ble.sh --attach=none

export DOTFILES_VERSION="1.0.0"

# Environment exports (PATH, LS_COLORS, etc.)
[[ -f "$DOTFILES_DIR/shells/bash/exports.bash" ]] && source "$DOTFILES_DIR/shells/bash/exports.bash"

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Universal distro-agnostic config (OS detection + cross-distro aliases)
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && source "$DOTFILES_DIR/core/universal.sh"

# Dynamic app detection (only enables aliases if app is installed)
[[ -f "$DOTFILES_DIR/shells/bash/detect_apps.bash" ]] && source "$DOTFILES_DIR/shells/bash/detect_apps.bash"

# All aliases (merged into one file)
[[ -f "$DOTFILES_DIR/core/aliases.sh" ]] && source "$DOTFILES_DIR/core/aliases.sh"

# All functions (merged into one file)
[[ -f "$DOTFILES_DIR/core/functions.sh" ]] && source "$DOTFILES_DIR/core/functions.sh"

# Distro-specific aliases (Arch, Debian, macOS, Fedora)
[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"

# Fastfetch at startup (interactive only)
case $- in *i*) if command -v fastfetch >/dev/null; then
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
fi;; esac

# ble-attach (must be at end of .bashrc for ble.sh)
[[ ! ${BLE_VERSION-} ]] || ble-attach

# Auto-update check (background, every 7 days)
[[ -z "$DOTFILES_NO_UPDATE" && $- == *i* ]] && {
  _du_file="$DOTFILES_STATE_DIR/last_update_check"
  [[ -f "$_du_file" ]] && _du_age=$(( $(date +%s) - $(<"$_du_file") )) || _du_age=999999
  [[ $_du_age -gt 604800 ]] && { bash "$DOTFILES_DIR/bin/dotupdate.sh" --yes >/dev/null 2>&1 & disown; date +%s > "$_du_file"; }
  unset _du_file _du_age
}

true