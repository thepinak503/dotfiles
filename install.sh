#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER v2.2.0
# One-command setup for the ultimate dotfiles configuration
# Supports: Bash, Zsh, Fish, Nushell
# PowerShell users: See https://github.com/thepinak503/powerconfig
# 
# Usage: ./install.sh [OPTIONS]
# 
# Options:
#   -h, --help              Show this help message
#   -v, --version           Show version information
#   -m, --mode MODE         Set configuration mode (basic|advanced|ultra-nerd)
#   -s, --shells SHELLS     Specify shells (bash,zsh,fish,nushell)
#   -f, --force             Force overwrite existing files
#   -n, --no-backup         Skip backup step
#   -d, --dry-run           Show what would happen without making changes
#   -i, --install-deps      Install dependencies automatically
#   --skip-deps             Skip dependency installation
# =============================================================================

set -e

# Version
VERSION="2.2.0"

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

# Default values
SELECTED_MODE=""
SELECTED_SHELLS=""
FORCE_MODE=false
SKIP_BACKUP=false
DRY_RUN=false
INSTALL_DEPS=false
SKIP_DEPS=false

# Print functions
print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DOTFILES INSTALLER v${VERSION}                       ║"
    echo "║    The Ultimate Universal Shell Configuration              ║"
    echo "║    Supports: Bash, Zsh, Fish, Nushell                      ║"
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

# Help message
show_help() {
    cat << EOF
${BOLD}Dotfiles Installer v${VERSION}${NC}

${BOLD}Usage:${NC} ./install.sh [OPTIONS]

${BOLD}Options:${NC}
  -h, --help              Show this help message
  -v, --version           Show version information
  -m, --mode MODE         Set configuration mode
                          (basic|advanced|ultra-nerd)
  -s, --shells SHELLS     Specify shells comma-separated
                          (bash,zsh,fish,nushell)
  -f, --force             Force overwrite existing files
  -n, --no-backup         Skip backup step
  -d, --dry-run           Show what would happen without changes
  -i, --install-deps      Install dependencies automatically
  --skip-deps             Skip dependency installation

${BOLD}Examples:${NC}
  ./install.sh                          # Interactive mode
  ./install.sh -m advanced              # Advanced mode
  ./install.sh -s bash,zsh              # Bash + Zsh only
  ./install.sh -m ultra-nerd -i         # Ultra-nerd with deps
  ./install.sh --dry-run                # Preview changes
  ./install.sh -f --no-backup           # Force, no backup

${BOLD}PowerShell Users:${NC}
  For Windows PowerShell, use PowerConfig:
  ${BLUE}https://github.com/thepinak503/powerconfig${NC}

EOF
}

# Version info
show_version() {
    echo "Dotfiles Installer v${VERSION}"
    echo "Repository: ${DOTFILES_REPO}"
    echo "License: MIT"
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--version)
                show_version
                exit 0
                ;;
            -m|--mode)
                SELECTED_MODE="$2"
                shift 2
                ;;
            -s|--shells)
                SELECTED_SHELLS="${2//,/ }"
                shift 2
                ;;
            -f|--force)
                FORCE_MODE=true
                shift
                ;;
            -n|--no-backup)
                SKIP_BACKUP=true
                shift
                ;;
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -i|--install-deps)
                INSTALL_DEPS=true
                shift
                ;;
            --skip-deps)
                SKIP_DEPS=true
                shift
                ;;
            -*)
                print_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
            *)
                print_error "Unknown argument: $1"
                exit 1
                ;;
        esac
    done
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

# Detect installed shells
detect_shells() {
    print_step "Detecting installed shells..."
    
    DETECTED_SHELLS=""
    
    if command -v bash &>/dev/null; then
        DETECTED_SHELLS+="bash "
        print_info "✓ Bash detected"
    fi
    
    if command -v zsh &>/dev/null; then
        DETECTED_SHELLS+="zsh "
        print_info "✓ Zsh detected"
    fi
    
    if command -v fish &>/dev/null; then
        DETECTED_SHELLS+="fish "
        print_info "✓ Fish detected"
    fi
    
    if command -v nu &>/dev/null; then
        DETECTED_SHELLS+="nushell "
        print_info "✓ Nushell detected"
    fi
    
    print_success "Detected shells: $DETECTED_SHELLS"
}

