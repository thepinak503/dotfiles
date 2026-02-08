#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER v3.0.0 - STRICT MODE
# One-command setup with double confirmation for safety
# =============================================================================

set -euo pipefail

# Version
VERSION="3.0.0"

# Strict mode - exit on any error
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
DOTFILES_REPO="https://github.com/thepinak503/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

# Flags
SELECTED_MODE=""
SELECTED_SHELLS=""
FORCE_MODE=false
SKIP_BACKUP=false
DRY_RUN=false
INSTALL_DEPS=false
SKIP_DEPS=false
CONFIRMED=false
INSTALL_PACKAGES=false

# Print functions
print_header() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DOTFILES INSTALLER v${VERSION}                       ║"
    echo "║    ⚠️  STRICT MODE - DOUBLE CONFIRMATION REQUIRED           ║"
    echo "║                                                            ║"
    echo "║    The Ultimate Universal Shell Configuration              ║"
    echo "║    Supports: Bash, Zsh, Fish, Nushell                      ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

print_warning_banner() {
    echo -e "${RED}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                    ⚠️  WARNING ⚠️                           ║"
    echo "║                                                            ║"
    echo "║  This installer will modify your shell configuration!      ║"
    echo "║                                                            ║"
    echo "║  It will:                                                  ║"
    echo "║  • Create backups of your existing configs                 ║"
    echo "║  • Replace .bashrc, .zshrc, .config/fish, etc.             ║"
    echo "║  • Install modern CLI tools (optional)                     ║"
    echo "║                                                            ║"
    echo "║  Your original configs will be backed up to:               ║"
    echo "║  ${BACKUP_DIR}"
    echo "║                                                            ║"
    echo "║  To restore later, run: ./uninstall.sh                     ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "${PURPLE}→${NC} $1"; }

# Double confirmation
double_confirm() {
    print_warning_banner
    
    echo -e "${YELLOW}${BOLD}FIRST CONFIRMATION:${NC}"
    read -p "Do you understand that this will modify your system? [yes/no]: " first_confirm
    
    if [[ "$first_confirm" != "yes" ]]; then
        echo ""
        print_error "Installation cancelled. You must type 'yes' to proceed."
        exit 1
    fi
    
    echo ""
    echo -e "${RED}${BOLD}SECOND CONFIRMATION:${NC}"
    echo -e "${RED}This is your last chance to cancel!${NC}"
    echo ""
    echo "Configuration that will be modified:"
    echo "  • ~/.bashrc"
    echo "  • ~/.bash_profile"
    echo "  • ~/.zshrc"
    echo "  • ~/.config/fish/"
    echo "  • ~/.config/nushell/"
    echo "  • ~/.gitconfig"
    echo "  • ~/.tmux.conf"
    echo "  • ~/.config/nvim/"
    echo "  • ~/.config/alacritty/"
    echo "  • ~/.config/kitty/"
    echo "  • ~/.config/starship.toml"
    echo "  • And more..."
    echo ""
    
    read -p "Type 'INSTALL' in ALL CAPS to proceed: " second_confirm
    
    if [[ "$second_confirm" != "INSTALL" ]]; then
        echo ""
        print_error "Installation cancelled. You must type 'INSTALL' in all caps to proceed."
        exit 1
    fi
    
    CONFIRMED=true
    echo ""
    print_success "Double confirmation received. Proceeding with installation..."
    echo ""
}

# Help message
show_help() {
    cat << EOF
${BOLD}Dotfiles Installer v${VERSION} - STRICT MODE${NC}

${BOLD}Usage:${NC} ./install.sh [OPTIONS]

${BOLD}Quick Start (Two-Step Process):${NC}
  ${GREEN}1. Install system packages:${NC}   ./install_dotfiles.sh --all
  ${GREEN}2. Configure dotfiles:${NC}       ./install.sh

${BOLD}Options:${NC}
  -h, --help              Show this help message
  -v, --version           Show version information
  -m, --mode MODE         Set configuration mode (basic|advanced|ultra-nerd)
  -s, --shells SHELLS     Specify shells comma-separated
  -f, --force             Force overwrite existing files
  -n, --no-backup         Skip backup step (NOT RECOMMENDED)
  -d, --dry-run           Show what would happen without changes
  -i, --install-deps      Install dependencies automatically
  --skip-deps             Skip dependency installation
  --install-packages      Install all packages via install_dotfiles.sh first
  -y, --yes               Skip confirmation (use with caution)

${BOLD}Examples:${NC}
  ./install.sh                          # Interactive mode with double confirmation
  ./install.sh --install-packages       # Install packages then configure
  ./install.sh -m advanced              # Advanced mode
  ./install.sh -s bash,zsh              # Bash + Zsh only
  ./install.sh -m ultra-nerd -i -y      # Auto-install with no confirm
  ./install.sh --dry-run                # Preview changes

${BOLD}Two-Step Installation:${NC}
  For a complete setup, run both scripts:
  ${PURPLE}./install_dotfiles.sh --all${NC}  # Installs all system packages
  ${PURPLE}./install.sh${NC}               # Configures dotfiles

${BOLD}Safety Features:${NC}
  • Double confirmation required by default
  • Automatic backup before any changes
  • Restore script included (./uninstall.sh)
  • Dry-run mode available

${BOLD}PowerShell Users:${NC}
  For Windows PowerShell, use PowerConfig:
  ${BLUE}https://github.com/thepinak503/powerconfig${NC}

EOF
}

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help) show_help; exit 0 ;;
            -v|--version) echo "Dotfiles Installer v${VERSION}"; exit 0 ;;
            -m|--mode) SELECTED_MODE="$2"; shift 2 ;;
            -s|--shells) SELECTED_SHELLS="${2//,/ }"; shift 2 ;;
            -f|--force) FORCE_MODE=true; shift ;;
            -n|--no-backup) SKIP_BACKUP=true; shift ;;
            -d|--dry-run) DRY_RUN=true; shift ;;
            -i|--install-deps) INSTALL_DEPS=true; shift ;;
            --skip-deps) SKIP_DEPS=true; shift ;;
            --install-packages) INSTALL_PACKAGES=true; shift ;;
            -y|--yes) CONFIRMED=true; shift ;;
            -*) print_error "Unknown option: $1"; show_help; exit 1 ;;
            *) print_error "Unknown argument: $1"; exit 1 ;;
        esac
    done
}

