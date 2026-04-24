#!/usr/bin/env zsh
# Chaotic-AUR integration for Arch Linux (Zsh)

chaotic_setup() {
  if command -v pacman >/dev/null 2>&1; then
    if grep -qE "^\[chaotic-aur\]" /etc/pacman.conf 2>/dev/null; then
      echo "Chaotic-AUR already configured."
      return 0
    fi
    if [[ "${CHAOTIC_AUTOINSTALL:-0}" == "1" ]]; then
      sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
      sudo pacman-key --lsign-key 3056513887B78AEB
      sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
      sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
      echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
      echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
      sudo pacman -Syu
      echo "Chaotic-AUR configured."
    else
      echo "Chaotic-AUR setup steps (manual):"
      echo "  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com"
      echo "  sudo pacman-key --lsign-key 3056513887B78AEB"
      echo "  sudo pacman -U 'chaotic-keyring.pkg.tar.zst' 'chaotic-mirrorlist.pkg.tar.zst'"
      echo "  Add [chaotic-aur] to pacman.conf"
      echo "  sudo pacman -Syu"
    fi
  else
    echo "Chaotic-AUR is Arch pacman-specific. Skipping."
  fi
}

chaotic_install() {
  local pkg="$1"
  if [[ -z "$pkg" ]]; then
    echo "Usage: chaotic_install <pkg>"
    return 1
  fi
  if command -v yay >/dev/null 2>&1; then
    yay -S chaotic-aur/"$pkg"
  else
    sudo pacman -S chaotic-aur/"$pkg"
  fi
}

export CHAOTIC_AUTOINSTALL=${CHAOTIC_AUTOINSTALL:-0}
chaotic_setup