#!/usr/bin/env fish
# =============================================================================
# DOTFILES - FISH SHELL CONFIGURATION
# The Ultimate Universal Shell Configuration for Fish
# =============================================================================

# =============================================================================
# CONFIGURATION
# =============================================================================

# Set dotfiles mode (basic, advanced, ultra-nerd)
set -gx DOTFILES_MODE (test -n "$DOTFILES_MODE"; and echo "$DOTFILES_MODE"; or echo "advanced")
set -gx DOTFILES_DIR (test -n "$DOTFILES_DIR"; and echo "$DOTFILES_DIR"; or echo "$HOME/.dotfiles")

# =============================================================================
# CORE ENVIRONMENT
# =============================================================================

# XDG directories
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Editor preference
if command -v nvim >/dev/null 2>&1
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if command -v vim >/dev/null 2>&1
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR nano
    set -gx VISUAL nano
end

# Pager
set -gx PAGER less
set -gx LESS "-R -i -g -c -W -F -X -M --shift 5"

# Locale
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Terminal
set -gx TERM xterm-256color
set -gx COLORTERM truecolor

# Disable annoying prompts
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
set -gx NPM_CONFIG_UPDATE_NOTIFIER false
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ENV_HINTS 1

# =============================================================================
# PATH MANAGEMENT
# =============================================================================

function add_to_path -a dir
    if test -d $dir; and not contains $dir $PATH
        set -gx PATH $dir $PATH
    end
end

# User-local binaries
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$HOME/.npm-global/bin"
add_to_path "$HOME/.poetry/bin"
add_to_path "$HOME/go/bin"
add_to_path "/snap/bin"
add_to_path "/var/lib/flatpak/exports/bin"

# =============================================================================
# FZF CONFIGURATION
# =============================================================================

set -gx FZF_DEFAULT_OPTS "
  --height=60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --bind='pgdn:preview-page-down,pgup:preview-page-up'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0'
  --color='pointer:#c586c0,marker:#ce9178,spinner:#569cd6,header:#4ec9b0'
"

# =============================================================================
# LOAD DOTFILES COMPONENTS
# =============================================================================

# Source core aliases
if test -f "$DOTFILES_DIR/fish/conf.d/aliases.fish"
    source "$DOTFILES_DIR/fish/conf.d/aliases.fish"
end

# Source functions
if test -d "$DOTFILES_DIR/fish/functions"
    for func in "$DOTFILES_DIR"/fish/functions/*.fish
        source $func
    end
end

# Source development tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/fish/conf.d/development.fish"
        source "$DOTFILES_DIR/fish/conf.d/development.fish"
    end
end

# Source modern tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/fish/conf.d/modern-tools.fish"
        source "$DOTFILES_DIR/fish/conf.d/modern-tools.fish"
    end
end

# =============================================================================
# DISTRO DETECTION
# =============================================================================

if test -f /etc/os-release
    source /etc/os-release
    set -gx DISTRO_ID $ID
    set -gx DISTRO_NAME $NAME
    
    # Package manager detection
    switch $ID
        case arch manjaro endeavouros
            set -gx PKG_MANAGER pacman
        case debian ubuntu
            set -gx PKG_MANAGER apt
        case fedora rhel centos
            set -gx PKG_MANAGER dnf
        case opensuse-tumbleweed opensuse-leap
            set -gx PKG_MANAGER zypper
        case alpine
            set -gx PKG_MANAGER apk
    end
end

# =============================================================================
# MODERN TOOL INITIALIZATION
# =============================================================================

# Starship
if command -v starship >/dev/null 2>&1
    starship init fish | source
end

# Zoxide
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end

# FZF key bindings
if command -v fzf >/dev/null 2>&1
    fzf --fish | source
end

# =============================================================================
# ABBREVIATIONS (Fish-style aliases)
# =============================================================================

# Navigation
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a -- - 'cd -'

# Listing
abbr -a l 'ls -la'
abbr -a ll 'ls -l'
abbr -a la 'ls -A'
abbr -a lt 'ls -laT'

# Safety
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'
abbr -a rm 'rm -i'

# Git
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gl 'git log --oneline --graph --decorate'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
abbr -a gs 'git status -sb'

# Docker
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'
abbr -a di 'docker images'

# Kubernetes
abbr -a k 'kubectl'
abbr -a kg 'kubectl get'
abbr -a kd 'kubectl describe'
abbr -a kl 'kubectl logs'

# System
abbr -a c 'clear'
abbr -a e 'exit'
abbr -a v '$EDITOR'

# =============================================================================
# WELCOME MESSAGE
# =============================================================================

switch $DOTFILES_MODE
    case "ultra-nerd"
        echo -e "\033[38;5;82m✓ Dotfiles loaded in \033[1mULTRA-NERD\033[0m\033[38;5;82m mode (Fish)\033[0m"
    case "basic"
        echo -e "\033[38;5;33m✓ Dotfiles loaded in \033[1mBASIC\033[0m\033[38;5;33m mode (Fish)\033[0m"
    case '*'
        echo -e "\033[38;5;208m✓ Dotfiles loaded in \033[1mADVANCED\033[0m\033[38;5;208m mode (Fish)\033[0m"
end

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end
