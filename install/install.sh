#!/usr/bin/env sh
set -e
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
VERSION="2.0.0"
BREWFILE="$DOTFILES_DIR/apps/brew/Brewfile"

AUTO_YES=false
INSTALL_PROFILE="standard"
for _arg in "$@"; do
    case "$_arg" in
        --yes|-y) AUTO_YES=true ;;
        --minimal) INSTALL_PROFILE="minimal" ;;
        --standard) INSTALL_PROFILE="standard" ;;
        --full) INSTALL_PROFILE="full" ;;
        --hyprland) INSTALL_PROFILE="hyprland" ;;
        --macos) INSTALL_PROFILE="macos" ;;
        --help|-h)
            echo "Usage: install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --yes, -y       Install all dependencies without prompting"
            echo "  --minimal       Shell + dev tools only"
            echo "  --standard      Default profile (shell + dev + git)"
            echo "  --full           Everything (including Hyprland/macOS extras)"
            echo "  --hyprland       Only Hyprland/Wayland ecosystem"
            echo "  --macos          Only macOS extras"
            echo "  --help, -h      Show this help message"
            exit 0
            ;;
    esac
done
[ "$INSTALL_PROFILE" != "standard" ] && AUTO_YES=true

mkdir -p "$DOTFILES_STATE_DIR"
if [ ! -f "$DOTFILES_STATE_DIR/install_date" ]; then
    date "+%Y-%m-%d %H:%M:%S" > "$DOTFILES_STATE_DIR/install_date"
fi
if [ -t 1 ]; then
    RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m'
    BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m'
    BOLD='\033[1m' NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' PURPLE='' CYAN='' BOLD='' NC=''
fi
info() { printf "  ${GREEN}✓${NC} %s\n" "$1"; }
warn() { printf "  ${YELLOW}⚠${NC} %s\n" "$1"; }
error() { printf "  ${RED}✗${NC} %s\n" "$1" >&2; }
_safe_curl_exec() {
    _url="$1" _shell="${2:-sh}" _tmp="/tmp/dots_install_$$.sh"
    curl -fsSL "$_url" -o "$_tmp" 2>/dev/null || { warn "download failed: $_url"; return 1; }
    [ -s "$_tmp" ] && head -c2 "$_tmp" | grep -q '^#!' || { warn "invalid/missing script from $_url"; rm -f "$_tmp"; return 1; }
    chmod +x "$_tmp"
    "$_shell" "$_tmp" 2>&1 || true
    _ret=$?; rm -f "$_tmp"; return $_ret
}

header() {
    printf "\n${CYAN}═══════════════════════════════════════════${NC}\n"
    printf "  ${BOLD}%s${NC}\n" "$1"
    printf "${CYAN}═══════════════════════════════════════════${NC}\n"
}
ask_yes_no() {
    _prompt=$1 _default=$2
    $AUTO_YES && return 0
    case "$_default" in
        [Yy]) _prompt_str="$_prompt [Y/n] " ;;
        *)    _prompt_str="$_prompt [y/N] " ;;
    esac
    printf "  ${YELLOW}?${NC} ${_prompt_str}"
    read -r _ans
    case "$_ans" in
        [yY]|[yY][eE][sS]) return 0 ;;
        [nN]|[nN][oO])     return 1 ;;
        *)                  [ "$_default" = "y" ] || [ "$_default" = "Y" ] && return 0 || return 1 ;;
    esac
}

# =============================================================================
# DETECT OS, DISTRO, ARCH, PACKAGE MANAGER
# =============================================================================
OS="$(uname -s)"
ARCH="$(uname -m)"
DISTRO="unknown"

case "$OS" in
    Linux)
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO=$ID
            DISTRO_FAMILY=$ID_LIKE
        elif [ -f /etc/debian_version ]; then
            DISTRO="debian"
        elif [ -f /etc/arch-release ]; then
            DISTRO="arch"
        elif [ -f /etc/fedora-release ]; then
            DISTRO="fedora"
        elif [ -f /etc/gentoo-release ]; then
            DISTRO="gentoo"
        elif [ -f /etc/SuSE-release ]; then
            DISTRO="opensuse"
        else
            DISTRO="linux"
        fi
        ;;
    Darwin)
        DISTRO="macos"
        case "$ARCH" in
            arm64) MACOS_SOC="apple-silicon" ;;
            x86_64) MACOS_SOC="intel" ;;
        esac
        ;;
