#!/usr/bin/env sh
# -----------------------------------------------------------------------------
# navigation — directory movement helpers
# -----------------------------------------------------------------------------
#
# Functions in this category provide fast, ergonomic directory navigation for
# the shell. They reduce keystrokes for common movement patterns and include
# basic error handling for missing directories or invalid arguments.
#
# Notable functions:
#   mkcd       — create directory and cd into it
#   take       — alias for mkcd (mnemonic: "take me there")
#   up         — go up N directories (default 1)
#   back       — return to previous directory (cd -)
#   cdup       — go up one directory
#   cdhome     — return to $HOME
#   cdroot     — return to filesystem root
#
# Usage examples:
#   $ mkcd /tmp/new-project
#   $ up 3
#   $ back
#
# See also: autojump, zoxide, pushd/popd
#

mkcd() { mkdir -p "$1" && cd "$1"; }
take() { mkdir -p "$1" && cd "$1"; }
up() { local d=""; for i in $(seq 1 "${1:-1}"); do d="${d}../"; done; cd "$d" 2>/dev/null || cd ..; }
back() { cd -; }
cdup() { cd ..; }
cdhome() { cd ~; }
cdroot() { cd /; }
# -----------------------------------------------------------------------------
# archive — universal archive extraction
# -----------------------------------------------------------------------------
#
# Functions in this category handle compressed archive extraction across a wide
# variety of formats. They auto-detect the format from the file extension and
# dispatch to the appropriate tool (tar, unzip, 7z, unrar, etc.).
#
# Notable functions:
#   extract    — extract any archive by detecting its extension
#
# Usage examples:
#   $ extract project.tar.gz
#   $ extract archive.zip
#
# See also: tar, unzip, 7z, unrar, uncompress_auto()
#

recent_dirs() { find "${1:-.}" -type d -mtime -1 -print 2>/dev/null | head -50; }
recent_all() { find "${1:-.}" -ctime -1 -print 2>/dev/null | head -100; }
# -----------------------------------------------------------------------------
# utilities — general-purpose shell helpers
# -----------------------------------------------------------------------------
#
# Functions in this category provide commonly needed operations that do not fit
# neatly into other categories. They include timing command execution and
# prompting before destructive operations.
#
# Notable functions:
#   timer      — run a command and print elapsed wall-clock time
#   confirm    — prompt for confirmation before running a command
#
# Usage examples:
#   $ timer make
#   $ confirm rm -rf node_modules
#
# See also: timeit(), bench()
#

mkdt() { mkdir -p "$1" && cd "$1" && pwd; }
quick_cd() { cd "$@" && ls; }
# -----------------------------------------------------------------------------
# trash — freedesktop-compatible trash management
# -----------------------------------------------------------------------------
#
# Functions in this category provide safe file deletion by moving files to the
# XDG trash directory (~/.local/share/Trash) rather than permanently removing
# them. They also support listing, emptying, and restoring trashed files.
#
# Notable functions:
#   trash_put       — move files to trash with timestamp suffix
#   trash_list      — list trashed files
#   trash_empty     — permanently empty the trash
#   trash_restore   — restore a trashed file to current directory
#
# Usage examples:
#   $ trash_put old-project/
#   $ trash_list
#   $ trash_restore old-project.1234567890
#
# See also: shred_file(), rm
#

dotfiles_cd() { cd "$DOTFILES_DIR" 2>/dev/null || cd; }

extract() { if [ -f "$1" ]; then case "$1" in *.tar.bz2|*.tbz2) tar xjf "$1";; *.tar.gz|*.tgz) tar xzf "$1";; *.tar.xz|*.txz) tar xJf "$1";; *.tar) tar xf "$1";; *.bz2) bunzip2 "$1";; *.gz) gunzip "$1";; *.rar) unrar x "$1";; *.zip) unzip "$1";; *.Z) uncompress "$1";; *.7z) 7z x "$1";; *) echo "unknown: $1"; return 1;; esac; else echo "not found: $1"; return 1; fi; }
compress_tar_gz() { tar -czf "$1.tar.gz" "$1"; }
# -----------------------------------------------------------------------------
# security — secret detection, encryption, and safe operations
# -----------------------------------------------------------------------------
#
# Functions in this category help detect leaked credentials, manage GPG agent
# and SSH agent integration, perform safe downloads with checksum verification,
# clear clipboard contents after a timeout, and encrypt/decrypt files. They are
# designed to minimise the risk of accidental secret exposure.
#
# Notable functions:
#   scan_secrets     — grep for API keys, tokens, private keys in git repos
#   gpg_agent_ensure — launch gpg-agent and set GPG_TTY
#   safe_dl          — download a file and verify its SHA-256 checksum
#   clipclear        — clear clipboard after N seconds (default 10)
#   shred_file       — securely overwrite and remove files
#   file_encrypt     — AES-256-CBC encrypt a file with openssl
#   file_decrypt     — AES-256-CBC decrypt a file with openssl
#
# Usage examples:
#   $ scan_secrets ~/projects/myapp
#   $ safe_dl https://example.com/file.tar.gz abc123...
#   $ clipclear 30
#
# See also: gpg_*, openssl_*
#

compress_tar_bz2() { tar -cjf "$1.tar.bz2" "$1"; }
compress_tar_xz() { tar -cJf "$1.tar.xz" "$1"; }
compress_zip() { zip -r "${1}.zip" "$1"; }
compress_gz() { gzip "$1"; }
compress_bz2() { bzip2 "$1"; }
compress_xz() { xz "$1"; }
compress_7z() { 7z a "${1}.7z" "$1"; }
decompress_tar_gz() { tar -xzf "$1"; }
decompress_tar_bz2() { tar -xjf "$1"; }
decompress_tar_xz() { tar -xJf "$1"; }
decompress_zip() { unzip "$1"; }
# -----------------------------------------------------------------------------
# ssh — key generation, agent management, and connection testing
# -----------------------------------------------------------------------------
#
# Functions in this category simplify SSH key generation using modern defaults
# (Ed25519, RSA 4096), agent initialisation, and basic agent status checks.
#
# Notable functions:
#   ssh_keygen_ed25519 — generate Ed25519 key with 100 KDF rounds
#   ssh_keygen_rsa     — generate 4096-bit RSA key
#   ssh_key_add        — start ssh-agent and add keys
#   ssh_agent_status   — list loaded keys or report agent not running
#
# Usage examples:
#   $ ssh_keygen_ed25519 -f ~/.ssh/id_ed25519 -C "user@host"
#   $ ssh_key_add ~/.ssh/id_ed25519
#   $ ssh_agent_status
#
# See also: ssh_copy_id_port(), ssh_tunnel_local(), ssh_agent_*
#

decompress_gz() { gunzip "$1"; }
decompress_bz2() { bunzip2 "$1"; }
decompress_xz() { unxz "$1"; }
# -----------------------------------------------------------------------------
# git — comprehensive git workflow and history functions
# -----------------------------------------------------------------------------
#
# Functions in this category cover the full git workflow: branch management,
# log inspection with various formats, diff visualisation, commit helpers,
# stash operations, tags, remotes, rebase, reset, cherry-pick, revert, blame,
# submodules, worktrees, bisect, notes, and configuration. Each function wraps
# a common git command with sensible defaults and error suppression.
#
# Notable functions:
#   git_branch_current       — show current branch name
#   git_branch_delete_merged — delete all branches merged into current
#   git_log_today            — commits by current user since midnight
#   git_log_graph            — compact one-line graph of last 30 commits
#   git_commit_signed        — commit with GPG signature
#   git_pull_rebase_auto     — pull with rebase and autostash
#   git_push_force_lease     — force push with safety check
#   git_stash_save           — stash including untracked files
#   git_squash_last          — squash last N commits into one
#   git_rebase_interactive   — interactive rebase of last N commits
#   git_branch_age           — branches sorted by commit freshness
#   git_clone_shallow        — shallow clone (depth=1)
#   git_fetch_prune          — fetch all remotes with pruning
#   git_branch_diff          — diff current branch against main
#   git_branch_log           — log current branch against main
#
# Usage examples:
#   $ git_branch_delete_merged
#   $ git_log_today
#   $ git_squash_last 3 "feat: squash into one"
#   $ git_push_force_lease
#
# See also: man git, git-config(1), gmb/gcm/gmm shortcuts
#

decompress_7z() { 7z x "$1"; }
decompress_rar() { unrar x "$1"; }
list_archive() { tar -tvf "$1" 2>/dev/null || unzip -l "$1" 2>/dev/null || 7z l "$1" 2>/dev/null; }

timer() { local start end code; start=$(date +%s); "$@"; code=$?; end=$(date +%s); echo "elapsed: $((end - start))s"; return $code; }
jsonfmt() { python3 -m json.tool "$@" 2>/dev/null || python3 -c "import sys,json; print(json.dumps(json.load(sys.stdin),indent=2))"; }
yamlfmt() { python3 -c "import sys,yaml,json; print(yaml.dump(json.load(sys.stdin)))" 2>/dev/null; }
pathuniq() { awk -v RS=: '!seen[$0]++{printf "%s%s",sep,$0;sep=":"} END{print ""}' <<EOF
$PATH
EOF
}
distribution() { if [ -f /etc/os-release ]; then . /etc/os-release && echo "$ID"; elif [ "$(uname)" = "Darwin" ]; then echo "macos"; else echo "linux"; fi; }
distro_version() { if [ -f /etc/os-release ]; then . /etc/os-release && echo "$PRETTY_NAME"; elif [ "$(uname)" = "Darwin" ]; then sw_vers -productVersion 2>/dev/null; else uname -r; fi; }
kernel_version() { uname -r; }
shell_version() { if [ -n "$ZSH_VERSION" ]; then echo "zsh $ZSH_VERSION"; elif [ -n "$BASH_VERSION" ]; then echo "bash $BASH_VERSION"; else "$SHELL" --version 2>/dev/null | head -1; fi; }
uptime_pretty() { uptime | sed 's/.*up //; s/,//g; s/ *$//'; }
sysinfo_summary() { echo "OS: $(distribution) $(distro_version) | Kernel: $(kernel_version) | Shell: $(shell_version) | Uptime: $(uptime_pretty)"; }
cpu_temp() { if [ -f /sys/class/thermal/thermal_zone0/temp ]; then echo "$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))°C"; fi; }
memory_usage() { free -h | awk '/^Mem/ {print "Memory: " $3 " / " $2}'; }
swap_usage() { free -h | awk '/^Swap/ {if ($2 != "0") print "Swap: " $3 " / " $2; else print "Swap: none";}'; }
disk_usage_summary() { df -h / 2>/dev/null | awk 'NR==2 {print "Disk: " $3 " / " $2 " (" $5 ")";}'; }
load_average() { uptime | awk -F'load average:' '{print "Load:" $2}'; }
sysinfo_quick() { echo "$(distribution) $(kernel_version) $(memory_usage) $(disk_usage_summary)"; }

