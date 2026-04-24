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

command -v nvim >/dev/null && export EDITOR="nvim" VISUAL="nvim" MANPAGER="nvim +Man!" || command -v vim >/dev/null && export EDITOR="vim" VISUAL="vim" || export EDITOR="nano" VISUAL="nano"
export PAGER="less"
export LESS="-R -i -g -c -W -F -X -M --shift 5"
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export TERM="${TERM:-xterm-256color}"
export COLORTERM="truecolor"
export CLICOLOR=1

export BAT_THEME="TwoDark"
export BAT_STYLE="numbers,changes,header"
export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border=rounded --preview-window=right:50%"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_EXPIRE_DUPS_FIRST SHARE_HISTORY EXTENDED_HISTORY APPEND_HISTORY HIST_FIND_NO_DUPS
setopt AUTO_CD CORRECT NOMATCH AUTO_PUSHD PUSHD_IGNORE_DUPS CD_SILENT 2>/dev/null || true
unsetopt BEEP 2>/dev/null || true
autoload -Uz select-word-style && select-word-style bash

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin${PATH:+:$PATH}"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin${PATH:+:$PATH}"
[[ -d "$GOPATH" ]] && export PATH="${GOPATH}:$PATH"
[[ -d "$HOME/.npm-global/bin" ]] && export PATH="$HOME/.npm-global/bin:$PATH"

autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{cyan}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches%f'

[[ -f "$DOTFILES_DIR/shells/zsh/aliases-core.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/aliases-core.zsh"
[[ -f "$DOTFILES_DIR/shells/zsh/functions-core.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/functions-core.zsh"

local d="$DOTFILES_DIR/shells/zsh/modes"
case "$DOTFILES_MODE" in
    minimal) source "$d/minimal.zsh" ;;
    standard) source "$d/minimal.zsh"; source "$d/standard.zsh" ;;
    supreme|*) source "$d/supreme.zsh" ;;
    ultra-nerd) source "$d/supreme.zsh"; source "$d/ultra_nerd.zsh" ;;
esac

command -v starship >/dev/null && eval "$(starship init zsh 2>>${DOTFILES_STATE_DIR:-/tmp}/errors.log)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)" 2>/dev/null

# Fastfetch on startup - runs in background
command -v fastfetch >/dev/null && fastfetch 2>/dev/null &

true