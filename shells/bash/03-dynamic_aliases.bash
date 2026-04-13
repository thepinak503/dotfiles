#!/usr/bin/env bash
# =============================================================================
# DYNAMIC ALIASES — Bash
# Defined at shell startup; only created when the binary is present.
# No Python. No JSON. No pre-generated files.
# To add an alias: _dyn_alias <name> <binary> <command>
# =============================================================================

_dyn_alias() {
    local name="$1" bin="$2"
    shift 2
    # shellcheck disable=SC2139,SC2142
    command -v "$bin" &>/dev/null && alias "$name=$*"
}

# -----------------------------------------------------------------------------
# Docker
# -----------------------------------------------------------------------------
_dyn_alias dkstat   docker  "docker stats --no-stream"
_dyn_alias dimgs    docker  "docker images"
_dyn_alias dpsa     docker  "docker ps -a"
_dyn_alias dnet     docker  "docker network ls"
_dyn_alias dvol     docker  "docker volume ls"

# -----------------------------------------------------------------------------
# Kubernetes
# -----------------------------------------------------------------------------
_dyn_alias k        kubectl  "kubectl"
_dyn_alias kg       kubectl  "kubectl get"
_dyn_alias kd       kubectl  "kubectl describe"
_dyn_alias kl       kubectl  "kubectl logs"
_dyn_alias ka       kubectl  "kubectl apply -f"
_dyn_alias kdel     kubectl  "kubectl delete"
_dyn_alias kctx     kubectl  "kubectl config use-context"
_dyn_alias kwp      kubectl  "kubectl get pods"

# -----------------------------------------------------------------------------
# Terraform
# -----------------------------------------------------------------------------
_dyn_alias tfi   terraform  "terraform init"
_dyn_alias tfp   terraform  "terraform plan"
_dyn_alias tfa   terraform  "terraform apply"
_dyn_alias tfd   terraform  "terraform destroy"
_dyn_alias tfv   terraform  "terraform validate"

# -----------------------------------------------------------------------------
# Helm
# -----------------------------------------------------------------------------
_dyn_alias helmup  helm  "helm upgrade --install"
_dyn_alias helml   helm  "helm list"

# -----------------------------------------------------------------------------
# GitHub CLI
# -----------------------------------------------------------------------------
_dyn_alias ghprl   gh  "gh pr list"
_dyn_alias ghprc   gh  "gh pr create"
_dyn_alias ghprv   gh  "gh pr view"
_dyn_alias ghrl    gh  "gh repo list"

# -----------------------------------------------------------------------------
# Node / npm / yarn / pnpm
# -----------------------------------------------------------------------------
_dyn_alias npmi   npm   "npm install"
_dyn_alias npmb   npm   "npm run build"
_dyn_alias npmt   npm   "npm test"
_dyn_alias yl     yarn  "yarn list --depth=0"
_dyn_alias yb     yarn  "yarn build"
_dyn_alias pnpmr  pnpm  "pnpm run"
_dyn_alias pnpmi  pnpm  "pnpm install"

# -----------------------------------------------------------------------------
# Python / pip
# -----------------------------------------------------------------------------
_dyn_alias pipi   pip3  "pip3 install"
_dyn_alias pipu   pip3  "pip3 install --upgrade"
_dyn_alias pipf   pip3  "pip3 install --upgrade pip"

# -----------------------------------------------------------------------------
# Go
# -----------------------------------------------------------------------------
_dyn_alias gopath  go  "go env GOPATH"
_dyn_alias gomod   go  "go mod tidy"

# -----------------------------------------------------------------------------
# Rust / Cargo
# -----------------------------------------------------------------------------
_dyn_alias crun   cargo  "cargo run"
_dyn_alias cbld   cargo  "cargo build"
_dyn_alias ctst   cargo  "cargo test"
_dyn_alias crel   cargo  "cargo run --release"
_dyn_alias cclp   cargo  "cargo clippy"
_dyn_alias cfmt   cargo  "cargo fmt"

# -----------------------------------------------------------------------------
# Tmux
# -----------------------------------------------------------------------------
_dyn_alias t    tmux  "tmux"
_dyn_alias ta   tmux  "tmux attach"
_dyn_alias tl   tmux  "tmux list-sessions"
_dyn_alias tn   tmux  "tmux new-session -s"

# -----------------------------------------------------------------------------
# Lazygit / Yazi / Zellij
# -----------------------------------------------------------------------------
_dyn_alias lg   lazygit  "lazygit"
_dyn_alias zj   zellij   "zellij"

# -----------------------------------------------------------------------------
# fzf
# -----------------------------------------------------------------------------
_dyn_alias fzf_top  fzf  "fzf --height 40% --reverse --prompt='>'"

# -----------------------------------------------------------------------------
# Chaotic-AUR (Arch only)
# -----------------------------------------------------------------------------
_dyn_alias chaotic_find  yay  "yay -S chaotic-aur"

unset -f _dyn_alias