# Check prerequisites
check_prerequisites() {
    print_step "Checking prerequisites..."
    
    if ! command -v git &>/dev/null; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
        print_error "Neither curl nor wget is installed."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Detect OS
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

# Detect shells
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

# Select shells
select_shells() {
    if [[ -n "$SELECTED_SHELLS" ]]; then
        for shell in $SELECTED_SHELLS; do
            case "$shell" in
                bash|zsh|fish|nushell) ;;
                *) print_error "Unknown shell: $shell"; exit 1 ;;
            esac
        done
        print_success "Will configure: $SELECTED_SHELLS"
        return
    fi
    
    echo ""
    print_step "Select shells to configure:"
    echo ""
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

# Backup function
backup_existing() {
    if [[ "$SKIP_BACKUP" == true ]]; then
        print_warning "⚠️  Skipping backup (--no-backup specified)"
        print_warning "This is NOT recommended! You won't be able to restore easily."
        read -p "Are you sure you want to skip backup? [yes/no]: " skip_confirm
        if [[ "$skip_confirm" != "yes" ]]; then
            print_info "Proceeding with backup..."
        else
            return
        fi
    fi
    
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would backup to: $BACKUP_DIR"
        return
    fi
    
    print_step "Creating backup of existing configurations..."
    print_info "Backup location: $BACKUP_DIR"
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup shell configs
    [[ -f ~/.bashrc ]] && cp ~/.bashrc "$BACKUP_DIR/" && print_info "✓ Backed up ~/.bashrc"
    [[ -f ~/.bash_profile ]] && cp ~/.bash_profile "$BACKUP_DIR/" && print_info "✓ Backed up ~/.bash_profile"
    [[ -f ~/.bash_logout ]] && cp ~/.bash_logout "$BACKUP_DIR/" && print_info "✓ Backed up ~/.bash_logout"
    [[ -f ~/.profile ]] && cp ~/.profile "$BACKUP_DIR/" && print_info "✓ Backed up ~/.profile"
    [[ -f ~/.inputrc ]] && cp ~/.inputrc "$BACKUP_DIR/" && print_info "✓ Backed up ~/.inputrc"
    [[ -f ~/.zshrc ]] && cp ~/.zshrc "$BACKUP_DIR/" && print_info "✓ Backed up ~/.zshrc"
    [[ -f ~/.zshenv ]] && cp ~/.zshenv "$BACKUP_DIR/" && print_info "✓ Backed up ~/.zshenv"
    [[ -f ~/.zprofile ]] && cp ~/.zprofile "$BACKUP_DIR/" && print_info "✓ Backed up ~/.zprofile"
    
    # Backup directories
    [[ -d ~/.config/fish ]] && cp -r ~/.config/fish "$BACKUP_DIR/" && print_info "✓ Backed up Fish config"
    [[ -d ~/.config/nushell ]] && cp -r ~/.config/nushell "$BACKUP_DIR/" && print_info "✓ Backed up Nushell config"
    [[ -d ~/.config/nvim ]] && cp -r ~/.config/nvim "$BACKUP_DIR/" && print_info "✓ Backed up Neovim config"
    [[ -d ~/.tmux ]] && cp -r ~/.tmux "$BACKUP_DIR/" && print_info "✓ Backed up Tmux config"
    
    # Backup files
    [[ -f ~/.tmux.conf ]] && cp ~/.tmux.conf "$BACKUP_DIR/" && print_info "✓ Backed up ~/.tmux.conf"
    [[ -f ~/.vimrc ]] && cp ~/.vimrc "$BACKUP_DIR/" && print_info "✓ Backed up ~/.vimrc"
    [[ -f ~/.gitconfig ]] && cp ~/.gitconfig "$BACKUP_DIR/" && print_info "✓ Backed up ~/.gitconfig"
    [[ -f ~/.gitignore_global ]] && cp ~/.gitignore_global "$BACKUP_DIR/" && print_info "✓ Backed up ~/.gitignore_global"
    
    print_success "Backup completed successfully!"
    print_info "To restore: ./uninstall.sh or cp -r $BACKUP_DIR/* ~/"
}

