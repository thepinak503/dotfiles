#!/bin/bash
# =============================================================================
# DOTFILES INSTALLER v5.0.0 - FULLY AUTOMATIC
# Zero-interaction installation with intelligent defaults
# =============================================================================

set -euo pipefail

# Version
VERSION="5.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
FORCE_MODE=false
VERBOSE=false

# Print functions
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "${PURPLE}→${NC} $1"; }

# Verbose logging
log() {
    [[ "$VERBOSE" == true ]] && echo -e "${CYAN}[LOG]${NC} $1"
}

# Detect OS
auto_detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            arch|manjaro|endeavouros) echo "arch" ;;
            debian|ubuntu|pop|linuxmint) echo "debian" ;;
            fedora|rhel|centos|amzn) echo "fedora" ;;
            opensuse*|suse*) echo "opensuse" ;;
            *) echo "$ID" ;;
        esac
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Detect available shells
auto_detect_shells() {
    local shells=""
    command -v bash &>/dev/null && shells+="bash "
    command -v zsh &>/dev/null && shells+="zsh "
    command -v fish &>/dev/null && shells+="fish "
    command -v nu &>/dev/null && shells+="nushell "
    echo "$shells"
}

# Auto-detect installation method
auto_select_method() {
    local tool_count=0
    command -v fzf &>/dev/null && ((tool_count++))
    command -v eza &>/dev/null && ((tool_count++))
    command -v bat &>/dev/null && ((tool_count++))
    command -v zoxide &>/dev/null && ((tool_count++))
    command -v starship &>/dev/null && ((tool_count++))
    
    if [[ $tool_count -lt 3 ]]; then
        echo "dynamic"
    else
        echo "traditional"
    fi
}

# Auto-select mode based on system
auto_select_mode() {
    local mode="advanced"
    
    # Check if it's a minimal/server environment
    if [[ ! -d "$HOME/.config" ]] || [[ $(df -h ~ | tail -1 | awk '{print $4}') == *"M" ]]; then
        mode="basic"
    fi
    
    # Check if it's a developer workstation
    if command -v docker &>/dev/null && command -v git &>/dev/null && [[ -d "$HOME/Projects" ]]; then
        mode="advanced"
    fi
    
    echo "$mode"
}

# Backup existing configs
auto_backup() {
    print_step "Creating automatic backup..."
    
    mkdir -p "$BACKUP_DIR"
    log "Backup directory: $BACKUP_DIR"
    
    # Files to backup
    local files=(
        "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.bash_logout"
        "$HOME/.profile" "$HOME/.inputrc" "$HOME/.zshrc"
        "$HOME/.zshenv" "$HOME/.zprofile" "$HOME/.tmux.conf"
        "$HOME/.vimrc" "$HOME/.gitconfig" "$HOME/.gitignore_global"
        "$HOME/.screenrc" "$HOME/.nanorc"
    )
    
    for file in "${files[@]}"; do
        if [[ -f "$file" && ! -L "$file" ]]; then
            cp "$file" "$BACKUP_DIR/" && log "Backed up: $file"
        fi
    done
    
    # Directories to backup
    local dirs=(
        "$HOME/.config/fish"
        "$HOME/.config/nushell"
        "$HOME/.config/nvim"
        "$HOME/.tmux"
    )
    
    for dir in "${dirs[@]}"; do
        if [[ -d "$dir" && ! -L "$dir" ]]; then
            cp -r "$dir" "$BACKUP_DIR/" && log "Backed up: $dir"
        fi
    done
    
    print_success "Backup completed: $BACKUP_DIR"
}

# Install packages based on OS
auto_install_packages() {
    local os=$1
    print_step "Auto-installing dependencies for $os..."
    
    case "$os" in
        arch|manjaro|endeavouros)
            auto_install_arch
            ;;
        debian|ubuntu)
            auto_install_debian
            ;;
        fedora|rhel|centos)
            auto_install_fedora
            ;;
        opensuse)
            auto_install_opensuse
            ;;
        macos)
            auto_install_macos
            ;;
        *)
            print_warning "Unknown OS: $os. Skipping package installation."
            return
            ;;
    esac
}

