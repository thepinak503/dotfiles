#!/usr/bin/env fish
# =============================================================================
# DOTFILES - FISH SHELL CONFIGURATION
# The Ultimate Universal Shell Configuration for Fish
# =============================================================================

# Suppress errors globally
set -g __fish_suppress_errors 1

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
end 2>/dev/null

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
    source "$DOTFILES_DIR/fish/conf.d/aliases.fish" 2>/dev/null
end

# Source functions
if test -d "$DOTFILES_DIR/fish/functions"
    for func in "$DOTFILES_DIR"/fish/functions/*.fish
        source $func 2>/dev/null
    end
end

# Source development tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/fish/conf.d/development.fish"
        source "$DOTFILES_DIR/fish/conf.d/development.fish" 2>/dev/null
    end
end

# Source modern tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/fish/conf.d/modern-tools.fish"
        source "$DOTFILES_DIR/fish/conf.d/modern-tools.fish" 2>/dev/null
    end
end

# =============================================================================
# DISTRO DETECTION
# =============================================================================

if test -f /etc/os-release
    # Read os-release safely
    while read -l line
        if string match -q "ID=*" $line
            set -gx DISTRO_ID (string replace "ID=" "" $line | string lower)
        else if string match -q "NAME=*" $line
            set -gx DISTRO_NAME (string replace "NAME=" "" $line | string trim -c '"')
        end
    end </etc/os-release 2>/dev/null
    
    # Package manager detection
    switch "$DISTRO_ID"
        case arch manjaro endeavouros garuda
            set -gx PKG_MANAGER pacman
        case debian ubuntu pop
            set -gx PKG_MANAGER apt
        case fedora rhel centos rocky almalinux
            set -gx PKG_MANAGER dnf
        case opensuse-tumbleweed opensuse-leap
            set -gx PKG_MANAGER zypper
        case alpine
            set -gx PKG_MANAGER apk
        case '*'
            set -gx PKG_MANAGER unknown
    end
end 2>/dev/null

# =============================================================================
# MODERN TOOL INITIALIZATION
# =============================================================================

# Starship
if command -v starship >/dev/null 2>&1
    starship init fish | source 2>/dev/null
end

# Zoxide
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source 2>/dev/null
end

# FZF key bindings
if command -v fzf >/dev/null 2>&1
    fzf --fish | source 2>/dev/null
end

# =============================================================================
# ABBREVIATIONS (Fish-style aliases)
# =============================================================================

# Navigation
abbr -a .. 'cd ..' 2>/dev/null
abbr -a ... 'cd ../..' 2>/dev/null
abbr -a .... 'cd ../../..' 2>/dev/null
abbr -a ..... 'cd ../../../..' 2>/dev/null
abbr -a -- - 'cd -' 2>/dev/null

# Listing
abbr -a l 'ls -la' 2>/dev/null
abbr -a ll 'ls -l' 2>/dev/null
abbr -a la 'ls -A' 2>/dev/null
abbr -a lt 'ls -laT' 2>/dev/null

# Safety
abbr -a cp 'cp -i' 2>/dev/null
abbr -a mv 'mv -i' 2>/dev/null
abbr -a rm 'rm -i' 2>/dev/null

# Git
abbr -a g 'git' 2>/dev/null
abbr -a ga 'git add' 2>/dev/null
abbr -a gaa 'git add --all' 2>/dev/null
abbr -a gc 'git commit' 2>/dev/null
abbr -a gcm 'git commit -m' 2>/dev/null
abbr -a gco 'git checkout' 2>/dev/null
abbr -a gd 'git diff' 2>/dev/null
abbr -a gl 'git log --oneline --graph --decorate' 2>/dev/null
abbr -a gp 'git push' 2>/dev/null
abbr -a gpl 'git pull' 2>/dev/null
abbr -a gs 'git status -sb' 2>/dev/null

# Docker
abbr -a d 'docker' 2>/dev/null
abbr -a dc 'docker-compose' 2>/dev/null
abbr -a dps 'docker ps' 2>/dev/null
abbr -a di 'docker images' 2>/dev/null

# Kubernetes
abbr -a k 'kubectl' 2>/dev/null
abbr -a kg 'kubectl get' 2>/dev/null
abbr -a kd 'kubectl describe' 2>/dev/null
abbr -a kl 'kubectl logs' 2>/dev/null

# System
abbr -a c 'clear' 2>/dev/null
abbr -a e 'exit' 2>/dev/null
abbr -a v '$EDITOR' 2>/dev/null

# =============================================================================
# WELCOME MESSAGE (DISABLED)
# =============================================================================
# Welcome message removed for cleaner startup

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish 2>/dev/null
end

# =============================================================================
# FASTFETCH (if installed)
# =============================================================================

if command -v fastfetch >/dev/null 2>&1
    fastfetch 2>/dev/null
end

thefuck --alias | source
