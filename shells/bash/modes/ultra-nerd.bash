#!/usr/bin/env bash
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -='cd -'
alias bconf='"$EDITOR" ~/.bashrc'
alias zconf='"$EDITOR" ~/.zshrc'
alias fconf='"$EDITOR" ~/.config/fish/config.fish'
alias sbrc='source ~/.bashrc'
alias reload='source ~/.bashrc'
alias psg='ps aux | grep -v grep | grep -i'
alias killi='kill -9'
if command -v pacman &>/dev/null; then
    alias install='sudo pacman -S'
    alias search='pacman -Ss'
    alias remove='sudo pacman -Rns'
    alias update='sudo pacman -Syu'
    alias list='pacman -Q'
elif command -v apt &>/dev/null; then
    alias install='sudo apt install'
    alias search='apt search'
    alias remove='sudo apt remove'
    alias update='sudo apt update && sudo apt upgrade'
    alias list='apt list --installed'
elif command -v dnf &>/dev/null; then
    alias install='sudo dnf install'
    alias search='dnf search'
    alias remove='sudo dnf remove'
    alias update='sudo dnf upgrade'
fi
if command -v yazi &>/dev/null; then
    function y() {
        local tmp; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        local cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd" || return
        fi
        rm -f -- "$tmp"
    }
fi
if command -v ranger &>/dev/null; then
    function ranger-cd() {
        local tempfile; tempfile="$(mktemp -t ranger-cd.XXXXXX)"
        ranger --choosedir="$tempfile" "$@"
        if [[ -f "$tempfile" ]]; then
            local dir; dir="$(<"$tempfile")"
            rm -f "$tempfile"
            if [[ -d "$dir" && "$dir" != "$PWD" ]]; then
                cd "$dir" || return
            fi
        fi
    }
    alias r=ranger-cd
fi
if command -v nnn &>/dev/null; then
    function nnn-cd() {
        nnn "$@"
        if [[ -f "$NNN_FIFO" ]]; then
            cd "$(cat "$NNN_FIFO")" || return
        fi
    }
    alias n=nnn-cd
fi
alias gap='git add -p'
alias gundo='git reset --soft HEAD~1'
alias greset='git reset --hard HEAD'
alias gsm='git stash push -m'
alias glogstat='git log --oneline --graph --decorate --stat'
alias gbsort='git branch --sort=-committerdate'
alias gcpush='git add -A && git commit -m'
alias rmf='rm -rf'
alias cpf='cp -rf'
alias mvf='mv -f'
alias llh='ls -lh'
alias lla='ls -la'
alias meminfo='free -h && echo "" && cat /proc/meminfo | head -20'
alias cpuinfo='lscpu'
alias diskinfo='lsblk && echo "" && df -h'
alias netspeed='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias mkzip='zip -r'
alias mktar='tar -czvf'
alias mktxz='tar -cJvf'
alias venv='python3 -m venv'
alias vact='source .venv/bin/activate'
alias reqinstall='pip install -r requirements.txt'
alias nrd='npm run dev'
alias nrs='npm run start'
alias nrb='npm run build'
alias crun='cargo run'
alias cbld='cargo build'
alias ctst='cargo test'
alias crel='cargo run --release'
alias gor='go run .'
alias gob='go build .'
alias got='go test ./...'
alias dcup='docker-compose up -d'
alias dcdn='docker-compose down'
alias dcrs='docker-compose restart'
alias dcls='docker-compose logs -f'
alias serve8000='python3 -m http.server 8000'
alias serve8080='python3 -m http.server 8080'
alias serve3000='python3 -m http.server 3000'
alias wtr='curl -s wttr.in'
alias wtrc='curl -s wttr.in?format=3'
if command -v xclip &>/dev/null; then
    alias xcopy='xclip -selection clipboard'
    alias xpaste='xclip -selection clipboard -o'
fi
alias editbash='"$EDITOR" ~/.bashrc'
alias editzsh='"$EDITOR" ~/.zshrc'
alias editfish='"$EDITOR" ~/.config/fish/config.fish'
alias editgit='"$EDITOR" ~/.gitconfig'
alias editstarship='"$EDITOR" ~/.config/starship.toml'
shopt -s autocd 2>/dev/null
shopt -s autocd 2>/dev/null
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null
shopt -s dotglob 2>/dev/null
shopt -s cdspell 2>/dev/null
shopt -s dirspell 2>/dev/null
shopt -s checkwinsize 2>/dev/null
shopt -s histappend 2>/dev/null
shopt -s lithist 2>/dev/null
shopt -s cmdhist 2>/dev/null
shopt -s fullpath 2>/dev/null
shopt -s extglob 2>/dev/null
shopt -s globasciiranges 2>/dev/null
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=erasedups:ignorespace:ignoredups
export HISTTIMEFORMAT="%F %T "
