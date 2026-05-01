#!/usr/bin/env bash
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
sys_cpu() { top -l 1 -n 3 2>/dev/null || top -b -n 1 | head -10; }
num_cores() { sysctl -n hw.ncpu 2>/dev/null || nproc; }
cpuinfo() { sysctl -n machdep.cpu.brand_string 2>/dev/null || grep "model name" /proc/cpuinfo | head -1; }
show_ram() { vm_stat 2>/dev/null || free -h; }
sys_load() { uptime; }
get_myip() { curl -s https://api.ipify.org 2>/dev/null || curl -s https://ifconfig.me; }
get_localip() { ipconfig getifaddr en0 2>/dev/null || ip addr show 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1; }
list_ports() { lsof -i -n -P 2>/dev/null || netstat -tulanp; }
check_port() { lsof -i :"$1" 2>/dev/null || netstat -tulpn 2>/dev/null | grep ":$1 "; }

# Files (avoid: la, ll, l, ls, lt)
ls_all() { ls -AGa "$@"; }
ls_long() { ls -AGl "$@"; }
ls_one() { ls -1 "$@"; }
ls_recent() { ls -t | head -10; }
ls_big() { ls -lS | head -10; }
find_file() { find . -name "*$1*"; }
find_dir() { find . -name "*$1*" -type d; }
find_grep() { grep -r "$1" . --include="*$2*" 2>/dev/null; }
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

# Git (avoid: g, gs, ga, gp, gc, gb, gd, gl, gst, commit, push, pull, branch)
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
git_stash_list() { git stash list; }
git_reset_soft() { git reset HEAD~1 --soft; }
git_reset_hard() { git reset --hard HEAD~1; }
git_tag() { git tag "$1"; }
git_tag_del() { git tag -d "$1"; }

# Docker (avoid: d, dps, dpsa, di, de, dl, docker)
docker_ps() { docker ps; }
docker_psa() { docker ps -a; }
docker_imgs() { docker images; }
docker_exec_sh() { docker exec -it "$1" /bin/sh; }
docker_exec_bash() { docker exec -it "$1" /bin/bash; }
docker_logs_f() { docker logs -f "$1"; }
docker_stop() { docker stop "$1"; }
docker_start() { docker start "$1"; }
docker_rm() { docker rm "$1"; }
docker_rmi() { docker rmi "$1"; }
docker_build() { docker build -t "$1" .; }
docker_run() { docker run -it --rm "$1" "$2"; }
docker_prune() { docker system prune -af; }
docker_inspect() { docker inspect "$1"; }
docker_cp() { docker cp "$1" "$2"; }

# Kubernetes (avoid: k, kgp, kgs, kd, kex)
kubectrl() { kubectl "$@"; }
k8s_pods() { kubectl get pods; }
k8s_svc() { kubectl get svc; }
k8s_deploy() { kubectl get deployments; }
k8s_nodes() { kubectl get nodes; }
k8s_pod_desc() { kubectl describe pod "$1"; }
k8s_svc_desc() { kubectl describe svc "$1"; }
k8s_deploy_desc() { kubectl describe deployment "$1"; }
k8s_exec_sh() { kubectl exec -it "$1" -- /bin/sh; }
k8s_exec_bash() { kubectl exec -it "$1" -- /bin/bash; }
k8s_logs_f() { kubectl logs -f "$1"; }
k8s_port_fw() { kubectl port-forward "$1" "${2:-8888}:${3:-80}"; }
k8s_apply() { kubectl apply -f "$1"; }
k8s_delete() { kubectl delete -f "$1"; }
k8s_scale() { kubectl scale deployment "$1" --replicas="$2"; }
k8s_rollout() { kubectl rollout status deployment/"$1"; }
k8s_restart() { kubectl rollout restart deployment/"$1"; }

# Package Managers (avoid: in, uni, q, ql)
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
pkg_list() {
    case "$(detect_pm)" in
        brew) brew list ;;
        apt) dpkg -l ;;
        dnf|yum) dnf list installed ;;
        pacman|yay) pacman -Q ;;
    esac
}

# Brew (avoid: bi, br, bu, bl, bs, bout, bclean)
brew_install() { brew install "$@"; }
brew_uninstall() { brew uninstall "$@"; }
brew_update() { brew update && brew upgrade; }
brew_list() { brew list; }
brew_outdated() { brew outdated; }
brew_cleanup() { brew cleanup; }
brew_doctor() { brew doctor; }
brew_link() { brew link "$@"; }