esac

detect_pm() {
    if command -v brew >/dev/null 2>&1; then echo "brew"; return 0; fi
    if command -v pacman >/dev/null 2>&1; then echo "pacman"; return 0; fi
    if command -v apt-get >/dev/null 2>&1; then echo "apt"; return 0; fi
    if command -v dnf >/dev/null 2>&1; then echo "dnf"; return 0; fi
    if command -v zypper >/dev/null 2>&1; then echo "zypper"; return 0; fi
    if command -v apk >/dev/null 2>&1; then echo "apk"; return 0; fi
    if command -v xbps-install >/dev/null 2>&1; then echo "xbps"; return 0; fi
    if command -v emerge >/dev/null 2>&1; then echo "emerge"; return 0; fi
    if command -v nix-env >/dev/null 2>&1; then echo "nix"; return 0; fi
    if command -v slackpkg >/dev/null 2>&1; then echo "slackpkg"; return 0; fi
    if command -v eopkg >/dev/null 2>&1; then echo "eopkg"; return 0; fi
    echo "manual"
}
PM=$(detect_pm)

# =============================================================================
# CROSS-DISTRO PACKAGE NAME MAP
# =============================================================================
pkg_name() {
    _pkg=$1
    case "$PM" in
        apt)
            case "$_pkg" in
                fd)            echo "fd-find" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                bash-preexec)  echo "bash-preexec" ;;
                lazygit)       echo "lazygit" ;;
                yazi)          echo "yazi" ;;
                lazydocker)    echo "lazydocker" ;;
                zellij)        echo "zellij" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker.io" ;;
                docker-compose) echo "docker-compose-v2" ;;
                podman)        echo "podman" ;;
                kubectl)       echo "kubectl" ;;
                helm)          echo "helm" ;;
                terraform)     echo "terraform" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                wlogout)       echo "wlogout" ;;
                rofi)          echo "rofi" ;;
                dunst)         echo "dunst" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                hyprlock)      echo "hyprlock" ;;
                hypridle)      echo "hypridle" ;;
                hyprpaper)     echo "hyprpaper" ;;
                hyprpicker)    echo "hyprpicker" ;;
                swayosd)       echo "swayosd" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                cliphist)      echo "cliphist" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                polkit-gnome)  echo "policykit-1-gnome" ;;
                xdg-desktop-portal-hyprland) echo "xdg-desktop-portal-hyprland" ;;
                swww)          echo "swww" ;;
                nwg-look)      echo "nwg-look" ;;
                hyprshot)      echo "hyprshot" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        dnf)
            case "$_pkg" in
                fd)            echo "fd-find" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                bash-preexec)  echo "bash-preexec" ;;
                lazygit)       echo "lazygit" ;;
                yazi)          echo "yazi" ;;
                lazydocker)    echo "lazydocker" ;;
                zellij)        echo "zellij" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                kubectl)       echo "kubectl" ;;
                helm)          echo "helm" ;;
                terraform)     echo "terraform" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                wlogout)       echo "wlogout" ;;
                rofi)          echo "rofi" ;;
                dunst)         echo "dunst" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                hyprlock)      echo "hyprlock" ;;
                hypridle)      echo "hypridle" ;;
                hyprpaper)     echo "hyprpaper" ;;
                hyprpicker)    echo "hyprpicker" ;;
                swayosd)       echo "swayosd" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                cliphist)      echo "cliphist" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                polkit-gnome)  echo "polkit-gnome" ;;
                xdg-desktop-portal-hyprland) echo "xdg-desktop-portal-hyprland" ;;
                swww)          echo "swww" ;;
                nwg-look)      echo "nwg-look" ;;
                hyprshot)      echo "hyprshot" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        pacman)
            case "$_pkg" in
                fd)            echo "fd" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "github-cli" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                bash-preexec)  echo "bash-preexec" ;;
                lazygit)       echo "lazygit" ;;
                yazi)          echo "yazi" ;;
                lazydocker)    echo "lazydocker" ;;
                zellij)        echo "zellij" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                kubectl)       echo "kubectl" ;;
                helm)          echo "helm" ;;
                terraform)     echo "terraform" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                wlogout)       echo "wlogout" ;;
                rofi)          echo "rofi" ;;
                dunst)         echo "dunst" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                hyprlock)      echo "hyprlock" ;;
                hypridle)      echo "hypridle" ;;
                hyprpaper)     echo "hyprpaper" ;;
                hyprpicker)    echo "hyprpicker" ;;
                swayosd)       echo "swayosd" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                cliphist)      echo "cliphist" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                polkit-gnome)  echo "polkit-gnome" ;;
                xdg-desktop-portal-hyprland) echo "xdg-desktop-portal-hyprland" ;;
                swww)          echo "swww" ;;
                nwg-look)      echo "nwg-look" ;;
                hyprshot)      echo "hyprshot" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        zypper)
            case "$_pkg" in
                fd)            echo "fd" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                bash-preexec)  echo "bash-preexec" ;;
                lazygit)       echo "lazygit" ;;
                yazi)          echo "yazi" ;;
                lazydocker)    echo "lazydocker" ;;
                zellij)        echo "zellij" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                kubectl)       echo "kubectl" ;;
                helm)          echo "helm" ;;
                terraform)     echo "terraform" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                wlogout)       echo "wlogout" ;;
                rofi)          echo "rofi" ;;
                dunst)         echo "dunst" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                hyprlock)      echo "hyprlock" ;;
                hypridle)      echo "hypridle" ;;
                hyprpaper)     echo "hyprpaper" ;;
                hyprpicker)    echo "hyprpicker" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                xdg-desktop-portal-hyprland) echo "xdg-desktop-portal-hyprland" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        apk)
            case "$_pkg" in
                fd)            echo "fd" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        xbps)
            case "$_pkg" in
                fd)            echo "fd" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                hyprland)      echo "hyprland" ;;
                waybar)        echo "waybar" ;;
                rofi)          echo "rofi" ;;
                dunst)         echo "dunst" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                hyprlock)      echo "hyprlock" ;;
                hypridle)      echo "hypridle" ;;
                grim)          echo "grim" ;;
                slurp)         echo "slurp" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                pavucontrol)   echo "pavucontrol" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        emerge)
            case "$_pkg" in
                fd)            echo "sys-apps/fd" ;;
                bat)           echo "sys-apps/bat" ;;
                ripgrep)       echo "sys-apps/ripgrep" ;;
                eza)           echo "sys-apps/eza" ;;
                starship)      echo "app-shells/starship" ;;
                zoxide)        echo "app-shells/zoxide" ;;
                fastfetch)     echo "sys-apps/fastfetch" ;;
                neovim)        echo "app-editors/neovim" ;;
                git-delta)     echo "dev-util/git-delta" ;;
                gh)            echo "dev-util/gh" ;;
                jq)            echo "app-misc/jq" ;;
                tmux)          echo "app-misc/tmux" ;;
                btop)          echo "sys-process/btop" ;;
                ncdu)          echo "sys-apps/ncdu" ;;
                fzf)           echo "app-shells/fzf" ;;
                docker)        echo "app-containers/docker" ;;
                podman)        echo "app-containers/podman" ;;
                kubectl)       echo "sys-cluster/kubectl" ;;
                helm)          echo "sys-cluster/helm" ;;
                terraform)     echo "app-admin/terraform" ;;
                hyprland)      echo "gui-wm/hyprland" ;;
                waybar)        echo "gui-apps/waybar" ;;
                rofi)          echo "x11-misc/rofi" ;;
                dunst)         echo "x11-misc/dunst" ;;
                kitty)         echo "x11-terms/kitty" ;;
                alacritty)     echo "x11-terms/alacritty" ;;
                hyprlock)      echo "gui-apps/hyprlock" ;;
                hypridle)      echo "gui-apps/hypridle" ;;
                hyprpaper)     echo "gui-apps/hyprpaper" ;;
                hyprpicker)    echo "gui-apps/hyprpicker" ;;
                grim)          echo "gui-apps/grim" ;;
                slurp)         echo "gui-apps/slurp" ;;
                wl-clipboard)  echo "gui-apps/wl-clipboard" ;;
                playerctl)     echo "media-sound/playerctl" ;;
                brightnessctl) echo "sys-apps/brightnessctl" ;;
                pavucontrol)   echo "media-sound/pavucontrol" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        nix)
            case "$_pkg" in
                fd)            echo "nixpkgs.fd" ;;
                bat)           echo "nixpkgs.bat" ;;
                ripgrep)       echo "nixpkgs.ripgrep" ;;
                eza)           echo "nixpkgs.eza" ;;
                starship)      echo "nixpkgs.starship" ;;
                zoxide)        echo "nixpkgs.zoxide" ;;
                fastfetch)     echo "nixpkgs.fastfetch" ;;
                atuin)         echo "nixpkgs.atuin" ;;
                neovim)        echo "nixpkgs.neovim" ;;
                git-delta)     echo "nixpkgs.delta" ;;
                gh)            echo "nixpkgs.gh" ;;
                jq)            echo "nixpkgs.jq" ;;
                yq)            echo "nixpkgs.yq-go" ;;
                tmux)          echo "nixpkgs.tmux" ;;
                btop)          echo "nixpkgs.btop" ;;
                ncdu)          echo "nixpkgs.ncdu" ;;
                tldr)          echo "nixpkgs.tldr" ;;
                direnv)        echo "nixpkgs.direnv" ;;
                hyperfine)     echo "nixpkgs.hyperfine" ;;
                fzf)           echo "nixpkgs.fzf" ;;
                lazygit)       echo "nixpkgs.lazygit" ;;
                yazi)          echo "nixpkgs.yazi" ;;
                docker)        echo "nixpkgs.docker" ;;
                docker-compose) echo "nixpkgs.docker-compose" ;;
                podman)        echo "nixpkgs.podman" ;;
                kubectl)       echo "nixpkgs.kubectl" ;;
                helm)          echo "nixpkgs.helm" ;;
                terraform)     echo "nixpkgs.terraform" ;;
                hyprland)      echo "nixpkgs.hyprland" ;;
                waybar)        echo "nixpkgs.waybar" ;;
                wlogout)       echo "nixpkgs.wlogout" ;;
                rofi)          echo "nixpkgs.rofi" ;;
                dunst)         echo "nixpkgs.dunst" ;;
                kitty)         echo "nixpkgs.kitty" ;;
                alacritty)     echo "nixpkgs.alacritty" ;;
                hyprlock)      echo "nixpkgs.hyprlock" ;;
                hypridle)      echo "nixpkgs.hypridle" ;;
                hyprpaper)     echo "nixpkgs.hyprpaper" ;;
                hyprpicker)    echo "nixpkgs.hyprpicker" ;;
                grim)          echo "nixpkgs.grim" ;;
                slurp)         echo "nixpkgs.slurp" ;;
                wl-clipboard)  echo "nixpkgs.wl-clipboard" ;;
                playerctl)     echo "nixpkgs.playerctl" ;;
                brightnessctl) echo "nixpkgs.brightnessctl" ;;
                pavucontrol)   echo "nixpkgs.pavucontrol" ;;
                *)             echo "nixpkgs.$_pkg" ;;
            esac
            ;;
        brew)
            case "$_pkg" in
                fd)            echo "fd" ;;
                bat)           echo "bat" ;;
                ripgrep)       echo "ripgrep" ;;
                eza)           echo "eza" ;;
                starship)      echo "starship" ;;
                zoxide)        echo "zoxide" ;;
                fastfetch)     echo "fastfetch" ;;
                atuin)         echo "atuin" ;;
                neovim)        echo "neovim" ;;
                git-delta)     echo "git-delta" ;;
                gh)            echo "gh" ;;
                jq)            echo "jq" ;;
                yq)            echo "yq" ;;
                tmux)          echo "tmux" ;;
                btop)          echo "btop" ;;
                ncdu)          echo "ncdu" ;;
                tldr)          echo "tldr" ;;
                direnv)        echo "direnv" ;;
                hyperfine)     echo "hyperfine" ;;
                lazygit)       echo "lazygit" ;;
                yazi)          echo "yazi" ;;
                lazydocker)    echo "lazydocker" ;;
                zellij)        echo "zellij" ;;
                fzf)           echo "fzf" ;;
                docker)        echo "docker" ;;
                docker-compose) echo "docker-compose" ;;
                podman)        echo "podman" ;;
                kubectl)       echo "kubectl" ;;
                helm)          echo "helm" ;;
                terraform)     echo "terraform" ;;
                kitty)         echo "kitty" ;;
                alacritty)     echo "alacritty" ;;
                grim)          echo "grim" ;;
                wl-clipboard)  echo "wl-clipboard" ;;
                playerctl)     echo "playerctl" ;;
                brightnessctl) echo "brightnessctl" ;;
                coreutils)     echo "coreutils" ;;
                findutils)     echo "findutils" ;;
                gnu-sed)       echo "gnu-sed" ;;
                gnu-tar)       echo "gnu-tar" ;;
                grep)          echo "grep" ;;
                *)             echo "$_pkg" ;;
            esac
            ;;
        *) echo "$_pkg" ;;
    esac
}

