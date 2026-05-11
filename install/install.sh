#!/usr/bin/env sh
set -e
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
VERSION="1.0.0"
BREWFILE="$DOTFILES_DIR/apps/brew/Brewfile"

AUTO_YES=false
for _arg in "$@"; do
    case "$_arg" in
        --yes|-y) AUTO_YES=true ;;
        --help|-h)
            echo "Usage: install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --yes, -y    Install all dependencies without prompting"
            echo "  --help, -h   Show this help message"
            exit 0
            ;;
    esac
done

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

OS="$(uname -s)"
case "$OS" in
    Linux)
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO=$ID
        else
            DISTRO="linux"
        fi
        ;;
    Darwin) DISTRO="macos" ;;
    *) DISTRO="unknown" ;;
esac
if command -v brew >/dev/null 2>&1; then PM="brew";
elif command -v pacman >/dev/null 2>&1; then PM="pacman";
elif command -v apt-get >/dev/null 2>&1; then PM="apt";
elif command -v dnf >/dev/null 2>&1; then PM="dnf";
elif command -v zypper >/dev/null 2>&1; then PM="zypper";
elif command -v apk >/dev/null 2>&1; then PM="apk";
elif command -v xbps-install >/dev/null 2>&1; then PM="xbps";
else PM="manual"; fi

pkg_name() {
    _pkg=$1
    case "$PM" in
        apt)
            case "$_pkg" in
                bash-preexec) echo "bash-preexec" ;;
                eza)          echo "eza" ;;
                bat)          echo "bat" ;;
                ripgrep)      echo "ripgrep" ;;
                fd)           echo "fd-find" ;;
                *)            echo "$_pkg" ;;
            esac
            ;;
        dnf)
            case "$_pkg" in
                bash-preexec) echo "bash-preexec" ;;
                *)            echo "$_pkg" ;;
            esac
            ;;
        *) echo "$_pkg" ;;
    esac
}

install_package() {
    _pkg=$1
    if command -v "$_pkg" >/dev/null 2>&1; then
        return 0
    fi
    _real_pkg=$(pkg_name "$_pkg")
    case "$PM" in
        pacman) sudo pacman -S --noconfirm "$_real_pkg" >/dev/null 2>&1 || return 1 ;;
        apt)    sudo apt-get install -y "$_real_pkg" >/dev/null 2>&1 || return 1 ;;
        dnf)    sudo dnf install -y "$_real_pkg" >/dev/null 2>&1 || return 1 ;;
        brew)
            if [ -f "$BREWFILE" ]; then
                brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
            else
                brew install "$_real_pkg" >/dev/null 2>&1 || return 1
            fi
            ;;
        *)      return 1 ;;
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

header "SYSTEM INFORMATION"
printf "  ${BOLD}Version:${NC}    %s\n" "$VERSION"
printf "  ${BOLD}Distro:${NC}     %s\n" "$DISTRO"
printf "  ${BOLD}Manager:${NC}    %s\n" "$PM"
$AUTO_YES && printf "  ${BOLD}Mode:${NC}       ${YELLOW}non-interactive (--yes)${NC}\n"

header "BOOTSTRAPPING CORE"

if ! command -v brew >/dev/null 2>&1; then
    printf "  ${YELLOW}⚠${NC} Homebrew not found.\n"
    if [ "$DISTRO" = "macos" ] || { [ "$DISTRO" != "unknown" ] && [ -t 1 ]; }; then
        if ask_yes_no "Install Homebrew?" y; then
            info "Installing Homebrew..."
            NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>&1 || true
            if command -v brew >/dev/null 2>&1; then
                PM="brew"
                info "Homebrew installed successfully"
            elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
                PM="brew"
                info "Homebrew installed successfully (linuxbrew)"
            elif [ -f /opt/homebrew/bin/brew ]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
                PM="brew"
                info "Homebrew installed successfully (Apple Silicon)"
            else
                warn "Homebrew install may have failed - continuing with system pkgs"
            fi
        else
            warn "Skipping Homebrew install"
        fi
    fi
