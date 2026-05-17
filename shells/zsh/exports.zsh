#!/usr/bin/env zsh
# Clear any inherited dotfiles vars
unset DOTFILES_MODE DOTFILES_VERSION DOTFILES_FASTFETCH_ON_STARTUP STARSHIP_CONFIG
[[ "$TERM" == "dumb" || -z "$TERM" ]] && export TERM=xterm-256color
export DOTFILES_MODE="${DOTFILES_MODE:-supreme}"

# Secure umask - files 0644, dirs 0755
umask 022


export LS_COLORS="di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"

export PATH="$HOME/.cargo/bin:$PATH"

# Flatpak paths
[ -d "/var/lib/flatpak/exports/bin" ] && export PATH="/var/lib/flatpak/exports/bin${PATH:+:$PATH}"
[ -d "$HOME/.local/share/flatpak/exports/bin" ] && export PATH="$HOME/.local/share/flatpak/exports/bin${PATH:+:$PATH}"


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
# HISTSIZE set in .zshrc
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

# -----------------------------------------------------------------------------
# EDITORS
# -----------------------------------------------------------------------------

if command -v nvim >/dev/null 2>&1; then
    export NVIM_LOG_FILE="${NVIM_LOG_FILE:-$XDG_STATE_HOME/nvim/log}"
    export NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
    export VIMCONFIG="${VIMCONFIG:-$XDG_CONFIG_HOME/nvim}"
    export VIMDATA="${VIMDATA:-$XDG_DATA_HOME/nvim}"
    export VIMPLUGINDIR="${VIMPLUGINDIR:-$VIMDATA/site/pack}"
fi

if command -v vim >/dev/null 2>&1; then
    export VIM="${VIM:-/usr/share/vim}"
    export VIMRUNTIME="${VIMRUNTIME:-$VIM/vim90}"
    export MYVIMRC="${MYVIMRC:-$XDG_CONFIG_HOME/vim/vimrc}"
    export VIMINIT="${VIMINIT:-source $MYVIMRC}"
fi

if command -v emacs >/dev/null 2>&1; then
    export EMACSDIR="${EMACSDIR:-$XDG_CONFIG_HOME/emacs}"
    export ESHELL="${ESHELL:-$SHELL}"
    export ALTERNATE_EDITOR="${ALTERNATE_EDITOR:-}"
fi

if command -v code >/dev/null 2>&1; then
    export VSCODE_CLI="${VSCODE_CLI:-1}"
fi

if command -v helix >/dev/null 2>&1; then
    export HELIX_RUNTIME="${HELIX_RUNTIME:-$XDG_DATA_HOME/helix/runtime}"
    export HELIX_LOG="${HELIX_LOG:-$XDG_STATE_HOME/helix/helix.log}"
fi

if command -v zed >/dev/null 2>&1; then
    export ZED_CONFIG_DIR="${ZED_CONFIG_DIR:-$XDG_CONFIG_HOME/zed}"
fi

if command -v micro >/dev/null 2>&1; then
    export MICRO_CONFIG_DIR="${MICRO_CONFIG_DIR:-$XDG_CONFIG_HOME/micro}"
    export MICRO_TRUECOLOR="${MICRO_TRUECOLOR:-1}"
fi

if command -v kak >/dev/null 2>&1; then
    export KAKOUNE_CONFIG_DIR="${KAKOUNE_CONFIG_DIR:-$XDG_CONFIG_HOME/kak}"
    export KAKOUNE_PLUGIN_DIR="${KAKOUNE_PLUGIN_DIR:-$XDG_DATA_HOME/kak/plugins}"
fi

if command -v joe >/dev/null 2>&1; then
    export JOERC="${JOERC:-$HOME/.joerc}"
    export JOE_TERM="${JOE_TERM:-$TERM}"
fi

# -----------------------------------------------------------------------------
# SHELLS
# -----------------------------------------------------------------------------

if command -v bash >/dev/null 2>&1; then
    export BASH_ENV="${BASH_ENV:-$HOME/.bashrc}"
    export BASH_LOADABLES_PATH="${BASH_LOADABLES_PATH:-/usr/lib/bash}"
fi

if command -v zsh >/dev/null 2>&1; then
    export ZDOTDIR="${ZDOTDIR:-$HOME}"
    export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$XDG_CACHE_HOME/zsh}"
    export ZSH_COMPDUMP="${ZSH_COMPDUMP:-$ZSH_CACHE_DIR/zcompdump}"
    export DISABLE_MAGIC_FUNCTIONS="${DISABLE_MAGIC_FUNCTIONS:-1}"
fi

if command -v fish >/dev/null 2>&1; then
    export FISH_CONFIG_DIR="${FISH_CONFIG_DIR:-$XDG_CONFIG_HOME/fish}"
    export FISH_DATA_DIR="${FISH_DATA_DIR:-$XDG_DATA_HOME/fish}"
    export FISH_CACHE_DIR="${FISH_CACHE_DIR:-$XDG_CACHE_HOME/fish}"
fi

if command -v nu >/dev/null 2>&1; then
    export NU_CONFIG_PATH="${NU_CONFIG_PATH:-$XDG_CONFIG_HOME/nushell/config.nu}"
    export NU_ENV_PATH="${NU_ENV_PATH:-$XDG_CONFIG_HOME/nushell/env.nu}"
    export NU_LIB_DIR="${NU_LIB_DIR:-$XDG_DATA_HOME/nu-lib}"
fi

if command -v elvish >/dev/null 2>&1; then
    export ELVISH_CONFIG_PATH="${ELVISH_CONFIG_PATH:-$XDG_CONFIG_HOME/elvish}"
    export ELVISH_DATA_PATH="${ELVISH_DATA_PATH:-$XDG_DATA_HOME/elvish}"
fi

if command -v xonsh >/dev/null 2>&1; then
    export XONSH_CONFIG_DIR="${XONSH_CONFIG_DIR:-$XDG_CONFIG_HOME/xonsh}"
    export XONSH_SHOW_TRACEBACK="${XONSH_SHOW_TRACEBACK:-0}"
    export XONSH_ENCODING="${XONSH_ENCODING:-UTF-8}"
fi

# -----------------------------------------------------------------------------
# LANGUAGE RUNTIMES
# -----------------------------------------------------------------------------

if command -v go >/dev/null 2>&1; then
    export GOROOT="${GOROOT:-$(go env GOROOT 2>/dev/null || true)}"
    export GOPATH="${GOPATH:-$HOME/.go}"
    export GOBIN="${GOBIN:-$GOPATH/bin}"
    export GOPROXY="${GOPROXY:-https://proxy.golang.org,direct}"
    export GOMODCACHE="${GOMODCACHE:-$GOPATH/pkg/mod}"
    export CGO_ENABLED="${CGO_ENABLED:-1}"
    export PATH="$GOBIN${PATH:+:$PATH}"
fi

if command -v cargo >/dev/null 2>&1; then
    export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
    export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
    export RUST_BACKTRACE="${RUST_BACKTRACE:-1}"
    export RUST_LOG="${RUST_LOG:-info}"
    export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-$CARGO_HOME/target}"
    export CARGO_INCREMENTAL="${CARGO_INCREMENTAL:-1}"
    export RUSTFLAGS="${RUSTFLAGS:-}"
    export PATH="$CARGO_HOME/bin${PATH:+:$PATH}"
fi

if command -v node >/dev/null 2>&1; then
    export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/repl_history}"
    export NODE_PATH="${NODE_PATH:-$HOME/.node_modules}"
    export NODE_OPTIONS="${NODE_OPTIONS:-}"
    export NODE_ENV="${NODE_ENV:-development}"
