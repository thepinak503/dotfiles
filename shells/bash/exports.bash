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




# =============================================================================
# EDITORS
# =============================================================================





# VIMCONFIG — config directory
if command -v nvim >/dev/null 2>&1; then
    export NVIM_APPNAME="${NVIM_APPNAME:-nvim}"
    export NVIM_LOG_FILE="${NVIM_LOG_FILE:-$XDG_STATE_HOME/nvim/log}"
    export VIMCONFIG="${VIMCONFIG:-$XDG_CONFIG_HOME/nvim}"
fi



# VIM — system runtime files
# VIMRUNTIME — runtime directory
# VIMINIT — initialization commands
if command -v vim >/dev/null 2>&1; then
    export VIM="${VIM:-/usr/share/vim}"
    export VIMRUNTIME="${VIMRUNTIME:-$VIM/vim91}"
    export VIMINIT="${VIMINIT:-}"
fi



# EMACS — t when running inside Emacs

# EMACSDATA — data files
# EMACSDOC — documentation files
if command -v emacs >/dev/null 2>&1; then
    export EMACS="${EMACS:-t}"
    export INSIDE_EMACS="${INSIDE_EMACS:-$EMACS}"
    export EMACSDATA="${EMACSDATA:-/usr/share/emacs}"
    export EMACSDOC="${EMACSDOC:-/usr/share/emacs/doc}"
fi






if command -v code >/dev/null 2>&1; then
    export VSCODE_CLI="${VSCODE_CLI:-1}"
    export SERVICE_URL="${SERVICE_URL:-https://open-vsx.org/vscode/gallery}"
    export ITEM_URL="${ITEM_URL:-https://open-vsx.org/vscode/item}"
fi

# =============================================================================
# RUNTIMES
# =============================================================================




# GOBIN — binaries directory
# GOPROXY — module proxy
# GOMODCACHE — cached modules

if command -v go >/dev/null 2>&1; then
    export GOPATH="${GOPATH:-$HOME/.go}"
    export GOBIN="${GOBIN:-$GOPATH/bin}"
    export GOPROXY="${GOPROXY:-https://proxy.golang.org,direct}"
    export GOMODCACHE="${GOMODCACHE:-$GOPATH/pkg/mod}"
    export CGO_ENABLED="${CGO_ENABLED:-1}"
    export PATH="$GOBIN${PATH:+:$PATH}"
fi







if command -v rustc >/dev/null 2>&1; then
    export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
    export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
    export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-}"
    export CARGO_NET_GIT_FETCH_WITH_CLI="${CARGO_NET_GIT_FETCH_WITH_CLI:-true}"
    export PATH="$CARGO_HOME/bin${PATH:+:$PATH}"
fi






if command -v node >/dev/null 2>&1; then
    export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/repl_history}"
    export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"
    export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.npm-global}"
    export PATH="$NPM_CONFIG_PREFIX/bin${PATH:+:$PATH}"
fi



# PYTHONSTARTUP — startup script




if command -v python3 >/dev/null 2>&1; then
    export PYTHONSTARTUP="${PYTHONSTARTUP:-$XDG_CONFIG_HOME/python/pythonrc}"
    export PYTHONPYCACHEPREFIX="${PYTHONPYCACHEPREFIX:-$XDG_CACHE_HOME/python}"
    export PYTHONDONTWRITEBYTECODE="${PYTHONDONTWRITEBYTECODE:-1}"
    export PIP_CACHE_DIR="${PIP_CACHE_DIR:-$XDG_CACHE_HOME/pip}"
    export PYTHON_HISTORY="${PYTHON_HISTORY:-$XDG_STATE_HOME/python/history}"
fi








if command -v ruby >/dev/null 2>&1; then
    export GEM_HOME="${GEM_HOME:-$HOME/.gem}"
    export GEM_PATH="${GEM_PATH:-$GEM_HOME}"
    export RBENV_ROOT="${RBENV_ROOT:-$XDG_DATA_HOME/rbenv}"
    export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
    export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
    export PATH="$GEM_HOME/bin${PATH:+:$PATH}"
fi







