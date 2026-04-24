#!/usr/bin/env zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
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
command -v fzf &>/dev/null && plugins+=(fzf)
command -v docker &>/dev/null && plugins+=(docker)
command -v kubectl &>/dev/null && plugins+=(kubectl)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"
for dir in "$ZSH/custom/plugins/zsh-syntax-highlighting" \
           "/usr/share/zsh/plugins/zsh-syntax-highlighting" \
           "/usr/share/zsh-syntax-highlighting"; do
    [[ -f "$dir/zsh-syntax-highlighting.zsh" ]] && source "$dir/zsh-syntax-highlighting.zsh" && break
done
for dir in "$ZSH/custom/plugins/zsh-autosuggestions" \
           "/usr/share/zsh/plugins/zsh-autosuggestions" \
           "/usr/share/zsh-autosuggestions"; do
    [[ -f "$dir/zsh-autosuggestions.zsh" ]] && source "$dir/zsh-autosuggestions.zsh" && break
done
autoload -Uz compinit
compinit -u 2>/dev/null || compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
