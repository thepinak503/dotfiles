#!/usr/bin/env bash
# =============================================================================
# DYNAMIC ALIASES - distro-agnostic, auto-generated based on installed binaries
# This file is sourced by .bashrc if present
# =============================================================================

# shellcheck source=/etc/os-release
detect_distro() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release 2>/dev/null
    echo "${ID:-unknown}|${ID_LIKE:-unknown}"
  else
    echo "unknown|unknown"
  fi
}

define_alias_if_missing() {
  local name="$1"; local cmd="$2"
  if ! alias 2>/dev/null | grep -qE "\b${name}=|alias ${name}"; then
    local theline
    printf -v theline 'alias %s="%s"' "$name" "$cmd"
    eval "$theline"
  fi
}

# Specs: name|binary|cmd
aliases_specs=(
  "dkstat|docker|docker stats --no-stream"
  "dimgs|docker|docker images"
  "dpsa|docker|docker ps -a"
  "kctx|kubectl|kubectl config use-context"
  "kwp|kubectl|kubectl get pods"
  "tfp|terraform|terraform plan"
  "tfa|terraform|terraform apply"
  "tfd|terraform|terraform destroy"
  "tfi|terraform|terraform init"
  "tfv|terraform|terraform validate"
  "helmup|helm|helm upgrade --install"
  "ghprl|gh|gh pr list"
  "ghprco|gh|gh pr create"
  "npmb|npm|npm run build"
  "npmi|npm|npm install"
  "yl|yarn|yarn list --depth=0"
  "yb|yarn|yarn build"
  "pnpmr|pnpm|pnpm run"
  "pipi|pip3|pip3 install"
  "pipu|pip3|pip3 install --upgrade"
  "godep|go|go env GOPATH"
  "fzftop|fzf|fzf --height 40% --reverse --prompt='>'"
)

for spec in "${aliases_specs[@]}"; do
  IFS='|' read -r name bin cmd <<< "$spec"
  if command -v "$bin" >/dev/null 2>&1; then
    define_alias_if_missing "$name" "$cmd"
  fi
done