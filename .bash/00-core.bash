#!/usr/bin/env bash
# =============================================================================
# SIMPLIFIED BASH CONFIG - Consolidated into fewer files
# =============================================================================

# -----------------------------------------------------------------------------
# CORE ENVIRONMENT
# -----------------------------------------------------------------------------

# XDG Base Directory
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

# Editor
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
elif command -v vim &>/dev/null; then
    export EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="nano"
    export VISUAL="nano"
fi
export PAGER="less"
export LESS="-R -i -g -c -W -F -X -M --shift 5"

# Locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export TERM="${TERM:-xterm-256color}"

# Disable annoying prompts
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NPM_CONFIG_UPDATE_NOTIFIER=false
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# PATH Management
_path_prepend() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1${PATH:+:$PATH}"
}
_path_append() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="${PATH:+$PATH:}$1"
}

_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.cargo/bin"

# WARNING: Be sure to add /home/pinak/.cargo/bin to your PATH to be able to run the installed binaries

_path_append "$HOME/.npm-global/bin"
_path_append "$HOME/.poetry/bin"
_path_append "$HOME/go/bin"

# -----------------------------------------------------------------------------
# SHELL OPTIONS
# -----------------------------------------------------------------------------
shopt -s autocd 2>/dev/null
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null
shopt -s dotglob 2>/dev/null
shopt -s cdspell 2>/dev/null

# -----------------------------------------------------------------------------
# COMPLETION
# -----------------------------------------------------------------------------
if command -v yum &>/dev/null; then
    # RHEL/CentOS
    :
elif command -v apt-get &>/dev/null; then
    # Debian/Ubuntu
    :
elif command -v pacman &>/dev/null; then
    # Arch
    :
fi
