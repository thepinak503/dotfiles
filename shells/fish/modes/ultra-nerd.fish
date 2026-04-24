#!/usr/bin/env fish
# =============================================================================
# ULTRA-NERD MODE - Maximum productivity (Fish)
# =============================================================================

# Only load if mode is ultra-nerd
if not test "$DOTFILES_MODE" = "ultra-nerd"
    return 0
end

# -----------------------------------------------------------------------------
# SUPER QUICK NAVIGATION
# -----------------------------------------------------------------------------
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a home 'cd ~'
abbr -a dl 'cd ~/Downloads'
abbr -a docs 'cd ~/Documents'
abbr -a back 'cd -'

# -----------------------------------------------------------------------------
# FILE MANAGERS
# -----------------------------------------------------------------------------
if type -q yazi
    abbr -a y 'yazi'
end

if type -q ranger
    abbr -a r 'ranger'
end

if type -q nnn
    abbr -a n 'nnn'
end

# -----------------------------------------------------------------------------
# QUICK EDITOR ACCESS
# -----------------------------------------------------------------------------
abbr -a v 'nvim'
abbr -a sv 'sudo nvim'
abbr -a bconf '$EDITOR ~/.config/fish/config.fish'
abbr -a zconf '$EDITOR ~/.zshrc'
abbr -a sfc 'source ~/.config/fish/config.fish'
abbr -a reload 'source ~/.config/fish/config.fish'

# -----------------------------------------------------------------------------
# GIT POWER FEATURES
# -----------------------------------------------------------------------------
abbr -a gst 'git status'
abbr -a gpl 'git pull'
abbr -a gps 'git push'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gap 'git add -p'
abbr -a gundo 'git reset --soft HEAD~1'
abbr -a greset 'git reset --hard HEAD'
abbr -a gsm 'git stash push -m'
abbr -a glogstat 'git log --oneline --graph --decorate --stat'
abbr -a gbsort 'git branch --sort=-committerdate'

# -----------------------------------------------------------------------------
# DOCKER POWER FEATURES
# -----------------------------------------------------------------------------
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps'
abbr -a di 'docker images'
abbr -a dex 'docker exec -it'
abbr -a dcup 'docker-compose up -d'
abbr -a dcdn 'docker-compose down'
abbr -a dcrs 'docker-compose restart'
abbr -a dcls 'docker-compose logs -f'

# -----------------------------------------------------------------------------
# SYSTEM POWER FEATURES
# -----------------------------------------------------------------------------
abbr -a update 'sudo apt update && sudo apt upgrade -y'
abbr -a upgrade 'update'
abbr -a cleanup 'sudo apt autoremove -y'
abbr -a rmf 'rm -rf'
abbr -a cpf 'cp -rf'
abbr -a mvf 'mv -f'
abbr -a llh 'ls -lh'
abbr -a lla 'ls -la'
abbr -a meminfo 'free -h && cat /proc/meminfo'
abbr -a cpuinfo 'lscpu'
abbr -a diskinfo 'lsblk && echo "" && df -h'

# -----------------------------------------------------------------------------
# NETWORK
# -----------------------------------------------------------------------------
abbr -a ping 'ping -c 5'
abbr -a fastping 'ping -c 100 -s.2'

# -----------------------------------------------------------------------------
# PROCESS
# -----------------------------------------------------------------------------
abbr -a psg 'ps aux | grep -v grep | grep -i'
abbr -a killi 'kill -9'

# -----------------------------------------------------------------------------
# HISTORY
# -----------------------------------------------------------------------------
abbr -a h 'history'
abbr -a hg 'history | grep'

# -----------------------------------------------------------------------------
# DEVELOPER POWER FEATURES
# -----------------------------------------------------------------------------
abbr -a venv 'python3 -m venv'
abbr -a vact 'source .venv/bin/activate.fish'
abbr -a nrd 'npm run dev'
abbr -a nrs 'npm run start'
abbr -a nrb 'npm run build'
abbr -a crun 'cargo run'
abbr -a cbld 'cargo build'
abbr -a ctst 'cargo test'
abbr -a crel 'cargo run --release'
abbr -a gor 'go run .'
abbr -a gob 'go build .'
abbr -a got 'go test ./...'

# -----------------------------------------------------------------------------
# CONVENIENCE SHORTCUTS
# -----------------------------------------------------------------------------
abbr -a serve8000 'python3 -m http.server 8000'
abbr -a serve8080 'python3 -m http.server 8080'
abbr -a serve3000 'python3 -m http.server 3000'
abbr -a wtr 'curl -s wttr.in'
abbr -a wtrc 'curl -s wttr.in?format=3'

if type -q xclip
    abbr -a xcopy 'xclip -selection clipboard'
    abbr -a xpaste 'xclip -selection clipboard -o'
end

# -----------------------------------------------------------------------------
# QUICK EDIT CONFIGS
# -----------------------------------------------------------------------------
abbr -a editbash '$EDITOR ~/.bashrc'
abbr -a editzsh '$EDITOR ~/.zshrc'
abbr -a editfish '$EDITOR ~/.config/fish/config.fish'
abbr -a editgit '$EDITOR ~/.gitconfig'
abbr -a editstarship '$EDITOR ~/.config/starship.toml'