fi

if command -v npm >/dev/null 2>&1; then
    export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
    export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"
    export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local}"
    export PATH="$NPM_CONFIG_PREFIX/bin${PATH:+:$PATH}"
fi

if command -v python3 >/dev/null 2>&1; then
    export PYTHONDONTWRITEBYTECODE="${PYTHONDONTWRITEBYTECODE:-1}"
    export PYTHONSTARTUP="${PYTHONSTARTUP:-$XDG_CONFIG_HOME/python/pythonrc}"
    export PYTHONPATH="${PYTHONPATH:-}"
    export PYTHONHASHSEED="${PYTHONHASHSEED:-random}"
    export PYTHONUNBUFFERED="${PYTHONUNBUFFERED:-1}"
fi

if command -v pip3 >/dev/null 2>&1; then
    export PIP_REQUIRE_VIRTUALENV="${PIP_REQUIRE_VIRTUALENV:-false}"
    export PIP_CACHE_DIR="${PIP_CACHE_DIR:-$XDG_CACHE_HOME/pip}"
    export PIP_DOWNLOAD_CACHE="${PIP_DOWNLOAD_CACHE:-$PIP_CACHE_DIR/downloads}"
    export PATH="$HOME/.local/bin${PATH:+:$PATH}"
fi

if command -v ruby >/dev/null 2>&1; then
    export GEM_HOME="${GEM_HOME:-$HOME/.gem}"
    export GEM_PATH="${GEM_PATH:-$GEM_HOME}"
    export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"
    export RUBYOPT="${RUBYOPT:-}"
    export RUBY_THREAD_VM_STACK_SIZE="${RUBY_THREAD_VM_STACK_SIZE:-524288}"
    export PATH="$GEM_HOME/bin${PATH:+:$PATH}"
fi

if command -v java >/dev/null 2>&1; then
    export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/default}"
    export JDK_HOME="${JDK_HOME:-$JAVA_HOME}"
    export JRE_HOME="${JRE_HOME:-$JAVA_HOME/jre}"
    export CLASSPATH="${CLASSPATH:-.}"
    export _JAVA_OPTIONS="${_JAVA_OPTIONS:--Dawt.useSystemAAFontSettings=on}"
    export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-}"
fi

if command -v julia >/dev/null 2>&1; then
    export JULIA_DEPOT_PATH="${JULIA_DEPOT_PATH:-$HOME/.julia}"
    export JULIA_PROJECT="${JULIA_PROJECT:-@.}"
    export JULIA_NUM_THREADS="${JULIA_NUM_THREADS:-$(nproc 2>/dev/null || echo 4)}"
    export JULIA_EDITOR="${JULIA_EDITOR:-$EDITOR}"
    export JULIA_PKG_SERVER="${JULIA_PKG_SERVER:-https://pkg.julialang.org}"
fi

# -----------------------------------------------------------------------------
# CONTAINERS
# -----------------------------------------------------------------------------

if command -v docker >/dev/null 2>&1; then
    export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
    export DOCKER_CONTENT_TRUST="${DOCKER_CONTENT_TRUST:-0}"
    export DOCKER_BUILDKIT="${DOCKER_BUILDKIT:-1}"
    export COMPOSE_DOCKER_CLI_BUILD="${COMPOSE_DOCKER_CLI_BUILD:-1}"
    export DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM:-linux/amd64}"
    export BUILDKIT_PROGRESS="${BUILDKIT_PROGRESS:-plain}"
    export DOCKER_SCAN_SUGGEST="${DOCKER_SCAN_SUGGEST:-false}"
fi

if command -v podman >/dev/null 2>&1; then
    export PODMAN_USERNS="${PODMAN_USERNS:-keep-id}"
    export CONTAINER_REGISTRIES_CONF="${CONTAINER_REGISTRIES_CONF:-$XDG_CONFIG_HOME/containers/registries.conf}"
    export STORAGE_DRIVER="${STORAGE_DRIVER:-overlay}"
    export BUILDAH_FORMAT="${BUILDAH_FORMAT:-oci}"
    export PODMAN_IGNORE_CGROUPS_V1="${PODMAN_IGNORE_CGROUPS_V1:-0}"
fi

if command -v nerdctl >/dev/null 2>&1; then
    export NERDCTL_HOST="${NERDCTL_HOST:-unix:///run/containerd/containerd.sock}"
    export NERDCTL_NAMESPACE="${NERDCTL_NAMESPACE:-default}"
fi

if command -v lazydocker >/dev/null 2>&1; then
    export LAZYDOCKER_CONFIG="${LAZYDOCKER_CONFIG:-$XDG_CONFIG_HOME/lazydocker}"
fi

if command -v ctop >/dev/null 2>&1; then
    export CTOP_CONFIG="${CTOP_CONFIG:-$XDG_CONFIG_HOME/ctop/config}"
fi

if command -v dive >/dev/null 2>&1; then
    export DIVE_CONFIG="${DIVE_CONFIG:-$XDG_CONFIG_HOME/dive/dive.yaml}"
fi

if command -v skopeo >/dev/null 2>&1; then
    export SKOPEO_CACHE_DIR="${SKOPEO_CACHE_DIR:-$XDG_CACHE_HOME/skopeo}"
    export SKOPEO_POLICY="${SKOPEO_POLICY:-/etc/containers/policy.json}"
    export REGISTRY_AUTH_FILE="${REGISTRY_AUTH_FILE:-$XDG_CONFIG_HOME/containers/auth.json}"
fi

# -----------------------------------------------------------------------------
# ORCHESTRATION
# -----------------------------------------------------------------------------

if command -v kubectl >/dev/null 2>&1; then
    export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
    export KUBE_EDITOR="${KUBE_EDITOR:-$EDITOR}"
    export KUBECTL_EXPLAIN_SYMBOLS="${KUBECTL_EXPLAIN_SYMBOLS:-true}"
    export KUBE_CACHE_DIR="${KUBE_CACHE_DIR:-$XDG_CACHE_HOME/kube}"
    export KUBECTL_PLUGINS_PATH="${KUBECTL_PLUGINS_PATH:-$HOME/.krew/bin}"
    export PATH="$KUBECTL_PLUGINS_PATH${PATH:+:$PATH}"
fi

if command -v helm >/dev/null 2>&1; then
    export HELM_CACHE_HOME="${HELM_CACHE_HOME:-$XDG_CACHE_HOME/helm}"
    export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-$XDG_CONFIG_HOME/helm}"
    export HELM_DATA_HOME="${HELM_DATA_HOME:-$XDG_DATA_HOME/helm}"
    export HELM_DRIVER="${HELM_DRIVER:-secret}"
    export HELM_DEBUG="${HELM_DEBUG:-false}"
    export HELM_KUBECONTEXT="${HELM_KUBECONTEXT:-}"
    export HELM_PLUGINS="${HELM_PLUGINS:-$HELM_DATA_HOME/plugins}"
fi

if command -v k9s >/dev/null 2>&1; then
    export K9S_CONFIG_DIR="${K9S_CONFIG_DIR:-$XDG_CONFIG_HOME/k9s}"
    export K9S_CACHE_DIR="${K9S_CACHE_DIR:-$XDG_CACHE_HOME/k9s}"
    export K9S_HIDE_CRDS="${K9S_HIDE_CRDS:-false}"
    export K9S_SCREEN_DUMP_DIR="${K9S_SCREEN_DUMP_DIR:-$XDG_DATA_HOME/k9s/dumps}"
