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

# =============================================================================
# CONDITIONAL APPLICATION EXPORTS
# =============================================================================
#
# Sections below configure env vars for apps detected on the system. Each
# section is guarded by command -v and uses the ${VAR:-default} pattern.
#
# =============================================================================
# EDITORS
# =============================================================================

# --- nvim — extensible, modern Vim-based text editor ---
# Neovim is a refactored fork of Vim with async plugins and LSP support.
# NVIM_APPNAME — multiple config profiles, default: nvim
# NVIM_LOG_FILE — debug log file
# VIMCONFIG — config directory
if command -v nvim >/dev/null 2>&1; then
    export NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
    export NVIM_LOG_FILE="${NVIM_LOG_FILE:-$XDG_STATE_HOME/nvim/log}"
    export VIMCONFIG="${VIMCONFIG:-$XDG_CONFIG_HOME/nvim}"
fi

# --- vim — highly configurable terminal text editor ---
# Vim is built on vi with an extensive plugin ecosystem.
# VIM — system runtime files
# VIMRUNTIME — runtime directory
# VIMINIT — initialization commands
if command -v vim >/dev/null 2>&1; then
    export VIM="${VIM:-/usr/share/vim}"
    export VIMRUNTIME="${VIMRUNTIME:-$VIM/vim91}"
    export VIMINIT="${VIMINIT:-}"
fi

# --- emacs — extensible text editor and computing environment ---
# Emacs provides deep extensibility via Emacs Lisp and package management.
# EMACS — t when running inside Emacs
# INSIDE_EMACS — version info for terminal emulation
# EMACSDATA — data files
# EMACSDOC — documentation files
if command -v emacs >/dev/null 2>&1; then
    export EMACS="${EMACS:-t}"
    export INSIDE_EMACS="${INSIDE_EMACS:-$EMACS}"
    export EMACSDATA="${EMACSDATA:-/usr/share/emacs}"
    export EMACSDOC="${EMACSDOC:-/usr/share/emacs/doc}"
fi

# --- code — Visual Studio Code editor ---
# VS Code is a cross-platform editor with integrated debugging and extensions.
# VSCODE_CLI — CLI integration, default: 1
# SERVICE_URL — extension gallery URL (open-source builds)
# ITEM_URL — extension item URL
if command -v code >/dev/null 2>&1; then
    export VSCODE_CLI="${VSCODE_CLI:-1}"
    export SERVICE_URL="${SERVICE_URL:-https://open-vsx.org/vscode/gallery}"
    export ITEM_URL="${ITEM_URL:-https://open-vsx.org/vscode/item}"
fi

# =============================================================================
# RUNTIMES
# =============================================================================

# --- go — compiled, concurrent programming language ---
# Go is statically typed with concurrency primitives and a robust stdlib.
# GOPATH — workspace, default: $HOME/.go
# GOBIN — binaries directory
# GOPROXY — module proxy
# GOMODCACHE — cached modules
# CGO_ENABLED — C interop, default: 1
if command -v go >/dev/null 2>&1; then
    export GOPATH="${GOPATH:-$HOME/.go}"
    export GOBIN="${GOBIN:-$GOPATH/bin}"
    export GOPROXY="${GOPROXY:-https://proxy.golang.org,direct}"
    export GOMODCACHE="${GOMODCACHE:-$GOPATH/pkg/mod}"
    export CGO_ENABLED="${CGO_ENABLED:-1}"
    export PATH="$GOBIN${PATH:+:$PATH}"
fi

# --- rustc — systems programming language ---
# Rust emphasizes performance, type safety, and memory safety.
# CARGO_HOME — Cargo home, default: $HOME/.cargo
# RUSTUP_HOME — rustup home, default: $HOME/.rustup
# CARGO_TARGET_DIR — default build output
# CARGO_NET_GIT_FETCH_WITH_CLI — use git CLI for fetch, default: true
if command -v rustc >/dev/null 2>&1; then
    export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
    export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
    export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-}"
    export CARGO_NET_GIT_FETCH_WITH_CLI="${CARGO_NET_GIT_FETCH_WITH_CLI:-true}"
    export PATH="$CARGO_HOME/bin${PATH:+:$PATH}"
fi

# --- node — JavaScript runtime built on V8 ---
# Node.js is a cross-platform JS runtime for server-side applications.
# NODE_REPL_HISTORY — REPL history file
# NPM_CONFIG_CACHE — npm cache
# NPM_CONFIG_PREFIX — global install prefix
if command -v node >/dev/null 2>&1; then
    export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/repl_history}"
    export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"
    export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.npm-global}"
    export PATH="$NPM_CONFIG_PREFIX/bin${PATH:+:$PATH}"
fi

# --- python3 — high-level, general-purpose programming language ---
# Python is versatile with an extensive standard library.
# PYTHONSTARTUP — startup script
# PYTHONPYCACHEPREFIX — .pyc cache directory
# PYTHONDONTWRITEBYTECODE — suppress .pyc, default: 1
# PIP_CACHE_DIR — pip cache
# PYTHON_HISTORY — REPL history
if command -v python3 >/dev/null 2>&1; then
    export PYTHONSTARTUP="${PYTHONSTARTUP:-$XDG_CONFIG_HOME/python/pythonrc}"
    export PYTHONPYCACHEPREFIX="${PYTHONPYCACHEPREFIX:-$XDG_CACHE_HOME/python}"
    export PYTHONDONTWRITEBYTECODE="${PYTHONDONTWRITEBYTECODE:-1}"
    export PIP_CACHE_DIR="${PIP_CACHE_DIR:-$XDG_CACHE_HOME/pip}"
    export PYTHON_HISTORY="${PYTHON_HISTORY:-$XDG_STATE_HOME/python/history}"
fi

# --- ruby — dynamic, reflective programming language ---
# Ruby focuses on simplicity and productivity with elegant syntax.
# GEM_HOME — gem install directory, default: $HOME/.gem
# GEM_PATH — gem search path
# RBENV_ROOT — rbenv root
# BUNDLE_USER_CONFIG — per-user Bundler config
# BUNDLE_USER_CACHE — per-user Bundler cache
if command -v ruby >/dev/null 2>&1; then
    export GEM_HOME="${GEM_HOME:-$HOME/.gem}"
    export GEM_PATH="${GEM_PATH:-$GEM_HOME}"
    export RBENV_ROOT="${RBENV_ROOT:-$XDG_DATA_HOME/rbenv}"
    export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
    export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
    export PATH="$GEM_HOME/bin${PATH:+:$PATH}"
fi

