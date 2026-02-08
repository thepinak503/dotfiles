#!/bin/bash
# =============================================================================
# DOTFILES UNINSTALLER
# Clean removal of dotfiles and restoration of backups
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Configuration
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

print_header() {
    echo -e "${RED}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           DOTFILES UNINSTALLER                             ║"
    echo "║    Clean removal and restoration                           ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "${PURPLE}→${NC} $1"; }

# Find latest backup
find_latest_backup() {
    local latest=$(ls -td "$BACKUP_DIR"-* 2>/dev/null | head -n 1)
    echo "$latest"
}

# Remove symlinks
remove_symlinks() {
    print_step "Removing symlinks..."
    
    local files=(
        "$HOME/.bashrc"
        "$HOME/.bash_profile"
        "$HOME/.bash_logout"
        "$HOME/.profile"
        "$HOME/.inputrc"
        "$HOME/.zshrc"
        "$HOME/.gitconfig"
        "$HOME/.gitignore_global"
    )
    
    for file in "${files[@]}"; do
        if [[ -L "$file" ]]; then
            rm "$file"
            print_info "Removed: $file"
        fi
    done
    
    # Fish
    if [[ -L "$HOME/.config/fish/config.fish" ]]; then
        rm "$HOME/.config/fish/config.fish"
        print_info "Removed: Fish config"
    fi
    
    # Nushell
    if [[ -L "$HOME/.config/nushell/config.nu" ]]; then
        rm "$HOME/.config/nushell/config.nu" "$HOME/.config/nushell/env.nu"
        print_info "Removed: Nushell config"
    fi
    
    # Starship
    if [[ -L "$HOME/.config/starship.toml" ]]; then
        rm "$HOME/.config/starship.toml"
        print_info "Removed: Starship config"
    fi
    
    # Fastfetch
    if [[ -L "$HOME/.config/fastfetch/config.jsonc" ]]; then
        rm "$HOME/.config/fastfetch/config.jsonc"
        print_info "Removed: Fastfetch config"
    fi
    
    print_success "Symlinks removed"
}

# Restore from backup
restore_backup() {
    local backup_path="$1"
    
    if [[ -z "$backup_path" || ! -d "$backup_path" ]]; then
        print_warning "No backup found to restore"
        return
    fi
    
    print_step "Restoring from backup: $backup_path"
    
    [[ -f "$backup_path/.bashrc" ]] && cp "$backup_path/.bashrc" "$HOME/" && print_info "Restored: .bashrc"
    [[ -f "$backup_path/.bash_profile" ]] && cp "$backup_path/.bash_profile" "$HOME/" && print_info "Restored: .bash_profile"
    [[ -f "$backup_path/.bash_logout" ]] && cp "$backup_path/.bash_logout" "$HOME/" && print_info "Restored: .bash_logout"
    [[ -f "$backup_path/.profile" ]] && cp "$backup_path/.profile" "$HOME/" && print_info "Restored: .profile"
    [[ -f "$backup_path/.inputrc" ]] && cp "$backup_path/.inputrc" "$HOME/" && print_info "Restored: .inputrc"
    [[ -f "$backup_path/.zshrc" ]] && cp "$backup_path/.zshrc" "$HOME/" && print_info "Restored: .zshrc"
    [[ -f "$backup_path/.zshenv" ]] && cp "$backup_path/.zshenv" "$HOME/" && print_info "Restored: .zshenv"
    [[ -f "$backup_path/.zprofile" ]] && cp "$backup_path/.zprofile" "$HOME/" && print_info "Restored: .zprofile"
    [[ -f "$backup_path/.gitconfig" ]] && cp "$backup_path/.gitconfig" "$HOME/" && print_info "Restored: .gitconfig"
    [[ -f "$backup_path/.gitignore_global" ]] && cp "$backup_path/.gitignore_global" "$HOME/" && print_info "Restored: .gitignore_global"
    
    # Fish
    if [[ -d "$backup_path/fish" ]]; then
        rm -rf "$HOME/.config/fish"
        cp -r "$backup_path/fish" "$HOME/.config/"
        print_info "Restored: Fish config"
    fi
    
    # Nushell
    if [[ -d "$backup_path/nushell" ]]; then
        rm -rf "$HOME/.config/nushell"
        cp -r "$backup_path/nushell" "$HOME/.config/"
        print_info "Restored: Nushell config"
    fi
    
    print_success "Backup restored"
}

# Remove dotfiles directory
remove_dotfiles() {
    if [[ -d "$DOTFILES_DIR" ]]; then
        print_step "Removing dotfiles directory..."
        rm -rf "$DOTFILES_DIR"
        print_success "Dotfiles directory removed"
    fi
}

# Main
main() {
    print_header
    
    echo "This will uninstall dotfiles and restore your original configuration."
    echo ""
    
    read -p "Continue? [y/N]: " confirm
    [[ ! "$confirm" =~ ^[Yy]$ ]] && { print_info "Uninstall cancelled"; exit 0; }
    
    local latest_backup=$(find_latest_backup)
    
    if [[ -n "$latest_backup" ]]; then
        print_info "Found backup: $latest_backup"
        read -p "Restore from this backup? [Y/n]: " restore
        if [[ ! "$restore" =~ ^[Nn]$ ]]; then
            restore_backup "$latest_backup"
        fi
    fi
    
    remove_symlinks
    remove_dotfiles
    
    echo ""
    print_success "Dotfiles uninstalled successfully!"
    echo ""
    print_info "Please restart your terminal or run:"
    echo "  source ~/.bashrc  (for Bash)"
    echo "  source ~/.zshrc   (for Zsh)"
    echo "  # Or open a new terminal window"
}

main
