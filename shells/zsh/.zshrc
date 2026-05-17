#!/usr/bin/env zsh
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_NAME DOTFILES_FASTFETCH_ON_STARTUP STARSHIP_CONFIG
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_NAME="Pinak's Dotfiles"

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

case "$-" in
    *i*) ;;
    *) return 0 ;;
esac

[[ -z "$DOTFILES_MODE" ]] && [[ -f "$DOTFILES_STATE_DIR/mode" ]] && export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
[[ -z "$DOTFILES_MODE" ]] && export DOTFILES_MODE="supreme"
export DOTFILES_VERSION="1.0.0"

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


[[ -f "$DOTFILES_DIR/shells/zsh/exports.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/exports.zsh"

autoload -Uz compinit
local zdump="$HOME/.zcompdump"
if [[ -f "$zdump" ]] && (( $(date +%s) - $(stat -c %Y "$zdump" 2>/dev/null || stat -f %m "$zdump" 2>/dev/null || echo 0) < 86400 )); then
    compinit -C
else
    compinit
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word
bindkey '^[[3;3~' kill-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey '^k' kill-line
bindkey '^y' yank
bindkey '^_' undo


[[ -f "$DOTFILES_DIR/core/__cache.sh" ]] && source "$DOTFILES_DIR/core/__cache.sh"
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && emulate sh -c "source '$DOTFILES_DIR/core/universal.sh'"

# Dynamic app detection
[[ -f "$DOTFILES_DIR/shells/zsh/detect_apps.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/detect_apps.zsh"


[[ -f "$DOTFILES_DIR/core/aliases.sh" ]] && source "$DOTFILES_DIR/core/aliases.sh"


[[ -f "$DOTFILES_DIR/shells/zsh/aliases.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/aliases.zsh"


[[ -f "$DOTFILES_DIR/core/functions.sh" ]] && source "$DOTFILES_DIR/core/functions.sh"


[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"


[[ -f "$DOTFILES_DIR/core/system-detect.sh" ]] && source "$DOTFILES_DIR/core/system-detect.sh"
[[ -f "$DOTFILES_DIR/core/os_detect.sh" ]] && source "$DOTFILES_DIR/core/os_detect.sh"
[[ -f "$DOTFILES_DIR/core/logging.sh" ]] && source "$DOTFILES_DIR/core/logging.sh"
[[ -f "$DOTFILES_DIR/core/ssh-agent.sh" ]] && source "$DOTFILES_DIR/core/ssh-agent.sh"
[[ -f "$DOTFILES_DIR/core/battery.sh" ]] && source "$DOTFILES_DIR/core/battery.sh"
[[ -f "$DOTFILES_DIR/core/tools.sh" ]] && source "$DOTFILES_DIR/core/tools.sh"


[[ -f "$DOTFILES_DIR/shells/zsh/modes/ultimate.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/modes/ultimate.zsh"


case $- in *i*) command -v fastfetch >/dev/null && fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null;; esac


[[ -z "$DOTFILES_NO_UPDATE" ]] && {
  _du_file="$DOTFILES_STATE_DIR/last_update_check"
  _du_age=999999; [[ -f "$_du_file" ]] && _du_age=$(( $(date +%s) - $(<"$_du_file") ))
  [[ $_du_age -gt 604800 ]] && { bash "$DOTFILES_DIR/bin/dotupdate.sh" --yes >/dev/null 2>&1 & disown; date +%s > "$_du_file"; }
  unset _du_file _du_age
}