# Select shells to configure
select_shells() {
    # If shells specified via command line, use those
    if [[ -n "$SELECTED_SHELLS" ]]; then
        # Validate shells
        for shell in $SELECTED_SHELLS; do
            case "$shell" in
                bash|zsh|fish|nushell)
                    ;;
                *)
                    print_error "Unknown shell: $shell"
                    exit 1
                    ;;
            esac
        done
        print_success "Will configure: $SELECTED_SHELLS"
        return
    fi
    
    echo ""
    print_step "Select shells to configure:"
    echo ""
    
    echo "Which shells would you like to configure?"
    echo "  1) All detected shells"
    echo "  2) Bash only"
    echo "  3) Zsh only"
    echo "  4) Fish only"
    echo "  5) Bash + Zsh"
    echo "  6) Bash + Fish"
    echo "  7) Zsh + Fish"
    echo "  8) Skip shell configuration"
    echo ""
    
    read -p "Enter your choice [1-8] (default: 1): " choice
    
    case "$choice" in
        2) SELECTED_SHELLS="bash" ;;
        3) SELECTED_SHELLS="zsh" ;;
        4) SELECTED_SHELLS="fish" ;;
        5) SELECTED_SHELLS="bash zsh" ;;
        6) SELECTED_SHELLS="bash fish" ;;
        7) SELECTED_SHELLS="zsh fish" ;;
        8) SELECTED_SHELLS="" ;;
        *) SELECTED_SHELLS="$DETECTED_SHELLS" ;;
    esac
    
    if [[ -n "$SELECTED_SHELLS" ]]; then
        print_success "Will configure: $SELECTED_SHELLS"
    else
        print_warning "Skipping shell configuration"
    fi
}

# Backup existing dotfiles
backup_existing() {
    if [[ "$SKIP_BACKUP" == true ]]; then
        print_warning "Skipping backup (--no-backup specified)"
        return
    fi
    
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would backup to: $BACKUP_DIR"
        return
    fi
    
    print_step "Backing up existing dotfiles..."
    
    mkdir -p "$BACKUP_DIR"
    
    [[ -f ~/.bashrc ]] && cp ~/.bashrc "$BACKUP_DIR/" && print_info "Backed up ~/.bashrc"
    [[ -f ~/.bash_profile ]] && cp ~/.bash_profile "$BACKUP_DIR/" && print_info "Backed up ~/.bash_profile"
    [[ -f ~/.bash_logout ]] && cp ~/.bash_logout "$BACKUP_DIR/" && print_info "Backed up ~/.bash_logout"
    [[ -f ~/.profile ]] && cp ~/.profile "$BACKUP_DIR/" && print_info "Backed up ~/.profile"
    [[ -f ~/.inputrc ]] && cp ~/.inputrc "$BACKUP_DIR/" && print_info "Backed up ~/.inputrc"
    [[ -f ~/.zshrc ]] && cp ~/.zshrc "$BACKUP_DIR/" && print_info "Backed up ~/.zshrc"
    [[ -f ~/.zshenv ]] && cp ~/.zshenv "$BACKUP_DIR/" && print_info "Backed up ~/.zshenv"
    [[ -f ~/.zprofile ]] && cp ~/.zprofile "$BACKUP_DIR/" && print_info "Backed up ~/.zprofile"
    
    if [[ -d ~/.config/fish ]]; then
        cp -r ~/.config/fish "$BACKUP_DIR/" && print_info "Backed up Fish config"
    fi
    
    if [[ -d ~/.config/nushell ]]; then
        cp -r ~/.config/nushell "$BACKUP_DIR/" && print_info "Backed up Nushell config"
    fi
    
    [[ -f ~/.gitconfig ]] && cp ~/.gitconfig "$BACKUP_DIR/" && print_info "Backed up ~/.gitconfig"
    [[ -f ~/.gitignore_global ]] && cp ~/.gitignore_global "$BACKUP_DIR/" && print_info "Backed up ~/.gitignore_global"
    
    print_success "Backup completed in $BACKUP_DIR"
}