if command -v java >/dev/null 2>&1; then
    export JAVA_HOME="${JAVA_HOME:-$(dirname "$(dirname "$(readlink -f "$(which java)")")")}"
    export _JAVA_OPTIONS="${_JAVA_OPTIONS:--Djava.awt.headless=true}"
    export GRADLE_OPTS="${GRADLE_OPTS:--Dorg.gradle.daemon=true -Dorg.gradle.parallel=true}"
    export MAVEN_OPTS="${MAVEN_OPTS:--Dmaven.artifact.threads=4}"
fi







if command -v julia >/dev/null 2>&1; then
    export JULIA_DEPOT_PATH="${JULIA_DEPOT_PATH:-$XDG_DATA_HOME/julia}"
    export JULIA_PROJECT="${JULIA_PROJECT:-@.}"
    export JULIA_NUM_THREADS="${JULIA_NUM_THREADS:-$(nproc 2>/dev/null || echo 4)}"
    export JULIA_EDITOR="${JULIA_EDITOR:-$EDITOR}"
fi

# =============================================================================
# CONTAINERS
# =============================================================================








if command -v docker >/dev/null 2>&1; then
    export DOCKER_HOST="${DOCKER_HOST:-unix:///run/user/$UID/docker.sock}"
    export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
    export DOCKER_CONTENT_TRUST="${DOCKER_CONTENT_TRUST:-0}"
    export DOCKER_CERT_PATH="${DOCKER_CERT_PATH:-$DOCKER_CONFIG/certs}"
    export DOCKER_TMPDIR="${DOCKER_TMPDIR:-$XDG_CACHE_HOME/docker}"
fi





if command -v podman >/dev/null 2>&1; then
    export DOCKER_HOST="${DOCKER_HOST:-unix://$XDG_RUNTIME_DIR/podman/podman.sock}"
    export PODMAN_IGNORE_CGROUPSV1_WARNING="${PODMAN_IGNORE_CGROUPSV1_WARNING:-0}"
fi





if command -v nerdctl >/dev/null 2>&1; then
    export CONTAINERD_ADDRESS="${CONTAINERD_ADDRESS:-/run/containerd/containerd.sock}"
    export CONTAINERD_NAMESPACE="${CONTAINERD_NAMESPACE:-default}"
fi





if command -v skopeo >/dev/null 2>&1; then
    export SKOPEO_CERT_DIR="${SKOPEO_CERT_DIR:-/etc/containers/certs.d}"
    export SKOPEO_POLICY="${SKOPEO_POLICY:-/etc/containers/policy.json}"
fi

# =============================================================================
# ORCHESTRATION
# =============================================================================







if command -v kubectl >/dev/null 2>&1; then
    export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
    export KUBE_EDITOR="${KUBE_EDITOR:-nvim}"
    export KUBECTL_EXTERNAL_DIFF="${KUBECTL_EXTERNAL_DIFF:-diff}"
    export KUBE_CACHEDIR="${KUBE_CACHEDIR:-$XDG_CACHE_HOME/kube}"
fi








if command -v helm >/dev/null 2>&1; then
    export HELM_CACHE_HOME="${HELM_CACHE_HOME:-$XDG_CACHE_HOME/helm}"
    export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-$XDG_CONFIG_HOME/helm}"
    export HELM_DATA_HOME="${HELM_DATA_HOME:-$XDG_DATA_HOME/helm}"
    export HELM_KUBECONTEXT="${HELM_KUBECONTEXT:-}"
    export HELM_DRIVER="${HELM_DRIVER:-secret}"
fi





if command -v k9s >/dev/null 2>&1; then
    export K9S_CONFIG_DIR="${K9S_CONFIG_DIR:-$XDG_CONFIG_HOME/k9s}"
    export K9S_CACHE_DIR="${K9S_CACHE_DIR:-$XDG_CACHE_HOME/k9s}"
fi





if command -v kustomize >/dev/null 2>&1; then
    export KUSTOMIZE_PLUGIN_HOME="${KUSTOMIZE_PLUGIN_HOME:-$XDG_CONFIG_HOME/kustomize/plugin}"
    export KUSTOMIZE_CONFIG_HOME="${KUSTOMIZE_CONFIG_HOME:-$XDG_CONFIG_HOME/kustomize}"
fi






if command -v argocd >/dev/null 2>&1; then
    export ARGOCD_SERVER="${ARGOCD_SERVER:-}"
    export ARGOCD_OPTS="${ARGOCD_OPTS:---grpc-web}"
    export ARGOCD_AUTH_TOKEN="${ARGOCD_AUTH_TOKEN:-}"
