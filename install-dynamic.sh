#!/usr/bin/env bash
# =============================================================================
# DYNAMIC DOTFILES INSTALLER
# Automatically detects tools and creates optimized configurations
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Configuration
SHELL_TYPE="${SHELL_TYPE:-auto}"
INSTALL_MODE="${INSTALL_MODE:-update}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)}"

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

log_info() {
    echo -e "${BLUE}[INFO]${RESET} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
}

detect_current_shell() {
    if [[ -n "$ZSH_VERSION" ]]; then
        echo "zsh"
    elif [[ -n "$BASH_VERSION" ]]; then
        echo "bash"
    elif [[ -n "$FISH_VERSION" ]]; then
        echo "fish"
    elif command -v nu &>/dev/null && [[ "$SHELL" == *"nu"* ]]; then
        echo "nushell"
    else
        echo "bash"  # Default fallback
    fi
}

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$(basename "$file")"
        cp "$file" "$backup_path"
        log_info "Backed up $file to $backup_path"
    fi
}

# =============================================================================
# DYNAMIC INSTALLATION FUNCTIONS
# =============================================================================

install_bash_config() {
    log_info "Installing Bash configuration..."
    
    local config_dir="$DOTFILES_DIR/generated"
    local bash_config="$config_dir/dynamic-bash.sh"
    local bashrc="$HOME/.bashrc"
    local bash_profile="$HOME/.bash_profile"
    
    if [[ -f "$bash_config" ]]; then
        # Backup existing configs
        backup_file "$bashrc"
        backup_file "$bash_profile"
        
        # Create new .bashrc
        cat > "$bashrc" << 'EOF'
#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH CONFIGURATION
# Auto-generated based on detected tools
# =============================================================================

# Source dynamic configuration
if [[ -f "$HOME/.dotfiles/generated/dynamic-bash.sh" ]]; then
    source "$HOME/.dotfiles/generated/dynamic-bash.sh"
fi

# Source local customizations
if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi

EOF
        
        # Create .bash_profile
        cat > "$bash_profile" << 'EOF'
#!/usr/bin/env bash
# =============================================================================
# DYNAMIC BASH PROFILE
# =============================================================================

# Source .bashrc
if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi

# Source local customizations
if [[ -f "$HOME/.bash_profile.local" ]]; then
    source "$HOME/.bash_profile.local"
fi

EOF
        
        log_success "Bash configuration installed"
    else
        log_error "Dynamic bash configuration not found at $bash_config"
    fi
}

install_zsh_config() {
    log_info "Installing Zsh configuration..."
    
    local config_dir="$DOTFILES_DIR/generated"
    local zsh_config="$config_dir/dynamic-zsh.sh"
    local zshrc="$HOME/.zshrc"
    
    if [[ -f "$zsh_config" ]]; then
        # Backup existing config
        backup_file "$zshrc"
        
        # Create new .zshrc
        cat > "$zshrc" << 'EOF'
#!/usr/bin/env zsh
# =============================================================================
# DYNAMIC ZSH CONFIGURATION
# Auto-generated based on detected tools
# =============================================================================

# Source dynamic configuration
if [[ -f "$HOME/.dotfiles/generated/dynamic-zsh.sh" ]]; then
    source "$HOME/.dotfiles/generated/dynamic-zsh.sh"
fi

# Source local customizations
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

EOF
        
        log_success "Zsh configuration installed"
    else
        log_error "Dynamic zsh configuration not found at $zsh_config"
    fi
}

install_fish_config() {
    log_info "Installing Fish configuration..."
    
    local config_dir="$DOTFILES_DIR/generated"
    local fish_config="$config_dir/dynamic-fish.fish"
    local fish_config_dir="$HOME/.config/fish"
    local fish_functions_dir="$fish_config_dir/functions"
    
    if [[ -f "$fish_config" ]]; then
        # Create directories
        mkdir -p "$fish_config_dir" "$fish_functions_dir"
        
        # Backup existing config
        backup_file "$fish_config_dir/config.fish"
        
        # Copy dynamic config
        cp "$fish_config" "$fish_config_dir/config.fish"
        
        log_success "Fish configuration installed"
    else
        log_error "Dynamic fish configuration not found at $fish_config"
    fi
}

install_nushell_config() {
    log_info "Installing Nushell configuration..."
    
    local config_dir="$DOTFILES_DIR/generated"
    local nu_config="$config_dir/dynamic-nu.nu"
    local nu_config_dir="$HOME/.config/nushell"
    
    if [[ -f "$nu_config" ]]; then
        # Create directory
        mkdir -p "$nu_config_dir"
        
        # Backup existing config
        backup_file "$nu_config_dir/config.nu"
        
        # Copy dynamic config
        cp "$nu_config" "$nu_config_dir/config.nu"
        
        log_success "Nushell configuration installed"
    else
        log_error "Dynamic nushell configuration not found at $nu_config"
    fi
}