# Clone dotfiles
clone_dotfiles() {
    print_step "Setting up dotfiles..."
    
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
            print_warning "Force mode: Removing existing dotfiles..."
            rm -rf "$DOTFILES_DIR"
            git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
        else
            print_info "Dotfiles directory exists. Updating..."
            cd "$DOTFILES_DIR"
            git pull origin main
        fi
    else
        git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
    
    print_success "Dotfiles ready at: $DOTFILES_DIR"
}

# Install dependencies
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
        echo ""
        read -p "Install modern CLI tools (fzf, eza, bat, starship, etc.)? [Y/n]: " install_deps
        [[ "$install_deps" =~ ^[Nn]$ ]] && return
    fi
    
    print_step "Installing dependencies..."
    print_info "This may take a few minutes..."
    
    case "$OS" in
        arch|manjaro|endeavouros)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux kitty alacritty"
            print_info "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some packages failed"
            
            # Install yay if not present
            if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
                print_info "Installing yay (AUR helper)..."
                git clone https://aur.archlinux.org/yay.git /tmp/yay
                cd /tmp/yay && makepkg -si --noconfirm
            fi
            
            # Install AUR packages
            if command -v yay &>/dev/null || command -v paru &>/dev/null; then
                local aur_helper=$(command -v yay || command -v paru)
                $aur_helper -S --needed --noconfirm dust procs sd micro 2>/dev/null || print_warning "Some AUR packages failed"
            fi
            ;;
            
        debian|ubuntu|pop|linuxmint)
            packages="git curl wget fzf zoxide bat ripgrep fd-find tmux"
            print_info "Installing packages with apt..."
            sudo apt-get update
            sudo apt-get install -y $packages 2>/dev/null || print_warning "Some packages failed"
            
            # Install starship
            if ! command -v starship &>/dev/null; then
                curl -sS https://starship.rs/install.sh | sh -s -- -y
            fi
            
            # Install eza
            if ! command -v eza &>/dev/null; then
                sudo apt install -y gpg
                sudo mkdir -p /etc/apt/keyrings
                wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
                echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
                sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
                sudo apt update
                sudo apt install -y eza
            fi
            ;;
            
        fedora|rhel|centos)
            packages="git curl wget fzf zoxide eza bat ripgrep fd-find starship fastfetch tmux"
            print_info "Installing packages with dnf..."
            sudo dnf install -y $packages 2>/dev/null || print_warning "Some packages failed"
            ;;
            
        opensuse*)
            packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux"
            print_info "Installing packages with zypper..."
            sudo zypper install -y $packages 2>/dev/null || print_warning "Some packages failed"
            ;;
            
        macos)
            if command -v brew &>/dev/null; then
                packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux micro"
                brew install $packages 2>/dev/null || print_warning "Some packages failed"
            else
                print_error "Homebrew not found. Install from: https://brew.sh"
            fi
            ;;
    esac
    
    # Install micro if not present
    if ! command -v micro &>/dev/null; then
        print_info "Installing micro editor..."
        curl https://getmic.ro | bash
        sudo mv micro /usr/local/bin/ 2>/dev/null || mv micro ~/.local/bin/
    fi
    
    print_success "Dependencies installed!"
}