# --- java — class-based, object-oriented programming language ---
# Java is a JVM language for portable applications with build tool ecosystem.
# JAVA_HOME — JDK root
# _JAVA_OPTIONS — default JVM flags
# GRADLE_OPTS — Gradle daemon options
# MAVEN_OPTS — Maven threads
if command -v java >/dev/null 2>&1; then
    export JAVA_HOME="${JAVA_HOME:-$(dirname "$(dirname "$(readlink -f "$(which java)")")")}"
    export _JAVA_OPTIONS="${_JAVA_OPTIONS:--Djava.awt.headless=true}"
    export GRADLE_OPTS="${GRADLE_OPTS:--Dorg.gradle.daemon=true -Dorg.gradle.parallel=true}"
    export MAVEN_OPTS="${MAVEN_OPTS:--Dmaven.artifact.threads=4}"
fi

# --- julia — high-level, high-performance technical computing language ---
# Julia is a dynamic language for numerical analysis and scientific computing.
# JULIA_DEPOT_PATH — package depot
# JULIA_PROJECT — default project environment
# JULIA_NUM_THREADS — thread count for parallelism
# JULIA_EDITOR — REPL editor
if command -v julia >/dev/null 2>&1; then
    export JULIA_DEPOT_PATH="${JULIA_DEPOT_PATH:-$XDG_DATA_HOME/julia}"
    export JULIA_PROJECT="${JULIA_PROJECT:-@.}"
    export JULIA_NUM_THREADS="${JULIA_NUM_THREADS:-$(nproc 2>/dev/null || echo 4)}"
    export JULIA_EDITOR="${JULIA_EDITOR:-$EDITOR}"
fi

# =============================================================================
# CONTAINERS
# =============================================================================

# --- docker — container management platform ---
# Docker provides OS-level virtualization in isolated container environments.
# DOCKER_HOST — daemon socket, default: unix:///run/user/$UID/docker.sock
# DOCKER_CONFIG — config directory
# DOCKER_CONTENT_TRUST — content trust verification, default: 0
# DOCKER_CERT_PATH — TLS certificates
# DOCKER_TMPDIR — temp files
if command -v docker >/dev/null 2>&1; then
    export DOCKER_HOST="${DOCKER_HOST:-unix:///run/user/$UID/docker.sock}"
    export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
    export DOCKER_CONTENT_TRUST="${DOCKER_CONTENT_TRUST:-0}"
    export DOCKER_CERT_PATH="${DOCKER_CERT_PATH:-$DOCKER_CONFIG/certs}"
    export DOCKER_TMPDIR="${DOCKER_TMPDIR:-$XDG_CACHE_HOME/docker}"
fi

# --- podman — daemonless container engine ---
# Podman provides a Docker-compatible CLI without a daemon, rootless.
# DOCKER_HOST — Docker-compatible socket (podman socket)
# PODMAN_IGNORE_CGROUPSV1_WARNING — suppress cgroup warnings
if command -v podman >/dev/null 2>&1; then
    export DOCKER_HOST="${DOCKER_HOST:-unix://$XDG_RUNTIME_DIR/podman/podman.sock}"
    export PODMAN_IGNORE_CGROUPSV1_WARNING="${PODMAN_IGNORE_CGROUPSV1_WARNING:-0}"
fi

# --- nerdctl — Docker-compatible CLI for containerd ---
# nerdctl supports lazy-pulling, rootless mode, and encrypted images.
# CONTAINERD_ADDRESS — containerd socket
# CONTAINERD_NAMESPACE — namespace, default: default
if command -v nerdctl >/dev/null 2>&1; then
    export CONTAINERD_ADDRESS="${CONTAINERD_ADDRESS:-/run/containerd/containerd.sock}"
    export CONTAINERD_NAMESPACE="${CONTAINERD_NAMESPACE:-default}"
fi

# --- skopeo — container image inspection and transfer ---
# Skopeo inspects/copies images without requiring a container runtime.
# SKOPEO_CERT_DIR — TLS certificates
# SKOPEO_POLICY — policy JSON path
if command -v skopeo >/dev/null 2>&1; then
    export SKOPEO_CERT_DIR="${SKOPEO_CERT_DIR:-/etc/containers/certs.d}"
    export SKOPEO_POLICY="${SKOPEO_POLICY:-/etc/containers/policy.json}"
fi

# =============================================================================
# ORCHESTRATION
# =============================================================================

# --- kubectl — Kubernetes CLI ---
# kubectl manages Kubernetes clusters with resource creation and debugging.
# KUBECONFIG — config file, default: $HOME/.kube/config
# KUBE_EDITOR — resource editor
# KUBECTL_EXTERNAL_DIFF — external diff command
# KUBE_CACHEDIR — cache directory
if command -v kubectl >/dev/null 2>&1; then
    export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
    export KUBE_EDITOR="${KUBE_EDITOR:-nvim}"
    export KUBECTL_EXTERNAL_DIFF="${KUBECTL_EXTERNAL_DIFF:-diff}"
    export KUBE_CACHEDIR="${KUBE_CACHEDIR:-$XDG_CACHE_HOME/kube}"
fi

# --- helm — Kubernetes package manager ---
# Helm manages K8s apps through Charts with templating and dependencies.
# HELM_CACHE_HOME — cache directory
# HELM_CONFIG_HOME — config directory
# HELM_DATA_HOME — data directory
# HELM_KUBECONTEXT — default context
# HELM_DRIVER — storage driver (secret, configmap, sql)
if command -v helm >/dev/null 2>&1; then
    export HELM_CACHE_HOME="${HELM_CACHE_HOME:-$XDG_CACHE_HOME/helm}"
    export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-$XDG_CONFIG_HOME/helm}"
    export HELM_DATA_HOME="${HELM_DATA_HOME:-$XDG_DATA_HOME/helm}"
    export HELM_KUBECONTEXT="${HELM_KUBECONTEXT:-}"
    export HELM_DRIVER="${HELM_DRIVER:-secret}"
fi

# --- k9s — terminal UI for Kubernetes ---
# k9s provides a terminal dashboard for K8s monitoring and editing.
# K9S_CONFIG_DIR — config directory
# K9S_CACHE_DIR — cluster data cache
if command -v k9s >/dev/null 2>&1; then
    export K9S_CONFIG_DIR="${K9S_CONFIG_DIR:-$XDG_CONFIG_HOME/k9s}"
    export K9S_CACHE_DIR="${K9S_CACHE_DIR:-$XDG_CACHE_HOME/k9s}"
fi

# --- kustomize — Kubernetes config customization ---
# kustomize provides template-free YAML customization via overlays.
# KUSTOMIZE_PLUGIN_HOME — plugin directory
# KUSTOMIZE_CONFIG_HOME — config directory
if command -v kustomize >/dev/null 2>&1; then
    export KUSTOMIZE_PLUGIN_HOME="${KUSTOMIZE_PLUGIN_HOME:-$XDG_CONFIG_HOME/kustomize/plugin}"
    export KUSTOMIZE_CONFIG_HOME="${KUSTOMIZE_CONFIG_HOME:-$XDG_CONFIG_HOME/kustomize}"
fi