fi

# =============================================================================
# CLOUD PLATFORMS
# =============================================================================








if command -v aws >/dev/null 2>&1; then
    export AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-$XDG_CONFIG_HOME/aws/config}"
    export AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-$XDG_CONFIG_HOME/aws/credentials}"
    export AWS_PROFILE="${AWS_PROFILE:-default}"
    export AWS_DEFAULT_OUTPUT="${AWS_DEFAULT_OUTPUT:-json}"
    export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
fi







if command -v gcloud >/dev/null 2>&1; then
    export CLOUDSDK_CONFIG="${CLOUDSDK_CONFIG:-$XDG_CONFIG_HOME/gcloud}"
    export CLOUDSDK_CORE_PROJECT="${CLOUDSDK_CORE_PROJECT:-}"
    export CLOUDSDK_COMPUTE_REGION="${CLOUDSDK_COMPUTE_REGION:-}"
    export CLOUDSDK_COMPUTE_ZONE="${CLOUDSDK_COMPUTE_ZONE:-}"
fi








if command -v terraform >/dev/null 2>&1; then
    export TF_PLUGIN_CACHE_DIR="${TF_PLUGIN_CACHE_DIR:-$XDG_CACHE_HOME/terraform/plugins}"
    export TF_CLI_ARGS="${TF_CLI_ARGS:--no-color}"
    export TF_IN_AUTOMATION="${TF_IN_AUTOMATION:-1}"
    export TF_LOG="${TF_LOG:-}"
    export TF_WORKSPACE="${TF_WORKSPACE:-default}"
fi








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







if command -v gh >/dev/null 2>&1; then
    export GH_CONFIG_DIR="${GH_CONFIG_DIR:-$XDG_CONFIG_HOME/gh}"
    export GH_EDITOR="${GH_EDITOR:-nvim}"
    export GH_HOST="${GH_HOST:-github.com}"
    export GH_PAGER="${GH_PAGER:-less}"
fi






if command -v glab >/dev/null 2>&1; then
    export GLAMOUR_STYLE="${GLAMOUR_STYLE:-dark}"
    export GITLAB_API_VERSION="${GITLAB_API_VERSION:-4}"
    export GLAB_CONFIG_DIR="${GLAB_CONFIG_DIR:-$XDG_CONFIG_HOME/glab}"
fi

# =============================================================================
# DATABASES
# =============================================================================








if command -v mysql >/dev/null 2>&1; then
    export MYSQL_HISTFILE="${MYSQL_HISTFILE:-$XDG_DATA_HOME/mysql/history}"
    export MYSQL_HOST="${MYSQL_HOST:-localhost}"
    export MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-3306}"
    export MYSQL_UNIX_PORT="${MYSQL_UNIX_PORT:-/run/mysqld/mysqld.sock}"
    export MYSQL_PS1="${MYSQL_PS1:-\\u@\\h [\\d]> }"
fi





# PGDATABASE — default database
# PGUSER — default user
# PGPASSFILE — password file

if command -v psql >/dev/null 2>&1; then
    export PGHOST="${PGHOST:-localhost}"
    export PGPORT="${PGPORT:-5432}"
    export PGDATABASE="${PGDATABASE:-}"
    export PGUSER="${PGUSER:-$USER}"
    export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
    export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_DATA_HOME/psql/history}"
fi





if command -v sqlite3 >/dev/null 2>&1; then
    export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"
    export SQLITE_TMPDIR="${SQLITE_TMPDIR:-$TMPDIR}"
fi







if command -v redis-cli >/dev/null 2>&1; then
    export REDISCLI_HISTFILE="${REDISCLI_HISTFILE:-$XDG_DATA_HOME/redis/history}"
    export REDISCLI_HISTFILESIZE="${REDISCLI_HISTFILESIZE:-10000}"
    export REDISCLI_AUTH="${REDISCLI_AUTH:-}"
    export REDISCLI_RAW="${REDISCLI_RAW:-}"
fi

# =============================================================================
# MONITORING
# =============================================================================




if command -v btop >/dev/null 2>&1; then
    export BTOP_CONFIG_DIR="${BTOP_CONFIG_DIR:-$XDG_CONFIG_HOME/btop}"