# Arch Linux installation
auto_install_arch() {
    print_info "Installing packages with pacman..."
    
    local packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux btop micro"
    
    if command -v pacman &>/dev/null; then
        sudo pacman -S --needed --noconfirm $packages 2>/dev/null || {
            print_warning "Some packages failed to install, continuing..."
        }
    fi
    
    # Install AUR helper if needed
    if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
        print_info "Installing yay (AUR helper)..."
        if [[ -d /tmp/yay ]]; then
            rm -rf /tmp/yay
        fi
        git clone https://aur.archlinux.org/yay.git /tmp/yay 2>/dev/null || true
        if [[ -d /tmp/yay ]]; then
            cd /tmp/yay
            makepkg -si --noconfirm 2>/dev/null || {
                print_warning "AUR helper installation failed, skipping AUR packages"
            }
        fi
    fi
    
    # Install AUR packages
    local aur_helper=""
    command -v yay &>/dev/null && aur_helper="yay"
    command -v paru &>/dev/null && aur_helper="paru"
    
    if [[ -n "$aur_helper" ]]; then
        print_info "Installing AUR packages..."
        $aur_helper -S --needed --noconfirm dust procs sd zellij 2>/dev/null || {
            print_warning "Some AUR packages failed"
        }
    fi
}

# Debian/Ubuntu installation
auto_install_debian() {
    print_info "Installing packages with apt..."
    
    # Update package list
    sudo apt-get update -qq
    
    # Install base packages
    local packages="git curl wget fzf zoxide bat ripgrep fd-find tmux"
    sudo apt-get install -y -qq $packages 2>/dev/null || {
        print_warning "Some base packages failed"
    }
    
    # Install eza
    if ! command -v eza &>/dev/null; then
        print_info "Installing eza..."
        sudo apt install -y -qq gpg 2>/dev/null || true
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc 2>/dev/null | \
            sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg 2>/dev/null || true
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | \
            sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list 2>/dev/null || true
        sudo apt-get update -qq
        sudo apt-get install -y -qq eza 2>/dev/null || {
            print_warning "eza installation failed"
        }
    fi
    
    # Install starship
    if ! command -v starship &>/dev/null; then
        print_info "Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || {
            print_warning "starship installation failed"
        }
    fi
    
    # Install micro
    if ! command -v micro &>/dev/null; then
        print_info "Installing micro..."
        curl -s https://getmic.ro | bash 2>/dev/null || {
            print_warning "micro installation failed"
        }
        [[ -f ./micro ]] && (sudo mv micro /usr/local/bin/ 2>/dev/null || mv micro ~/.local/bin/ 2>/dev/null || true)
    fi
    
    # Install btop
    if ! command -v btop &>/dev/null; then
        print_info "Installing btop..."
        sudo apt-get install -y -qq btop 2>/dev/null || {
            print_warning "btop not available in repo"
        }
    fi
}

# Fedora installation
auto_install_fedora() {
    print_info "Installing packages with dnf..."
    
    local packages="git curl wget fzf zoxide eza bat ripgrep fd-find starship fastfetch tmux btop micro"
    
    if command -v dnf &>/dev/null; then
        sudo dnf install -y $packages 2>/dev/null || {
            print_warning "Some packages failed"
        }
    elif command -v yum &>/dev/null; then
        sudo yum install -y $packages 2>/dev/null || {
            print_warning "Some packages failed"
        }
    fi
}

# openSUSE installation
auto_install_opensuse() {
    print_info "Installing packages with zypper..."
    
    local packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux btop"
    
    sudo zypper install -y $packages 2>/dev/null || {
        print_warning "Some packages failed"
    }
}

# macOS installation
auto_install_macos() {
    print_info "Installing packages with Homebrew..."
    
    if ! command -v brew &>/dev/null; then
        print_warning "Homebrew not found. Please install from https://brew.sh"
        return
    fi
    
    local packages="git curl wget fzf zoxide eza bat ripgrep fd starship fastfetch tmux btop micro"
    
    brew install $packages 2>/dev/null || {
        print_warning "Some packages failed"
    }
}