# =============================================================================
# INSTALL FUNCTIONS
# =============================================================================
_check_sudo() {
    case "$PM" in nix|brew) return 0 ;; esac
    command -v sudo >/dev/null 2>&1 || { error "sudo is required for package installation ($PM)"; return 1; }
    sudo -n true 2>/dev/null && return 0
    if ask_yes_no "sudo required for $PM installs. Run sudo -v?" y; then
        sudo -v || { error "sudo authentication failed"; return 1; }
    else
        error "sudo required but not granted. Run installer with --yes or authenticate via sudo -v first"
        return 1
    fi
}

install_package() {
    _pkg=$1
    _real_pkg=$(pkg_name "$_pkg")

    case "$PM" in
        pacman)
            sudo pacman -S --noconfirm "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        apt)
            sudo apt-get install -y "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        dnf)
            sudo dnf install -y "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        zypper)
            sudo zypper install -y "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        apk)
            sudo apk add "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        xbps)
            sudo xbps-install -y "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        emerge)
            sudo emerge --ask=n "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        nix)
            nix profile install "$_real_pkg" >/dev/null 2>&1 || return 1
            ;;
        brew)
            if [ -f "$BREWFILE" ]; then
                brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
            else
                brew install "$_real_pkg" >/dev/null 2>&1 || return 1
            fi
            ;;
        *)
            return 1 ;;
    esac
}