# Clone or update dotfiles
clone_dotfiles() {
    print_step "Cloning dotfiles repository..."
    
    if [[ "$DRY_RUN" == true ]]; then
        if [[ -d "$DOTFILES_DIR" ]]; then
            print_info "[DRY RUN] Would update existing dotfiles"
        else
            print_info "[DRY RUN] Would clone to: $DOTFILES_DIR"
        fi
        return
    fi
    
    if [[ -d "$DOTFILES_DIR" ]]; then
        if [[ "$FORCE_MODE" == true ]]; then
            print_warning "Force mode: Removing existing dotfiles"
            rm -rf "$DOTFILES_DIR"
            git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
        else
            print_warning "Dotfiles directory already exists. Updating..."
            cd "$DOTFILES_DIR"
            git pull origin main
        fi
    else
        git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
    
    print_success "Dotfiles cloned/updated"
}

# Install dependencies based on OS
install_dependencies() {
    if [[ "$SKIP_DEPS" == true ]]; then
        print_warning "Skipping dependencies (--skip-deps specified)"
        return
    fi
    
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would install dependencies for: $OS"
        return
    fi
    
    if [[ "$INSTALL_DEPS" == false ]]; then
        read -p "Install modern CLI tools (fzf, eza, bat, etc.)? [Y/n]: " install_deps
        [[ "$install_deps" =~ ^[Nn]$ ]] && return
    fi
    
    print_step "Installing dependencies..."
    
    case "$OS" in
        arch|manjaro|endeavouros)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch"
            print_info "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            
            if ! command -v fish &>/dev/null; then
                read -p "Install Fish shell? [Y/n]: " install_fish
                if [[ ! "$install_fish" =~ ^[Nn]$ ]]; then
                    sudo pacman -S --needed --noconfirm fish
                fi
            fi
            
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
            
            if ! command -v fish &>/dev/null; then
                read -p "Install Fish shell? [Y/n]: " install_fish
                if [[ ! "$install_fish" =~ ^[Nn]$ ]]; then
                    sudo apt-get install -y fish
                fi
            fi
            
            if ! command -v starship &>/dev/null; then
                curl -sS https://starship.rs/install.sh | sh
            fi
            ;;
            
        fedora|rhel|centos)
            packages="git curl wget fzf zoxide eza bat ripgrep fd-find starship fastfetch"
            print_info "Installing packages with dnf..."
            sudo dnf install -y $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            
            if ! command -v fish &>/dev/null; then
                read -p "Install Fish shell? [Y/n]: " install_fish
                if [[ ! "$install_fish" =~ ^[Nn]$ ]]; then
                    sudo dnf install -y fish
                fi
            fi
            ;;
            
        opensuse*)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch"
            print_info "Installing packages with zypper..."
            sudo zypper install -y $packages 2>/dev/null || print_warning "Some packages may need manual installation"
            
            if ! command -v fish &>/dev/null; then
                read -p "Install Fish shell? [Y/n]: " install_fish
                if [[ ! "$install_fish" =~ ^[Nn]$ ]]; then
                    sudo zypper install -y fish
                fi
            fi
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
                
                if ! command -v fish &>/dev/null; then
                    read -p "Install Fish shell? [Y/n]: " install_fish
                    if [[ ! "$install_fish" =~ ^[Nn]$ ]]; then
                        brew install fish
                    fi
                fi
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