confirm() { printf "%s [y/N] " "$*"; read -r _ans; case "$_ans" in [yY]|[yY][eE][sS]) "$@";; *) echo "aborted" >&2; return 1;; esac; }
trash_put() { mkdir -p "$HOME/.local/share/Trash/files"; for f in "$@"; do [ -e "$f" ] || continue; local _ts; _ts=$(date +%s); mv "$f" "$HOME/.local/share/Trash/files/$(basename "$f").$_ts"; done; }
trash_list() { ls -la "$HOME/.local/share/Trash/files" 2>/dev/null || echo "trash is empty"; }
trash_empty() { rm -rf "$HOME/.local/share/Trash/files"/* "$HOME/.local/share/Trash/info"/* 2>/dev/null; echo "trash cleared"; }
trash_restore() { local _f="$1"; [ -z "$_f" ] && { echo "usage: trash_restore <file>"; return 1; }; local _src="$HOME/.local/share/Trash/files/$_f"; [ -f "$_src" ] && mv "$_src" "./$_f" && echo "restored: $_f" || echo "not found in trash"; }
scan_secrets() { git -C "${1:-.}" grep -In \
    -e '-----BEGIN.*PRIVATE KEY' -e '-----BEGIN CERTIFICATE' \
    -e 'ghp_[0-9a-zA-Z]\{36\}' -e 'gho_[0-9a-zA-Z]\{36\}' \
    -e 'AKIA[0-9A-Z]\{16\}' -e 'sk-[0-9a-zA-Z]\{32,\}' \
    -e 'api[_-]\?key['"'"'"]\?\s*[:=]\s*['"'"'"][0-9a-zA-Z]\{16,\}' \
    -e 'secret['"'"'"]\?\s*[:=]\s*['"'"'"][0-9a-zA-Z]\{16,\}' \
    -e 'token['"'"'"]\?\s*[:=]\s*['"'"'"][0-9a-zA-Z]\{16,\}' \
    2>/dev/null || echo "no secrets detected in $(pwd)"; }
gpg_agent_ensure() { if command -v gpgconf >/dev/null 2>&1; then gpgconf --launch gpg-agent 2>/dev/null; elif command -v gpg-agent >/dev/null 2>&1; then gpg-agent --daemon 2>/dev/null || true; fi; export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null || echo /dev/tty)}"; }
gpg_agent_add() { gpg_agent_ensure; ssh-add "$@" 2>/dev/null || ssh-add; }
safe_dl() { if [ $# -lt 2 ]; then echo "usage: safe_dl <url> <sha256> [file]"; return 1; fi; local _url="$1" _exp="$2" _out="${3:-$(basename "$1")}"; if command -v curl >/dev/null 2>&1; then curl -fsSL -o "$_out" "$_url"; elif command -v wget >/dev/null 2>&1; then wget -q -O "$_out" "$_url"; else echo "no curl or wget" >&2; return 1; fi; local _act; _act=$(sha256sum "$_out" 2>/dev/null | cut -d' ' -f1); if [ "$_act" = "$_exp" ]; then echo "checksum ok: $_out"; else echo "checksum mismatch! expected: $_exp got: $_act" >&2; rm -f "$_out"; return 1; fi; }
clipclear() { (sleep "${1:-10}"; if command -v xclip >/dev/null 2>&1; then printf "" | xclip -selection clipboard -selection primary; elif command -v wl-copy >/dev/null 2>&1; then wl-copy ""; elif command -v pbcopy >/dev/null 2>&1; then printf "" | pbcopy; fi) & }
sudotime() { sudo -v; }
sudocheck() { sudo -n true 2>/dev/null && echo "sudo active" || echo "sudo expired"; }
env_secrets() { env | while IFS='=' read -r _k _v; do case "$_k" in *TOKEN*|*SECRET*|*PASSWORD*|*API_KEY*|*AUTH*) echo "possible secret in env: $_k";; esac; done; }
shred_file() { if command -v shred >/dev/null 2>&1; then shred -uz "$@"; else rm -P "$@" 2>/dev/null || rm -f "$@"; fi; }
file_encrypt() { if [ $# -lt 2 ]; then echo "usage: file_encrypt <file> <passphrase>"; return 1; fi; openssl enc -aes-256-cbc -salt -in "$1" -out "${1}.enc" -k "$2" 2>/dev/null && echo "encrypted: ${1}.enc"; }
file_decrypt() { if [ $# -lt 2 ]; then echo "usage: file_decrypt <file.enc> <passphrase>"; return 1; fi; local _out="${1%.enc}"; openssl enc -d -aes-256-cbc -in "$1" -out "$_out" -k "$2" 2>/dev/null && echo "decrypted: $_out"; }
ssh_keygen_ed25519() { ssh-keygen -t ed25519 -a 100 "$@"; }
ssh_keygen_rsa() { ssh-keygen -t rsa -b 4096 "$@"; }
ssh_key_add() { eval "$(ssh-agent -s)" >/dev/null 2>&1 && ssh-add "$@"; }
ssh_agent_status() { ssh-add -l 2>/dev/null || echo "ssh agent has no keys or not running"; }
check_breach() { curl -fsSL "https://haveibeenpwned.com/account/$1" 2>/dev/null || echo "check online: haveibeenpwned.com"; }

git_branch_current() { git rev-parse --abbrev-ref HEAD 2>/dev/null; }
git_branch_delete() { git branch -d "$1" 2>/dev/null || echo "branch not found or unmerged"; }
git_branch_delete_merged() { git branch --merged | grep -v "^*\|main\|master\|develop" | xargs -r git branch -d; }
git_branch_rename() { git branch -m "$1" "$2"; }
git_branch_list_all() { git branch -a; }
git_log_today() { git log --oneline --since="midnight" --author="$(git config user.email)" 2>/dev/null; }
git_log_author() { git log --oneline --author="$1" -20 2>/dev/null; }
git_log_graph() { git log --oneline --graph --all -30 2>/dev/null; }
git_log_oneline() { git log --oneline -20 2>/dev/null; }
git_log_search() { git log --oneline --grep="$1" -20 2>/dev/null; }
git_log_date_range() { git log --oneline --after="$1" --before="$2" 2>/dev/null; }
git_log_since() { git log --oneline --since="$1" 2>/dev/null; }
git_log_until() { git log --oneline --until="$1" 2>/dev/null; }
git_diff_stat() { git diff --stat "$@" 2>/dev/null; }
git_diff_word() { git diff --word-diff "$@" 2>/dev/null; }
git_diff_summary() { git diff --shortstat "$@" 2>/dev/null; }
git_commit_verbose() { git commit -v "$@"; }
git_commit_signed() { git commit -S "$@"; }
git_pull_rebase_auto() { git pull --rebase --autostash "$@"; }
git_push_force_lease() { git push --force-with-lease "$@"; }
git_push_upstream() { git push -u origin "$(git_branch_current)"; }
git_stash_save() { git stash push -u "$@"; }
git_stash_apply() { git stash apply "$@"; }
git_stash_drop() { git stash drop "$@"; }
git_stash_list() { git stash list; }
git_stash_pop() { git stash pop; }
git_stash_show() { git stash show -p "$@"; }
git_tag_create() { git tag "$1" && echo "tagged: $1"; }
git_tag_delete() { git tag -d "$1" && echo "deleted: $1"; }
git_tag_push() { git push origin "$1"; }
git_tag_push_all() { git push --tags; }
git_tag_list() { git tag -l "$@"; }
git_remote_add_upstream() { git remote add upstream "$1"; }
git_remote_prune() { git remote prune origin; }
git_remote_list() { git remote -v; }
git_clean_branches() { git branch --merged | grep -v "^*\|main\|master\|develop" | xargs -r git branch -d && git remote prune origin; }
git_squash_last() { git reset --soft HEAD~"${1:-2}" && git commit -m "${2:-squash}"; }
git_rebase_interactive() { git rebase -i HEAD~"${1:-10}"; }
git_rebase_continue() { git rebase --continue; }
git_rebase_abort() { git rebase --abort; }
# -----------------------------------------------------------------------------
# docker — container and image management
# -----------------------------------------------------------------------------
#
# Functions in this category wrap common Docker CLI operations: listing
# containers in various states, stopping and removing containers, pruning
# unused resources, running containers with various options, building images,
# managing networks and volumes, Docker Compose orchestration, Swarm mode,
# secrets, and plugins. All functions check for docker availability first.
#
# Notable functions:
#   docker_ps_all           — list all containers (running + stopped)
#   docker_stop_all         — stop all running containers
#   docker_rm_all           — remove all containers
#   docker_prune_all        — system prune including volumes
#   docker_clean_all        — full cleanup: prune + remove all images
#   docker_exec_sh          — exec interactive shell in running container
#   docker_logs_tail        — tail last N lines of container logs
#   docker_run_interactive  — run container interactively with auto-remove
#   docker_build_tag        — build image from Dockerfile with tag
#   docker_compose_up_build — docker compose up with rebuild
#   docker_compose_down_volumes — docker compose down removing volumes
#
# Usage examples:
#   $ docker_stop_all
#   $ docker_prune_all
#   $ docker_logs_tail myapp 50
#   $ docker_compose_up_build
#
# See also: docker-compose(1), lazydocker_open()
#

git_rebase_skip() { git rebase --skip; }
git_reset_soft() { git reset --soft HEAD~"$1"; }
git_reset_hard() { git reset --hard HEAD~"$1"; }
git_reset_mixed() { git reset --mixed HEAD~"$1"; }
git_reflog_show() { git reflog -20; }
git_reflog_all() { git reflog --all; }
git_worktree_add() { git worktree add "$1" "$2"; }
git_worktree_list() { git worktree list; }
git_submodule_update() { git submodule update --init --recursive; }
git_submodule_foreach() { git submodule foreach "$@"; }
git_blame_file() { git blame -w "$@"; }
git_grep_search() { git grep "$@"; }
git_ignore_local() { echo "$1" >> .gitignore; }
git_archive_branch() { git archive -o "${1:-archive}.tar.gz" HEAD; }
git_config_set_global() { git config --global "$1" "$2"; }
git_config_list() { git config --list; }
git_config_list_global() { git config --global --list; }
git_contributors() { git shortlog -sn; }
git_contributors_all() { git shortlog -sn --all; }
git_files_changed() { git diff --name-only "$@"; }
git_commit_stats() { git diff --stat "$@"; }
git_branch_age() { git for-each-ref --sort=committerdate refs/heads/ --format="%(refname:short) %(committerdate:relative)"; }
git_amend_noedit() { git commit --amend --no-edit; }
git_amend_message() { git commit --amend -m "$1"; }
git_commit_empty() { git commit --allow-empty -m "$1"; }
git_checkout_new_branch() { git checkout -b "$1"; }
git_merge_ff() { git merge --ff-only "$1"; }
git_merge_noff() { git merge --no-ff "$1" -m "${2:-merge}"; }
git_merge_squash() { git merge --squash "$1" && git commit -m "${2:-squash merge}"; }
git_merge_abort() { git merge --abort; }
git_merge_continue() { git merge --continue; }
git_cherry_pick() { git cherry-pick "$@"; }
git_cherry_pick_nocommit() { git cherry-pick -n "$@"; }
git_cherry_pick_continue() { git cherry-pick --continue; }
git_cherry_pick_abort() { git cherry-pick --abort; }
git_revert_commit() { git revert --no-edit "$1"; }
git_clone_shallow() { git clone --depth=1 "$@"; }
git_clone_recursive() { git clone --recursive "$@"; }
git_fetch_all() { git fetch --all; }
git_fetch_prune() { git fetch --all --prune; }
git_push_all() { git push --all; }
git_push_tags() { git push --tags; }
git_pull_ff() { git pull --ff-only; }
git_pull_rebase() { git pull --rebase "$@"; }
git_pull_autostash() { git pull --rebase --autostash; }
git_status_short() { git status --short --branch; }
git_diff_cached() { git diff --cached; }
git_diff_name() { git diff --name-only; }
git_log_stat() { git log --stat -10; }
git_verify_tags() { git tag -v "$@"; }
git_branch_diff() { git diff "main...$(git_branch_current)" --stat; }
git_branch_log() { git log "main...$(git_branch_current)" --oneline; }

if command -v docker >/dev/null 2>&1; then
docker_ps_all() { docker ps -a; }
docker_ps_running() { docker ps; }
docker_ps_stopped() { docker ps -a --filter status=exited; }
docker_stop_all() { docker stop $(docker ps -q) 2>/dev/null || true; }
docker_stop_latest() { docker ps -ql | xargs -r docker stop; }
docker_rm_all() { docker rm $(docker ps -aq) 2>/dev/null || true; }
docker_rm_exited() { docker rm $(docker ps -a -q -f status=exited) 2>/dev/null || true; }
docker_rm_stopped() { docker container prune -f; }
docker_rmi_dangling() { docker rmi $(docker images -f dangling=true -q) 2>/dev/null || true; }
docker_rmi_all() { docker rmi $(docker images -q) 2>/dev/null || true; }
docker_prune_all() { docker system prune -af --volumes; }
docker_prune_images() { docker image prune -af; }
docker_prune_containers() { docker container prune -f; }
docker_prune_volumes() { docker volume prune -f; }
docker_prune_networks() { docker network prune -f; }
# -----------------------------------------------------------------------------
# kubernetes — pod, service, deployment, and cluster management with kubectl
# -----------------------------------------------------------------------------
#
# Functions in this category wrap kubectl commands for common Kubernetes
# operations: listing resources across namespaces, inspecting pods, tailing
# logs, executing commands inside containers, port forwarding, rollouts,
# scaling, node management, context switching, and RBAC checks. The shorter
# k8s_* aliases provide quick-access variants for daily use.
#
# Notable functions:
#   kubectl_get_pods_all       — list pods across all namespaces
#   kubectl_logs_tail          — tail pod logs with configurable line count
#   kubectl_exec_bash          — open interactive bash in a pod
#   kubectl_port_forward_svc   — port-forward a service
#   kubectl_rollout_restart    — restart a deployment rollout
#   kubectl_context_switch     — switch kubectl context
#   kubectl_top_pods_all       — show pod resource usage across namespaces
#   k8s_pods                   — shorthand: get pods in current namespace
#   k8s_port_fw                — shorthand: port-forward a resource
#
# Usage examples:
#   $ kubectl_get_pods_all
#   $ kubectl_logs_tail my-pod-xyz12 200
#   $ kubectl_rollout_restart my-deployment
#   $ k8s_pods
#
# See also: kubectl(1), k9s_open(), helm_*
#

docker_clean_all() { docker system prune -af --volumes && docker rmi $(docker images -q) 2>/dev/null || true; }
docker_exec_sh() { docker exec -it "$1" /bin/sh; }
docker_exec_bash() { docker exec -it "$1" /bin/bash; }
docker_logs_tail() { docker logs --tail "${2:-100}" -f "$1"; }
docker_logs_since() { docker logs --since "${2:-5m}" "$1"; }
docker_run_detach() { docker run -d "$@"; }
docker_run_interactive() { docker run -it --rm "$@"; }
docker_run_name() { docker run --name "$1" "${@:2}"; }
docker_run_port() { docker run -it --rm -p "$1" "$2"; }
docker_run_volume() { docker run -it --rm -v "$1" "$2"; }
docker_build_tag() { docker build -t "$1" .; }
docker_build_nocache() { docker build --no-cache -t "$1" .; }
docker_push_tag() { docker push "$1"; }
docker_pull_latest() { docker pull "$1"; }
docker_stats_all() { docker stats --no-stream; }
docker_stats_live() { docker stats; }
docker_top_container() { docker top "$1"; }
docker_inspect_ip() { docker inspect -f "{{.NetworkSettings.IPAddress}}" "$1"; }
docker_network_create() { docker network create "$1"; }
docker_network_ls() { docker network ls; }
docker_volume_create() { docker volume create "$1"; }
docker_volume_ls() { docker volume ls; }
docker_volume_prune() { docker volume prune -f; }
docker_save_image() { docker save "$1" -o "${2:-$1.tar}"; }
docker_load_image() { docker load -i "$1"; }
docker_login_registry() { docker login "$@"; }
docker_tag_image() { docker tag "$1" "$2"; }
docker_export_container() { docker export "$1" -o "${2:-$1.tar}"; }
docker_import_image() { docker import "$1" "$2"; }
docker_system_df() { docker system df; }
docker_system_events() { docker system events; }
docker_system_info() { docker info; }
docker_compose_up_build() { docker compose up -d --build; }
docker_compose_down_volumes() { docker compose down -v; }
docker_compose_restart() { docker compose restart; }
docker_compose_stop() { docker compose stop; }
docker_compose_pull() { docker compose pull; }
docker_compose_build() { docker compose build; }
docker_compose_logs() { docker compose logs -f; }
docker_compose_logs_tail() { docker compose logs --tail="${1:-100}" -f; }
docker_compose_ps() { docker compose ps; }
docker_compose_exec() { docker compose exec "$@"; }
docker_compose_run() { docker compose run --rm "$@"; }
docker_compose_up_service() { docker compose up -d "$1"; }
docker_compose_stop_service() { docker compose stop "$1"; }
docker_compose_restart_service() { docker compose restart "$1"; }
docker_compose_build_nocache() { docker compose build --no-cache; }
docker_compose_down_remove_orphans() { docker compose down --remove-orphans; }
docker_compose_ps_services() { docker compose ps --services; }
docker_compose_exec_service() { docker compose exec "$1" "$2"; }
docker_compose_run_service() { docker compose run --rm "$1" "$2"; }
fi

if command -v kubectl >/dev/null 2>&1; then
kubectl_get_pods_all() { kubectl get pods --all-namespaces; }
kubectl_get_pods_node() { kubectl get pods -o wide --all-namespaces "$@"; }
kubectl_get_pods_wide() { kubectl get pods -o wide; }
kubectl_get_pods_watch() { kubectl get pods -w; }
kubectl_get_svc_all() { kubectl get svc --all-namespaces; }
kubectl_get_deployments_all() { kubectl get deployments --all-namespaces; }
kubectl_get_nodes_detail() { kubectl get nodes -o wide; }
kubectl_get_namespaces_all() { kubectl get namespaces; }
kubectl_describe_pod_detail() { kubectl describe pod "$1"; }
kubectl_logs_tail() { kubectl logs --tail="${2:-100}" -f "$1"; }
kubectl_logs_previous() { kubectl logs --previous "$1"; }
kubectl_logs_since() { kubectl logs --since="${2:-5m}" "$1"; }
kubectl_logs_all_containers() { kubectl logs "$1" --all-containers; }
kubectl_exec_bash() { kubectl exec -it "$1" -- /bin/bash; }
kubectl_exec_sh() { kubectl exec -it "$1" -- /bin/sh; }
kubectl_port_forward_svc() { kubectl port-forward svc/"$1" "${2:-8080}:${3:-80}"; }
kubectl_port_forward_pod() { kubectl port-forward pod/"$1" "${2:-8080}:${3:-80}"; }
kubectl_apply_dir() { kubectl apply -f "$1" --recursive; }
kubectl_apply_prune() { kubectl apply --prune -f "$1"; }
kubectl_delete_pod_force() { kubectl delete pod "$1" --force --grace-period=0; }
kubectl_rollout_status() { kubectl rollout status deployment/"$1"; }
# -----------------------------------------------------------------------------
# systemd & journalctl — service management and log inspection
# -----------------------------------------------------------------------------
#
# Functions in this category manage systemd services (start, stop, restart,
# enable, disable, mask) and inspect logs via journalctl with various filters
# (by unit, time range, priority, boot). All functions gracefully return 0
# on systems without systemd.
#
# Notable functions:
#   systemctl_status_all      — list all loaded units
#   systemctl_list_failed     — list failed units
#   systemctl_daemon_reload   — reload systemd daemon configuration
#   systemctl_analyze_blame   — show boot time breakdown by unit
#   journalctl_logs           — show recent log entries with explanations
#   journalctl_errors         — show error-level messages from current boot
#   journalctl_disk_usage     — show journal disk usage
#   journalctl_vacuum_size    — trim journal to a maximum size
#
# Usage examples:
#   $ systemctl_list_failed
#   $ journalctl_unit nginx.service
#   $ journalctl_errors
#   $ journalctl_vacuum_size 200M
#
# See also: systemd(1), journalctl(1), service_*
#

kubectl_rollout_history() { kubectl rollout history deployment/"$1"; }
kubectl_rollout_undo() { kubectl rollout undo deployment/"$1"; }
kubectl_rollout_restart() { kubectl rollout restart deployment/"$1"; }
kubectl_scale_deployment() { kubectl scale deployment "$1" --replicas="${2:-1}"; }
kubectl_scale_statefulset() { kubectl scale statefulset "$1" --replicas="${2:-1}"; }
kubectl_cordon_node() { kubectl cordon "$1"; }
kubectl_uncordon_node() { kubectl uncordon "$1"; }
kubectl_drain_node() { kubectl drain "$1" --ignore-daemonsets --delete-emptydir-data; }
kubectl_config_current() { kubectl config current-context; }
kubectl_config_set_namespace() { kubectl config set-context --namespace="$1"; }
kubectl_config_get_contexts() { kubectl config get-contexts; }
kubectl_context_switch() { kubectl config use-context "$1"; }
kubectl_top_pods_all() { kubectl top pods --all-namespaces; }
kubectl_top_nodes_all() { kubectl top nodes; }
kubectl_api_resources_short() { kubectl api-resources -o wide; }
kubectl_explain_recursive() { kubectl explain "$1" --recursive; }
kubectl_auth_cani() { kubectl auth can-i "$@"; }
kubectl_create_namespace() { kubectl create namespace "$1"; }
kubectl_create_configmap() { kubectl create configmap "$1" --from-file="$2"; }
kubectl_create_secret() { kubectl create secret generic "$1" --from-file="$2"; }
kubectl_get_events() { kubectl get events --sort-by=.lastTimestamp; }
kubectl_get_events_warn() { kubectl get events --field-selector type=Warning --sort-by=.lastTimestamp; }
kubectl_run_pod() { kubectl run "$1" --image="$2" -- "$@"; }
kubectl_run_deployment() { kubectl create deployment "$1" --image="$2"; }
kubectl_get_all_ingress() { kubectl get ingress --all-namespaces; }
kubectl_get_all_configmap() { kubectl get configmap --all-namespaces; }
kubectl_get_all_secret() { kubectl get secret --all-namespaces; }
kubectl_get_all_pvc() { kubectl get pvc --all-namespaces; }
kubectl_get_all_storageclass() { kubectl get sc; }
kubectl_label_node() { kubectl label node "$@"; }
kubectl_taint_node() { kubectl taint node "$@"; }
# -----------------------------------------------------------------------------
# package management — multi-distro package manager abstraction
# -----------------------------------------------------------------------------
#
# Functions in this category abstract package management across different
# distributions and operating systems. They dispatch to the correct package
# manager (pacman, yay, apt, dnf, brew, zypper, apk, xbps, nix) based on
# the DOTFILES_PKG_MANAGER environment variable. Additional helpers cover
# orphan cleanup, verification, PPA management, Flatpak, and Snap.
#
# Notable functions:
#   pkg_update_all     — update all packages using the configured manager
#   pkg_install_tool   — install packages via the configured manager
#   pkg_search_query   — search for packages by name
#   pkg_clean_cache    — clean the package cache
#   pacman_clean_orphans — remove orphaned pacman dependencies
#   apt_broken_fix     — fix broken apt dependencies
#   brew_update_all    — brew update + upgrade + cleanup
#   flatpak_update_all — update all Flatpak applications
#   snap_update_all    — refresh all Snap packages
#
# Usage examples:
#   $ DOTFILES_PKG_MANAGER=brew pkg_update_all
#   $ pkg_install_tool ripgrep fd
#   $ apt_broken_fix
#
# See also: pkg_install(), pkg_remove(), pkg_search(), pkg_update()
#

kubectl_cp_to_pod() { kubectl cp "$1" "$2:$3"; }
kubectl_cp_from_pod() { kubectl cp "$1:$2" "$3"; }
kubectl_get_events_ns() { kubectl get events -n "$1" --sort-by=.lastTimestamp; }
kubectl_get_all_pv() { kubectl get pv; }
kubectl_top_pod_ns() { kubectl top pod -n "$1"; }
kubectl_logs_pod_container() { kubectl logs -c "$2" "$1"; }
kubectl_exec_bash_pod_container() { kubectl exec -it "$1" -c "$2" -- /bin/bash; }
kubectl_port_forward_deployment() { kubectl port-forward deployment/"$1" "${2:-8080}:${3:-80}"; }
kubectl_apply_kustomize() { kubectl apply -k "$1"; }
kubectl_delete_all_deployments() { kubectl delete deployments --all -n "$1"; }
kubectl_rollout_pause() { kubectl rollout pause deployment/"$1"; }
kubectl_rollout_resume() { kubectl rollout resume deployment/"$1"; }
kubectl_scale_to_zero() { kubectl scale deployment "$1" --replicas=0; }
k8s_pods() { kubectl get pods; }
k8s_svc() { kubectl get svc; }
k8s_deploy() { kubectl get deployments; }
k8s_exec() { kubectl exec -it "$1" -- /bin/sh; }
k8s_exec_bash() { kubectl exec -it "$1" -- /bin/bash; }
k8s_logs() { kubectl logs -f "$1"; }
k8s_port_fw() { kubectl port-forward "$1" "${2:-8888}:${3:-80}"; }
fi

systemctl_status_all() { systemctl list-units 2>/dev/null || return 0; }
systemctl_list_failed() { systemctl list-units --failed 2>/dev/null || return 0; }
systemctl_list_enabled() { systemctl list-unit-files --state=enabled 2>/dev/null || return 0; }
systemctl_start_service() { sudo systemctl start "$1" 2>/dev/null || return 0; }
systemctl_stop_service() { sudo systemctl stop "$1" 2>/dev/null || return 0; }
systemctl_restart_service() { sudo systemctl restart "$1" 2>/dev/null || return 0; }
systemctl_enable_service() { sudo systemctl enable "$1" 2>/dev/null || return 0; }
systemctl_disable_service() { sudo systemctl disable "$1" 2>/dev/null || return 0; }
systemctl_mask_unit() { sudo systemctl mask "$1" 2>/dev/null || return 0; }
systemctl_unmask_unit() { sudo systemctl unmask "$1" 2>/dev/null || return 0; }
systemctl_daemon_reload() { sudo systemctl daemon-reload 2>/dev/null || return 0; }
# -----------------------------------------------------------------------------
# python — pip, venv, pytest, linting, and environment management
# -----------------------------------------------------------------------------
#
# Functions in this category cover Python development workflows: package
# installation via pip, virtual environment creation and activation, test
# running with pytest, linting with ruff/flake8/mypy, formatting with black,
# and pyenv/conda integration.
#
# Notable functions:
#   pip_install_reqs  — install dependencies from requirements.txt
#   pip_freeze_reqs   — freeze current environment to requirements.txt
#   venv_create       — create a Python virtual environment
#   venv_activate     — activate a virtual environment
#   pytest_run        — run pytest on current or specified files
#   pytest_coverage   — run pytest with coverage report
#   ruff_check        — run ruff linter
#   black_format      — format Python files with black
#
# Usage examples:
#   $ venv_create .venv && venv_activate .venv
#   $ pip_install_reqs
#   $ pytest_run tests/
#   $ ruff_check src/
#
# See also: python3(1), pip(1), poetry_*, pyenv_*, conda_*
#

systemctl_edit_override() { sudo systemctl edit "$1" 2>/dev/null || return 0; }
systemctl_cat_unit() { systemctl cat "$1" 2>/dev/null || return 0; }
systemctl_is_active() { systemctl is-active "$1" 2>/dev/null || return 0; }
systemctl_is_enabled() { systemctl is-enabled "$1" 2>/dev/null || return 0; }
systemctl_analyze_time() { systemd-analyze time 2>/dev/null || return 0; }
systemctl_analyze_blame() { systemd-analyze blame 2>/dev/null || return 0; }
systemctl_list_timers() { systemctl list-timers --all 2>/dev/null || return 0; }
systemctl_list_sockets() { systemctl list-sockets 2>/dev/null || return 0; }
journalctl_logs() { journalctl -xe 2>/dev/null || return 0; }
journalctl_follow() { journalctl -f 2>/dev/null || return 0; }
journalctl_unit() { journalctl -u "$1" 2>/dev/null || return 0; }
journalctl_unit_today() { journalctl -u "$1" --since="today" 2>/dev/null || return 0; }
journalctl_unit_yesterday() { journalctl -u "$1" --since="yesterday" --until="today" 2>/dev/null || return 0; }
journalctl_boot() { journalctl -b "$@" 2>/dev/null || return 0; }
journalctl_errors() { journalctl -p err -b 2>/dev/null || return 0; }
journalctl_warnings() { journalctl -p warning -b 2>/dev/null || return 0; }
journalctl_disk_usage() { journalctl --disk-usage 2>/dev/null || return 0; }
journalctl_vacuum_size() { sudo journalctl --vacuum-size="${1:-500M}" 2>/dev/null || return 0; }
journalctl_vacuum_time() { sudo journalctl --vacuum-time="${1:-2weeks}" 2>/dev/null || return 0; }

pkg_update_all() { case "${DOTFILES_PKG_MANAGER:-}" in pacman|yay) sudo pacman -Syu 2>/dev/null;; apt|apt-get) sudo apt update && sudo apt upgrade -y 2>/dev/null;; dnf) sudo dnf upgrade -y 2>/dev/null;; brew) brew update && brew upgrade 2>/dev/null;; zypper) sudo zypper update 2>/dev/null;; apk) apk update && apk upgrade 2>/dev/null;; xbps) sudo xbps-install -Su 2>/dev/null;; nix) nix upgrade-all 2>/dev/null;; *) echo "unknown pkg manager";; esac; }
pkg_install_tool() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) sudo pacman -S "$@" 2>/dev/null;; yay) yay -S "$@" 2>/dev/null;; apt|apt-get) sudo apt install "$@" 2>/dev/null;; dnf) sudo dnf install "$@" 2>/dev/null;; brew) brew install "$@" 2>/dev/null;; zypper) sudo zypper install "$@" 2>/dev/null;; apk) apk add "$@" 2>/dev/null;; xbps) sudo xbps-install "$@" 2>/dev/null;; nix) nix profile install "$@" 2>/dev/null;; *) echo "unknown pkg manager"; return 1;; esac; }
# -----------------------------------------------------------------------------
# node.js — npm, yarn, pnpm, nvm, and TypeScript tooling
# -----------------------------------------------------------------------------
#
# Functions in this category manage Node.js projects and packages: npm
# package installation (local, global, dev), running scripts, publishing,
# auditing, caching, and deduplication. Also covers pnpm, yarn, and nvm for
# Node version management, plus TypeScript compiler shortcuts.
#
# Notable functions:
#   npm_list_global   — list globally installed packages
#   npm_audit_fix     — run npm audit and fix vulnerabilities
#   npm_ci_clean      — clean install from lockfile
#   nvm_use           — switch Node version via nvm
#   tsc_noemit        — type-check without emitting output
#   ts_node_run       — run TypeScript directly via ts-node
#
# Usage examples:
#   $ npm_audit_fix
#   $ nvm_use 20
#   $ tsc_noemit
#
# See also: node(1), npm(1), nvm(1)
#

pkg_remove_tool() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) sudo pacman -Rns "$@" 2>/dev/null;; yay) yay -Rns "$@" 2>/dev/null;; apt|apt-get) sudo apt remove "$@" 2>/dev/null;; dnf) sudo dnf remove "$@" 2>/dev/null;; brew) brew uninstall "$@" 2>/dev/null;; zypper) sudo zypper remove "$@" 2>/dev/null;; apk) apk del "$@" 2>/dev/null;; xbps) sudo xbps-remove "$@" 2>/dev/null;; nix) nix profile remove "$@" 2>/dev/null;; *) echo "unknown pkg manager"; return 1;; esac; }
pkg_search_query() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Ss "$@" 2>/dev/null;; yay) yay -Ss "$@" 2>/dev/null;; apt|apt-get) apt search "$@" 2>/dev/null;; dnf) dnf search "$@" 2>/dev/null;; brew) brew search "$@" 2>/dev/null;; zypper) zypper search "$@" 2>/dev/null;; apk) apk search "$@" 2>/dev/null;; xbps) xbps-query -Rs "$@" 2>/dev/null;; *) echo "unknown pkg manager"; return 1;; esac; }
pkg_list_installed() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Q 2>/dev/null;; yay) yay -Q 2>/dev/null;; apt|apt-get) dpkg -l 2>/dev/null;; dnf) dnf list installed 2>/dev/null;; brew) brew list 2>/dev/null;; zypper) zypper se --installed-only 2>/dev/null;; apk) apk list -I 2>/dev/null;; *) echo "unknown"; return 1;; esac; }
pkg_list_outdated() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Qu 2>/dev/null;; yay) yay -Qu 2>/dev/null;; apt|apt-get) apt list --upgradable 2>/dev/null;; dnf) dnf check-update 2>/dev/null;; brew) brew outdated 2>/dev/null;; *) echo "not supported";; esac; }
pkg_clean_cache() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) sudo pacman -Sc 2>/dev/null;; apt|apt-get) sudo apt clean 2>/dev/null;; dnf) sudo dnf clean all 2>/dev/null;; brew) brew cleanup 2>/dev/null;; *) echo "not supported";; esac; }
pkg_show_info() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Qi "$@" 2>/dev/null;; yay) yay -Qi "$@" 2>/dev/null;; apt|apt-get) apt show "$@" 2>/dev/null;; dnf) dnf info "$@" 2>/dev/null;; brew) brew info "$@" 2>/dev/null;; zypper) zypper info "$@" 2>/dev/null;; *) echo "unknown";; esac; }
pacman_clean_orphans() { sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "no orphans"; }
pacman_list_orphans() { pacman -Qtd 2>/dev/null || echo "no orphans"; }
pacman_list_explicit() { pacman -Qe 2>/dev/null; }
pacman_verify_pkg() { pacman -Qk "$@" 2>/dev/null; }
apt_broken_fix() { sudo apt --fix-broken install 2>/dev/null; }
apt_search_installed() { dpkg -l | grep -i "$1" 2>/dev/null; }
apt_list_upgradable() { apt list --upgradable 2>/dev/null; }
apt_list_installed() { apt list --installed 2>/dev/null; }
apt_add_ppa() { sudo apt-add-repository ppa:"$1" 2>/dev/null; }
apt_remove_ppa() { sudo apt-add-repository --remove ppa:"$1" 2>/dev/null; }
dnf_list_groups() { dnf group list 2>/dev/null; }
dnf_history_rollback() { sudo dnf history rollback "$1" 2>/dev/null; }
brew_find_leaves() { brew leaves 2>/dev/null; }
brew_list_deps() { brew deps --tree "$@" 2>/dev/null; }
brew_clean_all() { brew cleanup --prune=all 2>/dev/null; }
brew_update_all() { brew update && brew upgrade && brew cleanup 2>/dev/null; }
# -----------------------------------------------------------------------------
# rust — cargo project management, testing, and tooling
# -----------------------------------------------------------------------------
#
# Functions in this category cover Rust development with Cargo: updating
# dependencies, building and testing, linting with clippy, formatting, code
# coverage, auditing, and publishing. They assume a Rust toolchain is
# installed.
#
# Notable functions:
#   cargo_update_all    — update all dependencies via cargo-install-update
#   cargo_tree_deps     — display dependency tree
#   cargo_clippy_all    — run clippy with deny warnings
#   cargo_fmt_check     — check code formatting
#   cargo_audit_check   — audit dependencies for vulnerabilities
#   cargo_outdated_all  — list outdated dependencies
#
# Usage examples:
#   $ cargo_update_all
#   $ cargo_clippy_all
#   $ cargo_test_all
#
# See also: cargo(1), rustc(1)
#

brew_services_start() { brew services start "$1" 2>/dev/null; }
brew_services_stop() { brew services stop "$1" 2>/dev/null; }
brew_services_list() { brew services list 2>/dev/null; }
brew_outdated_formula() { brew outdated 2>/dev/null; }
flatpak_list_apps() { flatpak list --app 2>/dev/null; }
flatpak_update_all() { flatpak update -y 2>/dev/null; }
snap_list_apps() { snap list 2>/dev/null; }
snap_update_all() { sudo snap refresh 2>/dev/null; }

pip_install_reqs() { pip install -r requirements.txt 2>/dev/null || pip3 install -r requirements.txt; }
pip_freeze_reqs() { pip freeze > requirements.txt 2>/dev/null || pip3 freeze > requirements.txt; }
pip_list_all() { pip list 2>/dev/null || pip3 list; }
pip_list_outdated() { pip list --outdated 2>/dev/null || pip3 list --outdated; }
pip_show_pkg() { pip show "$1" 2>/dev/null || pip3 show "$1"; }
pip_check() { pip check 2>/dev/null || pip3 check; }
venv_create() { python3 -m venv "${1:-.venv}"; }
venv_activate() { . "${1:-.venv}/bin/activate"; }
# -----------------------------------------------------------------------------
# go — module management, testing, building, and tooling
# -----------------------------------------------------------------------------
#
# Functions in this category cover Go development: module graph inspection,
# testing with coverage, building for multiple platforms, cross-compilation,
# vetting, formatting, and module verification.
#
# Notable functions:
#   go_version        — show Go version
#   go_test_cover     — run tests with coverage across all packages
#   go_build_cross    — cross-compile for Linux and macOS
#   go_mod_tidy       — tidy go module dependencies
#   go_vet_all        — run go vet across all packages
#   go_clean_cache    — clean the Go build cache
#
# Usage examples:
#   $ go_test_cover
#   $ go_build_cross myapp
#   $ go_mod_tidy
#
# See also: go(1), go-mod(1)
#

venv_deactivate() { deactivate 2>/dev/null || true; }
python_version() { python3 --version; }
python_find() { which python3 || which python; }
pyright_check() { python3 -m pyright "$@" 2>/dev/null || npx pyright "$@"; }
pytest_run() { python3 -m pytest "$@" 2>/dev/null; }
pytest_coverage() { python3 -m pytest --cov "$@" 2>/dev/null; }
mypy_check() { python3 -m mypy "$@" 2>/dev/null; }
flake8_lint() { python3 -m flake8 "$@" 2>/dev/null; }
black_format() { python3 -m black "$@" 2>/dev/null; }
pip_install_uv() { pip install uv 2>/dev/null || pip3 install uv; }
pip_cache_clean() { pip cache purge 2>/dev/null || true; }
pip_download_pkg() { pip download "$@" 2>/dev/null || pip3 download "$@"; }
pip_hash_pkg() { pip hash "$1" 2>/dev/null || pip3 hash "$1"; }

npm_list_global() { npm list -g --depth=0 2>/dev/null; }
npm_list_outdated() { npm outdated 2>/dev/null; }
# -----------------------------------------------------------------------------
# network diagnostics — IP, DNS, ports, SSL, and HTTP tools
# -----------------------------------------------------------------------------
#
# Functions in this category diagnose network issues: retrieving public and
# local IP addresses, checking open ports, DNS lookups (A, MX, NS, TXT,
# ANY), SSL certificate validation, HTTP status and header inspection, file
# downloads, and bandwidth testing. They prefer modern tools (dig, curl)
# with fallbacks to traditional ones (nslookup, wget).
#
# Notable functions:
#   whatismyip          — get public IP address
#   whatismyip_external — get public IP with geolocation JSON
#   dns_lookup          — resolve hostname to IP address
#   dns_mx_lookup       — look up MX records
#   check_port_open     — test if a remote TCP port is open
#   check_port_listen   — check if a local port is being listened on
#   ssl_check           — check SSL certificate expiry dates
#   http_status         — get HTTP status code for a URL
#   download_file       — download a file via curl or wget
#
# Usage examples:
#   $ whatismyip
#   $ dns_lookup example.com
#   $ check_port_open example.com 443
#   $ ssl_check example.com
#
# See also: ping_test(), traceroute_path(), myip4(), myip6(), localip()
#

npm_audit_fix() { npm audit fix 2>/dev/null; }
npm_cache_clean() { npm cache clean --force 2>/dev/null; }
npm_docs_pkg() { npm docs "$1" 2>/dev/null; }
npm_why_dep() { npm why "$1" 2>/dev/null; }
npm_ci_clean() { npm ci 2>/dev/null; }
npm_dedupe() { npm dedupe 2>/dev/null; }
npm_prune() { npm prune 2>/dev/null; }
npm_version_bump() { npm version "${1:-patch}" 2>/dev/null; }
pnpm_store_prune() { pnpm store prune 2>/dev/null; }
pnpm_dedupe() { pnpm dedupe 2>/dev/null; }
pnpm_lint() { pnpm run lint 2>/dev/null; }
yarn_upgrade_interactive() { yarn upgrade-interactive 2>/dev/null; }
yarn_outdated() { yarn outdated 2>/dev/null; }
yarn_why() { yarn why "$1" 2>/dev/null; }
node_version() { node --version; }
node_run_script() { node "$@"; }
nvm_use() { [ -f "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm use "$1"; }
nvm_list() { [ -f "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm ls; }
nvm_install() { [ -f "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm install "$1"; }

cargo_update_all() { cargo install-update -a 2>/dev/null || cargo update; }
cargo_tree_deps() { cargo tree "$@"; }
cargo_build_release() { cargo build --release; }
cargo_bench_all() { cargo bench --all; }
cargo_test_all() { cargo test --all; }
cargo_clippy_all() { cargo clippy --all-targets -- -D warnings 2>/dev/null; }
cargo_fmt_check() { cargo fmt --check; }
cargo_doc_open() { cargo doc --open; }
# -----------------------------------------------------------------------------
# file operations — backup, search, comparison, and metadata
# -----------------------------------------------------------------------------
#
# Functions in this category handle file and directory operations: creating
# timestamped backups, counting files/lines, finding largest/newest/oldest
# files, detecting duplicates, copying with progress, renaming extensions,
# symlink management, and checksum verification.
#
# Notable functions:
#   backup_file        — create timestamped backup copy of a file/dir
#   backup_dir         — create compressed tar.gz backup of a directory
#   find_largest       — show largest files in a directory
#   find_largest_dirs  — show largest subdirectories
#   find_duplicates    — find duplicate files by MD5 checksum
#   copy_with_progress — copy with rsync progress display
#   checksum_sha256    — compute SHA-256 checksum of a file
#
# Usage examples:
#   $ backup_file important.doc
#   $ find_largest /var/log 10
#   $ find_duplicates ~/Downloads
#
# See also: bak(), unbak(), orig(), file_*
#

cargo_expand_macro() { cargo expand "$@"; }
cargo_bloat_crate() { cargo bloat --crates 2>/dev/null; }
cargo_clean_all() { cargo clean; }
cargo_audit_check() { cargo audit 2>/dev/null; }
cargo_outdated_all() { cargo outdated 2>/dev/null; }
cargo_check_all() { cargo check --all; }
cargo_publish_crate() { cargo publish; }
cargo_test_nocapture() { cargo test -- --nocapture; }

go_version() { go version; }
go_env_list() { go env; }
go_deps_graph() { go mod graph; }
go_test_cover() { go test -cover ./...; }
go_build_all() { go build ./...; }
go_install_latest() { go install "$1@latest"; }
go_mod_tidy() { go mod tidy; }
go_mod_vendor() { go mod vendor; }
go_vet_all() { go vet ./...; }
go_clean_cache() { go clean -cache; }
go_generate_all() { go generate ./...; }
go_fmt_all() { go fmt ./...; }
go_lint_all() { golint ./... 2>/dev/null; }
go_run_dir() { go run .; }
go_test_race() { go test -race ./...; }

whatismyip() { curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null; }
whatismyip_external() { curl -fsSL https://ipinfo.io/json 2>/dev/null; }
# -----------------------------------------------------------------------------
# text processing — grep, sed, awk, sort, diff, and format conversion
# -----------------------------------------------------------------------------
#
# Functions in this category provide text processing utilities: searching
# with grep (recursive, invert, context, word), stream editing with sed,
# column extraction with awk, file sorting, line deduplication, diffing,
# CSV/JSON/YAML validation and formatting, and hex dumps.
#
# Notable functions:
#   grep_search      — basic grep search
#   grep_recursive   — recursive grep
#   sed_replace      — sed-based find-and-replace in a file
#   awk_column       — extract N-th column with awk
#   sort_by_size     — list files sorted by size
#   json_validate    — validate JSON syntax
#   yaml_validate    — validate YAML syntax
#   csv_view         — formatted CSV viewer with column alignment
#
# Usage examples:
#   $ grep_recursive "TODO" src/
#   $ sed_replace "old" "new" file.txt
#   $ json_validate package.json
#
# See also: text_*, rg_search(), sd_replace()
#

whatismyip_local() { ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1; }
check_port_open() { if command -v nc >/dev/null 2>&1; then nc -zv "$1" "$2" 2>&1; elif command -v nmap >/dev/null 2>&1; then nmap -p "$2" "$1"; else echo "check: nc or nmap needed"; fi; }
check_port_listen() { ss -tlnp 2>/dev/null | grep ":$1 " || netstat -tlnp 2>/dev/null | grep ":$1 "; }
check_port_pid() { lsof -i :"$1" 2>/dev/null || ss -tlnp 2>/dev/null | grep ":$1 " | awk '{print $NF}'; }
kill_port_process() { local _pid; _pid=$(check_port_pid "$1"); [ -n "$_pid" ] && kill -9 "$_pid" 2>/dev/null && echo "killed $_pid" || echo "no process found on port $1"; }
dns_lookup() { dig +short "$1" 2>/dev/null || host "$1" 2>/dev/null || nslookup "$1" 2>/dev/null; }
dns_reverse() { dig +short -x "$1" 2>/dev/null || host "$1" 2>/dev/null; }
dns_mx_lookup() { dig MX +short "$1" 2>/dev/null || nslookup -type=MX "$1" 2>/dev/null; }
dns_ns_lookup() { dig NS +short "$1" 2>/dev/null || nslookup -type=NS "$1" 2>/dev/null; }
dns_txt_lookup() { dig TXT +short "$1" 2>/dev/null || nslookup -type=TXT "$1" 2>/dev/null; }
dns_any() { dig ANY +short "$1" 2>/dev/null || host -a "$1" 2>/dev/null; }
ping_test() { ping -c "${2:-4}" "$1"; }
speedtest_run() { curl -fsSL https://speedtest.net 2>/dev/null || echo "use: speedtest-cli"; }
ssl_check() { echo | openssl s_client -connect "$1:${2:-443}" -servername "$1" 2>/dev/null | openssl x509 -noout -dates; }
http_status() { curl -sI "$1" | head -1; }
http_headers() { curl -I "$1"; }
download_file() { if command -v curl >/dev/null 2>&1; then curl -fsSL -O "$1"; elif command -v wget >/dev/null 2>&1; then wget -q "$1"; else echo "need curl or wget"; fi; }
download_extract() { local _f; _f=$(basename "$1"); download_file "$1" && extract "$_f"; }
ip_info() { curl -fsSL https://ipinfo.io/json 2>/dev/null; }
mac_lookup() { curl -fsSL "https://api.macvendors.com/$1" 2>/dev/null; }
whois_query() { whois "$1" 2>/dev/null; }
traceroute_path() { traceroute "$1" 2>/dev/null; }
bandwidth_test() { curl -fsSL https://speedtest.net 2>/dev/null || echo "speedtest-cli needed"; }
netstat_connections() { ss -tupan 2>/dev/null || netstat -tupan; }
netstat_listening() { ss -tlnp 2>/dev/null || netstat -tlnp; }
# -----------------------------------------------------------------------------
# dotfiles — self-management of the dotfiles repository
# -----------------------------------------------------------------------------
#
# Functions in this category manage the dotfiles repository itself: updating
# from remote, running health checks, viewing documentation, checking status,
# and synchronising changes. They assume the DOTFILES_DIR environment variable
# is set to the repository root.
#
# Notable functions:
#   dot_update  — pull latest changes via dotupdate.sh
#   dot_health  — run health check script
#   dot_status  — show git status of dotfiles repo
#   dot_sync    — fetch, prune, and rebase dotfiles repo
#   dot_docs    — open dotfiles documentation in browser
#   dot_ver     — show dotfiles version
#
# Usage examples:
#   $ dot_update
#   $ dot_health
#   $ dot_status
#
# See also: backup_dotfiles(), dotfiles_diff()
#


backup_file() { cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)" && echo "backup: ${1}.bak-$(date +%Y%m%d-%H%M%S)"; }
backup_dir() { tar -czf "${1%/}.tar.gz" "$1" && echo "backup: ${1%/}.tar.gz"; }
backup_with_date() { tar -czf "${1%/}-$(date +%Y%m%d).tar.gz" "$1"; }
count_files() { find "${1:-.}" -type f 2>/dev/null | wc -l; }
count_dirs() { find "${1:-.}" -type d 2>/dev/null | wc -l; }
count_lines_total() { find "${1:-.}" -type f -exec cat {} + 2>/dev/null | wc -l; }
find_largest() { find "${1:-.}" -type f -exec ls -s {} + 2>/dev/null | sort -rn | head "${2:-20}"; }
# -----------------------------------------------------------------------------
# generation — passwords, UUIDs, tokens, encoding, and hashing
# -----------------------------------------------------------------------------
#
# Functions in this category generate random values (passwords, UUIDs,
# tokens), encode/decode data (base64, URL encoding), and compute hashes
# (SHA-256, MD5) for strings and files.
#
# Notable functions:
#   generate_password — generate a base64-encoded random password
#   generate_uuid     — generate a UUID v4 string
#   url_encode        — percent-encode a string
#   hash_string       — compute SHA-256 hash of a string
#   hash_file         — compute SHA-256 hash of a file
#
# Usage examples:
#   $ generate_password 32
#   $ generate_uuid
#   $ url_encode "hello world"
#
# See also: openssl_rand_hex(), openssl_rand_base64()
#

find_largest_dirs() { du -sh "${1:-.}"/*/ 2>/dev/null | sort -rh | head "${2:-20}"; }
find_newest() { find "${1:-.}" -type f -print0 2>/dev/null | xargs -0 ls -lt | head "${2:-20}"; }
find_oldest() { find "${1:-.}" -type f -print0 2>/dev/null | xargs -0 ls -ltr | head "${2:-20}"; }
find_empty_files() { find "${1:-.}" -type f -empty 2>/dev/null; }
find_empty_dirs() { find "${1:-.}" -type d -empty 2>/dev/null; }
find_duplicates() { find "${1:-.}" -type f -exec md5sum {} + 2>/dev/null | sort | uniq -w32 -dD; }
copy_with_progress() { rsync -ah --progress "$1" "$2"; }
copy_and_cd() { cp -r "$1" "$2" && cd "$2"; }
move_and_cd() { mv "$1" "$2" && cd "$2"; }
rename_extension() { for f in *."$1"; do mv "$f" "${f%.$1}.$2"; done; }
symlink_force() { ln -sf "$1" "$2"; }
# -----------------------------------------------------------------------------
# media — FFmpeg, ImageMagick, and EXIF processing
# -----------------------------------------------------------------------------
#
# Functions in this category process media files: converting video formats
# with ffmpeg, compressing video to H.265, creating GIFs, extracting audio,
# taking screenshots, resizing and cropping, plus image manipulation with
# ImageMagick (resize, compress, convert, crop, rotate, trim) and EXIF
# metadata read/remove.
#
# Notable functions:
#   ffmpeg_convert       — convert video to another format
#   ffmpeg_compress      — compress video with H.265 at a given CRF
#   ffmpeg_gif           — create animated GIF from video
#   ffmpeg_extract_audio — extract audio stream to MP3
#   image_resize         — resize an image to a percentage
#   image_compress       — compress JPEG with quality setting
#   exif_show            — display EXIF metadata
#   exif_remove          — strip all EXIF metadata
#
# Usage examples:
#   $ ffmpeg_compress input.mp4 23
#   $ ffmpeg_gif input.mp4 15 640
#   $ image_resize photo.jpg 50%
#
# See also: ffprobe(1), convert(1), exiftool(1)
#

touch_all() { for f in "$@"; do touch "$f"; done; }
show_permissions() { ls -la "$1" | awk '{print $1, $NF}'; }
show_owner() { ls -la "$1" | awk '{print $3, $4, $NF}'; }
file_size() { ls -lh "$1" | awk '{print $5}'; }
file_extension() { echo "${1##*.}"; }
checksum_sha256() { sha256sum "$1" 2>/dev/null || shasum -a 256 "$1"; }
checksum_md5() { md5sum "$1" 2>/dev/null || md5 "$1"; }
verify_checksum() { sha256sum -c "$1" 2>/dev/null; }

count_lines() { wc -l "$@"; }
count_words() { wc -w "$@"; }
count_chars() { wc -m "$@"; }
grep_search() { grep "$@"; }
grep_recursive() { grep -r "$@"; }
grep_invert() { grep -v "$@"; }
grep_context() { grep -C "${3:-2}" "$1" "$2"; }
grep_count() { grep -c "$@"; }
grep_word() { grep -w "$@"; }
sed_replace() { sed -i "s/$1/$2/g" "$3"; }
sed_delete() { sed -i "$1d" "$2"; }
awk_column() { awk "{print \$$1}" "$2"; }
awk_calc() { awk "BEGIN{print $*}"; }
sort_by_size() { ls -lS "$@"; }
sort_by_time() { ls -lt "$@"; }
sort_by_name() { ls -l "$@"; }
# -----------------------------------------------------------------------------
# cloud — AWS, GCP, and Azure CLI wrappers
# -----------------------------------------------------------------------------
#
# Functions in this category wrap common cloud provider CLI commands: AWS
# (EC2, S3, Lambda, IAM, ECS, EKS, RDS, DynamoDB, CloudWatch, Route53, etc.),
# GCP (Compute Engine, GKE, Cloud Storage, IAM, Cloud Run, Cloud SQL, KMS),
# and Azure (VMs, AKS, resource groups).
#
# Notable functions:
#   aws_whoami           — show current AWS identity
#   aws_list_ec2         — list EC2 instances in table format
#   aws_s3_browse        — browse S3 bucket contents
#   gcloud_list_instances — list GCP compute instances
#   gcloud_get_creds     — get GKE cluster credentials
#   az_list_vms          — list Azure VMs
#
# Usage examples:
#   $ aws_whoami
#   $ aws_list_ec2
#   $ gcloud_list_instances
#   $ gcloud_get_creds my-cluster
#
# See also: aws(1), gcloud(1), az(1), terraform_*
#

unique_lines() { sort -u "$@"; }
unique_count() { sort "$1" | uniq -c | sort -rn; }
diff_summary() { diff -q "$@"; }
csv_view() { column -t -s, "$@" | less -S; }
json_validate() { python3 -m json.tool "$@" >/dev/null 2>&1 && echo "valid json" || echo "invalid json"; }
yaml_validate() { python3 -c "import sys,yaml; yaml.safe_load(open(sys.argv[1]))" "$@" 2>/dev/null && echo "valid yaml" || echo "invalid yaml"; }
hex_dump() { xxd "$@" | head -50; }
xml_format() { xmllint --format "$@" 2>/dev/null; }