install_if_asked() {
    _pkg=$1 _label=$2
    if command -v "$_pkg" >/dev/null 2>&1; then
        info "$_label already installed"
        return 0
    fi
    if ask_yes_no "Install $_label?" y; then
        if install_package "$_pkg"; then
            info "Installed $_label"
        else
            warn "Could not install $_label via $PM (may need manual install)"
        fi
    else
        info "Skipped $_label"
    fi
}

install_list() {
    _label=$1; shift
    _check_sudo || return 1
    header "$_label"
    for _tool in "$@"; do
        install_if_asked "$_tool" "$_tool"
    done
}

install_group_shell_tools() {
    install_list "SHELL TOOLS" \
        git curl wget fzf ripgrep bat eza fd starship zoxide fastfetch atuin
}

install_group_dev_tools() {
    install_list "DEV TOOLS" \
        neovim git-delta gh jq tmux btop ncdu tldr direnv hyperfine
}

install_group_git_tools() {
    install_list "GIT TOOLS" \
        lazygit yq
}

install_group_containers() {
    install_list "CONTAINERS" \
        docker docker-compose podman
}

install_group_cloud() {
    install_list "CLOUD TOOLS" \
        kubectl helm terraform
}

install_group_hyprland() {
    install_list "HYPRLAND (WAYLAND)" \
        hyprland waybar wlogout rofi dunst kitty alacritty \
        hyprlock hypridle hyprpaper hyprpicker grim slurp \
        wl-clipboard playerctl brightnessctl pavucontrol polkit-gnome \
        xdg-desktop-portal-hyprland
}

