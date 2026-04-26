#!/usr/bin/env zsh
# =============================================================================
# All Functions - Manually merged from all sources
# =============================================================================

cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ls
    else
        builtin cd ~ && ls
    fi
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

take() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) printf 'unknown archive: %s\n' "$1" >&2; return 1 ;;
    esac
}

pathuniq() {
    awk -v RS=: '!seen[$0]++{printf "%s%s", sep, $0; sep=":"} END{print ""}' <<<"$PATH"
}

dothealth() {
    bash "$DOTFILES_DIR/bin/health_check.sh"
}

dotbench() {
    bash "$DOTFILES_DIR/bin/benchmark_shell.sh"
}

dotfix() {
    sh "$DOTFILES_DIR/install/install.sh"
}

recent() {
    find "${1:-.}" -type f -mtime -1 -print 2>/dev/null | head -100
}

jsonfmt() {
    python3 -m json.tool "$@"
}

timer() {
    start=$(date +%s); "$@"; code=$?; end=$(date +%s); printf 'elapsed: %ss\n' "$((end-start))"; return $code
}

dotloadfull() {
    source "$DOTFILES_DIR/shells/zsh/functions_all.zsh"
    source "$DOTFILES_DIR/shells/zsh/aliases_all.zsh"
}

dot_sync() {
    local repo_root="${DOTFILES_DIR:-$HOME/.dotfiles}"
    if [[ -z "$repo_root" || ! -d "$repo_root/.git" ]]; then
        echo "Dotfiles repo not found."
        return 1
    fi
    echo "Syncing dotfiles in $repo_root..."
    git -C "$repo_root" fetch --all --prune
    git -C "$repo_root" pull --rebase --autostash || git -C "$repo_root" pull --ff-only
}

detect_pkg_manager() {
    if command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v yay >/dev/null 2>&1; then
        echo "yay"
    elif command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v brew >/dev/null 2>&1; then
        echo "brew"
    else
        echo "none"
    fi
}

pm_install() {
    case "$(detect_pkg_manager)" in
        pacman|yay) sudo pacman -S "$@" ;;
        apt) sudo apt install "$@" ;;
        dnf) sudo dnf install "$@" ;;
        brew) brew install "$@" ;;
    esac
}

pm_update() {
    case "$(detect_pkg_manager)" in
        pacman|yay) sudo pacman -Syu ;;
        apt) sudo apt update && sudo apt upgrade ;;
        dnf) sudo dnf update ;;
        brew) brew update ;;
    esac
}

pm_search() {
    case "$(detect_pkg_manager)" in
        pacman|yay) pacman -Ss "$@" ;;
        apt) apt search "$@" ;;
        dnf) dnf search "$@" ;;
        brew) brew search "$@" ;;
    esac
}

pm_list_installed() {
    case "$(detect_pkg_manager)" in
        pacman|yay) pacman -Qq ;;
        apt) dpkg -l | tail -n +3 ;;
        dnf) dnf list installed ;;
        brew) brew list ;;
    esac
}

# Search functions
findtext() { rg -l "$1" "${2:-.}"; }
findfn() { rg -l "function $1" "${2:-.}"; }

# System info
meminfo() { free -h && cat /proc/meminfo; }
cpuinfo() { lscpu; }
dfinfo() { df -h; }
portlist() { netstat -tulanp 2>/dev/null || ss -tulanp; }

# Network
myip() { curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null; }
weather() { curl -fsSL wttr.in; }
portcheck() { netstat -tulanp 2>/dev/null | grep "$1" || ss -tulanp | grep "$1"; }
pkillf() { pkill -f "$1" || killall "$1" 2>/dev/null; }

# Docker
dexec() { docker exec -it "$1" /bin/bash; }
dlogs() { docker logs -f "$1"; }
dclean() { docker system prune -af --volumes; }

# K8s
kexec() { kubectl exec -it "$1" -- /bin/bash; }
klogs() { kubectl logs -f "$1"; }
kshell() { kubectl exec -it "$1" -- /bin/sh; }

# Git
glog() { git log --oneline --graph --all -20; }
gdiff() { git diff --color "$@"; }
gcontrib() { git shortlog -sne; }
gtrack() { git ls-files; }

# Process
topcpu() { ps aux --sort=-%cpu | head -20; }
topmem() { ps aux --sort=-%mem | head -20; }
psgrep() { ps aux | grep -i "$1"; }

# Archive
targz() { tar -czf "${1}.tar.gz" "${1}"; }
tarxz() { tar -xzf "$1"; }

# Web
serve() { python3 -m http.server "${1:-8000}"; }
httpheader() { curl -I "$1"; }
httpbody() { curl -s "$1" | head -50; }

# JSON
jsonvalidate() { python3 -c "import json,f; json.load(f('${1}'))"; }

# Utility
backup() { cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)"; }
repeat() { for i in $(seq 1 "$1"); do "$2"; done; }
each() { for f in "$@"; do echo "$f"; done; }

# Docker Compose
dcop() { docker compose exec "$@"; }
dcup() { docker compose up -d; }
dcdn() { docker compose down; }

# Tmux
ta() { tmux attach -t "${1:-0}"; }
tn() { tmux new-session -s "$1"; }
tl() { tmux list-sessions; }

# Python
venv() { python3 -m venv "${1:-.venv}"; }
pyactivate() { source "${1:-.venv}/bin/activate"; }
pipup() { python3 -m pip install --upgrade pip; }

# NPM
npk() { npm init -y && npm install "$@"; }
nbump() { npm version patch && git push; }

# Rust
ccheck() { cargo check; }
cbuild() { cargo build --release; }
crt() { cargo run --release; }
ctest() { cargo test; }
cclippy() { cargo clippy -- -D warnings; }
cfmt() { cargo fmt; }

# Go
gobuild() { CGO_ENABLED=0 go build -ldflags="-s -w" -o "${1}" main.go; }
gotest() { go test -v -coverprofile=coverage.out; }
gocover() { go tool cover -html=coverage.out; }

# System update (cross-distro)
update() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman) sudo pacman -Syu ;;
        apt) sudo apt update && sudo apt upgrade ;;
        dnf) sudo dnf upgrade ;;
        brew) brew update && brew upgrade ;;
        apk) apk update && apk upgrade ;;
        *) echo "No supported package manager" ;;
    esac
}

# Install packages (cross-distro)
install() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman) sudo pacman -S "$@" ;;
        apt) sudo apt install "$@" ;;
        dnf) sudo dnf install "$@" ;;
        brew) brew install "$@" ;;
        apk) apk add "$@" ;;
        *) echo "No supported package manager" ;;
    esac
}

# Search packages (cross-distro)
search() {
    case "$DOTFILES_PKG_MANAGER" in
        yay|pacman) pacman -Ss "$@" ;;
        apt) apt search "$@" ;;
        dnf) dnf search "$@" ;;
        brew) brew search "$@" ;;
        *) echo "No supported package manager" ;;
    esac
}