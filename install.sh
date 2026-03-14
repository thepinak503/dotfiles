#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER v4.0.0
# Supports: Bash, Zsh, Fish, Nushell
# Distros: Arch, Debian, Fedora, macOS
# Usage: curl -fsSL https://is.gd/install_dotfiles | sh
# =============================================================================

set -e

VERSION="4.0.0"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Flags
INSTALL_DEPS=false
AUTO=false
SKIP_BACKUP=false

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS="$ID"
    elif [ "$(uname -s)" = "Darwin" ]; then
        OS="macos"
    else
        OS="unknown"
    fi
}

# Detect package manager
detect_pkg() {
    if command -v brew >/dev/null 2>&1; then PKG="brew"
    elif command -v pacman >/dev/null 2>&1; then PKG="pacman"
    elif command -v apt >/dev/null 2>&1; then PKG="apt"
    elif command -v dnf >/dev/null 2>&1; then PKG="dnf"
    else PKG="unknown"
    fi
}

# Install dependencies
install_deps() {
    print_info "Installing dependencies..."
    
    CORE="git curl wget vim neovim fzf ripgrep tree htop tar gzip unzip"
    
    case "$PKG" in
        brew)
            brew install $CORE eza bat starship zoxide 2>/dev/null || true
            ;;
        pacman)
            sudo pacman -Sy --noconfirm $CORE 2>/dev/null || true
            ;;
        apt)
            sudo apt update -qq 2>/dev/null || true
            sudo apt install -y $CORE 2>/dev/null || true
            ;;
        dnf)
            sudo dnf install -y $CORE 2>/dev/null || true
            ;;
    esac
    
    # Install starship
    [ ! -x "$(command -v starship)" ] && curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
    
    # Install eza
    [ ! -x "$(command -v eza)" ] && ARCH=$(uname -m) && curl -Ls "https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_${ARCH}-unknown-linux-gnu.tar.gz" | sudo tar xzf - -C /usr/local/bin eza 2>/dev/null || true
    
    # Install bat
    [ ! -x "$(command -v bat)" ] && ARCH=$(uname -m) && curl -Ls "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-${ARCH}-unknown-linux-gnu.tar.gz" | sudo tar xzf - -C /usr/local/bin bat 2>/dev/null || true
    
    # Install zoxide
    [ ! -x "$(command -v zoxide)" ] && curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh 2>/dev/null || true
    
    # Install Oh-My-Zsh
    [ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>/dev/null || true
    
    print_info "Dependencies installed"
}

# Backup existing configs
backup() {
    [ "$SKIP_BACKUP" = "true" ] && return
    print_info "Backing up existing configs..."
    mkdir -p "$BACKUP_DIR"
    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$BACKUP_DIR/"
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR/"
    [ -d "$HOME/.config/fish" ] && cp -r "$HOME/.config/fish" "$BACKUP_DIR/"
    print_info "Backup saved to: $BACKUP_DIR"
}

# Link configs
link_configs() {
    print_info "Linking config files..."
    
    # Shell configs
    ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
    [ -f "$DOTFILES_DIR/.bash_logout" ] && ln -sf "$DOTFILES_DIR/.bash_logout" "$HOME/.bash_logout"
    
    # Fish
    mkdir -p "$HOME/.config/fish"
    ln -sf "$DOTFILES_DIR/.fish/config.fish" "$HOME/.config/fish/config.fish"
    
    # Nushell
    mkdir -p "$HOME/.config/nushell"
    [ -f "$DOTFILES_DIR/nushell/config.nu" ] && ln -sf "$DOTFILES_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu"
    [ -f "$DOTFILES_DIR/nushell/env.nu" ] && ln -sf "$DOTFILES_DIR/nushell/env.nu" "$HOME/.config/nushell/env.nu"
    
    # Starship
    [ -f "$DOTFILES_DIR/config/starship.toml" ] && ln -sf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    
    # Other configs
    [ -f "$DOTFILES_DIR/.vimrc" ] && ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    [ -f "$DOTFILES_DIR/.tmux.conf" ] && ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
    [ -f "$DOTFILES_DIR/.nanorc" ] && ln -sf "$DOTFILES_DIR/.nanorc" "$HOME/.nanorc"
    [ -f "$DOTFILES_DIR/.inputrc" ] && ln -sf "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"
    [ -d "$DOTFILES_DIR/git" ] && mkdir -p "$HOME/.config/git" && ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    
    print_info "Configs linked"
}

# Main
main() {
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "         DOTFILES INSTALLER v$VERSION"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    
    # Check for --install-deps flag
    for arg in "$@"; do
        [ "$arg" = "--install-deps" ] && INSTALL_DEPS=true
        [ "$arg" = "--skip-backup" ] && SKIP_BACKUP=true
    done
    
    # Detect OS
    detect_os
    detect_pkg
    
    print_info "Detected: $OS ($PKG)"
    print_info "Target: $DOTFILES_DIR"
    
    # Clone if needed
    if [ ! -d "$DOTFILES_DIR/.git" ]; then
        print_info "Cloning dotfiles..."
        if [ -d "$HOME/git/dotfiles" ]; then
            mv "$HOME/git/dotfiles" "$DOTFILES_DIR"
        else
            git clone --depth 1 https://github.com/thepinak503/dotfiles.git "$DOTFILES_DIR"
        fi
    fi
    
    cd "$DOTFILES_DIR"
    
    # Install deps if requested
    [ "$INSTALL_DEPS" = "true" ] && install_deps
    
    # Backup and link
    backup
    link_configs
    
    echo ""
    echo "════════════════════════════════════════════════════════════"
    print_info "Installation complete!"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "Run: source ~/.bashrc   # Bash"
    echo "Run: source ~/.zshrc    # Zsh"
    echo ""
}

main "$@"
