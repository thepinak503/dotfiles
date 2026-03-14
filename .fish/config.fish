#!/usr/bin/env fish
# =============================================================================
# DOTFILES - FISH SHELL CONFIGURATION
# The Ultimate Universal Shell Configuration for Fish
# =============================================================================

# Enable autocd - type directory name to cd into it (enabled by default in Fish)
set -g autocd true

# Run fastfetch on start (interactive only)
if type -q fastfetch
    fastfetch 2>/dev/null
end

# Suppress errors globally
set -g __fish_suppress_errors 1

# =============================================================================
# CONFIGURATION
# =============================================================================

# Set dotfiles mode (basic, advanced, ultra-nerd)
set -gx DOTFILES_MODE (test -n "$DOTFILES_MODE"; and echo "$DOTFILES_MODE"; or echo "advanced")
set -gx DOTFILES_DIR (test -n "$DOTFILES_DIR"; and echo "$DOTFILES_DIR"; or echo "$HOME/.dotfiles")

# Adjust path for .fish directory
set -gx DOTFILES_DIR_FISH "$DOTFILES_DIR/.fish"

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
if test -f "$DOTFILES_DIR/.fish/conf.d/aliases.fish"
    source "$DOTFILES_DIR/.fish/conf.d/aliases.fish" 2>/dev/null
end

# Source functions
if test -d "$DOTFILES_DIR/.fish/functions"
    for func in "$DOTFILES_DIR"/.fish/functions/*.fish
        source $func 2>/dev/null
    end
end

# Source keybindings
if test -f "$DOTFILES_DIR/.fish/conf.d/keybindings.fish"
    source "$DOTFILES_DIR/.fish/conf.d/keybindings.fish" 2>/dev/null
end

# Source development tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/.fish/conf.d/development.fish"
        source "$DOTFILES_DIR/.fish/conf.d/development.fish" 2>/dev/null
    end
end

# Source modern tools
if test "$DOTFILES_MODE" != "basic"
    if test -f "$DOTFILES_DIR/.fish/conf.d/modern-tools.fish"
        source "$DOTFILES_DIR/.fish/conf.d/modern-tools.fish" 2>/dev/null
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
# MODERN ALIASES (with fallbacks)
# =============================================================================

# LS alternatives (eza -> ls)
if type -q eza
    abbr -a ls 'eza --icons --group-directories-first'
    abbr -a ll 'eza -l --icons --group-directories-first'
    abbr -a la 'eza -la --icons --group-directories-first'
    abbr -a lt 'eza --tree --level=2 --icons'
    abbr -a l. 'eza -d --icons .*'
    abbr -a llm 'eza -l --sort=modified --icons'
else if type -q exa
    abbr -a ls 'exa --icons --group-directories-first'
    abbr -a ll 'exa -l --icons --group-directories-first'
    abbr -a la 'exa -la --icons --group-directories-first'
end

# CAT alternatives (bat -> cat)
if type -q bat
    abbr -a cat 'bat --style=auto --wrap=never'
end

# GREP alternatives (ripgrep)
if type -q rg
    abbr -a grep 'rg --smart-case --hidden'
    abbr -a ag 'rg'
end

# DIFF alternatives (delta)
if type -q delta
    abbr -a diff 'delta'
end

# PROCESS alternatives
if type -q procs
    abbr -a ps 'procs --colour=auto'
end

# DU alternatives
if type -q dust
    abbr -a du 'dust -d 2'
end

# DF alternatives
if type -q duf
    abbr -a df 'duf'
end

# Network
abbr -a ping 'ping -c 5'
abbr -a ports 'netstat -tulanp'
abbr -a ip 'ip -color=auto'

# System
abbr -a update 'sudo apt update && sudo apt upgrade -y'
abbr -a upgrade 'sudo apt update && sudo apt upgrade -y'
abbr -a cleanup 'sudo apt autoremove -y && sudo apt autoclean'
abbr -a df 'df -h'
abbr -a free 'free -h'

# Safety
abbr -a rm 'rm -i'
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'

# Navigation
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a -- - 'cd -'

# Git
abbr -a g 'git'
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gco 'git checkout'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
abbr -a gl 'git log --oneline --graph --decorate'
abbr -a gd 'git diff'
abbr -a gb 'git branch'
abbr -a gst 'git stash'

# Docker
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'
abbr -a di 'docker images'
abbr -a dex 'docker exec -it'

# Kubernetes
abbr -a k 'kubectl'
abbr -a kg 'kubectl get'
abbr -a kd 'kubectl describe'
abbr -a kl 'kubectl logs'

# Tmux
abbr -a t 'tmux'
abbr -a ta 'tmux attach'

# Editors
abbr -a v 'vim'
abbr -a vi 'vim'

# Misc
abbr -a path 'echo $PATH | tr ":" "\n" | nl'
abbr -a h 'history'
abbr -a c 'clear'
abbr -a cl 'clear'
abbr -a cls 'clear'
abbr -a please 'sudo'
abbr -a q 'exit'

# FZF
if type -q fzf
    abbr -a fzf-preview 'fzf --preview "bat --style=numbers --color=always {}"'
end

# Tldr
if type -q tldr
    abbr -a help 'tldr'
end

# Yazi
if type -q yazi
    abbr -a y 'yazi'
end

# Zellij
if type -q zellij
    abbr -a zl 'zellij'
end

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

if command -v thefuck >/dev/null 2>&1
    thefuck --alias | source 2>/dev/null
end

# =============================================================================
# FIND-THE-COMMAND (Arch Linux only)
# =============================================================================

if type -q ftc
    if test "$DISTRO_ID" = "arch" -o "$DISTRO_ID" = "manjaro" -o "$DISTRO_ID" = "endeavouros" -o "$DISTRO_ID" = "garuda"
        abbr -a ftc ftc
        abbr -a ftcs ftc search
        abbr -a ftci ftc info
        abbr -a ftcl ftc list
        abbr -a ftcf ftc find
    end
end

# =============================================================================
# INSTALL SHELL SUPPORT COMMAND
# =============================================================================

# Install shells command
abbr -a install-shells 'fish ~/.dotfiles/scripts/install_shell_support.fish'

# =============================================================================
# AUTO-UPDATE DOTFILES
# =============================================================================

# Source autoupdate script
if test -f "$HOME/.dotfiles/scripts/autoupdate.fish"
    source "$HOME/.dotfiles/scripts/autoupdate.fish" 2>/dev/null
end

# Manual update commands
abbr -a dotfiles-update 'source ~/.dotfiles/scripts/autoupdate.fish; dotfiles_update'
abbr -a dotfiles-status 'cd ~/.dotfiles; and git status'
