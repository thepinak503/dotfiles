#!/bin/bash
# =============================================================================
# INSTALL_DOTFILES - Complete Installation Script
# Installs all packages and dependencies for all shells
# =============================================================================

set -euo pipefail

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
INSTALL_ALL=false
INSTALL_HYPRLAND=false
INSTALL_DEV_TOOLS=false
INSTALL_CLOUD=false
SKIP_CONFIRM=false

# Print functions
print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DOTFILES COMPLETE INSTALLER                      ║"
    echo "║    Installs all packages for Bash, Zsh, Fish, Nushell      ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "${PURPLE}→${NC} $1"; }

# Detect OS
detect_os() {
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
    print_success "Detected OS: $OS_NAME"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Do not run this script as root!"
        print_info "The script will use sudo when needed."
        exit 1
    fi
}

# Install packages based on OS
install_packages() {
    local packages="$1"
    
    case "$OS" in
        arch|manjaro|endeavouros)
            print_step "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some packages may have failed"
            ;;
        debian|ubuntu|pop|linuxmint)
            print_step "Installing packages with apt..."
            sudo apt-get update
            sudo apt-get install -y $packages 2>/dev/null || print_warning "Some packages may have failed"
            ;;
        fedora|rhel|centos)
            print_step "Installing packages with dnf..."
            sudo dnf install -y $packages 2>/dev/null || print_warning "Some packages may have failed"
            ;;
        opensuse*)
            print_step "Installing packages with zypper..."
            sudo zypper install -y $packages 2>/dev/null || print_warning "Some packages may have failed"
            ;;
        macos)
            if command -v brew &>/dev/null; then
                print_step "Installing packages with Homebrew..."
                brew install $packages 2>/dev/null || print_warning "Some packages may have failed"
            else
                print_error "Homebrew not found. Install from https://brew.sh"
            fi
            ;;
        *)
            print_error "Unsupported OS: $OS"
            return 1
            ;;
    esac
}

# Install AUR packages (Arch only)
install_aur_packages() {
    local packages="$1"
    
    if [[ "$OS" == "arch" ]] || [[ "$OS" == "manjaro" ]] || [[ "$OS" == "endeavouros" ]]; then
        if command -v yay &>/dev/null; then
            print_step "Installing AUR packages with yay..."
            yay -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some AUR packages may have failed"
        elif command -v paru &>/dev/null; then
            print_step "Installing AUR packages with paru..."
            paru -S --needed --noconfirm $packages 2>/dev/null || print_warning "Some AUR packages may have failed"
        else
            print_warning "No AUR helper found (yay/paru). Skipping AUR packages."
        fi
    fi
}

# =============================================================================
# CORE SHELLS INSTALLATION
# =============================================================================

install_shells() {
    print_header
    print_step "Installing shells..."
    
    local shell_packages=""
    
    case "$OS" in
        arch|manjaro|endeavouros)
            shell_packages="bash zsh fish nushell"
            ;;
        debian|ubuntu|pop|linuxmint)
            shell_packages="bash zsh fish"
            # Nushell may need manual install on Debian
            ;;
        fedora|rhel|centos)
            shell_packages="bash zsh fish"
            ;;
        opensuse*)
            shell_packages="bash zsh fish"
            ;;
        macos)
            shell_packages="bash zsh fish nushell"
            ;;
    esac
    
    install_packages "$shell_packages"
    
    # Change default shell to zsh if available
    if command -v zsh &>/dev/null; then
        print_info "Zsh is installed. To make it your default shell, run:"
        print_info "  chsh -s $(which zsh)"
    fi
    
    print_success "Shells installed"
}

# =============================================================================
# MODERN CLI TOOLS
# =============================================================================