# APT (avoid: apt_in, apt_up)
apt_install() { sudo apt install "$@"; }
apt_remove() { sudo apt remove "$@"; }
apt_update() { sudo apt update && sudo apt upgrade; }
apt_search() { apt search "$@"; }
apt_autoclean() { sudo apt autoremove && sudo apt autoclean; }

# DNF (avoid: dnf_in, dnf_up)
dnf_install() { sudo dnf install "$@"; }
dnf_remove() { sudo dnf remove "$@"; }
dnf_update() { sudo dnf upgrade; }
dnf_search() { sudo dnf search "$@"; }
dnf_autoclean() { sudo dnf autoremove; }

# Pacman (avoid: pac_in, pac_up)
pac_install() { sudo pacman -S "$@"; }
pac_remove() { sudo pacman -R "$@"; }
pac_update() { sudo pacman -Syu; }
pac_search() { pacman -Ss "$@"; }

# Tmux (avoid: t, ta, tls, tnew)
tmux_new() { tmux new -s "$1"; }
tmux_attach() { tmux attach; }
tmux_attach_t() { tmux attach -t "$1"; }
tmux_list() { tmux ls; }
tmux_kill() { tmux kill-session -t "$1"; }
tmux_send() { tmux send-keys -t "$1" "$2" C-m; }

# Network (avoid: ping, curl, wget, nc, dig, ns, host)
ping_host() { ping -c 4 "$1"; }
curl_head() { curl -I "$1"; }
curl_get() { curl -s "$1"; }
curl_json() { curl -s "$1" | jq .; }
wget_file() { wget -c "$1"; }
netcat() { nc -zv "$1" "$2"; }
dns_lookup() { dig +short "$1"; }
ns_lookup() { nslookup "$1"; }
host_lookup() { host "$1"; }
whois_lookup() { whois "$1"; }
mtr_trace() { mtr -c 5 "$1"; }
nmap_scan() { nmap "$1"; }

# Node.js (avoid: ni, nr, nt, nd, npm, npx)
npm_install() { npm install "$@"; }
npm_install_s() { npm install -S "$@"; }
npm_install_d() { npm install -D "$@"; }
npm_install_g() { npm install -g "$@"; }
npm_update() { npm update; }
npm_run() { npm run "$@"; }
npm_test() { npm test; }
npm_dev() { npm run dev; }
npm_build() { npm run build; }
npm_init() { npm init -y; }
npm_list() { npm list; }
npm_outdated() { npm outdated; }
npm_search() { npm search "$@"; }

# Yarn (avoid: yi, yrem, yup)
yarn_add() { yarn add "$@"; }
yarn_remove() { yarn remove "$@"; }
yarn_upgrade() { yarn upgrade; }
yarn_run() { yarn "$@"; }
yarn_build() { yarn build; }
yarn_test() { yarn test; }

# Python (avoid: py, pip)
python_run() { python3 "$@"; }
python_interact() { python3 -i; }
pip_install() { pip install "$@"; }
pip_uninstall() { pip uninstall "$@"; }
pip_upgrade() { pip install --upgrade pip; }
pip_list() { pip list; }
pip_freeze() { pip freeze; }
pip_freeze_req() { pip freeze > requirements.txt; }
python_venv() { python3 -m venv "$1"; }
python_http() { python3 -m http.server "${1:-8000}"; }
python_json() { python3 -m json.tool "$1"; }

# Go (avoid: go_run, go_build, go_test)
go_run() { go run .; }
go_build() { go build -o "$1" .; }
go_test() { go test -v ./...; }
go_install() { go install "$@"; }
go_get() { go get "$@"; }
go_vet() { go vet ./...; }

# Rust (avoid: cbuild, crun, ctest, ccheck, cfmt)
cargo_build() { cargo build; }
cargo_release() { cargo build --release; }
cargo_run() { cargo run; }
cargo_run_rel() { cargo run --release; }
cargo_test() { cargo test; }
cargo_check() { cargo check; }
cargo_fmt() { cargo fmt; }
cargo_update() { cargo update; }

# Ruby
gem_install() { gem install "$@"; }
gem_list() { gem list; }
bundle_install() { bundle install; }
bundle_exec() { bundle exec "$@"; }
bundle_update() { bundle update; }