fi

if command -v stern >/dev/null 2>&1; then
    export STERN_NAMESPACE="${STERN_NAMESPACE:-}"
    export STERN_TIMESTAMP="${STERN_TIMESTAMP:-false}"
    export STERN_MAX_LOG_REQUESTS="${STERN_MAX_LOG_REQUESTS:-5}"
    export STERN_CONFIG="${STERN_CONFIG:-$XDG_CONFIG_HOME/stern/config}"
fi

if command -v kustomize >/dev/null 2>&1; then
    export KUSTOMIZE_CONFIG_DIR="${KUSTOMIZE_CONFIG_DIR:-$XDG_CONFIG_HOME/kustomize}"
    export KUSTOMIZE_PLUGIN_DIR="${KUSTOMIZE_PLUGIN_DIR:-$XDG_DATA_HOME/kustomize/plugins}"
    export KUSTOMIZE_ENABLE_ALPHA_PLUGINS="${KUSTOMIZE_ENABLE_ALPHA_PLUGINS:-false}"
fi

if command -v argocd >/dev/null 2>&1; then
    export ARGOCD_SERVER="${ARGOCD_SERVER:-}"
    export ARGOCD_OPTS="${ARGOCD_OPTS:---grpc-web}"
    export ARGOCD_AUTH_TOKEN="${ARGOCD_AUTH_TOKEN:-}"
    export ARGOCD_GRPC_WEB="${ARGOCD_GRPC_WEB:-true}"
fi

if command -v flux >/dev/null 2>&1; then
    export FLUX_CACHE_DIR="${FLUX_CACHE_DIR:-$XDG_CACHE_HOME/flux}"
    export FLUX_KUBECONFIG="${FLUX_KUBECONFIG:-$KUBECONFIG}"
    export FLUX_DISABLE_GIT="${FLUX_DISABLE_GIT:-false}"
    export FLUX_CONFIG_DIR="${FLUX_CONFIG_DIR:-$XDG_CONFIG_HOME/flux}"
fi

if command -v istioctl >/dev/null 2>&1; then
    export ISTIO_CONFIG="${ISTIO_CONFIG:-$XDG_CONFIG_HOME/istio}"
    export ISTIO_VERSION="${ISTIO_VERSION:-}"
    export ISTIO_NAMESPACE="${ISTIO_NAMESPACE:-istio-system}"
fi

# -----------------------------------------------------------------------------
# CLOUD
# -----------------------------------------------------------------------------

if command -v aws >/dev/null 2>&1; then
    export AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-$XDG_CONFIG_HOME/aws/config}"
    export AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-$XDG_CONFIG_HOME/aws/credentials}"
    export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
    export AWS_DEFAULT_OUTPUT="${AWS_DEFAULT_OUTPUT:-json}"
    export AWS_PAGER="${AWS_PAGER:-}"
    export AWS_PROFILE="${AWS_PROFILE:-default}"
    export AWS_MAX_ATTEMPTS="${AWS_MAX_ATTEMPTS:-5}"
    export AWS_RETRY_MODE="${AWS_RETRY_MODE:-standard}"
fi

if command -v gcloud >/dev/null 2>&1; then
    export CLOUDSDK_CONFIG="${CLOUDSDK_CONFIG:-$XDG_CONFIG_HOME/gcloud}"
    export CLOUDSDK_CORE_PROJECT="${CLOUDSDK_CORE_PROJECT:-}"
    export CLOUDSDK_COMPUTE_REGION="${CLOUDSDK_COMPUTE_REGION:-us-central1}"
    export CLOUDSDK_COMPUTE_ZONE="${CLOUDSDK_COMPUTE_ZONE:-us-central1-a}"
    export CLOUDSDK_CORE_ACCOUNT="${CLOUDSDK_CORE_ACCOUNT:-}"
    export CLOUDSDK_CORE_DISABLE_PROMPTS="${CLOUDSDK_CORE_DISABLE_PROMPTS:-false}"
fi

if command -v az >/dev/null 2>&1; then
    export AZURE_CONFIG_DIR="${AZURE_CONFIG_DIR:-$XDG_CONFIG_HOME/azure}"
    export AZ_DEFAULTS_GROUP="${AZ_DEFAULTS_GROUP:-}"
    export AZ_DEFAULTS_REGION="${AZ_DEFAULTS_REGION:-eastus}"
    export AZURE_EXTENSION_DIR="${AZURE_EXTENSION_DIR:-$AZURE_CONFIG_DIR/extensions}"
    export AZURE_DEFAULTS_OUTPUT="${AZURE_DEFAULTS_OUTPUT:-table}"
fi

if command -v terraform >/dev/null 2>&1; then
    export TF_PLUGIN_CACHE_DIR="${TF_PLUGIN_CACHE_DIR:-$XDG_CACHE_HOME/terraform/plugin-cache}"
    export TF_IN_AUTOMATION="${TF_IN_AUTOMATION:-1}"
    export TF_LOG="${TF_LOG:-}"
    export TF_LOG_PATH="${TF_LOG_PATH:-$XDG_STATE_HOME/terraform/terraform.log}"
    export TF_DATA_DIR="${TF_DATA_DIR:-.terraform}"
    export TF_WORKSPACE="${TF_WORKSPACE:-default}"
    export TF_INPUT="${TF_INPUT:-false}"
    export TF_CLI_ARGS_init="${TF_CLI_ARGS_init:--input=false}"
fi

if command -v pulumi >/dev/null 2>&1; then
    export PULUMI_HOME="${PULUMI_HOME:-$XDG_DATA_HOME/pulumi}"
    export PULUMI_CONFIG_PASSPHRASE="${PULUMI_CONFIG_PASSPHRASE:-}"
    export PULUMI_SKIP_UPDATE_CHECK="${PULUMI_SKIP_UPDATE_CHECK:-true}"
    export PULUMI_BACKEND_URL="${PULUMI_BACKEND_URL:-}"
    export PULUMI_ACCESS_TOKEN="${PULUMI_ACCESS_TOKEN:-}"
    export PATH="$PULUMI_HOME/bin${PATH:+:$PATH}"
fi

if command -v tofu >/dev/null 2>&1; then
    export TOFU_PLUGIN_CACHE_DIR="${TOFU_PLUGIN_CACHE_DIR:-$XDG_CACHE_HOME/tofu/plugin-cache}"
    export TOFU_IN_AUTOMATION="${TOFU_IN_AUTOMATION:-1}"
    export TOFU_LOG="${TOFU_LOG:-}"
    export TOFU_LOG_PATH="${TOFU_LOG_PATH:-$XDG_STATE_HOME/tofu/tofu.log}"
    export TOFU_WORKSPACE="${TOFU_WORKSPACE:-default}"
fi

if command -v doppler >/dev/null 2>&1; then
    export DOPPLER_TOKEN="${DOPPLER_TOKEN:-}"
    export DOPPLER_PROJECT="${DOPPLER_PROJECT:-}"
    export DOPPLER_CONFIG="${DOPPLER_CONFIG:-}"
    export DOPPLER_SCOPE="${DOPPLER_SCOPE:-.}"
    export DOPPLER_CONFIG_DIR="${DOPPLER_CONFIG_DIR:-$XDG_CONFIG_HOME/doppler}"
fi

