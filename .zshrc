#!/usr/bin/env zsh
# =============================================================================
# DOTFILES - ZSH CONFIGURATION
# Universal Zsh configuration with Oh-My-Zsh integration
# =============================================================================

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme - let Starship handle the prompt
ZSH_THEME="robbyrussell"

# Dotfiles mode (basic, advanced, ultra-nerd)
export DOTFILES_MODE="${DOTFILES_MODE:-advanced}"
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# =============================================================================
# PLUGINS
# =============================================================================
plugins=(
    git
    sudo
    history
    colored-man-pages
    command-not-found
    copypath
    copyfile
    dirhistory
    jsontools
    web-search
    z
)

# Conditional plugins
command -v fzf &>/dev/null && plugins+=(fzf)
command -v docker &>/dev/null && plugins+=(docker)
command -v kubectl &>/dev/null && plugins+=(kubectl)

# Add zsh-syntax-highlighting if available
if [[ -d $ZSH/custom/plugins/zsh-syntax-highlighting ]] || \
   [[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] || \
   [[ -d /usr/share/zsh-syntax-highlighting ]]; then
    plugins+=(zsh-syntax-highlighting)
fi

# Add zsh-autosuggestions if available
if [[ -d $ZSH/custom/plugins/zsh-autosuggestions ]] || \
   [[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] || \
   [[ -d /usr/share/zsh-autosuggestions ]]; then
    plugins+=(zsh-autosuggestions)
fi

# Source Oh-My-Zsh if it exists
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# LOAD DOTFILES BASH COMPONENTS (shared)
# =============================================================================

# Source core environment
[[ -f "$DOTFILES_DIR/bash/00-core.sh" ]] && source "$DOTFILES_DIR/bash/00-core.sh"

# Source functions
[[ -f "$DOTFILES_DIR/bash/01-functions.sh" ]] && source "$DOTFILES_DIR/bash/01-functions.sh"

# Source aliases based on mode
[[ -f "$DOTFILES_DIR/bash/02-aliases-core.sh" ]] && source "$DOTFILES_DIR/bash/02-aliases-core.sh"

if [[ "$DOTFILES_MODE" != "basic" ]]; then
    [[ -f "$DOTFILES_DIR/bash/03-aliases-extended.sh" ]] && source "$DOTFILES_DIR/bash/03-aliases-extended.sh"
fi

if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    [[ -f "$DOTFILES_DIR/bash/04-aliases-nerd.sh" ]] && source "$DOTFILES_DIR/bash/04-aliases-nerd.sh"
fi

# Source distro detection and package managers
[[ -f "$DOTFILES_DIR/bash/05-distro-detection.sh" ]] && source "$DOTFILES_DIR/bash/05-distro-detection.sh"
[[ -f "$DOTFILES_DIR/bash/06-package-managers.sh" ]] && source "$DOTFILES_DIR/bash/06-package-managers.sh"

# Source modern tools
[[ -f "$DOTFILES_DIR/bash/07-modern-tools.sh" ]] && source "$DOTFILES_DIR/bash/07-modern-tools.sh"

# Source development aliases
[[ -f "$DOTFILES_DIR/bash/08-development.sh" ]] && source "$DOTFILES_DIR/bash/08-development.sh"

# =============================================================================
# ZSH-SPECIFIC CONFIGURATION
# =============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Completion with security handling
autoload -Uz compinit
compinit -u 2>/dev/null || compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Syntax highlighting (if installed)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Auto-suggestions (if installed)
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# =============================================================================
# STARSHIP PROMPT
# =============================================================================
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# =============================================================================
# ZOXIDE
# =============================================================================
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# =============================================================================
# WELCOME MESSAGE
# =============================================================================
if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    echo -e "\033[38;5;82m✓ Dotfiles loaded in \033[1mULTRA-NERD\033[0m\033[38;5;82m mode (Zsh)\033[0m"
elif [[ "$DOTFILES_MODE" == "basic" ]]; then
    echo -e "\033[38;5;33m✓ Dotfiles loaded in \033[1mBASIC\033[0m\033[38;5;33m mode (Zsh)\033[0m"
else
    echo -e "\033[38;5;208m✓ Dotfiles loaded in \033[1mADVANCED\033[0m\033[38;5;208m mode (Zsh)\033[0m"
fi
