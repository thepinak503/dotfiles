#!/usr/bin/env fish
# =============================================================================
# FISH ALIASES - Core abbreviations and aliases with error suppression
# =============================================================================

# =============================================================================
# NAVIGATION
# =============================================================================

# Quick directory navigation
abbr -a home 'cd ~' 2>/dev/null
abbr -a desk 'cd ~/Desktop 2>/dev/null; or cd ~/desktop 2>/dev/null' 2>/dev/null
abbr -a docs 'cd ~/Documents 2>/dev/null; or cd ~/documents 2>/dev/null' 2>/dev/null
abbr -a dl 'cd ~/Downloads 2>/dev/null; or cd ~/downloads 2>/dev/null' 2>/dev/null
abbr -a pics 'cd ~/Pictures 2>/dev/null; or cd ~/pictures 2>/dev/null' 2>/dev/null
abbr -a vids 'cd ~/Videos 2>/dev/null; or cd ~/videos 2>/dev/null' 2>/dev/null
abbr -a music 'cd ~/Music 2>/dev/null; or cd ~/music 2>/dev/null' 2>/dev/null

# =============================================================================
# LISTING (Adaptive based on available tools)
# =============================================================================

if command -v eza >/dev/null 2>&1
    alias ls='eza --group-directories-first --icons' 2>/dev/null
    alias l='eza -la --group-directories-first --icons' 2>/dev/null
    alias la='eza -a --group-directories-first --icons' 2>/dev/null
    alias ll='eza -l --group-directories-first --icons' 2>/dev/null
    alias lt='eza --tree --level=2 --icons' 2>/dev/null
    alias lsize='eza -la --sort=size --reverse --icons' 2>/dev/null
    alias ltime='eza -la --sort=modified --reverse --icons' 2>/dev/null
    alias lext='eza -la --sort=extension --icons' 2>/dev/null
else if command -v exa >/dev/null 2>&1
    alias ls='exa --group-directories-first --icons' 2>/dev/null
    alias l='exa -la --group-directories-first --icons' 2>/dev/null
    alias la='exa -a --group-directories-first --icons' 2>/dev/null
    alias ll='exa -l --group-directories-first --icons' 2>/dev/null
    alias lt='exa --tree --level=2 --icons' 2>/dev/null
else
    alias ls='ls --color=auto --group-directories-first' 2>/dev/null
    alias l='ls -lah' 2>/dev/null
    alias la='ls -A' 2>/dev/null
    alias ll='ls -lh' 2>/dev/null
end

# =============================================================================
# FILE OPERATIONS
# =============================================================================

abbr -a mkdir 'mkdir -pv' 2>/dev/null
alias cp='cp -i' 2>/dev/null
alias mv='mv -i' 2>/dev/null

# Safe deletion with trash-cli
if command -v trash >/dev/null 2>&1
    alias rm='trash -v' 2>/dev/null
else
    alias rm='rm -i' 2>/dev/null
end

# =============================================================================
# SEARCH & GREP
# =============================================================================

if command -v rg >/dev/null 2>&1
    alias grep='rg --color=always' 2>/dev/null
    alias grepi='rg -i' 2>/dev/null
    alias rgf='rg --files-with-matches' 2>/dev/null
else
    alias grep='grep --color=auto' 2>/dev/null
    alias grepi='grep -i' 2>/dev/null
end

# =============================================================================
# FILE VIEWING
# =============================================================================

if command -v bat >/dev/null 2>&1
    alias cat='bat --style=header,grid' 2>/dev/null
    alias catp='bat --style=plain --paging=never' 2>/dev/null
    alias catl='bat --style=header,grid --paging=always' 2>/dev/null
else if command -v batcat >/dev/null 2>&1
    alias cat='batcat --style=header,grid' 2>/dev/null
    alias bat='batcat' 2>/dev/null
end

alias less='less -R' 2>/dev/null
alias tailf='tail -f' 2>/dev/null

# =============================================================================
# SYSTEM INFO
# =============================================================================

abbr -a df 'df -h' 2>/dev/null
abbr -a du 'du -h' 2>/dev/null
abbr -a free 'free -h' 2>/dev/null
abbr -a ps 'ps auxf' 2>/dev/null

if command -v htop >/dev/null 2>&1
    alias top='htop' 2>/dev/null
end

# =============================================================================
# NETWORK
# =============================================================================

abbr -a ping 'ping -c 5' 2>/dev/null
abbr -a wget 'wget -c' 2>/dev/null

# =============================================================================
# DATE & TIME
# =============================================================================

abbr -a now 'date +"%Y-%m-%d %H:%M:%S"' 2>/dev/null
abbr -a today 'date +"%Y-%m-%d"' 2>/dev/null
abbr -a week 'date +%V' 2>/dev/null

# =============================================================================
# SHELL SHORTCUTS
# =============================================================================

abbr -a c 'clear' 2>/dev/null
abbr -a cls 'clear' 2>/dev/null
abbr -a h 'history' 2>/dev/null
abbr -a reload 'source ~/.config/fish/config.fish' 2>/dev/null
abbr -a sfish 'source ~/.config/fish/config.fish' 2>/dev/null

# =============================================================================
# EDITORS
# =============================================================================

abbr -a v '$EDITOR' 2>/dev/null
abbr -a vi '$EDITOR' 2>/dev/null
abbr -a vim '$EDITOR' 2>/dev/null
abbr -a nv 'nvim' 2>/dev/null

# =============================================================================
# SUDO
# =============================================================================

abbr -a _ 'sudo' 2>/dev/null
abbr -a please 'sudo $history[1]' 2>/dev/null

# =============================================================================
# CONFIG EDITING
# =============================================================================

abbr -a fconf '$EDITOR ~/.config/fish/config.fish' 2>/dev/null
abbr -a bconf '$EDITOR ~/.bashrc' 2>/dev/null
abbr -a zconf '$EDITOR ~/.zshrc' 2>/dev/null

# =============================================================================
# HELP
# =============================================================================

abbr -a helpme 'man' 2>/dev/null
abbr -a path 'echo $PATH | tr " " "\n"' 2>/dev/null
abbr -a aliases 'alias' 2>/dev/null
