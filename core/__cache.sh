DOTFILES_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles"
DOTFILES_CACHE_FILE="$DOTFILES_CACHE_DIR/init.cache"
DOTFILES_CACHE_BREW="$DOTFILES_CACHE_DIR/brew.env"

_cache_load() {
  [ -f "$DOTFILES_CACHE_FILE" ] && . "$DOTFILES_CACHE_FILE" && return 0
  return 1
}

_cache_save() {
  mkdir -p "$DOTFILES_CACHE_DIR"
  {
    echo "DOTFILES_OS='$(uname -s)'"
    echo "DOTFILES_ARCH='$(uname -m)'"
  } > "$DOTFILES_CACHE_FILE"
}

_cache_gen() {
  local os arch distro pkg init shname
  os="$(uname -s)"
  arch="$(uname -m)"
  distro="unknown"
  pkg="none"
  init=""

  case "$os" in
    Darwin) distro="macos" ;;
    Linux)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
          arch|artix|manjaro|endeavouros|garuda|archlabs) distro="arch" ;;
          debian|ubuntu|linuxmint|pop|elementary|zorin|neon|mx) distro="debian" ;;
          fedora|centos|stream|rhel|rocky|alma|nobara) distro="fedora" ;;
          opensuse|sles|leap|tumbleweed|gecko) distro="suse" ;;
          void) distro="void" ;;
          nixos) distro="nix" ;;
          gentoo|funtoo|calculate) distro="gentoo" ;;
          alpine) distro="alpine" ;;
          slackware|slint|salix|vector) distro="slackware" ;;
          *)
            case "$ID_LIKE" in
              *arch*) distro="arch" ;;
              *debian*|*ubuntu*) distro="debian" ;;
              *fedora*|*rhel*|*centos*) distro="fedora" ;;
              *suse*|*opensuse*) distro="suse" ;;
              *) distro="$ID" ;;
            esac
            ;;
        esac
      elif [ -f /etc/debian_version ]; then distro="debian"
      elif [ -f /etc/arch-release ]; then distro="arch"
      elif [ -f /etc/fedora-release ]; then distro="fedora"
      elif [ -f /etc/SuSE-release ]; then distro="suse"
      fi
      ;;
  esac

  command -v brew >/dev/null 2>&1 && pkg="brew"
  command -v paru >/dev/null 2>&1 && pkg="paru"
  command -v yay >/dev/null 2>&1 && pkg="yay"
  command -v pacman >/dev/null 2>&1 && pkg="pacman"
  command -v apt >/dev/null 2>&1 && pkg="apt"
  command -v dnf >/dev/null 2>&1 && pkg="dnf"
  command -v zypper >/dev/null 2>&1 && pkg="zypper"
  command -v xbps-install >/dev/null 2>&1 && pkg="xbps"
  command -v apk >/dev/null 2>&1 && pkg="apk"
  command -v nix >/dev/null 2>&1 && pkg="nix"

  [ -d /run/systemd/system ] && init="systemd" || init="unknown"

  case "${SHELL##*/}" in bash) shname="bash" ;; zsh) shname="zsh" ;; fish) shname="fish" ;; *) shname="bash" ;; esac

  mkdir -p "$DOTFILES_CACHE_DIR"
  {
    echo "DOTFILES_OS='$os'"
    echo "DOTFILES_ARCH='$arch'"
    echo "DOTFILES_DISTRO='$distro'"
    echo "DOTFILES_PKG_MANAGER='$pkg'"
    echo "DOTFILES_INIT='$init'"
    echo "SHELL_NAME='$shname'"
  } > "$DOTFILES_CACHE_FILE"

  if command -v brew >/dev/null 2>&1; then
    brew shellenv 2>/dev/null > "$DOTFILES_CACHE_BREW"
  fi
}

_cache_brew() {
  [ -f "$DOTFILES_CACHE_BREW" ] && . "$DOTFILES_CACHE_BREW" && return 0
  return 1
}

if ! _cache_load; then
  _cache_gen
  _cache_load
fi
