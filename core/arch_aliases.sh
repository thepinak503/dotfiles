#!/usr/bin/env bash
# =============================================================================
# Arch Linux - Pacman/Yay aliases
# Only loads on Arch-based distros
# =============================================================================

[ "$DOTFILES_DISTRO" = "arch" ] || [ "$DOTFILES_DISTRO" = "artix" ] || [ "$DOTFILES_DISTRO" = "manjaro" ] || [ "$DOTFILES_DISTRO" = "endeavouros" ] || [ "$DOTFILES_DISTRO" = "garuda" ] && {

# Pacman aliases
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacs='pacman -Ss'
alias pacq='pacman -Qq'
alias pacqi='pacman -Qi'
alias pacls='pacman -Qql'
alias pacown='pacman -Qo'
alias pacown='pacman -Qo'
alias pacdiff='pacman -Si'

# Pacman functions
pacinfo() { pacman -Si "$@"; }
pacfind() { pacman -Ss "$@" | less; }
pacinstall() { sudo pacman -S "$@"; }
pacremove() { sudo pacman -Rns "$@"; }
pacupdate() { sudo pacman -Syu; }
pacclean() { sudo pacman -Sc && sudo pacman -Scc; }
paclsremote() { pacman -Slq | grep "$@"; }
pacver() { pacman -V "$@"; }

# YAY aliases
alias yayi='yay -S'
alias yayu='yay -Syu'
alias yays='yay -Ss'
alias yayq='yay -Qq'
alias yayrm='yay -Rns'
alias yaycat='yay -Pc'

# YAY functions
yayinfo() { yay -Si "$@"; }
yayfind() { yay -Ss "$@"; }
yayinstall() { yay -S "$@"; }
yayremove() { yay -Rns "$@"; }
yayupdate() { yay -Syu; }

# Chaotic AUR (if installed)
command -v chaotic-gl >/dev/null 2>&1 && {
    alias cgi='chaotic-gl install'
    alias cgr='chaotic-gl remove'
    alias cgs='chaotic-gl search'
}

echo "[dotfiles] Arch Linux aliases loaded"
}