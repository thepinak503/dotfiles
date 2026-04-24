#!/usr/bin/env sh
set -e
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/local/share/.dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
VERSION="12.0.0"
BREWFILE="$DOTFILES_DIR/apps/brew/Brewfile"
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
if command -v pacman >/dev/null 2>&1; then PM="pacman";
elif command -v apt-get >/dev/null 2>&1; then PM="apt";
elif command -v dnf >/dev/null 2>&1; then PM="dnf";
elif command -v zypper >/dev/null 2>&1; then PM="zypper";
elif command -v apk >/dev/null 2>&1; then PM="apk";
elif command -v xbps-install >/dev/null 2>&1; then PM="xbps";
elif [ "$DISTRO" = "macos" ] && command -v brew >/dev/null 2>&1; then PM="brew";
else PM="manual"; fi
install_package() {
    _pkg=$1
    if command -v "$_pkg" >/dev/null 2>&1; then
        return 0
    fi
    case "$PM" in
        pacman) sudo pacman -S --noconfirm "$_pkg" >/dev/null 2>&1 || return 1 ;;
        apt)    sudo apt-get install -y "$_pkg" >/dev/null 2>&1 || return 1 ;;
        dnf)    sudo dnf install -y "$_pkg" >/dev/null 2>&1 || return 1 ;;
        brew)
            if [ -f "$BREWFILE" ]; then
                info "Installing packages from Brewfile..."
                brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
            else
                brew install "$_pkg" >/dev/null 2>&1 || return 1
            fi
            ;;
        *)      return 1 ;;
    esac
}
header "SYSTEM INFORMATION"
printf "  ${BOLD}Version:${NC} %s\n" "$VERSION"
printf "  ${BOLD}Distro:${NC}  %s\n" "$DISTRO"
printf "  ${BOLD}Manager:${NC} %s\n" "$PM"
header "BOOTSTRAPPING CORE"
if [ "$PM" = "brew" ] && [ -f "$BREWFILE" ]; then
    info "Detected Homebrew Bundle. Installing packages..."
    brew bundle --file="$BREWFILE" >/dev/null 2>&1 || true
fi
for tool in git curl wget fzf ripgrep starship zoxide eza bat fastfetch atuin; do
    if install_package "$tool"; then
        info "Installed $tool"
    else
        warn "Could not install $tool via $PM (may need manual install)"
    fi
done
header "LINKING CONFIGURATIONS"
mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/atuin"
mkdir -p "$HOME/.config/fish"
safe_link() {
    src="$1"; dst="$2"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.bak"
        warn "Backed up existing $dst to $dst.bak"
    fi
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
# Optionally install fonts. Set DOTFILES_INSTALL_FONTS=0 to disable.
if [ "${DOTFILES_INSTALL_FONTS:-1}" != "0" ] && [ -x "$DOTFILES_DIR/install/fonts-install.sh" ]; then
    info "Running fonts installer..."
    # The fonts script will choose system or user install as appropriate.
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