install_common_configs() {
    log_info "Installing common configurations..."
    
    # Copy common config files
    local common_configs=(
        ".vimrc"
        ".tmux.conf"
        ".inputrc"
        ".gitconfig"
        ".gitignore"
    )
    
    for config in "${common_configs[@]}"; do
        local source="$DOTFILES_DIR/$config"
        local target="$HOME/$config"
        
        if [[ -f "$source" ]]; then
            backup_file "$target"
            cp "$source" "$target"
            log_success "Installed $config"
        fi
    done
    
    # Copy script files
    local scripts_dir="$HOME/.local/bin"
    mkdir -p "$scripts_dir"
    
    # Make scripts executable and copy to local bin
    find "$DOTFILES_DIR/scripts" -name "*.sh" -type f -exec cp {} "$scripts_dir/" \;
    chmod +x "$scripts_dir"/*.sh
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$scripts_dir:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
        log_info "Added $scripts_dir to PATH"
    fi
}

# =============================================================================
# MAIN INSTALLATION
# =============================================================================

main() {
    local action="${1:-install}"
    local shell="${2:-auto}"
    
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DYNAMIC DOTFILES INSTALLER                       ║"
    echo "║              Auto-Detection & Installation                 ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    case "$action" in
        "install"|"update")
            log_info "Starting dynamic dotfiles $action..."
            
            # Detect current shell if auto
            if [[ "$shell" == "auto" ]]; then
                shell=$(detect_current_shell)
                log_info "Detected shell: $shell"
            fi
            
            # Generate configurations
            log_info "Generating dynamic configurations..."
            "$SCRIPT_DIR/generate-configs.sh" "all" "$DOTFILES_DIR/generated"
            
            if [[ $? -ne 0 ]]; then
                log_error "Failed to generate configurations"
                exit 1
            fi
            
            # Install shell-specific configs
            case "$shell" in
                "bash")
                    install_bash_config
                    ;;
                "zsh")
                    install_zsh_config
                    ;;
                "fish")
                    install_fish_config
                    ;;
                "nushell"|"nu")
                    install_nushell_config
                    ;;
                "all")
                    install_bash_config
                    install_zsh_config
                    install_fish_config
                    install_nushell_config
                    ;;
            esac
            
            # Install common configurations
            install_common_configs
            
            log_success "Dynamic dotfiles installation completed!"
            log_info "Backup created at: $BACKUP_DIR"
            log_info "Generated configs at: $DOTFILES_DIR/generated"
            
            echo ""
            echo -e "${WHITE}Next steps:${RESET}"
            echo "1. Restart your shell or run 'source ~/.${shell}rc'"
            echo "2. Check the generated report: $DOTFILES_DIR/generated/generated-report.txt"
            echo "3. Customize local settings in ~/.${shell}rc.local"
            echo ""
            echo -e "${GREEN}✨ Your dynamic dotfiles are now active! ✨${RESET}"
            ;;
            
        "detect")
            log_info "Running module detection only..."
            "$SCRIPT_DIR/dynamic-modules.sh" "report"
            ;;
            
        "generate")
            local gen_shell="${3:-all}"
            log_info "Generating configurations only..."
            "$SCRIPT_DIR/generate-configs.sh" "$gen_shell" "$DOTFILES_DIR/generated"
            ;;
            
        "clean")
            log_info "Cleaning generated files..."
            if [[ -d "$DOTFILES_DIR/generated" ]]; then
                rm -rf "$DOTFILES_DIR/generated"
                log_success "Cleaned generated files"
            fi
            ;;
            
        "restore")
            if [[ -d "$BACKUP_DIR" ]]; then
                log_info "Restoring from backup at $BACKUP_DIR..."
                find "$BACKUP_DIR" -type f -name ".*" -exec cp {} "$HOME/" \;
                log_success "Backup restored"
            else
                log_error "No backup found at $BACKUP_DIR"
            fi
            ;;
            
        *)
            echo "Usage: $0 {install|update|detect|generate|clean|restore} [shell] [options]"
            echo ""
            echo "Commands:"
            echo "  install   - Full installation (default)"
            echo "  update    - Update existing installation"
            echo "  detect    - Run module detection and show report"
            echo "  generate  - Generate configurations only"
            echo "  clean     - Clean generated files"
            echo "  restore   - Restore from backup"
            echo ""
            echo "Shell types: auto, bash, zsh, fish, nushell, all"
            echo ""
            echo "Examples:"
            echo "  $0 install auto      # Auto-detect and install"
            echo "  $0 install zsh       # Install for Zsh only"
            echo "  $0 detect            # Show detection report"
            echo "  $0 generate fish     # Generate Fish config only"
            exit 1
            ;;
    esac
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi