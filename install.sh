#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER
# One-command setup for the ultimate dotfiles configuration
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Configuration
DOTFILES_REPO="https://github.com/thepinak503/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Print functions
print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DOTFILES INSTALLER v2.0.0                        ║"
    echo "║    The Ultimate Universal Shell Configuration              ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_step() {
    echo -e "${PURPLE}→${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_step "Checking prerequisites..."
    
    # Check for git
    if ! command -v git &>/dev/null; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Detect operating system
detect_os() {
    print_step "Detecting operating system..."
    
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$ID
        OS_NAME=$NAME
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        OS_NAME="macOS"
    else
        OS="unknown"
        OS_NAME="Unknown"
    fi
    
    print_success "Detected: $OS_NAME"
}

# Backup existing dotfiles
backup_existing() {
    print_step "Backing up existing dotfiles..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup files if they exist
    [[ -f ~/.bashrc ]] && cp ~/.bashrc "$BACKUP_DIR/" && print_info "Backed up ~/.bashrc"
    [[ -f ~/.bash_profile ]] && cp ~/.bash_profile "$BACKUP_DIR/" && print_info "Backed up ~/.bash_profile"
    [[ -f ~/.zshrc ]] && cp ~/.zshrc "$BACKUP_DIR/" && print_info "Backed up ~/.zshrc"
    [[ -f ~/.profile ]] && cp ~/.profile "$BACKUP_DIR/" && print_info "Backed up ~/.profile"
    [[ -f ~/.inputrc ]] && cp ~/.inputrc "$BACKUP_DIR/" && print_info "Backed up ~/.inputrc"
    [[ -f ~/.gitconfig ]] && cp ~/.gitconfig "$BACKUP_DIR/" && print_info "Backed up ~/.gitconfig"
    
    print_success "Backup completed in $BACKUP_DIR"
}

# Clone or update dotfiles
clone_dotfiles() {
    print_step "Cloning dotfiles repository..."
    
    if [[ -d "$DOTFILES_DIR" ]]; then
        print_warning "Dotfiles directory already exists. Updating..."
        cd "$DOTFILES_DIR"
        git pull origin main
    else
        git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
    
    print_success "Dotfiles cloned/updated"
}

# Install dependencies based on OS
install_dependencies() {
    print_step "Installing dependencies..."
    
    local packages=""
    
    case "$OS" in
        arch|manjaro|endeavouros)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch"
            print_info "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            
            # Check for AUR helper
            if command -v yay &>/dev/null || command -v paru &>/dev/null; then
                print_info "Installing AUR packages..."
                local aur_helper=$(command -v yay || command -v paru)
                $aur_helper -S --needed --noconfirm dust delta procs sd 2>/dev/null || print_warning "Some AUR packages may need manual installation"
            fi
            ;;
            
        debian|ubuntu|pop|linuxmint)
            packages="git curl wget fzf zoxide bat ripgrep fd-find"
            print_info "Installing packages with apt..."
            sudo apt-get update
            sudo apt-get install -y $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            
            # Install additional tools via other methods
            print_info "Installing additional tools..."
            
            # eza (may need manual install)
            if ! command -v eza &>/dev/null; then
                print_warning "eza not available in apt. Install manually from: https://github.com/eza-community/eza"
            fi
            
            # starship
            if ! command -v starship &>/dev/null; then
                curl -sS https://starship.rs/install.sh | sh
            fi
            
            # fastfetch
            if ! command -v fastfetch &>/dev/null; then
                print_warning "fastfetch not available in apt. Install manually."
            fi
            ;;
            
        fedora|rhel|centos)
            packages="git curl wget fzf zoxide eza bat ripgrep fd-find starship fastfetch"
            print_info "Installing packages with dnf..."
            sudo dnf install -y $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            ;;
            
        opensuse*)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch"
            print_info "Installing packages with zypper..."
            sudo zypper install -y $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            ;;
            
        alpine)
            packages="git curl wget fzf zoxide bat ripgrep fd"
            print_info "Installing packages with apk..."
            sudo apk add $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            ;;
            
        macos)
            if command -v brew &>/dev/null; then
                packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch dust delta"
                print_info "Installing packages with Homebrew..."
                brew install $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            else
                print_warning "Homebrew not found. Please install it first: https://brew.sh"
            fi
            ;;
            
        *)
            print_warning "Unknown OS. Please install dependencies manually."
            ;;
    esac
    
    print_success "Dependencies installed (or skipped if unavailable)"
}

# Create symlinks
create_symlinks() {
    print_step "Creating symlinks..."
    
    # Main dotfiles
    ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
    ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
    ln -sf "$DOTFILES_DIR/.bash_logout" ~/.bash_logout
    ln -sf "$DOTFILES_DIR/.profile" ~/.profile
    ln -sf "$DOTFILES_DIR/.inputrc" ~/.inputrc
    ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
    
    # Config directory
    mkdir -p ~/.config
    
    # Starship
    if [[ -f "$DOTFILES_DIR/config/starship.toml" ]]; then
        ln -sf "$DOTFILES_DIR/config/starship.toml" ~/.config/starship.toml
    fi
    
    # Git
    if [[ -f "$DOTFILES_DIR/git/.gitconfig" ]]; then
        ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
    fi
    
    if [[ -f "$DOTFILES_DIR/git/.gitignore_global" ]]; then
        ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
    fi
    
    # SSH
    if [[ -d ~/.ssh ]]; then
        if [[ -f "$DOTFILES_DIR/ssh/config.template" ]]; then
            cp -n "$DOTFILES_DIR/ssh/config.template" ~/.ssh/config 2>/dev/null || true
            chmod 600 ~/.ssh/config
        fi
    fi
    
    print_success "Symlinks created"
}

# Select mode
select_mode() {
    print_step "Select your dotfiles mode:"
    echo ""
    echo -e "  ${GREEN}1) Basic${NC}       - Essential aliases, minimal configuration"
    echo -e "  ${YELLOW}2) Advanced${NC}    - Full aliases, modern tools (default)"
    echo -e "  ${RED}3) Ultra-Nerd${NC}  - Everything + 1000+ aliases, all integrations"
    echo ""
    
    read -p "Enter your choice [1-3] (default: 2): " choice
    
    case "$choice" in
        1)
            mode="basic"
            ;;
        3)
            mode="ultra-nerd"
            ;;
        *)
            mode="advanced"
            ;;
    esac
    
    echo "export DOTFILES_MODE=\"$mode\"" > ~/.bashrc.local
    print_success "Mode set to: $mode"
}

# Main installation
main() {
    print_header
    
    check_prerequisites
    detect_os
    
    echo ""
    read -p "This will install dotfiles and backup existing configs. Continue? [Y/n]: " confirm
    [[ "$confirm" =~ ^[Nn]$ ]] && { print_error "Installation cancelled"; exit 0; }
    
    backup_existing
    clone_dotfiles
    install_dependencies
    create_symlinks
    select_mode
    
    echo ""
    print_success "Installation completed successfully!"
    echo ""
    print_info "Backup location: $BACKUP_DIR"
    print_info "Dotfiles location: $DOTFILES_DIR"
    echo ""
    print_step "To apply changes, run: ${BOLD}source ~/.bashrc${NC}"
    echo ""
    echo -e "${CYAN}Happy hacking!${NC}"
}

# Run main function
main "$@"
