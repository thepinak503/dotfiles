#!/usr/bin/env bash
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border=rounded --color='bg+:#3c3c3c,fg+:#ffffff,hl:#569cd6,hl+:#569cd6'"
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f -not -path '*/\.*'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d -not -path '*/\.*'"
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi
alias ports='netstat -tulanp 2>/dev/null || ss -tuln'
alias ipl='ip -br link 2>/dev/null'
alias ipa='ip -br addr 2>/dev/null'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias path='echo $PATH | tr ":" "\n" | nl'
alias gaa='git add --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstd='git stash drop'
if command -v docker &>/dev/null; then
    alias dprune='docker system prune -af'
    alias dlog='docker logs -f'
fi
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:ignorespace
shopt -s autocd 2>/dev/null
shopt -s cdspell 2>/dev/null
