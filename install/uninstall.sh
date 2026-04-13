#!/bin/bash
set -e
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'
AUTO_YES=false
RESTORE=false
while [ $# -gt 0 ]; do
    case "$1" in
        --yes|-y) AUTO_YES=true ;;
        --restore) RESTORE=true ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "  --yes, -y    Auto-confirm"
            echo "  --restore    Restore from backup"
            exit 0
            ;;
    esac
    shift
done
[ ! -t 0 ] && AUTO_YES=true
banner() {
    clear
    echo -e "${CYAN}"
    echo "  ██████╗ ███████╗████████╗██████╗  ██████╗"
    echo "  ██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗"
    echo "  ██████╔╝█████╗     ██║   ██████╔╝██║   ██║"
    echo "  ██╔══██╗██╔══╝     ██║   ██╔══██╗██║   ██║"
    echo "  ██║  ██║███████╗    ██║   ██║  ██║╚██████╔╝"
    echo "  ╚═╝  ╚═╝╚══════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝"
    echo -e "${NC}"
    echo -e "  ${BOLD}Dotfiles Uninstaller v6.0.0${NC}"
    echo ""
}
info() { echo -e "  ${GREEN}✓${NC} $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; }
error() { echo -e "  ${RED}✗${NC} $1" >&2; }
main() {
    banner
    if [ "$RESTORE" = "true" ]; then
        info "Restoring from backup..."
        [ -d "$BACKUP_DIR" ] || { error "No backup found"; exit 1; }
        cp -r "$BACKUP_DIR/"* "$HOME/" 2>/dev/null || true
        info "Done!"
        exit 0
    fi
    echo "  This will remove dotfiles symlinks from your home."
    echo "  Backup location: $BACKUP_DIR"
    echo ""
    if [ "$AUTO_YES" != "true" ]; then
        echo -en "  Continue? [Y/n] "
        read -r r
        [[ "$r" =~ ^[nN]$ ]] && exit 0
    fi
    info "Removing symlinks..."
    rm -f "$HOME/.bashrc"
    rm -f "$HOME/.zshrc"
    rm -f "$HOME/.bash_profile"
    rm -f "$HOME/.config/starship.toml"
    rm -f "$HOME/.config/fish/config.fish"
    rm -f "$HOME/.config/dotfiles"
    info "Creating backup..."
    mkdir -p "$BACKUP_DIR"
    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$BACKUP_DIR/" || true
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR/" || true
    info "Done! Backup at: $BACKUP_DIR"
    echo ""
    echo "  Restart your shell to apply changes."
    echo ""
}
main