install_modern_tools() {
    print_step "Installing modern CLI tools..."
    
    local tools=""
    
    case "$OS" in
        arch|manjaro|endeavouros)
            tools="fzf zoxide eza bat ripgrep fd starship fastfetch btop dust procs sd micro"
            install_packages "$tools"
            # AUR packages
            install_aur_packages "zellij"
            ;;
        debian|ubuntu|pop|linuxmint)
            tools="fzf zoxide bat ripgrep fd-find tmux"
            install_packages "$tools"
            # Install starship
            curl -sS https://starship.rs/install.sh | sh -s -- -y
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
            # Install micro
            curl https://getmic.ro | bash
            sudo mv micro /usr/local/bin/ 2>/dev/null || mv micro ~/.local/bin/
            ;;
        fedora|rhel|centos)
            tools="fzf zoxide eza bat ripgrep fd-find starship fastfetch tmux btop"
            install_packages "$tools"
            ;;
        opensuse*)
            tools="fzf zoxide eza bat ripgrep fd starship fastfetch tmux btop"
            install_packages "$tools"
            ;;
        macos)
            tools="fzf zoxide eza bat ripgrep fd starship fastfetch tmux btop micro"
            install_packages "$tools"
            ;;
    esac
    
    # Install delta for git
    if ! command -v delta &>/dev/null; then
        print_step "Installing delta..."
        case "$OS" in
            arch|manjaro|endeavouros)
                install_packages "git-delta"
                ;;
            debian|ubuntu)
                curl -sL https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb -o /tmp/delta.deb
                sudo dpkg -i /tmp/delta.deb
                ;;
            fedora|rhel|centos)
                install_packages "git-delta"
                ;;
            macos)
                brew install git-delta
                ;;
        esac
    fi
    
    print_success "Modern CLI tools installed"
}

# =============================================================================
# TERMINAL EMULATORS
# =============================================================================

install_terminals() {
    print_step "Installing terminal emulators..."
    
    local terms=""
    
    case "$OS" in
        arch|manjaro|endeavouros)
            terms="alacritty kitty"
            install_packages "$terms"
            install_aur_packages "wezterm"
            ;;
        debian|ubuntu)
            terms="alacritty"
            install_packages "$terms"
            print_warning "Kitty and WezTerm may need manual installation on Debian"
            ;;
        fedora)
            terms="alacritty kitty"
            install_packages "$terms"
            ;;
        opensuse)
            terms="alacritty kitty"
            install_packages "$terms"
            ;;
        macos)
            terms="alacritty kitty wezterm"
            install_packages "$terms"
            ;;
    esac
    
    print_success "Terminal emulators installed"
}

# =============================================================================
# HYPRLAND (Wayland Desktop)
# =============================================================================

install_hyprland() {
    if [[ "$INSTALL_HYPRLAND" == false ]]; then
        return
    fi
    
    print_step "Installing Hyprland and dependencies..."
    
    if [[ "$OS" == "arch" ]] || [[ "$OS" == "manjaro" ]] || [[ "$OS" == "endeavouros" ]]; then
        # Core Hyprland packages
        local hypr_packages="hyprland waybar wofi swaylock swayidle swaync grimblast"
        install_packages "$hypr_packages"
        
        # Additional dependencies
        local hypr_deps="xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland"
        install_packages "$hypr_deps"
        
        # Install themes
        install_aur_packages "catppuccin-gtk-theme-mocha papirus-icon-theme catppuccin-cursors-mocha"
        
        print_success "Hyprland installed"
        print_info "To start Hyprland, run: exec Hyprland"
    else
        print_warning "Hyprland installation is primarily supported on Arch Linux"
        print_info "For other distributions, please install manually"
    fi
}

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================

