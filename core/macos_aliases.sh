#!/usr/bin/env bash
# =============================================================================
# macOS - Homebrew aliases
# Only loads on macOS
# =============================================================================

_is_macos() {
    [ "$DOTFILES_DISTRO" = "macos" ]
}

if _is_macos; then
    # Homebrew aliases
    alias brewup='brew update && brew upgrade'
    alias brewin='brew install'
    alias brewrm='brew uninstall'
    alias brews='brew search'
    alias brewq='brew list'
    alias brewli='brew leaves'
    alias brewdeps='brew deps'
    alias brewc='brew cleanup'
    alias brewinfo='brew info'
    alias brewdo='brew doctor'
    alias brewpin='brew pin'
    alias brewunpin='brew unpin'
    alias brewupg='brew upgrade'
    alias brewlink='brew link'
    
    # Homebrew functions
    brewinstall() {
        brew install "$@"
    }
    
    brewremove() {
        brew uninstall "$@"
    }
    
    brewupdate() {
        brew update
    }
    
    brewupgrade() {
        brew upgrade
    }
    
    brewclean() {
        brew cleanup
    }
    
    brewsearch() {
        brew search "$@"
    }
    
    brewinfo() {
        brew info "$@"
    }
    
    brewcask() {
        brew install --cask "$@"
    }
    
    # Mac App Store
    if command -v mas >/dev/null 2>&1; then
        alias masin='mas install'
        alias masup='mas outdated'
    fi
    
    # MacPorts (if installed)
    if command -v port >/dev/null 2>&1; then
        alias portin='sudo port install'
        alias portrm='sudo port uninstall'
        alias portup='sudo port selfupdate && sudo port upgrade'
        alias ports='port search'
    fi
    
    echo "[dotfiles] macOS aliases loaded"
else
    echo "[dotfiles] This is for macOS only! Current: $DOTFILES_DISTRO"
fi