install_group_macos_extras() {
    install_list "MACOS EXTRAS" \
        coreutils findutils gnu-sed gnu-tar grep
}

# =============================================================================
# POST-INSTALL FIXES
# =============================================================================
post_install_fixes() {
    header "POST-INSTALL FIXES"
    case "$PM" in
        apt)
            if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
                info "Creating bat -> batcat symlink (Debian/Ubuntu)"
                ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat" 2>/dev/null || true
            fi
            if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
                info "Creating fd -> fdfind symlink (Debian/Ubuntu)"
                ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd" 2>/dev/null || true
            fi
            if [ -d /etc/apt/keyrings ] && ! dpkg -l | grep -q "hyprland" 2>/dev/null; then
                info "Note: Hyprland on Debian/Ubuntu may need a PPA or manual build"
            fi
            ;;
        dnf)
            if command -v lazygit >/dev/null 2>&1; then
                : # already installed via copr
            else
                info "Note: lazygit on Fedora may need 'dnf copr enable atim/lazygit' first"
            fi
            if command -v eza >/dev/null 2>&1; then
                : 
            else
                info "Note: eza on Fedora may need 'dnf copr enable alternateved/eza' first"
            fi
            ;;
    esac

    # Ensure ~/.local/bin is in PATH for symlinks
    mkdir -p "$HOME/.local/bin"

    # cargo install fallbacks for tools not in repos
    if ! command -v starship >/dev/null 2>&1; then
        if command -v cargo >/dev/null 2>&1; then
            info "Installing starship via cargo (not in $PM repos)"
            cargo install starship --locked >/dev/null 2>&1 && info "starship installed" || warn "starship install via cargo failed"
        else
            warn "starship not available via $PM. Install Rust first or use the standalone installer: curl -sS https://starship.rs/install.sh | sh"
        fi
    fi
    if ! command -v zoxide >/dev/null 2>&1; then
        if command -v cargo >/dev/null 2>&1; then
            info "Installing zoxide via cargo"
            cargo install zoxide --locked >/dev/null 2>&1 && info "zoxide installed" || warn "zoxide install via cargo failed"
        elif command -v curl >/dev/null 2>&1; then
            info "Installing zoxide via standalone script"
            _safe_curl_exec https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh >/dev/null 2>&1 || warn "zoxide install failed"
        fi
    fi
    if ! command -v atuin >/dev/null 2>&1 && [ "$PM" != "brew" ] && [ "$PM" != "pacman" ]; then
        if command -v cargo >/dev/null 2>&1; then
            info "Installing atuin via cargo"
            cargo install atuin --locked >/dev/null 2>&1 && info "atuin installed" || warn "atuin install via cargo failed"
        elif command -v curl >/dev/null 2>&1; then
            info "Installing atuin via standalone script"
            _safe_curl_exec https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh >/dev/null 2>&1 || warn "atuin install failed"
        fi
    fi
    if ! command -v fastfetch >/dev/null 2>&1 && [ "$PM" != "pacman" ]; then
        if command -v cargo >/dev/null 2>&1; then
            info "Installing fastfetch via cargo"
            cargo install fastfetch --locked >/dev/null 2>&1 && info "fastfetch installed" || warn "fastfetch install via cargo failed"
        fi
    fi
    if ! command -v lazygit >/dev/null 2>&1; then
        if command -v go >/dev/null 2>&1; then
            info "Installing lazygit via go"
            go install github.com/jesseduffield/lazygit@latest >/dev/null 2>&1 && info "lazygit installed" || warn "lazygit install via go failed"
        elif command -v cargo >/dev/null 2>&1; then
            :
        fi
    fi
    if ! command -v eza >/dev/null 2>&1 && command -v exa >/dev/null 2>&1; then
        info "Creating eza -> exa symlink (older distros)"
        ln -sf "$(command -v exa)" "$HOME/.local/bin/eza" 2>/dev/null || true
    fi
    if ! command -v tldr >/dev/null 2>&1 && command -v tealdeer >/dev/null 2>&1; then
        info "Creating tldr -> tealdeer symlink"
        ln -sf "$(command -v tealdeer)" "$HOME/.local/bin/tldr" 2>/dev/null || true
    fi
    if ! command -v yq >/dev/null 2>&1 && command -v yq-go >/dev/null 2>&1; then
        info "Creating yq -> yq-go symlink"
        ln -sf "$(command -v yq-go)" "$HOME/.local/bin/yq" 2>/dev/null || true
    fi
}