# --- argocd — declarative GitOps CD for Kubernetes ---
# Argo CD deploys K8s apps using Git repos as the source of truth.
# ARGOCD_SERVER — server address
# ARGOCD_OPTS — CLI options (--grpc-web)
# ARGOCD_AUTH_TOKEN — auth token
if command -v argocd >/dev/null 2>&1; then
    export ARGOCD_SERVER="${ARGOCD_SERVER:-}"
    export ARGOCD_OPTS="${ARGOCD_OPTS:---grpc-web}"
    export ARGOCD_AUTH_TOKEN="${ARGOCD_AUTH_TOKEN:-}"
fi

# =============================================================================
# CLOUD PLATFORMS
# =============================================================================

# --- aws — Amazon Web Services CLI ---
# AWS CLI manages AWS services, IAM authentication, and infrastructure.
# AWS_CONFIG_FILE — config file
# AWS_SHARED_CREDENTIALS_FILE — credentials file
# AWS_PROFILE — profile name, default: default
# AWS_DEFAULT_OUTPUT — output format, default: json
# AWS_DEFAULT_REGION — default region
if command -v aws >/dev/null 2>&1; then
    export AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-$XDG_CONFIG_HOME/aws/config}"
    export AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-$XDG_CONFIG_HOME/aws/credentials}"
    export AWS_PROFILE="${AWS_PROFILE:-default}"
    export AWS_DEFAULT_OUTPUT="${AWS_DEFAULT_OUTPUT:-json}"
    export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
fi

# --- gcloud — Google Cloud CLI ---
# gcloud manages GCP resources including Compute Engine and GKE.
# CLOUDSDK_CONFIG — SDK config directory
# CLOUDSDK_CORE_PROJECT — default project
# CLOUDSDK_COMPUTE_REGION — default region
# CLOUDSDK_COMPUTE_ZONE — default zone
if command -v gcloud >/dev/null 2>&1; then
    export CLOUDSDK_CONFIG="${CLOUDSDK_CONFIG:-$XDG_CONFIG_HOME/gcloud}"
    export CLOUDSDK_CORE_PROJECT="${CLOUDSDK_CORE_PROJECT:-}"
    export CLOUDSDK_COMPUTE_REGION="${CLOUDSDK_COMPUTE_REGION:-}"
    export CLOUDSDK_COMPUTE_ZONE="${CLOUDSDK_COMPUTE_ZONE:-}"
fi

# --- terraform — HashiCorp infrastructure as code ---
# Terraform provisions infrastructure across providers via config files.
# TF_PLUGIN_CACHE_DIR — provider plugin cache
# TF_CLI_ARGS — CLI arguments (--no-color)
# TF_IN_AUTOMATION — automation flag, default: 1
# TF_LOG — log verbosity
# TF_WORKSPACE — workspace name
if command -v terraform >/dev/null 2>&1; then
    export TF_PLUGIN_CACHE_DIR="${TF_PLUGIN_CACHE_DIR:-$XDG_CACHE_HOME/terraform/plugins}"
    export TF_CLI_ARGS="${TF_CLI_ARGS:--no-color}"
    export TF_IN_AUTOMATION="${TF_IN_AUTOMATION:-1}"
    export TF_LOG="${TF_LOG:-}"
    export TF_WORKSPACE="${TF_WORKSPACE:-default}"
fi

# --- vault — HashiCorp secrets management ---
# Vault provides secure access to secrets and encryption keys.
# VAULT_ADDR — server address, default: https://127.0.0.1:8200
# VAULT_TOKEN — auth token
# VAULT_CAPATH — CA cert path
# VAULT_SKIP_VERIFY — TLS skip verify
# VAULT_NAMESPACE — Enterprise namespace
if command -v vault >/dev/null 2>&1; then
    export VAULT_ADDR="${VAULT_ADDR:-https://127.0.0.1:8200}"
    export VAULT_TOKEN="${VAULT_TOKEN:-}"
    export VAULT_CAPATH="${VAULT_CAPATH:-}"
    export VAULT_SKIP_VERIFY="${VAULT_SKIP_VERIFY:-}"
    export VAULT_NAMESPACE="${VAULT_NAMESPACE:-}"
fi

# =============================================================================
# CI/CD
# =============================================================================

# --- gh — GitHub CLI ---
# The GitHub CLI brings PRs, issues, and actions to the terminal.
# GH_CONFIG_DIR — config directory
# GH_EDITOR — editor for GH interactions
# GH_HOST — GitHub host, default: github.com
# GH_PAGER — output pager
if command -v gh >/dev/null 2>&1; then
    export GH_CONFIG_DIR="${GH_CONFIG_DIR:-$XDG_CONFIG_HOME/gh}"
    export GH_EDITOR="${GH_EDITOR:-nvim}"
    export GH_HOST="${GH_HOST:-github.com}"
    export GH_PAGER="${GH_PAGER:-less}"
fi

# --- glab — GitLab CLI ---
# The GitLab CLI brings MRs, issues, and pipelines to the terminal.
# GLAMOUR_STYLE — Markdown render style, default: dark
# GITLAB_API_VERSION — API version, default: 4
# GLAB_CONFIG_DIR — config directory
if command -v glab >/dev/null 2>&1; then
    export GLAMOUR_STYLE="${GLAMOUR_STYLE:-dark}"
    export GITLAB_API_VERSION="${GITLAB_API_VERSION:-4}"
    export GLAB_CONFIG_DIR="${GLAB_CONFIG_DIR:-$XDG_CONFIG_HOME/glab}"
fi

# =============================================================================
# DATABASES
# =============================================================================

# --- mysql — MySQL database client ---
# MySQL is an open-source relational database with ACID compliance.
# MYSQL_HISTFILE — client history
# MYSQL_HOST — server host, default: localhost
# MYSQL_TCP_PORT — TCP port, default: 3306
# MYSQL_UNIX_PORT — Unix socket
# MYSQL_PS1 — prompt format
if command -v mysql >/dev/null 2>&1; then
    export MYSQL_HISTFILE="${MYSQL_HISTFILE:-$XDG_DATA_HOME/mysql/history}"
    export MYSQL_HOST="${MYSQL_HOST:-localhost}"
    export MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-3306}"
    export MYSQL_UNIX_PORT="${MYSQL_UNIX_PORT:-/run/mysqld/mysqld.sock}"
    export MYSQL_PS1="${MYSQL_PS1:-\\u@\\h [\\d]> }"
fi

# --- psql — PostgreSQL interactive terminal ---
# PostgreSQL is an object-relational database with advanced features.
# PGHOST — server host, default: localhost
# PGPORT — server port, default: 5432
# PGDATABASE — default database
# PGUSER — default user
# PGPASSFILE — password file
# PSQL_HISTORY — psql history
if command -v psql >/dev/null 2>&1; then
    export PGHOST="${PGHOST:-localhost}"
    export PGPORT="${PGPORT:-5432}"
    export PGDATABASE="${PGDATABASE:-}"
    export PGUSER="${PGUSER:-$USER}"
    export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
    export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_DATA_HOME/psql/history}"