fi



# HTOPRC — configuration file
if command -v htop >/dev/null 2>&1; then
    export HTOPRC="${HTOPRC:-$XDG_CONFIG_HOME/htop/htoprc}"
fi

# =============================================================================
# NETWORK TOOLS
# =============================================================================



# NMAPDIR — data directory

if command -v nmap >/dev/null 2>&1; then
    export NMAPDIR="${NMAPDIR:-$XDG_DATA_HOME/nmap}"
    export NMAP_PRIVILEGED="${NMAP_PRIVILEGED:-}"
fi







if command -v ngrok >/dev/null 2>&1; then
    export NGROK_CONFIG="${NGROK_CONFIG:-$XDG_CONFIG_HOME/ngrok/ngrok.yml}"
    export NGROK_AUTHTOKEN="${NGROK_AUTHTOKEN:-}"
    export NGROK_REGION="${NGROK_REGION:-us}"
    export NGROK_ROOT="${NGROK_ROOT:-$XDG_DATA_HOME/ngrok}"
fi

# =============================================================================
# FILE MANAGEMENT
# =============================================================================





if command -v yazi >/dev/null 2>&1; then
    export YAZI_CONFIG_DIR="${YAZI_CONFIG_DIR:-$XDG_CONFIG_HOME/yazi}"
    export YAZI_CACHE_DIR="${YAZI_CACHE_DIR:-$XDG_CACHE_HOME/yazi}"
fi








if command -v nnn >/dev/null 2>&1; then
    export NNN_OPTS="${NNN_OPTS:-d}"
    export NNN_BMS="${NNN_BMS:-}"
    export NNN_USE_EDITOR="${NNN_USE_EDITOR:-1}"
    export NNN_TRASH="${NNN_TRASH:-1}"
    export NNN_PLUG="${NNN_PLUG:-}"
fi







if command -v mc >/dev/null 2>&1; then
    export MC_COLOR_TABLE="${MC_COLOR_TABLE:-gotar}"
    export MC_SKIN="${MC_SKIN:-}"
    export MC_EDITOR="${MC_EDITOR:-$EDITOR}"
    export MC_DIFF_VIEWER="${MC_DIFF_VIEWER:-diff}"
fi

# =============================================================================
# SECURITY
# =============================================================================





if command -v gpg >/dev/null 2>&1; then
    export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
    export GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"
fi






if command -v openssl >/dev/null 2>&1; then
    export OPENSSL_CONF="${OPENSSL_CONF:-/etc/ssl/openssl.cnf}"
    export OPENSSL_ENGINES="${OPENSSL_ENGINES:-/usr/lib/x86_64-linux-gnu/engines-3}"
    export OPENSSL_MODULES="${OPENSSL_MODULES:-/usr/lib/x86_64-linux-gnu/ossl-modules}"
fi





if command -v age >/dev/null 2>&1; then
    export AGE_KEY_FILE="${AGE_KEY_FILE:-$XDG_CONFIG_HOME/age/keys.txt}"
    export AGE_DIR="${AGE_DIR:-$XDG_CONFIG_HOME/age}"
fi







if command -v sops >/dev/null 2>&1; then
    export SOPS_AGE_KEY_FILE="${SOPS_AGE_KEY_FILE:-$AGE_KEY_FILE}"
    export SOPS_KMS_ARN="${SOPS_KMS_ARN:-}"
    export SOPS_GCP_KMS="${SOPS_GCP_KMS:-}"
    export SOPS_PGP_FP="${SOPS_PGP_FP:-}"
fi








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





if command -v jq >/dev/null 2>&1; then
    export JQ_COLORS="${JQ_COLORS:-0:31:0:0:0:32:0:0}"
    export JQ_LIBRARY_PATH="${JQ_LIBRARY_PATH:-$XDG_DATA_HOME/jq}"
fi








if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-fd --type f --hidden --follow --exclude .git}"
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=16 --height=40% --layout=reverse --border}"
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-fd --type f --hidden --follow --exclude .git}"
    export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-fd --type d --hidden --follow --exclude .git}"
    export FZF_TMUX_OPTS="${FZF_TMUX_OPTS:--p 55%,60%}"
fi








