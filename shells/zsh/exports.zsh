#!/usr/bin/env zsh
# Clear any inherited dotfiles vars
unset DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP STARSHIP_CONFIG
[[ "$TERM" == "dumb" || -z "$TERM" ]] && export TERM=xterm-256color
export DOTFILES_MODE="${DOTFILES_MODE:-supreme}"

# Secure umask - files 0644, dirs 0755
umask 022

# Nord LS_COLORS for ls consistency
export LS_COLORS="di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"

export PATH="$HOME/.cargo/bin:$PATH"

# Flatpak paths
[ -d "/var/lib/flatpak/exports/bin" ] && export PATH="/var/lib/flatpak/exports/bin${PATH:+:$PATH}"
[ -d "$HOME/.local/share/flatpak/exports/bin" ] && export PATH="$HOME/.local/share/flatpak/exports/bin${PATH:+:$PATH}"

# LESS_TERMCAP - Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_MESSAGES="${LC_MESSAGES:-en_US.UTF-8}"
export LC_COLLATE="${LC_COLLATE:-C}"
export LC_TIME="${LC_TIME:-en_US.UTF-8}"
export LC_NUMERIC="${LC_NUMERIC:-en_US.UTF-8}"
export LC_MONETARY="${LC_MONETARY:-en_US.UTF-8}"
export LC_PAPER="${LC_PAPER:-en_US.UTF-8}"
export LC_NAME="${LC_NAME:-en_US.UTF-8}"
export LC_ADDRESS="${LC_ADDRESS:-en_US.UTF-8}"
export LC_TELEPHONE="${LC_TELEPHONE:-en_US.UTF-8}"
export LC_MEASUREMENT="${LC_MEASUREMENT:-en_US.UTF-8}"
export LC_IDENTIFICATION="${LC_IDENTIFICATION:-en_US.UTF-8}"

# Editors
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:-less}"
export BROWSER="${BROWSER:-xdg-open}"
export TERMINAL="${TERMINAL:-alacritty}"
export MANPAGER="${MANPAGER:-less}"
export MANWIDTH="${MANWIDTH:-80}"

# History
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE="${HISTSIZE:-50000}"
export SAVEHIST="${SAVEHIST:-100000}"
export HISTFILESIZE="${HISTFILESIZE:-100000}"
export HISTCONTROL="${HISTCONTROL:-ignoreboth:erasedups}"
export HISTIGNORE="${HISTIGNORE:-&:ls:ll:la:cd:pwd:exit:clear:reset:history}"
export HISTTIMEFORMAT="[%F %T] "

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"

# Development
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export GOBIN="${GOBIN:-$HOME/.go/bin}"
export GOROOT="${GOROOT:-$(go env GOROOT 2>/dev/null || true)}"
export GOPATH="${GOPATH:-$HOME/.go}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
export DENO_INSTALL_ROOT="${DENO_INSTALL_ROOT:-$HOME/.deno}"
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export YARN_CACHE_FOLDER="${YARN_CACHE_FOLDER:-$XDG_CACHE_HOME/yarn}"
export KREW_ROOT="${KREW_ROOT:-$HOME/.krew}"
export TF_PLUGIN_CACHE_DIR="${TF_PLUGIN_CACHE_DIR:-$HOME/.terraform.d/plugin-cache}"

# Language
export PYTHONDONTWRITEBYTECODE=1
export PIP_REQUIRE_VIRTUALENV=false
export RUST_BACKTRACE=1
export RUST_LOG="${RUST_LOG:-info}"
export GOFLAGS="${GOFLAGS:--mod=mod}"

# Tools
export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-rg --files --hidden --follow --no-ignore-vcs}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=16 --height=40% --layout=reverse --border}"
export BAT_THEME="${BAT_THEME:-Nord}"
export BAT_STYLE="${BAT_STYLE:-numbers,changes}"
export DELTA_FEATURES="${DELTA_FEATURES:-+line-numbers}"
export EZA_COLORS="${EZA_COLORS:-di=36:ex=32}"
export LESS="${LESS:-RFX}"
export LESSHISTFILE="${LESSHISTFILE:--}"
export SYSTEMD_PAGER="${SYSTEMD_PAGER:-less -RFX}"
export SYSTEMD_COLORS="${SYSTEMD_COLORS:-1}"

# Security
export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
export GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"

# Git
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PAGER="${GIT_PAGER:-delta}"
export GIT_SEQUENCE_EDITOR="${GIT_SEQUENCE_EDITOR:-nvim}"

# Docker
export DOCKER_BUILDKIT="${DOCKER_BUILDKIT:-1}"
export COMPOSE_DOCKER_CLI_BUILD="${COMPOSE_DOCKER_CLI_BUILD:-1}"
export DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM:-linux/amd64}"
export BUILDKIT_PROGRESS="${BUILDKIT_PROGRESS:-plain}"

# Misc
export TMPDIR="${TMPDIR:-/tmp}"
export MAILCHECK="${MAILCHECK:-0}"
export FIGNORE="${FIGNORE:-.o:~:.pyc:.swp}"
export PROMPT_DIRTRIM="${PROMPT_DIRTRIM:-3}"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export AWS_PAGER="${AWS_PAGER:-}"
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
export KUBE_EDITOR="${KUBE_EDITOR:-nvim}"
export HELM_CACHE_HOME="${HELM_CACHE_HOME:-$XDG_CACHE_HOME/helm}"
export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-$XDG_CONFIG_HOME/helm}"
export HELM_DATA_HOME="${HELM_DATA_HOME:-$XDG_DATA_HOME/helm}"
export TF_IN_AUTOMATION="${TF_IN_AUTOMATION:-1}"
export GH_EDITOR="${GH_EDITOR:-nvim}"
export GLAMOUR_STYLE="${GLAMOUR_STYLE:-dark}"