fi

# --- sqlite3 — SQLite database CLI ---
# SQLite is a self-contained, serverless SQL database engine.
# SQLITE_HISTORY — CLI history
# SQLITE_TMPDIR — temporary files
if command -v sqlite3 >/dev/null 2>&1; then
    export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"
    export SQLITE_TMPDIR="${SQLITE_TMPDIR:-$TMPDIR}"
fi

# --- redis-cli — Redis command-line client ---
# Redis is an in-memory data structure store for caching and messaging.
# REDISCLI_HISTFILE — CLI history
# REDISCLI_HISTFILESIZE — max history entries, default: 10000
# REDISCLI_AUTH — default auth password
# REDISCLI_RAW — raw output mode
if command -v redis-cli >/dev/null 2>&1; then
    export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-$XDG_DATA_HOME/redis/history}"
    export REDISCLI_HISTFILESIZE="${REDISCLI_HISTFILESIZE:-10000}"
    export REDISCLI_AUTH="${REDISCLI_AUTH:-}"
    export REDISCLI_RAW="${REDISCLI_RAW:-}"
fi

# =============================================================================
# MONITORING
# =============================================================================

# --- btop — modern terminal resource monitor ---
# btop has mouse support, custom themes, and configurable displays.
# BTOP_CONFIG_DIR — config and themes directory
if command -v btop >/dev/null 2>&1; then
    export BTOP_CONFIG_DIR="${BTOP_CONFIG_DIR:-$XDG_CONFIG_HOME/btop}"
fi

# --- htop — interactive process viewer ---
# htop has tree view, mouse support, and configurable columns.
# HTOPRC — configuration file
if command -v htop >/dev/null 2>&1; then
    export HTOPRC="${HTOPRC:-$XDG_CONFIG_HOME/htop/htoprc}"
fi

# =============================================================================
# NETWORK TOOLS
# =============================================================================

# --- nmap — network discovery and security scanner ---
# Nmap discovers hosts/services on networks with OS detection.
# NMAPDIR — data directory
# NMAP_PRIVILEGED — privileged scans
if command -v nmap >/dev/null 2>&1; then
    export NMAPDIR="${NMAPDIR:-$XDG_DATA_HOME/nmap}"
    export NMAP_PRIVILEGED="${NMAP_PRIVILEGED:-}"
fi

# --- ngrok — secure tunnel to localhost ---
# ngrok exposes local servers to the internet via secure tunnels.
# NGROK_CONFIG — config file
# NGROK_AUTHTOKEN — auth token
# NGROK_REGION — edge region (us, eu, ap, au, sa), default: us
# NGROK_ROOT — data directory
if command -v ngrok >/dev/null 2>&1; then
    export NGROK_CONFIG="${NGROK_CONFIG:-$XDG_CONFIG_HOME/ngrok/ngrok.yml}"
    export NGROK_AUTHTOKEN="${NGROK_AUTHTOKEN:-}"
    export NGROK_REGION="${NGROK_REGION:-us}"
    export NGROK_ROOT="${NGROK_ROOT:-$XDG_DATA_HOME/ngrok}"
fi

# =============================================================================
# FILE MANAGEMENT
# =============================================================================

# --- yazi — blazing fast terminal file manager ---
# Yazi is a Rust-based file manager with async I/O and image previews.
# YAZI_CONFIG_DIR — configuration directory
# YAZI_CACHE_DIR — thumbnail cache directory
if command -v yazi >/dev/null 2>&1; then
    export YAZI_CONFIG_DIR="${YAZI_CONFIG_DIR:-$XDG_CONFIG_HOME/yazi}"
    export YAZI_CACHE_DIR="${YAZI_CACHE_DIR:-$XDG_CACHE_HOME/yazi}"
fi

# --- nnn — fast terminal file manager ---
# nnn is a tiny file manager with disk usage analysis and plugins.
# NNN_OPTS — CLI options (d for detail mode)
# NNN_BMS — bookmark key-value pairs
# NNN_USE_EDITOR — open in $EDITOR, default: 1
# NNN_TRASH — use trash-cli, default: 1
# NNN_PLUG — plugin key-value pairs
if command -v nnn >/dev/null 2>&1; then
    export NNN_OPTS="${NNN_OPTS:-d}"
    export NNN_BMS="${NNN_BMS:-}"
    export NNN_USE_EDITOR="${NNN_USE_EDITOR:-1}"
    export NNN_TRASH="${NNN_TRASH:-1}"
    export NNN_PLUG="${NNN_PLUG:-}"
fi

# --- mc — Midnight Commander ---
# MC is a text-mode file manager with a two-panel interface.
# MC_COLOR_TABLE — color theme, default: gotar
# MC_SKIN — skin file
# MC_EDITOR — default editor
# MC_DIFF_VIEWER — external diff viewer
if command -v mc >/dev/null 2>&1; then
    export MC_COLOR_TABLE="${MC_COLOR_TABLE:-gotar}"
    export MC_SKIN="${MC_SKIN:-}"
    export MC_EDITOR="${MC_EDITOR:-$EDITOR}"
    export MC_DIFF_VIEWER="${MC_DIFF_VIEWER:-diff}"
fi

# =============================================================================
# SECURITY
# =============================================================================

# --- gpg — GNU Privacy Guard encryption and signing ---
# GnuPG implements OpenPGP for encrypting, signing, and verifying data.
# GPG_TTY — TTY for passphrase prompts
# GNUPGHOME — GPG home, default: $HOME/.gnupg
if command -v gpg >/dev/null 2>&1; then
    export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
    export GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"
fi

# --- openssl — cryptography and SSL/TLS toolkit ---
# OpenSSL provides encryption, certificates, and TLS protocol support.
# OPENSSL_CONF — config file, default: /etc/ssl/openssl.cnf
# OPENSSL_ENGINES — engine modules directory
# OPENSSL_MODULES — loadable module directory
if command -v openssl >/dev/null 2>&1; then
    export OPENSSL_CONF="${OPENSSL_CONF:-/etc/ssl/openssl.cnf}"
    export OPENSSL_ENGINES="${OPENSSL_ENGINES:-/usr/lib/x86_64-linux-gnu/engines-3}"
    export OPENSSL_MODULES="${OPENSSL_MODULES:-/usr/lib/x86_64-linux-gnu/ossl-modules}"
fi

# --- age — simple, modern file encryption ---
# age uses modern cryptography with small, explicit keys.
# AGE_KEY_FILE — identity (private key) file
# AGE_DIR — key storage directory
if command -v age >/dev/null 2>&1; then
    export AGE_KEY_FILE="${AGE_KEY_FILE:-$XDG_CONFIG_HOME/age/keys.txt}"
    export AGE_DIR="${AGE_DIR:-$XDG_CONFIG_HOME/age}"