if command -v bat >/dev/null 2>&1; then
    export BAT_THEME="${BAT_THEME:-Nord}"
    export BAT_STYLE="${BAT_STYLE:-numbers,changes}"
    export BAT_CONFIG_PATH="${BAT_CONFIG_PATH:-$XDG_CONFIG_HOME/bat/config}"
    export BAT_PAGER="${BAT_PAGER:-less -RFX}"
    export BAT_CACHE_DIR="${BAT_CACHE_DIR:-$XDG_CACHE_HOME/bat}"
fi




if command -v rg >/dev/null 2>&1; then
    export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgreprc}"
fi





if command -v fd >/dev/null 2>&1; then
    export FD_CONFIG_PATH="${FD_CONFIG_PATH:-$XDG_CONFIG_HOME/fd/fdignore}"
    export FD_CACHE_DIR="${FD_CACHE_DIR:-$XDG_CACHE_HOME/fd}"
fi






if command -v eza >/dev/null 2>&1; then
    export EZA_COLORS="${EZA_COLORS:-di=36:ex=32}"
    export EZA_CONFIG_DIR="${EZA_CONFIG_DIR:-$XDG_CONFIG_HOME/eza}"
    export TIME_STYLE="${TIME_STYLE:-long-iso}"
fi







if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DATA_DIR="${_ZO_DATA_DIR:-$XDG_DATA_HOME/zoxide}"
    export _ZO_EXCLUDE_DIRS="${_ZO_EXCLUDE_DIRS:-/:/home/*/go/pkg}"
    export _ZO_RESOLVE_SYMLINKS="${_ZO_RESOLVE_SYMLINKS:-0}"
    export _ZO_ECHO="${_ZO_ECHO:-0}"
fi






if command -v starship >/dev/null 2>&1; then
    export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship.toml}"
    export STARSHIP_CACHE="${STARSHIP_CACHE:-$XDG_CACHE_HOME/starship}"
    export STARSHIP_SHELL="${STARSHIP_SHELL:-bash}"
fi

# =============================================================================
# MEDIA TOOLS
# =============================================================================




# FFREPORT — report logging

if command -v ffmpeg >/dev/null 2>&1; then
    export FFMPEG_DATADIR="${FFMPEG_DATADIR:-$XDG_DATA_HOME/ffmpeg}"
    export FFREPORT="${FFREPORT:-}"
    export AV_LOG_FORCE_NOCOLOR="${AV_LOG_FORCE_NOCOLOR:-0}"
fi






if command -v yt-dlp >/dev/null 2>&1; then
    export YT_DLP_CONFIG_HOME="${YT_DLP_CONFIG_HOME:-$XDG_CONFIG_HOME/yt-dlp}"
    export YT_DLP_CACHE_DIR="${YT_DLP_CACHE_DIR:-$XDG_CACHE_HOME/yt-dlp}"
    export YT_DLP_EXTERNAL_DOWNLOADER="${YT_DLP_EXTERNAL_DOWNLOADER:-}"
fi






if command -v mpv >/dev/null 2>&1; then
    export MPV_HOME="${MPV_HOME:-$XDG_CONFIG_HOME/mpv}"
    export MPV_SCRIPT_OPTS="${MPV_SCRIPT_OPTS:-}"
    export MPV_CONFIG_DIR="${MPV_CONFIG_DIR:-$XDG_CONFIG_HOME/mpv}"
fi








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





if command -v tmux >/dev/null 2>&1; then
    export TMUX_TMPDIR="${TMUX_TMPDIR:-$XDG_RUNTIME_DIR/tmux}"
    export TMUX_CONF="${TMUX_CONF:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
fi






if command -v zellij >/dev/null 2>&1; then
    export ZELLIJ_CONFIG_DIR="${ZELLIJ_CONFIG_DIR:-$XDG_CONFIG_HOME/zellij}"
    export ZELLIJ_LAYOUT_DIR="${ZELLIJ_LAYOUT_DIR:-$ZELLIJ_CONFIG_DIR/layouts}"
    export ZELLIJ_SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"
fi

# =============================================================================
# GIT AND DEVELOPMENT TOOLS
# =============================================================================












# =============================================================================
# Lazygit - Terminal UI for Git
# =============================================================================
































