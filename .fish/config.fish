#!/usr/bin/env fish
# =============================================================================
# FISH MAIN CONFIGURATION
# Simplified with 3 tiers: basic, advanced, ultra-nerd
# =============================================================================

# Fastfetch on start (if installed)
if type -q fastfetch
    fastfetch 2>/dev/null
end

# Mode
set -gx DOTFILES_MODE (test -n "$DOTFILES_MODE"; and echo "$DOTFILES_MODE"; or echo "advanced")
set -gx DOTFILES_DIR (test -n "$DOTFILES_DIR"; and echo "$DOTFILES_DIR"; or echo "$HOME/.dotfiles")

# Enable autocd
set -g autocd true

# XDG
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Editor
if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if type -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR nano
    set -gx VISUAL nano
end
set -gx PAGER less

# PATH
fish_add_path "$HOME/.local/bin" 2>/dev/null
fish_add_path "$HOME/.cargo/bin" 2>/dev/null

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

# LS
if type -q eza
    abbr -a ls 'eza --icons --group-directories-first'
    abbr -a ll 'eza -l --icons --group-directories-first'
    abbr -a la 'eza -la --icons --group-directories-first'
    abbr -a lt 'eza --tree --level=2 --icons'
else
    abbr -a ls 'ls --color=auto'
    abbr -a ll 'ls -lh'
end

# CAT
if type -q bat
    abbr -a cat 'bat --style=auto'
end

# Navigation
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

# Clear
abbr -a c 'clear'
abbr -a cl 'clear'
abbr -a cls 'clear'

# Git
abbr -a g 'git'
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git pull'

# Docker
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'

# Safety
abbr -a rm 'rm -i'
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'

# -----------------------------------------------------------------------------
# MODERN TOOLS (Advanced mode)
# -----------------------------------------------------------------------------

if test "$DOTFILES_MODE" != "basic"
    # Starship
    if type -q starship
        starship init fish | source
    end
    
    # Zoxide
    if type -q zoxide
        zoxide init fish | source
    end
    
    # FZF
    if type -q fzf
        fzf --fish | source
    end
end

# -----------------------------------------------------------------------------
# SCRIPTS
# -----------------------------------------------------------------------------

abbr -a install-shells 'fish ~/.dotfiles/scripts/install_shell_support.fish'
abbr -a dotfiles-update 'source ~/.dotfiles/scripts/autoupdate.fish; dotfiles_update'
abbr -a dotfiles-status 'cd ~/.dotfiles; and git status'

# -----------------------------------------------------------------------------
# LOCAL
# -----------------------------------------------------------------------------

if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end
