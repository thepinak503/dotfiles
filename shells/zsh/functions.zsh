#!/usr/bin/env zsh
# =============================================================================
# Universal Shell Functions - Linux & macOS Compatible
# All function names are DIFFERENT from alias names to avoid conflicts
# =============================================================================

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)
            [[ -f /etc/os-release ]] && source /etc/os-release
            echo "${ID:-linux}" ;;
        *) echo "unknown"
    esac
}
detect_pm() {
    command -v brew >/dev/null && echo "brew" && return
    command -v apt >/dev/null && echo "apt" && return
    command -v dnf >/dev/null && echo "dnf" && return
    command -v pacman >/dev/null && echo "pacman" && return
    echo "none"
}

# Navigation
cc() { builtin cd "$@" && ls -A; }
back() { cd -; }
cdup() { cd ..; }
cdup2() { cd ../..; }
cdhome() { cd ~; }
mkcd() { mkdir -p "$1" && cd "$1"; }

# System (avoid: p, ps, pf, top)
sys_ps() { ps aux | head -20; }
find_proc() { ps aux | grep "$1"; }
show_procs() { ps aux; }
pidof() { pgrep -f "$1"; }
show_top() { command top -o "$1"; }
top_bycpu() { command top -o cpu; }
top_bymem() { command top -o mem; }
sys_cpu() { top -l 1 -n 3 }
num_cores() { sysctl -n hw.ncpu 2>/dev/null || nproc; }
cpuinfo() { sysctl -n machdep.cpu.brand_string 2>/dev/null || grep "model name" /proc/cpuinfo | head -1; }
show_ram() { vm_stat 2>/dev/null || free -h; }
sys_load() { uptime; }
get_myip() { curl -s https://api.ipify.org }
get_localip() { ipconfig getifaddr en0 2>/dev/null || ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1; }
list_ports() { lsof -i -n -P 2>/dev/null || netstat -tulanp; }
check_port() { lsof -i :"$1" 2>/dev/null || netstat -tulpn | grep ":$1 "; }

# Files (avoid: la, ll, l, ls, lt)
ls_all() { ls -AGa "$@"; }
ls_long() { ls -AGl "$@"; }
ls_one() { ls -1 "$@"; }
ls_recent() { ls -t | head -10; }
ls_big() { ls -lS | head -10; }
find_file() { find . -name "*$1*"; }
find_dir() { find . -name "*$1*" -type d; }
find_grep() { grep -r "$1" . --include="*$2*"; }
disk_usage() { du -h --max-depth=1; }
disk_sum() { du -sh "$@"; }
disk_free() { df -h; }

# Archive (avoid: extract)
unarchive() {
    for f in "$@"; do
        [[ -f "$f" ]] || continue
        case "$f" in
            *.tar.gz|*.tgz) tar -xzf "$f" ;;
            *.tar.bz2) tar -xjf "$f" ;;
            *.tar.xz) tar -xJf "$f" ;;
            *.tar) tar -xf "$f" ;;
            *.gz) gunzip -k "$f" ;;
            *.zip) unzip "$f" ;;
            *.rar) unrar x "$f" ;;
            *) echo "Unknown: $f" ;;
        esac
    done
}
tar_extract() { tar -xf "$1"; }
tar_create() { tar -czf "${2:-$1.tar.gz}" "$1"; }
zip_folder() { zip -r "${1}.zip" "$1"; }
unzip_file() { unzip "$1"; }

# Text (avoid: cat, grep)
cat_lines() { cat -n "$1"; }
tail_lines() { tail -30 "$1"; }
head_lines() { head -30 "$1"; }
tail_follow() { tail -f "$1"; }
count_lines() { wc -l "$1"; }
sort_unique() { sort -u "$1"; }
grep_line() { grep -n "$1" "$2"; }
grep_ignore() { grep -ri "$1" "$2"; }

