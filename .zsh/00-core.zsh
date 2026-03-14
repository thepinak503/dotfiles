#!/usr/bin/env zsh
# =============================================================================
# ZSH CORE CONFIGURATION
# Zsh-specific environment and variables
# =============================================================================

# Enable autocd - type directory name to cd into it
setopt AUTO_CD

# XDG Base Directory
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# Editor
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim +Man!"
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

# Terminal
export TERM="${TERM:-xterm-256color}"
export COLORTERM="truecolor"
export CLICOLOR=1

# Disable annoying prompts
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NPM_CONFIG_UPDATE_NOTIFIER=false
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# LS Colors
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.zip=01;31:*.gz=01;31:*.bz2=01;31:*.jpg=01;35:*.jpeg=01;35:*.png=01;35:*.gif=01;35:*.mp3=01;35:*.wav=01;35:'

# Man pages
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# PATH Management
_path_prepend() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1${PATH:+:$PATH}"
}
_path_append() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="${PATH:+$PATH:}$1"
}

_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.cargo/bin"
_path_append "$HOME/.dotnet/tools"
_path_append "$HOME/.npm-global/bin"
_path_append "$HOME/.poetry/bin"
_path_append "$HOME/go/bin"

[[ -d "/snap/bin" ]] && _path_append "/snap/bin"
[[ -d "/var/lib/flatpak/exports/bin" ]] && _path_append "/var/lib/flatpak/exports/bin"

# Homebrew
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && _path_prepend "$PYENV_ROOT/bin"

# Node
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export NVM_DIR="$HOME/.nvm"

# Rust
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# Go
export GOPATH="$HOME/go"

# Java
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/default-java}"
[[ -d "$JAVA_HOME/bin" ]] && _path_append "$JAVA_HOME/bin"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# FZF
export FZF_DEFAULT_OPTS="
  --height=60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0'
"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f -not -path '*/\.*' 2>/dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d -not -path '*/\.*' 2>/dev/null"

# Bat
export BAT_THEME="TwoDark"
export BAT_STYLE="numbers,changes,header"

# Ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Dotfiles
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"
export DOTFILES_VERSION="2.0.0"

# System
export OS="$(uname -s)"
export ARCH="$(uname -m)"