fi

# --- sops — secrets encryption for files ---
# SOPS encrypts YAML/JSON using KMS, age, or PGP backends.
# SOPS_AGE_KEY_FILE — age key for SOPS
# SOPS_KMS_ARN — AWS KMS ARN
# SOPS_GCP_KMS — GCP KMS resource ID
# SOPS_PGP_FP — PGP fingerprint
if command -v sops >/dev/null 2>&1; then
    export SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:-$AGE_KEY_FILE}"
    export SOPS_KMS_ARN="${SOPS_KMS_ARN:-}"
    export SOPS_GCP_KMS="${SOPS_GCP_KMS:-}"
    export SOPS_PGP_FP="${SOPS_PGP_FP:-}"
fi

# --- trivy — comprehensive security scanner ---
# Trivy scans containers, filesystems, and repos for vulnerabilities.
# TRIVY_CACHE_DIR — cache directory
# TRIVY_CONFIG_DIR — config directory
# TRIVY_DB_REPOSITORY — vulnerability DB repo
# TRIVY_SKIP_DB_UPDATE — skip DB update, default: false
# TRIVY_SEVERITY — severity filter, default: UNKNOWN,HIGH,CRITICAL
if command -v trivy >/dev/null 2>&1; then
    export TRIVY_CACHE_DIR="${TRIVY_CACHE_DIR:-$XDG_CACHE_HOME/trivy}"
    export TRIVY_CONFIG_DIR="${TRIVY_CONFIG_DIR:-$XDG_CONFIG_HOME/trivy}"
    export TRIVY_DB_REPOSITORY="${TRIVY_DB_REPOSITORY:-ghcr.io/aquasecurity/trivy-db}"
    export TRIVY_SKIP_DB_UPDATE="${TRIVY_SKIP_DB_UPDATE:-false}"
    export TRIVY_SEVERITY="${TRIVY_SEVERITY:-UNKNOWN,HIGH,CRITICAL}"
fi

# =============================================================================
# DEV TOOLS
# =============================================================================

# --- jq — lightweight command-line JSON processor ---
# jq queries and transforms JSON with a sed-like expression language.
# JQ_COLORS — color scheme for JSON output
# JQ_LIBRARY_PATH — module import paths
if command -v jq >/dev/null 2>&1; then
    export JQ_COLORS="${JQ_COLORS:-0:31:0:0:0:32:0:0}"
    export JQ_LIBRARY_PATH="${JQ_LIBRARY_PATH:-$XDG_DATA_HOME/jq}"
fi

# --- fzf — command-line fuzzy finder ---
# fzf provides interactive filtering for files, histories, and processes.
# FZF_DEFAULT_COMMAND — file search command
# FZF_DEFAULT_OPTS — options (colors, height, layout)
# FZF_CTRL_T_COMMAND — Ctrl-T file search
# FZF_ALT_C_COMMAND — Alt-C directory search
# FZF_TMUX_OPTS — tmux split options
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-fd --type f --hidden --follow --exclude .git}"
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=16 --height=40% --layout=reverse --border}"
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-fd --type f --hidden --follow --exclude .git}"
    export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-fd --type d --hidden --follow --exclude .git}"
    export FZF_TMUX_OPTS="${FZF_TMUX_OPTS:--p 55%,60%}"
fi

# --- bat — cat clone with syntax highlighting ---
# bat extends cat with Git integration, paging, and file previews.
# BAT_THEME — highlighting theme, default: Nord
# BAT_STYLE — output style (numbers, changes, header)
# BAT_CONFIG_PATH — config file
# BAT_PAGER — pager, default: less -RFX
# BAT_CACHE_DIR — syntax cache
if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="${BAT_THEME:-Nord}"
    export BAT_STYLE="${BAT_STYLE:-numbers,changes}"
    export BAT_CONFIG_PATH="${BAT_CONFIG_PATH:-$XDG_CONFIG_HOME/bat/config}"
    export BAT_PAGER="${BAT_PAGER:-less -RFX}"
    export BAT_CACHE_DIR="${BAT_CACHE_DIR:-$XDG_CACHE_HOME/bat}"
fi

# --- rg — ripgrep, line-oriented search ---
# ripgrep recursively searches directories for regex patterns.
# RIPGREP_CONFIG_PATH — config for default options
if command -v rg >/dev/null 2>&1; then
    export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgreprc}"
fi

# --- fd — fast find alternative ---
# fd is a user-friendly alternative to find with sensible defaults.
# FD_CONFIG_PATH — fdignore path
# FD_CACHE_DIR — cache directory
if command -v fd >/dev/null 2>&1; then
    export FD_CONFIG_PATH="${FD_CONFIG_PATH:-$XDG_CONFIG_HOME/fd/fdignore}"
    export FD_CACHE_DIR="${FD_CACHE_DIR:-$XDG_CACHE_HOME/fd}"
fi

# --- eza — modern, maintained ls replacement ---
# eza improves on ls with Git integration, colors, and tree view.
# EZA_COLORS — color scheme for file types
# EZA_CONFIG_DIR — config directory
# TIME_STYLE — date format (long-iso, iso, etc.)
if command -v eza >/dev/null 2>&1; then
    export EZA_COLORS="${EZA_COLORS:-di=36:ex=32}"
    export EZA_CONFIG_DIR="${EZA_CONFIG_DIR:-$XDG_CONFIG_HOME/eza}"
    export TIME_STYLE="${TIME_STYLE:-long-iso}"
fi

# --- zoxide — smarter cd command ---
# zoxide learns your directories and enables instant frecency navigation.
# _ZO_DATA_DIR — database directory
# _ZO_EXCLUDE_DIRS — excluded directories
# _ZO_RESOLVE_SYMLINKS — resolve symlinks, default: 0
# _ZO_ECHO — echo matched directory
if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DATA_DIR="${_ZO_DATA_DIR:-$XDG_DATA_HOME/zoxide}"
    export _ZO_EXCLUDE_DIRS="${_ZO_EXCLUDE_DIRS:-/:/home/*/go/pkg}"
    export _ZO_RESOLVE_SYMLINKS="${_ZO_RESOLVE_SYMLINKS:-0}"
    export _ZO_ECHO="${_ZO_ECHO:-0}"
fi

# --- starship — minimal, customizable prompt ---
# Starship provides a shell-agnostic prompt with module-based display.
# STARSHIP_CONFIG — config file (TOML), default: ~/.config/starship.toml
# STARSHIP_CACHE — cache directory
# STARSHIP_SHELL — shell type (bash, zsh, fish)
if command -v starship >/dev/null 2>&1; then
    export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship.toml}"
    export STARSHIP_CACHE="${STARSHIP_CACHE:-$XDG_CACHE_HOME/starship}"
    export STARSHIP_SHELL="${STARSHIP_SHELL:-bash}"
