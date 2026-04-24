#!/usr/bin/env bash
# =============================================================================
# Install shell support across distros (macOS friendly)
# This installs core dependencies and optional tools.
# =============================================================================

install_shell_support() {
  local AUTO=false
  local INCLUDE_DEPS=false
  local INCLUDE_OPTIONAL=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes) AUTO=true; shift; ;;
      --deps|--with-deps|--all) INCLUDE_DEPS=true; shift; ;;
      --optional) INCLUDE_OPTIONAL=true; shift; ;;
      *) break; ;;
    esac
  done

  local PM="unknown"
  if command -v apt-get >/dev/null 2>&1; then PM="apt"
  elif command -v dnf >/dev/null 2>&1; then PM="dnf"
  elif command -v pacman >/dev/null 2>&1; then PM="pacman"
  elif command -v zypper >/usr/bin/zypper; then PM="zypper"
  elif command -v brew >/usr/bin/brew; then PM="brew"
  elif command -v apk >/sbin/apk || command -v apk >/bin/apk; then PM="apk"
  else PM="unknown"; fi

  local base_pkgs=(git curl wget fzf ripgrep zoxide)
  local opt_pkgs=(bat)
  local to_install=("${base_pkgs[@]}")

  if $INCLUDE_OPTIONAL; then to_install+=("${opt_pkgs[@]}"); fi
  if $INCLUDE_DEPS; then to_install+=("starship"); fi

  echo "Detected OS: ${PM}. Installing packages: ${to_install[*]}"
  for pkg in "${to_install[@]}"; do
    if command -v "$pkg" >/dev/null 2>&1; then
      continue
    fi
    if [[ "$PM" == "unknown" ]]; then
      echo "No supported package manager detected for $pkg" >&2
      continue
    fi
    case "$PM" in
      apt|apt-get) sudo apt-get install -y "$pkg" ;;
      dnf) sudo dnf install -y "$pkg" ;;
      pacman) sudo pacman -S --noconfirm "$pkg" ;;
      zypper) sudo zypper install -y "$pkg" ;;
      brew) brew install "$pkg" ;;
      apk) sudo apk add "$pkg" ;;
      *) echo "Unsupported PM: $PM"; ;;
    esac
  done

  echo "Shell support installation finished."
}