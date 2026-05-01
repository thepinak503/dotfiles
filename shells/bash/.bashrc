#!/usr/bin/env bash
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"

# Homebrew
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\C-a": beginning-of-line'
bind '"\C-e": end-of-line'
bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\e[1;3D": backward-word'
bind '"\e[1;3C": forward-word'
bind '"\C-w": backward-kill-word'
bind '"\C-u": backward-kill-line'
bind '"\C-k": kill-line'
bind '"\C-y": yank'
bind '"\C-_": undo'

export DOTFILES_VERSION="12.1.0"

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Universal distro-agnostic config (OS detection + cross-distro aliases)
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && source "$DOTFILES_DIR/core/universal.sh"

# Dynamic app detection (only enables aliases if app is installed)
[[ -f "$DOTFILES_DIR/shells/bash/detect_apps.bash" ]] && source "$DOTFILES_DIR/shells/bash/detect_apps.bash"

# All aliases (merged into one file)
[[ -f "$DOTFILES_DIR/shells/bash/aliases.bash" ]] && source "$DOTFILES_DIR/shells/bash/aliases.bash"

# All functions (merged into one file)
[[ -f "$DOTFILES_DIR/shells/bash/functions.bash" ]] && source "$DOTFILES_DIR/shells/bash/functions.bash"

# Distro-specific aliases (Arch, Debian, macOS, Fedora)
[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"

# Fastfetch at startup (interactive only)
case $- in *i*) if command -v fastfetch >/dev/null; then
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
fi;; esac

true