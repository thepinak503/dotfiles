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
    alias lt='ls --color=auto -R'
fi

# -----------------------------------------------------------------------------
# CAT ALTERNATIVES (bat → cat)
# -----------------------------------------------------------------------------
if command -v bat &>/dev/null; then
    alias cat='bat --style=auto --wrap=never'
    alias catt='bat --style=plain --language=temp'
fi

# -----------------------------------------------------------------------------
# FIND ALTERNATIVES (fd → find)
# -----------------------------------------------------------------------------
if command -v fd &>/dev/null; then
    alias find='fd'
    alias ff='fd -e'
    alias ffind='fd -H -L'
fi

# -----------------------------------------------------------------------------
# GREP ALTERNATIVES (ripgrep)
# -----------------------------------------------------------------------------
if command -v rg &>/dev/null; then
    alias grep='rg --smart-case --hidden'
    alias ag='rg'
    alias ff='rg --files'
fi

# -----------------------------------------------------------------------------
# DIFF ALTERNATIVES (delta)
# -----------------------------------------------------------------------------
if command -v delta &>/dev/null; then
    alias diff='delta'
    alias gitdiff='git diff | delta'
    alias gitdiffc='git diff --cached | delta'
fi

# -----------------------------------------------------------------------------
# PROCESS ALTERNATIVES (procs, bottom)
# -----------------------------------------------------------------------------
if command -v procs &>/dev/null; then
    alias ps='procs --colour=auto'
    alias pss='procs --sortby PID'
elif command -v eza &>/dev/null; then
    alias ps='ps -eo user,pid,pcpu,pmem,etime,cmd --sort=-pcpu'
fi

if command -v btm &>/dev/null; then
    alias top='btm'
    alias htop='btm'
elif command -v htop &>/dev/null; then
    alias top='htop'
fi

# -----------------------------------------------------------------------------
# DU ALTERNATIVES (dust)
# -----------------------------------------------------------------------------
if command -v dust &>/dev/null; then
    alias du='dust -d 2'
    alias duu='dust -d 3'
fi

# -----------------------------------------------------------------------------
# DF ALTERNATIVES (duf)
# -----------------------------------------------------------------------------
if command -v duf &>/dev/null; then
    alias df='duf'
elif ! command -v duf &>/dev/null; then
    alias df='df -h'
fi

# -----------------------------------------------------------------------------
# CURL/WGET
# -----------------------------------------------------------------------------
if command -v httpie &>/dev/null; then
    alias http='httpie'
    alias curl='http'
fi

# -----------------------------------------------------------------------------
# NETWORK
# -----------------------------------------------------------------------------
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias ip='ip -color=auto'
alias ipl='ip -br link'
alias ipa='ip -br addr'

# -----------------------------------------------------------------------------
# SYSTEM (distro-aware)
# -----------------------------------------------------------------------------
# Detect distro and set package manager
_distro_update() {
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y
    elif command -v dnf &>/dev/null; then
        sudo dnf upgrade -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu
    elif command -v brew &>/dev/null; then
        brew update && brew upgrade
    fi
}

_distro_cleanup() {
    if command -v apt &>/dev/null; then
        sudo apt autoremove -y && sudo apt autoclean
    elif command -v dnf &>/dev/null; then
        sudo dnf autoremove -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -Scc
    fi
}

alias update='_distro_update'
alias upgrade='_distro_update'
alias cleanup='_distro_cleanup'

alias free='free -h'
alias meminfo='free -h && echo "" && cat /proc/meminfo'
alias cpuinfo='lscpu'
alias gpumeminfo='lsmem'

# -----------------------------------------------------------------------------
# SAFETY ALIASES
# -----------------------------------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias chown='chown -i'
alias chmod='chmod -i'

# -----------------------------------------------------------------------------
# SHORTCUTS
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# -----------------------------------------------------------------------------
# GIT
# -----------------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
alias gdm='git diff main'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gra='git remote add'
alias grr='git remote rm'
alias gcl='git clone'
alias gst='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# -----------------------------------------------------------------------------
# DOCKER
# -----------------------------------------------------------------------------
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dprune='docker system prune -af'
alias dstop='docker stop $(docker ps -aq)'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'

# -----------------------------------------------------------------------------
# KUBERNETES
# -----------------------------------------------------------------------------
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kx='kubectl exec -it'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias wlog='watch -n1 kubectl get pods'

# -----------------------------------------------------------------------------
# TMUX
# -----------------------------------------------------------------------------
alias t='tmux'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tk='tmux kill-session'
alias tn='tmux new-session -s'

# -----------------------------------------------------------------------------
# EDITORS
# -----------------------------------------------------------------------------
alias v='vim'
alias vi='vim'
alias nano='nano -c'
alias edit='vim'

# -----------------------------------------------------------------------------
# BROWSERS
# -----------------------------------------------------------------------------
alias ff='firefox'
alias chrome='google-chrome'
alias brave='brave-browser'

# -----------------------------------------------------------------------------
# MISC
# -----------------------------------------------------------------------------
alias path='echo $PATH | tr ":" "\n" | nl'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias cnt='find . -type f -name "*" | wc -l'
alias h='history'
alias j='jobs'
alias c='clear'
alias cl='clear'
alias cls='clear'
alias please='sudo'
alias plz='sudo'
alias q='exit'

# -----------------------------------------------------------------------------
# FZF INTEGRATION
# -----------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    alias fzf-preview='fzf --preview "bat --style=numbers --color=always {}"'
    alias fzf-files='fzf --print0 | xargs -0 -o git ls-files'
    alias fzf-edit='vim $(fzf)'
fi

# -----------------------------------------------------------------------------
# TLDRAI
# -----------------------------------------------------------------------------
if command -v tldr &>/dev/null; then
    alias help='tldr'
fi

# -----------------------------------------------------------------------------
# YAZI FILE MANAGER
# -----------------------------------------------------------------------------
if command -v yazi &>/dev/null; then
    alias y='yazi'
    alias yy='yazi --cwd-file'
fi

# -----------------------------------------------------------------------------
# ZELLIJ TMUX ALTERNATIVE
# -----------------------------------------------------------------------------
if command -v zellij &>/dev/null; then
    alias zl='zellij'
    alias zla='zellij attach'
fi

# -----------------------------------------------------------------------------
# ATUIN HISTORY
# -----------------------------------------------------------------------------
if command -v atuin &>/dev/null; then
    alias history='atuin search'
fi