# =============================================================================
# SHELL CONFIGURATION LINKS
# =============================================================================
link_configs() {
    header "LINKING CONFIGURATIONS"
    mkdir -p "$HOME/.config/fastfetch"
    mkdir -p "$HOME/.config/lazygit"
    mkdir -p "$HOME/.config/atuin"
    mkdir -p "$HOME/.config/fish"
    mkdir -p "$HOME/.config"
    BACKUP_DIR="$DOTFILES_STATE_DIR/backups"
    mkdir -p "$BACKUP_DIR"
    backup_existing() {
        src="$1"; dst="$2"
        if [ -e "$dst" ] && [ ! -L "$dst" ]; then
            fname=$(basename "$dst")
            timestamp=$(date +"%Y%m%d-%H%M%S")
            mv "$dst" "$BACKUP_DIR/${fname}.bak"
            info "Backed up existing $dst to $BACKUP_DIR/${fname}.bak"
        fi
    }
    safe_link() {
        src="$1"; dst="$2"
        backup_existing "$src" "$dst"
        ln -nsf "$src" "$dst"
        info "Linked $(basename "$dst")"
    }

    safe_link "$DOTFILES_DIR/shells/bash/.bashrc" "$HOME/.bashrc"
    safe_link "$DOTFILES_DIR/core/.profile" "$HOME/.profile"
    safe_link "$DOTFILES_DIR/shells/zsh/.zshrc" "$HOME/.zshrc"
    safe_link "$DOTFILES_DIR/shells/zsh/.zprofile" "$HOME/.zprofile"
    safe_link "$DOTFILES_DIR/shells/fish/config.fish" "$HOME/.config/fish/config.fish"
    safe_link "$DOTFILES_DIR/apps/git/gitconfig" "$HOME/.gitconfig"
    safe_link "$DOTFILES_DIR/apps/tmux/tmux.conf" "$HOME/.tmux.conf"
    safe_link "$DOTFILES_DIR/apps/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
    safe_link "$DOTFILES_DIR/apps/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    safe_link "$DOTFILES_DIR/apps/fastfetch/battery_health.sh" "$HOME/.config/fastfetch/battery_health.sh"
    safe_link "$DOTFILES_DIR/apps/atuin/config.toml" "$HOME/.config/atuin/config.toml"

    if [ "$DISTRO" = "macos" ]; then
        safe_link "$DOTFILES_DIR/apps/starship-mac.toml" "$HOME/.config/starship.toml"
    else
        safe_link "$DOTFILES_DIR/apps/starship-linux.toml" "$HOME/.config/starship.toml"
    fi
}