fi

if [ "$PM" = "brew" ] && [ -f "$BREWFILE" ]; then
    info "Detected Homebrew Bundle. Installing packages..."
    brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
fi

header "CORE TOOLS"
for tool in git curl wget fzf ripgrep starship zoxide eza bat fastfetch atuin; do
    install_if_asked "$tool" "$tool"
done

header "SHELL DEPS"
case "$PM" in
    pacman)
        install_if_asked "bash-preexec" "bash-preexec (atuin bash hook)"
        if ask_yes_no "Install find-the-command (command-not-found hook)?" y; then
            if command -v paru >/dev/null 2>&1; then
                paru -S --noconfirm find-the-command >/dev/null 2>&1 && info "Installed find-the-command" || warn "Could not install find-the-command"
            elif command -v yay >/dev/null 2>&1; then
                yay -S --noconfirm find-the-command >/dev/null 2>&1 && info "Installed find-the-command" || warn "Could not install find-the-command"
            else
                warn "Need paru or yay to install find-the-command (AUR)"
            fi
        fi
        ;;
    apt|dnf)
        if ask_yes_no "Install bash-preexec for atuin bash support?" y; then
            if install_package bash-preexec; then
                info "Installed bash-preexec"
            else
                warn "bash-preexec not in repos - install manually if using bash"
            fi
        fi
        ;;
    *)
        warn "bash-preexec not available via $PM - install manually if using bash with atuin"
        ;;
esac

header "OPTIONAL TOOLS"
install_if_asked "lazygit" "lazygit (git TUI)"
install_if_asked "tmux" "tmux (terminal multiplexer)"
install_if_asked "btop" "btop (system monitor)"
install_if_asked "ncdu" "ncdu (disk usage analyzer)"
install_if_asked "tldr" "tldr (simplified man pages)"
install_if_asked "yazi" "yazi (terminal file manager)"
install_if_asked "lazydocker" "lazydocker (docker TUI)"
install_if_asked "zellij" "zellij (terminal workspace)"
install_if_asked "atuin" "atuin (shell history)"

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
if [ "${DOTFILES_INSTALL_FONTS:-1}" != "0" ] && [ -x "$DOTFILES_DIR/install/fonts-install.sh" ]; then
    info "Running fonts installer..."
    "$DOTFILES_DIR/install/fonts-install.sh" || warn "Fonts installer exited with errors"
fi
header "FINALIZING"
header "VALIDATING SHELLS"
if command -v bash >/dev/null 2>&1; then
    bash -c ". '$DOTFILES_DIR/shells/bash/aliases.bash'; . '$DOTFILES_DIR/shells/bash/functions.bash'; alias dots >/dev/null; type mkcd >/dev/null" \
        && info "Bash behavior check passed" \
        || warn "Bash behavior check failed"
fi
if command -v zsh >/dev/null 2>&1; then
    zsh -c ". '$DOTFILES_DIR/shells/zsh/aliases.zsh'; . '$DOTFILES_DIR/shells/zsh/functions.zsh'; alias dots >/dev/null; whence -w mkcd >/dev/null" \
        && info "Zsh behavior check passed" \
        || warn "Zsh behavior check failed"
fi
if command -v fish >/dev/null 2>&1; then
    fish -c "source '$DOTFILES_DIR/shells/fish/aliases.fish'; source '$DOTFILES_DIR/shells/fish/functions.fish'; alias dots >/dev/null; functions -q mkcd" \
        && info "Fish behavior check passed" \
        || warn "Fish behavior check failed"
fi
info "Cleaning up legacy Atuin paths from system RC files..."
sed -i '/\.atuin\/bin\/env/d' "$HOME/.bashrc" "$HOME/.profile" "$HOME/.bash_profile" 2>/dev/null || true
sed -i '/atuin init bash/d' "$HOME/.bashrc" "$HOME/.profile" "$HOME/.bash_profile" 2>/dev/null || true
printf "\n${GREEN}${BOLD}✓ Setup complete! Run 'exec \$SHELL' to begin.${NC}\n\n"