# Encoding
base64_enc() { echo -n "$1" | base64; }
base64_dec() { echo -n "$1" | base64 -d; }
url_encode() { python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"; }
url_decode() { python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"; }
hash_md5() { md5 -q "$1" 2>/dev/null || md5sum "$1" | cut -d' -f1; }
hash_sha() { shasum -a 256 "$1" 2>/dev/null || sha256sum "$1" | cut -d' -f1; }

# Editors (avoid: v, vi, vim, nano, code)
nvim_edit() { nvim "$@"; }
nano_edit() { nano "$@"; }
vscode() { code "$@"; }

# Git (avoid: g, gs, ga, gp, gc, gb, gd, gl, gst)
git_stat() { git status; }
git_addf() { git add "$@"; }
git_addall() { git add -A; }
git_commit_m() { git commit -m "$1"; }
git_commit_am() { git commit -am "$1"; }
git_push() { git push; }
git_pull() { git pull; }
git_fetch() { git fetch; }
git_branch_list() { git branch; }
git_branch_all() { git branch -a; }
git_checkout() { git checkout "$1"; }
git_checkout_b() { git checkout -b "$1"; }
git_diff() { git diff; }
git_diff_staged() { git diff --staged; }
git_log() { git log --oneline -20; }
git_log_graph() { git log --oneline --graph --all -20; }
git_stash_push() { git stash; }
git_stash_pop() { git stash pop; }
git_reset_soft() { git reset HEAD~1 --soft; }
git_reset_hard() { git reset --hard HEAD~1; }

# Docker (avoid: d, dps, dpsa, di, de, dl)
docker_ps() { docker ps; }
docker_psa() { docker ps -a; }
docker_imgs() { docker images; }
docker_exec_sh() { docker exec -it "$1" /bin/sh; }
docker_exec_bash() { docker exec -it "$1" /bin/bash; }
docker_logs_f() { docker logs -f "$1"; }
docker_stop() { docker stop "$1"; }
docker_start() { docker start "$1"; }
docker_rm() { docker rm "$1"; }
docker_build() { docker build -t "$1" .; }
docker_prune() { docker system prune -af; }

# Kubernetes (avoid: k, kgp, kgs, kd)
kubectrl() { kubectl "$@"; }
k8s_pods() { kubectl get pods; }
k8s_svc() { kubectl get svc; }
k8s_deploy() { kubectl get deployments; }
k8s_exec() { kubectl exec -it "$1" -- /bin/sh; }
k8s_exec_bash() { kubectl exec -it "$1" -- /bin/bash; }
k8s_logs() { kubectl logs -f "$1"; }
k8s_port_fw() { kubectl port-forward "$1" "${2:-8888}:${3:-80}"; }

# Package Managers
sys_update() {
    case "$(detect_pm)" in
        brew) brew update && brew upgrade ;;
        apt) sudo apt update && sudo apt upgrade ;;
        dnf|yum) sudo dnf upgrade ;;
        pacman|yay) sudo pacman -Syu ;;
    esac
}
pkg_install() {
    case "$(detect_pm)" in
        brew) brew install "$@" ;;
        apt) sudo apt install "$@" ;;
        dnf|yum) sudo dnf install "$@" ;;
        pacman|yay) sudo pacman -S "$@" ;;
    esac
}
pkg_remove() {
    case "$(detect_pm)" in
        brew) brew uninstall "$@" ;;
        apt) sudo apt remove "$@" ;;
        dnf|yum) sudo dnf remove "$@" ;;
        pacman|yay) sudo pacman -R "$@" ;;
    esac
}
pkg_search() {
    case "$(detect_pm)" in
        brew) brew search "$@" ;;
        apt) apt search "$@" ;;
        dnf|yum) sudo dnf search "$@" ;;
        pacman|yay) pacman -Ss "$@" ;;
    esac
}

# Tmux (avoid: t, ta, tls)
tmux_new() { tmux new -s "$1"; }
tmux_attach() { tmux attach; }
tmux_list() { tmux ls; }
tmux_kill() { tmux kill-session -t "$1"; }