make_all() { make 2>/dev/null; }
make_clean() { make clean 2>/dev/null; }
make_install() { make install 2>/dev/null; }
make_test() { make test 2>/dev/null; }
make_build() { make build 2>/dev/null; }
make_distclean() { make distclean 2>/dev/null; }
just_list() { just --list 2>/dev/null; }
just_run() { just "$@" 2>/dev/null; }
just_edit() { just --edit 2>/dev/null; }
dot_docs() { xdg-open "$DOTFILES_DIR/docs/index.html" 2>/dev/null || open "$DOTFILES_DIR/docs/index.html" 2>/dev/null || echo "docs at $DOTFILES_DIR/docs/index.html"; }
dot_update() { bash "$DOTFILES_DIR/bin/dotupdate.sh" 2>/dev/null || echo "dotupdate not found"; }
dot_health() { bash "$DOTFILES_DIR/bin/health_check.sh" 2>/dev/null || echo "health check not found"; }
dot_bench() { bash "$DOTFILES_DIR/bin/benchmark_shell.sh" 2>/dev/null || echo "benchmark not found"; }
dot_fix() { sh "$DOTFILES_DIR/install/install.sh" 2>/dev/null || echo "installer not found"; }
# -----------------------------------------------------------------------------
# infrastructure — Terraform lifecycle management
# -----------------------------------------------------------------------------
#
# Functions in this category manage Terraform workflows: initialisation,
# planning, applying, destroying, workspace management, state inspection,
# validation, formatting, and graph visualisation.
#
# Notable functions:
#   terraform_plan_out      — plan with output file
#   terraform_apply_auto    — apply without confirmation
#   terraform_workspace_new — create and switch to a new workspace
#   terraform_fmt_recursive — format all Terraform files recursively
#   terraform_validate_all  — validate configuration
#   terraform_graph_deps    — generate dependency graph as PNG
#
# Usage examples:
#   $ terraform_plan_out
#   $ terraform_apply_auto
#   $ terraform_fmt_recursive
#
# See also: terraform(1), helm_*
#

dot_status() { git -C "$DOTFILES_DIR" status --short --branch 2>/dev/null || true; }
dot_sync() { git -C "$DOTFILES_DIR" fetch --all --prune 2>/dev/null && git -C "$DOTFILES_DIR" pull --rebase --autostash 2>/dev/null; }
dot_ver() { echo "$DOTFILES_VERSION"; }
generate_password() { openssl rand -base64 "${1:-16}" 2>/dev/null || python3 -c "import secrets; print(secrets.token_urlsafe(${1:-16}))"; }
generate_uuid() { uuidgen 2>/dev/null || python3 -c "import uuid; print(uuid.uuid4())"; }
generate_token() { openssl rand -hex "${1:-32}" 2>/dev/null || python3 -c "import secrets; print(secrets.token_hex(${1:-32}))"; }
encode_base64() { printf "%s" "$1" | base64; }
decode_base64() { printf "%s" "$1" | base64 -d 2>/dev/null || printf "%s" "$1" | base64 -D; }
url_encode() { python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$1" 2>/dev/null; }
url_decode() { python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))" "$1" 2>/dev/null; }
hash_string() { printf "%s" "$1" | sha256sum | cut -d' ' -f1; }
hash_file() { sha256sum "$1" 2>/dev/null | cut -d' ' -f1; }
hash_md5() { printf "%s" "$1" | md5sum | cut -d' ' -f1; }
# -----------------------------------------------------------------------------
# helm — Kubernetes package manager operations
# -----------------------------------------------------------------------------
#
# Functions in this category manage Helm charts and releases: repository
# management, searching, installing, upgrading, rolling back, fetching
# manifests, testing, and templating.
#
# Notable functions:
#   helm_repo_add            — add a Helm chart repository
#   helm_upgrade_install_full — upgrade or install with namespace
#   helm_list_releases_all   — list releases across all namespaces
#   helm_dry_run             — dry-run install for debugging
#   helm_template_render     — render chart templates locally
#
# Usage examples:
#   $ helm_repo_add bitnami https://charts.bitnami.com/bitnami
#   $ helm_upgrade_install_full my-release bitnami/nginx
#
# See also: helm(1), kubectl_*
#


ffmpeg_convert() { ffmpeg -i "$1" "${2:-output.mp4}"; }
ffmpeg_compress() { ffmpeg -i "$1" -vcodec libx265 -crf "${2:-28}" "${1%.*}-compressed.mp4"; }
ffmpeg_gif() { ffmpeg -i "$1" -vf "fps=${2:-10},scale=${3:-320}:-1" "${1%.*}.gif"; }
ffmpeg_screenshot() { ffmpeg -i "$1" -ss "${2:-00:00:01}" -vframes 1 "${3:-screenshot.png}"; }
ffmpeg_extract_audio() { ffmpeg -i "$1" -q:a 0 -map a "${1%.*}.mp3"; }
ffmpeg_merge_video() { ffmpeg -i "$1" -i "$2" -c copy -map 0:v:0 -map 1:a:0 "${3:-output.mp4}"; }
ffmpeg_resize_video() { ffmpeg -i "$1" -vf "scale=${2:-1280}:${3:-720}" "${1%.*}-resized.mp4"; }
ffmpeg_crop() { ffmpeg -i "$1" -filter:v "crop=${2:-640}:${3:-480}:${4:-0}:${5:-0}" "${1%.*}-cropped.mp4"; }
ffmpeg_speed() { ffmpeg -i "$1" -filter:v "setpts=${2:-0.5}*PTS" -filter:a "atempo=${3:-2.0}" "${1%.*}-sped.mp4"; }
ffmpeg_metadata() { ffprobe "$1" 2>/dev/null; }
ffmpeg_png_sequence() { ffmpeg -i "$1" -vf "fps=${2:-1}" "${1%.*}-%04d.png"; }
ffmpeg_stream() { ffmpeg -i "$1" -c copy -f mp4 pipe:; }
image_resize() { convert "$1" -resize "${2:-50%}" "${1%.*}-resized.${1##*.}"; }
# -----------------------------------------------------------------------------
# databases — MySQL, PostgreSQL, SQLite, and Redis helpers
# -----------------------------------------------------------------------------
#
# Functions in this category provide quick database operations: dumping and
# importing MySQL/PostgreSQL databases, running queries, listing tables and
# schemas for SQLite, and basic Redis operations (ping, flush, monitor,
# key-value get/set).
#
# Notable functions:
#   mysql_dump_db  — dump a MySQL database to a SQL file
#   pg_list_dbs    — list PostgreSQL databases
#   sqlite_query   — run a query against a SQLite database
#   redis_ping     — test Redis connectivity
#   redis_monitor  — start Redis monitor
#
# Usage examples:
#   $ mysql_dump_db mydb
#   $ pg_list_dbs
#   $ sqlite_query my.db "SELECT * FROM users"
#
# See also: mysql(1), psql(1), sqlite3(1), redis-cli(1)
#

image_compress() { convert "$1" -quality "${2:-85}" "${1%.*}-compressed.${1##*.}"; }
image_convert() { convert "$1" "${2:-output.png}"; }
image_crop() { convert "$1" -crop "${2:-640x480}+${3:-0}+${4:-0}" "${1%.*}-cropped.${1##*.}"; }
image_rotate() { convert "$1" -rotate "${2:-90}" "${1%.*}-rotated.${1##*.}"; }
image_info() { identify "$1" 2>/dev/null; }
image_trim() { convert "$1" -trim "${1%.*}-trimmed.${1##*.}"; }
exif_show() { exiftool "$1" 2>/dev/null; }
exif_remove() { exiftool -all= "$1" 2>/dev/null; }
ffmpeg_volume() { ffmpeg -i "$1" -filter:a "volume=${2:-2.0}" "${1%.*}-louder.mp3"; }
ffmpeg_concat() { ffmpeg -f concat -safe 0 -i "$1" -c copy "${2:-output.mp4}"; }
gif_optimize() { convert "$1" -fuzz 2% -layers Optimize "${1%.*}-optimized.gif"; }

aws_whoami() { aws sts get-caller-identity 2>/dev/null || echo "aws not configured"; }
aws_list_s3() { aws s3 ls 2>/dev/null || true; }
aws_list_ec2() { aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key==`Name`].Value|[0]]' --output table 2>/dev/null || true; }
aws_list_lambda() { aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime,MemorySize]' --output table 2>/dev/null || true; }
aws_list_ecs() { aws ecs list-clusters 2>/dev/null || true; }
aws_list_eks() { aws eks list-clusters 2>/dev/null || true; }
aws_list_iam() { aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table 2>/dev/null || true; }
aws_list_vpc() { aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,Tags[?Key==`Name`].Value|[0],CidrBlock]' --output table 2>/dev/null || true; }
aws_list_logs() { aws logs describe-log-groups --query 'logGroups[*].[logGroupName,storedBytes]' --output table 2>/dev/null || true; }
aws_list_route53() { aws route53 list-hosted-zones --query 'HostedZones[*].[Name,Id]' --output table 2>/dev/null || true; }
# -----------------------------------------------------------------------------
# gpg & openssl — encryption, signing, key management, and certificate inspection
# -----------------------------------------------------------------------------
#
# Functions in this category manage GPG keys (listing, exporting, importing,
# encrypting, decrypting, signing, verifying) and OpenSSL operations
# (generating RSA keys and CSRs, self-signed certificates, certificate
# inspection, random data generation).
#
# Notable functions:
#   gpg_list_keys        — list public keys
#   gpg_encrypt_file     — encrypt a file for a recipient
#   gpg_decrypt_file     — decrypt a GPG-encrypted file
#   gpg_sign_file        — sign a file with your GPG key
#   openssl_gen_rsa      — generate RSA private key
#   openssl_self_sign    — generate self-signed certificate
#   openssl_check_expiry — check certificate expiry dates
#
# Usage examples:
#   $ gpg_encrypt_file recipient@example.com secret.txt
#   $ openssl_self_sign mykey.pem mycert.pem 730
#   $ openssl_check_expiry cert.pem
#
# See also: gpg(1), openssl(1), file_encrypt(), file_decrypt()
#

aws_s3_browse() { aws s3 ls "s3://$1"; }
aws_s3_sync_up() { aws s3 sync . "s3://$1" --exclude '.git/*'; }
aws_s3_sync_down() { aws s3 sync "s3://$1" .; }
gcloud_list_instances() { gcloud compute instances list 2>/dev/null || true; }
gcloud_list_clusters() { gcloud container clusters list 2>/dev/null || true; }
gcloud_get_creds() { gcloud container clusters get-credentials "$1" "$@"; }
gcloud_ssh() { gcloud compute ssh "$@"; }
gcloud_list_projects() { gcloud projects list 2>/dev/null || true; }
gcloud_list_images() { gcloud compute images list 2>/dev/null || true; }
gcloud_list_disks() { gcloud compute disks list 2>/dev/null || true; }
az_list_vms() { az vm list --output table 2>/dev/null || true; }
az_list_aks() { az aks list --output table 2>/dev/null || true; }
az_list_groups() { az group list --output table 2>/dev/null || true; }
terraform_init_re() { terraform init -reconfigure; }
terraform_plan_out() { terraform plan -out=tfplan; }
terraform_apply_auto() { terraform apply -auto-approve; }
terraform_destroy_auto() { terraform destroy -auto-approve; }
terraform_workspace_new() { terraform workspace new "$1"; }
terraform_workspace_show() { terraform workspace show; }
terraform_workspace_list() { terraform workspace list; }
terraform_state_pull() { terraform state pull; }
terraform_state_push() { terraform state push "$1"; }
terraform_fmt_recursive() { terraform fmt -recursive; }
terraform_validate_all() { terraform validate && echo "valid"; }
terraform_refresh_state() { terraform refresh; }
terraform_console_tool() { terraform console; }
# -----------------------------------------------------------------------------
# docker compose — orchestration inspection and lifecycle
# -----------------------------------------------------------------------------
#
# These functions provide Docker Compose and container inspection commands:
# listing all compose resources, inspecting containers/images/volumes,
# building and pulling all services, and system-level pruning.
#
# Notable functions:
#   docker_compose_ps_all   — list all compose services including stopped
#   docker_compose_build_all — build all compose services
#   docker_system_prune_all  — full system prune including volumes
#   docker_container_ip      — get IP address of a container
#
# Usage examples:
#   $ docker_compose_build_all
#   $ docker_system_prune_all
#
# See also: docker-compose(1), docker_*
#

helm_repo_add() { helm repo add "$1" "$2"; }
helm_repo_update() { helm repo update; }
helm_repo_list() { helm repo list; }
helm_search_repo() { helm search repo "$1"; }
helm_upgrade_install_full() { helm upgrade --install "$1" "$2" --namespace "${3:-default}" --create-namespace; }
helm_get_values_all() { helm get values "$1" --all; }
helm_list_releases_all() { helm list --all-namespaces; }
helm_uninstall_release() { helm uninstall "$1"; }
helm_rollback_release() { helm rollback "$1" "$2"; }
helm_history_show() { helm history "$1"; }
helm_dry_run() { helm install "$1" "$2" --dry-run --debug; }
helm_test_release() { helm test "$1"; }
helm_template_render() { helm template "$1" "$2"; }

mysql_dump_db() { mysqldump -u root -p "$1" > "${1}.sql"; }
mysql_import_db() { mysql -u root -p "$1" < "$2"; }
mysql_run_query() { mysql -u root -p -e "$1"; }
mysql_list_dbs() { mysql -u root -p -e "SHOW DATABASES;" 2>/dev/null || mysql -u root -e "SHOW DATABASES;"; }
# -----------------------------------------------------------------------------
# kubectl — resource inspection, YAML output, and namespace helpers
# -----------------------------------------------------------------------------
#
# These kubectl functions focus on resource inspection with YAML/JSON output,
# detailed descriptions, multi-container log access, scaling, labelling,
# annotation, watching, proxying, port forwarding, and namespace-scoped
# resource listing.
#
# Notable functions:
#   kubectl_get_pod_yaml — get pod definition as YAML
#   kubectl_describe_node — detailed node information
#   kubectl_watch_all    — watch all resources in a namespace
#   kubectl_proxy_start  — start kubectl proxy
#   kubectl_get_pods_ns   — get pods in a specific namespace
#
# Usage examples:
#   $ kubectl_get_pod_yaml my-pod
#   $ kubectl_describe_node worker-1
#
# See also: kubectl(1), k9s_open()
#

pg_dump_db() { pg_dump -U postgres "$1" > "${1}.sql"; }
pg_import_db() { psql -U postgres -d "$1" -f "$2"; }
pg_list_dbs() { psql -U postgres -l 2>/dev/null || true; }
pg_run_query() { psql -U postgres -c "$1"; }
sqlite_query() { sqlite3 "$1" "$2"; }
sqlite_tables() { sqlite3 "$1" ".tables"; }
sqlite_schema() { sqlite3 "$1" ".schema"; }
sqlite_dump() { sqlite3 "$1" ".dump"; }
redis_ping() { redis-cli ping; }
redis_flush() { redis-cli FLUSHALL; }
redis_info() { redis-cli INFO "$1"; }
redis_monitor() { redis-cli MONITOR; }
redis_keys() { redis-cli KEYS "$1"; }
redis_get() { redis-cli GET "$1"; }
redis_set() { redis-cli SET "$1" "$2"; }
mongosh_run() { mongosh "$@" 2>/dev/null || true; }
mongosh_list_dbs() { mongosh --quiet --eval "db.adminCommand('listDatabases')" 2>/dev/null || true; }

gpg_list_keys() { gpg --list-keys 2>/dev/null || true; }
# -----------------------------------------------------------------------------
# system information — hardware, OS, and resource queries
# -----------------------------------------------------------------------------
#
# Functions in this category report system information: CPU, memory, disk,
# network interfaces, system load, running processes, listening ports,
# logged-in users, uptime, battery status and percentage, temperature,
# GPU info, and swap usage.
#
# Notable functions:
#   get_cpu_info          — show CPU information
#   get_memory_info       — show memory usage
#   get_listening_ports   — show listening TCP ports
#   get_battery_percent   — show battery charge percentage
#   get_temperature_info  — show CPU temperature
#
# Usage examples:
#   $ get_cpu_info
#   $ get_battery_percent
#   $ get_listening_ports
#
# See also: sys_*, ps_*, disk_*, net_*
#

gpg_list_secret_keys() { gpg --list-secret-keys 2>/dev/null || true; }
gpg_export_key() { gpg --export -a "$1" > "${1}.asc"; }
gpg_export_secret_key() { gpg --export-secret-keys -a "$1"; }
gpg_import_key() { gpg --import "$1"; }
gpg_encrypt_file() { gpg -e -r "$1" "$2"; }
gpg_decrypt_file() { gpg -d "$1" > "${1%.gpg}"; }
gpg_sign_file() { gpg -s "$1"; }
gpg_verify_file() { gpg --verify "$1"; }
gpg_recv_keys() { gpg --recv-keys "$@"; }
gpg_refresh_keys() { gpg --refresh-keys; }
gpg_encrypt_symmetric() { gpg -c "$1"; }
gpg_key_id() { gpg --list-keys --keyid-format LONG "$1" | grep "^pub" | awk '{print $2}'; }
gpg_key_fingerprint() { gpg --fingerprint "$1" | grep fingerprint | tr -d ' ' | cut -d= -f2; }
gpg_set_trust() { gpg --edit-key "$1" trust; }
openssl_gen_rsa() { openssl genrsa -out "${1:-private.pem}" "${2:-2048}"; }
openssl_gen_csr() { openssl req -new -key "$1" -out "${2:-request.csr}"; }
openssl_self_sign() { openssl req -x509 -newkey rsa:4096 -keyout "${1:-key.pem}" -out "${2:-cert.pem}" -days "${3:-365}" -nodes; }
openssl_check_cert() { openssl x509 -in "$1" -text -noout 2>/dev/null; }
openssl_check_expiry() { openssl x509 -in "$1" -noout -dates 2>/dev/null; }
openssl_check_conn() { echo | openssl s_client -connect "$1:${2:-443}" -servername "$1" 2>/dev/null | openssl x509 -noout -dates; }
# -----------------------------------------------------------------------------
# archive utilities — tar, gzip, bzip2, xz, zip, 7z, rar compression
# -----------------------------------------------------------------------------
#
# Functions in this category provide compression and decompression for
# individual archive formats with configurable compression levels. They
# complement the universal extract() function.
#
# Notable functions:
#   tar_compress     — create a tar.gz archive
#   tar_decompress   — extract a tar.gz archive
#   gzip_compress    — compress a file with gzip
#   zip_compress     — create a zip archive
#   7z_compress      — create a 7z archive
#   uncompress_auto  — extract any archive by extension (multi-format)
#
# Usage examples:
#   $ tar_compress mydir "output.tar.gz"
#   $ zip_compress project/
#   $ uncompress_auto file.rar
#
# See also: extract(), archive_create_*
#

openssl_rand_hex() { openssl rand -hex "${1:-32}"; }
openssl_rand_base64() { openssl rand -base64 "${1:-32}"; }
openssl_check_modulus() { openssl rsa -modulus -in "$1" -noout | openssl md5; }
openssl_check_key() { openssl rsa -in "$1" -check 2>/dev/null || openssl ec -in "$1" -check 2>/dev/null; }

show_path() { printf "%s\n" "$PATH" | tr ':' '\n'; }
show_env() { env | sort; }
show_aliases() { alias | sort; }
show_functions() { declare -f | grep -E '^[a-z_][a-z0-9_]* \(\)' | cut -d' ' -f1 | sort 2>/dev/null || typeset -f | grep -E '^[a-z_]' | cut -d' ' -f1 | sort; }
show_banner() { printf "%s\n" "dotfiles: ${DOTFILES_DIR:-?} mode: ${DOTFILES_MODE:-?} shell: $SHELL"; }
show_calendar() { cal "${1:-}"; }
show_weather() { curl -fsSL "wttr.in/${1:-}" 2>/dev/null; }
show_date() { date '+%F %T %Z'; }
show_date_utc() { date -u '+%F %T UTC'; }
show_datetime() { date '+%F %T'; }
date_iso_8601() { date -u +%Y-%m-%dT%H:%M:%SZ; }
date_unix_ts() { date +%s; }
date_format() { date "+${1:-%F %T}"; }
random_number() { shuf -i "${1:-1}"-"${2:-100}" -n 1 2>/dev/null || echo $((RANDOM % ${2:-100} + ${1:-1})); }
random_string() { openssl rand -base64 "${1:-16}" 2>/dev/null; }
repeat_command() { local _n="${1:-1}"; shift; for _i in $(seq 1 "$_n"); do "$@"; done; }
run_with_timeout() { timeout "${1:-5}" "${@:2}"; }
watch_command() { watch -n "${1:-2}" "${@:2}"; }
retry_command() { local _n="${1:-3}"; shift; for _i in $(seq 1 "$_n"); do "$@" && return 0; done; return 1; }
quiet_run() { "$@" >/dev/null 2>&1; }
dry_run() { printf "DRY-RUN: %s\n" "$*"; }
confirm_action() { printf "continue? [y/N] "; read -r _c; case "$_c" in [yY]|[yY][eE][sS]) "$@";; *) echo "cancelled"; return 1;; esac; }
show_ip() { ip -br addr show 2>/dev/null || ifconfig; }
# -----------------------------------------------------------------------------
# gpg — extended key management, encryption, and signing operations
# -----------------------------------------------------------------------------
#
# These functions extend the GPG toolset with asymmetric encryption/decryption,
# detached signing, keyserver operations, key expiry checks, and detailed
# fingerprint and identity inspection.
#
# Notable functions:
#   gpg_encrypt_asymmetric — encrypt a file for a specific recipient
#   gpg_sign_detached      — create a detached signature
#   gpg_recv_keyserver     — receive keys from a keyserver
#   gpg_delete_key         — delete a public key
#   gpg_key_details        — show full key details with long ID
#
# Usage examples:
#   $ gpg_encrypt_asymmetric alice@example.com doc.pdf
#   $ gpg_sign_detached release.tar.gz
#
# See also: gpg(1), gpg_agent_ensure()
#

show_date_time() { date '+%A, %B %d, %Y %T %Z'; }
show_timezone() { cat /etc/timezone 2>/dev/null || echo "$TZ"; }
show_uptime() { uptime; }
show_ram_usage() { free -h; }
show_disk_usage() { df -h; }
show_cpu_info() { lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string; }
show_kernel() { uname -r; }
show_os() { uname -a; }
show_host() { hostname; }
show_users() { who; }
show_last() { last -10; }
show_ssh_keys() { ssh-add -l 2>/dev/null || echo "no keys loaded"; }
show_docker_status() { docker info --format '{{.ServerVersion}}' 2>/dev/null || echo "docker not running"; }
show_kubectl_version() { kubectl version --client --short 2>/dev/null || echo "kubectl not found"; }
show_git_config() { git config --list --global 2>/dev/null | sort; }
show_battery_status() { if [ -f /sys/class/power_supply/BAT0/capacity ]; then cat /sys/class/power_supply/BAT0/capacity; elif [ -f /sys/class/power_supply/BAT1/capacity ]; then cat /sys/class/power_supply/BAT1/capacity; fi; }
calc() { echo "$*" | bc -l; }
calc_float() { echo "$*" | bc -l; }
# -----------------------------------------------------------------------------
# docker — advanced run, exec, log, volume, and swarm operations
# -----------------------------------------------------------------------------
#
# These functions extend the Docker toolset with interactive shell access,
# detailed log inspection, formatted ps output, image management, build cache
# pruning, volume backup/restore, Docker Compose lifecycle options, Swarm
# mode operations, secret/config management, and plugin management.
#
# Notable functions:
#   docker_run_shell       — run a container with an interactive shell
#   docker_logs_timestamps — show logs with timestamps
#   docker_ps_format       — formatted container listing
#   docker_image_dangling  — list dangling images
#   docker_volume_backup   — backup a volume to a tar.gz file
#   docker_swarm_init      — initialise a Docker Swarm cluster
#
# Usage examples:
#   $ docker_run_shell alpine
#   $ docker_volume_backup my_volume
#   $ docker_swarm_init 192.168.1.10
#
# See also: docker(1), docker_compose_*
#

calc_int() { printf "%.0f\n" $(echo "$*" | bc -l 2>/dev/null) 2>/dev/null; }
calc_sci() { echo "$*" | bc -l; }
hex_to_dec() { printf "%d\n" "0x$1" 2>/dev/null; }
dec_to_hex() { printf "%x\n" "$1" 2>/dev/null; }
bin_to_dec() { echo "$((2#$1))" 2>/dev/null; }
dec_to_bin() { python3 -c "print(bin($1)[2:])" 2>/dev/null; }
byte_convert() { python3 -c "size=$1; units=['B','KB','MB','GB','TB']; i=0; while size>1024 and i<4: size/=1024; i+=1; print(f'{size:.2f} {units[i]}')" 2>/dev/null; }
time_convert() { python3 -c "s=$1; h=s//3600; m=(s%3600)//60; s=s%60; print(f'{h}h {m}m {s}s')" 2>/dev/null; }
csv_sum() { awk -F, "{sum+=\$$1} END {print sum}" "$2"; }
csv_avg() { awk -F, "{sum+=\$$1; count++} END {print sum/count}" "$2"; }
csv_max() { awk -F, "NR==1||\$$1>max{max=\$$1} END {print max}" "$2"; }
csv_min() { awk -F, "NR==1||\$$1<min{min=\$$1} END {print min}" "$2"; }
csv_head() { head -n "${2:-10}" "$1" | column -t -s,; }
csv_tail() { tail -n "${2:-10}" "$1" | column -t -s,; }
csv_cols() { head -1 "$1" | tr ',' '\n' | nl; }
docker_compose_ps_all() { docker compose ps -a 2>/dev/null; }
docker_compose_images() { docker compose images 2>/dev/null; }
docker_compose_config() { docker compose config 2>/dev/null; }
docker_compose_top_all() { docker compose top 2>/dev/null; }
docker_container_inspect() { docker inspect "$1"; }
docker_container_ip() { docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"; }
docker_image_history() { docker history "$1"; }
docker_image_inspect() { docker inspect "$1"; }
docker_network_inspect() { docker network inspect "$1"; }
docker_volume_inspect() { docker volume inspect "$1"; }
docker_compose_build_all() { docker compose build 2>/dev/null; }
docker_compose_pull_all() { docker compose pull 2>/dev/null; }
docker_compose_create_all() { docker compose create 2>/dev/null; }
docker_compose_start_all() { docker compose start 2>/dev/null; }
docker_compose_kill_all() { docker compose kill 2>/dev/null; }
docker_compose_pause_all() { docker compose pause 2>/dev/null; }
docker_compose_unpause_all() { docker compose unpause 2>/dev/null; }
docker_system_prune_all() { docker system prune -af --volumes 2>/dev/null; }
kubectl_get_pod_yaml() { kubectl get pod "$1" -o yaml; }
kubectl_get_svc_yaml() { kubectl get svc "$1" -o yaml; }
kubectl_get_deploy_yaml() { kubectl get deployment "$1" -o yaml; }
kubectl_get_all_yaml() { kubectl get all -o yaml; }
kubectl_describe_node() { kubectl describe node "$1"; }
kubectl_describe_svc() { kubectl describe svc "$1"; }
kubectl_describe_deploy() { kubectl describe deployment "$1"; }
kubectl_logs_multiple() { kubectl logs "$1" --tail="${2:-100}" "${@:3}"; }
kubectl_exec_command() { kubectl exec -it "$1" -- "$@"; }
kubectl_scale_to_replicas() { kubectl scale "$1" "$2" --replicas="$3"; }
kubectl_label_add() { kubectl label "$1" "$2" "$3"; }
kubectl_label_remove() { kubectl label "$1" "$2" "$3"-; }
kubectl_annotate_add() { kubectl annotate "$1" "$2" "$3"; }
kubectl_rollback() { kubectl rollout undo "$1"; }
kubectl_watch_pods() { kubectl get pods -w; }
kubectl_watch_all() { kubectl get all -w; }
kubectl_proxy_start() { kubectl proxy; }
kubectl_port_forward_all() { kubectl port-forward "$1" "$2":"$3"; }

get_cpu_info() { lscpu 2>/dev/null | head -20 || sysctl -n machdep.cpu.brand_string; }
get_memory_info() { free -h 2>/dev/null || vm_stat; }
get_disk_info() { df -h 2>/dev/null; }
get_network_info() { ip -br addr 2>/dev/null || ifconfig; }
get_system_load() { uptime; }
get_running_processes() { ps aux | head -20; }
get_listening_ports() { ss -tlnp 2>/dev/null || netstat -tlnp; }
get_logged_in_users() { who; }
get_last_reboot() { who -b; }
get_uptime_pretty() { uptime | sed 's/.*up //; s/,//g'; }
get_installed_packages() { pacman -Q 2>/dev/null | wc -l || dpkg -l 2>/dev/null | wc -l || brew list 2>/dev/null | wc -l; }
get_battery_percent() { if [ -f /sys/class/power_supply/BAT0/capacity ]; then cat /sys/class/power_supply/BAT0/capacity; elif [ -f /sys/class/power_supply/BAT1/capacity ]; then cat /sys/class/power_supply/BAT1/capacity; elif command -v pmset >/dev/null 2>&1; then pmset -g batt 2>/dev/null | grep -o '[0-9]*%' | tr -d '%'; fi; }
get_battery_status() { if [ -f /sys/class/power_supply/BAT0/status ]; then cat /sys/class/power_supply/BAT0/status; elif [ -f /sys/class/power_supply/BAT1/status ]; then cat /sys/class/power_supply/BAT1/status; elif command -v pmset >/dev/null 2>&1; then pmset -g batt 2>/dev/null | grep -o 'charging\|discharging\|AC'; fi; }
get_temperature_info() { if [ -f /sys/class/thermal/thermal_zone0/temp ]; then echo "$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))°C"; fi; }
get_gpu_info() { lspci | grep -i vga 2>/dev/null || true; }
get_disk_usage_root() { df -h /; }
get_swap_usage() { free -h | awk '/Swap/ {print $3 "/" $2}'; }
get_shell_process() { ps -p $$ -o comm=; }
get_display_info() { echo "${DISPLAY:-:0}"; }

tar_compress() { tar -czf "${2:-$1.tar.gz}" "$1"; }
tar_decompress() { tar -xzf "$1"; }
tar_list() { tar -tzf "$1"; }
# -----------------------------------------------------------------------------
# kubectl — namespace-scoped resource management and configuration
# -----------------------------------------------------------------------------
#
# These kubectl functions manage resources within a specific namespace:
# creating cronjobs, jobs, deployments, services, and ingresses; updating
# images and environment variables; autoscaling; node cordoning; config
# operations; API discovery; shell completion generation; and pod readiness
# waiting.
#
# Notable functions:
#   kubectl_get_pods_ns       — get pods in a namespace
#   kubectl_create_cronjob    — create a cronjob
#   kubectl_set_image         — update deployment image
#   kubectl_autoscale_deployment — enable autoscaling
#   kubectl_wait_pod_ready    — wait until a pod is ready
#   kubectl_completion_bash   — generate bash completion script
#
# Usage examples:
#   $ kubectl_get_pods_ns production
#   $ kubectl_set_image myapp nginx:1.25
#   $ kubectl_wait_pod_ready my-pod 60
#
# See also: kubectl(1), helm_*
#

tar_compress_bz2() { tar -cjf "${2:-$1.tar.bz2}" "$1"; }
tar_compress_xz() { tar -cJf "${2:-$1.tar.xz}" "$1"; }
tar_decompress_bz2() { tar -xjf "$1"; }
tar_decompress_xz() { tar -xJf "$1"; }
gzip_compress() { gzip "$1"; }
gzip_decompress() { gunzip "$1"; }
gzip_level() { gzip -"${2:-6}" "$1"; }
bzip2_compress() { bzip2 "$1"; }
bzip2_decompress() { bunzip2 "$1"; }
bzip2_level() { bzip2 -"${2:-9}" "$1"; }
xz_compress() { xz "$1"; }
xz_decompress() { unxz "$1"; }
xz_level() { xz -"${2:-6}" "$1"; }
zip_compress() { zip -r "$1.zip" "$1"; }
zip_decompress() { unzip "$1"; }
zip_list() { unzip -l "$1"; }
zip_encrypt() { zip -er "$1.zip" "$1"; }
7z_compress() { 7z a "$1.7z" "$1"; }
7z_decompress() { 7z x "$1"; }
7z_list() { 7z l "$1"; }
7z_encrypt() { 7z a -p "$1.7z" "$1"; }
rar_decompress() { unrar x "$1"; }
rar_list() { unrar l "$1"; }
uncompress_auto() { case "$1" in *.tar.gz|*.tgz) tar xzf "$1";; *.tar.bz2|*.tbz2) tar xjf "$1";; *.tar.xz|*.txz) tar xJf "$1";; *.tar) tar xf "$1";; *.gz) gunzip "$1";; *.bz2) bunzip2 "$1";; *.xz) unxz "$1";; *.zip) unzip "$1";; *.7z) 7z x "$1";; *.rar) unrar x "$1";; *.Z) uncompress "$1";; *) echo "unknown: $1"; return 1;; esac; }

