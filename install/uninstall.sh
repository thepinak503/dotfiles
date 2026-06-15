#!/usr/bin/env sh
set -euo pipefail
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"
if [ -t 1 ]; then
    RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m'
    CYAN='\033[0;36m' BOLD='\033[1m' NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' CYAN='' BOLD='' NC=''
fi
AUTO_YES=false
RESTORE=false
RESTORE_PATH=""
while [ $# -gt 0 ]; do
    case "$1" in
        --yes|-y) AUTO_YES=true ;;
        --restore)
            RESTORE=true
            RESTORE_PATH="${2:-}"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "  --yes, -y           Auto-confirm"
            echo "  --restore [PATH]    Restore from backup (list available if no PATH given)"
            echo "  -h, --help          Show this help"
            exit 0
            ;;
    esac
    shift
done
[ ! -t 0 ] && AUTO_YES=true
info() { printf "  ${GREEN}✓${NC} %s\n" "$1"; }
warn() { printf "  ${YELLOW}⚠${NC} %s\n" "$1"; }
error() { printf "  ${RED}✗${NC} %s\n" "$1" >&2; }

_is_dotfiles_link() {
    [ -L "$1" ] && readlink "$1" | grep -q "$DOTFILES_DIR"
}

_remove_dotfiles_link() {
    if [ -L "$1" ] && _is_dotfiles_link "$1"; then
        rm -f "$1"
        info "Removed symlink: $1"
    elif [ -f "$1" ] || [ -d "$1" ]; then
        warn "Skipping $1 (not a dotfiles symlink)"
    fi
}

_list_managed_links() {
    find "$HOME" -maxdepth 1 -type l 2>/dev/null | while read -r link; do
        _is_dotfiles_link "$link" && echo "$link"
    done
    find "$HOME/.config" -type l 2>/dev/null | while read -r link; do
        _is_dotfiles_link "$link" && echo "$link"
    done
}

printf "${CYAN}${BOLD}"
printf "  ┌───────────────────────────────────────────┐\n"
printf "  │       DOTFILES UNINSTALLER v2.0           │\n"
printf "  └───────────────────────────────────────────┘\n"
printf "${NC}\n"

if [ "$RESTORE" = "true" ]; then
    if [ -z "$RESTORE_PATH" ]; then
        printf "  Available backups:\n"
        found=false
        for d in "$HOME"/.dotfiles-backup-*; do
            [ -d "$d" ] && printf "  ${GREEN}✓${NC} %s\n" "$d" && found=true
        done
        $found || printf "  ${YELLOW}⚠${NC} No backups found.\n"
        exit 0
    fi
    [ -d "$RESTORE_PATH" ] || { error "Backup not found: $RESTORE_PATH"; exit 1; }
    info "Restoring from $RESTORE_PATH..."
    for f in "$RESTORE_PATH"/*; do
        [ -f "$f" ] || continue
        fname=$(basename "$f")
        cp "$f" "$HOME/$fname" 2>/dev/null || true
    done
    info "Restored from backup. Restart your shell."
    exit 0
fi

printf "  This will remove all dotfiles symlinks from your home.\n"
printf "  Backup location: ${YELLOW}%s${NC}\n" "$BACKUP_DIR"
printf "\n"

if [ "$AUTO_YES" != "true" ]; then
    printf "  Continue? [Y/n] "
    read -r r
    case "$r" in [nN]|[nN][oO]) exit 0;; esac
fi

# Backup FIRST
info "Creating backup..."
mkdir -p "$BACKUP_DIR"
_list_managed_links | while read -r link; do
    target=$(readlink "$link")
    if [ -f "$target" ]; then
        cp "$target" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done
info "Backup saved to $BACKUP_DIR"

# Remove symlinks
info "Removing dotfiles symlinks..."
_list_managed_links | while read -r link; do
    _remove_dotfiles_link "$link"
done

# Clean dotfiles directory (ask first)
printf "\n  Remove dotfiles repository at ${YELLOW}%s${NC}? [y/N] " "$DOTFILES_DIR"
read -r r
case "$r" in [yY]|[yY][eE][sS])
    rm -rf "$DOTFILES_DIR"
    info "Removed $DOTFILES_DIR"
    ;;
esac

printf "\n${GREEN}${BOLD}  ✓ Done! Restart your shell to apply changes.${NC}\n"
printf "  Backup at: ${YELLOW}%s${NC}\n" "$BACKUP_DIR"
printf "  Restore with: ${CYAN}%s --restore %s${NC}\n" "$0" "$BACKUP_DIR"
echo ""