# Database
mysql_conn() { mysql -u root -p"$1"; }
mysql_dump() { mysqldump -u root -p"$1" > "$2"; }
pg_conn() { psql -U postgres; }
pg_dump() { pg_dump -U postgres "$1" > "$2"; }
sqlite_conn() { sqlite3 "$1"; }
mongosh_conn() { mongosh; }
redis_cli() { redis-cli; }

# Cloud CLI (avoid: tf, aws, az, gcloud)
terraform() { terraform "$@"; }
terraform_plan() { terraform plan; }
terraform_apply() { terraform apply; }
terraform_destroy() { terraform destroy; }
terraform_init() { terraform init; }
terraform_validate() { terraform validate; }
terraform_output() { terraform output; }
aws_cli() { aws "$@"; }
aws_sts() { aws sts get-caller-identity; }
az_cli() { az "$@"; }
gcloud_cli() { gcloud "$@"; }

# Helm
helm_list() { helm list; }
helm_install() { helm install "$1" "$2"; }
helm_uninstall() { helm uninstall "$1"; }
helm_upgrade() { helm upgrade "$1" "$2"; }
helm_rollback() { helm rollback "$1" "$2"; }
helm_repo_update() { helm repo update; }

# Services (avoid: sc, svc)
systemctl_cmd() { systemctl "$@"; }
systemctl_status() { systemctl status "$1"; }
systemctl_start() { systemctl start "$1"; }
systemctl_stop() { systemctl stop "$1"; }
systemctl_restart() { systemctl restart "$1"; }
systemctl_enable() { systemctl enable "$1"; }
systemctl_disable() { systemctl disable "$1"; }
systemctl_list() { systemctl list-units --type=service; }
systemctl_failed() { systemctl list-units --failed; }

# macOS services (avoid: launc, lunlaunc)
launchctl_load() { launchctl load "$1"; }
launchctl_unload() { launchctl unload "$1"; }
launchctl_list() { launchctl list; }

# Time
curr_time() { date "+%Y-%m-%d %H:%M:%S"; }
timestamp() { date +%s; }
from_epoch() { date -r "$1"; }
cal_show() { cal; }

# Calculator
bc_calc() { echo "$1" | bc -l; }

# Random
rand_num() { shuf -i 1-"$1" -n 1; }
gen_uuid() { uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid; }

# System Info
show_neofetch() { neofetch; }
show_sysinfo() { uname -a; }
show_osver() { sw_vers 2>/dev/null || cat /etc/os-release; }
show_hostname() { hostname; }
show_kernel() { uname -r; }
show_uptime() { uptime; }
whoami() { whoami; }
show_id() { id; }

# User management
user_add() { sudo useradd -m "$1"; }
user_del() { sudo userdel -r "$1"; }
passwd_set() { sudo passwd "$1"; }

# Permissions
chmod_exec() { chmod +x "$1"; }
chown_user() { sudo chown "$1:$2" "$3"; }

# Processes (avoid: kill, pkill, pstop, pcont)
kill_proc() { kill "$1"; }
kill_proc9() { kill -9 "$1"; }
pkill_proc() { pkill -f "$1"; }
proc_stop() { kill -STOP "$1"; }
proc_cont() { kill -CONT "$1"; }
proc_renice() { renice +"$1" -p "$2"; }
proc_jobs() { jobs -l; }

# Hardware
hw_lscpu() { lscpu; }
hw_lsmod() { lsmod; }
hw_lspci() { lspci -v; }
hw_lsusb() { lsusb; }
hw_lsblk() { lsblk; }
hw_sensors() { sensors; }

# Env vars
show_env() { printenv | sort; }
get_env() { printenv "$1"; }
set_env() { export "$1=$2"; }
unset_env() { unset "$1"; }
show_path() { echo "$PATH" | tr ':' '\n'; }
add_path() { export PATH="$1:$PATH"; }

# Helpers
which_cmd() { which "$1"; }
type_cmd() { type "$1"; }

# Backup
make_backup() { cp -r "$1" "$1.bak-$(date +%Y%m%d)"; }
rsync_copy() { rsync -avz --progress "$1"/ "$2"/; }
tar_backup() { tar -czf "${1}_$(date +%Y%m%d).tar.gz" "$1"; }

# HTTP server
http_server() { python3 -m http.server "${1:-8000}"; }

# Quick
clear_scr() { clear; }
exit_shell() { exit 0; }
reload_sh() { source ~/.bashrc; }

echo "Loaded universal bash functions (Linux + macOS)"