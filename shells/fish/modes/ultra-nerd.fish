#!/usr/bin/env fish
if not test "$DOTFILES_MODE" = "ultra-nerd"
    return 0
end
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a home 'cd ~'
abbr -a dl 'cd ~/Downloads'
abbr -a docs 'cd ~/Documents'
if type -q ranger
    abbr -a r 'ranger'
end
if type -q nnn
    abbr -a n 'nnn'
end
abbr -a v 'vim'
abbr -a sv 'sudo vim'
abbr -a gst 'git status'
abbr -a gpl 'git pull'
abbr -a gps 'git push'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'
abbr -a di 'docker images'
abbr -a dex 'docker exec -it'
abbr -a update 'sudo apt update && sudo apt upgrade -y'
abbr -a upgrade 'update'
abbr -a cleanup 'sudo apt autoremove -y'
abbr -a ping 'ping -c 5'
abbr -a fastping 'ping -c 100 -s.2'
abbr -a psg 'ps aux | grep -v grep | grep -i'
abbr -a h 'history'
abbr -a hg 'history | grep'
abbr -a bconf '$EDITOR ~/.config/fish/config.fish'
abbr -a sfc 'source ~/.config/fish/config.fish'
abbr -a reload 'source ~/.config/fish/config.fish'