# Create symlinks for selected shells
create_symlinks() {
    print_step "Creating symlinks..."
    
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would create symlinks for: $SELECTED_SHELLS"
        return
    fi
    
    mkdir -p ~/.config
    
    # Bash configuration
    if [[ "$SELECTED_SHELLS" == *"bash"* ]]; then
        ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
        ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
        ln -sf "$DOTFILES_DIR/.bash_logout" ~/.bash_logout
        ln -sf "$DOTFILES_DIR/.profile" ~/.profile
        ln -sf "$DOTFILES_DIR/.inputrc" ~/.inputrc
        print_info "Bash configuration linked"
    fi
    
    # Zsh configuration
    if [[ "$SELECTED_SHELLS" == *"zsh"* ]]; then
        ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
        print_info "Zsh configuration linked"
    fi
    
    # Fish configuration
    if [[ "$SELECTED_SHELLS" == *"fish"* ]]; then
        mkdir -p ~/.config/fish
        mkdir -p ~/.config/fish/conf.d
        mkdir -p ~/.config/fish/functions
        mkdir -p ~/.config/fish/completions
        
        ln -sf "$DOTFILES_DIR/fish/config.fish" ~/.config/fish/config.fish
        
        for file in "$DOTFILES_DIR"/fish/conf.d/*.fish; do
            if [[ -f "$file" ]]; then
                ln -sf "$file" ~/.config/fish/conf.d/
            fi
        done
        
        for file in "$DOTFILES_DIR"/fish/functions/*.fish; do
            if [[ -f "$file" ]]; then
                ln -sf "$file" ~/.config/fish/functions/
            fi
        done
        
        print_info "Fish configuration linked"
    fi
    
    # Nushell configuration
    if [[ "$SELECTED_SHELLS" == *"nushell"* ]]; then
        mkdir -p ~/.config/nushell
        ln -sf "$DOTFILES_DIR/nushell/config.nu" ~/.config/nushell/config.nu
        ln -sf "$DOTFILES_DIR/nushell/env.nu" ~/.config/nushell/env.nu
        print_info "Nushell configuration linked"
    fi
    
    # Starship
    if [[ -f "$DOTFILES_DIR/config/starship.toml" ]]; then
        mkdir -p ~/.config
        ln -sf "$DOTFILES_DIR/config/starship.toml" ~/.config/starship.toml
        print_info "Starship configuration linked"
    fi
    
    # Fastfetch
    if [[ -f "$DOTFILES_DIR/config/fastfetch/config.jsonc" ]]; then
        mkdir -p ~/.config/fastfetch
        ln -sf "$DOTFILES_DIR/config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
        print_info "Fastfetch configuration linked"
    fi
    
    # Git
    if [[ -f "$DOTFILES_DIR/git/.gitconfig" ]]; then
        ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
        print_info "Git configuration linked"
    fi
    
    if [[ -f "$DOTFILES_DIR/git/.gitignore_global" ]]; then
        ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
        print_info "Git ignore linked"
    fi
    
    # SSH
    if [[ -d ~/.ssh ]]; then
        if [[ -f "$DOTFILES_DIR/ssh/config.template" ]]; then
            cp -n "$DOTFILES_DIR/ssh/config.template" ~/.ssh/config 2>/dev/null || true
            chmod 600 ~/.ssh/config 2>/dev/null || true
            print_info "SSH config template copied"
        fi
    fi
    
    print_success "Symlinks created"
}

# Select mode
select_mode() {
    # If mode specified via command line, use that
    if [[ -n "$SELECTED_MODE" ]]; then
        case "$SELECTED_MODE" in
            basic|advanced|ultra-nerd)
                print_success "Mode set to: $SELECTED_MODE"
                return
                ;;
            *)
                print_error "Invalid mode: $SELECTED_MODE"
                print_info "Valid modes: basic, advanced, ultra-nerd"
                exit 1
                ;;
        esac
    fi
    
    print_step "Select your dotfiles mode:"
    echo ""
    echo -e "  ${GREEN}1) Basic${NC}       - Essential aliases, minimal configuration"
    echo -e "  ${YELLOW}2) Advanced${NC}    - Full aliases, modern tools (default)"
    echo -e "  ${RED}3) Ultra-Nerd${NC}  - Everything + 1000+ aliases, all integrations"
    echo ""
    
    read -p "Enter your choice [1-3] (default: 2): " choice
    
    case "$choice" in
        1) mode="basic" ;;
        3) mode="ultra-nerd" ;;
        *) mode="advanced" ;;
    esac
    
    SELECTED_MODE="$mode"
    
    echo "export DOTFILES_MODE=\"$mode\"" > ~/.bashrc.local
    echo "set -gx DOTFILES_MODE \"$mode\"" > ~/.config/fish/config.local.fish 2>/dev/null || true
    
    print_success "Mode set to: $mode"
}

# Change default shell
change_default_shell() {
    if [[ -z "$SELECTED_SHELLS" ]]; then
        return
    fi
    
    if [[ "$DRY_RUN" == true ]]; then
        return
    fi
    
    echo ""
    print_step "Change default shell?"
    echo "Current shell: $SHELL"
    echo ""
    
    if [[ "$SELECTED_SHELLS" == *"fish"* ]]; then
        read -p "Set Fish as default shell? [y/N]: " change_shell
        if [[ "$change_shell" =~ ^[Yy]$ ]]; then
            if command -v fish &>/dev/null; then
                local fish_path=$(command -v fish)
                if ! grep -q "$fish_path" /etc/shells; then
                    echo "$fish_path" | sudo tee -a /etc/shells
                fi
                chsh -s "$fish_path"
                print_success "Default shell changed to Fish"
                print_info "Please log out and log back in for changes to take effect"
            fi
        fi
    elif [[ "$SELECTED_SHELLS" == *"zsh"* ]]; then
        read -p "Set Zsh as default shell? [y/N]: " change_shell
        if [[ "$change_shell" =~ ^[Yy]$ ]]; then
            if command -v zsh &>/dev/null; then
                chsh -s $(command -v zsh)
                print_success "Default shell changed to Zsh"
                print_info "Please log out and log back in for changes to take effect"
            fi
        fi
    fi
}

# Print dry run summary
print_dry_run_summary() {
    echo ""
    print_info "${BOLD}DRY RUN SUMMARY${NC}"
    echo "  Mode: ${SELECTED_MODE:-interactive}"
    echo "  Shells: ${SELECTED_SHELLS:-detected automatically}"
    echo "  Backup: $([[ "$SKIP_BACKUP" == true ]] && echo "No" || echo "Yes")"
    echo "  Force: $([[ "$FORCE_MODE" == true ]] && echo "Yes" || echo "No")"
    echo "  Dependencies: $([[ "$SKIP_DEPS" == true ]] && echo "Skip" || echo "Install")"
    echo ""
    print_info "Run without --dry-run to apply changes"
}

# Main installation
main() {
    # Parse command line arguments
    parse_args "$@"
    
    print_header
    
    check_prerequisites
    detect_os
    
    if [[ -z "$SELECTED_SHELLS" ]]; then
        detect_shells
        select_shells
    fi
    
    if [[ -z "$SELECTED_SHELLS" ]]; then
        print_warning "No shells selected. Exiting."
        exit 0
    fi
    
    if [[ "$DRY_RUN" == false ]]; then
        echo ""
        read -p "This will install dotfiles and backup existing configs. Continue? [Y/n]: " confirm
        [[ "$confirm" =~ ^[Nn]$ ]] && { print_error "Installation cancelled"; exit 0; }
    fi
    
    backup_existing
    clone_dotfiles
    install_dependencies
    create_symlinks
    select_mode
    change_default_shell
    
    if [[ "$DRY_RUN" == true ]]; then
        print_dry_run_summary
        exit 0
    fi
    
    echo ""
    print_success "Installation completed successfully!"
    echo ""
    print_info "Backup location: $BACKUP_DIR"
    print_info "Dotfiles location: $DOTFILES_DIR"
    echo ""
    
    print_step "To apply changes, run:"
    if [[ "$SELECTED_SHELLS" == *"bash"* ]]; then
        echo "  Bash:    ${BOLD}source ~/.bashrc${NC}"
    fi
    if [[ "$SELECTED_SHELLS" == *"zsh"* ]]; then
        echo "  Zsh:     ${BOLD}source ~/.zshrc${NC}"
    fi
    if [[ "$SELECTED_SHELLS" == *"fish"* ]]; then
        echo "  Fish:    ${BOLD}source ~/.config/fish/config.fish${NC}"
    fi
    if [[ "$SELECTED_SHELLS" == *"nushell"* ]]; then
        echo "  Nushell: ${BOLD}Restart your terminal${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}Happy hacking!${NC}"
}

# Run main function
main "$@"