gpg_encrypt_asymmetric() { gpg -e -r "$1" "$2"; }
gpg_decrypt_asymmetric() { gpg -d "$1"; }
gpg_encrypt_sym() { gpg -c "$1"; }
gpg_decrypt_sym() { gpg -d "$1"; }
gpg_sign_detached() { gpg --detach-sign "$1"; }
gpg_verify_detached() { gpg --verify "$1"{,.sig} 2>/dev/null || gpg --verify "$1"{,.asc}; }
gpg_export_key_armor() { gpg --export -a "$1"; }
gpg_export_secret_key_armor() { gpg --export-secret-keys -a "$1"; }
gpg_import_key_armor() { gpg --import "$1"; }
gpg_recv_keyserver() { gpg --keyserver "${2:-keyserver.ubuntu.com}" --recv-keys "$1"; }
gpg_refresh_keyserver() { gpg --keyserver "${1:-keyserver.ubuntu.com}" --refresh-keys; }
gpg_key_details() { gpg --list-keys --keyid-format LONG "$1"; }
gpg_key_fpr() { gpg --fingerprint "$1" | grep -i fingerprint | tr -d ' ' | cut -d= -f2; }
gpg_list_keys_with_id() { gpg --list-keys --keyid-format LONG | grep "^pub\|^sub"; }
gpg_list_keys_with_email() { gpg --list-keys --keyid-format LONG | grep -A1 "^pub" | grep -v "^--"; }
# -----------------------------------------------------------------------------
# helm — advanced chart search, pull, packaging, and dependency management
# -----------------------------------------------------------------------------
#
# These Helm functions extend the toolset with Hub search, chart pulling,
# install/upgrade with various options, release inspection, chart creation,
# packaging, linting, dependency management, and chart metadata display.
#
# Notable functions:
#   helm_search_hub     — search Helm Hub for charts
#   helm_pull_chart     — download and untar a chart
#   helm_get_manifest   — get the manifest of a release
#   helm_create_chart   — scaffold a new chart
#   helm_dep_update     — update chart dependencies
#   helm_show_readme    — display chart README
#
# Usage examples:
#   $ helm_search_hub nginx
#   $ helm_create_chart my-app
#   $ helm_pull_chart bitnami/postgresql
#
# See also: helm(1), kubectl_*
#

gpg_delete_key() { gpg --delete-key "$1"; }
gpg_delete_secret_key() { gpg --delete-secret-key "$1"; }

