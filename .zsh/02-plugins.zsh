#!/usr/bin/env zsh
# =============================================================================
# ZSH PLUGINS
# Oh-My-Zsh and custom plugin loading
# =============================================================================

# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Base plugins
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

# Source Oh-My-Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Syntax highlighting
for dir in "$ZSH/custom/plugins/zsh-syntax-highlighting" \
           "/usr/share/zsh/plugins/zsh-syntax-highlighting" \
           "/usr/share/zsh-syntax-highlighting"; do
    [[ -f "$dir/zsh-syntax-highlighting.zsh" ]] && source "$dir/zsh-syntax-highlighting.zsh" && break
done

# Auto-suggestions
for dir in "$ZSH/custom/plugins/zsh-autosuggestions" \
           "/usr/share/zsh/plugins/zsh-autosuggestions" \
           "/usr/share/zsh-autosuggestions"; do
    [[ -f "$dir/zsh-autosuggestions.zsh" ]] && source "$dir/zsh-autosuggestions.zsh" && break
done

# Completion
autoload -Uz compinit
compinit -u 2>/dev/null || compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