# =============================================================================
# MAIN INSTALL ROUTINE
# =============================================================================
header "SYSTEM INFORMATION"
printf "  ${BOLD}Version:${NC}    %s\n" "$VERSION"
printf "  ${BOLD}OS:${NC}         %s\n" "$OS"
printf "  ${BOLD}Distro:${NC}     %s\n" "$DISTRO"
printf "  ${BOLD}Arch:${NC}       %s\n" "$ARCH"
printf "  ${BOLD}Manager:${NC}    %s\n" "$PM"
printf "  ${BOLD}Profile:${NC}    %s\n" "$INSTALL_PROFILE"
[ "$DISTRO" = "macos" ] && printf "  ${BOLD}SoC:${NC}        %s\n" "${MACOS_SOC:-unknown}"
$AUTO_YES && printf "  ${BOLD}Mode:${NC}       ${YELLOW}non-interactive${NC}\n"

# Homebrew bootstrapping (macOS + Linux)
header "BOOTSTRAPPING"
if [ "$DISTRO" = "macos" ] || [ "$PM" = "brew" ]; then
    if ! command -v brew >/dev/null 2>&1; then
        printf "  ${YELLOW}⚠${NC} Homebrew not found.\n"
        if ask_yes_no "Install Homebrew?" y; then
            info "Installing Homebrew..."
            NONINTERACTIVE=1 _safe_curl_exec https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh bash
            if command -v brew >/dev/null 2>&1; then
                PM="brew"
                info "Homebrew installed successfully"
            elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
                PM="brew"
                info "Homebrew installed (linuxbrew)"
            elif [ -f /opt/homebrew/bin/brew ]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
                PM="brew"
                info "Homebrew installed (Apple Silicon)"
            else
                warn "Homebrew install may have failed - continuing with system pkgs"
            fi
        fi
    fi
    if [ "$PM" = "brew" ] && [ -f "$BREWFILE" ]; then
        info "Brewfile detected. Installing bundle..."
        brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
    fi
fi