fi

# =============================================================================
# MEDIA TOOLS
# =============================================================================

# --- ffmpeg — complete multimedia framework ---
# FFmpeg records, converts, and streams audio/video with 100+ codecs.
# FFMPEG_DATADIR — data files directory
# FFREPORT — report logging
# AV_LOG_FORCE_NOCOLOR — disable colored logs
if command -v ffmpeg >/dev/null 2>&1; then
    export FFMPEG_DATADIR="${FFMPEG_DATADIR:-$XDG_DATA_HOME/ffmpeg}"
    export FFREPORT="${FFREPORT:-}"
    export AV_LOG_FORCE_NOCOLOR="${AV_LOG_FORCE_NOCOLOR:-0}"
fi

# --- yt-dlp — feature-rich video downloader ---
# yt-dlp downloads video from YouTube and hundreds of other sites.
# YT_DLP_CONFIG_HOME — config directory
# YT_DLP_CACHE_DIR — cache directory
# YT_DLP_EXTERNAL_DOWNLOADER — external downloader (aria2c, ffmpeg)
if command -v yt-dlp >/dev/null 2>&1; then
    export YT_DLP_CONFIG_HOME="${YT_DLP_CONFIG_HOME:-$XDG_CONFIG_HOME/yt-dlp}"
    export YT_DLP_CACHE_DIR="${YT_DLP_CACHE_DIR:-$XDG_CACHE_HOME/yt-dlp}"
    export YT_DLP_EXTERNAL_DOWNLOADER="${YT_DLP_EXTERNAL_DOWNLOADER:-}"
fi

# --- mpv — cross-platform media player ---
# mpv is a free media player with GPU video output and Lua scripting.
# MPV_HOME — config and data directory
# MPV_SCRIPT_OPTS — script configuration
# MPV_CONFIG_DIR — config files
if command -v mpv >/dev/null 2>&1; then
    export MPV_HOME="${MPV_HOME:-$XDG_CONFIG_HOME/mpv}"
    export MPV_SCRIPT_OPTS="${MPV_SCRIPT_OPTS:-}"
    export MPV_CONFIG_DIR="${MPV_CONFIG_DIR:-$XDG_CONFIG_HOME/mpv}"
fi

# --- magick — ImageMagick image manipulation ---
# ImageMagick creates, edits, and converts bitmap images (200+ formats).
# MAGICK_CONFIGURE_PATH — config search path
# MAGICK_HOME — install directory, default: /usr
# MAGICK_TEMPORARY_PATH — temp directory
# MAGICK_THREAD_LIMIT — thread limit
# MAGICK_MAP_LIMIT — memory map limit
if command -v magick >/dev/null 2>&1; then
    export MAGICK_CONFIGURE_PATH="${MAGICK_CONFIGURE_PATH:-$XDG_CONFIG_HOME/ImageMagick}"
    export MAGICK_HOME="${MAGICK_HOME:-/usr}"
    export MAGICK_TEMPORARY_PATH="${MAGICK_TEMPORARY_PATH:-$TMPDIR}"
    export MAGICK_THREAD_LIMIT="${MAGICK_THREAD_LIMIT:-}"
    export MAGICK_MAP_LIMIT="${MAGICK_MAP_LIMIT:-}"
fi

# =============================================================================
# TERMINAL MULTIPLEXERS
# =============================================================================

# --- tmux — terminal multiplexer ---
# tmux enables multiple terminal sessions with session persistence.
# TMUX_TMPDIR — socket directory, default: $XDG_RUNTIME_DIR/tmux
# TMUX_CONF — config file
if command -v tmux >/dev/null 2>&1; then
    export TMUX_TMPDIR="${TMUX_TMPDIR:-$XDG_RUNTIME_DIR/tmux}"
    export TMUX_CONF="${TMUX_CONF:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
fi

# --- zellij — terminal multiplexer with layouts ---
# Zellij is a workspace with built-in layouts and plugin support.
# ZELLIJ_CONFIG_DIR — config directory
# ZELLIJ_LAYOUT_DIR — layout files directory
# ZELLIJ_SESSION_NAME — default session name
if command -v zellij >/dev/null 2>&1; then
    export ZELLIJ_CONFIG_DIR="${ZELLIJ_CONFIG_DIR:-$XDG_CONFIG_HOME/zellij}"
    export ZELLIJ_LAYOUT_DIR="${ZELLIJ_LAYOUT_DIR:-$ZELLIJ_CONFIG_DIR/layouts}"
    export ZELLIJ_SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"
fi

# =============================================================================
# GIT AND DEVELOPMENT TOOLS
# =============================================================================
#
# This section configures development tools for version control, code
# review, and terminal-based development workflows. Each application
# is detected via command -v and configured with sensible defaults
# following XDG Base Directory specifications.
#
# See also:
#   - lazygit(1) - Terminal UI for Git
#   - delta(1) - Syntax-highlighting diff pager
#   - git(1) - Git version control system
#

# =============================================================================
# Lazygit - Terminal UI for Git
# =============================================================================
#
# Lazygit is a simple terminal UI for Git written in Go. It provides
# a user-friendly interface for common Git operations without leaving
# the terminal.
#
# Features:
#   - Staging and committing changes
#   - Branch management and creation
#   - Rebasing and merging
#   - Viewing commit history and diffs
#   - Pushing and pulling from remotes
#   - Stash management
#   - Custom keybindings and configuration
#
# Usage examples:
#   lazygit
#   lazygit -f /path/to/repo
#   lazygit --help
#
# Configuration files:
#   - config.yml - Configuration file
#
# Environment variables:
#   LG_CONFIG_FILE        - Configuration file path
#   GIT_SEQUENCE_EDITOR   - Rebase sequence editor (default: lazygit)
#   GIT_EDITOR            - Git commit message editor
#
# See also:
#   - lazygit(1) - Lazygit documentation
#   - https://github.com/jesseduffield/lazygit - GitHub repository
#

if command -v lazygit >/dev/null 2>&1; then
    export LG_CONFIG_FILE="${LG_CONFIG_FILE:-$XDG_CONFIG_HOME/lazygit/config.yml}"
    export GIT_SEQUENCE_EDITOR="${GIT_SEQUENCE_EDITOR:-lazygit}"
    export GIT_EDITOR="${GIT_EDITOR:-$EDITOR}"
fi

