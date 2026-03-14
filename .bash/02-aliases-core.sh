#!/usr/bin/env bash
# =============================================================================
# 02-ALIASES-CORE.SH - Additional Essential Aliases
# Unique aliases not covered in unified aliases
# =============================================================================

# =============================================================================
# NAVIGATION (additional)
# =============================================================================
alias bd='cd "$OLDPWD"'

# =============================================================================
# LISTING (additional eza variants)
# =============================================================================
if command -v eza &>/dev/null; then
    alias llt='eza -laT --level=2 --icons'
    alias lsize='eza -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons'
    alias lext='eza -la --sort=extension --icons'
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
alias gi='grep -i'
alias gv='grep -v'

# =============================================================================
# FILE VIEWING
# =============================================================================
alias catn='cat -n'
alias less='less -R'
alias more='less'
alias tailf='tail -f'

# =============================================================================
# SYSTEM INFO
# =============================================================================
alias du='du -h'
alias du.='du -h --max-depth=1'
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

# =============================================================================
# SHELL SHORTCUTS
# =============================================================================
alias c='clear'
alias cls='clear'
alias j='jobs -l'
alias x='exit'
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
# GIT (additional)
# =============================================================================
alias gcam='git commit -a -m'
alias gf='git fetch'
alias gfa='git fetch --all'
alias glg='git log --graph --decorate --all'
alias gm='git merge'
alias gpf='git push --force-with-lease'
alias gpr='git pull --rebase'
alias gr='git remote -v'
alias gst='git status'
alias gundo='git reset HEAD~1 --mixed'

# =============================================================================
# HELP & INFO
# =============================================================================
alias helpme='man'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias functions='declare -f | grep -E "^[a-z].*\(\)"'
alias aliases='alias | sort'