# Create directory structure
auto_create_dirs() {
    print_step "Creating directory structure..."
    
    local dirs=(
        "$HOME/.config"
        "$HOME/.config/fish/conf.d"
        "$HOME/.config/fish/functions"
        "$HOME/.config/fish/completions"
        "$HOME/.config/nushell"
        "$HOME/.config/alacritty"
        "$HOME/.config/kitty"
        "$HOME/.config/wezterm"
        "$HOME/.config/zellij"
        "$HOME/.config/nvim"
        "$HOME/.config/micro"
        "$HOME/.config/fastfetch"
        "$HOME/.config/Code/User"
        "$HOME/.local/bin"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    print_success "Directories created"
}

# Create symlinks
auto_create_symlinks() {
    local shells=$1
    print_step "Creating symlinks for: $shells"
    
    # Bash
    if [[ "$shells" == *"bash"* ]]; then
        log "Linking Bash configs..."
        ln -sf "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
        ln -sf "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile"
        ln -sf "$SCRIPT_DIR/.bash_logout" "$HOME/.bash_logout"
        ln -sf "$SCRIPT_DIR/.profile" "$HOME/.profile"
        ln -sf "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"
        print_success "Bash configured"
    fi
    
    # Zsh
    if [[ "$shells" == *"zsh"* ]]; then
        log "Linking Zsh configs..."
        ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
        print_success "Zsh configured"
    fi
    
    # Fish
    if [[ "$shells" == *"fish"* ]]; then
        log "Linking Fish configs..."
        mkdir -p "$HOME/.config/fish"
        ln -sf "$SCRIPT_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
        
        for file in "$SCRIPT_DIR"/fish/conf.d/*.fish; do
            [[ -f "$file" ]] && ln -sf "$file" "$HOME/.config/fish/conf.d/"
        done
        
        for file in "$SCRIPT_DIR"/fish/functions/*.fish; do
            [[ -f "$file" ]] && ln -sf "$file" "$HOME/.config/fish/functions/"
        done
        
        print_success "Fish configured"
    fi
    
    # Nushell
    if [[ "$shells" == *"nushell"* ]]; then
        log "Linking Nushell configs..."
        mkdir -p "$HOME/.config/nushell"
        ln -sf "$SCRIPT_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu"
        ln -sf "$SCRIPT_DIR/nushell/env.nu" "$HOME/.config/nushell/env.nu"
        print_success "Nushell configured"
    fi
    
    # Terminal emulators
    log "Linking terminal emulator configs..."
    ln -sf "$SCRIPT_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    ln -sf "$SCRIPT_DIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    ln -sf "$SCRIPT_DIR/config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
    ln -sf "$SCRIPT_DIR/config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
    print_success "Terminal emulators configured"
    
    # Editors
    log "Linking editor configs..."
    ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
    ln -sf "$SCRIPT_DIR/.nanorc" "$HOME/.nanorc"
    ln -sf "$SCRIPT_DIR/config/micro/settings.json" "$HOME/.config/micro/settings.json"
    ln -sf "$SCRIPT_DIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
    ln -sf "$SCRIPT_DIR/config/nvim/lua" "$HOME/.config/nvim/lua"
    ln -sf "$SCRIPT_DIR/config/Code/settings.json" "$HOME/.config/Code/User/settings.json"
    print_success "Editors configured"
    
    # Tools
    log "Linking tool configs..."
    ln -sf "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$SCRIPT_DIR/.screenrc" "$HOME/.screenrc"
    ln -sf "$SCRIPT_DIR/config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    ln -sf "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    ln -sf "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
    ln -sf "$SCRIPT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
    print_success "Tools configured"
    
    # SSH config
    if [[ -d "$HOME/.ssh" ]]; then
        if [[ ! -f "$HOME/.ssh/config" ]] || [[ "$FORCE_MODE" == true ]]; then
            cp -n "$SCRIPT_DIR/ssh/config.template" "$HOME/.ssh/config" 2>/dev/null || true
            chmod 600 "$HOME/.ssh/config" 2>/dev/null || true
            print_success "SSH config template installed"
        fi
    fi
}

# Set mode configuration
auto_set_mode() {
    local mode=$1
    print_step "Setting dotfiles mode: $mode"
    
    # Create mode files for shells
    echo "export DOTFILES_MODE=\"$mode\"" > "$HOME/.bashrc.local"
    
    if [[ -d "$HOME/.config/fish" ]]; then
        echo "set -gx DOTFILES_MODE \"$mode\"" > "$HOME/.config/fish/config.local.fish"
    fi
    
    print_success "Mode set to: $mode"
}

# Verify installation
auto_verify() {
    print_step "Verifying installation..."
    
    local errors=0
    
    # Check critical symlinks
    local critical_files=(
        "$HOME/.bashrc"
        "$HOME/.zshrc"
        "$HOME/.config/fish/config.fish"
        "$HOME/.config/starship.toml"
        "$HOME/.tmux.conf"
    )
    
    for file in "${critical_files[@]}"; do
        if [[ -L "$file" ]]; then
            log "✓ $file is linked"
        elif [[ -f "$file" ]]; then
            print_warning "$file exists but is not a symlink"
        else
            print_error "$file is missing"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_success "All critical files verified"
    else
        print_warning "Some files may be missing ($errors errors)"
    fi
}

# Main installation flow
auto_main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--force) FORCE_MODE=true; shift ;;
            -v|--verbose) VERBOSE=true; shift ;;
            --no-packages) NO_PACKAGES=true; shift ;;
            --no-backup) NO_BACKUP=true; shift ;;
            -h|--help)
                cat << 'EOF'
Automatic Dotfiles Installer v5.0.0

Usage: ./install-auto.sh [OPTIONS]

Options:
    -f, --force       Force overwrite existing files
    -v, --verbose     Enable verbose output
    --no-packages     Skip package installation
    --no-backup       Skip backup creation
    -h, --help        Show this help message

This installer automatically:
    • Detects your OS and installed shells
    • Installs required packages
    • Backs up existing configs
    • Creates all symlinks
    • Configures everything automatically

Zero interaction required!
EOF
                exit 0
                ;;
            *) shift ;;
        esac
    done
    
    # Header
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║       AUTOMATIC DOTFILES INSTALLER v${VERSION}              ║"
    echo "║                                                            ║"
    echo "║           Zero-Interaction Installation                    ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Auto-detect environment
    OS=$(auto_detect_os)
    SHELLS=$(auto_detect_shells)
    METHOD=$(auto_select_method)
    MODE=$(auto_select_mode)
    
    print_info "OS: $OS"
    print_info "Shells: $SHELLS"
    print_info "Method: $METHOD"
    print_info "Mode: $MODE"
    print_info "Backup: $BACKUP_DIR"
    echo ""
    
    # Run installation steps
    [[ "${NO_BACKUP:-false}" != true ]] && auto_backup
    [[ "${NO_PACKAGES:-false}" != true ]] && auto_install_packages "$OS"
    auto_create_dirs
    auto_create_symlinks "$SHELLS"
    auto_set_mode "$MODE"
    auto_verify
    
    # Success message
    echo ""
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════╗"
    echo "║         INSTALLATION COMPLETE! 🎉                          ║"
    echo "╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    print_success "All dotfiles installed automatically!"
    print_info "Backup location: $BACKUP_DIR"
    print_info "To restore: cp -r $BACKUP_DIR/* ~/"
    echo ""
    print_info "To apply changes, run:"
    [[ "$SHELLS" == *"bash"* ]] && echo "  source ~/.bashrc"
    [[ "$SHELLS" == *"zsh"* ]] && echo "  source ~/.zshrc"
    [[ "$SHELLS" == *"fish"* ]] && echo "  source ~/.config/fish/config.fish"
    echo ""
    echo -e "${CYAN}Happy hacking! 🚀${NC}"
}

# Run main
auto_main "$@"
