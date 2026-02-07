#!/usr/bin/env fish
# =============================================================================
# FISH ALIASES - Core abbreviations and aliases
# =============================================================================

# =============================================================================
# NAVIGATION
# =============================================================================

# Quick directory navigation
abbr -a home 'cd ~'
abbr -a desk 'cd ~/Desktop 2>/dev/null; or cd ~/desktop 2>/dev/null'
abbr -a docs 'cd ~/Documents 2>/dev/null; or cd ~/documents 2>/dev/null'
abbr -a dl 'cd ~/Downloads 2>/dev/null; or cd ~/downloads 2>/dev/null'
abbr -a pics 'cd ~/Pictures 2>/dev/null; or cd ~/pictures 2>/dev/null'
abbr -a vids 'cd ~/Videos 2>/dev/null; or cd ~/videos 2>/dev/null'
abbr -a music 'cd ~/Music 2>/dev/null; or cd ~/music 2>/dev/null'

# =============================================================================
# LISTING (Adaptive based on available tools)
# =============================================================================

if command -v eza >/dev/null 2>&1
    alias ls='eza --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
    alias lsize='eza -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons'
    alias lext='eza -la --sort=extension --icons'
else if command -v exa >/dev/null 2>&1
    alias ls='exa --group-directories-first --icons'
    alias l='exa -la --group-directories-first --icons'
    alias la='exa -a --group-directories-first --icons'
    alias ll='exa -l --group-directories-first --icons'
    alias lt='exa --tree --level=2 --icons'
else
    alias ls='ls --color=auto --group-directories-first'
    alias l='ls -lah'
    alias la='ls -A'
    alias ll='ls -lh'
end

# =============================================================================
# FILE OPERATIONS
# =============================================================================

abbr -a mkdir 'mkdir -pv'
alias cp='cp -i'
alias mv='mv -i'

# Safe deletion with trash-cli
if command -v trash >/dev/null 2>&1
    alias rm='trash -v'
else
    alias rm='rm -i'
end

# =============================================================================
# SEARCH & GREP
# =============================================================================

if command -v rg >/dev/null 2>&1
    alias grep='rg --color=always'
    alias grepi='rg -i'
    alias rgf='rg --files-with-matches'
else
    alias grep='grep --color=auto'
    alias grepi='grep -i'
end

# =============================================================================
# FILE VIEWING
# =============================================================================

if command -v bat >/dev/null 2>&1
    alias cat='bat --style=header,grid'
    alias catp='bat --style=plain --paging=never'
    alias catl='bat --style=header,grid --paging=always'
else if command -v batcat >/dev/null 2>&1
    alias cat='batcat --style=header,grid'
    alias bat='batcat'
end

alias less='less -R'
alias tailf='tail -f'

# =============================================================================
# SYSTEM INFO
# =============================================================================

abbr -a df 'df -h'
abbr -a du 'du -h'
abbr -a free 'free -h'
abbr -a ps 'ps auxf'

if command -v htop >/dev/null 2>&1
    alias top='htop'
end

# =============================================================================
# NETWORK
# =============================================================================

abbr -a ping 'ping -c 5'
abbr -a wget 'wget -c'

# =============================================================================
# DATE & TIME
# =============================================================================

abbr -a now 'date +"%Y-%m-%d %H:%M:%S"'
abbr -a today 'date +"%Y-%m-%d"'
abbr -a week 'date +%V'

# =============================================================================
# SHELL SHORTCUTS
# =============================================================================

abbr -a c 'clear'
abbr -a cls 'clear'
abbr -a h 'history'
abbr -a reload 'source ~/.config/fish/config.fish'
abbr -a sfish 'source ~/.config/fish/config.fish'

# =============================================================================
# EDITORS
# =============================================================================

abbr -a v '$EDITOR'
abbr -a vi '$EDITOR'
abbr -a vim '$EDITOR'
abbr -a nv 'nvim'

# =============================================================================
# SUDO
# =============================================================================

abbr -a _ 'sudo'
abbr -a please 'sudo (fc -ln -1)'
abbr -a fuck 'sudo (fc -ln -1)'

# =============================================================================
# CONFIG EDITING
# =============================================================================

abbr -a fconf '$EDITOR ~/.config/fish/config.fish'
abbr -a bconf '$EDITOR ~/.bashrc'
abbr -a zconf '$EDITOR ~/.zshrc'

# =============================================================================
# HELP
# =============================================================================

abbr -a helpme 'man'
abbr -a path 'echo $PATH | tr " " "\n"'
abbr -a aliases 'alias'