install_dev_tools() {
    if [[ "$INSTALL_DEV_TOOLS" == false ]] && [[ "$INSTALL_ALL" == false ]]; then
        return
    fi
    
    print_step "Installing development tools..."
    
    # Git tools
    install_packages "git git-lfs"
    
    # Build essentials
    case "$OS" in
        arch|manjaro|endeavouros)
            install_packages "base-devel"
            ;;
        debian|ubuntu)
            install_packages "build-essential"
            ;;
        fedora|rhel|centos)
            install_packages "gcc gcc-c++ make"
            ;;
        opensuse)
            install_packages "gcc gcc-c++ make"
            ;;
        macos)
            install_packages "cmake"
            ;;
    esac
    
    # Docker
    if ! command -v docker &>/dev/null; then
        print_step "Installing Docker..."
        case "$OS" in
            arch|manjaro|endeavouros)
                install_packages "docker docker-compose"
                sudo systemctl enable --now docker
                ;;
            debian|ubuntu)
                # Docker install script
                curl -fsSL https://get.docker.com | sh
                ;;
            fedora)
                install_packages "docker docker-compose"
                sudo systemctl enable --now docker
                ;;
        esac
        sudo usermod -aG docker "$USER"
        print_info "Please log out and back in for Docker group changes to take effect"
    fi
    
    # Kubernetes tools
    if ! command -v kubectl &>/dev/null; then
        print_step "Installing kubectl..."
        case "$OS" in
            arch|manjaro|endeavouros)
                install_packages "kubectl"
                ;;
            *)
                curl -LO "https://dl.k8s/release/$(curl -L -s https://dl.k8s/release/stable.txt)/bin/linux/amd64/kubectl"
                sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                ;;
        esac
    fi
    
    # Helm
    if ! command -v helm &>/dev/null; then
        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    fi
    
    print_success "Development tools installed"
}

# =============================================================================
# LANGUAGE VERSION MANAGERS
# =============================================================================

install_lang_managers() {
    print_step "Installing language version managers..."
    
    # NVM (Node)
    if [ ! -d "$HOME/.nvm" ]; then
        print_step "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        print_success "NVM installed"
    fi
    
    # Pyenv (Python)
    if ! command -v pyenv &>/dev/null; then
        print_step "Installing Pyenv..."
        curl https://pyenv.run | bash
        print_success "Pyenv installed"
    fi
    
    # Rust
    if ! command -v rustc &>/dev/null; then
        print_step "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        print_success "Rust installed"
    fi
    
    # Go
    if ! command -v go &>/dev/null; then
        print_step "Installing Go..."
        case "$OS" in
            arch|manjaro|endeavouros)
                install_packages "go"
                ;;
            debian|ubuntu)
                install_packages "golang-go"
                ;;
            fedora)
                install_packages "golang"
                ;;
            macos)
                brew install go
                ;;
        esac
        print_success "Go installed"
    fi
    
    print_success "Language version managers installed"
}

# =============================================================================
# CLOUD CLI TOOLS
# =============================================================================

install_cloud_tools() {
    if [[ "$INSTALL_CLOUD" == false ]] && [[ "$INSTALL_ALL" == false ]]; then
        return
    fi
    
    print_step "Installing cloud CLI tools..."
    
    # AWS CLI
    if ! command -v aws &>/dev/null; then
        print_step "Installing AWS CLI..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
        unzip -q /tmp/awscliv2.zip -d /tmp
        sudo /tmp/aws/install
    fi
    
    # Azure CLI
    if ! command -v az &>/dev/null; then
        print_step "Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    fi
    
    # Google Cloud SDK
    if ! command -v gcloud &>/dev/null; then
        print_step "Installing Google Cloud SDK..."
        curl -sSL https://sdk.cloud.google.com | bash
    fi
    
    # Terraform
    if ! command -v terraform &>/dev/null; then
        print_step "Installing Terraform..."
        case "$OS" in
            arch|manjaro|endeavouros)
                install_packages "terraform"
                ;;
            *)
                # Install via official repository
                sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
                wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update && sudo apt-get install -y terraform
                ;;
        esac
    fi
    
    print_success "Cloud CLI tools installed"
}

# =============================================================================
# FONTS
# =============================================================================

