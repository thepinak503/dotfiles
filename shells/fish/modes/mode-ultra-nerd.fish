#!/usr/bin/env fish
# =============================================================================
# ULTRA-NERD MODE - Maximum productivity
# =============================================================================

# Only load if mode is ultra-nerd
if not test "$DOTFILES_MODE" = "ultra-nerd"
    return 0
end

# Short aliases (some already in aliases, but ensure)
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'

# Quick navigation
abbr -a home 'cd ~'
abbr -a dl 'cd ~/Downloads'
abbr -a docs 'cd ~/Documents'

# File managers
if type -q ranger
    abbr -a r 'ranger'
end

if type -q nnn
    abbr -a n 'nnn'
end

# Development shortcuts
abbr -a v 'vim'
abbr -a sv 'sudo vim'

# Git shortcuts (some already in aliases)
abbr -a gst 'git status'
abbr -a gpl 'git pull'
abbr -a gps 'git push'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'

# Docker shortcuts (some already in aliases)
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'
abbr -a di 'docker images'
abbr -a dex 'docker exec -it'

# System shortcuts
abbr -a update 'sudo apt update && sudo apt upgrade -y'
abbr -a upgrade 'update'
abbr -a cleanup 'sudo apt autoremove -y'

# Network
abbr -a ping 'ping -c 5'
abbr -a fastping 'ping -c 100 -s.2'

# Process
abbr -a psg 'ps aux | grep -v grep | grep -i'

# History
abbr -a h 'history'
abbr -a hg 'history | grep'

# Quick edit
abbr -a bconf '$EDITOR ~/.config/fish/config.fish'
abbr -a sfc 'source ~/.config/fish/config.fish'
abbr -a reload 'source ~/.config/fish/config.fish'
