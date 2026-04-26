#!/usr/bin/env bash
# =============================================================================
# Debian/Ubuntu - APT aliases
# Only loads on Debian-based distros
# =============================================================================

[ "$DOTFILES_DISTRO" = "debian" ] || [ "$DOTFILES_DISTRO" = "ubuntu" ] || [ "$DOTFILES_DISTRO" = "linuxmint" ] || [ "$DOTFILES_DISTRO" = "pop" ] || [ "$DOTFILES_DISTRO" = "zorin" ] && {

# APT aliases
alias aptup='sudo apt update && sudo apt upgrade'
alias aptin='sudo apt install'
alias aptr='sudo apt remove'
alias apts='apt search'
alias aptq='dpkg -l'
alias aptshow='apt show'
alias aptfiles='dpkg -L'
alias aptown='dpkg -S'
alias aptclean='sudo apt autoremove && sudo apt autoclean'
alias aptfix='sudo apt install -f'
alias aptdl='apt download'
alias aptlist='apt list'
alias aptpolicy='apt policy'

# APT functions
aptinfo() { apt show "$@"; }
aptsearch() { apt search "$@" | less; }
aptinstall() { sudo apt install "$@"; }
aptremove() { sudo apt remove "$@"; }
aptupdate() { sudo apt update; }
aptupgrade() { sudo apt upgrade; }
aptfull() { sudo apt update && sudo apt upgrade -y; }
aptclean() { sudo apt autoremove && sudo apt autoclean; }
aptfix() { sudo dpkg --configure -a && sudo apt install -f; }

# Add-apt-repository
command -v add-apt-repository >/dev/null 2>&1 && {
    alias aptrepo='add-apt-repository'
}

echo "[dotfiles] Debian/Ubuntu aliases loaded"
}