# Check for missing modern tools and suggest install_dotfiles.sh
check_missing_tools() {
    local missing_tools=()
    
    command -v fzf &>/dev/null || missing_tools+=("fzf")
    command -v eza &>/dev/null || missing_tools+=("eza")
    command -v bat &>/dev/null || missing_tools+=("bat")
    command -v zoxide &>/dev/null || missing_tools+=("zoxide")
    command -v starship &>/dev/null || missing_tools+=("starship")
    command -v ripgrep &>/dev/null || missing_tools+=("ripgrep")
    command -v fd &>/dev/null || missing_tools+=("fd")
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo ""
        print_warning "Some modern tools are not installed: ${missing_tools[*]}"
        print_info "For the best experience, run: ./install_dotfiles.sh --all"
        print_info "This will install all packages for all shells."
        echo ""
        read -p "Would you like to run install_dotfiles.sh now? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [ -f "$DOTFILES_DIR/install_dotfiles.sh" ]; then
                "$DOTFILES_DIR/install_dotfiles.sh"
            elif [ -f "./install_dotfiles.sh" ]; then
                ./install_dotfiles.sh
            else
                print_error "install_dotfiles.sh not found!"
                print_info "Download it from: https://github.com/thepinak503/dotfiles"
            fi
        fi
    fi
}

# Run install_dotfiles.sh if --install-packages flag is set
run_install_packages() {
    if [[ "$INSTALL_PACKAGES" == true ]]; then
        print_step "Running install_dotfiles.sh to install all packages..."
        
        if [ -f "$DOTFILES_DIR/install_dotfiles.sh" ]; then
            "$DOTFILES_DIR/install_dotfiles.sh" --yes
        elif [ -f "./install_dotfiles.sh" ]; then
            ./install_dotfiles.sh --yes
        else
            print_error "install_dotfiles.sh not found!"
            print_info "Please ensure install_dotfiles.sh is in the same directory."
            print_info "Download it from: https://github.com/thepinak503/dotfiles"
            exit 1
        fi
        
        print_success "Package installation complete!"
        echo ""
    fi
}