if command -v vault >/dev/null 2>&1; then
    export VAULT_ADDR="${VAULT_ADDR:-https://127.0.0.1:8200}"
    export VAULT_TOKEN="${VAULT_TOKEN:-}"
    export VAULT_CACERT="${VAULT_CACERT:-}"
    export VAULT_CAPATH="${VAULT_CAPATH:-}"
    export VAULT_CLIENT_CERT="${VAULT_CLIENT_CERT:-}"
    export VAULT_CLIENT_KEY="${VAULT_CLIENT_KEY:-}"
    export VAULT_SKIP_VERIFY="${VAULT_SKIP_VERIFY:-false}"
    export VAULT_NAMESPACE="${VAULT_NAMESPACE:-}"
    export VAULT_FORMAT="${VAULT_FORMAT:-table}"
fi

# -----------------------------------------------------------------------------
# CI/CD
# -----------------------------------------------------------------------------

if command -v gh >/dev/null 2>&1; then
    export GH_EDITOR="${GH_EDITOR:-$EDITOR}"
    export GH_HOST="${GH_HOST:-github.com}"
    export GH_CONFIG_DIR="${GH_CONFIG_DIR:-$XDG_CONFIG_HOME/gh}"
    export GH_TOKEN="${GH_TOKEN:-}"
    export GH_PROMPT_DISABLED="${GH_PROMPT_DISABLED:-false}"
    export GH_PAGER="${GH_PAGER:-less}"
    export GH_BROWSER="${GH_BROWSER:-$BROWSER}"
fi

if command -v glab >/dev/null 2>&1; then
    export GLAMOUR_STYLE="${GLAMOUR_STYLE:-dark}"
    export GITLAB_TOKEN="${GITLAB_TOKEN:-}"
    export GITLAB_HOST="${GITLAB_HOST:-gitlab.com}"
    export GLAB_CONFIG_DIR="${GLAB_CONFIG_DIR:-$XDG_CONFIG_HOME/glab-cli}"
fi

if command -v act >/dev/null 2>&1; then
    export ACT_CONFIG="${ACT_CONFIG:-$XDG_CONFIG_HOME/act/actrc}"
    export ACT_CACHE_DIR="${ACT_CACHE_DIR:-$XDG_CACHE_HOME/act}"
    export ACT_WORKFLOW_DIR="${ACT_WORKFLOW_DIR:-.github/workflows}"
    export ACT_SECRETS="${ACT_SECRETS:-}"
    export ACT_VARS="${ACT_VARS:-}"
fi

if command -v drone >/dev/null 2>&1; then
    export DRONE_SERVER="${DRONE_SERVER:-}"
    export DRONE_TOKEN="${DRONE_TOKEN:-}"
    export DRONE_CONFIG="${DRONE_CONFIG:-$XDG_CONFIG_HOME/drone/drone.yml}"
fi

if command -v circleci >/dev/null 2>&1; then
    export CIRCLE_TOKEN="${CIRCLE_TOKEN:-}"
    export CIRCLECI_CLI_CONFIG="${CIRCLECI_CLI_CONFIG:-$XDG_CONFIG_HOME/circleci}"
    export CIRCLECI_HOST="${CIRCLECI_HOST:-https://circleci.com}"
    export CIRCLECI_HOME="${CIRCLECI_HOME:-$CIRCLECI_CLI_CONFIG}"
fi

# -----------------------------------------------------------------------------
# DATABASES
# -----------------------------------------------------------------------------

if command -v mysql >/dev/null 2>&1; then
    export MYSQL_HOME="${MYSQL_HOME:-$XDG_CONFIG_HOME/mysql}"
    export MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-3306}"
    export MYSQL_UNIX_PORT="${MYSQL_UNIX_PORT:-/run/mysqld/mysqld.sock}"
    export MYSQL_PS1="${MYSQL_PS1:-\\u@\\h [\\d]> }"
    export MYSQL_HISTFILE="${MYSQL_HISTFILE:-$XDG_DATA_HOME/mysql/history}"
    export MYSQL_PAGER="${MYSQL_PAGER:-less -RFX}"
fi

if command -v psql >/dev/null 2>&1; then
    export PGHOST="${PGHOST:-localhost}"
    export PGPORT="${PGPORT:-5432}"
    export PGDATABASE="${PGDATABASE:-}"
    export PGUSER="${PGUSER:-$USER}"
    export PGPASSWORD="${PGPASSWORD:-}"
    export PGDATA="${PGDATA:-/var/lib/postgres/data}"
    export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
    export PGSERVICE="${PGSERVICE:-}"
    export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_DATA_HOME/psql/history}"
    export PSQL_PAGER="${PSQL_PAGER:-less -RFX}"
fi

if command -v sqlite3 >/dev/null 2>&1; then
    export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"
    export SQLITE_TMPDIR="${SQLITE_TMPDIR:-$TMPDIR}"
    export SQLITE_FOREGROUND="${SQLITE_FOREGROUND:-0}"
    export SQLITE_DEFAULT_CACHE_SIZE="${SQLITE_DEFAULT_CACHE_SIZE:-2000}"
fi

if command -v redis-cli >/dev/null 2>&1; then
    export REDIS_HOST="${REDIS_HOST:-localhost}"
    export REDIS_PORT="${REDIS_PORT:-6379}"
    export REDIS_PASSWORD="${REDIS_PASSWORD:-}"
    export REDISCLI_AUTH="${REDISCLI_AUTH:-}"
    export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-$XDG_DATA_HOME/redis/rediscli_history}"
    export REDISCLI_RAW="${REDISCLI_RAW:-0}"
fi

if command -v mongosh >/dev/null 2>&1; then
    export MONGOSH_HOME="${MONGOSH_HOME:-$XDG_CONFIG_HOME/mongosh}"
    export MONGOSH_HISTORY="${MONGOSH_HISTORY:-$XDG_DATA_HOME/mongosh/history}"
    export MONGODB_URI="${MONGODB_URI:-mongodb://localhost:27017}"
    export MONGO_HOST="${MONGO_HOST:-localhost}"
    export MONGO_PORT="${MONGO_PORT:-27017}"
    export MONGO_USERNAME="${MONGO_USERNAME:-}"
    export MONGO_PASSWORD="${MONGO_PASSWORD:-}"
    export MONGO_TLS="${MONGO_TLS:-false}"
fi

if command -v cockroach >/dev/null 2>&1; then
    export COCKROACH_HOST="${COCKROACH_HOST:-localhost}"
    export COCKROACH_PORT="${COCKROACH_PORT:-26257}"
    export COCKROACH_DATABASE="${COCKROACH_DATABASE:-defaultdb}"
    export COCKROACH_USER="${COCKROACH_USER:-root}"
    export COCKROACH_INSECURE="${COCKROACH_INSECURE:-true}"
    export COCKROACH_CERTS_DIR="${COCKROACH_CERTS_DIR:-}"
    export COCKROACH_SQL_HISTORY="${COCKROACH_SQL_HISTORY:-$XDG_DATA_HOME/cockroach/sql_history}"
fi

if command -v duckdb >/dev/null 2>&1; then
    export DUCKDB_HISTORY="${DUCKDB_HISTORY:-$XDG_DATA_HOME/duckdb/history}"
    export DUCKDB_CONFIG="${DUCKDB_CONFIG:-$XDG_CONFIG_HOME/duckdb/config}"
    export DUCKDB_THREADS="${DUCKDB_THREADS:-$(nproc 2>/dev/null || echo 4)}"
    export DUCKDB_MAX_MEMORY="${DUCKDB_MAX_MEMORY:-80%}"
    export DUCKDB_TEMP_DIR="${DUCKDB_TEMP_DIR:-$TMPDIR}"
fi

# -----------------------------------------------------------------------------
# MONITORING
# -----------------------------------------------------------------------------