# Install by profile
case "$INSTALL_PROFILE" in
    minimal)
        install_group_shell_tools
        install_group_dev_tools
        install_group_git_tools
        ;;
    standard)
        install_group_shell_tools
        install_group_dev_tools
        install_group_git_tools
        if [ "$DISTRO" != "macos" ] && [ "$DISTRO" != "mac" ]; then
            install_group_containers
        fi
        ;;
    full)
        install_group_shell_tools
        install_group_dev_tools
        install_group_git_tools
        install_group_containers
        install_group_cloud
        if [ "$DISTRO" != "macos" ] && [ "$DISTRO" != "mac" ]; then
            install_group_hyprland
        fi
        if [ "$DISTRO" = "macos" ] || [ "$DISTRO" = "mac" ]; then
            install_group_macos_extras
        fi
        ;;
    hyprland)
        if [ "$DISTRO" = "macos" ] || [ "$DISTRO" = "mac" ]; then
            warn "Hyprland is not available on macOS. Skipping."
        else
            install_group_hyprland
        fi
        ;;
    macos)
        if [ "$DISTRO" = "macos" ] || [ "$DISTRO" = "mac" ]; then
            install_group_macos_extras
        else
            warn "macOS extras only available on macOS. Skipping."
        fi
        ;;
esac

# Post-install fixes
post_install_fixes

# Link config files
link_configs

# Fonts
if [ "${DOTFILES_INSTALL_FONTS:-1}" != "0" ] && [ -x "$DOTFILES_DIR/install/fonts-install.sh" ]; then
    header "FONTS"
    info "Running fonts installer..."
    "$DOTFILES_DIR/install/fonts-install.sh" || warn "Fonts installer exited with errors"
fi

# =============================================================================
# VALIDATION
# =============================================================================
header "VALIDATING SHELLS"
if command -v bash >/dev/null 2>&1; then
    bash -c ". '$DOTFILES_DIR/shells/bash/aliases.bash' 2>/dev/null; . '$DOTFILES_DIR/shells/bash/functions.bash' 2>/dev/null; alias dots >/dev/null 2>&1; type mkcd >/dev/null 2>&1" \
        && info "Bash behavior check passed" \
        || warn "Bash behavior check failed (non-critical)"
fi
if command -v zsh >/dev/null 2>&1; then
    zsh -c ". '$DOTFILES_DIR/shells/zsh/aliases.zsh' 2>/dev/null; . '$DOTFILES_DIR/shells/zsh/functions.zsh' 2>/dev/null; alias dots >/dev/null 2>&1; whence -w mkcd >/dev/null 2>&1" \
        && info "Zsh behavior check passed" \
        || warn "Zsh behavior check failed (non-critical)"
fi
if command -v fish >/dev/null 2>&1; then
    fish -c "source '$DOTFILES_DIR/shells/fish/aliases.fish' 2>/dev/null; source '$DOTFILES_DIR/shells/fish/functions.fish' 2>/dev/null; alias dots >/dev/null 2>&1; functions -q mkcd >/dev/null 2>&1" \
        && info "Fish behavior check passed" \
        || warn "Fish behavior check failed (non-critical)"
fi

header "CLEANUP"
info "Cleaning up legacy Atuin paths from system RC files..."
sed -i '/\.atuin\/bin\/env/d' "$HOME/.bashrc" "$HOME/.profile" "$HOME/.bash_profile" 2>/dev/null || true
sed -i '/atuin init bash/d' "$HOME/.bashrc" "$HOME/.profile" "$HOME/.bash_profile" 2>/dev/null || true

# Summary
header "INSTALL SUMMARY"
printf "  ${BOLD}Profile:${NC}     %s\n" "$INSTALL_PROFILE"
printf "  ${BOLD}OS/Distro:${NC}   %s / %s\n" "$OS" "$DISTRO"
printf "  ${BOLD}PM:${NC}          %s\n" "$PM"
printf "  ${BOLD}Configs:${NC}     Symlinked to ~/ and ~/.config/\n"
printf "  ${BOLD}Fonts:${NC}       %s\n" "$([ "${DOTFILES_INSTALL_FONTS:-1}" != "0" ] && echo "Installed" || echo "Skipped")"
printf "\n${GREEN}${BOLD}  ✓ Setup complete! Run 'exec \$SHELL' to begin.${NC}\n\n"