docker_run_shell() { docker run -it --rm "$1" /bin/sh; }
docker_run_bash() { docker run -it --rm "$1" /bin/bash; }
docker_exec_root() { docker exec -it -u 0 "$1" /bin/sh; }
docker_exec_user() { docker exec -it -u "$2" "$1" /bin/sh; }
docker_logs_tail_n() { docker logs --tail="${2:-100}" "$1"; }
docker_logs_timestamps() { docker logs -t "$1"; }
docker_logs_until() { docker logs --until="$2" "$1"; }
docker_stats_no_stream() { docker stats --no-stream; }
docker_ps_format() { docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"; }
docker_ps_by_image() { docker ps -a --filter ancestor="$1"; }
docker_ps_volume() { docker ps -a --filter volume="$1"; }
docker_ps_network() { docker ps -a --filter network="$1"; }
docker_image_dangling() { docker images -f dangling=true; }
docker_image_by_repo() { docker images "$1"; }
docker_prune_build_cache() { docker builder prune -f; }
docker_system_disk_usage() { docker system df -v; }
docker_compose_down_rmi() { docker compose down --rmi all; }
docker_compose_down_timeout() { docker compose down -t "${1:-10}"; }
docker_compose_events() { docker compose events; }
docker_compose_pause() { docker compose pause; }
docker_compose_unpause() { docker compose unpause; }
# -----------------------------------------------------------------------------
# terraform — extended plan, state, and provider management
# -----------------------------------------------------------------------------
#
# These Terraform functions extend the toolset with targeted applies,
# resource tainting, state manipulation, workspace selection, provider
# locking, dependency graph generation, and console expressions.
#
# Notable functions:
#   terraform_plan_destroy  — plan a destroy operation
#   terraform_apply_target  — apply only a specific resource target
#   terraform_import_resource — import existing infrastructure
#   terraform_graph_deps    — generate dependency graph as PNG
#   terraform_validate_quiet — quick validation check
#
# Usage examples:
#   $ terraform_plan_destroy
#   $ terraform_import_resource aws_instance.web i-12345
#   $ terraform_graph_deps
#
# See also: terraform(1), aws_*, gcloud_*
#

docker_compose_kill() { docker compose kill; }
docker_compose_scale() { docker compose scale "$@"; }
docker_compose_version() { docker compose version; }
docker_save_gz() { docker save "$1" | gzip > "${2:-$1}.tar.gz"; }
docker_load_gz() { gunzip -c "$1" | docker load; }
docker_container_port() { docker port "$1"; }
docker_container_diff() { docker diff "$1"; }
docker_container_top() { docker top "$1"; }
docker_container_rename() { docker rename "$1" "$2"; }
docker_container_pause() { docker pause "$1"; }
docker_container_unpause() { docker unpause "$1"; }
docker_container_wait() { docker wait "$1"; }
docker_container_commit() { docker commit "$1" "$2"; }
docker_container_cp_to() { docker cp "$1" "$2:$3"; }
docker_container_cp_from() { docker cp "$1:$2" "$3"; }
docker_image_build_from() { docker build -f "$1" -t "$2" .; }
docker_image_tag_latest() { docker tag "$1:latest" "$1:$(date +%Y%m%d)"; }
docker_image_squash() { docker build --squash -t "$1" .; }
docker_network_create_bridge() { docker network create -d bridge "$1"; }
docker_network_create_overlay() { docker network create -d overlay "$1"; }
# -----------------------------------------------------------------------------
# gcloud — authentication, config, storage, IAM, serverless, and KMS
# -----------------------------------------------------------------------------
#
# Functions in this category wrap gcloud commands for authentication,
# configuration management, Cloud Storage operations, firewall rules,
# DNS management, IAM service accounts, Cloud Build, Cloud Run, Cloud SQL,
# and Cloud KMS.
#
# Notable functions:
#   gcloud_auth_login       — authenticate with Google Cloud
#   gcloud_config_set_project — set the active project
#   gcloud_storage_buckets  — list storage buckets
#   gcloud_run_deploy       — deploy to Cloud Run
#   gcloud_kms_encrypt      — encrypt with Cloud KMS
#
# Usage examples:
#   $ gcloud_auth_login
#   $ gcloud_config_set_project my-project
#   $ gcloud_run_deploy my-service gcr.io/my-project/my-image
#
# See also: gcloud(1), kubectl_*, terraform_*
#

docker_network_connect() { docker network connect "$1" "$2"; }
docker_network_disconnect() { docker network disconnect "$1" "$2"; }
docker_network_prune() { docker network prune -f; }
docker_volume_create_named() { docker volume create "$1"; }
docker_volume_backup() { docker run --rm -v "$1":/data -v "$(pwd)":/backup alpine tar czf /backup/"$1-$(date +%Y%m%d).tar.gz" -C /data .; }
docker_volume_restore() { docker run --rm -v "$1":/data -v "$(pwd)":/backup alpine tar xzf /backup/"$2" -C /data; }
docker_compose_up_recreate() { docker compose up --force-recreate -d; }
docker_compose_up_scale() { docker compose up -d --scale "$1=$2"; }

docker_build_prune_all() { docker buildx prune -af; }
docker_build_prune_cache() { docker builder prune -f; }
docker_system_events_since() { docker system events --since "$1"; }
docker_system_events_until() { docker system events --until "$1"; }
docker_system_info_format() { docker info --format "$1"; }
docker_swarm_init() { docker swarm init --advertise-addr "$1"; }
docker_swarm_leave() { docker swarm leave --force; }
docker_swarm_join() { docker swarm join-token "$1"; }
docker_swarm_node_ls() { docker node ls; }
docker_swarm_service_ls() { docker service ls; }
docker_swarm_service_create() { docker service create --name "$1" "$2"; }
docker_swarm_stack_deploy() { docker stack deploy -c "$1" "$2"; }
docker_swarm_stack_ls() { docker stack ls; }
docker_swarm_stack_rm() { docker stack rm "$1"; }
docker_swarm_stack_services() { docker stack services "$1"; }
docker_swarm_stack_ps() { docker stack ps "$1"; }
docker_secret_create() { printf "%s" "$2" | docker secret create "$1" -; }
docker_secret_ls() { docker secret ls; }
docker_config_create() { docker config create "$1" "$2"; }
docker_config_ls() { docker config ls; }
# -----------------------------------------------------------------------------
# aws — EC2, S3, Lambda, IAM, ECS, EKS, RDS, and infrastructure services
# -----------------------------------------------------------------------------
#
# These AWS functions wrap EC2 instance lifecycle management, S3 bucket
# operations, Lambda invocation, IAM listing, CloudWatch log inspection,
# Route53 DNS, CloudFront invalidation, SQS/SNS messaging, DynamoDB CRUD,
# ECR/ECS/EKS cluster management, RDS snapshots, and more.
#
# Notable functions:
#   aws_ec2_start           — start an EC2 instance
#   aws_ec2_instances       — list all EC2 instances
#   aws_s3_presign          — generate a presigned S3 URL
#   aws_lambda_invoke       — invoke a Lambda function
#   aws_iam_users           — list IAM users
#   aws_eks_update_kubeconfig — update kubeconfig for an EKS cluster
#
# Usage examples:
#   $ aws_ec2_start i-1234567890abcdef0
#   $ aws_s3_presign my-bucket secret.pdf 3600
#   $ aws_eks_update_kubeconfig my-cluster
#
# See also: aws(1), terraform_*
#

docker_plugin_ls() { docker plugin ls; }
docker_plugin_install() { docker plugin install "$1"; }
docker_plugin_disable() { docker plugin disable "$1"; }
docker_plugin_remove() { docker plugin rm "$1"; }

kubectl_get_pods_ns() { kubectl get pods -n "$1"; }
kubectl_get_svc_ns() { kubectl get svc -n "$1"; }
kubectl_get_deploy_ns() { kubectl get deployments -n "$1"; }
kubectl_get_configmap_ns() { kubectl get configmap -n "$1"; }
kubectl_get_secret_ns() { kubectl get secret -n "$1"; }
kubectl_get_ingress_ns() { kubectl get ingress -n "$1"; }
kubectl_get_pvc_ns() { kubectl get pvc -n "$1"; }
kubectl_get_hpa_ns() { kubectl get hpa -n "$1"; }
kubectl_create_cronjob() { kubectl create cronjob "$1" --image="$2" --schedule="$3" -- "$4"; }
kubectl_create_job() { kubectl create job "$1" --image="$2" -- "$3"; }
kubectl_create_deployment() { kubectl create deployment "$1" --image="$2"; }
kubectl_create_service_nodeport() { kubectl create service nodeport "$1" --tcp="$2:$3"; }
kubectl_create_service_clusterip() { kubectl create service clusterip "$1" --tcp="$2:$3"; }
kubectl_create_ingress() { kubectl create ingress "$1" --rule="$2/$3=$4:$5"; }
kubectl_set_image() { kubectl set image deployment/"$1" "$2=$3"; }
kubectl_set_env() { kubectl set env deployment/"$1" "$2=$3"; }
kubectl_set_resources() { kubectl set resources deployment/"$1" --limits="$2" --requests="$3"; }
kubectl_autoscale_deployment() { kubectl autoscale deployment "$1" --min="$2" --max="$3" --cpu-percent="$4"; }
kubectl_get_events_warn_ns() { kubectl get events -n "$1" --field-selector type=Warning --sort-by=.lastTimestamp; }
kubectl_cordon_all() { kubectl get nodes -o name | xargs -r kubectl cordon; }
kubectl_uncordon_all() { kubectl get nodes -o name | xargs -r kubectl uncordon; }
kubectl_node_ready() { kubectl get nodes | grep -c Ready || true; }
kubectl_node_details() { kubectl describe node "$1"; }
kubectl_top_node_sort() { kubectl top node --sort-by="$1"; }
kubectl_config_view() { kubectl config view; }
kubectl_config_rename_context() { kubectl config rename-context "$1" "$2"; }
kubectl_config_delete_context() { kubectl config delete-context "$1"; }
kubectl_config_use_namespace() { kubectl config set-context --namespace="$1"; }
kubectl_auth_reconcil() { kubectl auth reconcile -f "$1"; }
kubectl_api_versions() { kubectl api-versions; }
kubectl_completion_bash() { kubectl completion bash; }
kubectl_completion_zsh() { kubectl completion zsh; }
kubectl_completion_fish() { kubectl completion fish; }
kubectl_plugin_list() { kubectl plugin list; }
kubectl_cp_pod_to_local() { kubectl cp "$1:$2" "$3"; }
kubectl_cp_local_to_pod() { kubectl cp "$1" "$2:$3"; }
kubectl_wait_pod_ready() { kubectl wait --for=condition=Ready pod "$1" --timeout="${2:-300}s"; }
kubectl_wait_deploy_ready() { kubectl wait --for=condition=Available deployment/"$1" --timeout="${2:-300}s"; }
kubectl_wait_node_ready() { kubectl wait --for=condition=Ready node "$1" --timeout="${2:-300}s"; }

helm_search_hub() { helm search hub "$1"; }
helm_search_all() { helm search repo "$1" --versions; }
helm_pull_chart() { helm pull "$1" --untar; }
helm_pull_chart_version() { helm pull "$1" --version "$2" --untar; }
helm_install_chart() { helm install "$1" "$2" -n "$3" --create-namespace; }
helm_upgrade_release() { helm upgrade "$1" "$2"; }
helm_upgrade_install() { helm upgrade --install "$1" "$2"; }
helm_rollback_revision() { helm rollback "$1" "$2"; }
helm_list_releases() { helm list; }
helm_list_releases_ns() { helm list -n "$1"; }
helm_get_manifest() { helm get manifest "$1"; }
helm_get_notes() { helm get notes "$1"; }
helm_get_hooks() { helm get hooks "$1"; }
# -----------------------------------------------------------------------------
# python — pip, pipx, virtualenv, pytest, ruff, and poetry integration
# -----------------------------------------------------------------------------
#
# These extended Python functions cover additional pip installation modes
# (global, user, editable, dev requirements), pipx for isolated app
# installation, virtualenv creation variants, advanced pytest options
# (verbose, fail-fast, parallel, coverage HTML, last-failed), ruff linting
# and formatting, and Poetry dependency management.
#
# Notable functions:
#   pip_install_user       — install packages in user site-packages
#   pip_upgrade_all        — upgrade all outdated pip packages
#   pipx_install           — install a package via pipx
#   pytest_run_parallel    — run tests in parallel with pytest-xdist
#   ruff_check             — run ruff linter
#   poetry_install         — install project dependencies with Poetry
#   pyenv_install_python   — install a Python version via pyenv
#   conda_env_create       — create a conda environment
#
# Usage examples:
#   $ pip_install_user requests
#   $ pytest_run_parallel tests/
#   $ poetry_add_dev pytest
#
# See also: python(1), pip(1), pipx(1), pyenv(1)
#

helm_status_release() { helm status "$1"; }
helm_test_ns() { helm test "$1" -n "$2"; }
helm_create_chart() { helm create "$1"; }
helm_package_chart() { helm package "$1"; }
helm_lint_chart() { helm lint "$1"; }
helm_dep_update() { helm dependency update "$1"; }
helm_dep_build() { helm dependency build "$1"; }
helm_show_chart() { helm show chart "$1"; }
helm_show_values() { helm show values "$1"; }
helm_show_readme() { helm show readme "$1"; }

terraform_plan_destroy() { terraform plan -destroy -out=tfplan; }
terraform_apply_target() { terraform apply -target="$1"; }
terraform_taint_resource() { terraform taint "$1"; }
terraform_untaint_resource() { terraform untaint "$1"; }
terraform_import_resource() { terraform import "$1" "$2"; }
terraform_output_raw() { terraform output -json; }
terraform_state_list() { terraform state list; }
terraform_state_rm() { terraform state rm "$1"; }
terraform_state_mv() { terraform state mv "$1" "$2"; }
terraform_state_show() { terraform state show "$1"; }
terraform_workspace_select() { terraform workspace select "$1"; }
terraform_workspace_delete() { terraform workspace delete "$1"; }
terraform_version_check() { terraform version; }
terraform_providers_list() { terraform providers; }
terraform_lock_hcl() { terraform providers lock; }
terraform_graph_deps() { terraform graph | dot -Tpng > graph.png; }
terraform_console_expr() { terraform console <<<"$1"; }
terraform_get_modules() { terraform get -update; }
terraform_validate_quiet() { terraform validate -no-color >/dev/null 2>&1 && echo "valid" || echo "invalid"; }

gcloud_auth_login() { gcloud auth login; }
gcloud_auth_list() { gcloud auth list; }
gcloud_auth_application() { gcloud auth application-default login; }
gcloud_config_list() { gcloud config list; }
gcloud_config_set() { gcloud config set "$1" "$2"; }
gcloud_config_set_project() { gcloud config set project "$1"; }
gcloud_config_set_region() { gcloud config set compute/region "$1"; }
gcloud_config_set_zone() { gcloud config set compute/zone "$1"; }
gcloud_storage_list() { gcloud storage ls; }
gcloud_storage_cp() { gcloud storage cp "$1" "$2"; }
gcloud_storage_rsync() { gcloud storage rsync "$1" "$2"; }
gcloud_storage_buckets() { gcloud storage buckets list; }
gcloud_firewall_list() { gcloud compute firewall-rules list; }
gcloud_firewall_create() { gcloud compute firewall-rules create "$1" --allow "$2"; }
gcloud_dns_list() { gcloud dns managed-zones list; }
# -----------------------------------------------------------------------------
# node.js — advanced npm, pnpm, yarn, and TypeScript tooling
# -----------------------------------------------------------------------------
#
# These extended Node.js functions cover project initialisation (npm init,
# TypeScript setup), package installation modes (local, dev, global,
# optional), running scripts, publishing, linking, access control, and
# registry management. Also covers pnpm commands (install, add, remove,
# store), yarn (workspaces, immutable installs), nvm (remote listing, LTS),
# and advanced node/TypeScript utilities.
#
# Notable functions:
#   npm_init_project       — initialise a package.json
#   npm_init_ts            — initialise with TypeScript
#   npm_install_pkg        — install a package
#   npm_run_dev            — run the dev script
#   npm_publish_pkg        — publish to npm registry
#   pnpm_install           — install dependencies with pnpm
#   yarn_workspace_run     — run a script in a yarn workspace
#   nvm_install_lts        — install the latest LTS Node version
#   tsc_compile            — compile TypeScript with tsc
#
# Usage examples:
#   $ npm_init_ts
#   $ npm_install_pkg express
#   $ nvm_install_lts
#   $ tsc_noemit
#
# See also: node(1), npm(1), nvm(1), pnpm(1), yarn(1)
#

gcloud_dns_records() { gcloud dns record-sets list --zone="$1"; }
gcloud_iam_list() { gcloud iam service-accounts list; }
gcloud_iam_create() { gcloud iam service-accounts create "$1"; }
gcloud_iam_keys() { gcloud iam service-accounts keys list --iam-account="$1"; }
gcloud_build_submit() { gcloud builds submit --tag "$1"; }
gcloud_build_list() { gcloud builds list; }
gcloud_run_deploy() { gcloud run deploy "$1" --image "$2" --platform managed; }
gcloud_run_list() { gcloud run services list; }
gcloud_sql_list() { gcloud sql instances list; }
gcloud_sql_connect() { gcloud sql connect "$1" --user="$2"; }
gcloud_kms_list() { gcloud kms keyrings list --location="$1"; }
gcloud_kms_encrypt() { gcloud kms encrypt --location="$1" --keyring="$2" --key="$3" --plaintext-file="$4" --ciphertext-file="$5"; }
gcloud_kms_decrypt() { gcloud kms decrypt --location="$1" --keyring="$2" --key="$3" --ciphertext-file="$4" --plaintext-file="$5"; }

aws_ec2_start() { aws ec2 start-instances --instance-ids "$1"; }
aws_ec2_stop() { aws ec2 stop-instances --instance-ids "$1"; }
aws_ec2_reboot() { aws ec2 reboot-instances --instance-ids "$1"; }
aws_ec2_terminate() { aws ec2 terminate-instances --instance-ids "$1"; }
aws_ec2_instances() { aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,LaunchTime]' --output table; }
aws_ec2_instances_running() { aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,LaunchTime]' --output table; }
aws_ec2_instances_stopped() { aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,LaunchTime]' --output table; }
aws_ec2_keypairs() { aws ec2 describe-key-pairs --query 'KeyPairs[*].[KeyName,KeyType]' --output table; }
aws_ec2_security_groups() { aws ec2 describe-security-groups --query 'SecurityGroups[*].[GroupName,GroupId,VpcId]' --output table; }
aws_ec2_volumes() { aws ec2 describe-volumes --query 'Volumes[*].[VolumeId,Size,State,AvailabilityZone]' --output table; }
aws_ec2_snapshots() { aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[*].[SnapshotId,VolumeSize,StartTime]' --output table; }
aws_ec2_subnets() { aws ec2 describe-subnets --query 'Subnets[*].[SubnetId,CidrBlock,AvailabilityZone]' --output table; }
aws_s3_buckets() { aws s3api list-buckets --query 'Buckets[*].Name' --output table; }
aws_s3_size() { aws s3api list-objects --bucket "$1" --output json --query "[sum(Contents[].Size)]" 2>/dev/null || echo "empty or no access"; }
aws_s3_presign() { aws s3 presign "s3://$1/$2" --expires-in "${3:-3600}"; }
aws_s3_website() { aws s3 website "s3://$1" --index-document index.html --error-document error.html; }
aws_lambda_invoke() { aws lambda invoke --function-name "$1" response.json && cat response.json && rm -f response.json; }
aws_lambda_list() { aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime]' --output table; }
aws_lambda_logs() { aws logs filter-log-events --log-group-name "/aws/lambda/$1" --limit "${2:-50}" --query 'events[*].[timestamp,message]' --output text; }
aws_iam_users() { aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table; }
aws_iam_roles() { aws iam list-roles --query 'Roles[*].[RoleName,CreateDate]' --output table; }
aws_iam_policies() { aws iam list-policies --scope Local --query 'Policies[*].[PolicyName,CreateDate]' --output table; }
aws_iam_groups() { aws iam list-groups --query 'Groups[*].[GroupName,CreateDate]' --output table; }
aws_logs_groups() { aws logs describe-log-groups --query 'logGroups[*].[logGroupName,storedBytes]' --output table; }
aws_logs_tail() { aws logs tail "$1" --follow; }
aws_logs_filter() { aws logs filter-log-events --log-group-name "$1" --filter-pattern "$2" --limit "${3:-50}" --output text; }
aws_route53_zones() { aws route53 list-hosted-zones --query 'HostedZones[*].[Name,Id]' --output table; }
aws_route53_records() { aws route53 list-resource-record-sets --hosted-zone-id "$1" --query 'ResourceRecordSets[*].[Name,Type]' --output table; }
aws_cf_list() { aws cloudfront list-distributions --query 'DistributionList.Items[*].[Id,DomainName,Status]' --output table; }
aws_cf_invalidate() { aws cloudfront create-invalidation --distribution-id "$1" --paths "$2"; }
aws_sqs_list() { aws sqs list-queues --query 'QueueUrls[*]' --output table; }
aws_sqs_send() { aws sqs send-message --queue-url "$1" --message-body "$2"; }
aws_sns_topics() { aws sns list-topics --query 'Topics[*].TopicArn' --output table; }
aws_sns_publish() { aws sns publish --topic-arn "$1" --message "$2"; }
aws_dynamo_list() { aws dynamodb list-tables --query 'TableNames[*]' --output table; }
aws_dynamo_scan() { aws dynamodb scan --table-name "$1" --limit "${2:-20}" --output table; }
aws_dynamo_get() { aws dynamodb get-item --table-name "$1" --key "$2" --output table; }
aws_dynamo_put() { aws dynamodb put-item --table-name "$1" --item "$2"; }
aws_dynamo_delete() { aws dynamodb delete-item --table-name "$1" --key "$2"; }
aws_cw_alarms() { aws cloudwatch describe-alarms --query 'MetricAlarms[*].[AlarmName,StateValue]' --output table; }
aws_cw_metrics() { aws cloudwatch list-metrics --namespace "$1" --limit "${2:-20}" --output table; }
aws_cw_logs() { aws logs describe-log-groups --query 'logGroups[*].[logGroupName]' --output table; }
aws_ecr_repos() { aws ecr describe-repositories --query 'repositories[*].[repositoryName,repositoryUri]' --output table; }
aws_ecr_images() { aws ecr list-images --repository-name "$1" --query 'imageIds[*].[imageTag]' --output table; }
aws_ecr_login() { aws ecr get-login-password --region "$1" | docker login --username AWS --password-stdin "$2"; }
aws_ecs_clusters() { aws ecs list-clusters --query 'clusterArns[*]' --output table; }
aws_ecs_services() { aws ecs list-services --cluster "$1" --query 'serviceArns[*]' --output table; }
aws_ecs_tasks() { aws ecs list-tasks --cluster "$1" --query 'taskArns[*]' --output table; }
aws_ecs_describe() { aws ecs describe-services --cluster "$1" --services "$2" --output table; }
aws_eks_clusters() { aws eks list-clusters --query 'clusters[*]' --output table; }
aws_eks_update_kubeconfig() { aws eks update-kubeconfig --name "$1"; }
aws_elasticache_clusters() { aws elasticache describe-cache-clusters --query 'CacheClusters[*].[CacheClusterId,Engine,CacheNodeType]' --output table; }
aws_rds_instances() { aws rds describe-db-instances --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceClass,Engine,DBInstanceStatus]' --output table; }
aws_rds_snapshots() { aws rds describe-db-snapshots --query 'DBSnapshots[*].[DBSnapshotIdentifier,DBInstanceIdentifier,SnapshotCreateTime]' --output table; }
aws_stepfunctions_list() { aws stepfunctions list-state-machines --query 'stateMachines[*].[name,creationDate]' --output table; }
aws_apigateway_apis() { aws apigatewayv2 get-apis --query 'Items[*].[Name,ProtocolType,ApiId]' --output table; }
aws_cognito_pools() { aws cognito-idp list-user-pools --max-results 20 --query 'UserPools[*].[Name,Id]' --output table; }

pip_install_global() { pip install "$@" 2>/dev/null || pip3 install "$@"; }
pip_install_user() { pip install --user "$@" 2>/dev/null || pip3 install --user "$@"; }
pip_install_editable() { pip install -e "$1" 2>/dev/null || pip3 install -e "$1"; }
pip_install_reqs_dev() { pip install -r requirements-dev.txt 2>/dev/null || pip3 install -r requirements-dev.txt; }
pip_uninstall_pkg() { pip uninstall -y "$1" 2>/dev/null || pip3 uninstall -y "$1"; }
pip_upgrade_all() { pip list --outdated --format=freeze 2>/dev/null | cut -d= -f1 | xargs -r pip install --upgrade; }
pip_upgrade_pkg() { pip install --upgrade "$1" 2>/dev/null || pip3 install --upgrade "$1"; }
pip_install_pipx() { pipx install "$1"; }
pipx_list_all() { pipx list; }
pipx_run_bin() { pipx run "$1"; }
pipx_upgrade_all() { pipx upgrade-all; }
venv_create_python() { python3 -m venv "$1"; }
venv_create_system() { virtualenv -p "$(which python3)" "$1"; }
venv_list_packages() { pip list --format=columns 2>/dev/null; }
venv_export_reqs() { pip freeze > "${1:-requirements.txt}"; }
pytest_run_verbose() { python3 -m pytest -v "$@"; }
pytest_run_failfast() { python3 -m pytest -x "$@"; }
pytest_run_parallel() { python3 -m pytest -n auto "$@"; }
pytest_run_coverage_html() { python3 -m pytest --cov --cov-report=html "$@"; }
pytest_run_last_failed() { python3 -m pytest --lf "$@"; }
ruff_check() { python3 -m ruff check "$@"; }
ruff_format() { python3 -m ruff format "$@"; }
ruff_fix() { python3 -m ruff check --fix "$@"; }
poetry_install() { poetry install; }
# -----------------------------------------------------------------------------
# rust — advanced cargo project, dependency, and workspace management
# -----------------------------------------------------------------------------
#
# These extended Rust/Cargo functions cover project scaffolding (cargo new,
# init), dependency management (add, rm, upgrade), workspace creation,
# running examples and binaries, advanced testing (doc tests, ignored),
# benchmarking, metadata inspection, vendoring, publishing operations,
# licensing, and linting.
#
# Notable functions:
#   cargo_new_project      — create a new Rust project
#   cargo_add_dep          — add a dependency
#   cargo_run_example      — run an example binary
#   cargo_test_doc         — run documentation tests
#   cargo_fix_all          — auto-fix compiler warnings
#   cargo_publish_dryrun   — dry-run publish to crates.io
#   cargo_licenses         — list dependency licenses
#
# Usage examples:
#   $ cargo_new_project my-app
#   $ cargo_add_dep serde
#   $ cargo_test_doc
#   $ cargo_fix_all
#
# See also: cargo(1), rustc(1)
#

poetry_add() { poetry add "$1"; }
poetry_add_dev() { poetry add --dev "$1"; }
poetry_build() { poetry build; }
poetry_publish() { poetry publish; }
poetry_update_lock() { poetry update; }
poetry_export_reqs() { poetry export -f requirements.txt -o requirements.txt; }
poetry_shell() { poetry shell; }
poetry_run_dev() { poetry run python "$@"; }
pyenv_versions() { pyenv versions; }
pyenv_global() { pyenv global "$1"; }
pyenv_local() { pyenv local "$1"; }
pyenv_install_python() { pyenv install "$1"; }
pyenv_uninstall_python() { pyenv uninstall "$1"; }
pyenv_virtualenv_create() { pyenv virtualenv "$1" "$2"; }
pyenv_virtualenv_activate() { pyenv activate "$1"; }
pyenv_virtualenv_deactivate() { pyenv deactivate; }
conda_env_create() { conda create -n "$1" python="$2"; }
conda_env_remove() { conda env remove -n "$1"; }
conda_env_list() { conda env list; }
conda_install_pkg() { conda install "$1"; }
conda_update_all() { conda update --all; }

npm_init_project() { npm init -y; }
npm_init_ts() { npm init -y && npm install typescript @types/node --save-dev; }
npm_install_pkg() { npm install "$1"; }
npm_install_dev() { npm install --save-dev "$1"; }
npm_install_global() { npm install -g "$1"; }
npm_install_optional() { npm install --save-optional "$1"; }
npm_uninstall_pkg() { npm uninstall "$1"; }
npm_update_pkg() { npm update "$1"; }
npm_update_all() { npm update; }
# -----------------------------------------------------------------------------
# go — advanced testing, cross-compilation, modules, and profiling
# -----------------------------------------------------------------------------
#
# These extended Go functions cover advanced testing (short, benchmark,
# coverage HTML/functional reports), cross-compilation for multiple
# platforms (Linux, macOS, Windows), module management (download, verify,
# why), workspace mode (use, init, sync), and profiling tools (pprof,
# trace, objdump, covdata).
#
# Notable functions:
#   go_test_short          — run short tests only
#   go_test_cover_html     — generate HTML coverage report
#   go_build_linux         — cross-compile for Linux amd64
#   go_build_darwin        — cross-compile for macOS arm64
#   go_mod_verify          — verify module checksums
#   go_work_init           — initialise a Go workspace
#   go_tool_pprof          — run pprof profiling tool
#
# Usage examples:
#   $ go_test_cover_html
#   $ go_build_cross myapp
#   $ go_mod_verify
#   $ go_tool_pprof cpu.pprof
#
# See also: go(1), go-mod(1)
#

npm_run_dev() { npm run dev; }
npm_run_build() { npm run build; }
npm_run_test() { npm run test; }
npm_run_lint() { npm run lint; }
npm_run_typecheck() { npm run typecheck; }
npm_run_start() { npm run start; }
npm_publish_pkg() { npm publish; }
npm_publish_dryrun() { npm publish --dry-run; }
npm_unpublish_pkg() { npm unpublish "$1"; }
npm_link_global() { npm link; }
npm_unlink_global() { npm unlink; }
npm_link_pkg() { npm link "$1"; }
npm_whoami() { npm whoami; }
npm_token_list() { npm token list; }
npm_token_create() { npm token create; }
npm_token_delete() { npm token delete "$1"; }
npm_team_list() { npm team list "$1"; }
npm_access_list() { npm access list packages "$1"; }
npm_view_pkg() { npm view "$1"; }
npm_search_pkg() { npm search "$1"; }
npm_pack_pkg() { npm pack; }
npm_rebuild_all() { npm rebuild; }
npm_cache_ls() { npm cache ls; }
npm_cache_verify() { npm cache verify; }
# -----------------------------------------------------------------------------
# git — clone, branch, stash, merge, rebase, submodule, and worktree ops
# -----------------------------------------------------------------------------
#
# These extended git functions cover clone variants (GitHub SSH, GitLab,
# Bitbucket, bare, mirror), branch operations (create, switch, rename with
# remote, purge, sort by date), log formatting (patch, stat, short, custom
# format, between, graph-all), diff modes (branches, commits, word-highlight,
# patch), commit helpers (fixup, squash, date stamp, allow-empty), stash
# (with message, apply+drop, branch, clear), remote operations (add origin,
# set-url, rename, remove), merge/rebase variants, submodule management
# (add, remove, deinit, sync, update remote), worktree management, bisect,
# blame, ignore templates, config, notes, replace, archive, fsck, gc, and
# repack.
#
# Notable functions:
#   git_clone_gh_ssh         — clone via SSH from GitHub
#   git_branch_rename_remote — rename branch and update remote
#   git_log_patch            — show log with patch content
#   git_commit_fixup         — create a fixup commit
#   git_stash_branch         — create a branch from a stash
#   git_submodule_remove     — properly remove a submodule
#   git_bisect_start         — start a bisect session
#   git_worktree_remove      — remove a worktree
#   git_gc_aggressive        — aggressive garbage collection
#
# Usage examples:
#   $ git_clone_gh_ssh user/repo
#   $ git_branch_rename_remote old-name new-name
#   $ git_log_patch HEAD~5..HEAD
#   $ git_bisect_start HEAD v1.0
#
# See also: man git, git-config(1)
#

npm_ls_top() { npm ls --depth=0; }
npm_ls_global() { npm ls -g --depth=0; }
npm_fund_pkg() { npm fund "$1"; }
npm_org_list() { npm org ls "$1"; }
npm_stars_pkg() { npm stars "$1"; }
pnpm_install() { pnpm install; }
pnpm_add() { pnpm add "$1"; }
pnpm_add_dev() { pnpm add -D "$1"; }
pnpm_add_global() { pnpm add -g "$1"; }
pnpm_remove() { pnpm remove "$1"; }
pnpm_update() { pnpm update; }
pnpm_run_dev() { pnpm dev; }
pnpm_run_build() { pnpm build; }
pnpm_run_test() { pnpm test; }
pnpm_run_lint() { pnpm lint; }
pnpm_ls_depth() { pnpm ls --depth="$1"; }
pnpm_outdated() { pnpm outdated; }
pnpm_audit() { pnpm audit; }
pnpm_audit_fix() { pnpm audit --fix; }
pnpm_rebuild() { pnpm rebuild; }
pnpm_store_status() { pnpm store status; }
pnpm_store_path() { pnpm store path; }
pnpm_fetch() { pnpm fetch; }
pnpm_pack() { pnpm pack; }
pnpm_publish() { pnpm publish; }
yarn_add_pkg() { yarn add "$1"; }
yarn_add_dev() { yarn add --dev "$1"; }
yarn_remove_pkg() { yarn remove "$1"; }
yarn_install_frozen() { yarn install --frozen-lockfile; }
yarn_install_immutable() { yarn install --immutable; }
yarn_run_dev() { yarn dev; }
yarn_run_build() { yarn build; }
yarn_run_test() { yarn test; }
yarn_run_lint() { yarn lint; }
yarn_run_typecheck() { yarn typecheck; }
yarn_workspace_info() { yarn workspaces info; }
yarn_workspace_run() { yarn workspace "$1" run "$2"; }
yarn_why_pkg() { yarn why "$1"; }
yarn_link_pkg() { yarn link "$1"; }
yarn_unlink_pkg() { yarn unlink "$1"; }
yarn_publish_pkg() { yarn publish; }
yarn_info_pkg() { yarn info "$1"; }
yarn_cache_clean() { yarn cache clean; }
nvm_list_remote() { nvm ls-remote; }
nvm_list_local() { nvm ls; }
nvm_install_lts() { nvm install --lts; }
nvm_use_default() { nvm use default; }
nvm_alias_default() { nvm alias default "$1"; }
nvm_current_version() { nvm current; }
nvm_which_node() { nvm which "$1"; }
nvm_uninstall_node() { nvm uninstall "$1"; }
node_eval() { node -e "$1"; }
node_inspect() { node inspect "$@"; }
node_check_syntax() { node --check "$1"; }
node_print_v8() { node -e "console.log(process.versions.v8)"; }
node_print_versions() { node -e "console.log(process.versions)"; }
tsc_compile() { npx tsc "$@"; }
tsc_init() { npx tsc --init; }
tsc_watch() { npx tsc --watch; }
tsc_noemit() { npx tsc --noEmit; }
tsc_build() { npx tsc --build; }
ts_node_run() { npx ts-node "$@"; }

cargo_new_project() { cargo new "$1"; }
cargo_init_project() { cargo init; }
cargo_add_dep() { cargo add "$1"; }
cargo_add_dev_dep() { cargo add --dev "$1"; }
cargo_add_build_dep() { cargo add --build "$1"; }
cargo_rm_dep() { cargo rm "$1"; }
cargo_upgrade_dep() { cargo upgrade "$1"; }
cargo_upgrade_all() { cargo upgrade; }
cargo_workspace_member() { cargo new "$1" --lib; }
cargo_run_example() { cargo run --example "$1"; }
cargo_run_bin() { cargo run --bin "$1"; }
cargo_test_name() { cargo test "$1"; }
cargo_test_doc() { cargo test --doc; }
cargo_test_ignored() { cargo test -- --ignored; }
cargo_bench() { cargo bench; }
cargo_build_debug() { cargo build; }
cargo_build_release_clean() { cargo build --release && cargo clean; }
cargo_check_warnings() { cargo check -- -W warnings; }
cargo_fix_all() { cargo fix --all-targets --all-features; }
cargo_metadata_deps() { cargo metadata --format-version 1 | python3 -m json.tool; }
cargo_vendor_deps() { cargo vendor; }
cargo_publish_dryrun() { cargo publish --dry-run; }
cargo_owner_list() { cargo owner --list "$1"; }
cargo_owner_add() { cargo owner --add "$1" "$2"; }
cargo_owner_remove() { cargo owner --remove "$1" "$2"; }
cargo_yank_version() { cargo yank --vers "$1" "$2"; }
cargo_unyank_version() { cargo yank --vers "$1" "$2" --undo; }
cargo_workspace_list() { cargo metadata --format-version 1 | python3 -c "import sys,json; ws=json.load(sys.stdin)['workspace_members']; print('\n'.join(ws))" 2>/dev/null; }
cargo_licenses() { cargo license 2>/dev/null || echo "cargo-license not installed"; }
cargo_lint_clippy() { cargo clippy; }
cargo_fmt_rust() { cargo fmt; }
go_test_short() { go test -short ./...; }
go_test_bench() { go test -bench=. ./...; }
go_test_cover_html() { go test -coverprofile=coverage.out ./... && go tool cover -html=coverage.out; }
go_test_cover_func() { go test -coverprofile=coverage.out ./... && go tool cover -func=coverage.out; }
go_build_linux() { GOOS=linux GOARCH=amd64 go build -o "${1:-app}-linux-amd64" .; }
go_build_darwin() { GOOS=darwin GOARCH=arm64 go build -o "${1:-app}-darwin-arm64" .; }
go_build_windows() { GOOS=windows GOARCH=amd64 go build -o "${1:-app}-windows-amd64.exe" .; }
go_build_cross() { go build -o "${1:-app}-linux" . && GOOS=darwin GOARCH=arm64 go build -o "${1:-app}-mac" .; }
go_get_pkg() { go get "$1"; }
go_install_tool() { go install "$1@latest"; }
go_doc_view() { go doc "$1"; }
go_doc_start() { godoc -http=:6060 2>/dev/null || echo "godoc not installed"; }
go_clean_modcache() { go clean -modcache; }
go_mod_download() { go mod download; }
go_mod_verify() { go mod verify; }
go_mod_why() { go mod why "$1"; }
go_work_use() { go work use "$1"; }
go_work_init() { go work init "$@"; }
go_work_sync() { go work sync; }
go_tool_pprof() { go tool pprof "$@"; }
go_tool_trace() { go tool trace "$@"; }
go_tool_objdump() { go tool objdump "$1"; }
go_tool_covdata() { go tool covdata "$@"; }
# -----------------------------------------------------------------------------
# systemd — extended service lifecycle, power management, and journal filters
# -----------------------------------------------------------------------------
#
# These extended systemd functions cover service reload, re-enable, preset,
# dependency listing, unit property display, listing units by type, machine
# listing, power management (poweroff, reboot, hibernate, suspend, hybrid
# sleep), and journalctl query variants (user units, priority, time ranges,
# JSON output, catalog, merge, reverse, kernel messages, boot listing).
#
# Notable functions:
#   systemctl_reload_service — reload service configuration
#   systemctl_list_deps      — list unit dependencies
#   systemctl_poweroff       — power off the system
#   journalctl_priority      — show logs by priority level
#   journalctl_kernel        — show kernel messages
#   journalctl_list_boots    — list available boot entries
#
# Usage examples:
#   $ systemctl_list_deps nginx.service
#   $ journalctl_priority err
#   $ journalctl_kernel
#
# See also: systemd(1), journalctl(1)
#


git_clone_github() { git clone "https://github.com/$1.git" "${2:-$(basename "$1")}"; }
git_clone_gh_ssh() { git clone "git@github.com:$1.git" "${2:-$(basename "$1")}"; }
git_clone_gitlab() { git clone "https://gitlab.com/$1.git" "${2:-$(basename "$1")}"; }
git_clone_bitbucket() { git clone "https://bitbucket.org/$1.git" "${2:-$(basename "$1")}"; }
git_clone_bare() { git clone --bare "$1" "${2:-$(basename "$1").git}"; }
git_clone_mirror() { git clone --mirror "$1" "${2:-$(basename "$1").git}"; }
git_branch_create() { git checkout -b "$1"; }
git_branch_switch() { git checkout "$1"; }
git_branch_switch_create() { git checkout -b "$1"; }
git_branch_rename_remote() { git push origin --delete "$1" && git branch -m "$1" "$2" && git push origin -u "$2"; }
git_branch_purge() { git branch -D "$1"; }
git_branch_merged() { git branch --merged; }
git_branch_not_merged() { git branch --no-merged; }
git_branch_tracking() { git branch -vv; }
git_branch_sort() { git branch --sort=-committerdate; }
git_log_stats() { git log --stat --summary "$@"; }
git_log_patch() { git log -p "$@"; }
git_log_short() { git log --oneline --decorate -10; }
git_log_format() { git log --format='%h %an %s' -20; }
git_log_between() { git log --oneline "$1..$2"; }
git_log_graph_all() { git log --oneline --graph --all --decorate; }
git_log_author_date() { git log --author="$1" --format='%h %ad %s' --date=short; }
git_log_diff() { git whatchanged -p "$1"; }
git_diff_staged() { git diff --cached; }
git_diff_unstaged() { git diff; }
# -----------------------------------------------------------------------------
# find — file search by name, size, type, permissions, and metadata
# -----------------------------------------------------------------------------
#
# These functions use the find command to locate files by various criteria:
# name patterns, regex, size ranges, file type, permissions, inode number,
# depth, owner, group, modification/access/change time, broken symlinks,
# SUID/SGID binaries, world-writable files, large files, and recent changes.
#
# Notable functions:
#   find_by_name        — find files by name pattern
#   find_by_size        — find files within a size range
#   find_broken_symlinks — find dangling symbolic links
#   find_suid_binaries  — find SUID-root binaries (security)
#   find_large_files    — find files larger than a threshold
#   find_exec_command   — find and exec a command on matches
#
# Usage examples:
#   $ find_by_name "*.py" src/
#   $ find_large_files /var 500M
#   $ find_suid_binaries /usr
#
# See also: ffind(), fd_find(), find(1)
#

git_diff_branches() { git diff "$1"..."$2"; }
git_diff_commits() { git diff "$1" "$2"; }
git_diff_summary_only() { git diff --name-status "$@"; }
git_diff_word_highlight() { git diff --word-diff=color "$@"; }
git_diff_patch() { git diff --patch "$@"; }
git_commit_sign() { git commit -S "$@"; }
git_commit_fixup() { git commit --fixup "$1"; }
git_commit_squash() { git commit --squash "$1"; }
git_commit_allow_empty() { git commit --allow-empty -m "$1"; }
git_commit_date() { GIT_AUTHOR_DATE="$1" GIT_COMMITTER_DATE="$1" git commit -m "$2"; }
git_stash_save_msg() { git stash push -m "$1"; }
git_stash_apply_drop() { git stash apply && git stash drop; }
git_stash_branch() { git stash branch "$1"; }
git_stash_clear_all() { git stash clear; }
git_stash_show_files() { git stash show --stat; }
git_stash_list_all() { git stash list --stat; }
git_remote_add_origin() { git remote add origin "$1"; }
git_remote_set_url() { git remote set-url origin "$1"; }
git_remote_rename() { git remote rename "$1" "$2"; }
git_remote_remove() { git remote remove "$1"; }
git_remote_get_url() { git remote get-url origin; }
git_remote_update() { git remote update; }
git_merge_squash_branch() { git merge --squash "$1" && git commit -m "${2:-squash: $1}"; }
git_merge_ff_only() { git merge --ff-only "$1"; }
# -----------------------------------------------------------------------------
# network — port scanning, routing, DNS, HTTP methods, SSL, and packet capture
# -----------------------------------------------------------------------------
#
# These network functions perform port scanning, subnet discovery, traceroute,
# ping with custom count and flood mode, MTR reports, detailed DNS queries
# (all records, per-nameserver), HTTP methods (GET, POST, PUT, DELETE, HEAD,
# OPTIONS), download with resume and rate limiting, SSL certificate chain
# inspection, whois lookups, and packet capture with tcpdump.
#
# Notable functions:
#   network_scan_ports     — scan TCP ports on a host
#   network_scan_subnet    — discover hosts on a subnet
#   network_http_get       — HTTP GET request
#   network_http_post      — HTTP POST request
#   network_ssl_cert       — retrieve and display SSL certificate
#   network_tcpdump_port   — capture packets on a specific port
#
# Usage examples:
#   $ network_scan_ports example.com 1-1000
#   $ network_http_get https://api.example.com
#   $ network_tcpdump_port 443 50
#
# See also: nmap(1), tcpdump(1), curl(1)
#

git_rebase_root() { git rebase -i --root; }
git_rebase_onto() { git rebase --onto "$1" "$2" "$3"; }
git_rebase_editor() { GIT_SEQUENCE_EDITOR=true git rebase -i "$@"; }
git_reset_keep() { git reset --keep HEAD~"$1"; }
git_reset_file() { git checkout -- "$1"; }
git_reset_all() { git reset --hard HEAD && git clean -fd; }
git_reset_to_commit() { git reset --hard "$1"; }
git_cherry_pick_range() { git cherry-pick "$1".."$2"; }
git_revert_no_commit() { git revert --no-commit "$1"; }
git_revert_abort() { git revert --abort; }
git_revert_continue() { git revert --continue; }
git_amend_author() { git commit --amend --author="$1"; }
git_amend_date() { git commit --amend --date="$1"; }
git_amend_all() { git add -A && git commit --amend --no-edit; }
git_worktree_remove() { git worktree remove "$1"; }
git_worktree_prune() { git worktree prune; }
git_worktree_lock() { git worktree lock "$1"; }
git_worktree_unlock() { git worktree unlock "$1"; }
git_submodule_add() { git submodule add "$1" "$2"; }
git_submodule_remove() { git submodule deinit -f "$1" && git rm -f "$1" && rm -rf ".git/modules/$1"; }
git_submodule_init() { git submodule init; }
git_submodule_status() { git submodule status; }
git_submodule_sync() { git submodule sync; }
git_submodule_update_remote() { git submodule update --recursive --remote; }
git_bisect_start() { git bisect start "$1" "$2"; }
git_bisect_good() { git bisect good; }
git_bisect_bad() { git bisect bad; }
git_bisect_reset() { git bisect reset; }
git_bisect_log() { git bisect log; }
# -----------------------------------------------------------------------------
# execution — command runners with retry, timeout, logging, and backgrounding
# -----------------------------------------------------------------------------
#
# These utility functions execute commands with various modifiers: as a
# different user, as root, in sequence, in parallel, in a specific directory,
# with logging to a file, with retry logic, with a timeout, in the background
# via nohup, conditionally if a command exists, or via specific interpreters
# (sh, bash, python, node, deno).
#
# Notable functions:
#   execute_as_root      — run a command as root via sudo
#   execute_parallel     — run multiple commands in parallel
#   execute_retry        — retry a command up to N times
#   execute_timeout      — run a command with a timeout
#   execute_background   — run a command in the background via nohup
#
# Usage examples:
#   $ execute_retry 5 curl -s https://example.com
#   $ execute_parallel "make" "make test"
#   $ execute_timeout 30 long_running_command
#
# See also: nohup(1), timeout(1), sudo(1)
#

git_bisect_run() { git bisect run "$1"; }
git_blame_email() { git blame -e "$1"; }
git_blame_date() { git blame --date=short "$1"; }
git_grep_string() { git grep -n "$1"; }
git_grep_files() { git grep -l "$1"; }
git_grep_context() { git grep -C "${3:-2}" "$1" "$2"; }
git_ignore_global() { git config --global core.excludesfile "$1"; }
git_ignore_template() { curl -fsSL "https://www.gitignore.io/api/$1" >> .gitignore 2>/dev/null || echo "add gitignore template manually"; }
git_attributes_text() { echo "* text=auto" >> .gitattributes; }
git_config_user() { git config user.name "$1" && git config user.email "$2"; }
git_config_global_user() { git config --global user.name "$1" && git config --global user.email "$2"; }
git_config_diff_tool() { git config --global diff.tool "$1"; }
git_config_merge_tool() { git config --global merge.tool "$1"; }
git_config_signing() { git config --global commit.gpgsign true && git config --global user.signingkey "$1"; }
git_config_autocorrect() { git config --global help.autocorrect 10; }
git_config_pull_rebase() { git config --global pull.rebase true; }
git_config_push_default() { git config --global push.default current; }
git_notes_add() { git notes add -m "$1" "$2"; }
git_notes_show() { git notes show "$1"; }
git_notes_list() { git notes list; }
git_replace_commit() { git replace "$1" "$2"; }
git_archive_zip() { git archive -o "${1:-archive}.zip" HEAD; }
git_archive_format() { git archive --format="$1" -o "${2:-archive}.$1" HEAD; }
git_describe_commit() { git describe --tags "$1"; }
git_verify_commit() { git verify-commit "$1"; }
git_verify_tag() { git verify-tag "$1"; }
git_check_ignore() { git check-ignore "$1"; }
git_check_attr() { git check-attr "$1" "$2"; }
# -----------------------------------------------------------------------------
# disk — usage analysis, free space, mounts, filesystem, and SMART
# -----------------------------------------------------------------------------
#
# These functions analyse disk usage and filesystem health: human-readable
# usage summaries, sorted output, usage by extension, free space reporting,
# inode usage, filesystem type detection, mount point listing, filesystem
# check (fsck), block device inspection (blkid, lsblk), SMART health
# monitoring, and I/O statistics (iostat, iotop).
#
# Notable functions:
#   disk_usage_sort     — sort directories by disk usage
#   disk_usage_by_ext   — calculate total usage by file extension
#   disk_free_summary   — show free space on a mount
#   disk_lsblk_tree     — show block devices as a tree
#   disk_smart_health   — check disk SMART health status
#   disk_iostat         — show I/O statistics
#
# Usage examples:
#   $ disk_usage_sort /var
#   $ disk_smart_health /dev/sda
#   $ disk_iostat 10
#
# See also: df(1), du(1), lsblk(1), smartctl(1)
#

git_show_refs() { git show-ref; }
git_ls_files() { git ls-files; }
git_ls_tree() { git ls-tree -r "$1"; }
git_count_objects() { git count-objects -v; }
git_fsck_repair() { git fsck --full; }
git_gc_aggressive() { git gc --aggressive --prune=now; }
git_repack_optimize() { git repack -a -d --depth=250 --window=250; }
git_clean_ignored() { git clean -fX; }
git_clean_dry() { git clean -nfd; }
git_archive_export() { git archive HEAD | tar -xC "${1:-export}"; }

systemctl_reload_service() { sudo systemctl reload "$1" 2>/dev/null || return 0; }
systemctl_reenable_service() { sudo systemctl reenable "$1" 2>/dev/null || return 0; }
systemctl_preset_service() { sudo systemctl preset "$1" 2>/dev/null || return 0; }
systemctl_add_wants() { sudo systemctl add-wants "$1" "$2" 2>/dev/null || return 0; }
systemctl_list_deps() { systemctl list-dependencies "$1" 2>/dev/null || return 0; }
systemctl_show_unit() { systemctl show "$1" 2>/dev/null || return 0; }
systemctl_list_units_by_type() { systemctl list-units --type="$1" --all 2>/dev/null || return 0; }
systemctl_list_machines() { systemctl list-machines 2>/dev/null || return 0; }
systemctl_poweroff() { sudo systemctl poweroff 2>/dev/null || return 0; }
systemctl_reboot() { sudo systemctl reboot 2>/dev/null || return 0; }
systemctl_hibernate() { sudo systemctl hibernate 2>/dev/null || return 0; }
# -----------------------------------------------------------------------------
# process — listing, tree, search, kill, priority, threads, and inspection
# -----------------------------------------------------------------------------
#
# These functions manage and inspect running processes: full listing, tree
# view, search by name or user, kill by name or PID (SIGTERM/SIGKILL), kill
# all processes for a user, adjust priority (nice, renice), inspect threads,
# open file descriptors, environment variables, scheduling policy, stack
# dumps, CPU/memory/elapsed time, parent-child relationships, and zombie or
# uninterruptible (D-state) process detection.
#
# Notable functions:
#   process_by_name     — find processes matching a name
#   process_kill_by_name — kill processes by name
#   process_threads     — show threads of a process
#   process_zombies     — list zombie processes
#   process_hung        — list uninterruptible (D-state) processes
#
# Usage examples:
#   $ process_by_name nginx
#   $ process_kill_by_name chrome
#   $ process_zombies
#
# See also: ps(1), kill(1), htop_monitor()
#

systemctl_suspend() { sudo systemctl suspend 2>/dev/null || return 0; }
systemctl_hybrid_sleep() { sudo systemctl hybrid-sleep 2>/dev/null || return 0; }
journalctl_user_unit() { journalctl --user -u "$1" 2>/dev/null || return 0; }
journalctl_priority() { journalctl -p "$1" -b 2>/dev/null || return 0; }
journalctl_since_time() { journalctl --since "$1" 2>/dev/null || return 0; }
journalctl_until_time() { journalctl --until "$1" 2>/dev/null || return 0; }
journalctl_output_json() { journalctl -o json 2>/dev/null || return 0; }
journalctl_catalog() { journalctl -x "$1" 2>/dev/null || return 0; }
journalctl_merge() { journalctl --merge 2>/dev/null || return 0; }
journalctl_no_pager() { journalctl --no-pager 2>/dev/null || return 0; }
journalctl_reverse() { journalctl -r 2>/dev/null || return 0; }
journalctl_follow_unit() { journalctl -fu "$1" 2>/dev/null || return 0; }
journalctl_kernel() { journalctl -k 2>/dev/null || return 0; }
journalctl_list_boots() { journalctl --list-boots 2>/dev/null || return 0; }

find_by_name() { find "${2:-.}" -name "$1" -type f 2>/dev/null; }
find_by_regex() { find "${2:-.}" -regex "$1" -type f 2>/dev/null; }
find_by_size() { find "${3:-.}" -type f -size "$1" -size "$2" 2>/dev/null; }
find_by_type() { find "${2:-.}" -type "$1" 2>/dev/null; }
find_by_perm() { find "${2:-.}" -perm "$1" 2>/dev/null; }
find_by_inode() { find "${2:-.}" -inum "$1" 2>/dev/null; }
# -----------------------------------------------------------------------------
# ssh — keygen variants, config management, tunnels, agent, and connections
# -----------------------------------------------------------------------------
#
# These extended SSH functions cover additional key types (ECDSA, Ed25519-SK),
# SSH config management (host listing, editing), connection testing, local/
# remote/dynamic port forwarding, jump hosts, agent key management (list,
# add, remove, load defaults), fingerprint display (SHA256, MD5, visual
# ASCII art), passphrase changes, remote key scanning, known hosts
# management, SFTP transfers, SCP with recursion, mosh connections,
# proxy command chaining, and config validation.
#
# Notable functions:
#   ssh_keygen_ecdsa     — generate ECDSA key (P-521)
#   ssh_config_host      — list configured SSH hosts
#   ssh_tunnel_local     — create a local port forward
#   ssh_tunnel_dynamic   — create a SOCKS proxy tunnel
#   ssh_key_fingerprint  — show key fingerprint
#   ssh_key_from_remote  — add remote host key to known_hosts
#   ssh_scp_recursive    — recursive copy via SCP
#
# Usage examples:
#   $ ssh_config_host
#   $ ssh_tunnel_local 8080 internal:80 bastion
#   $ ssh_key_fingerprint ~/.ssh/id_ed25519
#
# See also: ssh(1), ssh-keygen(1), ssh-add(1), ssh_config(5)
#

find_by_depth() { find "${2:-.}" -maxdepth "$1" -name "$3" 2>/dev/null; }
find_by_user() { find "${2:-.}" -user "$1" 2>/dev/null; }
find_by_group() { find "${2:-.}" -group "$1" 2>/dev/null; }
find_by_newer() { find "${2:-.}" -newer "$1" 2>/dev/null; }
find_by_accessed() { find "${2:-.}" -atime "$1" 2>/dev/null; }
find_by_modified() { find "${2:-.}" -mtime "$1" 2>/dev/null; }
find_by_changed() { find "${2:-.}" -ctime "$1" 2>/dev/null; }
find_broken_symlinks() { find "${1:-.}" -type l ! -exec test -e {} \; -print 2>/dev/null; }
find_suid_binaries() { find "${1:-/}" -type f -perm -4000 2>/dev/null; }
find_sgid_binaries() { find "${1:-/}" -type f -perm -2000 2>/dev/null; }
find_world_writable() { find "${1:-/}" -type f -perm -o+w 2>/dev/null; }
find_large_files() { find "${1:-.}" -type f -size +"${2:-100M}" 2>/dev/null; }
find_recent_changed() { find "${1:-.}" -cmin -"${2:-60}" 2>/dev/null; }
find_recent_accessed() { find "${1:-.}" -amin -"${2:-60}" 2>/dev/null; }
find_hidden_files() { find "${1:-.}" -name '.*' -type f 2>/dev/null; }
find_exec_command() { find "${1:-.}" -name "$2" -exec "${@:3}" {} \; 2>/dev/null; }
find_delete_by_name() { find "${2:-.}" -name "$1" -delete 2>/dev/null; }

network_scan_ports() { nmap -p "${2:-1-1000}" "$1" 2>/dev/null || nc -zv "$1" "$2" 2>&1; }
network_scan_subnet() { nmap -sn "$1"/"${2:-24}" 2>/dev/null || echo "nmap needed"; }
network_traceroute_path() { traceroute -n "$1" 2>/dev/null; }
network_ping_flood() { ping -f -c "${2:-100}" "$1" 2>/dev/null; }
network_ping_count() { ping -c "${2:-4}" "$1" 2>/dev/null; }
network_mtr_report() { mtr -r -c "${2:-10}" "$1" 2>/dev/null || echo "mtr needed"; }
network_dig_all() { dig ANY +noall +answer "$1" 2>/dev/null; }
network_dig_short() { dig +short "$1" 2>/dev/null; }
network_dns_test() { for ns in $(dig NS +short "$1" 2>/dev/null); do dig @"$ns" "$1" +short 2>/dev/null; done; }
network_http_get() { curl -sS "$1"; }
network_http_post() { curl -sS -X POST -d "$2" "$1"; }
network_http_put() { curl -sS -X PUT -d "$2" "$1"; }
network_http_delete() { curl -sS -X DELETE "$1"; }
network_http_head() { curl -sI "$1"; }
# -----------------------------------------------------------------------------
# curl — JSON, form, auth, proxy, rate limiting, and advanced HTTP helpers
# -----------------------------------------------------------------------------
#
# These curl wrapper functions add content-type headers (JSON POST, PUT,
# PATCH), form uploads, file uploads, resume downloads, basic auth, bearer
# token auth, proxy usage, rate limiting, connection and max timeouts,
# retry logic, redirect following, verbose dumps, certificate-based auth
# (CA certs, client certs), cookie jar management, insecure SSL, range
# requests, If-Modified-Since, HTTP/2, speed limits, interface binding,
# custom DNS servers, and parallel fetching.
#
# Notable functions:
#   curl_json_post       — POST JSON data
#   curl_auth_bearer     — send request with Bearer token
#   curl_proxy_use       — send request through a proxy
#   curl_retry_conn      — retry request on failure
#   curl_parallel_fetch  — download multiple URLs in parallel
#
# Usage examples:
#   $ curl_json_post '{"key":"value"}' https://api.example.com
#   $ curl_auth_bearer "token123" https://api.example.com
#   $ curl_parallel_fetch url1 url2 url3
#
# See also: curl(1), curlm(), curlt(), httpie_*, xh_*
#

network_http_options() { curl -sX OPTIONS "$1"; }
network_http_download() { curl -fsSL -O "$1"; }
network_http_download_as() { curl -fsSL -o "$2" "$1"; }
network_http_resume() { curl -C - -O "$1"; }
network_http_rate() { curl -s -w 'Speed: %{speed_download} Time: %{time_total}\n' -o /dev/null "$1"; }
network_http_compress() { curl --compressed -sS "$1"; }
network_http_cookie() { curl -b "$1" -c "$2" -sS "$3"; }
network_http_header() { curl -H "$1" -sS "$2"; }
network_ssl_cert() { echo | openssl s_client -connect "$1:${2:-443}" -servername "$1" 2>/dev/null | openssl x509 -text -noout; }
network_ssl_chain() { openssl s_client -showcerts -connect "$1:${2:-443}" -servername "$1" </dev/null 2>/dev/null; }
network_whois_domain() { whois "$1" 2>/dev/null; }
network_tcpdump_interface() { sudo tcpdump -i "$1" -c "${2:-100}" -nn; }
network_tcpdump_port() { sudo tcpdump -i any port "$1" -c "${2:-100}" -nn; }
network_tcpdump_host() { sudo tcpdump -i any host "$1" -c "${2:-100}" -nn; }

execute_as_user() { sudo -u "$1" "$@"; }
execute_as_root() { sudo "$@"; }
execute_command_each() { for item in "$@"; do "$item"; done; }
execute_parallel() { for cmd in "$@"; do "$cmd" & done; wait; }
execute_in_dir() { (cd "$1" && shift && "$@"); }
execute_with_log() { "$@" 2>&1 | tee "${2:-output.log}"; }
execute_retry() { local _n="${1:-3}"; shift; for _i in $(seq 1 "$_n"); do "$@" && return 0 || sleep 1; done; return 1; }
execute_timeout() { timeout "${1:-10}" "${@:2}"; }
execute_background() { nohup "$@" >/dev/null 2>&1 & }
execute_if_available() { command -v "$1" >/dev/null 2>&1 && "$@"; }
execute_chroot_cmd() { sudo chroot "$1" "$2"; }
execute_shell_script() { sh "$1" "$@"; }
execute_bash_script() { bash "$1" "$@"; }
execute_python_script() { python3 "$1" "$@"; }
execute_node_script() { node "$1" "$@"; }
# -----------------------------------------------------------------------------
# git — configuration, aliases, hooks, git-flow, SVN, LFS, and patches
# -----------------------------------------------------------------------------
#
# These extended git functions cover configuration options (HTTP proxy,
# SSH command, credential helper, excludes, autocrlf, editor, merge,
# push, rebase, color, init defaults, fetch), alias management (set,
# list, remove), hooks (view, install), git-flow workflow (init, feature,
# release, hotfix), git-SVN bridge (clone, rebase, dcommit), git LFS
# (install, track, list, pull, push, migrate), patch operations (format,
# apply, stat, check), range-diff, bundle (create, verify, unbundle),
# interactive rebase utilities (reword, split, undo), staging helpers,
# reflog management, blob/object inspection, and squash-all.
#
# Notable functions:
#   git_config_http_proxy   — set HTTP proxy for git
#   git_alias_set           — create a git alias
#   git_flow_init           — initialise git-flow
#   git_lfs_install         — install git LFS
#   git_patch_create        — create patch series
#   git_squash_all          — squash entire history
#
# Usage examples:
#   $ git_config_http_proxy http://proxy:8080
#   $ git_alias_set co checkout
#   $ git_lfs_track "*.psd"
#   $ git_squash_all "Initial commit"
#
# See also: man git, git-config(1), git-flow(1)
#

execute_deno_script() { deno run "$1" "$@"; }
eval_math() { echo "$*" | bc -l; }
eval_condition() { if "$@"; then echo "true"; else echo "false"; fi; }
eval_command_time() { time "$@"; }
eval_memory_usage() { /usr/bin/time -v "$@" 2>&1 | grep -E 'Maximum resident|Elapsed'; }
eval_shell_check() { shellcheck "$1"; }
eval_shfmt() { shfmt -i 2 "$1"; }
eval_bash_nounset() { bash -u "$1"; }
eval_bash_xtrace() { bash -x "$1"; }
eval_zsh_nounset() { zsh -u "$1"; }
eval_python_syntax() { python3 -m py_compile "$1"; }
eval_node_syntax() { node --check "$1"; }

disk_usage_human() { du -sh "$@"; }
disk_usage_total() { du -shc "$@"; }
disk_usage_sort() { du -sh "${1:-.}"/* | sort -rh; }
disk_usage_depth() { du -h --max-depth="${1:-1}" "${2:-.}"; }
disk_usage_by_ext() { find "${1:-.}" -type f -name "*$2" -exec du -ch {} + 2>/dev/null | tail -1; }
disk_free_summary() { df -h "${1:-/}"; }
disk_free_inodes() { df -ih "${1:-/}"; }
disk_free_type() { df -hT "${1:-/}"; }
disk_free_all() { df -h; }
disk_mount_list() { mount | column -t; }
disk_mount_by_device() { mount | grep "$1"; }
disk_fs_check() { sudo fsck -n "$1" 2>/dev/null || echo "fsck needed"; }
disk_fs_repair() { sudo fsck -y "$1" 2>/dev/null || echo "fsck needed"; }
disk_blkid() { sudo blkid "$1" 2>/dev/null; }
disk_lsblk_tree() { lsblk -f "$@"; }
disk_lsblk_all() { lsblk -a; }
disk_lsblk_size() { lsblk -o NAME,SIZE,TYPE,MOUNTPOINT; }
disk_smart_info() { sudo smartctl -a "$1" 2>/dev/null || echo "smartctl needed"; }
disk_smart_health() { sudo smartctl -H "$1" 2>/dev/null || echo "smartctl needed"; }
disk_iostat() { iostat -x 1 "${1:-5}" 2>/dev/null || echo "iostat needed"; }
disk_iotop() { sudo iotop -o 2>/dev/null || echo "iotop needed"; }

process_list_all() { ps aux; }
process_tree() { ps auxf; }
process_tree_pid() { ps -p "$1" --forest; }
process_by_name() { pgrep -af "$1" 2>/dev/null || ps aux | grep "$1"; }
process_by_user() { ps aux | grep "^$1" 2>/dev/null; }
process_kill_by_name() { pkill -f "$1" 2>/dev/null || killall "$1" 2>/dev/null; }
process_kill_by_pid() { kill -15 "$1" 2>/dev/null && echo "SIGTERM sent to $1" || echo "failed"; }
process_kill_force() { kill -9 "$1" 2>/dev/null; }
process_kill_all_user() { sudo killall -u "$1" 2>/dev/null || echo "cannot kill all"; }
process_nice_start() { nice -n "${1:-10}" "${@:2}"; }
process_renice() { sudo renice -n "$1" -p "$2"; }
process_threads() { ps -eLf | grep "$1"; }
process_fds() { lsof -p "$1" 2>/dev/null || echo "lsof needed"; }
process_env_vars() { cat "/proc/$1/environ" 2>/dev/null | tr '\0' '\n' || echo "no access"; }
process_priority() { chrt -p "$1" 2>/dev/null || echo "chrt needed"; }
process_dump_stack() { cat "/proc/$1/stack" 2>/dev/null || echo "no stack"; }
process_cputime() { ps -p "$1" -o pid,%cpu,%mem,etime,comm --no-headers 2>/dev/null; }
process_children() { ps --ppid "$1" -o pid,comm --no-headers 2>/dev/null; }
process_zombies() { ps aux | awk '$8 ~ /Z/ {print}'; }
process_hung() { ps aux | awk '$8 ~ /D/ {print}'; }

ssh_keygen_ecdsa() { ssh-keygen -t ecdsa -b 521 "$@"; }
ssh_keygen_ed25519_sk() { ssh-keygen -t ed25519-sk "$@"; }
ssh_copy_id_port() { ssh-copy-id -p "$2" "$1" 2>/dev/null; }
ssh_config_host() { cat ~/.ssh/config 2>/dev/null | grep -i "host " | awk '{print $2}'; }
ssh_config_edit() { $EDITOR ~/.ssh/config; }
ssh_test_conn() { ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no "$1" exit 2>/dev/null && echo "ok" || echo "failed"; }
ssh_tunnel_local() { ssh -L "$1:localhost:$2" "$3"; }
ssh_tunnel_remote() { ssh -R "$1:localhost:$2" "$3"; }
ssh_tunnel_dynamic() { ssh -D "$1" "$2"; }
ssh_tunnel_jump() { ssh -J "$1" "$2"; }
ssh_agent_list() { ssh-add -l; }
ssh_agent_add_key() { ssh-add "$1"; }
ssh_agent_remove_all() { ssh-add -D; }
ssh_agent_remove_key() { ssh-add -d "$1"; }
ssh_agent_load_default() { ssh-add 2>/dev/null || true; }
ssh_key_fingerprint() { ssh-keygen -lf "$1"; }
ssh_key_fingerprint_sha256() { ssh-keygen -lf "$1" -E sha256; }
ssh_key_fingerprint_md5() { ssh-keygen -lf "$1" -E md5; }
ssh_key_visual() { ssh-keygen -lvf "$1"; }
ssh_key_change_pass() { ssh-keygen -p -f "$1"; }
ssh_key_from_remote() { ssh-keyscan -H "$1" >> ~/.ssh/known_hosts 2>/dev/null; }
ssh_known_hosts_remove() { ssh-keygen -R "$1"; }
ssh_known_hosts_list() { cat ~/.ssh/known_hosts | cut -d' ' -f1 | sort -u; }
ssh_sftp_get() { sftp "$1:$2" "$3"; }
ssh_sftp_put() { sftp "$1" <<<"put $2" 2>/dev/null; }
ssh_scp_copy() { scp "$1" "$2"; }
ssh_scp_recursive() { scp -r "$1" "$2"; }
ssh_mosh_connect() { mosh "$1" 2>/dev/null || echo "mosh needed"; }
ssh_proxy_command() { ssh -o ProxyCommand="ssh -W %h:%p $1" "$2"; }
ssh_config_validate() { ssh -G "$1" 2>/dev/null | grep -i "^hostname\|^user\|^port\|^identityfile"; }
ssh_escape_sequences() { echo "~. - terminate; ~^Z - suspend; ~# - list fwd; ~& - bg; ~? - help"; }

curl_json_post() { curl -sS -H "Content-Type: application/json" -X POST -d "$1" "$2"; }
curl_json_put() { curl -sS -H "Content-Type: application/json" -X PUT -d "$1" "$2"; }
curl_json_patch() { curl -sS -H "Content-Type: application/json" -X PATCH -d "$1" "$2"; }
curl_form_post() { curl -sS -F "$1" "$2"; }
curl_upload_file() { curl -sS -F "file=@$1" "$2"; }
curl_download_resume() { curl -C - -O "$1"; }
curl_auth_basic() { curl -sS -u "$1:$2" "$3"; }
curl_auth_bearer() { curl -sS -H "Authorization: Bearer $1" "$2"; }
curl_proxy_use() { curl -sS -x "$1" "$2"; }
curl_limit_rate() { curl --limit-rate "$1" -O "$2"; }
curl_timeout_conn() { curl --connect-timeout "$1" -sS "$2"; }
curl_timeout_max() { curl --max-time "$1" -sS "$2"; }
curl_retry_conn() { curl --retry "${2:-3}" -sS "$1"; }
curl_follow_redirect() { curl -L -sS "$1"; }
curl_verbose_dump() { curl -v "$1" 2>&1; }
curl_cert_check() { curl --cacert "$1" -sS "$2"; }
# -----------------------------------------------------------------------------
# package management — cache, download, files, deps, provides, APK/RPM/DPKG
# -----------------------------------------------------------------------------
#
# These extended package management functions cover additional operations
# beyond the DOTFILES_PKG_MANAGER abstraction: cache cleaning, download-only
# mode, listing files owned by a package, showing dependencies, finding what
# package owns a file, downloading source packages, and format-specific
# helpers for Alpine (apk), RPM, Debian (dpkg), Flatpak, and Snap.
#
# Notable functions:
#   pkg_cache_clean     — clean the package manager cache
#   pkg_what_provides   — find which package owns a file
#   pkg_list_files      — list files installed by a package
#   dpkg_configure_all  — reconfigure all unpacked dpkg packages
#   flatpak_install_app — install a Flatpak application
#   snap_install_app    — install a Snap package
#
# Usage examples:
#   $ pkg_what_provides /usr/bin/ffmpeg
#   $ flatpak_install_app com.spotify.Client
#   $ dpkg_configure_all
#
# See also: pkg_install(), apt_*, brew_*, pacman_*
#

curl_cert_client() { curl --cert "$1" --key "$2" -sS "$3"; }
curl_cookie_jar() { curl -c "$1" -b "$2" -sS "$3"; }
curl_insecure_ssl() { curl -k -sS "$1"; }
curl_range_request() { curl -r "$1" -O "$2"; }
curl_if_modified() { curl -z "$1" -O "$2"; }
curl_http2_use() { curl --http2 -sS "$1"; }
curl_http2_push() { curl --http2-prior-knowledge -sS "$1"; }
curl_speed_limit() { curl --speed-limit "$1" --speed-time "${2:-30}" -O "$3"; }
curl_interface_bind() { curl --interface "$1" -sS "$2"; }
curl_dns_server() { curl --dns-servers "$1" -sS "$2"; }
curl_write_output() { curl -w "\n%{http_code} %{time_total}s\n" -sS "$1"; }
curl_silent_check() { curl -sS -o /dev/null -w "%{http_code}" "$1"; }
curl_parallel_fetch() { for url in "$@"; do curl -sS -O "$url" & done; wait; }

git_config_http_proxy() { git config --global http.proxy "$1"; }
git_config_no_proxy() { git config --global --unset http.proxy; }
git_config_ssh_command() { git config --global core.sshCommand "$1"; }
git_config_credential_helper() { git config --global credential.helper "$1"; }
git_config_excludes() { git config --global core.excludesFile "$1"; }
git_config_autocrlf() { git config --global core.autocrlf "$1"; }
git_config_safecrlf() { git config --global core.safecrlf "$1"; }
git_config_symlink() { git config --global core.symlinks true; }
git_config_editor() { git config --global core.editor "$1"; }
git_config_merge_ff() { git config --global merge.ff false; }
git_config_push_followtags() { git config --global push.followTags true; }
git_config_rebase_autostash() { git config --global rebase.autoStash true; }
git_config_rebase_autosquash() { git config --global rebase.autosquash true; }
git_config_color_ui() { git config --global color.ui auto; }
git_config_init_default() { git config --global init.defaultBranch main; }
git_config_fetch_prune() { git config --global fetch.prune true; }
git_config_diff_algorithm() { git config --global diff.algorithm patience; }
git_config_diff_renames() { git config --global diff.renames copies; }
git_config_pull_ff() { git config --global pull.ff only; }
git_config_tag_sort() { git config --global tag.sort version:refname; }
git_alias_set() { git config --global alias."$1" "$2"; }
git_alias_list() { git config --global --get-regexp alias; }
git_alias_remove() { git config --global --unset alias."$1"; }
git_hook_precommit() { cat .git/hooks/pre-commit 2>/dev/null || echo "no pre-commit hook"; }
git_hook_install() { curl -fsSL "$1" > .git/hooks/"$2" 2>/dev/null && chmod +x .git/hooks/"$2"; }
git_flow_init() { git flow init -d; }
git_flow_feature_start() { git flow feature start "$1"; }
git_flow_feature_finish() { git flow feature finish "$1"; }
git_flow_release_start() { git flow release start "$1"; }
# -----------------------------------------------------------------------------
# time & date — formatting, arithmetic, stopwatch, countdown, and waiters
# -----------------------------------------------------------------------------
#
# These functions provide time and date utilities: current time in various
# formats (local, UTC, epoch, ISO 8601), epoch-to-date conversion, relative
# date arithmetic (next, last, add, subtract, diff in days), a stopwatch
# that measures command execution time, a visual countdown, random sleep,
# simple timers stored in a temp file, and wait loops for ports, URLs,
# file existence, and process startup.
#
# Notable functions:
#   time_date_now      — show current date and time
#   time_date_diff     — calculate days between two dates
#   time_stopwatch     — time a command with start/elapsed display
#   time_countdown     — display a numeric countdown from N
#   time_wait_port     — wait until a TCP port is accepting connections
#
# Usage examples:
#   $ time_date_utc
#   $ time_date_diff "2024-01-01" "2024-12-31"
#   $ time_countdown 5
#   $ time_wait_port localhost 8080
#
# See also: date(1), timer(), timeit()
#

git_flow_release_finish() { git flow release finish "$1"; }
git_flow_hotfix_start() { git flow hotfix start "$1"; }
git_flow_hotfix_finish() { git flow hotfix finish "$1"; }
git_svn_clone() { git svn clone "$1" "${2:-$(basename "$1")}"; }
git_svn_rebase() { git svn rebase; }
git_svn_dcommit() { git svn dcommit; }
git_lfs_install() { git lfs install; }
git_lfs_track() { git lfs track "$1"; }
git_lfs_list() { git lfs ls-files; }
git_lfs_pull() { git lfs pull; }
git_lfs_push() { git lfs push origin "$1"; }
git_lfs_migrate() { git lfs migrate import --include="$1" --everything; }
git_cherry_commit() { git cherry -v "$1" "$2"; }
git_patch_create() { git format-patch "$1" -o "${2:-patches}"; }
git_patch_apply() { git am "$1"; }
git_patch_apply_stat() { git apply --stat "$1"; }
git_patch_apply_check() { git apply --check "$1"; }
git_range_diff() { git range-diff "$1" "$2" "$3"; }
git_bundle_create() { git bundle create "${1:-repo.bundle}" --all; }
git_bundle_verify() { git bundle verify "$1"; }
git_bundle_unbundle() { git clone "$1" "${2:-repo}"; }
git_interactive_rebase() { git rebase -i HEAD~"${1:-10}"; }
# -----------------------------------------------------------------------------
# file — create, remove, copy, move, symlink, chmod, diff, patch, and watch
# -----------------------------------------------------------------------------
#
# These extended file operations cover file creation, safe removal (force,
# recursive, interactive), copies with backup/preserve/verbose/recursive,
# moves (force, interactive, verbose, backup), symlinks (soft, hard, edit),
# recursive chmod/chown/chgrp, file comparison (diff, quiet, side-by-side),
# patching (dry-run, apply, reverse), interactive merging, line joining
# and splitting, head/tail/middle line extraction, random/shuffle/reverse,
# numbering, whitespace trimming, line ending conversion (DOS/Unix), blank
# line removal, deduplication, string replacement, line insertion/append/
# prepend, encryption (AES-256-CBC, GPG), compression (gzip, bzip2, xz,
# zip, tar, 7z), auto-extraction, and file change watching with inotify.
#
# Notable functions:
#   file_touch_create      — create an empty file
#   file_remove_force      — force-remove files
#   file_copy_backup       — copy with backup
#   file_chmod_recursive   — recursive chmod on files
#   file_compare           — unified diff between two files
#   file_encrypt_aes       — AES-256-CBC encrypt a file
#   file_watch_changes     — watch a file for changes and run a command
#
# Usage examples:
#   $ file_chmod_recursive /path/to/dir 644
#   $ file_encrypt_aes secret.txt
#   $ file_watch_changes config.py "make test"
#
# See also: bak(), unbak(), backup_file()
#

git_reword_commit() { git commit --amend --only -m "$1"; }
git_split_commit() { git reset HEAD~1 && git add -p && git commit -m "$1" && git commit -m "$2"; }
git_undo_commit() { git reset --soft HEAD~1; }
git_undo_commit_keep() { git reset --mixed HEAD~1; }
git_undo_last_commit_msg() { git commit --amend -m "$1"; }
git_stage_interactive() { git add -p; }
git_stage_partial() { git add -p "$1"; }
git_unstage_file() { git reset HEAD "$1"; }
git_unstage_all() { git reset HEAD .; }
git_discard_file() { git checkout -- "$1"; }
git_discard_all() { git checkout -- .; }
git_files_untracked() { git ls-files --others --exclude-standard; }
git_files_modified() { git ls-files -m; }
git_files_staged() { git diff --cached --name-only; }
git_files_conflict() { git diff --name-only --diff-filter=U; }
git_status_porcelain() { git status --porcelain; }
git_status_ignored() { git status --ignored --short; }
git_reflog_date() { git reflog --date=iso; }
git_reflog_expire() { git reflog expire --expire="${1:-90.days}" --all; }
git_reflog_delete_old() { git reflog expire --expire-unreachable="${1:-30.days}" --all; }
git_blob_size() { git cat-file -s "$1" 2>/dev/null; }
git_obj_type() { git cat-file -t "$1" 2>/dev/null; }
git_show_tree() { git ls-tree -r --name-only "$1"; }
git_show_commit_body() { git show -s --format=%B "$1"; }
git_show_files_in_commit() { git show --name-only "$1"; }
git_compare_branches() { git log --oneline --left-right "$1...$2"; }
git_squash_all() { git reset --soft "$(git rev-list --max-parents=0 HEAD)" && git commit --amend -m "${1:-squashed}"; }
git_contributors_count() { git shortlog -sn | wc -l; }
git_contributors_top() { git shortlog -sn -20; }
git_contributors_by_date() { git log --format='%an' | sort | uniq -c | sort -rn; }
git_first_commit() { git log --reverse --oneline | head -1; }
git_last_commit() { git log -1 --oneline; }
git_tag_annotated() { git tag -a "$1" -m "$2"; }
git_tag_sign() { git tag -s "$1" -m "$2"; }
git_tag_verify_all() { git tag -v $(git tag) 2>&1 | grep -B1 "Good\|Bad" || true; }
git_tag_date() { git log --tags --simplify-by-decoration --format="%ai %d"; }
git_tag_contains() { git tag --contains "$1"; }
git_tag_latest() { git describe --tags "$(git rev-list --tags --max-count=1)" 2>/dev/null; }
git_subtree_add() { git subtree add --prefix="$1" "$2" "$3" --squash; }
git_subtree_pull() { git subtree pull --prefix="$1" "$2" "$3" --squash; }
git_subtree_push() { git subtree push --prefix="$1" "$2" "$3"; }
git_subtree_merge() { git subtree merge --prefix="$1" "$2"; }
git_subtree_split() { git subtree split --prefix="$1" -b "$2"; }
git_worktree_list_paths() { git worktree list --porcelain; }
git_notes_append() { git notes append -m "$1" "$2"; }
git_notes_remove() { git notes remove "$2" 2>/dev/null; }
git_notes_prune() { git notes prune; }
git_replace_list() { git replace -l; }
git_replace_delete() { git replace -d "$1"; }
git_rerere_enable() { git config --global rerere.enabled true; }
git_rerere_status() { git rerere status; }
git_rerere_gc() { git rerere gc; }

pkg_cache_clean() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) sudo pacman -Sc;; apt|apt-get) sudo apt clean;; dnf) sudo dnf clean all;; brew) brew cleanup;; apk) apk cache clean;; zypper) sudo zypper clean;; esac; }
pkg_download_only() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) sudo pacman -Sw "$@";; apt|apt-get) sudo apt install -d "$@";; dnf) sudo dnf download "$@";; brew) brew fetch "$@";; esac; }
pkg_list_files() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Ql "$@";; dpkg) dpkg -L "$@";; rpm) rpm -ql "$@";; brew) brew ls "$@";; esac; }
pkg_show_deps() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Qi "$@" | grep Depends;; apt|apt-get) apt depends "$@";; dnf) dnf deplist "$@";; brew) brew deps "$@";; esac; }
pkg_what_provides() { case "${DOTFILES_PKG_MANAGER:-}" in pacman) pacman -Qo "$@";; apt|apt-get) dpkg -S "$@";; dnf) dnf provides "$@";; brew) brew uses --installed "$@";; esac; }
pkg_download_source() { case "${DOTFILES_PKG_MANAGER:-}" in apt|apt-get) apt-get source "$@";; pacman) sudo pacman -S --needed base-devel && echo "use AUR for src";; esac; }
apk_add_pkg() { apk add "$@"; }
apk_remove_pkg() { apk del "$@"; }
apk_search_pkg() { apk search "$@"; }
apk_list_installed() { apk list -I; }
apk_list_updates() { apk list -u; }
# -----------------------------------------------------------------------------
# text — search, replace, delete, extract, transform, and format conversion
# -----------------------------------------------------------------------------
#
# These extended text functions provide comprehensive search (recursive,
# word, case-insensitive, inverse, count, context, regex, fixed-string,
# binary, by file types, exclude patterns), sed-based replacement (all,
# line-specific, first, regex), line deletion (range, empty, matching),
# extraction (between markers, columns, fields, URLs, emails, IPs),
# word/line/character counting and frequency analysis, sorting (alpha,
# numeric, reverse, unique), file merging, splitting on delimiters,
# joining lines, wrapping, indenting, case conversion (upper, lower,
# capitalize, reverse, rot13), XML formatting/xpath/validation, JSON
# formatting/minification/querying/flattening, YAML formatting/conversion/
# validation, CSV-to-JSON conversion, HTML-to-text extraction, Markdown
# rendering, and character/word-level diffing.
#
# Notable functions:
#   text_search_recursive    — recursive grep in a directory
#   text_replace_all         — sed replace all occurrences in files
#   text_extract_urls        — extract all URLs from a file
#   text_count_freq          — word frequency analysis
#   text_json_query          — query JSON with JMESPath-like paths
#   text_csv_to_json         — convert CSV to JSON
#   text_diff_words          — word-level diff of two files
#
# Usage examples:
#   $ text_search_recursive "TODO" src/ --include="*.py"
#   $ text_json_query data.json /users/0/name
#   $ text_csv_to_json data.csv
#
# See also: grep(1), sed(1), jq(1), rg_search()
#

apk_info_pkg() { apk info "$@"; }
apk_cache_clean() { apk cache clean; }
apk_upgrade_all() { apk upgrade; }
rpm_list_pkgs() { rpm -qa; }
rpm_info_pkg() { rpm -qi "$@"; }
rpm_verify_pkg() { rpm -V "$@"; }
rpm_list_files() { rpm -ql "$@"; }
dpkg_list_pkgs() { dpkg -l; }
dpkg_info_pkg() { dpkg -p "$@"; }
dpkg_verify_pkg() { dpkg --verify "$@"; }
dpkg_configure_all() { sudo dpkg --configure -a; }
dpkg_reconfigure_pkg() { sudo dpkg-reconfigure "$@"; }
dpkg_list_files() { dpkg -L "$@"; }
flatpak_install_app() { flatpak install "$1"; }
flatpak_remove_app() { flatpak uninstall "$1"; }
flatpak_run_app() { flatpak run "$1"; }
flatpak_search_app() { flatpak search "$1"; }
flatpak_info_app() { flatpak info "$1"; }
flatpak_update_apps() { flatpak update; }
flatpak_list_runtime() { flatpak list --runtime; }
snap_install_app() { sudo snap install "$1"; }
snap_remove_app() { sudo snap remove "$1"; }
snap_search_app() { snap find "$1"; }
snap_info_app() { snap info "$1"; }
snap_list_services() { snap services; }
snap_start_service() { sudo snap start "$1"; }
snap_stop_service() { sudo snap stop "$1"; }
snap_restart_service() { sudo snap restart "$1"; }
snap_enable_service() { sudo snap enable "$1"; }
snap_disable_service() { sudo snap disable "$1"; }
snap_logs_service() { snap logs "$1"; }

time_date_now() { date '+%F %T %Z'; }
time_date_utc() { date -u '+%F %T UTC'; }
time_date_epoch() { date +%s; }
time_date_iso() { date -u +%Y-%m-%dT%H:%M:%SZ; }
time_date_from_epoch() { date -d "@$1" '+%F %T'; }
time_date_from_string() { date -d "$1" '+%F %T'; }
time_date_next() { date -d "$1" '+%F %T'; }
time_date_last() { date -d "-1 $1" '+%F %T'; }
time_date_add() { date -d "+$1 $2" '+%F %T'; }
time_date_sub() { date -d "-$1 $2" '+%F %T'; }
time_date_diff() { local _s1 _s2; _s1=$(date -d "$1" +%s 2>/dev/null); _s2=$(date -d "$2" +%s 2>/dev/null); echo "$(( (_s2 - _s1) / 86400 )) days"; }
time_stopwatch() { local _s; _s=$(date +%s); echo "started"; "$@"; echo "elapsed: $(($(date +%s) - _s))s"; }
time_countdown() { local _i="$1"; while [ "$_i" -gt 0 ]; do printf "\r%3d " "$_i"; sleep 1; _i=$((_i - 1)); done; printf "\rdone\n"; }
time_sleep_random() { sleep "$(shuf -i "${1:-1}"-"${2:-10}" -n 1)"; }
time_timer_set() { echo "$(date +%s)" > /tmp/timer_start; }
time_timer_check() { [ -f /tmp/timer_start ] && echo "elapsed: $(($(date +%s) - $(cat /tmp/timer_start)))s" || echo "no timer"; }
time_timer_clear() { rm -f /tmp/timer_start; }
time_wait_port() { while ! nc -z "$1" "$2" 2>/dev/null; do sleep 1; done; echo "$1:$2 ready"; }
time_wait_url() { until curl -sSf "$1" >/dev/null 2>&1; do sleep 1; done; echo "$1 ready"; }
time_wait_file() { until [ -f "$1" ]; do sleep 1; done; echo "$1 ready"; }
time_wait_process() { until pgrep -x "$1" >/dev/null 2>&1; do sleep 1; done; echo "$1 running"; }

file_touch_create() { touch "$1"; }
file_remove_force() { rm -f "$@"; }
file_remove_recursive() { rm -rf "$@"; }
file_remove_interactive() { rm -i "$@"; }
file_copy_backup() { cp -b "$1" "$2"; }
file_copy_preserve() { cp -p "$1" "$2"; }
file_copy_recursive() { cp -r "$1" "$2"; }
file_copy_verbose() { cp -v "$1" "$2"; }
file_move_force() { mv -f "$1" "$2"; }
file_move_interactive() { mv -i "$1" "$2"; }
file_move_verbose() { mv -v "$1" "$2"; }
file_move_backup() { mv -b "$1" "$2"; }
file_symlink_create() { ln -s "$1" "$2"; }
file_symlink_hard() { ln "$1" "$2"; }
file_symlink_edit() { ln -sf "$1" "$2"; }
file_chmod_recursive() { find "$1" -type f -exec chmod "$2" {} \; 2>/dev/null; }
file_chmod_dirs() { find "$1" -type d -exec chmod "$2" {} \; 2>/dev/null; }
file_chown_recursive() { sudo chown -R "$1:$2" "$3"; }
file_chgrp_recursive() { sudo chgrp -R "$1" "$2"; }
file_compare() { diff -u "$1" "$2"; }
file_compare_quiet() { diff -q "$1" "$2" && echo "same" || echo "different"; }
file_compare_side() { diff -y "$1" "$2" | less; }
file_patch_dry() { patch --dry-run -i "$1"; }
file_patch_apply() { patch -i "$1"; }
file_patch_reverse() { patch -R -i "$1"; }
file_merge_interactive() { sdiff -o "${3:-merged}" "$1" "$2"; }
file_join_lines() { paste -sd "$1" "$2"; }
file_split_lines() { split -l "${1:-1000}" "$2" "${3:-split}"; }
file_head_bytes() { head -c "$1" "$2"; }
file_tail_bytes() { tail -c "$1" "$2"; }
file_tail_follow() { tail -f "$1"; }
file_tail_follow_name() { tail -F "$1"; }
file_head_first() { head -n "${1:-10}" "$2"; }
# -----------------------------------------------------------------------------
# terminal multiplexers — screen, tmux, and zellij session management
# -----------------------------------------------------------------------------
#
# These functions manage terminal multiplexer sessions: screen (list, create,
# attach, detach, kill, reattach), tmux (create, attach, split, window
# navigation, rename, swap, rotate, send keys, capture, buffer, options,
# resize, choose tree), and zellij (list, attach, create, kill, rename
# session, move focus, resize).
#
# Notable functions:
#   screen_session_create    — create a named screen session
#   screen_session_reattach  — reattach to a detached screen session
#   tmux_new_session         — create a new tmux session
#   tmux_split_horizontal    — split pane horizontally in tmux
#   zellij_session_create    — create a new zellij session
#
# Usage examples:
#   $ tmux_new_session work
#   $ tmux_split_vertical
#   $ zellij_session_attach main
#
# See also: screen(1), tmux(1), zellij(1)
#

file_head_last() { tail -n "${1:-10}" "$2"; }
file_middle_lines() { sed -n "${1},${2}p" "$3"; }
file_random_line() { shuf -n 1 "$1"; }
file_shuffle_lines() { shuf "$1" -o "$1"; }
file_reverse_lines() { tac "$1"; }
file_number_lines() { nl "$1"; }
file_trim_trailing() { sed -i 's/[[:space:]]*$//' "$1"; }
file_trim_leading() { sed -i 's/^[[:space:]]*//' "$1"; }
file_trim_both() { sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "$1"; }
file_dos_to_unix() { dos2unix "$1" 2>/dev/null || sed -i 's/\r$//' "$1"; }
file_unix_to_dos() { unix2dos "$1" 2>/dev/null || sed -i 's/$/\r/' "$1"; }
file_remove_blank() { sed -i '/^$/d' "$1"; }
file_remove_duplicates() { sort -u -o "$1" "$1"; }
file_replace_string() { sed -i "s/$1/$2/g" "$3"; }
file_insert_line() { sed -i "$1i\\$2" "$3"; }
file_append_line() { echo "$1" >> "$2"; }
file_prepend_line() { sed -i "1i\\$1" "$2"; }
file_encrypt_aes() { openssl enc -aes-256-cbc -salt -in "$1" -out "${1}.enc"; }
file_decrypt_aes() { openssl enc -d -aes-256-cbc -in "$1" -out "${1%.enc}"; }
file_encrypt_gpg() { gpg -c "$1"; }
file_decrypt_gpg() { gpg -d "$1" > "${1%.gpg}"; }
file_compress_gzip() { gzip -k "$1"; }
file_compress_bzip2() { bzip2 -k "$1"; }
file_compress_xz() { xz -k "$1"; }
file_compress_zip() { zip -r "$1.zip" "$1"; }
file_compress_tar() { tar -czf "$1.tar.gz" "$1"; }
file_compress_7z() { 7z a "$1.7z" "$1"; }
file_extract_auto() { extract "$1"; }
file_watch_changes() { while inotifywait -qq -e modify "$1"; do "$2"; done 2>/dev/null || echo "inotifywait needed"; }
file_watch_clear() { while inotifywait -qq -e modify "$1"; do clear; "$2"; done 2>/dev/null || echo "inotifywait needed"; }

text_search() { grep -n "$1" "$2"; }
text_search_recursive() { grep -rn "$1" "${2:-.}"; }
text_search_word() { grep -wn "$1" "$2"; }
text_search_case() { grep -in "$1" "$2"; }
text_search_inverse() { grep -v "$1" "$2"; }
text_search_count() { grep -c "$1" "$2"; }
text_search_context() { grep -C "${3:-2}" "$1" "$2"; }
# -----------------------------------------------------------------------------
# TUI launchers — lazygit, lazydocker, htop, and modern CLI tool wrappers
# -----------------------------------------------------------------------------
#
# These functions launch terminal UI applications and modern CLI tool
# replacements: lazygit and lazydocker for git/docker TUI, htop/btop/
# nvtop/glances for system monitoring, iftop/nethogs/bandwhich for
# network monitoring, iotop/ctop/ytop for I/O and container monitoring,
# procs for process listing, dog/doggo for DNS queries, duf/dust for
# disk usage, bottom for system monitoring, gping for ping with graph,
# grex for regex generation, gron for JSON flattening, xh/httpie for
# HTTP clients, bat/eza/lsd for file listing, fd for file finding, rg
# for text searching, sd for find-and-replace, and fzf for fuzzy
# finding with previews.
#
# Notable functions:
#   lazygit_open     — open lazygit TUI
#   htop_monitor     — open htop system monitor
#   bat_cat          — syntax-highlighted file output
#   eza_tree         — directory tree with icons
#   rg_search        — fast recursive text search
#   fzf_file         — fuzzy-find files with preview
#   fzf_git_branch   — fuzzy-switch git branches
#
# Usage examples:
#   $ lazygit_open
#   $ eza_tree 3 src/
#   $ rg_search "def main" src/
#   $ fzf_file
#
# See also: lazygit(1), htop(1), bat(1), fzf(1)
#

text_search_regex() { grep -E "$1" "$2"; }
text_search_fixed() { grep -F "$1" "$2"; }
text_search_only_match() { grep -o "$1" "$2"; }
text_search_binary() { grep -a "$1" "$2"; }
text_search_recursive_full() { grep -rn "$1" "${2:-.}" --include="*.$3" 2>/dev/null; }
text_search_exclude() { grep -rn "$1" "${2:-.}" --exclude="$3" 2>/dev/null; }
text_search_exclude_dir() { grep -rn "$1" "${2:-.}" --exclude-dir="$3" 2>/dev/null; }
text_search_files() { grep -rl "$1" "${2:-.}"; }
text_search_file_types() { grep -rn "$1" "${2:-.}" --include="*.$3" 2>/dev/null; }
text_replace_all() { sed -i "s/$1/$2/g" "${3:-*}"; }
text_replace_line() { sed -i "${4}s/$1/$2/$3" "$5"; }
text_replace_first() { sed -i "s/$1/$2/" "$3"; }
text_replace_regex() { sed -i -E "s/$1/$2/g" "$3"; }
text_delete_lines() { sed -i "${2},${3}d" "$1"; }
text_delete_empty() { sed -i '/^$/d' "$1"; }
text_delete_matching() { sed -i "/$1/d" "$2"; }
text_extract_between() { sed -n "/$1/,/$2/p" "$3"; }
text_extract_column() { awk "{print \$$1}" "$2"; }
text_extract_field() { cut -d"${3:- }" -f"$1" "$2"; }
text_extract_urls() { grep -oP 'https?://[^\s<>"'\'']+' "$1"; }
text_extract_emails() { grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$1"; }
text_extract_ips() { grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' "$1"; }
text_count_words() { wc -w < "$1"; }
text_count_lines() { wc -l < "$1"; }
text_count_chars() { wc -m < "$1"; }
text_count_freq() { tr ' ' '\n' < "$1" | sort | uniq -c | sort -rn | head -"${2:-20}"; }
text_sort_alpha() { sort "$1"; }
text_sort_numeric() { sort -n "$1"; }
text_sort_reverse() { sort -r "$1"; }
text_sort_unique() { sort -u "$1"; }
text_merge_files() { cat "$@" > "${@: -1}"; }
text_split_on_delim() { awk -F"$1" '{for(i=1;i<=NF;i++) print $i}' "$2"; }
text_join_lines() { paste -sd"$1" "$2"; }
text_wrap_lines() { fold -w "${1:-80}" "$2"; }
text_indent_lines() { sed "s/^/$1/" "$2"; }
text_unindent_lines() { sed "s/^$1//" "$2"; }
text_uppercase() { tr '[:lower:]' '[:upper:]' < "$1"; }
text_lowercase() { tr '[:upper:]' '[:lower:]' < "$1"; }
text_capitalize() { sed 's/\b\(.\)/\u\1/g' "$1"; }
text_reverse_chars() { rev "$1"; }
text_rot13() { tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$1"; }
text_xml_pretty() { xmllint --format "$1" 2>/dev/null || echo "xmllint needed"; }
text_xml_query() { xmllint --xpath "$1" "$2" 2>/dev/null || echo "xmllint needed"; }
text_xml_validate() { xmllint --valid "$1" 2>/dev/null && echo "valid" || echo "invalid or xmllint needed"; }
text_json_format() { python3 -m json.tool "$1"; }
text_json_minify() { python3 -c "import sys,json; print(json.dumps(json.load(open(sys.argv[1])),separators=(',',':')))" "$1"; }
text_json_query() { python3 -c "
import sys,json
def get(d,p):
 for k in p.strip('/').split('/'):
  if not k: continue
  try: d=d[int(k)]
  except ValueError: d=d[k]
 return d
d=json.load(open(sys.argv[1]))
print(json.dumps(get(d,sys.argv[2])))
" "$@" 2>/dev/null || python3 -c "
import sys,json
def get(d,p):
 for k in p.strip('/').split('/'):
  if not k: continue
  try: d=d[int(k)]
  except ValueError: d=d[k]
 return d
# -----------------------------------------------------------------------------
# tree — directory tree visualisation with various output formats
# -----------------------------------------------------------------------------
#
# These functions display directory trees using the tree command when
# available, with fallback to find-based formatting. They support level
# limiting, directory-only display, hidden files, size display, and
# output in XML, JSON, or HTML format.
#
# Notable functions:
#   tree_show         — display directory tree
#   tree_dirs_only    — show directories only
#   tree_size         — show tree with file sizes
#   tree_json         — output tree in JSON format
#   tree_html         — generate HTML tree view
#
# Usage examples:
#   $ tree_show /var/log
#   $ tree_json src/ > tree.json
#   $ tree_html . > /tmp/tree.html
#
# See also: tree(1), eza_tree(), lsd_tree()
#

d=json.load(sys.stdin)
print(json.dumps(get(d,'$1')))
" "$1" 2>/dev/null; }
text_json_flatten() { python3 -c "import sys,json; print(json.dumps(json.load(open(sys.argv[1])),indent=None,separators=(',',':')))" "$1"; }
text_yaml_format() { python3 -c "import sys,yaml; print(yaml.dump(yaml.safe_load(open(sys.argv[1]))))" "$1" 2>/dev/null; }
text_yaml_to_json() { python3 -c "import sys,yaml,json; print(json.dumps(yaml.safe_load(open(sys.argv[1])),indent=2))" "$1" 2>/dev/null; }
text_yaml_validate() { python3 -c "import sys,yaml; yaml.safe_load(open(sys.argv[1])); print('valid')" "$1" 2>/dev/null || echo "invalid"; }
text_csv_to_json() { python3 -c "import sys,csv,json; print(json.dumps(list(csv.DictReader(open(sys.argv[1]))),indent=2))" "$1"; }
text_html_to_text() { lynx -dump "$1" 2>/dev/null || w3m -dump "$1" 2>/dev/null || echo "lynx or w3m needed"; }
# -----------------------------------------------------------------------------
# project management — TODO tracking and project file generation
# -----------------------------------------------------------------------------
#
# These functions manage project TODO/FIXME/HACK/XXX annotations across
# source files, generate project boilerplate (LICENSE files for MIT,
# Apache-2.0, GPL-3.0, BSD-2, Unlicense), .gitignore and .dockerignore
# files via gitignore.io templates, .editorconfig, .prettierrc, eslintrc,
# tsconfig.json, and package.json.
#
# Notable functions:
#   todo_list         — list all TODO/FIXME/HACK/XXX markers
#   todo_by_type      — count TODOs grouped by type
#   license_mit       — generate MIT license file
#   gitignore_fetch   — fetch .gitignore template from gitignore.io
#   editorconfig_create — create .editorconfig file
#
# Usage examples:
#   $ todo_list src/
#   $ license_mit "Your Name"
#   $ gitignore_fetch python,java
#
# See also: license(1), gitignore.io
#

text_html_extract() { python3 -c "import sys; from html.parser import HTMLParser; p=HTMLParser(); p.feed(open(sys.argv[1]).read())" 2>/dev/null || echo "python needed"; }
text_markdown_render() { python3 -c "import sys,markdown,html; print(html.escape(markdown.markdown(open(sys.argv[1]).read())))" "$1" 2>/dev/null || echo "markdown module needed"; }
text_diff_chars() { diff -u "$1" "$2" | colordiff 2>/dev/null || diff -u "$1" "$2"; }
text_diff_words() { git diff --word-diff --no-index "$1" "$2" 2>/dev/null; }
text_diff_side() { sdiff -w"${3:-120}" "$1" "$2"; }
text_patch_create() { diff -u "$1" "$2" > "${3:-patch.diff}"; }

screen_session_list() { screen -ls; }
screen_session_create() { screen -S "$1"; }
screen_session_attach() { screen -r "$1"; }
screen_session_detach() { screen -d "$1"; }
screen_session_kill() { screen -X -S "$1" kill; }
screen_session_reattach() { screen -dr "$1"; }
tmux_new_session() { tmux new -s "$1"; }
tmux_attach_session() { tmux attach -t "$1"; }
tmux_list_sessions() { tmux ls; }
tmux_kill_session() { tmux kill-session -t "$1"; }
tmux_split_horizontal() { tmux split-window -h; }
tmux_split_vertical() { tmux split-window -v; }
tmux_new_window() { tmux new-window -n "$1"; }
tmux_next_window() { tmux next-window; }
# -----------------------------------------------------------------------------
# utility helpers — command availability check, backup, bookmark, and PATH
# -----------------------------------------------------------------------------
#
# These utility helper functions solve common shell workflow needs: _x
# checks if a command exists before running it (suppressing errors on
# missing commands), bak/unbak create and restore timestamped backups,
# orig/unorig save/restore .org files, topcommands shows most-used
# shell commands from history, puniq deduplicates PATH-like strings,
# findup searches parent directories for a file, cdup changes to the
# directory containing a found file, pg greps process listing, stamp
# adds a timestamp prefix, clip copies file content to clipboard,
# path_remove/append/prepend manipulate PATH, and here/there provide
# a directory bookmark system.
#
# Notable functions:
#   _x         — run command if available, else print error
#   bak        — create a timestamped backup of a file
#   findup     — search parent directories for a file
#   clip       — copy file content to clipboard
#   path_append — append a directory to PATH
#   here       — bookmark the current directory
#   there      — navigate to the bookmarked directory
#
# Usage examples:
#   $ bak important-file.txt
#   $ findup Makefile
#   $ here && cd /tmp && there
#   $ path_prepend "$HOME/.local/bin"
#
# See also: backup_file(), clipboard utilities
#

tmux_prev_window() { tmux previous-window; }
tmux_rename_session() { tmux rename-session "$1"; }
tmux_rename_window() { tmux rename-window "$1"; }
tmux_kill_window() { tmux kill-window; }
tmux_detach_client() { tmux detach; }
tmux_swap_pane() { tmux swap-pane -D; }
tmux_rotate_panes() { tmux rotate-window; }
tmux_send_keys() { tmux send-keys -t "$1" "$2" Enter; }
tmux_capture_pane() { tmux capture-pane -t "$1" -p; }
tmux_save_buffer() { tmux save-buffer -b "$1" "${2:-/tmp/tmux-buffer}"; }
tmux_set_option() { tmux set-option -g "$1" "$2"; }
tmux_show_options() { tmux show-options -g; }
tmux_resize_pane() { tmux resize-pane -D "$1"; }
tmux_choose_tree() { tmux choose-tree; }
tmux_list_clients() { tmux list-clients; }
tmux_list_buffers() { tmux list-buffers; }
zellij_session_list() { zellij list-sessions; }
zellij_session_attach() { zellij attach "$1"; }
zellij_session_create() { zellij -s "$1"; }
zellij_session_kill() { zellij kill-session "$1"; }
zellij_action_rename() { zellij action rename-session "$1"; }
zellij_action_move() { zellij action move-focus "$1"; }
zellij_action_resize() { zellij action resize "$1" "$2"; }

lazygit_open() { lazygit; }
lazydocker_open() { lazydocker; }
k9s_open() { k9s; }
htop_monitor() { htop; }
btop_monitor() { btop 2>/dev/null || htop; }
nvtop_monitor() { nvtop 2>/dev/null || echo "nvtop needed"; }
glances_monitor() { glances 2>/dev/null || echo "glances needed"; }
iftop_monitor() { sudo iftop 2>/dev/null || echo "iftop needed"; }
nethogs_monitor() { sudo nethogs 2>/dev/null || echo "nethogs needed"; }
iotop_monitor() { sudo iotop -o 2>/dev/null || echo "iotop needed"; }
ctop_monitor() { ctop 2>/dev/null || echo "ctop needed"; }
ytop_monitor() { ytop 2>/dev/null || echo "ytop needed"; }
bashtop_monitor() { bashtop 2>/dev/null || bpytop 2>/dev/null || echo "bashtop/bpytop needed"; }
procs_process_list() { procs 2>/dev/null || ps aux; }
bandwhich_monitor() { sudo bandwhich 2>/dev/null || echo "bandwhich needed"; }
dog_dns_query() { dog "$1" 2>/dev/null || dig "$1"; }
doggo_dns_query() { doggo "$1" 2>/dev/null || dig "$1"; }
duf_disk_usage() { duf 2>/dev/null || df -h; }
dust_disk_usage() { dust 2>/dev/null || du -sh .; }
bottom_monitor() { btm 2>/dev/null || echo "btm needed"; }
gping_ping() { gping "$1" 2>/dev/null || ping "$1"; }
grex_regex_gen() { grex "$1" 2>/dev/null || echo "grex needed"; }
gron_json_flatten() { gron "$1" 2>/dev/null || cat "$1"; }
gron_json_unflatten() { gron -u "$1" 2>/dev/null || cat "$1"; }
xh_get() { xh "$1" 2>/dev/null || curl -sS "$1"; }
xh_post() { xh POST "$1" "$2" 2>/dev/null || curl -sS -X POST -d "$2" "$1"; }
xh_put() { xh PUT "$1" "$2" 2>/dev/null || curl -sS -X PUT -d "$2" "$1"; }
xh_delete() { xh DELETE "$1" 2>/dev/null || curl -sS -X DELETE "$1"; }
httpie_get() { http "$1" 2>/dev/null || curl -sS "$1"; }
httpie_post() { http POST "$1" "$2" 2>/dev/null || curl -sS -X POST -d "$2" "$1"; }
httpie_put() { http PUT "$1" "$2" 2>/dev/null || curl -sS -X PUT -d "$2" "$1"; }
httpie_delete() { http DELETE "$1" 2>/dev/null || curl -sS -X DELETE "$1"; }
bat_cat() { bat "$@" 2>/dev/null || cat "$@"; }
# -----------------------------------------------------------------------------
# cross-platform — OS detection, platform-aware commands, and clipboard
# -----------------------------------------------------------------------------
#
# These helpers detect the current operating system (_is_mac, _is_linux,
# _is_bsd) and provide conditional execution paths for platform-specific
# commands (ip vs ifconfig, free vs vm_stat, lscpu vs sysctl, pacman vs
# dpkg vs brew, systemctl vs launchctl). They also provide cross-platform
# wrappers for opening files, copying/pasting clipboard content, bookmark
# directory navigation (cdf), swapping files, epoch time conversion, and
# HTTP server launching.
#
# Notable functions:
#   ip_show    — show network interfaces (OS-aware)
#   disk_usage — show disk free space (OS-aware)
#   mem_info   — show memory info (OS-aware)
#   open_file  — open a file with the system default handler
#   copy_cmd   — copy to system clipboard
#   paste_cmd  — paste from system clipboard
#   cdf        — cd to directory containing a file
#   swap       — swap two filenames
#   epoch2date — convert Unix epoch to human date
#
# Usage examples:
#   $ _is_linux && echo "Running on Linux"
#   $ open_file report.pdf
#   $ copy_cmd < secret.txt
#   $ epoch2date 1700000000
#
# See also: have(), nott(), _x()
#

bat_lang() { bat -l "$1" "$2" 2>/dev/null || cat "$2"; }
bat_theme_list() { bat --list-themes 2>/dev/null || echo "bat not installed"; }
bat_diff() { bat --diff "$1" "$2" 2>/dev/null || diff -u "$1" "$2"; }
eza_list() { eza -la --icons=auto "$@" 2>/dev/null || ls -la "$@"; }
eza_tree() { eza --tree --level="${1:-2}" 2>/dev/null || tree -L "${1:-2}"; }
eza_all() { eza -laa --icons=auto "$@" 2>/dev/null || ls -la "$@"; }
lsd_list() { lsd -la "$@" 2>/dev/null || ls -la "$@"; }
lsd_tree() { lsd --tree --depth="${1:-2}" "$2" 2>/dev/null || tree -L "${1:-2}" "$2"; }
fd_find() { fd "$1" "${2:-.}" 2>/dev/null || find "${2:-.}" -name "$1"; }
fd_find_type() { fd --type "$1" "$2" "${3:-.}" 2>/dev/null || find "${3:-.}" -type "$1" -name "$2"; }
fd_find_exec() { fd "$1" "${2:-.}" --exec "${@:3}" 2>/dev/null || find "${2:-.}" -name "$1" -exec "${@:3}" {} \; ; }
rg_search() { rg "$1" "${2:-.}" 2>/dev/null || grep -rn "$1" "${2:-.}"; }
rg_search_files() { rg -l "$1" "${2:-.}" 2>/dev/null || grep -rl "$1" "${2:-.}"; }
rg_search_context() { rg -C "${3:-2}" "$1" "${2:-.}" 2>/dev/null || grep -rn -C "${3:-2}" "$1" "${2:-.}"; }
rg_search_word() { rg -w "$1" "${2:-.}" 2>/dev/null || grep -rnw "$1" "${2:-.}"; }
sd_replace() { sd "$1" "$2" "$3" 2>/dev/null || sed -i "s/$1/$2/g" "$3"; }
fzf_file() { fzf --preview 'bat {}' 2>/dev/null; }
fzf_dir() { find "${1:-.}" -type d | fzf 2>/dev/null; }
fzf_kill() { ps aux | fzf | awk '{print $2}' | xargs -r kill; }
fzf_ssh() { grep -i "host " ~/.ssh/config 2>/dev/null | awk '{print $2}' | fzf | xargs -r ssh; }
fzf_git_branch() { git branch -a | fzf | tr -d ' *' | xargs -r git checkout; }
fzf_git_log() { git log --oneline --graph --all | fzf | awk '{print $1}' | xargs -r git show; }
fzf_git_diff() { git status --short | fzf | awk '{print $2}' | xargs -r git diff; }
fzf_history() { history | fzf; }
fzf_process() { ps aux | fzf | awk '{print $2}' | xargs -r kill; }
# -----------------------------------------------------------------------------
# dev servers — local HTTP servers, tunnels, watchers, and formatters
# -----------------------------------------------------------------------------
#
# These functions start local development servers for various stacks:
# Python's http.server module, PHP's built-in server, Node.js http-server
# and live-server with auto-reload, serve for static files, ngrok and
# cloudflared for public tunnels, browser-sync for multi-device testing,
# sass compiler watcher, and build watchers for webpack, vite, parcel,
# and esbuild. Also includes code formatting with prettier, linting with
# eslint and stylelint, and TypeScript compilation.
#
# Notable functions:
#   dev_server_python       — HTTP server on port 8000
#   dev_server_ngrok        — expose localhost via ngrok tunnel
#   dev_server_browsersync  — start browser-sync with file watching
#   dev_watch_vite          — start Vite dev server
#   dev_watch_sass          — watch and compile Sass files
#   dev_format_prettier     — format code with prettier
#
# Usage examples:
#   $ dev_server_python 8080
#   $ dev_watch_vite
#   $ dev_server_ngrok 3000
#
# See also: npx(1), python3(1), sass(1)
#

fzf_man() { man -k . | fzf | awk '{print $1}' | xargs -r man; }
fzf_browse() { fzf --preview 'bat {}' --bind 'enter:become(nvim {})' 2>/dev/null; }
fzf_cd() { cd "$(find "${1:-.}" -type d | fzf)" 2>/dev/null; }
fzf_search() { fzf -q "$1" --preview 'bat {}' 2>/dev/null; }
fzf_rg() { rg --line-number --null "$1" | fzf --delimiter : --preview 'bat --color=always {1} --highlight-line {2}' --preview-window +{2}-5; }

tree_show() { tree -C "${1:-.}" 2>/dev/null || find "${1:-.}" -print | sed 's|[^/]*/||---|g'; }
tree_level() { tree -L "${1:-2}" -C "${2:-.}" 2>/dev/null || find "${2:-.}" -maxdepth "${1:-2}" -print | sed 's|[^/]*/||---|g'; }
tree_dirs_only() { tree -d -C "${1:-.}" 2>/dev/null || find "${1:-.}" -type d -print | sed 's|[^/]*/||---|g'; }
tree_with_hidden() { tree -a -C "${1:-.}" 2>/dev/null || find "${1:-.}" -print | sed 's|[^/]*/||---|g'; }
tree_size() { tree --du -h -C "${1:-.}" 2>/dev/null || du -sh "${1:-.}"/*; }
tree_xml() { tree -X "${1:-.}" 2>/dev/null || echo "tree not installed"; }
tree_json() { tree -J "${1:-.}" 2>/dev/null || echo "tree not installed"; }
tree_html() { tree -H "${1:-.}" 2>/dev/null > /tmp/tree.html && echo "written: /tmp/tree.html"; }

todo_list() { grep -rn "TODO\|FIXME\|HACK\|XXX" "${1:-.}" --include="*.${2:-*}" 2>/dev/null; }
todo_count() { grep -rn "TODO\|FIXME\|HACK\|XXX" "${1:-.}" --include="*.${2:-*}" 2>/dev/null | wc -l; }
todo_by_type() { for _t in TODO FIXME HACK XXX; do echo "$_t: $(grep -rn "$_t" "${1:-.}" --include="*.${2:-*}" 2>/dev/null | wc -l)"; done; }
todo_add() { echo "TODO: $1" >> "${2:-TODO.md}"; }
todo_show_file() { cat "${1:-TODO.md}" 2>/dev/null || echo "no TODO.md"; }

license_mit() { curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/mit.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$1/" > LICENSE 2>/dev/null || echo "unable to fetch"; }
# -----------------------------------------------------------------------------
# command availability — portable command existence checks
# -----------------------------------------------------------------------------
#
# These shorthands check whether commands are available on the PATH. The
# have() function is the primary workhorse used throughout this file to
# gracefully handle missing tools. The nott() variant prints a warning.
# macos(), linux(), bsd() and wsl() are convenience aliases.
#
# Notable functions:
#   have   — check if a command exists on PATH (silent)
#   nott   — check if a command exists, warn if missing
#   macos  — true when running on macOS
#   linux  — true when running on Linux
#   wsl    — true when running under Windows WSL
#
# Usage examples:
#   $ have docker || echo "Docker not installed"
#   $ nott jq
#   $ linux && echo "Running on Linux"
#
# See also: _is_mac(), _is_linux(), _x()
#

license_apache() { curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/apache2.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$1/" > LICENSE 2>/dev/null || echo "unable to fetch"; }
license_gpl() { curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/gpl3.txt" > LICENSE 2>/dev/null || echo "unable to fetch"; }
license_bsd() { curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/bsd2.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$1/" > LICENSE 2>/dev/null || echo "unable to fetch"; }
license_unlicense() { curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/unlicense.txt" > LICENSE 2>/dev/null || echo "unable to fetch"; }
gitignore_fetch() { curl -fsSL "https://www.toptal.com/developers/gitignore/api/$1" > .gitignore 2>/dev/null || echo "unable to fetch"; }
gitignore_append() { curl -fsSL "https://www.toptal.com/developers/gitignore/api/$1" >> .gitignore 2>/dev/null || echo "unable to fetch"; }
gitignore_list() { curl -fsSL "https://www.toptal.com/developers/gitignore/api/list" 2>/dev/null | tr ',' '\n'; }
dockerignore_create() { echo -e ".git\n*.md\nDockerfile\ndocker-compose.yml\n.gitignore" > .dockerignore; }
# -----------------------------------------------------------------------------
# network — IP retrieval, DNS, port scanning, HTTP, and routing
# -----------------------------------------------------------------------------
#
# These network diagnostic functions retrieve public and local IP addresses
# (IPv4 and IPv6), perform DNS lookups and reverse lookups, scan TCP ports,
# check HTTP status codes and headers, download files, test bandwidth via
# speedtest-cli, display network statistics, and inspect routing tables.
# They prefer modern tools (dig, curl, ss) with fallbacks to traditional
# ones (nslookup, wget, netstat).
#
# Notable functions:
#   myip4         — get public IPv4 address
#   myip6         — get public IPv6 address
#   localip       — get local network IP address
#   port_scan     — scan TCP ports on a remote host
#   http_status   — get HTTP status code for a URL
#   download      — download a file via curl or wget
#   route_table   — display the routing table
#
# Usage examples:
#   $ myip4
#   $ localip
#   $ port_scan example.com 80,443
#   $ http_status https://example.com
#
# See also: whatismyip(), dns_*, check_port_*, netstat_*
#

editorconfig_create() { echo -e "root = true\n\n[*]\nend_of_line = lf\ninsert_final_newline = true\ncharset = utf-8\nindent_style = space\nindent_size = 2" > .editorconfig; }
prettier_init() { echo -e "{\n  \"semi\": true,\n  \"singleQuote\": true,\n  \"tabWidth\": 2,\n  \"trailingComma\": \"all\"\n}" > .prettierrc; }
eslint_init() { echo -e "{\n  \"env\": {\"node\": true,\"es2021\": true},\n  \"extends\": \"eslint:recommended\",\n  \"parserOptions\": {\"ecmaVersion\": \"latest\"}\n}" > .eslintrc.json; }
tsconfig_init() { echo -e "{\n  \"compilerOptions\": {\n    \"target\": \"ES2022\",\n    \"module\": \"ESNext\",\n    \"strict\": true,\n    \"outDir\": \"./dist\"\n  },\n  \"include\": [\"src\"]\n}" > tsconfig.json; }
package_json_init() { echo -e "{\n  \"name\": \"$1\",\n  \"version\": \"1.0.0\",\n  \"main\": \"index.js\",\n  \"scripts\": {},\n  \"license\": \"MIT\"\n}" > package.json; }

_x() { if command -v "${1%% *}" >/dev/null 2>&1; then "$@"; else echo "missing: $1" >&2; return 127; fi; }

bak() { for f in "$@"; do [ -f "$f" ] || { echo "usage: bak file"; return 1; }; [[ $f =~ \.bak\..* ]] && continue; local b; b="$f.bak.$(date '+%F_%T' | sed 's/:/-/g')"; while [ -f "$b" ]; do sleep 1; b="$f.bak.$(date '+%F_%T' | sed 's/:/-/g')"; done; cp -av "$f" "$b"; done; }

unbak() { for f in "$@"; do local d b; d="$(dirname "$f")"; f="${f##*/}"; b="$(find "$d" -name "$f.bak.*" -o -name "$f.*.bak" 2>/dev/null | sort | tail -1)"; [ -n "$b" ] && cp -av "$b" "$d/$f" || echo "no backup for $f"; done; }

orig() { for f in "$@"; do [ -f "$f" ] || { echo "missing: $f"; return 1; }; [ -f "$f.org" ] && { echo "$f.org exists"; return 1; }; done; for f in "$@"; do cp -av "$f" "$f.org"; done; }

# -----------------------------------------------------------------------------
# system — OS, kernel, hostname, users, reboot detection, and temperature
# -----------------------------------------------------------------------------
#
# These functions query system-level information: uptime display, load
# averages, OS pretty-name from /etc/os-release (or sw_vers on macOS),
# kernel version, hostname, logged-in users, whether a reboot is required
# after package updates, and CPU temperature from thermal sensors.
#
# Notable functions:
#   sys_uptime           — show system uptime
#   sys_load             — show load averages
#   sys_os               — show OS pretty name
#   sys_kernel           — show kernel version
#   sys_reboot_required  — check if reboot is needed
#   sys_temp             — show CPU temperature
#
# Usage examples:
#   $ sys_os
#   $ sys_reboot_required
#   $ sys_temp
#
# See also: get_cpu_info(), get_memory_info(), sys_info()
#

unorig() { for f in "$@"; do [ -f "$f" ] || { echo "missing: $f"; return 1; }; cp -av "$f" "${f%.org}"; done; }

topcommands() { history | awk '{print $4}' | awk 'BEGIN{FS="|"}{print $1}' | sort | uniq -c | sort -n | tail -n "${1:-10}" | sort -nr; }

puniq() { echo "$1" | tr : '\n' | nl | sort -u -k2,2 | sort -n | cut -f2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'; }

findup() { local a="$1" d="${PWD:-$(pwd)}"; while [ -n "$d" ]; do [ -e "$d/$a" ] && { echo "$d/$a"; return 0; }; d="${d%/*}"; done; echo "not found: $a" >&2; return 1; }

cdup() { local f; f="$(findup "$1")" && cd "$(dirname "$f")" || echo "not found: $1"; }

pg() { ps -ef | grep -i --color=yes "$@" | grep -v grep; }
# -----------------------------------------------------------------------------
# disk — usage, inodes, filesystem types, mounts, and SMART monitoring
# -----------------------------------------------------------------------------
#
# These functions provide disk and filesystem diagnostics: human-readable
# disk usage, inode usage, filesystem type detection, mount point listing
# for physical devices, I/O statistics, SMART health checks, and usage
# summaries by directory depth.
#
# Notable functions:
#   disk_usage       — show disk usage of a mount point
#   disk_inode       — show inode usage
#   disk_fs          — show filesystem types
#   disk_mounts      — show mounted physical devices
#   disk_smart       — show SMART health for a disk
#   disk_usage_depth — show directory usage at a specific depth
#
# Usage examples:
#   $ disk_usage /
#   $ disk_mounts
#   $ disk_smart /dev/sda
#
# See also: df(1), du(1), iostat(1), smartctl(1)
#


stamp() { printf "%s" "$(date '+%F %T')  $*"; [ $# -gt 0 ] && echo; }

stampcmd() { local o; o="$("$@" 2>&1)"; stamp "$o"; }

clip() { if [ $# -gt 0 ]; then _x xclip -selection clipboard < "$1" 2>/dev/null || _x wl-copy < "$1" 2>/dev/null || _x pbcopy < "$1" 2>/dev/null; else _x xclip -selection clipboard 2>/dev/null || _x wl-copy 2>/dev/null || _x pbcopy 2>/dev/null; fi; }

path_remove() { PATH="$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')"; }

# -----------------------------------------------------------------------------
# process — top CPU/memory consumers, tree, threads, and waiting
# -----------------------------------------------------------------------------
#
# These functions inspect running processes: top consumers by CPU and
# memory usage, process tree display, thread listing, and waiting for
# background processes to complete.
#
# Notable functions:
#   ps_cpu      — show top processes by CPU usage
#   ps_mem      — show top processes by memory usage
#   ps_tree     — show process tree
#   ps_threads  — show thread list
#   ps_wait     — wait for a background process
#
# Usage examples:
#   $ ps_cpu 15
#   $ ps_mem 10
#   $ ps_tree
#
# See also: ps(1), htop_monitor(), mem_top(), cpu_top()
#

path_append() { path_remove "$1"; PATH="${PATH:+"$PATH:"}$1"; }

path_prepend() { path_remove "$1"; PATH="$1${PATH:+":$PATH"}"; }

here() { ln -sfn "$(readlink -f "${1:-.}" 2>/dev/null || echo "${1:-.}")" "$HOME/.shell.here"; echo "here -> $(readlink "$HOME/.shell.here")"; }

there() { cd "$(readlink "$HOME/.shell.here")" 2>/dev/null || echo "no bookmark"; }
# -----------------------------------------------------------------------------
# file — largest, newest, dupes, splitting, renaming, and type distribution
# -----------------------------------------------------------------------------
#
# These functions operate on files within the filesystem: finding the largest
# files by size, most recently modified files, oldest files, duplicate files
# by MD5 checksum, splitting and joining files, bulk renaming by substring
# replacement, counting file extension types, and finding/removing zero-byte
# files.
#
# Notable functions:
#   file_largest       — show largest files by size
#   file_newest        — show most recently modified files
#   file_dupes         — find duplicate files by MD5
#   file_rename_bulk   — replace substring in multiple filenames
#   file_type_dist     — show distribution of file extensions
#   file_zero_size_rm  — remove all empty files
#
# Usage examples:
#   $ file_largest /var 10
#   $ file_dupes ~/Downloads
#   $ file_rename_bulk "old" "new"
#
# See also: find_largest(), find_duplicates(), find(1)
#


mkcd() { mkdir -p "$1" && cd "$1"; }

gcd() { local r; r="$(git rev-parse --show-toplevel 2>/dev/null)" && cd "$r" || echo "not in git repo"; }

gbs() { git branch 2>/dev/null | sed -n '/\* /s/^* //p'; }

extract() { [ $# -eq 0 ] && { echo "usage: extract <file>"; return 1; }; for f in "$@"; do [ -f "$f" ] || { echo "missing: $f"; continue; }; case "$f" in *.tar.bz2|*.tbz2) _x tar xjf "$f" ;; *.tar.gz|*.tgz) _x tar xzf "$f" ;; *.tar.xz) _x tar xJf "$f" ;; *.tar.zst) _x tar --zstd -xf "$f" ;; *.tar) _x tar xf "$f" ;; *.bz2) _x bunzip2 "$f" ;; *.gz) _x gunzip "$f" ;; *.xz) _x unxz "$f" ;; *.zst) _x zstd -d "$f" ;; *.zip) _x unzip "$f" ;; *.rar) _x unrar x "$f" ;; *.7z) _x 7z x "$f" ;; *.Z) _x uncompress "$f" ;; *) echo "unknown: $f" ;; esac; done; }

colors() { for i in {0..15}; do printf "\e[48;5;${i}m  \e[0m"; done; echo; for i in {16..231}; do printf "\e[48;5;${i}m \e[0m"; (( (i-16)%36==35 )) && echo; done; echo; for i in {232..255}; do printf "\e[48;5;${i}m  \e[0m"; done; echo; }

wanip() { _x dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || _x curl -s ifconfig.me 2>/dev/null || _x curl -s icanhazip.com 2>/dev/null; }

# -----------------------------------------------------------------------------
# text — wrapping, truncation, case conversion, sorting, and formatting
# -----------------------------------------------------------------------------
#
# These functions provide text transformation utilities for stdin: wrapping
# lines at a given column width, truncating to a maximum length, converting
# case (lowercase, uppercase, title case), reversing character order, sorting
# unique words, counting lines/words/characters, deduplicating sorted lines,
# counting line frequencies, selecting a random line, formatting as aligned
# table columns, and pretty-printing JSON.
#
# Notable functions:
#   text_wrap          — wrap lines at a given width
#   text_lower         — convert stdin to lowercase
#   text_title         — title-case text from stdin
#   text_sort_words    — sort unique words alphabetically
#   text_random_line   — select a random line from stdin
#   text_columns       — format as aligned table columns
#   text_json          — pretty-print JSON from stdin
#
# Usage examples:
#   $ echo "HELLO WORLD" | text_lower
#   $ cat data.json | text_json
#   $ cut -d: -f1 /etc/passwd | text_sort_words
#
# See also: fold(1), tr(1), column(1), jq(1), json_pretty()
#







pwdtail() { pwd | awk -F/ '{nlast=NF-1; print $nlast"/"$NF}'; }

distribution() { local d="unknown"; [ -r /etc/os-release ] && { . /etc/os-release 2>/dev/null; case "${ID-}" in fedora|rhel|centos) d="redhat" ;; sles|opensuse*) d="suse" ;; ubuntu|debian) d="debian" ;; gentoo) d="gentoo" ;; arch|manjaro) d="arch" ;; slackware) d="slackware" ;; *) case "${ID_LIKE-}" in *fedora*|*rhel*|*centos*) d="redhat" ;; *sles*|*opensuse*) d="suse" ;; *ubuntu*|*debian*) d="debian" ;; *gentoo*) d="gentoo" ;; *arch*) d="arch" ;; esac ;; esac; }; echo "$d"; }

# cross-platform helpers
_os() { uname -s; }
_is_mac() { [ "$(_os)" = "Darwin" ]; }
_is_linux() { [ "$(_os)" = "Linux" ]; }
_is_bsd() { [ "$(_os)" = "FreeBSD" ] || [ "$(_os)" = "OpenBSD" ] || [ "$(_os)" = "NetBSD" ]; }
_mac_only() { _is_mac && "$@" || echo "macOS only" >&2; }
_linux_only() { _is_linux && "$@" || echo "Linux only" >&2; }
# -----------------------------------------------------------------------------
# archive — create, list, and extract common archive formats
# -----------------------------------------------------------------------------
#
# These functions create archives in tar.gz, zip, and 7z formats from one
# or more input files/directories, and list the contents of existing
# archives by auto-detecting the format from the filename extension.
#
# Notable functions:
#   archive_create_tar  — create a tar.gz archive
#   archive_create_zip  — create a zip archive
#   archive_create_7z   — create a 7z archive
#   archive_list        — list contents of any archive type
#
# Usage examples:
#   $ archive_create_tar myproject
#   $ archive_create_zip myproject
#   $ archive_list archive.tar.gz
#
# See also: tar_compress(), zip_compress(), extract(), compress()
#


ip_show() { if _is_linux; then _x ip addr show "$@"; else _x ifconfig "$@"; fi; }
disk_usage() { if _is_linux; then _x df -h "$@"; else _x df -h "$@" 2>/dev/null || _x df "$@"; fi; }
mem_info() { if _is_linux; then _x free -h; else _x vm_stat 2>/dev/null || _x free -h; fi; }
cpu_info() { if _is_linux; then _x lscpu; else _x sysctl -n machdep.cpu.brand_string; fi; }
pkg_list() { if _is_linux; then _x pacman -Q 2>/dev/null || _x dpkg -l 2>/dev/null || _x rpm -qa 2>/dev/null; else _x brew list 2>/dev/null; fi; }
# -----------------------------------------------------------------------------
# encrypt — symmetric encryption/decryption and GPG signing
# -----------------------------------------------------------------------------
#
# These functions encrypt and decrypt files using OpenSSL AES-256-CBC or
# GPG symmetric encryption, and create/verify detached GPG signatures.
# Each function checks that the required tool is available before running.
#
# Notable functions:
#   encrypt_aes   — AES-256-CBC encrypt a file
#   decrypt_aes   — decrypt an AES-encrypted file
#   encrypt_gpg   — GPG symmetric encrypt a file
#   sign_file     — create a detached GPG signature
#   verify_file   — verify a detached GPG signature
#
# Usage examples:
#   $ encrypt_aes secret.txt
#   $ decrypt_aes secret.txt.enc
#   $ sign_file release.tar.gz
#
# See also: gpg(1), openssl(1), file_encrypt(), file_decrypt()
#

service_list() { if _is_linux; then _x systemctl list-units --type=service 2>/dev/null || _x service --status-all 2>/dev/null; else _x launchctl list 2>/dev/null; fi; }
ssh_keys() { for k in "$HOME"/.ssh/id_*; do [ -f "$k" ] && echo "${k##*/}"; done; }
open_file() { _x xdg-open "$@" 2>/dev/null || _x open "$@" 2>/dev/null || echo "no opener"; }
copy_cmd() { _x xclip -selection clipboard "$@" 2>/dev/null || _x wl-copy "$@" 2>/dev/null || _x pbcopy "$@" 2>/dev/null || echo "no clipboard tool"; }
paste_cmd() { _x xclip -selection clipboard -o 2>/dev/null || _x wl-paste 2>/dev/null || _x pbpaste 2>/dev/null || echo "no clipboard tool"; }

cdf() { cd "$(dirname "$(find . -name "$1" -maxdepth 5 -type f 2>/dev/null | head -1)")" 2>/dev/null || echo "not found: $1"; }
swap() { mv "$1" "${1}.bak" && mv "$2" "$1" && mv "${1}.bak" "$2"; }
# -----------------------------------------------------------------------------
# hash — cryptographic file hashing with multiple algorithms
# -----------------------------------------------------------------------------
#
# These functions compute cryptographic hashes of files using MD5, SHA-1,
# SHA-256, or SHA-512, with cross-platform fallbacks (Linux sha*sum vs
# macOS shasum). They are useful for verifying file integrity after
# downloads.
#
# Notable functions:
#   hash_md5    — compute MD5 hash of a file
#   hash_sha1   — compute SHA-1 hash of a file
#   hash_sha256 — compute SHA-256 hash of a file
#   hash_sha512 — compute SHA-512 hash of a file
#
# Usage examples:
#   $ hash_sha256 downloaded-file.iso
#
# See also: checksum_sha256(), verify_checksum(), hash_string()
#


# -----------------------------------------------------------------------------
# backup_dotfiles — full dotfiles backup with timestamp
# -----------------------------------------------------------------------------
#
# Creates a complete timestamped archive of the dotfiles directory,
# including any uncommitted changes. The backup is written to the parent
# of DOTFILES_DIR with a filename containing the current date and time.
# This provides a safety net before making major configuration changes.
#
# Usage:
#   backup_dotfiles
#
# Examples:
#   $ backup_dotfiles
#   > created: /home/user/.dotfiles-backup-20250115-143022.tar.gz
#
# Requires: DOTFILES_DIR to be set, tar to be installed.
# Returns 1 if the dotfiles directory is not found or archive creation fails.
#
backup_dotfiles() {
    local _dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    [ -d "$_dir" ] || { echo "dotfiles directory not found: $_dir" >&2; return 1; }
    local _ts; _ts=$(date +%Y%m%d-%H%M%S)
    local _out="${_dir}-backup-${_ts}.tar.gz"
    tar -czf "$_out" -C "$(dirname "$_dir")" "$(basename "$_dir")" 2>/dev/null &&         echo "created: $_out" || { echo "backup failed" >&2; return 1; }
}

# -----------------------------------------------------------------------------
# dotfiles_diff — compare current vs committed dotfiles
# -----------------------------------------------------------------------------
#
# Shows the diff between the current state of the dotfiles repository
# and the last committed state. It runs git diff inside DOTFILES_DIR,
# showing staged, unstaged, and optionally untracked changes.
#
# Usage:
#   dotfiles_diff
#
# Examples:
#   $ dotfiles_diff
#   > diff --git a/core/functions.sh b/core/functions.sh
#   > +new_function() { echo "hello"; }
#
# Requires: DOTFILES_DIR set to a git repository.
#
dotfiles_diff() {
    local _dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    [ -d "$_dir" ] || { echo "dotfiles directory not found: $_dir" >&2; return 1; }
    git -C "$_dir" diff --stat "$@" && git -C "$_dir" diff "$@"
}

# -----------------------------------------------------------------------------
# workon — activate project with directory change, venv, and git status
# -----------------------------------------------------------------------------
#
# Activates a Python project by changing to its directory, sourcing the
# virtual environment (.venv or venv), and showing the current git status.
# If no argument is given, it lists all available projects in the configured
# WORKON_HOME directory (default: ~/code). Inspired by virtualenvwrapper.
#
# Usage:
#   workon [project_name]
#
# Examples:
#   $ workon
#   > available projects: myapp, mylib, website
#   $ workon myapp
#   > (myapp) Python 3.12.1
#   > ## main...origin/main
#
# Requires: python3, virtual environment in project/.venv or project/venv.
#
workon() {
    local _home="${WORKON_HOME:-$HOME/code}"
    if [ $# -eq 0 ]; then
        echo "available projects:"
        ls -1 "$_home" 2>/dev/null || echo "(none in $_home)"
        return 0
    fi
    local _dir="$_home/$1"
    [ -d "$_dir" ] || { echo "project not found: $_dir" >&2; return 1; }
    cd "$_dir" || return 1
    if [ -f ".venv/bin/activate" ]; then
        . .venv/bin/activate
    elif [ -f "venv/bin/activate" ]; then
        . venv/bin/activate
    fi
    echo "[$1] $(python3 --version 2>/dev/null)"
    git status --short --branch 2>/dev/null || true
}

# -----------------------------------------------------------------------------
# mkproject — create project directory with git init and virtualenv
# -----------------------------------------------------------------------------
#
# Creates a new project directory under WORKON_HOME, initialises a git
# repository, creates a Python virtual environment, and generates a basic
# .gitignore file. This is the creation counterpart to workon().
#
# Usage:
#   mkproject <project_name>
#
# Examples:
#   $ mkproject my-new-app
#   > Initialised empty Git repository in ~/code/my-new-app/.git/
#   > created virtual environment: .venv
#   > created: .gitignore
#
# Requires: python3, git. Sets WORKON_HOME (default: ~/code).
#
mkproject() {
    [ $# -eq 1 ] || { echo "usage: mkproject <name>" >&2; return 1; }
    local _home="${WORKON_HOME:-$HOME/code}"
    mkdir -p "$_home/$1" || return 1
    cd "$_home/$1" || return 1
    git init 2>/dev/null
    python3 -m venv .venv 2>/dev/null && echo "created virtual environment: .venv"
    if [ ! -f .gitignore ]; then
        cat > .gitignore <<'GITIGNORE'
.venv/
venv/
__pycache__/
*.pyc
.env
*.egg-info/
dist/
build/
GITIGNORE
        echo "created: .gitignore"
    fi
    git status --short --branch 2>/dev/null || true
}

# -----------------------------------------------------------------------------
# ffind — find files by name with case-insensitive matching
# -----------------------------------------------------------------------------
#
# Searches for files by name under a given directory using case-insensitive
# matching. Uses fd for fast parallel search when available, with automatic
# fallback to find -iname. Results are sorted for consistent output.
#
# Usage:
#   ffind <name_pattern> [directory]
#
# Examples:
#   $ ffind "*.py" src/
#   > src/main.py
#   > src/utils/helpers.py
#
# Requires: fd is optional; falls back to find(1) automatically.
# Default directory: current directory (.).
#
ffind() {
    [ $# -ge 1 ] || { echo "usage: ffind <pattern> [directory]" >&2; return 1; }
    local _pat="$1" _dir="${2:-.}"
    if command -v fd >/dev/null 2>&1; then
        fd -t f -i "$_pat" "$_dir"
    else
        find "$_dir" -iname "$_pat" -type f 2>/dev/null | sort
    fi
}

# -----------------------------------------------------------------------------
# grep_all — recursive grep across multiple patterns
# -----------------------------------------------------------------------------
#
# Searches files recursively for multiple patterns at once. Each pattern
# is searched separately and results are grouped by pattern. Uses ripgrep
# (rg) if available for better performance, with automatic fallback to
# grep -r. Useful for finding all TODOs, FIXMEs, or multiple terms.
#
# Usage:
#   grep_all <pattern1> [pattern2 ...] [directory]
#
# Examples:
#   $ grep_all "TODO" "FIXME" src/
#   > === TODO ===
#   > src/main.py:10: # TODO: implement feature X
#   > === FIXME ===
#   > src/utils.py:5: # FIXME: handle edge case
#
grep_all() {
    [ $# -ge 1 ] || { echo "usage: grep_all <pattern> [pattern...] [dir]" >&2; return 1; }
    local _dir="."
    local _args=() _last
    _last="${@: -1}"
    if [ -d "$_last" ] && [ $# -gt 1 ]; then
        _dir="$_last"
        set -- "${@:1:$#-1}"
    fi
    for _p in "$@"; do
        echo "=== $_p ==="
        if command -v rg >/dev/null 2>&1; then
            rg -l "$_p" "$_dir" 2>/dev/null | head -20
        else
            grep -rl "$_p" "$_dir" 2>/dev/null | head -20
        fi
        echo
    done
}

# -----------------------------------------------------------------------------
# sys_update — comprehensive system update across all package managers
# -----------------------------------------------------------------------------
#
# Performs a comprehensive system update across multiple package managers:
# the primary system manager (pacman/apt/dnf/brew via pkg_update_all),
# flatpak, snap, Homebrew (macOS), and the dotfiles repository. Each step
# is attempted independently so that one failure does not block others.
#
# Usage:
#   sys_update
#
# Examples:
#   $ sys_update
#   > :: updating system packages... done
#   > :: updating flatpaks... done
#   > :: updating dotfiles... done
#
sys_update() {
    echo ":: updating system packages..."
    pkg_update_all 2>/dev/null || echo "   (skipped)"
    if command -v flatpak >/dev/null 2>&1; then
        echo ":: updating flatpaks..."
        flatpak update -y 2>/dev/null || echo "   (failed)"
    fi
    if command -v snap >/dev/null 2>&1; then
        echo ":: updating snaps..."
        sudo snap refresh 2>/dev/null || echo "   (failed)"
    fi
    if command -v brew >/dev/null 2>&1; then
        echo ":: updating homebrew..."
        brew update 2>/dev/null && brew upgrade 2>/dev/null || echo "   (failed)"
    fi
    if [ -n "${DOTFILES_DIR:-}" ]; then
        echo ":: updating dotfiles..."
        dot_sync 2>/dev/null || echo "   (failed)"
    fi
    echo ":: done"
}

# -----------------------------------------------------------------------------
# disk_usage — show human-readable disk usage for paths
# -----------------------------------------------------------------------------
#
# Displays disk usage for the given paths in human-readable format, sorted
# by size. With no arguments, shows usage for all visible items in the
# current directory. When multiple paths are given, includes a grand total.
#
# Usage:
#   disk_usage [path ...]
#
# Examples:
#   $ disk_usage
#   > 4.0K    file.txt
#   > 1.2M    src/
#   > 500M    videos/
#   $ disk_usage /var/log /tmp
#   > ...
#   > total  1.5G
#
disk_usage() {
    if [ $# -eq 0 ]; then
        du -sh -- * .[!.]* 2>/dev/null | sort -rh
    else
        du -shc "$@" 2>/dev/null | sort -rh
    fi
}

# -----------------------------------------------------------------------------
# mem_top — show top memory-consuming processes
# -----------------------------------------------------------------------------
#
# Displays the top N processes by resident memory usage (RSS). Shows PID,
# memory percentage, RSS, and command name. Uses ps with %mem sorting,
# with fallback for platforms that use different flag conventions.
#
# Usage:
#   mem_top [count]
#
# Examples:
#   $ mem_top 10
#   >   PID %MEM    RSS COMMAND
#   >  1234 12.5  2.1g chromium-browser
#
# Default count: 10.
#
mem_top() {
    local _n="${1:-10}"
    if ps --version 2>/dev/null | grep -qi procps; then
        ps aux --sort=-%mem 2>/dev/null | head -n "$((_n + 1))"
    else
        ps aux 2>/dev/null | sort -k4rn | head -n "$((_n + 1))"
    fi
}

# -----------------------------------------------------------------------------
# cpu_top — show top CPU-consuming processes
# -----------------------------------------------------------------------------
#
# Displays the top N processes by CPU usage percentage. Shows PID, CPU
# percentage, cumulative CPU time, and command name. Uses ps with %cpu
# sorting, with fallback for platforms that use different flags.
#
# Usage:
#   cpu_top [count]
#
# Examples:
#   $ cpu_top 5
#   >   PID %CPU     TIME COMMAND
#   >  5678 45.2  01:23:45 ffmpeg
#
# Default count: 10.
#
cpu_top() {
    local _n="${1:-10}"
    if ps --version 2>/dev/null | grep -qi procps; then
        ps aux --sort=-%cpu 2>/dev/null | head -n "$((_n + 1))"
    else
        ps aux 2>/dev/null | sort -k3rn | head -n "$((_n + 1))"
    fi
}

# -----------------------------------------------------------------------------
# git_cleanup — remove merged branches, prune remote, and run gc
# -----------------------------------------------------------------------------
#
# Cleans a git repository by deleting local branches that have been merged
# into the current branch, pruning remote tracking branches that no longer
# exist on origin, and running automatic garbage collection. Safe to run
# at any time and helps keep the branch list manageable.
#
# Usage:
#   git_cleanup
#
# Examples:
#   $ git_cleanup
#   > Deleted feature-x (was merged)
#   > Pruned origin/obsolete-branch
#   > cleanup done
#
git_cleanup() {
    git branch --merged | grep -v "^*\|main\|master\|develop" | xargs -r git branch -d
    git remote prune origin 2>/dev/null || true
    git gc --auto 2>/dev/null || true
    echo "cleanup done"
}

# -----------------------------------------------------------------------------
# git_search — search git log for string in messages and diffs
# -----------------------------------------------------------------------------
#
# Searches the entire git log for commits that reference a given string,
# either in their commit message or in the diff content. Uses --grep for
# message matching and -G (pickaxe) for content matching, providing a
# comprehensive search across the repository's full history.
#
# Usage:
#   git_search <pattern>
#
# Examples:
#   $ git_search "fix race condition"
#   > === commits matching in message ===
#   > abc1234 Fix race condition in queue handler
#   > === commits touching code ===
#   > def5678 Add test for race condition fix
#
git_search() {
    [ $# -ge 1 ] || { echo "usage: git_search <pattern>" >&2; return 1; }
    echo "=== commits matching in message ==="
    git log --all --oneline --grep="$1" -30 2>/dev/null
    echo "=== commits touching code ==="
    git log --all --oneline -G"$1" -20 2>/dev/null
}

# -----------------------------------------------------------------------------
# git_find — find when a string was introduced in git history
# -----------------------------------------------------------------------------
#
# Uses git log's -S (pickaxe) to find the commit that introduced or removed
# a given string in the codebase. Shows commit hash, date, author, email,
# and subject line for each matching commit. Useful for tracking down when
# and why a specific change was made.
#
# Usage:
#   git_find <string>
#
# Examples:
#   $ git_find "deprecated_function"
#   > abc1234 2024-01-15 Alice <alice@x>
#   >   refactor: replace deprecated_function with new API
#
git_find() {
    [ $# -ge 1 ] || { echo "usage: git_find <string>" >&2; return 1; }
    git log --all -S "$1" --format="%h %ad %an <%ae>%n  %s%n" --date=short 2>/dev/null
}

# -----------------------------------------------------------------------------
# net_listen — show listening ports with process information
# -----------------------------------------------------------------------------
#
# Displays all listening TCP (or UDP) ports along with the process name and
# PID that owns each socket. Uses ss if available (preferred for speed),
# with fallback to netstat and lsof. Accepts an optional protocol filter.
#
# Usage:
#   net_listen [tcp|udp]
#
# Examples:
#   $ net_listen
#   > State  Recv-Q Send-Q  Local Address:Port  Peer Address:Port  Process
#   > LISTEN 0      128     0.0.0.0:22          0.0.0.0:*          users:(("sshd",pid=1234))
#
net_listen() {
    local _proto="${1:-}"
    if command -v ss >/dev/null 2>&1; then
        case "$_proto" in
            tcp) ss -tlnp 2>/dev/null ;;
            udp) ss -ulnp 2>/dev/null ;;
            *) ss -tlnp 2>/dev/null ;;
        esac
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tlnp 2>/dev/null
    elif command -v lsof >/dev/null 2>&1; then
        lsof -i -P -n 2>/dev/null | grep LISTEN
    fi
}

# -----------------------------------------------------------------------------
# local_ip — show local IPv4 addresses for all active interfaces
# -----------------------------------------------------------------------------
#
# Displays the IPv4 addresses assigned to all active network interfaces,
# excluding loopback. On Linux uses 'ip addr', with fallback to 'ifconfig'
# on macOS and other Unix systems, and finally 'hostname -I'.
#
# Usage:
#   local_ip
#
# Examples:
#   $ local_ip
#   > 192.168.1.42
#   > 10.0.0.5
#
local_ip() {
    if command -v ip >/dev/null 2>&1; then
        ip -4 addr show scope global 2>/dev/null | grep -oP 'inet \K[\d.]+'
    elif command -v ifconfig >/dev/null 2>&1; then
        ifconfig 2>/dev/null | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'
    elif command -v hostname >/dev/null 2>&1; then
        hostname -I 2>/dev/null | awk '{print $1}'
    fi
}

# -----------------------------------------------------------------------------
# docker_clean_all — aggressive cleanup of unused Docker resources
# -----------------------------------------------------------------------------
#
# Performs a thorough Docker cleanup by removing all stopped containers,
# dangling and unused images, unused networks, and build cache. This is
# more aggressive than docker system prune because it also removes all
# unused images regardless of whether they are dangling. Supports an
# optional --volumes flag to additionally remove unused named volumes.
#
# Usage:
#   docker_clean_all [--volumes]
#
# Examples:
#   $ docker_clean_all
#   > :: removing unused images...
#   > :: removing build cache...
#   > Total reclaimed space: 2.3GB
#
docker_clean_all() {
    echo ":: removing stopped containers..."
    docker container prune -f 2>/dev/null
    echo ":: removing unused images..."
    docker image prune -af 2>/dev/null
    echo ":: removing unused networks..."
    docker network prune -f 2>/dev/null
    echo ":: removing build cache..."
    docker builder prune -af 2>/dev/null
    if [ "${1:-}" = "--volumes" ]; then
        echo ":: removing unused volumes..."
        docker volume prune -f 2>/dev/null
    fi
    docker system df 2>/dev/null
}

# -----------------------------------------------------------------------------
# docker_compose_rebuild — rebuild and restart compose services
# -----------------------------------------------------------------------------
#
# Rebuilds all (or a specific) Docker Compose service images from scratch
# without using the build cache, then recreates and restarts the containers.
# Useful when dependencies have changed or when you need a guaranteed clean
# build of the service images.
#
# Usage:
#   docker_compose_rebuild [service_name]
#
# Examples:
#   $ docker_compose_rebuild
#   > rebuilding all services...
#   $ docker_compose_rebuild api
#   > rebuilding api...
#
docker_compose_rebuild() {
    if [ $# -eq 0 ]; then
        echo "rebuilding all services..."
        docker compose build --no-cache 2>/dev/null
        docker compose up -d --force-recreate 2>/dev/null
    else
        echo "rebuilding $1..."
        docker compose build --no-cache "$1" 2>/dev/null
        docker compose up -d --force-recreate "$1" 2>/dev/null
    fi
}

# -----------------------------------------------------------------------------
# compress — compress file or directory with auto-detected format
# -----------------------------------------------------------------------------
#
# Creates a compressed archive from a file or directory, selecting the
# compression method based on the output filename extension. Supports
# .tar.gz (default), .tar.bz2, .tar.xz, .zip, .7z, .gz, .bz2, and .xz.
# If no output filename is given, appends .tar.gz to the source name.
#
# Usage:
#   compress <target> [output]
#
# Examples:
#   $ compress mydir
#   > created: mydir.tar.gz
#   $ compress mydir archive.tar.bz2
#   > created: archive.tar.bz2
#
compress() {
    [ $# -ge 1 ] || { echo "usage: compress <target> [output]" >&2; return 1; }
    local _src="$1" _out="${2:-$1.tar.gz}"
    case "$_out" in
        *.tar.gz|*.tgz) tar -czf "$_out" "$_src" ;;
        *.tar.bz2|*.tbz2) tar -cjf "$_out" "$_src" ;;
        *.tar.xz|*.txz) tar -cJf "$_out" "$_src" ;;
        *.zip) zip -r "$_out" "$_src" ;;
        *.7z) 7z a "$_out" "$_src" ;;
        *.gz) gzip -c "$_src" > "$_out" ;;
        *.bz2) bzip2 -c "$_src" > "$_out" ;;
        *.xz) xz -c "$_src" > "$_out" ;;
        *) tar -czf "$_out" "$_src" ;;
    esac
    echo "created: $_out"
}

