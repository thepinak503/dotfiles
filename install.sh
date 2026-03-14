#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER - UNIFIED SHELL CONFIGURATION
# Supports: Bash, Zsh, Fish, Nushell
# Distros: Arch, Debian, Fedora, macOS
# =============================================================================

set -euo pipefail

VERSION="5.1.0"
DOTFILES_REPO="${DOTFILES_DIR:-$HOME/.dotfiles}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
SKIP_BACKUP=false
FORCE=false
AUTO=false
SHELLS=""
INSTALL_DEPS=false

print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║         DOTFILES INSTALLER v${VERSION}                          ║"
    echo "║                                                            ║"
    echo "║    Unified Shell Configuration for All Shells              ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "${CYAN}→${NC} $1"; }

# Detect OS
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="$ID"
        OS_NAME="$NAME"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        OS_NAME="macOS"
    else
        OS="unknown"
        OS_NAME="Unknown"
    fi
    print_info "Detected: $OS_NAME"
}

# Detect package manager
detect_pkg_manager() {
    if command -v brew &>/dev/null; then
        PKG_MANAGER="brew"
    elif command -v pacman &>/dev/null; then
        PKG_MANAGER="pacman"
    elif command -v apt &>/dev/null; then
        PKG_MANAGER="apt"
    elif command -v dnf &>/dev/null; then
        PKG_MANAGER="dnf"
    elif command -v zypper &>/dev/null; then
        PKG_MANAGER="zypper"
    elif command -v apk &>/dev/null; then
        PKG_MANAGER="apk"
    else
        PKG_MANAGER="unknown"
    fi
    print_info "Package manager: $PKG_MANAGER"
}

# Detect shells
detect_shells() {
    SHELLS=()
    
    command -v bash &>/dev/null && SHELLS+=("bash")
    command -v zsh &>/dev/null && SHELLS+=("zsh")
    command -v fish &>/dev/null && SHELLS+=("fish")
    command -v nu &>/dev/null && SHELLS+=("nushell")
    
    print_info "Detected shells: ${SHELLS[*]-none}"
}

# Install shell support - ALL PACKAGES
install_shell_support() {
    print_step "Installing shell support packages..."
    
    local packages=(
        git curl wget vim neovim fzf ripgrep tree htop
        tar gzip unzip zip
    )
    
    # Modern tools
    local modern=(
        eza bat starship zoxide delta fd procs dust
        duf bottom yazi tldr httpie
    )
    
    case "$PKG_MANAGER" in
        brew)
            brew install "${packages[@]}" "${modern[@]}" 2>/dev/null || true
            brew install zsh fish nushell 2>/dev/null || true
            ;;
        pacman)
            sudo pacman -Sy --noconfirm "${packages[@]}" 2>/dev/null || true
            # Install modern tools
            curl -Ls https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_x86_64-unknown-linux-gnu.tar.gz | sudo tar xzf - -C /usr/local/bin eza 2>/dev/null || true
            curl -Ls https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-gnu.tar.gz | sudo tar xzf - -C /usr/local/bin bat 2>/dev/null || true
            curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
            curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh 2>/dev/null || true
            ;;
        apt)
            sudo apt update -qq
            sudo apt install -y "${packages[@]}" 2>/dev/null || true
            # Add modern tools via cargo or binary
            curl -Ls https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_x86_64-unknown-linux-gnu.tar.gz | sudo tar xzf - -C /usr/local/bin eza 2>/dev/null || true
            curl -Ls https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-gnu.tar.gz | sudo tar xzf - -C /usr/local/bin bat 2>/dev/null || true
            curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
            ;;
        dnf)
            sudo dnf install -y "${packages[@]}" 2>/dev/null || true
            ;;
    esac
    
    # Install Oh-My-Zsh if using zsh
    if command -v zsh &>/dev/null && [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>/dev/null || true
    fi
    
    # Install fzf
    if ! command -v fzf &>/dev/null; then
        [[ -d ~/.fzf ]] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all 2>/dev/null || true
    fi
    
    print_success "Shell support packages installed"
}

