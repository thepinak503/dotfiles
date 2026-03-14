#!/bin/sh
# =============================================================================
# DOTFILES QUICK INSTALLER
# Usage: curl -fsSL is.gd/installdotfiles | sh
# Or: curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install-quick.sh | sh
# =============================================================================

set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
INSTALL_DEPS="${INSTALL_DEPS:-false}"
SHELLS="${SHELLS:-bash,zsh,fish}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() { printf "${GREEN}[INFO]${NC} %s\n" "$1"; }
print_warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
print_error() { printf "${RED}[ERROR]${NC} %s\n" "$1" >&2; }

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
detect_pkg_manager() {
    if command -v brew >/dev/null 2>&1; then
        PKG="brew"
    elif command -v pacman >/dev/null 2>&1; then
        PKG="pacman"
    elif command -v apt >/dev/null 2>&1; then
        PKG="apt"
    elif command -v dnf >/dev/null 2>&1; then
        PKG="dnf"
    else
        PKG="unknown"
    fi
}

# Install dependencies
install_deps() {
    print_info "Installing dependencies..."
    
    CORE_PKGS="git curl wget vim neovim fzf ripgrep tree htop tar gzip unzip"
    MODERN_PKGS="eza bat starship zoxide"
    
    case "$PKG" in
        brew)
            brew install $CORE_PKGS $MODERN_PKGS 2>/dev/null || true
            ;;
        pacman)
            sudo pacman -Sy --noconfirm $CORE_PKGS 2>/dev/null || true
            ;;
        apt)
            sudo apt update -qq 2>/dev/null || true
            sudo apt install -y $CORE_PKGS 2>/dev/null || true
            ;;
        dnf)
            sudo dnf install -y $CORE_PKGS 2>/dev/null || true
            ;;
    esac
    
    # Install starship
    if ! command -v starship >/dev/null 2>&1; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
    fi
    
    # Install eza
    if ! command -v eza >/dev/null 2>&1; then
        ARCH=$(uname -m)
        EZA_URL="https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_${ARCH}-unknown-linux-gnu.tar.gz"
        curl -Ls "$EZA_URL" | sudo tar xzf - -C /usr/local/bin eza 2>/dev/null || true
    fi
    
    # Install bat
    if ! command -v bat >/dev/null 2>&1; then
        ARCH=$(uname -m)
        BAT_URL="https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-${ARCH}-unknown-linux-gnu.tar.gz"
        curl -Ls "$BAT_URL" | sudo tar xzf - -C /usr/local/bin bat 2>/dev/null || true
    fi
    
    # Install zoxide
    if ! command -v zoxide >/dev/null 2>&1; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh 2>/dev/null || true
    fi
    
    print_info "Dependencies installed"
}

# Link config files
link_configs() {
    print_info "Linking config files..."
    
    # Create symlinks
    ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" 2>/dev/null || true
    ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" 2>/dev/null || true
    ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile" 2>/dev/null || true
    
    # Fish
    mkdir -p "$HOME/.config/fish"
    ln -sf "$DOTFILES_DIR/.fish/config.fish" "$HOME/.config/fish/config.fish" 2>/dev/null || true
    
    # Nushell
    mkdir -p "$HOME/.config/nushell"
    [ -f "$DOTFILES_DIR/nushell/config.nu" ] && ln -sf "$DOTFILES_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu" 2>/dev/null || true
    [ -f "$DOTFILES_DIR/nushell/env.nu" ] && ln -sf "$DOTFILES_DIR/nushell/env.nu" "$HOME/.config/nushell/env.nu" 2>/dev/null || true
    
    # Starship
    [ -f "$DOTFILES_DIR/config/starship.toml" ] && ln -sf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml" 2>/dev/null || true
    
    # Other configs
    [ -f "$DOTFILES_DIR/.vimrc" ] && ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc" 2>/dev/null || true
    [ -f "$DOTFILES_DIR/.tmux.conf" ] && ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf" 2>/dev/null || true
    [ -f "$DOTFILES_DIR/.nanorc" ] && ln -sf "$DOTFILES_DIR/.nanorc" "$HOME/.nanorc" 2>/dev/null || true
    [ -f "$DOTFILES_DIR/.inputrc" ] && ln -sf "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc" 2>/dev/null || true
    [ -f "$DOTFILES_DIR/git/.gitconfig" ] && ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig" 2>/dev/null || true
    
    print_info "Configs linked"
}

# Set default shell
set_shell() {
    print_info "Setting default shell..."
    
    case "$1" in
        zsh)
            if command -v zsh >/dev/null 2>&1; then
                chsh -s "$(command -v zsh)" 2>/dev/null || true
            fi
            ;;
        fish)
            if command -v fish >/dev/null 2>&1; then
                chsh -s "$(command -v fish)" 2>/dev/null || true
            fi
            ;;
    esac
}

# Main
main() {
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "         DOTFILES QUICK INSTALLER"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    
    detect_os
    detect_pkg_manager
    
    print_info "Detected: $OS ($PKG)"
    print_info "Target: $DOTFILES_DIR"
    
    # Clone dotfiles if not present
    if [ ! -d "$DOTFILES_DIR/.git" ]; then
        print_info "Cloning dotfiles..."
        if [ -d "$HOME/git/dotfiles" ]; then
            mv "$HOME/git/dotfiles" "$DOTFILES_DIR"
        else
            git clone --depth 1 https://github.com/thepinak503/dotfiles.git "$DOTFILES_DIR" 2>/dev/null || {
                print_error "Failed to clone dotfiles"
                exit 1
            }
        fi
    fi
    
    # Install deps if requested
    if [ "$INSTALL_DEPS" = "true" ] || [ "$1" = "--install-deps" ]; then
        install_deps
    fi
    
    # Link configs
    link_configs
    
    # Set shell if specified
    if [ -n "$1" ]; then
        set_shell "$1"
    fi
    
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
