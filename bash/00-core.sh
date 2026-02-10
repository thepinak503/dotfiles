#!/usr/bin/env bash
# =============================================================================
# 00-CORE.SH - Core Environment & Variables
# Applies to ALL modes: basic, advanced, ultra-nerd
# =============================================================================

# -----------------------------------------------------------------------------
# SOURCE SHARED LIBRARY
# -----------------------------------------------------------------------------
# Load shared colors and utility functions if available
[[ -f "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/colors.sh" ]] && \
    source "${DOTFILES_DIR:-$HOME/.dotfiles}/lib/colors.sh"

# -----------------------------------------------------------------------------
# XDG BASE DIRECTORY SPECIFICATION
# -----------------------------------------------------------------------------
# Ensure XDG directories exist
ensure_xdg_dirs() {
    local dirs=(
        "${XDG_DATA_HOME:-$HOME/.local/share}"
        "${XDG_CONFIG_HOME:-$HOME/.config}"
        "${XDG_STATE_HOME:-$HOME/.local/state}"
        "${XDG_CACHE_HOME:-$HOME/.cache}"
    )
    for dir in "${dirs[@]}"; do
        [[ -d "$dir" ]] || mkdir -p "$dir"
    done
}
ensure_xdg_dirs
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# -----------------------------------------------------------------------------
# HISTORY CONFIGURATION (Universal Best Practices)
# -----------------------------------------------------------------------------
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL="erasedups:ignoredups:ignorespace"
export HISTIGNORE="&:ls:ll:la:l:cd:cd ..:exit:clear:history:pwd:date:* --help"

# Eternal history (survives across sessions)
export HISTFILE_ETERNAL="$HOME/.bash_eternal_history"
if [[ ! -f "$HISTFILE_ETERNAL" ]]; then
    touch "$HISTFILE_ETERNAL"
    chmod 600 "$HISTFILE_ETERNAL"
fi

# Enhanced history with timestamp and command duration (if available)
if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
    # Record command start time
    export HISTFILE="$HOME/.bash_history"
    # Sync history immediately for better multi-terminal experience
    shopt -s histappend &>/dev/null
fi

# -----------------------------------------------------------------------------
# DEFAULT APPLICATIONS
# -----------------------------------------------------------------------------
# Priority: nvim → vim → vi → nano
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim +Man!"
elif command -v vim &>/dev/null; then
    export EDITOR="vim"
    export VISUAL="vim"
    export MANPAGER="vim -M +MANPAGER -"
else
    export EDITOR="nano"
    export VISUAL="nano"
fi

# Pager
export PAGER="less"
export LESS="-R -i -g -c -W -F -X -M --shift 5"

# Browser (fallback)
export BROWSER="${BROWSER:-firefox}"

# -----------------------------------------------------------------------------
# LOCALE & CHARACTER ENCODING
# -----------------------------------------------------------------------------
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"

# -----------------------------------------------------------------------------
# TERMINAL & DISPLAY
# -----------------------------------------------------------------------------
export TERM="${TERM:-xterm-256color}"
export COLORTERM="truecolor"
export CLICOLOR=1

# Disable virtualenv prompt modification (let Starship handle it)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Disable npm update notifier (speeds up npm commands)
export NPM_CONFIG_UPDATE_NOTIFIER=false

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# -----------------------------------------------------------------------------
# LS_COLORS (Comprehensive File Type Coloring)
# -----------------------------------------------------------------------------
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# -----------------------------------------------------------------------------
# MAN PAGE COLORS
# -----------------------------------------------------------------------------
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# -----------------------------------------------------------------------------
# PATH MANAGEMENT (Smart Appending)
# -----------------------------------------------------------------------------
# Note: _path_append and _path_prepend are now in lib/colors.sh
# Define local versions for standalone usage

if ! declare -f _path_append &>/dev/null; then
    _path_append() {
        if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
            export PATH="${PATH:+$PATH:}$1"
        fi
    }
fi

if ! declare -f _path_prepend &>/dev/null; then
    _path_prepend() {
        if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
            export PATH="$1${PATH:+:$PATH}"
        fi
    }
fi

# Deduplicate PATH function
_dedup_path() {
    local IFS=':'
    local -a paths=($PATH)
    local -a unique=()
    local p
    for p in "${paths[@]}"; do
        [[ -z "$p" ]] && continue
        if [[ ! " ${unique[*]} " =~ " $p " ]]; then
            unique+=("$p")
        fi
    done
    export PATH="$(IFS=':'; echo "${unique[*]}")"
}

# User-local binaries (order matters - prepend for priority)
_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.cargo/bin"
_path_append "$HOME/.dotnet/tools"
_path_append "$HOME/.npm-global/bin"
_path_append "$HOME/.poetry/bin"
_path_append "$HOME/go/bin"

# Snap packages (if available)
[[ -d "/snap/bin" ]] && _path_append "/snap/bin"

# Flatpak exports
[[ -d "/var/lib/flatpak/exports/bin" ]] && _path_append "/var/lib/flatpak/exports/bin"

# Homebrew (Linux/macOS) - only initialize once
if [[ -z "${HOMEBREW_INITIALIZED:-}" ]]; then
    if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        export HOMEBREW_INITIALIZED=1
    elif [[ -d "/opt/homebrew/bin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export HOMEBREW_INITIALIZED=1
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
        export HOMEBREW_INITIALIZED=1
    fi
fi

# Clean up PATH to remove duplicates (run once per session)
if [[ -z "${PATH_DEDUPED:-}" ]]; then
    _dedup_path
    export PATH_DEDUPED=1
fi

# -----------------------------------------------------------------------------
# TOOL-SPECIFIC SETTINGS
# -----------------------------------------------------------------------------

# FZF Configuration
export FZF_DEFAULT_OPTS="
  --height=60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --bind='pgdn:preview-page-down,pgup:preview-page-up'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0'
  --color='pointer:#c586c0,marker:#ce9178,spinner:#569cd6,header:#4ec9b0'
"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f -not -path '*/\.*' 2>/dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d -not -path '*/\.*' 2>/dev/null"

# Ripgrep Configuration
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Bat Configuration
export BAT_THEME="TwoDark"
export BAT_STYLE="numbers,changes,header"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && _path_prepend "$PYENV_ROOT/bin"

# Node.js
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export NVM_DIR="$HOME/.nvm"

# Rust
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# Java
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/default-java}"
[[ -d "$JAVA_HOME/bin" ]] && _path_append "$JAVA_HOME/bin"

# Go
export GOPATH="$HOME/go"

# Kubernetes
export KUBECONFIG="$HOME/.kube/config"

# -----------------------------------------------------------------------------
# DOTFILES-SPECIFIC ENVIRONMENT
# -----------------------------------------------------------------------------
export DOTFILES_VERSION="2.0.0"
export DOTFILES_REPO="https://github.com/thepinak503/dotfiles"

# -----------------------------------------------------------------------------
# SYSTEM DETECTION
# -----------------------------------------------------------------------------
export OS="$(uname -s)"
export ARCH="$(uname -m)"
export KERNEL="$(uname -r)"
export HOSTNAME="$(hostname -s)"
