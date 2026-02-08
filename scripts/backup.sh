#!/bin/bash
# Backup and Sync System
# Rsync, rclone, and automated backup scripts

set -euo pipefail

# Configuration
BACKUP_DIR="${BACKUP_DIR:-$HOME/Backups}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config}"
LOG_FILE="$BACKUP_DIR/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging
log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

# Create backup directory
mkdir -p "$BACKUP_DIR"

# =============================================================================
# DOTFILES BACKUP
# =============================================================================

backup-dotfiles() {
    log "Backing up dotfiles..."
    
    local backup_file="$BACKUP_DIR/dotfiles_$DATE.tar.gz"
    
    if [ -d "$DOTFILES_DIR" ]; then
        tar -czf "$backup_file" -C "$HOME" .dotfiles
        success "Dotfiles backed up to: $backup_file"
    else
        error "Dotfiles directory not found at $DOTFILES_DIR"
        return 1
    fi
}

# =============================================================================
# CONFIG BACKUP
# =============================================================================

backup-configs() {
    log "Backing up configuration files..."
    
    local backup_file="$BACKUP_DIR/configs_$DATE.tar.gz"
    
    # List of important config directories
    local configs=(
        "alacritty"
        "btop"
        "fastfetch"
        "fish"
        "hypr"
        "kitty"
        "micro"
        "nvim"
        "ranger"
        "starship.toml"
        "swaylock"
        "swaync"
        "waybar"
        "wezterm"
        "wofi"
        "zellij"
    )
    
    local found_configs=()
    
    for config in "${configs[@]}"; do
        if [ -e "$CONFIG_DIR/$config" ]; then
            found_configs+=(".config/$config")
        fi
    done
    
    if [ ${#found_configs[@]} -gt 0 ]; then
        tar -czf "$backup_file" -C "$HOME" "${found_configs[@]}"
        success "Configs backed up to: $backup_file"
    else
        warning "No config directories found to backup"
    fi
}

# =============================================================================
# HOME BACKUP
# =============================================================================

backup-home() {
    log "Backing up important home files..."
    
    local backup_file="$BACKUP_DIR/home_$DATE.tar.gz"
    
    # Important files to backup
    local files=(
        ".bashrc"
        ".bash_profile"
        ".zshrc"
        ".vimrc"
        ".tmux.conf"
        ".gitconfig"
        ".ssh/config"
        ".p10k.zsh"
        ".nvmrc"
        ".python-version"
        ".ruby-version"
        ".node-version"
    )
    
    local found_files=()
    
    for file in "${files[@]}"; do
        if [ -f "$HOME/$file" ]; then
            found_files+=("$file")
        fi
    done
    
    if [ ${#found_files[@]} -gt 0 ]; then
        tar -czf "$backup_file" -C "$HOME" "${found_files[@]}"
        success "Home files backed up to: $backup_file"
    else
        warning "No home files found to backup"
    fi
}

# =============================================================================
# RSYNC BACKUP
# =============================================================================

rsync-backup() {
    local src="${1:-$HOME/Documents}"
    local dest="${2:-$BACKUP_DIR/Documents}"
    
    log "Rsync backup: $src -> $dest"
    
    rsync -avh --progress --delete \
        --exclude='.git' \
        --exclude='node_modules' \
        --exclude='__pycache__' \
        --exclude='*.pyc' \
        --exclude='.env' \
        --exclude='.venv' \
        --exclude='target' \
        "$src/" "$dest/"
    
    success "Rsync backup complete: $dest"
}

# =============================================================================
# RESTORE FUNCTIONS
# =============================================================================

list-backups() {
    log "Available backups:"
    ls -lh "$BACKUP_DIR"/*.tar.gz 2>/dev/null | awk '{print $9, "(" $5 ")"}' || echo "No backups found"
}

restore-dotfiles() {
    local backup_file="$1"
    
    if [ -z "$backup_file" ]; then
        list-backups
        echo ""
        read -p "Enter backup filename to restore: " backup_file
    fi
    
    if [ ! -f "$BACKUP_DIR/$backup_file" ]; then
        error "Backup file not found: $backup_file"
        return 1
    fi
    
    warning "This will overwrite existing dotfiles!"
    read -p "Are you sure? [y/N] " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Restore cancelled"
        return 0
    fi
    
    # Backup current dotfiles first
    local current_backup="$BACKUP_DIR/dotfiles_pre_restore_$(date +%Y%m%d_%H%M%S).tar.gz"
    if [ -d "$DOTFILES_DIR" ]; then
        tar -czf "$current_backup" -C "$HOME" .dotfiles
        log "Current dotfiles backed up to: $current_backup"
    fi
    
    # Extract backup
    tar -xzf "$BACKUP_DIR/$backup_file" -C "$HOME"
    success "Dotfiles restored from: $backup_file"
}

restore-configs() {
    local backup_file="$1"
    
    if [ -z "$backup_file" ]; then
        list-backups
        echo ""
        read -p "Enter config backup filename to restore: " backup_file
    fi
    
    if [ ! -f "$BACKUP_DIR/$backup_file" ]; then
        error "Backup file not found: $backup_file"
        return 1
    fi
    
    warning "This will overwrite existing configs!"
    read -p "Are you sure? [y/N] " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Restore cancelled"
        return 0
    fi
    
    # Backup current configs first
    local current_backup="$BACKUP_DIR/configs_pre_restore_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$current_backup" -C "$HOME" .config 2>/dev/null || true
    
    # Extract backup
    tar -xzf "$BACKUP_DIR/$backup_file" -C "$HOME"
    success "Configs restored from: $backup_file"
}

# =============================================================================
# CLEANUP
# =============================================================================

cleanup-backups() {
    local keep_count="${1:-10}"
    
    log "Cleaning up old backups (keeping last $keep_count)..."
    
    cd "$BACKUP_DIR" || return 1
    
    # Remove old backups, keeping the most recent
    ls -t *.tar.gz 2>/dev/null | tail -n +$((keep_count + 1)) | xargs -r rm -f
    
    success "Cleanup complete"
}

# =============================================================================
# MAIN
# =============================================================================

case "${1:-all}" in
    dotfiles)
        backup-dotfiles
        ;;
    configs)
        backup-configs
        ;;
    home)
        backup-home
        ;;
    rsync)
        rsync-backup "$2" "$3"
        ;;
    all)
        backup-dotfiles
        backup-configs
        backup-home
        ;;
    list)
        list-backups
        ;;
    restore-dotfiles)
        restore-dotfiles "$2"
        ;;
    restore-configs)
        restore-configs "$2"
        ;;
    cleanup)
        cleanup-backups "$2"
        ;;
    *)
        echo "Usage: $0 {dotfiles|configs|home|rsync|all|list|restore-dotfiles|restore-configs|cleanup}"
        echo ""
        echo "Commands:"
        echo "  dotfiles              Backup dotfiles repository"
        echo "  configs               Backup config files"
        echo "  home                  Backup home files"
        echo "  rsync [src] [dest]    Rsync backup"
        echo "  all                   Backup everything (default)"
        echo "  list                  List available backups"
        echo "  restore-dotfiles      Restore dotfiles from backup"
        echo "  restore-configs       Restore configs from backup"
        echo "  cleanup [count]       Remove old backups (keep last N)"
        exit 1
        ;;
esac