# =============================================================================
# Delta - Syntax-highlighting diff pager
# =============================================================================
#
# Delta is a syntax-highlighting pager for git, diff, and grep output.
# It enhances the readability of diffs with side-by-side view, line
# numbers, and syntax highlighting.
#
# Features:
#   - Syntax highlighting for code in diffs
#   - Side-by-side diff view
#   - Line numbers
#   - Git-specific features (commit messages, branch names)
#   - Customizable colors and themes
#   - Support for git log, git show, git diff
#
# Usage examples:
#   git config --global core.pager delta
#   git config --global interactive.diffFilter "delta --color-only"
#   git config --global delta.navigate true
#   git config --global delta.light false
#   git config --global delta.line-numbers true
#
# Environment variables:
#   DELTA_FEATURES      - Enabled features (+line-numbers)
#   DELTA_PAGER         - Pager for long output (default: less -RFX)
#   DELTA_CONFIG_DIR    - Configuration directory
#
# See also:
#   - delta(1) - Delta documentation
#   - https://github.com/dandavison/delta - GitHub repository
#

if command -v delta >/dev/null 2>&1; then
    export DELTA_FEATURES="${DELTA_FEATURES:-+line-numbers}"
    export DELTA_PAGER="${DELTA_PAGER:-less -RFX}"
    export DELTA_CONFIG_DIR="${DELTA_CONFIG_DIR:-$XDG_CONFIG_HOME/delta}"
fi

# =============================================================================
# Broot - File browser with tree view
# =============================================================================
#
# Broot is a file browser with a tree view that makes navigating
# directories more efficient. It provides a modern interface for
# file management with search and preview capabilities.
#
# Features:
#   - Tree view of directory structure
#   - Search and filter files
#   - Preview files and directories
#   - Execute commands on selected files
#   - Customizable themes and configuration
#   - Keyboard shortcuts and navigation
#
# Usage examples:
#   broot
#   broot --root /path/to/dir
#   broot --help
#
# Configuration files:
#   - config.toml - Configuration file
#
# Environment variables:
#   BROOT_CONFIG_DIR    - Configuration directory
#   BROOT_CACHE_DIR     - Cache directory for thumbnails
#   BROOT_ICONS         - Enable icons (0=disable, 1=enable)
#   BROOT_COLORS        - Color mode (truecolor, 256, 16)
#
# See also:
#   - https://dystroy.org/broot/ - Project website
#   - https://github.com/Canop/broot - GitHub repository
#

if command -v broot >/dev/null 2>&1; then
    export BROOT_CONFIG_DIR="${BROOT_CONFIG_DIR:-$XDG_CONFIG_HOME/broot}"
    export BROOT_CACHE_DIR="${BROOT_CACHE_DIR:-$XDG_CACHE_HOME/broot}"
    export BROOT_ICONS="${BROOT_ICONS:-0}"
    export BROOT_COLORS="${BROOT_COLORS:-truecolor}"
fi

# =============================================================================
# Ranger - Console file manager with vim keybindings
# =============================================================================
#
# Ranger is a console file manager with vim-like keybindings. It
# provides a text-based interface for file management with support
# for previews, tabs, and custom configurations.
#
# Features:
#   - vim-like keybindings and navigation
#   - Preview files and directories
#   - Tab support for multiple directories
#   - Custom configuration with Python
#   - Plugin system for extensions
#   - Image previews in supported terminals
#
# Usage examples:
#   ranger
#   ranger /path/to/dir
#   ranger --cmd=help
#
# Configuration files:
#   - rc.conf - Configuration file
#   - rifle.conf - File opening rules
#
# Environment variables:
#   RANGER_LOAD_DEFAULT_RC - Load default configuration
#   RANGER_CONFIG_DIR      - Configuration directory
#   RANGER_DATA_DIR        - Data directory for plugins
#   RANGER_CACHE_DIR       - Cache directory
#
# See also:
#   - ranger(1) - Ranger documentation
#   - https://github.com/ranger/ranger - GitHub repository
#

if command -v ranger >/dev/null 2>&1; then
    export RANGER_LOAD_DEFAULT_RC="${RANGER_LOAD_DEFAULT_RC:-FALSE}"
    export RANGER_CONFIG_DIR="${RANGER_CONFIG_DIR:-$XDG_CONFIG_HOME/ranger}"
    export RANGER_DATA_DIR="${RANGER_DATA_DIR:-$XDG_DATA_HOME/ranger}"
    export RANGER_CACHE_DIR="${RANGER_CACHE_DIR:-$XDG_CACHE_HOME/ranger}"
fi

# =============================================================================
# lf - Terminal file manager
# =============================================================================
#
# lf is a terminal file manager that provides a simple interface
# for file management with support for previews, bookmarks, and
# custom configurations.
#
# Features:
#   - Simple and minimal interface
#   - Preview files and directories
#   - Bookmark support
#   - Custom configuration with shell scripts
#   - Image previews in supported terminals
#   - File operations (copy, move, delete)
#
# Usage examples:
#   lf
#   lf /path/to/dir
#   lf -help
#
# Configuration files:
#   - lfrc - Configuration file
#
# Environment variables:
#   LF_CONFIG_DIR       - Configuration directory
#   LF_CACHE_DIR        - Cache directory for thumbnails
#   LF_DATA_DIR         - Data directory for bookmarks
#   LF_ICONS            - Enable icons (0=disable, 1=enable)
#
# See also:
#   - https://github.com/gokcehan/lf - GitHub repository
#

if command -v lf >/dev/null 2>&1; then
    export LF_CONFIG_DIR="${LF_CONFIG_DIR:-$XDG_CONFIG_HOME/lf}"
    export LF_CACHE_DIR="${LF_CACHE_DIR:-$XDG_CACHE_HOME/lf}"
    export LF_DATA_DIR="${LF_DATA_DIR:-$XDG_DATA_HOME/lf}"
    export LF_ICONS="${LF_ICONS:-0}"
fi

# =============================================================================
# NNN - Fast terminal file manager
# =============================================================================
#
# NNN is a fast, lightweight terminal file manager with disk usage
# analysis and plugin support. It's designed for efficiency and
# minimal resource usage.
#
# Features:
#   - Fast and lightweight
#   - Disk usage analysis
#   - Plugin support
#   - Bookmarks
#   - File preview
#   - Custom configuration
#   - Mouse support
#
# Usage examples:
#   nnn
#   nnn /path/to/dir
#   nnn -h
#
# Configuration files:
#   - config - Configuration file
#
# Environment variables:
#   NNN_BMS           - Bookmarks key-value pairs
#   NNN_OPENER        - File opener command
#   NNN_USE_EDITOR    - Use $EDITOR (0=disable, 1=enable)
#   NNN_COLORS        - Color scheme
#   NNN_FCOLORS       - File color scheme
#   NNN_TERMINAL      - Terminal type
#   NNN_TRASH         - Use trash (0=disable, 1=enable)
#   NNN_SHOW_HIDDEN   - Show hidden files (0=disable, 1=enable)
#   NNN_ORDER         - File order (t=time, n=name, s=size, e=extension)
#
# See also:
#   - https://github.com/jarun/nnn - GitHub repository
#