# Create symlinks
create_symlinks() {
    print_step "Creating symbolic links..."
    
    if [[ "$DRY_RUN" == true ]]; then
        print_info "[DRY RUN] Would create symlinks"
        return
    fi
    
    mkdir -p ~/.config
    
    # Bash
    if [[ "$SELECTED_SHELLS" == *"bash"* ]]; then
        ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
        ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
        ln -sf "$DOTFILES_DIR/.bash_logout" ~/.bash_logout
        ln -sf "$DOTFILES_DIR/.profile" ~/.profile
        ln -sf "$DOTFILES_DIR/.inputrc" ~/.inputrc
        print_info "✓ Bash configuration linked"
    fi
    
    # Zsh
    if [[ "$SELECTED_SHELLS" == *"zsh"* ]]; then
        ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
        print_info "✓ Zsh configuration linked"
    fi
    
    # Fish
    if [[ "$SELECTED_SHELLS" == *"fish"* ]]; then
        mkdir -p ~/.config/fish/{conf.d,functions,completions}
        ln -sf "$DOTFILES_DIR/fish/config.fish" ~/.config/fish/config.fish
        for file in "$DOTFILES_DIR"/fish/conf.d/*.fish; do
            [[ -f "$file" ]] && ln -sf "$file" ~/.config/fish/conf.d/
        done
        for file in "$DOTFILES_DIR"/fish/functions/*.fish; do
            [[ -f "$file" ]] && ln -sf "$file" ~/.config/fish/functions/
        done
        print_info "✓ Fish configuration linked"
    fi
    
    # Nushell
    if [[ "$SELECTED_SHELLS" == *"nushell"* ]]; then
        mkdir -p ~/.config/nushell
        ln -sf "$DOTFILES_DIR/nushell/config.nu" ~/.config/nushell/config.nu
        ln -sf "$DOTFILES_DIR/nushell/env.nu" ~/.config/nushell/env.nu
        print_info "✓ Nushell configuration linked"
    fi
    
    # Terminal emulators
    mkdir -p ~/.config/alacritty
    ln -sf "$DOTFILES_DIR/config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
    print_info "✓ Alacritty configuration linked"
    
    mkdir -p ~/.config/kitty
    ln -sf "$DOTFILES_DIR/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
    print_info "✓ Kitty configuration linked"
    
    mkdir -p ~/.config/wezterm
    ln -sf "$DOTFILES_DIR/config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
    print_info "✓ WezTerm configuration linked"
    
    mkdir -p ~/.config/zellij
    ln -sf "$DOTFILES_DIR/config/zellij/config.kdl" ~/.config/zellij/config.kdl
    print_info "✓ Zellij configuration linked"
    
    # Tmux
    ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
    print_info "✓ Tmux configuration linked"
    
    # Screen
    ln -sf "$DOTFILES_DIR/.screenrc" ~/.screenrc
    print_info "✓ Screen configuration linked"
    
    # Editors
    ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
    ln -sf "$DOTFILES_DIR/.nanorc" ~/.nanorc
    print_info "✓ Vim and Nano configurations linked"
    
    mkdir -p ~/.config/micro
    ln -sf "$DOTFILES_DIR/config/micro/settings.json" ~/.config/micro/settings.json
    print_info "✓ Micro configuration linked"
    
    # Neovim
    mkdir -p ~/.config/nvim
    ln -sf "$DOTFILES_DIR/config/nvim/init.lua" ~/.config/nvim/init.lua
    ln -sf "$DOTFILES_DIR/config/nvim/lua" ~/.config/nvim/lua
    print_info "✓ Neovim configuration linked"
    
    # VS Code:
    mkdir -p ~/.config/Code/User
    ln -sf "$DOTFILES_DIR/config/Code/settings.json" ~/.config/Code/User/settings.json
    print_info "✓ VS Code: settings linked"
    
    # Modern tools
    mkdir -p ~/.config/fastfetch
    ln -sf "$DOTFILES_DIR/config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
    
    mkdir -p ~/.config
    ln -sf "$DOTFILES_DIR/config/starship.toml" ~/.config/starship.toml
    print_info "✓ Starship configuration linked"
    
    # Git
    ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
    ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
    print_info "✓ Git configuration linked"
    
    # SSH
    if [[ -d ~/.ssh ]]; then
        cp -n "$DOTFILES_DIR/ssh/config.template" ~/.ssh/config 2>/dev/null || true
        chmod 600 ~/.ssh/config 2>/dev/null || true
        print_info "✓ SSH config template copied"
    fi
    
    print_success "All configurations linked successfully!"
}

# Select mode
select_mode() {
    if [[ -n "$SELECTED_MODE" ]]; then
        case "$SELECTED_MODE" in
            basic|advanced|ultra-nerd)
                print_success "Mode: $SELECTED_MODE"
                ;;
            *)
                print_error "Invalid mode: $SELECTED_MODE"
                exit 1
                ;;
        esac
    else
        echo ""
        print_step "Select your dotfiles mode:"
        echo ""
        echo -e "  ${GREEN}1) Basic${NC}       - Essential only (~200 aliases)"
        echo -e "  ${YELLOW}2) Advanced${NC}    - Full features (~600 aliases) [RECOMMENDED]"
        echo -e "  ${RED}3) Ultra-Nerd${NC}  - Everything (~1000+ aliases)"
        echo ""
        read -p "Enter choice [1-3] (default: 2): " choice
        
        case "$choice" in
            1) SELECTED_MODE="basic" ;;
            3) SELECTED_MODE="ultra-nerd" ;;
            *) SELECTED_MODE="advanced" ;;
        esac
        
        print_success "Mode set to: $SELECTED_MODE"
    fi
    
    # Create local config files
    echo "export DOTFILES_MODE=\"$SELECTED_MODE\"" > ~/.bashrc.local
    echo "set -gx DOTFILES_MODE \"$SELECTED_MODE\"" > ~/.config/fish/config.local.fish 2>/dev/null || true
}

# Post-install message
print_post_install() {
    echo ""
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════╗"
    echo "║           INSTALLATION COMPLETE! 🎉                        ║"
    echo "╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    print_success "Dotfiles v${VERSION} installed successfully!"
    echo ""
    print_info "Backup location: ${BACKUP_DIR}"
    print_info "Dotfiles location: ${DOTFILES_DIR}"
    echo ""
    echo "To apply changes, run:"
    [[ "$SELECTED_SHELLS" == *"bash"* ]] && echo -e "  ${BOLD}source ~/.bashrc${NC}"
    [[ "$SELECTED_SHELLS" == *"zsh"* ]] && echo -e "  ${BOLD}source ~/.zshrc${NC}"
    [[ "$SELECTED_SHELLS" == *"fish"* ]] && echo -e "  ${BOLD}source ~/.config/fish/config.fish${NC}"
    echo ""
    echo "Or simply restart your terminal."
    echo ""
    print_info "To restore original configs: ./uninstall.sh"
    print_info "To update dotfiles: cd ~/.dotfiles && git pull"
    echo ""
    echo -e "${CYAN}Happy hacking! 🚀${NC}"
    echo ""
}

# Main
main() {
    parse_args "$@"
    
    # Run package installer if requested
    run_install_packages
    
    # Skip confirmation only with -y flag
    if [[ "$CONFIRMED" != true ]]; then
        print_header
        double_confirm
    else
        print_header
        print_warning "Running with --yes flag (skipped confirmation)"
    fi
    
    check_prerequisites
    detect_os
    detect_shells
    
    if [[ -z "$SELECTED_SHELLS" ]]; then
        select_shells
    fi
    
    if [[ -z "$SELECTED_SHELLS" ]]; then
        print_error "No shells selected. Exiting."
        exit 1
    fi
    
    # Final summary before execution
    echo ""
    print_step "Installation Summary:"
    echo "  Shells: $SELECTED_SHELLS"
    echo "  Mode: ${SELECTED_MODE:-interactive}"
    echo "  OS: $OS_NAME"
    echo "  Backup: $([[ "$SKIP_BACKUP" == true ]] && echo "No" || echo "Yes")"
    echo "  Dependencies: $([[ "$SKIP_DEPS" == true ]] && echo "No" || echo "Yes")"
    echo "  Dry Run: $([[ "$DRY_RUN" == true ]] && echo "Yes" || echo "No")"
    echo ""
    
    if [[ "$DRY_RUN" != true ]]; then
        read -p "Proceed with installation? [yes/no]: " final_confirm
        if [[ "$final_confirm" != "yes" ]]; then
            print_error "Installation cancelled."
            exit 1
        fi
    fi
    
    # Execute installation
    backup_existing
    clone_dotfiles
    install_dependencies
    create_symlinks
    select_mode
    
    if [[ "$DRY_RUN" == true ]]; then
        echo ""
        print_info "DRY RUN completed. No changes were made."
        exit 0
    fi
    
    # Check for missing tools and offer to install them
    check_missing_tools
    
    print_post_install
}

main "$@"