if command -v lazygit >/dev/null 2>&1; then
    export LG_CONFIG_FILE="${LG_CONFIG_FILE:-$XDG_CONFIG_HOME/lazygit/config.yml}"
    export GIT_SEQUENCE_EDITOR="${GIT_SEQUENCE_EDITOR:-lazygit}"
    export GIT_EDITOR="${GIT_EDITOR:-$EDITOR}"
fi

# =============================================================================
# Delta - Syntax-highlighting diff pager
# =============================================================================






























if command -v delta >/dev/null 2>&1; then
    export DELTA_FEATURES="${DELTA_FEATURES:-+line-numbers}"
    export DELTA_PAGER="${DELTA_PAGER:-less -RFX}"
    export DELTA_CONFIG_DIR="${DELTA_CONFIG_DIR:-$XDG_CONFIG_HOME/delta}"
fi

# =============================================================================
# Broot - File browser with tree view
# =============================================================================
































if command -v broot >/dev/null 2>&1; then
    export BROOT_CONFIG_DIR="${BROOT_CONFIG_DIR:-$XDG_CONFIG_HOME/broot}"
    export BROOT_CACHE_DIR="${BROOT_CACHE_DIR:-$XDG_CACHE_HOME/broot}"
    export BROOT_ICONS="${BROOT_ICONS:-0}"
    export BROOT_COLORS="${BROOT_COLORS:-truecolor}"
fi

# =============================================================================
# Ranger - Console file manager with vim keybindings
# =============================================================================

































if command -v ranger >/dev/null 2>&1; then
    export RANGER_LOAD_DEFAULT_RC="${RANGER_LOAD_DEFAULT_RC:-FALSE}"
    export RANGER_CONFIG_DIR="${RANGER_CONFIG_DIR:-$XDG_CONFIG_HOME/ranger}"
    export RANGER_DATA_DIR="${RANGER_DATA_DIR:-$XDG_DATA_HOME/ranger}"
    export RANGER_CACHE_DIR="${RANGER_CACHE_DIR:-$XDG_CACHE_HOME/ranger}"
fi

# =============================================================================

# =============================================================================































if command -v lf >/dev/null 2>&1; then
    export LF_CONFIG_DIR="${LF_CONFIG_DIR:-$XDG_CONFIG_HOME/lf}"
    export LF_CACHE_DIR="${LF_CACHE_DIR:-$XDG_CACHE_HOME/lf}"
    export LF_DATA_DIR="${LF_DATA_DIR:-$XDG_DATA_HOME/lf}"
    export LF_ICONS="${LF_ICONS:-0}"
fi

# =============================================================================
# NNN - Fast terminal file manager
# =============================================================================





































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































if command -v yazi >/dev/null 2>&1; then
    export YAZI_CONFIG_DIR="${YAZI_CONFIG_DIR:-$XDG_CONFIG_HOME/yazi}"
    export YAZI_CACHE_DIR="${YAZI_CACHE_DIR:-$XDG_CACHE_HOME/yazi}"
    export YAZI_LOG_DIR="${YAZI_LOG_DIR:-$XDG_STATE_HOME/yazi}"
    export YAZI_LOGGER="${YAZI_LOGGER:-0}"
fi

# =============================================================================
# Broot - File browser with tree view
# =============================================================================
































if command -v broot >/dev/null 2>&1; then
    export BROOT_CONFIG_DIR="${BROOT_CONFIG_DIR:-$XDG_CONFIG_HOME/broot}"
    export BROOT_CACHE_DIR="${BROOT_CACHE_DIR:-$XDG_CACHE_HOME/broot}"
    export BROOT_ICONS="${BROOT_ICONS:-0}"
    export BROOT_COLORS="${BROOT_COLORS:-truecolor}"
fi

# =============================================================================
# Joshuto - Terminal file manager
# =============================================================================






























if command -v joshuto >/dev/null 2>&1; then
    export JOSHUTO_CONFIG_DIR="${JOSHUTO_CONFIG_DIR:-$XDG_CONFIG_HOME/joshuto}"
    export JOSHUTO_CACHE_DIR="${JOSHUTO_CACHE_DIR:-$XDG_CACHE_HOME/joshuto}"
    export JOSHUTO_PREVIEW="${JOSHUTO_PREVIEW:-1}"
    export JOSHUTO_SHOW_HIDDEN="${JOSHUTO_SHOW_HIDDEN:-1}"
fi
