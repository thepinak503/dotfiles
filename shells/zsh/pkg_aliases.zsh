#!/usr/bin/env zsh
# =============================================================================
# Package manager agnostic wrappers (Zsh)
# Detects distro and delegates to the proper installer commands.
# =============================================================================

detect_pkg_manager() {
  if command -v apk >/dev/null 2>&1; then echo "apk"
  elif command -v apt-get >/dev/null 2>&1; then echo "apt"
  elif command -v apt >/dev/null 2>&1; then echo "apt"
  elif command -v dnf >/dev/null 2>&1; then echo "dnf"
  elif command -v yum >/usr/bin/yum 2>/dev/null; then echo "yum"
  elif command -v pacman >/usr/bin/pacman; then echo "pacman"
  elif command -v zypper >/usr/bin/zypper; then echo "zypper"
  elif command -v emerge >/usr/bin/emerge; then echo "emerge"
  elif command -v xbps-install >/usr/bin/xbps-install; then echo "xbps"
  elif command -v brew >/usr/bin/brew; then echo "brew"
  else echo "unknown"; fi
}

pm_install() {
  local pkgs="$@"
  case "$(detect_pkg_manager)" in
    apk) sudo apk add "$pkgs" ;;
    apt|apt-get) sudo apt-get install -y "$pkgs" ;;
    dnf) sudo dnf install -y "$pkgs" ;;
    yum) sudo yum install -y "$pkgs" ;;
    pacman) sudo pacman -S --noconfirm "$pkgs" ;;
    zypper) sudo zypper install -y "$pkgs" ;;
    emerge) sudo emerge "$pkgs" ;;
    xbps) sudo xbps-install -S "$pkgs" ;;
    brew) if command -v brew >/dev/null 2>&1; then brew install "$pkgs"; else echo "brew not found"; return 1; fi ;;
    *) echo "No supported package manager detected"; return 1 ;;
  esac
}

pm_update() {
  case "$(detect_pkg_manager)" in
    apt|apt-get) sudo apt-get update && sudo apt-get upgrade -y ;;
    dnf) sudo dnf upgrade -y ;;
    yum) sudo yum update -y ;;
    pacman) sudo pacman -Syu --noconfirm ;;
    zypper) sudo zypper refresh && sudo zypper update -y ;;
    apk) sudo apk update && sudo apk upgrade ;;
    xbps) sudo xbps-install -Syu ;;
    brew) if command -v brew >/dev/null 2>&1; then brew update && brew upgrade; else echo "brew not found"; fi ;;
    *) echo "No supported package manager detected" ;;
  esac
}

pm_search() {
  local term="$1"
  case "$(detect_pkg_manager)" in
    apt|apt-get) apt-cache search "$term" ;;
    dnf) dnf search "$term" ;;
    yum) yum search "$term" ;;
    pacman) pacman -Ss "$term" ;;
    zypper) zypper search "$term" ;;
    apk) apk search "$term" ;;
    brew) brew search "$term" ;;
    emerge) emerge -s "$term" ;;
    xbps) xbps-query -Rs "$term" ;;
    *) echo "No supported package manager detected" ;;
  esac
}

pm_list_installed() {
  case "$(detect_pkg_manager)" in
    apt|apt-get) dpkg -l ;;
    dnf) dnf list installed ;;
    yum) yum list installed ;;
    pacman) pacman -Q ;;
    zypper) zypper se --installed-only ;;
    apk) apk list --installed ;;
    brew) brew list --formulae --casks ;;
    emerge) equery list ;;
    xbps) xbps-query -l ;;
    *) echo "No supported package manager detected" ;;
  esac
}