install_fonts() {
    print_step "Installing Nerd Fonts..."
    
    # Create fonts directory
    mkdir -p ~/.local/share/fonts
    
    # Download JetBrainsMono Nerd Font
    if [ ! -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
        print_step "Downloading JetBrainsMono Nerd Font..."
        cd /tmp
        wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip" -O JetBrainsMono.zip
        unzip -q -o JetBrainsMono.zip -d ~/.local/share/fonts/
        fc-cache -fv
        print_success "JetBrainsMono Nerd Font installed"
    fi
    
    # Download Caskaydiacove Nerd Font (for kitty)
    if [ ! -f "$HOME/.local/share/fonts/CaskaydiaCoveNerdFont-Regular.ttf" ]; then
        print_step "Downloading Caskaydiacove Nerd Font..."
        cd /tmp
        wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip" -O CascadiaCode.zip
        unzip -q -o CascadiaCode.zip -d ~/.local/share/fonts/
        fc-cache -fv
        print_success "Caskaydiacove Nerd Font installed"
    fi
}

# =============================================================================
# MAIN INSTALLATION FUNCTION
# =============================================================================

install_dotfiles() {
    print_header
    check_root
    detect_os
    
    print_info "This will install all packages needed for the dotfiles"
    print_info "Components to be installed:"
    echo "  • All shells (Bash, Zsh, Fish, Nushell)"
    echo "  • Modern CLI tools (50+ tools)"
    echo "  • Terminal emulators (Alacritty, Kitty, WezTerm)"
    echo "  • Development tools (Docker, K8s)"
    echo "  • Language managers (nvm, pyenv, rustup, go)"
    
    if [[ "$INSTALL_HYPRLAND" == true ]]; then
        echo "  • Hyprland Wayland desktop"
    fi
    
    if [[ "$INSTALL_CLOUD" == true ]] || [[ "$INSTALL_ALL" == true ]]; then
        echo "  • Cloud CLI tools (AWS, Azure, GCP)"
    fi
    
    echo ""
    
    if [[ "$SKIP_CONFIRM" == false ]]; then
        read -p "Continue with installation? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            return 0
        fi
    fi
    
    # Run installations
    install_shells
    install_modern_tools
    install_terminals
    install_fonts
    install_lang_managers
    install_dev_tools
    install_hyprland
    install_cloud_tools
    
    # Final setup
    print_step "Finalizing installation..."
    
    # Create local directories
    mkdir -p ~/.local/bin
    mkdir -p ~/.config
    
    print_success "Installation complete!"
    echo ""
    print_info "Next steps:"
    print_info "1. Run the dotfiles installer: ./install.sh"
    print_info "2. Restart your shell or log out and back in"
    print_info "3. For Hyprland: run 'exec Hyprland' from TTY"
    echo ""
    print_info "To update in the future, run: ./scripts/sysupdate.sh"
}

# =============================================================================
# COMMAND LINE INTERFACE
# =============================================================================

show_help() {
    cat << EOF
Dotfiles Complete Installer

Usage: $0 [OPTIONS]

Options:
    -h, --help          Show this help message
    -a, --all           Install everything including cloud tools
    --hyprland          Install Hyprland Wayland desktop
    --cloud             Install cloud CLI tools (AWS, Azure, GCP)
    --dev               Install development tools
    -y, --yes           Skip confirmation prompts

Examples:
    $0                  # Basic installation
    $0 --all            # Install everything
    $0 --hyprland       # Include Hyprland desktop
    $0 --cloud --yes    # Install with cloud tools, no prompts

This script installs all system packages needed before running ./install.sh
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -a|--all)
            INSTALL_ALL=true
            shift
            ;;
        --hyprland)
            INSTALL_HYPRLAND=true
            shift
            ;;
        --cloud)
            INSTALL_CLOUD=true
            shift
            ;;
        --dev)
            INSTALL_DEV_TOOLS=true
            shift
            ;;
        -y|--yes)
            SKIP_CONFIRM=true
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_dotfiles
fi