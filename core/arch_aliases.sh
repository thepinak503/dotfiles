#!/usr/bin/env bash
# =============================================================================
# Arch Linux - Pacman/Yay aliases
# Only loads on Arch-based distros
# =============================================================================

_is_arch() {
    [ "$DOTFILES_DISTRO" = "arch" ] || [ "$DOTFILES_DISTRO" = "artix" ] || [ "$DOTFILES_DISTRO" = "manjaro" ] || [ "$DOTFILES_DISTRO" = "endeavouros" ] || [ "$DOTFILES_DISTRO" = "garuda" ]
}

if _is_arch; then
    # Pacman aliases
    alias pacup='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacs='pacman -Ss'
    alias pacq='pacman -Qq'
    alias pacqi='pacman -Qi'
    alias pacls='pacman -Qql'
    alias pacown='pacman -Qo'
    alias pacexplicit='pacman -Qe'
    alias pacdeps='pacman -Qdt'
    alias pacsize='pacman -Qs'
    
    # Yay aliases (if installed)
    if command -v yay >/dev/null 2>&1; then
        alias yayi='yay -S'
        alias yayd='yay -R'
        alias yays='yay -Ss'
        alias yayup='yay -Syu'
        alias yayupg='yay -Syu --devel'
        alias yayin='yay -S --answerclean'
        alias yaycat='yay -Pc'
    fi
    
    # Functions
    pacinfo() {
        pacman -Si "$@"
    }
    
    pacfind() {
        pacman -Ss "$@" | less
    }
    
    pacinstall() {
        sudo pacman -S "$@"
    }
    
    pacremove() {
        sudo pacman -Rns "$@"
    }
    
    pacupdate() {
        sudo pacman -Syu
    }
    
    pacclean() {
        sudo pacman -Sc && sudo pacman -Scc
    }
    
    paclsremote() {
        pacman -Slq | grep "$@"
    }
    
    pacver() {
        pacman -V "$@"
    }
    
    # Chaotic AUR (if installed)
    if command -v chaotic-gl >/dev/null 2>&1; then
        alias cgi='chaotic-gl install'
        alias cgr='chaotic-gl remove'
        alias cgs='chaotic-gl search'
    fi
    
    echo "[dotfiles] Arch Linux aliases loaded"
else
    echo "[dotfiles] This is for Arch Linux only! Current: $DOTFILES_DISTRO"
fi