# -----------------------------------------------------------------------------
# backup_rotate — keep the last N backup files, remove older ones
# -----------------------------------------------------------------------------
#
# Prunes old backup files matching a glob pattern, keeping only the N most
# recent ones by modification time. Useful when used with cron jobs or
# regular script invocations that create periodic backups.
#
# Usage:
#   backup_rotate <glob_pattern> [keep]
#
# Examples:
#   $ backup_rotate "*.backup.sql" 7
#   > only 3 files (keeping 7), nothing to prune
#   $ backup_rotate "db-dump-*.gz" 5
#   > removed: db-dump-20240101.gz
#   > removed: db-dump-20240102.gz
#
# Default keep count: 7.
#
backup_rotate() {
    [ $# -ge 1 ] || { echo "usage: backup_rotate <glob_pattern> [keep]" >&2; return 1; }
    local _pat="$1" _keep="${2:-7}" _files _count
    _files=$(ls -t $_pat 2>/dev/null) || { echo "no files matching: $_pat"; return 0; }
    _count=$(echo "$_files" | wc -l)
    if [ "$_count" -le "$_keep" ]; then
        echo "only $_count files (keeping $_keep), nothing to prune"
        return 0
    fi
    echo "$_files" | tail -n "$((_count - _keep))" | while IFS= read -r _f; do
        rm -f "$_f" && echo "removed: $_f"
    done
}

# -----------------------------------------------------------------------------
# sys_info — comprehensive system overview summary
# -----------------------------------------------------------------------------
#
# Prints a concise summary of the current system: hostname, OS name,
# kernel version, uptime, CPU model, memory usage, and root disk usage.
# Designed as a quick overview when logging into a new machine or for
# inclusion in shell prompts.
#
# Usage:
#   sys_info
#
# Examples:
#   $ sys_info
#   > Hostname: my-machine
#   > OS:       Arch Linux
#   > Kernel:   6.6.1-arch1-1
#   > Uptime:   3 days, 12:34
#   > CPU:      Intel(R) Core(TM) i7-10750H
#   > Memory:   2.1G / 15.6G (13%)
#
sys_info() {
    local _host _os _kernel _uptime _cpu _mem_total _mem_used _mem_pct
    _host=$(hostname 2>/dev/null || echo "N/A")
    _os=$(cat /etc/os-release 2>/dev/null | grep '^PRETTY_NAME=' | cut -d= -f2 | tr -d '"' || sw_vers -productName 2>/dev/null || echo "N/A")
    _kernel=$(uname -r 2>/dev/null || echo "N/A")
    _uptime=$(uptime | sed 's/.*up //; s/,.*//' 2>/dev/null || echo "N/A")
    _cpu=$(lscpu 2>/dev/null | grep 'Model name' | sed 's/Model name:\s*//' || sysctl -n machdep.cpu.brand_string 2>/dev/null || echo "N/A")
    if command -v free >/dev/null 2>&1; then
        _mem_total=$(free -h | awk '/Mem:/{print $2}')
        _mem_used=$(free -h | awk '/Mem:/{print $3}')
        _mem_pct=$(free | awk '/Mem:/{printf "%.0f", $3/$2 * 100}')
    else
        _mem_total="N/A"; _mem_used="N/A"; _mem_pct="N/A"
    fi
    echo "Hostname: $_host"
    echo "OS:       $_os"
    echo "Kernel:   $_kernel"
    echo "Uptime:   $_uptime"
    echo "CPU:      $_cpu"
    echo "Memory:   ${_mem_used} / ${_mem_total} (${_mem_pct}%)"
    if command -v df >/dev/null 2>&1; then
        df -h / | awk 'NR==2{printf "Disk:    %s / %s (%s)\n", $3, $2, $5}'
    fi
}

# -----------------------------------------------------------------------------
# json_pretty — pretty-print JSON from file or stdin
# -----------------------------------------------------------------------------
#
# Formats JSON data with proper indentation using Python's json.tool
# module. Accepts either a filename as an argument or piped input via
# stdin. Validates the JSON input and reports errors for invalid data.
#
# Usage:
#   json_pretty [file]
#
# Examples:
#   $ json_pretty data.json
#   $ echo '{"a":1}' | json_pretty
#   > {
#   >     "a": 1
#   > }
#
json_pretty() {
    if [ $# -ge 1 ]; then
        python3 -m json.tool "$1" 2>/dev/null || { echo "invalid JSON or file not found: $1" >&2; return 1; }
    else
        python3 -m json.tool 2>/dev/null || { echo "invalid JSON from stdin" >&2; return 1; }
    fi
}

# -----------------------------------------------------------------------------
# weather — show current weather conditions for a city
# -----------------------------------------------------------------------------
#
# Fetches and displays the current weather conditions for a given city
# from wttr.in. Shows temperature, conditions, wind speed, and humidity
# in a compact single-line format. If no city is provided, it attempts
# to auto-detect location by IP geolocation.
#
# Usage:
#   weather [city_name]
#
# Examples:
#   $ weather London
#   > London: +12°C ☁️ Overcast  ↙15km/h 72%
#   $ weather "New York"
#   > New York: +18°C ☀️ Sunny  →10km/h 45%
#
weather_report() {
    local _loc="${1:-}"
    if [ -n "$_loc" ]; then
        curl -fsSL "https://wttr.in/${_loc}?format=%l:+%t+%C+%w+%h" 2>/dev/null || echo "unable to fetch weather"
    else
        curl -fsSL "https://wttr.in?format=%l:+%t+%C+%w+%h" 2>/dev/null || echo "unable to fetch weather"
    fi
}

# -----------------------------------------------------------------------------
# markdown_preview — render Markdown to HTML and open in browser
# -----------------------------------------------------------------------------
#
# Converts a Markdown file to HTML using Python's markdown library and
# opens the result in the default web browser. If the markdown library
# is not installed, it falls back to rendering the raw content as a
# preformatted block. Useful for quick documentation previews.
#
# Usage:
#   markdown_preview <file.md>
#
# Examples:
#   $ markdown_preview README.md
#   > Preview opened in browser
#
markdown_preview() {
    [ $# -ge 1 ] || { echo "usage: markdown_preview <file>" >&2; return 1; }
    local _f="$1" _tmp
    [ -f "$_f" ] || { echo "file not found: $_f" >&2; return 1; }
    _tmp=$(mktemp /tmp/mdpreview-XXXXXX.html) || return 1
    if python3 -c "import markdown" 2>/dev/null; then
        python3 -c "import markdown, sys; html = markdown.markdown(open(sys.argv[1]).read()); print(f'<html><body>{html}</body></html>')" "$_f" > "$_tmp"
    else
        python3 -c "import sys, html; print('<html><body><pre>' + html.escape(open(sys.argv[1]).read()) + '</pre></body></html>')" "$_f" > "$_tmp"
    fi
    xdg-open "$_tmp" 2>/dev/null || open "$_tmp" 2>/dev/null || echo "opened: $_tmp"
}