# Backup existing configs
backup_configs() {
    [[ "$SKIP_BACKUP" == true ]] && return
    
    print_step "Backing up existing configs..."
    mkdir -p "$BACKUP_DIR"
    
    [[ -f "$HOME/.bashrc" ]] && cp "$HOME/.bashrc" "$BACKUP_DIR/"
    [[ -f "$HOME/.bash_profile" ]] && cp "$HOME/.bash_profile" "$BACKUP_DIR/"
    [[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$BACKUP_DIR/"
    [[ -f "$HOME/.zshenv" ]] && cp "$HOME/.zshenv" "$BACKUP_DIR/"
    [[ -d "$HOME/.config/fish" ]] && cp -r "$HOME/.config/fish" "$BACKUP_DIR/"
    [[ -d "$HOME/.config/nushell" ]] && cp -r "$HOME/.config/nushell" "$BACKUP_DIR/"
    
    print_success "Backup saved to: $BACKUP_DIR"
}

# Link bash config
install_bash() {
    [[ ! " ${SHELLS[*]} " =~ " bash " ]] && return
    
    print_step "Installing Bash configuration..."
    
    mkdir -p "$HOME"
    ln -sf "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
    ln -sf "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile"
    [[ -f "$SCRIPT_DIR/.bash_logout" ]] && ln -sf "$SCRIPT_DIR/.bash_logout" "$HOME/.bash_logout"
    
    print_success "Bash configured"
}

# Link zsh config
install_zsh() {
    [[ ! " ${SHELLS[*]} " =~ " zsh " ]] && return
    
    print_step "Installing Zsh configuration..."
    
    mkdir -p "$HOME"
    ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    
    print_success "Zsh configured"
}

# Link fish config
install_fish() {
    [[ ! " ${SHELLS[*]} " =~ " fish " ]] && return
    
    print_step "Installing Fish configuration..."
    
    mkdir -p "$HOME/.config/fish"
    ln -sf "$SCRIPT_DIR/.fish/config.fish" "$HOME/.config/fish/config.fish"
    [[ -d "$SCRIPT_DIR/.fish/conf.d" ]] && ln -sf "$SCRIPT_DIR/.fish/conf.d" "$HOME/.config/fish/conf.d" 2>/dev/null || true
    [[ -d "$SCRIPT_DIR/.fish/functions" ]] && ln -sf "$SCRIPT_DIR/.fish/functions" "$HOME/.config/fish/functions" 2>/dev/null || true
    
    print_success "Fish configured"
}

# Link nushell config
install_nushell() {
    [[ ! " ${SHELLS[*]} " =~ " nushell " ]] && return
    
    print_step "Installing Nushell configuration..."
    
    mkdir -p "$HOME/.config/nushell"
    [[ -f "$SCRIPT_DIR/nushell/config.nu" ]] && ln -sf "$SCRIPT_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu"
    [[ -f "$SCRIPT_DIR/nushell/env.nu" ]] && ln -sf "$SCRIPT_DIR/nushell/env.nu" "$HOME/.config/nushell/env.nu"
    [[ -f "$SCRIPT_DIR/nushell/config.local.nu" ]] && ln -sf "$SCRIPT_DIR/nushell/config.local.nu" "$HOME/.config/nushell/config.local.nu"
    [[ -f "$SCRIPT_DIR/nushell/env.local.nu" ]] && ln -sf "$SCRIPT_DIR/nushell/env.local.nu" "$HOME/.config/nushell/env.local.nu"
    
    print_success "Nushell configured"
}

# Install other configs
install_other() {
    print_step "Installing other configurations..."
    
    # Git
    [[ -d "$SCRIPT_DIR/git" ]] && mkdir -p "$HOME/.config/git" && ln -sf "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
    
    # Vim
    [[ -f "$SCRIPT_DIR/.vimrc" ]] && ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
    
    # Tmux
    [[ -f "$SCRIPT_DIR/.tmux.conf" ]] && ln -sf "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    
    # Nano
    [[ -f "$SCRIPT_DIR/.nanorc" ]] && ln -sf "$SCRIPT_DIR/.nanorc" "$HOME/.nanorc"
    
    # Inputrc
    [[ -f "$SCRIPT_DIR/.inputrc" ]] && ln -sf "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"
    
    # Starship
    [[ -f "$SCRIPT_DIR/config/starship.toml" ]] && mkdir -p "$HOME/.config" && ln -sf "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    
    print_success "Other configs installed"
}

# Set default shell
set_default_shell() {
    if [[ -n "$1" ]] && command -v "$1" &>/dev/null; then
        print_step "Setting default shell to $1..."
        if [[ "$OS" == "macos" ]]; then
            sudo chsh -s "$(command -v "$1")" 2>/dev/null || true
        else
            chsh -s "$(command -v "$1")" 2>/dev/null || true
        fi
        print_success "Default shell set to $1"
    fi
}

# Show help
show_help() {
    cat << EOF
${BOLD}Dotfiles Installer v${VERSION}${NC}

${BOLD}Usage:${NC} ./install.sh [OPTIONS]

${BOLD}Options:${NC}
  -h, --help              Show this help
  -s, --shells SHELLS    Shells to install (bash,zsh,fish,nushell)
  -d, --default SHELL    Set default shell
  --skip-backup          Skip backup
  --force                Force overwrite
  --install-deps         Install dependencies (modern tools)
  --no-deps              Skip dependency installation
  -y, --yes              Skip confirmation

${BOLD}Examples:${NC}
  ./install.sh                        # Interactive
  ./install.sh -s bash,zsh,fish       # Specific shells
  ./install.sh -s all --install-deps  # Install all with deps
  ./install.sh -d zsh                 # Set zsh as default

EOF
}

# Main
main() {
    local default_shell=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help) show_help; exit 0 ;;
            -s|--shells) SHELLS="${2//,/ }"; shift 2 ;;
            -d|--default) default_shell="$2"; shift 2 ;;
            --skip-backup) SKIP_BACKUP=true; shift ;;
            --force) FORCE=true; shift ;;
            --install-deps) INSTALL_DEPS=true; shift ;;
            --no-deps) INSTALL_DEPS=false; shift ;;
            -y|--yes) AUTO=true; shift ;;
            *) shift ;;
        esac
    done
    
    print_header
    detect_os
    detect_pkg_manager
    
    if [[ -z "${SHELLS[*]}" ]]; then
        detect_shells
    else
        SHELLS=($SHELLS)
    fi
    
    if [[ "$AUTO" != true ]]; then
        echo ""
        echo "Shells to configure: ${SHELLS[*]-none}"
        read -p "Continue? [Y/n]: " confirm
        [[ "$confirm" =~ ^[Nn]$ ]] && exit 0
    fi
    
    [[ "$INSTALL_DEPS" == true ]] && install_shell_support
    
    backup_configs
    
    install_bash
    install_zsh
    install_fish
    install_nushell
    install_other
    
    [[ -n "$default_shell" ]] && set_default_shell "$default_shell"
    
    echo ""
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║                 INSTALLATION COMPLETE!                     ║${NC}"
    echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Restart your shell or run:"
    echo "  source ~/.bashrc    # for Bash"
    echo "  source ~/.zshrc     # for Zsh"
    echo ""
}

main "$@"