if command -v htop >/dev/null 2>&1; then
    export HTOPRC="${HTOPRC:-$XDG_CONFIG_HOME/htop/htoprc}"
    export HTOP_NUMA="${HTOP_NUMA:-0}"
    export HTOP_COLUMNS="${HTOP_COLUMNS:-PID,PERCENT_CPU,PERCENT_MEM,USER,TIME,COMMAND}"
    export HTOP_SORT_BY="${HTOP_SORT_BY:-PERCENT_CPU}"
    export HTOP_TREE="${HTOP_TREE:-0}"
fi

if command -v btop >/dev/null 2>&1; then
    export BTOP_CONFIG="${BTOP_CONFIG:-$XDG_CONFIG_HOME/btop}"
    export BTOP_THEME="${BTOP_THEME:-Nord}"
    export BTOP_UPDATE_INTERVAL="${BTOP_UPDATE_INTERVAL:-2000}"
    export BTOP_LOG_LEVEL="${BTOP_LOG_LEVEL:-WARNING}"
fi

if command -v glances >/dev/null 2>&1; then
    export GLANCES_CONFIG="${GLANCES_CONFIG:-$XDG_CONFIG_HOME/glances/glances.conf}"
    export GLANCES_THEME="${GLANCES_THEME:-dark}"
    export GLANCES_TIME="${GLANCES_TIME:-3}"
    export GLANCES_EXPORT="${GLANCES_EXPORT:-}"
fi

if command -v nmon >/dev/null 2>&1; then
    export NMON_CONFIG="${NMON_CONFIG:-$XDG_CONFIG_HOME/nmon}"
    export NMON_MODE="${NMON_MODE:-}"
    export NMON_DEBUG="${NMON_DEBUG:-0}"
fi

if command -v iotop >/dev/null 2>&1; then
    export IOTOP_CONFIG="${IOTOP_CONFIG:-$XDG_CONFIG_HOME/iotop}"
    export IOTOP_DELAY="${IOTOP_DELAY:-1}"
    export IOTOP_ACCUMULATED="${IOTOP_ACCUMULATED:-0}"
fi

if command -v iftop >/dev/null 2>&1; then
    export IFTOP_CONFIG="${IFTOP_CONFIG:-$HOME/.iftoprc}"
    export IFTOP_INTERFACE="${IFTOP_INTERFACE:-}"
    export IFTOP_FILTER="${IFTOP_FILTER:-}"
fi

if command -v iperf3 >/dev/null 2>&1; then
    export IPERF3_CONFIG="${IPERF3_CONFIG:-$XDG_CONFIG_HOME/iperf3}"
    export IPERF3_PORT="${IPERF3_PORT:-5201}"
    export IPERF3_TIME="${IPERF3_TIME:-10}"
    export IPERF3_PARALLEL="${IPERF3_PARALLEL:-1}"
fi

# -----------------------------------------------------------------------------
# NETWORK
# -----------------------------------------------------------------------------

if command -v nmap >/dev/null 2>&1; then
    export NMAPDIR="${NMAPDIR:-$XDG_DATA_HOME/nmap}"
    export NMAP_ARGS="${NMAP_ARGS:-}"
    export NMAP_OUTPUT_DIR="${NMAP_OUTPUT_DIR:-$XDG_DATA_HOME/nmap/scans}"
fi

if command -v tcpdump >/dev/null 2>&1; then
    export TCPDUMP_CONFIG="${TCPDUMP_CONFIG:-$XDG_CONFIG_HOME/tcpdump}"
    export TCPDUMP_INTERFACE="${TCPDUMP_INTERFACE:-}"
    export TCPDUMP_SNAPLEN="${TCPDUMP_SNAPLEN:-262144}"
    export TCPDUMP_VERBOSE="${TCPDUMP_VERBOSE:-1}"
fi

if command -v mitmproxy >/dev/null 2>&1; then
    export MITMPROXY_CONFIG_DIR="${MITMPROXY_CONFIG_DIR:-$XDG_CONFIG_HOME/mitmproxy}"
    export MITMPROXY_LISTEN_HOST="${MITMPROXY_LISTEN_HOST:-127.0.0.1}"
    export MITMPROXY_LISTEN_PORT="${MITMPROXY_LISTEN_PORT:-8080}"
    export MITMPROXY_MODE="${MITMPROXY_MODE:-regular}"
    export MITMPROXY_SSL_INSECURE="${MITMPROXY_SSL_INSECURE:-false}"
fi

if command -v ngrok >/dev/null 2>&1; then
    export NGROK_CONFIG="${NGROK_CONFIG:-$XDG_CONFIG_HOME/ngrok/ngrok.yml}"
    export NGROK_AUTHTOKEN="${NGROK_AUTHTOKEN:-}"
    export NGROK_DOMAIN="${NGROK_DOMAIN:-}"
    export NGROK_REGION="${NGROK_REGION:-us}"
    export NGROK_LOG="${NGROK_LOG:-$XDG_STATE_HOME/ngrok/ngrok.log}"
fi

if command -v cloudflared >/dev/null 2>&1; then
    export CLOUDFLARED_CONFIG_DIR="${CLOUDFLARED_CONFIG_DIR:-$XDG_CONFIG_HOME/cloudflared}"
    export TUNNEL_CRED_FILE="${TUNNEL_CRED_FILE:-$CLOUDFLARED_CONFIG_DIR/credentials.json}"
    export TUNNEL_METRICS="${TUNNEL_METRICS:-localhost:8081}"
    export TUNNEL_TRANSPORT_PROTOCOL="${TUNNEL_TRANSPORT_PROTOCOL:-auto}"
fi

if command -v dog >/dev/null 2>&1; then
    export DOG_DOH_URL="${DOG_DOH_URL:-https://dns.cloudflare.com/dns-query}"
    export DOG_DOT_ADDR="${DOG_DOT_ADDR:-1.1.1.1:853}"
    export DOG_NAMESERVER="${DOG_NAMESERVER:-1.1.1.1}"
    export DOG_TIMEOUT="${DOG_TIMEOUT:-5}"
    export DOG_COLORS="${DOG_COLORS:-auto}"
fi

# -----------------------------------------------------------------------------
# FILE MANAGEMENT
# -----------------------------------------------------------------------------

if command -v yazi >/dev/null 2>&1; then
    export YAZI_CONFIG_DIR="${YAZI_CONFIG_DIR:-$XDG_CONFIG_HOME/yazi}"
    export YAZI_CACHE_DIR="${YAZI_CACHE_DIR:-$XDG_CACHE_HOME/yazi}"
    export YAZI_LOG_DIR="${YAZI_LOG_DIR:-$XDG_STATE_HOME/yazi}"
    export YAZI_LOGGER="${YAZI_LOGGER:-0}"
fi

if command -v ranger >/dev/null 2>&1; then
    export RANGER_LOAD_DEFAULT_RC="${RANGER_LOAD_DEFAULT_RC:-FALSE}"
    export RANGER_CONFIG_DIR="${RANGER_CONFIG_DIR:-$XDG_CONFIG_HOME/ranger}"
    export RANGER_DATA_DIR="${RANGER_DATA_DIR:-$XDG_DATA_HOME/ranger}"
    export RANGER_CACHE_DIR="${RANGER_CACHE_DIR:-$XDG_CACHE_HOME/ranger}"
fi

