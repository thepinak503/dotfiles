#!/usr/bin/env bash
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
[[ $- != *i* ]] && return

bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"

export DOTFILES_VERSION="12.1.0"

[[ -f "$DOTFILES_DIR/shells/bash/aliases-core.bash" ]] && source "$DOTFILES_DIR/shells/bash/aliases-core.bash"
[[ -f "$DOTFILES_DIR/shells/bash/functions-core.bash" ]] && source "$DOTFILES_DIR/shells/bash/functions-core.bash"

d="$DOTFILES_DIR/shells/bash/modes"
[[ -f "$d/supreme.bash" ]] && source "$d/supreme.bash"

# Starship init
command -v starship >/dev/null && eval "$(starship init bash 2>>${DOTFILES_STATE_DIR:-/tmp}/errors.log)"

# Fastfetch
command -v fastfetch >/dev/null && fastfetch 2>/dev/null &

true