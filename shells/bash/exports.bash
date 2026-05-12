#!/usr/bin/env bash
# Environment variables
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
[[ "$TERM" == "dumb" || -z "$TERM" ]] && export TERM=xterm-256color
export DOTFILES_MODE="${DOTFILES_MODE:-supreme}"

# Secure umask - files 0644, dirs 0755
umask 022

# History security
export HISTTIMEFORMAT="%F %T "

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

export LS_COLORS="di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"

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
export HISTFILE="${HISTFILE:-$HOME/.bash_history}"
export HISTSIZE="${HISTSIZE:-50000}"
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
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export NVM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvm"
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
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=true
export POETRY_VIRTUALENVS_CREATE=true
export RUST_BACKTRACE=1
export RUST_LOG="${RUST_LOG:-info}"
export GOFLAGS="${GOFLAGS:--mod=mod}"
export GOWORK="${GOWORK:-off}"

# Tools
export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-rg --files --hidden --follow --no-ignore-vcs}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=16 --height=40% --layout=reverse --border}"
export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-rg --files --hidden --follow --no-ignore-vcs}"
export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-find . -type d 2>/dev/null}"
export BAT_THEME="${BAT_THEME:-Nord}"
export BAT_STYLE="${BAT_STYLE:-numbers,changes}"
export DELTA_FEATURES="${DELTA_FEATURES:-+line-numbers}"
export EZA_COLORS="${EZA_COLORS:-di=36:ex=32}"
export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$HOME/.ripgreprc}"
export TREE_COLORS="${TREE_COLORS:-1}"
export TLDR_COLOR_NAME="${TLDR_COLOR_NAME:-cyan}"
export TLDR_COLOR_DESCRIPTION="${TLDR_COLOR_DESCRIPTION:-white}"
export TLDR_COLOR_EXAMPLE="${TLDR_COLOR_EXAMPLE:-green}"
export TLDR_COLOR_CODE="${TLDR_COLOR_CODE:-yellow}"

# Security
export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/ssh-agent.socket}"
export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
export GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"

# Misc
export TMPDIR="${TMPDIR:-/tmp}"
export TEMPDIR="${TEMPDIR:-/tmp}"
export MAILCHECK="${MAILCHECK:-0}"
export FIGNORE="${FIGNORE:-.o:~:.pyc:.swp}"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=auto
export PROMPT_DIRTRIM="${PROMPT_DIRTRIM:-3}"
export BASH_COMPLETION_COMPAT_DIR="${BASH_COMPLETION_COMPAT_DIR:-/etc/bash_completion.d}"
export SYSTEMD_PAGER="${SYSTEMD_PAGER:-less -RFX}"
export SYSTEMD_COLORS="${SYSTEMD_COLORS:-1}"
export JQ_COLORS="${JQ_COLORS:-0:31:0:0:0:32:0:0}"
export LESS="${LESS:-RFX}"
export LESSHISTFILE="${LESSHISTFILE:--}"
export PAGER="${PAGER:-less}"
export GIT_PAGER="${GIT_PAGER:-delta}"
export GIT_SEQUENCE_EDITOR="${GIT_SEQUENCE_EDITOR:-nvim}"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---no-quarantine}"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export AZURE_CORE_COLLECT_TELEMETRY=0
export AWS_REGION="${AWS_REGION:-us-east-1}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
export AWS_PAGER="${AWS_PAGER:-}"
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
export KUBE_EDITOR="${KUBE_EDITOR:-nvim}"
export HELM_EXPERIMENTAL_OCI=1
export HELM_CACHE_HOME="${HELM_CACHE_HOME:-$XDG_CACHE_HOME/helm}"
export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-$XDG_CONFIG_HOME/helm}"
export HELM_DATA_HOME="${HELM_DATA_HOME:-$XDG_DATA_HOME/helm}"
export TF_CLI_ARGS="${TF_CLI_ARGS:--no-color}"
export TF_IN_AUTOMATION="${TF_IN_AUTOMATION:-1}"
export TF_LOG="${TF_LOG:-}"
export PACKER_LOG="${PACKER_LOG:-0}"
export VAGRANT_HOME="${VAGRANT_HOME:-$HOME/.vagrant.d}"
export MINIKUBE_HOME="${MINIKUBE_HOME:-$HOME/.minikube}"
export SKOPEO_DEPS="${SKOPEO_DEPS:-none}"
export DOCKER_BUILDKIT="${DOCKER_BUILDKIT:-1}"
export COMPOSE_DOCKER_CLI_BUILD="${COMPOSE_DOCKER_CLI_BUILD:-1}"
export DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM:-linux/amd64}"
export DOCKER_SCAN_SUGGEST="${DOCKER_SCAN_SUGGEST:-false}"
export BUILDKIT_PROGRESS="${BUILDKIT_PROGRESS:-plain}"
export GRADLE_OPTS="${GRADLE_OPTS:--Dorg.gradle.daemon=true -Dorg.gradle.parallel=true}"
export MAVEN_OPTS="${MAVEN_OPTS:--Dmaven.artifact.threads=4}"
export JAVA_OPTS="${JAVA_OPTS:--Xmx2g}"
export SBT_OPTS="${SBT_OPTS:--Xmx2g}"
export NODE_OPTIONS="${NODE_OPTIONS:---max-old-space-size=4096}"
export ELECTRON_OZONE_PLATFORM_HINT="${ELECTRON_OZONE_PLATFORM_HINT:-auto}"
export CHROME_EXECUTABLE="${CHROME_EXECUTABLE:-/usr/bin/chromium}"
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-$ANDROID_HOME}"
export FLUTTER_ROOT="${FLUTTER_ROOT:-/opt/flutter}"
export GH_EDITOR="${GH_EDITOR:-nvim}"
export GLAMOUR_STYLE="${GLAMOUR_STYLE:-dark}"
export GITLAB_API_VERSION="${GITLAB_API_VERSION:-4}"
export GITHUB_TOKEN="${GITHUB_TOKEN:-}"
export GITLAB_TOKEN="${GITLAB_TOKEN:-}"
