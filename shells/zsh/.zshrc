#!/usr/bin/env zsh
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP STARSHIP_CONFIG
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"

case "$-" in
    *i*) ;;
    *) return 0 ;;
esac

[[ -z "$DOTFILES_MODE" ]] && [[ -f "$DOTFILES_STATE_DIR/mode" ]] && export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
[[ -z "$DOTFILES_MODE" ]] && export DOTFILES_MODE="supreme"
export DOTFILES_VERSION="12.1.0"

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

command -v nvim >/dev/null && export EDITOR="nvim" VISUAL="nvim" MANPAGER="nvim +Man!"
export PAGER="less"
export LESS="-R -i -g -c -W -F -X -M --shift 5"
export TERM="${TERM:-xterm-256color}"
export CLICOLOR=1
export BAT_THEME="TwoDark"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_EXPIRE_DUPS_FIRST SHARE_HISTORY EXTENDED_HISTORY APPEND_HISTORY HIST_FIND_NO_DUPS
setopt AUTO_CD CORRECT NOMATCH AUTO_PUSHD PUSHD_IGNORE_DUPS CD_SILENT 2>/dev/null || true
unsetopt BEEP 2>/dev/null || true
autoload -Uz select-word-style && select-word-style bash

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin${PATH:+:$PATH}"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin${PATH:+:$PATH}"

autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Universal distro-agnostic config (OS detection)
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && emulate sh -c "source '$DOTFILES_DIR/core/universal.sh'"

# Dynamic app detection
[[ -f "$DOTFILES_DIR/core/detect_apps.sh" ]] && emulate sh -c "source '$DOTFILES_DIR/core/detect_apps.sh'"

# All aliases (merged)
[[ -f "$DOTFILES_DIR/shells/zsh/aliases_all.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/aliases_all.zsh"

# All functions (merged)
[[ -f "$DOTFILES_DIR/shells/zsh/functions_all.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/functions_all.zsh"

# Fastfetch at startup
command -v fastfetch >/dev/null && fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null

true