if command -v lf >/dev/null 2>&1; then
    export LF_CONFIG_DIR="${LF_CONFIG_DIR:-$XDG_CONFIG_HOME/lf}"
    export LF_CACHE_DIR="${LF_CACHE_DIR:-$XDG_CACHE_HOME/lf}"
    export LF_DATA_DIR="${LF_DATA_DIR:-$XDG_DATA_HOME/lf}"
    export LF_ICONS="${LF_ICONS:-0}"
fi

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

if command -v mc >/dev/null 2>&1; then
    export MC_SKIN="${MC_SKIN:-$XDG_CONFIG_HOME/mc/skins/default.ini}"
    export MC_COLOR_TABLE="${MC_COLOR_TABLE:-gray-green}"
    export MC_TMPDIR="${MC_TMPDIR:-$TMPDIR}"
    export MC_EXT_CD="${MC_EXT_CD:-1}"
    export MC_EDITOR="${MC_EDITOR:-$EDITOR}"
    export MC_PAGER="${MC_PAGER:-$PAGER}"
fi

if command -v broot >/dev/null 2>&1; then
    export BROOT_CONFIG_DIR="${BROOT_CONFIG_DIR:-$XDG_CONFIG_HOME/broot}"
    export BROOT_CACHE_DIR="${BROOT_CACHE_DIR:-$XDG_CACHE_HOME/broot}"
    export BROOT_ICONS="${BROOT_ICONS:-0}"
    export BROOT_COLORS="${BROOT_COLORS:-truecolor}"
fi

if command -v joshuto >/dev/null 2>&1; then
    export JOSHUTO_CONFIG_DIR="${JOSHUTO_CONFIG_DIR:-$XDG_CONFIG_HOME/joshuto}"
    export JOSHUTO_CACHE_DIR="${JOSHUTO_CACHE_DIR:-$XDG_CACHE_HOME/joshuto}"
    export JOSHUTO_PREVIEW="${JOSHUTO_PREVIEW:-1}"
    export JOSHUTO_SHOW_HIDDEN="${JOSHUTO_SHOW_HIDDEN:-1}"
fi

# -----------------------------------------------------------------------------
# SECURITY
# -----------------------------------------------------------------------------

if command -v gpg >/dev/null 2>&1; then
    export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
    export GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"
    export GPG_PINENTRY="${GPG_PINENTRY:-pinentry-curses}"
    export GPG_KEY_ID="${GPG_KEY_ID:-}"
    export GPG_SIGN_KEY="${GPG_SIGN_KEY:-}"
    export GPG_ENCRYPT_KEY="${GPG_ENCRYPT_KEY:-}"
fi

if command -v openssl >/dev/null 2>&1; then
    export OPENSSL_CONF="${OPENSSL_CONF:-/etc/ssl/openssl.cnf}"
    export OPENSSL_MODULES="${OPENSSL_MODULES:-/usr/lib/openssl/engines}"
    export SSL_CERT_DIR="${SSL_CERT_DIR:-/etc/ssl/certs}"
    export SSL_CERT_FILE="${SSL_CERT_FILE:-/etc/ssl/certs/ca-certificates.crt}"
    export RANDFILE="${RANDFILE:-$HOME/.rnd}"
fi

if command -v age >/dev/null 2>&1; then
    export AGE_KEY_FILE="${AGE_KEY_FILE:-$XDG_CONFIG_HOME/age/keys.txt}"
    export AGE_RECIPIENTS_FILE="${AGE_RECIPIENTS_FILE:-}"
    export AGE_ENCRYPT_ARGS="${AGE_ENCRYPT_ARGS:-}"
    export AGE_DECRYPT_ARGS="${AGE_DECRYPT_ARGS:-}"
fi

if command -v sops >/dev/null 2>&1; then
    export SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:-$AGE_KEY_FILE}"
    export SOPS_AGE_RECIPIENTS="${SOPS_AGE_RECIPIENTS:-}"
    export SOPS_KMS_ARN="${SOPS_KMS_ARN:-}"
    export SOPS_GCP_KMS_IDS="${SOPS_GCP_KMS_IDS:-}"
    export SOPS_PGP_FP="${SOPS_PGP_FP:-}"
fi

if command -v cosign >/dev/null 2>&1; then
    export COSIGN_PASSWORD="${COSIGN_PASSWORD:-}"
    export COSIGN_KEY="${COSIGN_KEY:-}"
    export COSIGN_REPOSITORY="${COSIGN_REPOSITORY:-}"
    export COSIGN_EXPERIMENTAL="${COSIGN_EXPERIMENTAL:-false}"
    export COSIGN_TLOG="${COSIGN_TLOG:-true}"
fi

if command -v grype >/dev/null 2>&1; then
    export GRYPE_CONFIG="${GRYPE_CONFIG:-$XDG_CONFIG_HOME/grype/config.yaml}"
    export GRYPE_DB_CACHE_DIR="${GRYPE_DB_CACHE_DIR:-$XDG_CACHE_HOME/grype/db}"
    export GRYPE_CHECK_FOR_APP_UPDATE="${GRYPE_CHECK_FOR_APP_UPDATE:-false}"
    export GRYPE_OUTPUT="${GRYPE_OUTPUT:-table}"
fi

if command -v syft >/dev/null 2>&1; then
    export SYFT_CONFIG="${SYFT_CONFIG:-$XDG_CONFIG_HOME/syft/config.yaml}"
    export SYFT_CACHE_DIR="${SYFT_CACHE_DIR:-$XDG_CACHE_HOME/syft}"
    export SYFT_CHECK_FOR_APP_UPDATE="${SYFT_CHECK_FOR_APP_UPDATE:-false}"
    export SYFT_OUTPUT="${SYFT_OUTPUT:-table}"
fi

if command -v trivy >/dev/null 2>&1; then
    export TRIVY_CONFIG="${TRIVY_CONFIG:-$XDG_CONFIG_HOME/trivy/trivy.yaml}"
    export TRIVY_CACHE_DIR="${TRIVY_CACHE_DIR:-$XDG_CACHE_HOME/trivy}"
    export TRIVY_DB_REPOSITORY="${TRIVY_DB_REPOSITORY:-ghcr.io/aquasecurity/trivy-db}"
    export TRIVY_SKIP_DB_UPDATE="${TRIVY_SKIP_DB_UPDATE:-false}"
    export TRIVY_SEVERITY="${TRIVY_SEVERITY:-UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL}"
    export TRIVY_FORMAT="${TRIVY_FORMAT:-table}"
    export TRIVY_EXIT_CODE="${TRIVY_EXIT_CODE:-1}"
    export TRIVY_QUIET="${TRIVY_QUIET:-false}"
fi

# -----------------------------------------------------------------------------
# DEV TOOLS
# -----------------------------------------------------------------------------

if command -v jq >/dev/null 2>&1; then
    export JQ_COLORS="${JQ_COLORS:-2;36:4;33:5;37:7;34:1;35:1;32}"
    export JQ_LIBRARY_PATH="${JQ_LIBRARY_PATH:-$XDG_DATA_HOME/jq/modules}"
    export JQ_INDENT="${JQ_INDENT:-2}"
    export JQ_SORT_KEYS="${JQ_SORT_KEYS:-false}"
fi

if command -v yq >/dev/null 2>&1; then
    export YQ_CONFIG="${YQ_CONFIG:-$XDG_CONFIG_HOME/yq/config.yml}"
    export YQ_COLUMNS="${YQ_COLUMNS:-100}"
    export YQ_INDENT="${YQ_INDENT:-2}"
    export YQ_OUTPUT_FORMAT="${YQ_OUTPUT_FORMAT:-yaml}"
fi

