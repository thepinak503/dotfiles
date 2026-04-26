#!/usr/bin/env bash
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"

bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"

export DOTFILES_VERSION="12.1.0"

# Universal distro-agnostic config (OS detection + cross-distro aliases)
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && source "$DOTFILES_DIR/core/universal.sh"

# Dynamic app detection (only enables aliases if app is installed)
[[ -f "$DOTFILES_DIR/core/detect_apps.sh" ]] && source "$DOTFILES_DIR/core/detect_apps.sh"

# All aliases (merged into one file)
[[ -f "$DOTFILES_DIR/shells/bash/aliases_all.bash" ]] && source "$DOTFILES_DIR/shells/bash/aliases_all.bash"

# All functions (merged into one file)
[[ -f "$DOTFILES_DIR/shells/bash/functions_all.bash" ]] && source "$DOTFILES_DIR/shells/bash/functions_all.bash"

# Distro-specific aliases (Arch, Debian, macOS, Fedora)
[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"

# Fastfetch at startup (interactive only)
if [[ -i ]] && command -v fastfetch >/dev/null; then
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
fi

true