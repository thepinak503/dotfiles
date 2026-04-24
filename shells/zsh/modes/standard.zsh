#!/usr/bin/env zsh
# Completion already initialized in top-level .zshrc; avoid re-running compinit here to save startup time
HISTSIZE=10000
SAVEHIST=10000
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
setopt AUTO_CD
setopt CD_SILENT
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)" 2>/dev/null
fi