if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-rg --files --hidden --follow --no-ignore-vcs}"
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=16 --height=40% --layout=reverse --border}"
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-$FZF_DEFAULT_COMMAND}"
    export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:---sort}"
    export FZF_COMPLETION_TRIGGER="${FZF_COMPLETION_TRIGGER:-**}"
    export FZF_PREVIEW_WINDOW="${FZF_PREVIEW_WINDOW:-right:60%:wrap}"
fi

if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="${BAT_THEME:-Nord}"
    export BAT_STYLE="${BAT_STYLE:-numbers,changes}"
    export BAT_CONFIG_PATH="${BAT_CONFIG_PATH:-$XDG_CONFIG_HOME/bat/config}"
    export BAT_CACHE_PATH="${BAT_CACHE_PATH:-$XDG_CACHE_HOME/bat}"
    export BAT_TABS="${BAT_TABS:-4}"
    export BAT_PAGER="${BAT_PAGER:-less -RFX}"
fi

if command -v rg >/dev/null 2>&1; then
    export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgrep/ripgreprc}"
    export RG_SHOW_CONTEXT="${RG_SHOW_CONTEXT:-2}"
    export RG_NO_IGNORE="${RG_NO_IGNORE:-false}"
    export RG_HIDDEN="${RG_HIDDEN:-true}"
    export RG_PRETTY="${RG_PRETTY:-never}"
    export RG_NUMLINES="${RG_NUMLINES:-true}"
    export RG_HEADING="${RG_HEADING:-true}"
    export RG_SMART_CASE="${RG_SMART_CASE:-true}"
fi

if command -v fd >/dev/null 2>&1; then
    export FD_CONFIG_PATH="${FD_CONFIG_PATH:-$XDG_CONFIG_HOME/fd/fdignore}"
    export FD_MAX_DEPTH="${FD_MAX_DEPTH:-}"
    export FD_HIDDEN="${FD_HIDDEN:-false}"
    export FD_NO_IGNORE="${FD_NO_IGNORE:-false}"
    export FD_FOLLOW="${FD_FOLLOW:-false}"
    export FD_CASE_SENSITIVE="${FD_CASE_SENSITIVE:-false}"
    export FD_TYPE="${FD_TYPE:-}"
    export FD_THREADS="${FD_THREADS:-}"
fi

if command -v eza >/dev/null 2>&1; then
    export EZA_COLORS="${EZA_COLORS:-di=36:ex=32}"
    export EZA_ICONS="${EZA_ICONS:-auto}"
    export EZA_COLOR_MODE="${EZA_COLOR_MODE:-auto}"
    export EZA_ICON_SPACING="${EZA_ICON_SPACING:-1}"
    export EZA_TIME_STYLE="${EZA_TIME_STYLE:-iso}"
fi

if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DATA_DIR="${_ZO_DATA_DIR:-$XDG_DATA_HOME/zoxide}"
    export _ZO_EXCLUDE_DIRS="${_ZO_EXCLUDE_DIRS:-}"
    export _ZO_FZF_OPTS="${_ZO_FZF_OPTS:-}"
    export _ZO_ECHO="${_ZO_ECHO:-0}"
    export _ZO_RESOLVE_SYMLINKS="${_ZO_RESOLVE_SYMLINKS:-0}"
    export _ZO_MAX_RESULTS="${_ZO_MAX_RESULTS:-10000}"
fi

if command -v starship >/dev/null 2>&1; then
    export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship.toml}"
    export STARSHIP_CACHE="${STARSHIP_CACHE:-$XDG_CACHE_HOME/starship}"
    export STARSHIP_LOG="${STARSHIP_LOG:-}"
    export STARSHIP_SHELL="${STARSHIP_SHELL:-zsh}"
fi

if command -v atuin >/dev/null 2>&1; then
    export ATUIN_CONFIG_DIR="${ATUIN_CONFIG_DIR:-$XDG_CONFIG_HOME/atuin}"
    export ATUIN_DATA_DIR="${ATUIN_DATA_DIR:-$XDG_DATA_HOME/atuin}"
    export ATUIN_DB_PATH="${ATUIN_DB_PATH:-$ATUIN_DATA_DIR/history.db}"
    export ATUIN_NO_ENTRY="${ATUIN_NO_ENTRY:-false}"
    export ATUIN_HISTORY_LIMIT="${ATUIN_HISTORY_LIMIT:-50000}"
fi

# -----------------------------------------------------------------------------
# MEDIA
# -----------------------------------------------------------------------------


# =============================================================================
# FFmpeg - Complete multimedia framework
# =============================================================================


if command -v ffmpeg >/dev/null 2>&1; then
    export FFMPEG_DATADIR="${FFMPEG_DATADIR:-$XDG_DATA_HOME/ffmpeg}"
    export FFREPORT="${FFREPORT:-}"
    export FFREPORT_FILE="${FFREPORT_FILE:-$XDG_STATE_HOME/ffmpeg/ffreport.log}"
    export AV_LOG_FORCE_COLOR="${AV_LOG_FORCE_COLOR:-1}"
fi

# =============================================================================

# =============================================================================


if command -v yt-dlp >/dev/null 2>&1; then
    export YT_DLP_CONFIG="${YT_DLP_CONFIG:-$XDG_CONFIG_HOME/yt-dlp/config}"
    export YT_DLP_CACHE_DIR="${YT_DLP_CACHE_DIR:-$XDG_CACHE_HOME/yt-dlp}"
    export YT_DLP_HOME="${YT_DLP_HOME:-$XDG_DATA_HOME/yt-dlp}"
    export YT_DLP_OUTPUT_TEMPLATE="${YT_DLP_OUTPUT_TEMPLATE:-%(title)s.%(ext)s}"
    export YT_DLP_DEFAULT_FORMAT="${YT_DLP_DEFAULT_FORMAT:-bestvideo[height<=?1080]+bestaudio/best}"
    export YT_DLP_RETRIES="${YT_DLP_RETRIES:-10}"
fi

# =============================================================================
# MPV - Cross-platform media player
# =============================================================================


if command -v mpv >/dev/null 2>&1; then
    export MPV_HOME="${MPV_HOME:-$XDG_CONFIG_HOME/mpv}"
    export MPV_CACHE_DIR="${MPV_CACHE_DIR:-$XDG_CACHE_HOME/mpv}"
    export MPV_SCRIPT_DIR="${MPV_SCRIPT_DIR:-$MPV_HOME/scripts}"
    export MPV_INPUT_CONF="${MPV_INPUT_CONF:-$MPV_HOME/input.conf}"
    export MPV_LOG_FILE="${MPV_LOG_FILE:-$XDG_STATE_HOME/mpv/mpv.log}"
    export MPV_GPU_API="${MPV_GPU_API:-auto}"
fi

# =============================================================================
# ImageMagick - Image manipulation suite
# =============================================================================


if command -v magick >/dev/null 2>&1; then
    export MAGICK_HOME="${MAGICK_HOME:-/usr}"
    export MAGICK_CONFIGURE_PATH="${MAGICK_CONFIGURE_PATH:-$XDG_CONFIG_HOME/ImageMagick}"
    export MAGICK_TMPDIR="${MAGICK_TMPDIR:-$TMPDIR}"
    export MAGICK_MEMORY_LIMIT="${MAGICK_MEMORY_LIMIT:-256MiB}"
    export MAGICK_MAP_LIMIT="${MAGICK_MAP_LIMIT:-512MiB}"
    export MAGICK_DISK_LIMIT="${MAGICK_DISK_LIMIT:-1GiB}"
    export MAGICK_THREAD_LIMIT="${MAGICK_THREAD_LIMIT:-$(nproc 2>/dev/null || echo 4)}"