if command -v nnn >/dev/null 2>&1; then
    export NNN_BMS="${NNN_BMS:-d:$HOME/Downloads;D:$XDG_CONFIG_HOME;h:$HOME}"
    export NNN_OPENER="${NNN_OPENER:-xdg-open}"
    export NNN_USE_EDITOR="${NNN_USE_EDITOR:-1}"
    export NNN_COLORS="${NNN_COLORS:-5632}"
    export NNN_FCOLORS="${NNN_FCOLORS:-c1e1e1e1e1e1e1e1}"
    export NNN_TERMINAL="${NNN_TERMINAL:-$TERMINAL}"
    export NNN_TRASH="${NNN_TRASH:-1}"
    export NNN_SHOW_HIDDEN="${NNN_SHOW_HIDDEN:-1}"
    export NNN_ORDER="${NNN_ORDER:-t}"
fi

# =============================================================================
# MC - Midnight Commander
# =============================================================================
#
# Midnight Commander is a text-mode file manager with a two-panel
# interface. It provides a familiar interface for file management
# with support for plugins and custom configurations.
#
# Features:
#   - Two-panel interface
#   - File operations (copy, move, delete)
#   - Built-in file viewer and editor
#   - Plugin support
#   - Custom skins and themes
#   - FTP and SFTP support
#
# Usage examples:
#   mc
#   mc /path/to/dir
#   mc -h
#
# Configuration files:
#   - mc.ini - Configuration file
#   - skins/ - Skin files
#
# Environment variables:
#   MC_SKIN           - Skin file
#   MC_COLOR_TABLE    - Color theme
#   MC_TMPDIR         - Temporary directory
#   MC_EXT_CD         - Auto-change directory on external command
#   MC_EDITOR         - Default editor
#   MC_PAGER          - Default pager
#
# See also:
#   - https://midnight-commander.org - Project website
#   - https://github.com/MidnightCommander/mc - GitHub repository
#

if command -v mc >/dev/null 2>&1; then
    export MC_SKIN="${MC_SKIN:-$XDG_CONFIG_HOME/mc/skins/default.ini}"
    export MC_COLOR_TABLE="${MC_COLOR_TABLE:-gray-green}"
    export MC_TMPDIR="${MC_TMPDIR:-$TMPDIR}"
    export MC_EXT_CD="${MC_EXT_CD:-1}"
    export MC_EDITOR="${MC_EDITOR:-$EDITOR}"
    export MC_PAGER="${MC_PAGER:-$PAGER}"
fi

# =============================================================================
# Yazi - Blazing fast terminal file manager
# =============================================================================
#
# Yazi is a blazing fast terminal file manager built with Rust. It
# features async I/O, image previews, and a modern interface.
#
# Features:
#   - Blazing fast with async I/O
#   - Image previews
#   - Modern interface
#   - Customizable themes
#   - Plugin support
#   - Keyboard shortcuts
#
# Usage examples:
#   yazi
#   yazi /path/to/dir
#   yazi --help
#
# Configuration files:
#   - config.toml - Configuration file
#
# Environment variables:
#   YAZI_CONFIG_DIR   - Configuration directory
#   YAZI_CACHE_DIR    - Cache directory for thumbnails
#   YAZI_LOG_DIR      - Log directory
#   YAZI_LOGGER       - Logger level (0=disable, 1=enable)
#
# See also:
#   - https://yazi-rs.github.io - Project website
#   - https://github.com/sxyazi/yazi - GitHub repository
#

if command -v yazi >/dev/null 2>&1; then
    export YAZI_CONFIG_DIR="${YAZI_CONFIG_DIR:-$XDG_CONFIG_HOME/yazi}"
    export YAZI_CACHE_DIR="${YAZI_CACHE_DIR:-$XDG_CACHE_HOME/yazi}"
    export YAZI_LOG_DIR="${YAZI_LOG_DIR:-$XDG_STATE_HOME/yazi}"
    export YAZI_LOGGER="${YAZI_LOGGER:-0}"
fi

# =============================================================================
# Broot - File browser with tree view
# =============================================================================
#
# Broot is a file browser with a tree view that makes navigating
# directories more efficient. It provides a modern interface for
# file management with search and preview capabilities.
#
# Features:
#   - Tree view of directory structure
#   - Search and filter files
#   - Preview files and directories
#   - Execute commands on selected files
#   - Customizable themes and configuration
#   - Keyboard shortcuts and navigation
#
# Usage examples:
#   broot
#   broot --root /path/to/dir
#   broot --help
#
# Configuration files:
#   - config.toml - Configuration file
#
# Environment variables:
#   BROOT_CONFIG_DIR    - Configuration directory
#   BROOT_CACHE_DIR     - Cache directory for thumbnails
#   BROOT_ICONS         - Enable icons (0=disable, 1=enable)
#   BROOT_COLORS        - Color mode (truecolor, 256, 16)
#
# See also:
#   - https://dystroy.org/broot/ - Project website
#   - https://github.com/Canop/broot - GitHub repository
#

if command -v broot >/dev/null 2>&1; then
    export BROOT_CONFIG_DIR="${BROOT_CONFIG_DIR:-$XDG_CONFIG_HOME/broot}"
    export BROOT_CACHE_DIR="${BROOT_CACHE_DIR:-$XDG_CACHE_HOME/broot}"
    export BROOT_ICONS="${BROOT_ICONS:-0}"
    export BROOT_COLORS="${BROOT_COLORS:-truecolor}"
fi

# =============================================================================
# Joshuto - Terminal file manager
# =============================================================================
#
# Joshuto is a terminal file manager with a focus on simplicity and
# efficiency. It provides a minimal interface for file management
# with support for previews and custom configurations.
#
# Features:
#   - Simple and minimal interface
#   - Preview files and directories
#   - Custom configuration
#   - Keyboard shortcuts
#   - File operations
#
# Usage examples:
#   joshuto
#   joshuto /path/to/dir
#   joshuto --help
#
# Configuration files:
#   - config.toml - Configuration file
#
# Environment variables:
#   JOSHUTO_CONFIG_DIR  - Configuration directory
#   JOSHUTO_CACHE_DIR   - Cache directory for thumbnails
#   JOSHUTO_PREVIEW     - Enable preview (0=disable, 1=enable)
#   JOSHUTO_SHOW_HIDDEN - Show hidden files (0=disable, 1=enable)
#
# See also:
#   - https://github.com/kamiyaa/joshuto - GitHub repository
#

if command -v joshuto >/dev/null 2>&1; then
    export JOSHUTO_CONFIG_DIR="${JOSHUTO_CONFIG_DIR:-$XDG_CONFIG_HOME/joshuto}"
    export JOSHUTO_CACHE_DIR="${JOSHUTO_CACHE_DIR:-$XDG_CACHE_HOME/joshuto}"
    export JOSHUTO_PREVIEW="${JOSHUTO_PREVIEW:-1}"
    export JOSHUTO_SHOW_HIDDEN="${JOSHUTO_SHOW_HIDDEN:-1}"
fi