# Network (avoid: ping, curl, wget, nc, dig, ns)
ping_host() { ping -c 4 "$1"; }
curl_head() { curl -I "$1"; }
curl_get() { curl -s "$1"; }
curl_json() { curl -s "$1" | jq .; }
wget_file() { wget -c "$1"; }
netcat() { nc -zv "$1" "$2"; }
dns_lookup() { dig +short "$1"; }
ns_lookup() { nslookup "$1"; }

# Node.js (avoid: ni, nr, nt, nd)
npm_install() { npm install "$@"; }
npm_run() { npm run "$@"; }
npm_test() { npm test; }
npm_dev() { npm run dev; }
npm_init() { npm init -y; }

# Python (avoid: py, pip)
python_run() { python3 "$@"; }
python_interact() { python3 -i; }
pip_install() { pip install "$@"; }
pip_list() { pip list; }
python_venv() { python3 -m venv "$1"; }
python_http() { python3 -m http.server "${1:-8000}"; }

# Go
go_run() { go run .; }
go_build() { go build -o "$1" .; }
go_test() { go test -v ./...; }

# Rust (avoid: cbuild, crun, ctest)
cargo_build() { cargo build; }
cargo_run() { cargo run; }
cargo_test() { cargo test; }

# Database
mysql_conn() { mysql -u root -p"$1"; }
pg_conn() { psql -U postgres; }
sqlite_conn() { sqlite3 "$1"; }
redis_cli() { redis-cli; }

# Cloud (avoid: tf)
terraform() { terraform "$@"; }
terraform_plan() { terraform plan; }
terraform_apply() { terraform apply; }
terraform_destroy() { terraform destroy; }
terraform_init() { terraform init; }

# Services (avoid: sc)
systemctl() { systemctl "$@"; }
systemctl_status() { systemctl status "$1"; }
systemctl_restart() { systemctl restart "$1"; }

# Time
curr_time() { date "+%Y-%m-%d %H:%M:%S"; }
timestamp() { date +%s; }
cal_show() { cal; }

# Random
rand_num() { shuf -i 1-"$1" -n 1; }

# System Info
show_neofetch() { neofetch; }
show_sysinfo() { uname -a; }
show_hostname() { hostname; }
show_kernel() { uname -r; }

# User
whoami() { whoami; }
show_id() { id; }

# Permissions
chmod_exec() { chmod +x "$1"; }
chown_user() { sudo chown "$1:$2" "$3"; }

# Processes (avoid: kill, pkill)
kill_proc() { kill "$1"; }
pkill_proc() { pkill -f "$1"; }
proc_stop() { kill -STOP "$1"; }
proc_cont() { kill -CONT "$1"; }

# Hardware
hw_lscpu() { lscpu; }
hw_lsmod() { lsmod; }
hw_lspci() { lspci -v; }
hw_lsusb() { lsusb; }

# Env vars
show_env() { printenv | sort; }
show_path() { echo "$PATH" | tr ':' '\n'; }
add_path() { export PATH="$1:$PATH"; }

# Backup
make_backup() { cp -r "$1" "$1.bak-$(date +%Y%m%d)"; }
rsync_copy() { rsync -avz "$1"/ "$2"/; }

# HTTP server
http_server() { python3 -m http.server "${1:-8000}"; }

# macOS specific
mac_afk() { pmset displaysleepnow; }
mac_restart() { sudo shutdown -r now; }
showfiles() { defaults write com.apple.finder AppleShowAllFiles -bool TRUE && killall Finder; }
hidefiles() { defaults write com.apple.finder AppleShowAllFiles -bool FALSE && killall Finder; }
safari() { open -a Safari "$@"; }
chrome() { open -a "Google Chrome" "$@"; }
finder() { open .; }
spotlight() { mdfind "$1"; }

# Quick
clear_scr() { clear; }
exit_shell() { exit 0; }
reload_sh() { source ~/.zshrc; }

echo "Loaded universal zsh functions (Linux + macOS)"