fi

# =============================================================================
# ExifTool - Metadata reading/writing tool
# =============================================================================


if command -v exiftool >/dev/null 2>&1; then
    export EXIFTOOL_HOME="${EXIFTOOL_HOME:-/usr/share/exiftool}"
    export EXIFTOOL_CONFIG="${EXIFTOOL_CONFIG:-$XDG_CONFIG_HOME/exiftool/exiftool.cfg}"
    export EXIFTOOL_VERBOSE="${EXIFTOOL_VERBOSE:-0}"
    export EXIFTOOL_CHARSET="${EXIFTOOL_CHARSET:-UTF8}"
    export EXIFTOOL_DATE_FORMAT="${EXIFTOOL_DATE_FORMAT:-%Y:%m:%d %H:%M:%S}"
fi

# =============================================================================
# Audacity - Audio editing software
# =============================================================================


if command -v audacity >/dev/null 2>&1; then
    export AUDACITY_CONFIG_DIR="${AUDACITY_CONFIG_DIR:-$XDG_CONFIG_HOME/audacity}"
    export AUDACITY_DATA_DIR="${AUDACITY_DATA_DIR:-$XDG_DATA_HOME/audacity}"
    export AUDACITY_CACHE_DIR="${AUDACITY_CACHE_DIR:-$XDG_CACHE_HOME/audacity}"
    export AUDACITY_TEMP_DIR="${AUDACITY_TEMP_DIR:-$TMPDIR}"
fi

# -----------------------------------------------------------------------------
# TERMINAL
# -----------------------------------------------------------------------------


# =============================================================================
# Tmux - Terminal multiplexer
# =============================================================================


if command -v tmux >/dev/null 2>&1; then
    export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
    export TMUX_TMPDIR="${TMUX_TMPDIR:-$XDG_RUNTIME_DIR/tmux}"
    export TMUX_CONF="${TMUX_CONF:-$TMUX_CONFIG}"
    export TMUX_PLUGIN_MANAGER_PATH="${TMUX_PLUGIN_MANAGER_PATH:-$XDG_DATA_HOME/tmux/plugins}"
    export TMUX_DEFAULT_SESSION="${TMUX_DEFAULT_SESSION:-main}"
    export TMUX_DEFAULT_COMMAND="${TMUX_DEFAULT_COMMAND:-$SHELL}"
    export TMUX_DEFAULT_TERM="${TMUX_DEFAULT_TERM:-tmux-256color}"
fi

# =============================================================================
# Zellij - Terminal workspace with layouts
# =============================================================================


if command -v zellij >/dev/null 2>&1; then
    export ZELLIJ_CONFIG_DIR="${ZELLIJ_CONFIG_DIR:-$XDG_CONFIG_HOME/zellij}"
    export ZELLIJ_CACHE_DIR="${ZELLIJ_CACHE_DIR:-$XDG_CACHE_HOME/zellij}"
    export ZELLIJ_DATA_DIR="${ZELLIJ_DATA_DIR:-$XDG_DATA_HOME/zellij}"
    export ZELLIJ_MODE="${ZELLIJ_MODE:-normal}"
    export ZELLIJ_LAYOUT="${ZELLIJ_LAYOUT:-$ZELLIJ_CONFIG_DIR/layouts/default.kdl}"
    export ZELLIJ_LOG_FILE="${ZELLIJ_LOG_FILE:-$XDG_STATE_HOME/zellij/zellij.log}"
fi

# =============================================================================
# GNU Screen - Terminal multiplexer
# =============================================================================


if command -v screen >/dev/null 2>&1; then
    export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"
    export SYSSCREENRC="${SYSSCREENRC:-/etc/screenrc}"
    export SCREEN_TMP_DIR="${SCREEN_TMP_DIR:-$XDG_RUNTIME_DIR/screen}"
    export SCREEN_TERM="${SCREEN_TERM:-screen-256color}"
fi

# =============================================================================
# Kitty - GPU-accelerated terminal emulator
# =============================================================================


if command -v kitty >/dev/null 2>&1; then
    export KITTY_CONFIG_DIRECTORY="${KITTY_CONFIG_DIRECTORY:-$XDG_CONFIG_HOME/kitty}"
    export KITTY_CACHE_DIRECTORY="${KITTY_CACHE_DIRECTORY:-$XDG_CACHE_HOME/kitty}"
    export KITTY_THEME="${KITTY_THEME:-}"
    export KITTY_FONT_SIZE="${KITTY_FONT_SIZE:-}"
    export KITTY_SHELL_INTEGRATION="${KITTY_SHELL_INTEGRATION:-enabled}"
fi

# =============================================================================
# Alacritty - GPU-accelerated terminal emulator
# =============================================================================


if command -v alacritty >/dev/null 2>&1; then
    export ALACRITTY_CONFIG="${ALACRITTY_CONFIG:-$XDG_CONFIG_HOME/alacritty/alacritty.toml}"
    export ALACRITTY_LOG_FILE="${ALACRITTY_LOG_FILE:-$XDG_STATE_HOME/alacritty/alacritty.log}"
    export ALACRITTY_THEME="${ALACRITTY_THEME:-}"
    export ALACRITTY_FONT_SIZE="${ALACRITTY_FONT_SIZE:-}"
fi

# =============================================================================
# WezTerm - GPU-accelerated terminal emulator
# =============================================================================


if command -v wezterm >/dev/null 2>&1; then
    export WEZTERM_CONFIG_DIR="${WEZTERM_CONFIG_DIR:-$XDG_CONFIG_HOME/wezterm}"
    export WEZTERM_CONFIG_FILE="${WEZTERM_CONFIG_FILE:-$WEZTERM_CONFIG_DIR/wezterm.lua}"
    export WEZTERM_CACHE_DIR="${WEZTERM_CACHE_DIR:-$XDG_CACHE_HOME/wezterm}"
    export WEZTERM_DATA_DIR="${WEZTERM_DATA_DIR:-$XDG_DATA_HOME/wezterm}"
    export WEZTERM_LOG_FILE="${WEZTERM_LOG_FILE:-$XDG_STATE_HOME/wezterm/wezterm.log}"
    export WEZTERM_COLOR_SCHEME="${WEZTERM_COLOR_SCHEME:-}"
    export WEZTERM_FRONTEND="${WEZTERM_FRONTEND:-}"
fi

# =============================================================================
# Ghostty - Fast, feature-rich terminal emulator
# =============================================================================


if command -v ghostty >/dev/null 2>&1; then
    export GHOSTTY_CONFIG_DIR="${GHOSTTY_CONFIG_DIR:-$XDG_CONFIG_HOME/ghostty}"
    export GHOSTTY_CONFIG_FILE="${GHOSTTY_CONFIG_FILE:-$GHOSTTY_CONFIG_DIR/config}"
    export GHOSTTY_CACHE_DIR="${GHOSTTY_CACHE_DIR:-$XDG_CACHE_HOME/ghostty}"
    export GHOSTTY_DATA_DIR="${GHOSTTY_DATA_DIR:-$XDG_DATA_HOME/ghostty}"
    export GHOSTTY_LOG_FILE="${GHOSTTY_LOG_FILE:-$XDG_STATE_HOME/ghostty/ghostty.log}"
    export GHOSTTY_LOG_LEVEL="${GHOSTTY_LOG_LEVEL:-info}"
    export GHOSTTY_THEME="${GHOSTTY_THEME:-}"
fi

# -----------------------------------------------------------------------------
