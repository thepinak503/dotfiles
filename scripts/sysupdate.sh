#!/bin/bash
# System Update Script
# Universal package manager update

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[*]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

error() {
    echo -e "${RED}[✗]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Detect OS
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    OS="unknown"
fi

log "Detected OS: $OS"

# =============================================================================
# PACKAGE MANAGER UPDATES
# =============================================================================

case "$OS" in
    arch|manjaro|endeavouros)
        log "Updating Arch Linux system..."
        
        # Update pacman packages
        if command -v pacman &>/dev/null; then
            sudo pacman -Syu --noconfirm
            success "Pacman packages updated"
        fi
        
        # Update AUR packages
        if command -v yay &>/dev/null; then
            log "Updating AUR packages with yay..."
            yay -Sua --noconfirm
            success "AUR packages updated"
        elif command -v paru &>/dev/null; then
            log "Updating AUR packages with paru..."
            paru -Sua --noconfirm
            success "AUR packages updated"
        fi
        
        # Clean up
        log "Cleaning up package cache..."
        sudo pacman -Sc --noconfirm
        ;;
        
    debian|ubuntu|pop|linuxmint)
        log "Updating Debian/Ubuntu system..."
        sudo apt update
        sudo apt upgrade -y
        sudo apt autoremove -y
        sudo apt clean
        success "System updated"
        ;;
        
    fedora|rhel|centos)
        log "Updating Fedora system..."
        sudo dnf upgrade -y
        sudo dnf autoremove -y
        sudo dnf clean all
        success "System updated"
        ;;
        
    opensuse*)
        log "Updating openSUSE system..."
        sudo zypper refresh
        sudo zypper update -y
        sudo zypper clean
        success "System updated"
        ;;
        
    alpine)
        log "Updating Alpine Linux system..."
        sudo apk update
        sudo apk upgrade
        success "System updated"
        ;;
        
    macos)
        log "Updating macOS system..."
        if command -v brew &>/dev/null; then
            brew update
            brew upgrade
            brew cleanup
            success "Homebrew packages updated"
        fi
        ;;
        
    *)
        error "Unknown OS: $OS"
        exit 1
        ;;
esac

# =============================================================================
# FLATPAK UPDATES
# =============================================================================

if command -v flatpak &>/dev/null; then
    log "Updating Flatpak packages..."
    flatpak update -y
    success "Flatpak packages updated"
fi

# =============================================================================
# SNAP UPDATES
# =============================================================================

if command -v snap &>/dev/null; then
    log "Updating Snap packages..."
    sudo snap refresh
    success "Snap packages updated"
fi

# =============================================================================
# DOTFILES UPDATE
# =============================================================================

if [ -d "$HOME/.dotfiles" ]; then
    log "Updating dotfiles..."
    cd "$HOME/.dotfiles"
    git pull origin main
    success "Dotfiles updated"
fi

# =============================================================================
# LANGUAGE VERSION MANAGERS
# =============================================================================

# NVM
if [ -d "$HOME/.nvm" ]; then
    log "Updating Node.js versions..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Update default Node version if set
    if [ -f "$HOME/.nvmrc" ]; then
        nvm install
        success "Node.js updated"
    fi
fi

# Rust
if command -v rustup &>/dev/null; then
    log "Updating Rust toolchain..."
    rustup update
    success "Rust updated"
fi

# =============================================================================
# SUMMARY
# =============================================================================

echo ""
success "System update complete!"
echo ""
echo "You may want to restart your shell or log out and back in."