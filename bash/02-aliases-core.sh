#!/usr/bin/env bash
# =============================================================================
# 02-ALIASES-CORE.SH - Essential Aliases (ALL MODES)
# These aliases work on all systems, basic tools only
# =============================================================================

# =============================================================================
# NAVIGATION
# =============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias bd='cd "$OLDPWD"'

# =============================================================================
# LISTING (Falls back gracefully)
# =============================================================================
if command -v eza &>/dev/null; then
    # Modern eza with all features
    alias ls='eza --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
    alias llt='eza -laT --level=2 --icons'
    alias l.='eza -d --icons .*'
    alias lsize='eza -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons'
    alias lext='eza -la --sort=extension --icons'
elif command -v exa &>/dev/null; then
    # Fallback to exa
    alias ls='exa --group-directories-first --icons'
    alias l='exa -la --group-directories-first --icons'
    alias la='exa -a --group-directories-first --icons'
    alias ll='exa -l --group-directories-first --icons'
    alias lt='exa --tree --level=2 --icons'
    alias l.='exa -d .*'
else
    # Standard ls with colors
    alias ls='ls --color=auto --group-directories-first 2>/dev/null || ls -G'
    alias l='ls -lah'
    alias la='ls -A'
    alias ll='ls -lh'
    alias lt='ls -R'
    alias l.='ls -d .*'
fi

# =============================================================================
# SAFETY & CONFIRMATIONS
# =============================================================================
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Safe deletion (use trash-cli if available)
if command -v trash &>/dev/null; then
    alias rm='trash -v'
    alias rmp='trash -v'
    alias rml='trash-list'
    alias rme='trash-empty'
fi

# =============================================================================
# FILE OPERATIONS
# =============================================================================
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'
alias cpv='cp -v'
alias mvv='mv -v'
alias rmv='rm -v'

# =============================================================================
# GREP & SEARCH
# =============================================================================
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Case insensitive grep
alias gi='grep -i'
alias gv='grep -v'

# =============================================================================
# FILE VIEWING
# =============================================================================
alias cat='bat --style=plain --paging=never 2>/dev/null || cat'
alias catn='cat -n'
alias less='less -R'
alias more='less'
alias tailf='tail -f'

# =============================================================================
# SYSTEM INFO
# =============================================================================
alias df='df -h'
alias du='du -h'
alias du.='du -h --max-depth=1'
alias dusort='du -h --max-depth=1 | sort -h'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i'
alias top='htop 2>/dev/null || top'

# =============================================================================
# DATE & TIME
# =============================================================================
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias today='date +"%Y-%m-%d"'
alias week='date +"%V"'
alias cal='cal -3'

# =============================================================================
# NETWORK
# =============================================================================
alias ping='ping -c 5'
alias fastping='ping -c 100 -i 0.2'
alias ports='netstat -tulanp 2>/dev/null || netstat -tulan'
alias wget='wget -c'

# =============================================================================
# TEXT EDITING
# =============================================================================
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'
alias nv='$EDITOR'
alias svi='sudo $EDITOR'

# =============================================================================
# SUDO SHORTCUTS
# =============================================================================
alias _='sudo'
alias please='sudo $(fc -ln -1)'
# Note: 'fuck' alias is provided by 'thefuck' tool if installed

# =============================================================================
# SHELL SHORTCUTS
# =============================================================================
alias c='clear'
alias cls='clear'
alias h='history'
alias j='jobs -l'
alias x='exit'
alias q='exit'
alias reload='source ~/.bashrc'
alias sbrc='source ~/.bashrc'

# =============================================================================
# PATH SHORTCUTS
# =============================================================================
alias home='cd ~'
alias desk='cd ~/Desktop 2>/dev/null || cd ~/desktop 2>/dev/null'
alias docs='cd ~/Documents 2>/dev/null || cd ~/documents 2>/dev/null'
alias dl='cd ~/Downloads 2>/dev/null || cd ~/downloads 2>/dev/null'
alias pics='cd ~/Pictures 2>/dev/null || cd ~/pictures 2>/dev/null'
alias vids='cd ~/Videos 2>/dev/null || cd ~/videos 2>/dev/null'
alias music='cd ~/Music 2>/dev/null || cd ~/music 2>/dev/null'

# =============================================================================
# COMMON FILE LOCATIONS
# =============================================================================
alias bconf='$EDITOR ~/.bashrc'
alias zconf='$EDITOR ~/.zshrc'
alias vconf='$EDITOR ~/.vimrc'
alias nconf='$EDITOR ~/.config/nvim/init.vim 2>/dev/null || $EDITOR ~/.vimrc'

# =============================================================================
# GIT ESSENTIALS (Minimal set)
# =============================================================================
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gl='git log --oneline --graph --decorate'
alias glg='git log --graph --decorate --all'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gr='git remote -v'
alias gs='git status -sb'
alias gst='git status'
alias gundo='git reset HEAD~1 --mixed'

# =============================================================================
# HELP & INFO
# =============================================================================
alias helpme='man'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias functions='declare -f | grep -E "^[a-z].*\(\)"'
alias aliases='alias | sort'

# Emoji picker and calculator
alias emoji='/home/pinak/.dotfiles/scripts/emoji-picker'
alias calc='/home/pinak/.dotfiles/scripts/calc'
