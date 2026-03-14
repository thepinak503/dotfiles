#!/usr/bin/env bash
# =============================================================================
# UNIFIED ALIASES - Modern CLI with Fallbacks
# Works across bash/zsh with graceful degradation
# =============================================================================

# -----------------------------------------------------------------------------
# LS ALTERNATIVES (eza → ls)
# -----------------------------------------------------------------------------
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza --tree --level=2 --icons'
    alias l.='eza -d --icons .*'
    alias llm='eza -l --sort=modified --icons'
elif command -v exa &>/dev/null; then
    alias ls='exa --icons --group-directories-first'
    alias ll='exa -l --icons --group-directories-first'
    alias la='exa -la --icons --group-directories-first'
    alias lt='exa --tree --level=2 --icons'
else
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls -lh --color=auto'
    alias la='ls -lAh --color=auto'
fi

# -----------------------------------------------------------------------------
# CAT ALTERNATIVES (bat → cat)
# -----------------------------------------------------------------------------
if command -v bat &>/dev/null; then
    alias cat='bat --style=auto --wrap=never'
fi

# -----------------------------------------------------------------------------
# FIND ALTERNATIVES (fd → find)
# -----------------------------------------------------------------------------
if command -v fd &>/dev/null; then
    alias find='fd'
fi

# -----------------------------------------------------------------------------
# GREP ALTERNATIVES (ripgrep)
# -----------------------------------------------------------------------------
if command -v rg &>/dev/null; then
    alias grep='rg --smart-case --hidden'
    alias ag='rg'
fi

# -----------------------------------------------------------------------------
# DIFF ALTERNATIVES (delta)
# -----------------------------------------------------------------------------
if command -v delta &>/dev/null; then
    alias diff='delta'
fi

# -----------------------------------------------------------------------------
# PROCESS ALTERNATIVES (procs)
# -----------------------------------------------------------------------------
if command -v procs &>/dev/null; then
    alias ps='procs --colour=auto'
fi

# -----------------------------------------------------------------------------
# NETWORK
# -----------------------------------------------------------------------------
alias ping='ping -c 5'
alias ip='ip -color=auto'

# -----------------------------------------------------------------------------
# SAFETY ALIASES
# -----------------------------------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# -----------------------------------------------------------------------------
# SHORTCUTS
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# -----------------------------------------------------------------------------
# GIT
# -----------------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'

# -----------------------------------------------------------------------------
# DOCKER
# -----------------------------------------------------------------------------
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# -----------------------------------------------------------------------------
# SYSTEM
# -----------------------------------------------------------------------------
alias update='sudo apt update && sudo apt upgrade -y'
alias upgrade='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y && sudo apt autoclean'
alias free='free -h'
alias df='df -h'

# -----------------------------------------------------------------------------
# EDITORS
# -----------------------------------------------------------------------------
alias v='vim'
alias vi='vim'

# -----------------------------------------------------------------------------
# MISC
# -----------------------------------------------------------------------------
alias h='history'
alias c='clear'
alias cl='clear'
alias cls='clear'

# -----------------------------------------------------------------------------
# FZF INTEGRATION
# -----------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    alias fzf-preview='fzf --preview "bat --style=numbers --color=always {}"'
fi

# -----------------------------------------------------------------------------
# YAZI FILE MANAGER
# -----------------------------------------------------------------------------
if command -v yazi &>/dev/null; then
    alias y='yazi'
fi
