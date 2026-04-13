#!/usr/bin/env bash
# =============================================================================
# ~/.bashrc — Bash entry point (thin loader)
# =============================================================================

[[ $- != *i* ]] && return

# Robustly detect DOTFILES_DIR (resolve symlinks)
_BS_FILE="${BASH_SOURCE[0]}"
while [ -L "$_BS_FILE" ]; do
    _BS_DIR="$(cd -P "$(dirname "$_BS_FILE")" >/dev/null 2>&1 && pwd)"
    _BS_FILE="$(readlink "$_BS_FILE")"
    [[ $_BS_FILE != /* ]] && _BS_FILE="$_BS_DIR/$_BS_FILE"
done
DOTFILES_DIR="$(cd -P "$(dirname "$_BS_FILE")/../.." >/dev/null 2>&1 && pwd)"
if [[ ! -d "$DOTFILES_DIR/shells" ]]; then
    if [[ -d "$HOME/git/dotfiles" ]]; then
        DOTFILES_DIR="$HOME/git/dotfiles"
    elif [[ -d "/home/pinak/git/dotfiles" ]]; then
        DOTFILES_DIR="/home/pinak/git/dotfiles"
    fi
fi
export DOTFILES_DIR
unset _BS_FILE _BS_DIR
export DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null

if [[ -z "$DOTFILES_MODE" ]]; then
    if [[ -f "$DOTFILES_STATE_DIR/mode" ]]; then
        export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
    else
        export DOTFILES_MODE="supreme"
    fi
fi
export DOTFILES_VERSION="11.0.0"

_src() { [[ -f "$1" && -r "$1" ]] && source "$1" 2>/dev/null; }

# 1. CORE
_src "$DOTFILES_DIR/core/system-detect.sh"
_src "$DOTFILES_DIR/core/tools.sh"
_src "$DOTFILES_DIR/core/battery.sh"

# 2. SHELL CONFIG
_src "$DOTFILES_DIR/shells/bash/exports.bash"
_src "$DOTFILES_DIR/shells/bash/functions.bash"
_src "$DOTFILES_DIR/shells/bash/aliases.bash"

# 3. DYNAMIC & PACKAGES (Phase-gated)
if [[ "$DOTFILES_MODE" =~ ^(basic|standard|advanced|supreme|ultra-nerd)$ ]]; then
    _src "$DOTFILES_DIR/shells/bash/03-dynamic_aliases.bash"
    _src "$DOTFILES_DIR/shells/bash/04-pkg_aliases.bash"
fi

if [[ "$DOTFILES_MODE" =~ ^(supreme|ultra-nerd)$ ]]; then
    _src "$DOTFILES_DIR/shells/bash/05-heavy_tools.bash"
fi

# 4. PROMPT & EXTRA
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

# 5. STARTUP TOOLS
if [[ -f /usr/bin/fastfetch ]]; then
    exec fastfetch
fi

if [[ -f /usr/share/doc/find-the-command/ftc.bash ]]; then
    source /usr/share/doc/find-the-command/ftc.bash noprompt quiet
fi

if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
