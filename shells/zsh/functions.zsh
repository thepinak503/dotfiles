# ZSH
#!/usr/bin/env bash
# =============================================================================
# .bash/functions.bash — 200+ unique, distro-agnostic shell functions
# Security-focused, productivity-driven, cross-platform (Linux + macOS).
# =============================================================================

# ===========================================================================
# DOTFILES MODES & SYSTEM
# ===========================================================================

# Change the operational mode of the dotfiles
# Change the operational mode of the dotfiles (Unified)
chmode() {
    local mode="${1:-}"
    case "$mode" in
        basic|minimal|standard|supreme|ultra-nerd)
            echo "Switching to $mode mode..."
            export DOTFILES_MODE="$mode"
            # Persist the mode for next session
            [[ -d "$DOTFILES_STATE_DIR" ]] || mkdir -p "$DOTFILES_STATE_DIR"
            echo "$mode" > "$DOTFILES_STATE_DIR/mode"
            
            # Re-sync to other shells
            if [[ -f "$DOTFILES_DIR/bin/sync_shells.py" ]]; then
                python3 "$DOTFILES_DIR/bin/sync_shells.py"
            fi
            echo -e "\033[1;32m✓ Mode updated. Restart shell or run 'exec $SHELL' to apply.\033[0m"
            ;;
        *)
            echo "Usage: chmode [basic | minimal | standard | supreme | ultra-nerd]"
            echo "Current Mode: $DOTFILES_MODE"
            ;;
    esac
}
alias cm='chmode'
alias dotmode='chmode'


# Fix and re-link all dotfiles
dotfix() {
    echo "Fixing and re-linking dotfiles..."
    if [ -f "$DOTFILES_DIR/install/install.sh" ]; then
        sh "$DOTFILES_DIR/install/install.sh"
    else
        echo "Error: Could not find installer at $DOTFILES_DIR"
    fi
}

# ===========================================================================
# NAVIGATION
# ===========================================================================

# cd with auto-ls after entering
cd() { builtin cd "$@" && ls; }

# Create directory and cd into it
mkcd()   { mkdir -p "$1" && builtin cd "$1"; }

# Go up N directories

# copy and cd to destination

# move and cd to destination

# cd to git root
groot() { builtin cd "$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "Not a git repo"; return 1; }; }

# quick jump to dotfiles
dot() { builtin cd "$DOTFILES_DIR"; }

# ===========================================================================
# FILES & ARCHIVES
# ===========================================================================

# Universal extract — supports every common archive format

# Extract and cd into the directory
excd() {
    extract "$1"
    local d="${1%.*}"
    [[ -d "$d" ]] && builtin cd "$d"
}

# Create a .tar.gz of a path
mktar()   { tar -czvf "${1:-$(basename "$PWD")}.tar.gz" "${2:-.}"; }
mktarbz() { tar -cjvf "${1:-$(basename "$PWD")}.tar.bz2" "${2:-.}"; }
mktarxz() { tar -cJvf "${1:-$(basename "$PWD")}.tar.xz" "${2:-.}"; }
mkzst()   { tar --zstd -cvf "${1:-$(basename "$PWD")}.tar.zst" "${2:-.}"; }

# Backup file with timestamp
bak() {
    [[ -f "$1" ]] || { echo "File not found: $1"; return 1; }
    local dst; dst="$1.bak.$(date +%Y%m%d_%H%M%S)"
    cp -a "$1" "$dst" && echo "Backed up → $dst"
}

# Restore the latest backup
unbak() {
    local latest; latest="$(find . -maxdepth 1 -name "${1}.bak.*" -type f -printf "%T@ %p\n" 2>/dev/null | sort -nr | head -1 | cut -d' ' -f2)"
    [[ -z "$latest" ]] && { echo "No backup found for: $1"; return 1; }
    cp -a "$latest" "$1" && echo "Restored from: $latest"
}

# Touch with automatic parent dir creation
touchp() { mkdir -p "$(dirname "$1")" && touch "$1"; }

# Swap two files atomically
swap() {
    [[ $# -ne 2 ]] && { echo "Usage: swap <file1> <file2>"; return 1; }
    local tmp; tmp="$(mktemp)"
    mv "$1" "$tmp" && mv "$2" "$1" && mv "$tmp" "$2"
    echo "Swapped: $1 ↔ $2"
}

# Copy with progress bar (rsync)
cpv() { rsync -ah --info=progress2 "$@"; }

# Find file by name (fd → find fallback)
ff()  { if command -v fd &>/dev/null; then fd "$1" "${2:-.}"; else find "${2:-.}" -type f -iname "*$1*" 2>/dev/null; fi; }
ffd() { if command -v fd &>/dev/null; then fd --type d "$1" "${2:-.}"; else find "${2:-.}" -type d -iname "*$1*" 2>/dev/null; fi; }

# Search text in files (rg → grep)

# Largest N files in a directory
largest()     { find "${1:-.}" -type f -exec du -h {} + 2>/dev/null | sort -rh | head "${2:-10}"; }
largestdirs() { du -h --max-depth=1 "${1:-.}" 2>/dev/null | sort -rh | head "${2:-10}"; }

# Disk usage summary
diskusage() {
    echo "=== Disk Partitions ==="
    df -hT | grep -v tmpfs | grep -v devtmpfs
    echo ""
    echo "=== Top 10 dirs in $HOME ==="
    du -h --max-depth=1 "$HOME" 2>/dev/null | sort -rh | head 10
}

# Count files / links / directories
countfiles() {
    for t in files links directories; do
        echo "$(find . -type "${t:0:1}" 2>/dev/null | wc -l) $t"
    done
}

# Show file size (mathiasbynens)
fs() {
    local arg="-sbh"
    du -b /dev/null &>/dev/null || arg="-sh"
    if [[ -n "$*" ]]; then du $arg -- "$@"; else du $arg .[^.]* ./*; fi
}

# Open file/URL (cross-platform)
xopen() {
    if [[ "$DOTFILES_OS" == "Darwin" ]]; then
        command open "$@"
    else
        xdg-open "$@" &>/dev/null &
    fi
}

# Quick note with timestamp
note() {
    local f="$HOME/.notes"
    if [[ -z "$1" ]]; then
        [[ -f "$f" ]] && less "$f" || echo "No notes yet."
    else
        echo "$(date '+%Y-%m-%d %H:%M') — $*" >> "$f"
        echo "Note saved."
    fi
}

# Show, clear, or search notes
notes-clear()  { true > "$HOME/.notes" && echo "Notes cleared."; }
notes-search() { grep -i "$1" "$HOME/.notes" 2>/dev/null; }

# ===========================================================================
# GIT
# ===========================================================================

# git add all + commit

# git add all, commit, push

# Emergency git push — add everything, commit, force-push, no questions asked
# Usage: sos "message"  or just: sos  (auto-generates timestamp message)
sosgit() {
    local branch msg
    branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || { echo "Not a git repo"; return 1; }
    msg="${*:-"🚨 EMERGENCY PUSH $(date '+%Y-%m-%d %H:%M:%S') from $(hostname)"}"
    echo -e "\033[1;31m⚡ EMERGENCY MODE\033[0m"
    echo "  Branch : $branch"
    echo "  Message: $msg"
    git add -A
    git stash pop 2>/dev/null  # recover any stashed work too
    git commit -m "$msg" --no-verify
    git push --force-with-lease origin "$branch" || git push origin "$branch" || {
        # If upstream isn't set, set it and push
        git push --set-upstream origin "$branch"
    }
    local status=$?
    if [[ $status -eq 0 ]]; then
        echo -e "\033[1;32m✓ Emergency push complete.\033[0m"
    else
        echo -e "\033[1;31m✗ Push failed! Try manual push.\033[0m"
    fi
    return $status
}

# git add -A + commit (distinct from gca = --amend)
gcall() {
    [[ -z "$1" ]] && { echo "Usage: gcall <message>"; return 1; }
    git add -A && git commit -m "$*"
}

# Signed commit (requires GPG key)
gcmsign() {
    [[ -z "$1" ]] && { echo "Usage: gcmsign <message>"; return 1; }
    git add -A && git commit -S -m "$*"
}

# Interactive rebase N commits
grib() {
    [[ -z "$1" ]] && { echo "Usage: grib <N>"; return 1; }
    git rebase -i "HEAD~$1"
}

# Clean merged branches
git-clean() {
    git fetch -p
    git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -r git branch -d
    echo "Cleaned merged branches."
}

# Squash last N commits
gsquash() {
    [[ -z "$1" ]] && { echo "Usage: gsquash <N>"; return 1; }
    git reset --soft "HEAD~$1"
    echo "Squashed $1 commits. Now commit:"
    echo "  git commit -m \"<message>\""
}

# Git repo info
ginfo() {
    printf "Branch  : %s\n" "$(git branch --show-current 2>/dev/null || echo N/A)"
    printf "Remote  : %s\n" "$(git remote get-url origin 2>/dev/null || echo N/A)"
    printf "Commit  : %s\n" "$(git log -1 --pretty='%h – %s (%ar)' 2>/dev/null || echo N/A)"
    printf "Staged  : %s files\n" "$(git diff --cached --name-only 2>/dev/null | wc -l)"
    printf "Modified: %s files\n" "$(git diff --name-only 2>/dev/null | wc -l)"
    echo ""
    git status -sb 2>/dev/null
}

# Git statistics
gstats() {
    echo "Commits   : $(git rev-list --count HEAD 2>/dev/null)"
    echo "Branches  : $(git branch | wc -l)"
    echo "Stashes   : $(git stash list | wc -l)"
    echo "Tags      : $(git tag | wc -l)"
    echo "Top authors:"
    git shortlog -sn --all --no-merges | head -5
}

# Pretty log (N lines)
glog() { git log --oneline --graph --decorate "-${1:-20}"; }

# Show git diff stat
gdiffs() { git diff --stat "${1:-HEAD}"; }

# Create and push new branch
gnewbranch() {
    [[ -z "$1" ]] && { echo "Usage: gnewbranch <name>"; return 1; }
    git switch -c "$1" && git push -u origin "$1"
}

# Delete branch locally and remotely
gdelb() {
    [[ -z "$1" ]] && { echo "Usage: gdelb <branch>"; return 1; }
    git branch -d "$1"
    git push origin --delete "$1"
}

# Show files changed in last N commits
gchanged() { git diff --name-only "HEAD~${1:-1}" HEAD; }

# Interactive fuzzy branch checkout (requires fzf)
fgco() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local branch; branch="$(git branch -a | sed 's/remotes\/origin\///' | sort -u | fzf --prompt='branch> ')"
    [[ -n "$branch" ]] && git checkout "$(echo "$branch" | xargs)"
}

# Fuzzy stash picker
fgstash() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local stash; stash="$(git stash list | fzf | cut -d: -f1)"
    [[ -n "$stash" ]] && git stash show -p "$stash"
}

# Git sync: pull, prune, and clean
gsync() {
    git fetch --all --prune
    git pull --rebase --autostash
    git-clean
}

# Dotfiles sync
dsync() {
    local root="${DOTFILES_DIR:-$HOME/.dotfiles}"
    [[ -d "$root/.git" ]] || { echo "Dotfiles repo not found at $root"; return 1; }
    echo "Syncing $root..."
    git -C "$root" fetch --all --prune
    git -C "$root" pull --rebase --autostash
    [[ -f "$root/.gitmodules" ]] && git -C "$root" submodule update --init --recursive
    echo "Sync complete."
}

# Dotfiles push (add, commit, push)
dpush() {
    local root="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local msg="${1:-"chore: sync dotfiles $(date +%Y-%m-%d)"}"
    git -C "$root" add -A
    git -C "$root" commit -m "$msg"
    git -C "$root" push
}

# ===========================================================================
# DOCKER
# ===========================================================================

# System prune all
docker-clean() {
    echo "Pruning Docker system..."
    docker system prune -af --volumes && echo "Done."
}

# Stop all running containers
docker-stop-all() { docker ps -q | xargs -r docker stop && echo "All containers stopped."; }

# Remove all containers
docker-rm-all()   { docker ps -aq | xargs -r docker rm -f && echo "All containers removed."; }

# Remove all images
docker-rmi-all()  { docker images -q | xargs -r docker rmi -f && echo "All images removed."; }

# Docker disk usage
docker-du() { docker system df -v; }

# Interactive exec into running container (fzf)
dexec() {
    command -v fzf &>/dev/null || { echo "Install fzf for interactive mode"; return 1; }
    local c; c="$(docker ps --format '{{.Names}}' | fzf --prompt='container> ')"
    [[ -n "$c" ]] && docker exec -it "$c" /bin/bash
}

# Follow logs from container (fzf picker)
dlf() {
    command -v fzf &>/dev/null || { echo "Install fzf for interactive mode"; return 1; }
    local c; c="$(docker ps --format '{{.Names}}' | fzf --prompt='logs> ')"
    [[ -n "$c" ]] && docker logs -f "$c"
}

# Docker container IP
dip() {
    local c="${1:-$(docker ps --format '{{.Names}}' | head -1)}"
    docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$c"
}

# ===========================================================================
# KUBERNETES HELPERS
# ===========================================================================

# Watch pods in current namespace
kwatch() { watch -n 2 kubectl get pods "${@}"; }

# Tail logs from pod matching pattern (fzf)
klf() {
    command -v fzf &>/dev/null || { echo "Install fzf"; return 1; }
    local pod; pod="$(kubectl get pods --no-headers | fzf --prompt='pod> ' | awk '{print $1}')"
    [[ -n "$pod" ]] && kubectl logs -f "$pod" "${@}"
}

# Exec into pod (fzf)
kexf() {
    command -v fzf &>/dev/null || { echo "Install fzf"; return 1; }
    local pod; pod="$(kubectl get pods --no-headers | fzf --prompt='exec> ' | awk '{print $1}')"
    [[ -n "$pod" ]] && kubectl exec -it "$pod" -- "${1:-/bin/sh}"
}

# Get secret value decoded
ksecret() {
    [[ -z "$1" ]] && { echo "Usage: ksecret <secret-name> [key]"; return 1; }
    if [[ -n "$2" ]]; then
        kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 -d && echo
    else
        if kubectl get secret "$1" -o json | command -v jq &>/dev/null; then
            kubectl get secret "$1" -o json | jq '.data | map_values(@base64d)'
        else
            kubectl get secret "$1" -o yaml
        fi
    fi
}

# Switch k8s namespace
kns() {
    if command -v fzf &>/dev/null && [[ -z "$1" ]]; then
        local ns; ns="$(kubectl get ns --no-headers | fzf --prompt='namespace> ' | awk '{print $1}')"
        [[ -n "$ns" ]] && kubectl config set-context --current --namespace="$ns"
    else
        kubectl config set-context --current --namespace="$1"
    fi
}

# Switch k8s context
kctxf() {
    command -v fzf &>/dev/null || { kubectl config use-context "$1"; return; }
    local ctx; ctx="$(kubectl config get-contexts --no-headers | fzf --prompt='context> ' | awk '{print $2}')"
    [[ -n "$ctx" ]] && kubectl config use-context "$ctx"
}

# ===========================================================================
# SYSTEM & NETWORK
# ===========================================================================

# Cross-distro system update
sysupdate() {
    echo "Updating system (${DOTFILES_PKG:-auto-detect})..."
    case "${DOTFILES_PKG:-}" in
        pacman) sudo pacman -Syu ;;
        apt)    sudo apt-get update && sudo apt-get upgrade -y ;;
        dnf)    sudo dnf upgrade -y ;;
        yum)    sudo yum update -y ;;
        zypper) sudo zypper update -y ;;
        xbps)   sudo xbps-install -Su ;;
        apk)    sudo apk upgrade ;;
        emerge) sudo emerge --update --deep --newuse @world ;;
        brew)   brew update && brew upgrade ;;
        *)
            if command -v pacman &>/dev/null;       then sudo pacman -Syu
            elif command -v apt-get &>/dev/null;    then sudo apt-get update && sudo apt-get upgrade -y
            elif command -v dnf &>/dev/null;        then sudo dnf upgrade -y
            elif command -v brew &>/dev/null;       then brew update && brew upgrade
            else echo "No supported package manager found"; return 1
            fi ;;
    esac
}

# Get internal + external IP
myip() {
    printf "Internal: "
    if command -v ip &>/dev/null; then
        ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1 | head -1
    elif command -v ifconfig &>/dev/null; then
        ifconfig 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1
    fi
    printf "External: "
    curl -4s --max-time 5 https://ifconfig.me 2>/dev/null || curl -4s --max-time 5 https://icanhazip.com 2>/dev/null || echo "N/A"
    echo
}
alias whatismyip='myip'

# Check open port on remote host
portopen() {
    local host="$1" port="$2"
    [[ -z "$host" || -z "$port" ]] && { echo "Usage: portopen <host> <port>"; return 1; }
    timeout 3 bash -c ">/dev/tcp/$host/$port" 2>/dev/null \
        && echo "Port $port on $host is OPEN" \
        || echo "Port $port on $host is CLOSED / filtered"
}

# Kill process on a port
killport() {
    [[ -z "$1" ]] && { echo "Usage: killport <port>"; return 1; }
    local pids; pids="$(lsof -ti:"$1" 2>/dev/null)"
    [[ -z "$pids" ]] && { echo "Nothing on port $1"; return 0; }
    echo "$pids" | xargs kill -9 && echo "Killed process(es) on :$1"
}

# What is using port
portused() {
    [[ -z "$1" ]] && { echo "Usage: portused <port>"; return 1; }
    lsof -i:"$1" 2>/dev/null || ss -tulnp | grep ":$1"
}

# Check if host is reachable
reachable() {
    ping -c 1 -W 2 "$1" &>/dev/null && echo "$1 is reachable" || echo "$1 is NOT reachable"
}

# Weather (wttr.in)
weather() { curl -s "wttr.in/${1:-}?lang=en"; }

# Quick HTTP server
serve() {
    local port="${1:-8000}"
    echo "Serving on http://localhost:$port"
    python3 -m http.server "$port"
}

# DNS lookup all records
digga() { dig +nocmd "$1" any +multiline +noall +answer; }

# SSL certificate check
sslcheck() {
    [[ -z "$1" ]] && { echo "Usage: sslcheck <domain>"; return 1; }
    echo | openssl s_client -servername "$1" -connect "$1:443" 2>/dev/null \
        | openssl x509 -noout -subject -issuer -dates
}

# Get cert SAN names
certnames() {
    [[ -z "$1" ]] && { echo "Usage: certnames <domain>"; return 1; }
    local tmp; tmp="$(echo -e "GET / HTTP/1.0\nEOT" | openssl s_client -connect "$1:443" -servername "$1" 2>&1)"
    echo "$tmp" | grep -A1 "Subject Alternative Name:" | tail -1 \
        | sed -e 's/DNS://g' -e 's/ //g' | tr ',' '\n'
}

# Search process
psg() { # shellcheck disable=SC2009
        ps aux | grep -v grep | grep -i "$1"; }

# Fuzzy kill process
fkill() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local pids; pids="$(ps aux | sed 1d | fzf --multi --header='Select process(es) to kill' | awk '{print $2}')"
    [[ -n "$pids" ]] && echo "$pids" | xargs kill -9 && echo "Killed."
}

# Show who's logged in with IPs
ww() { who -a; w; }

# Distro detection

# ===========================================================================
# SECURITY
# ===========================================================================

# Generate cryptographically strong password
genpass() {
    local len="${1:-32}"
    openssl rand -base64 64 | tr -dc 'a-zA-Z0-9!@#$%^&*()-_=+[]{}|;:,.<>?' | head -c "$len"
    echo
}

# Generate passphrase (memorable)
genphrase() {
    local words="${1:-4}"
    # Uses /usr/share/dict/words if available, else fallback
    if [[ -f /usr/share/dict/words ]]; then
        shuf -n "$words" /usr/share/dict/words | tr '\n' '-' | sed 's/-$//'
        echo
    else
        genpass "$((words * 8))"
    fi
}

# Hash a string or file
hashfile() {
    [[ -z "$1" ]] && { echo "Usage: hashfile <file>"; return 1; }
    echo "SHA256 : $(sha256sum "$1" | cut -d' ' -f1)"
    echo "SHA512 : $(sha512sum "$1" | cut -d' ' -f1)"
    echo "MD5    : $(md5sum    "$1" | cut -d' ' -f1)"
}

# Securely wipe a file (3-pass)
securerm() {
    [[ -z "$1" ]] && { echo "Usage: securerm <file>"; return 1; }
    shred -u -z -n 3 "$1" && echo "Securely deleted: $1"
}

# Encrypt a file with GPG
encrypt() {
    [[ -z "$2" ]] && { echo "Usage: encrypt <recipient-email> <file>"; return 1; }
    gpg --encrypt --armor -r "$1" "$2" && echo "Encrypted: ${2}.asc"
}

# Decrypt a GPG file
decrypt() {
    [[ -z "$1" ]] && { echo "Usage: decrypt <file.gpg|file.asc>"; return 1; }
    gpg --decrypt "$1"
}

# Sign a file with GPG
gpgsign() {
    [[ -z "$1" ]] && { echo "Usage: gpgsign <file>"; return 1; }
    gpg --clearsign "$1" && echo "Signed: ${1}.asc"
}

# Check GPG signature
gpgverify() {
    [[ -z "$1" ]] && { echo "Usage: gpgverify <file.sig> [file]"; return 1; }
    gpg --verify "$1" "$2"
}

# Base64 encode/decode
b64e() { echo -n "$1" | base64; }
b64d() { echo -n "$1" | base64 -d; echo; }

# URL encode/decode
urlencode() { python3 -c "import sys,urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$1"; }
urldecode() { python3 -c "import sys,urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$1"; }

# JWT decode (without verification — for inspection only)
jwtdecode() {
    [[ -z "$1" ]] && { echo "Usage: jwtdecode <jwt-token>"; return 1; }
    local payload; payload="$(echo "$1" | cut -d. -f2)"
    # Pad base64 if needed
    local padded; padded="${payload}$(printf '%0.s=' $(seq 1 $(( 4 - ${#payload} % 4 ))))"
    echo "$padded" | base64 -d 2>/dev/null | python3 -m json.tool 2>/dev/null || echo "Failed to decode JWT"
}

# Check if running as root
is_root() { [[ $EUID -eq 0 ]]; }

# Require root or exit
require_root() {
    is_root || { echo "This command requires root privileges."; return 1; }
}

# Audit SUID/SGID binaries
audit_suid() {
    echo "=== SUID Binaries ==="
    find / -perm /4000 -type f 2>/dev/null | sort
    echo ""
    echo "=== SGID Binaries ==="
    find / -perm /2000 -type f 2>/dev/null | sort
}

# Find world-writable files
audit_worldwrite() {
    echo "=== World-writable files ==="
    find / -perm /o+w -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null | sort
}

# Check SSH configuration for weak settings
audit_ssh() {
    local f="/etc/ssh/sshd_config"
    [[ -f "$f" ]] || { echo "sshd_config not found"; return 1; }
    echo "=== SSH Security Audit ==="
    grep -E "^(PermitRootLogin|PasswordAuthentication|ChallengeResponseAuthentication|X11Forwarding|AllowTcpForwarding|UsePAM|Protocol)" "$f" 2>/dev/null
}

# Data URL from file (for embedding in HTML)
dataurl() {
    local mime; mime="$(file -b --mime-type "$1")"
    [[ $mime == text/* ]] && mime="${mime};charset=utf-8"
    echo "data:${mime};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Upload to hastebin
    # shellcheck disable=SC2317
hb() {
    [[ -f "$1" ]] || { echo "Usage: hb <file>"; return 1; }
    local key; key="$(curl -s -X POST -d @"$1" http://bin.christitus.com/documents | grep -o '"key":"[^"]*"' | cut -d'"' -f4)"
    echo "http://bin.christitus.com/$key"
}

# ===========================================================================
# DEVELOPMENT UTILITIES
# ===========================================================================

# Timer for a command
timer() {
    local s; s="$(date +%s%N)"
    "$@"
    local e; e="$(date +%s%N)"
    printf "Duration: %.3fs\n" "$(echo "scale=3; ($e - $s) / 1000000000" | bc)"
}

# Calculator (bc → python3)
calc() {
    [[ -z "$*" ]] && { echo "Usage: calc <expression>"; return 1; }
    echo "$*" | bc -l 2>/dev/null || python3 -c "from math import *; print($*)"
}

# QR code in terminal
qr() {
    [[ -z "$1" ]] && { echo "Usage: qr <text>"; return 1; }
    curl -s "qrenco.de/$1"
}

# Cheat sheet (cheat.sh)
cheat() {
    [[ -z "$1" ]] && { echo "Usage: cheat <command>"; return 1; }
    curl -s "cheat.sh/$1" | less -R
}

# Look up a man page in tldr format
tman() {
    if command -v tldr &>/dev/null; then
        tldr "$1"
    elif command -v tealdeer &>/dev/null; then
        tldr "$1"
    else
        man "$1"
    fi
}

# JSON pretty print
json() {
    if command -v jq &>/dev/null; then
        jq --color-output . <<< "$1" 2>/dev/null || echo "$1" | jq --color-output . 2>/dev/null
    else
        python3 -m json.tool <<< "$1"
    fi
}

# YAML pretty print
yamlfmt() {
    if command -v yq &>/dev/null; then
        yq eval '.' "$1"
    elif command -v python3 &>/dev/null; then
        python3 -c "import sys,yaml; yaml.dump(yaml.safe_load(open('$1')),sys.stdout,default_flow_style=False)"
    fi
}

# Convert JSON to YAML
json2yaml() {
    python3 -c "import sys,json,yaml; yaml.dump(json.load(open('$1')),sys.stdout,default_flow_style=False)"
}

# Convert YAML to JSON
yaml2json() {
    python3 -c "import sys,json,yaml; json.dump(yaml.safe_load(open('$1')),sys.stdout,indent=2)"
}

# Colorize log output (ERROR=red WARN=yellow INFO=green DEBUG=cyan)
colorize() {
    sed \
        -e "s/\(ERROR\)/\033[0;31m\1\033[0m/g" \
        -e "s/\(WARN\)/\033[0;33m\1\033[0m/g"  \
        -e "s/\(INFO\)/\033[0;32m\1\033[0m/g"  \
        -e "s/\(DEBUG\)/\033[0;36m\1\033[0m/g"
}

# Follow log with colorize
logtail() { tail -f "${1:--}" | colorize; }

# HTTP status code check
httping() {
    [[ -z "$1" ]] && { echo "Usage: httping <url>"; return 1; }
    curl -o /dev/null -s -w "%{http_code} %{time_total}s %{url_effective}\n" "$1"
}

# Validate JSON file
jsoncheck() {
    if command -v jq &>/dev/null; then
        jq . "$1" >/dev/null && echo "✓ Valid JSON" || echo "✗ Invalid JSON"
    else
        python3 -m json.tool "$1" >/dev/null && echo "✓ Valid JSON" || echo "✗ Invalid JSON"
    fi
}

# Validate YAML file
yamlcheck() {
    python3 -c "import yaml; yaml.safe_load(open('$1'))" 2>/dev/null \
        && echo "✓ Valid YAML" || echo "✗ Invalid YAML"
}

# Validate TOML file
tomlcheck() {
    python3 -c "
try:
    import tomllib
except ImportError:
    import tomli as tomllib
with open('$1','rb') as f: tomllib.load(f)
print('✓ Valid TOML')
" 2>/dev/null || echo "✗ Invalid TOML"
}

# Quick diff between two commands
diffcmds() {
    diff <(eval "$1") <(eval "$2")
}

# Watch a command with color
watchc() { watch --color -n "${1:-2}" "${@:2}"; }

# Repeat command N times
repeatn() {
    local n="$1"; shift
    for (( i=0; i<n; i++ )); do "$@"; done
}

# Run command in background silently
bg_run() { nohup "$@" &>/dev/null & echo "PID: $!"; }

# Wait for a host to come online
wait_for() {
    local host="$1" port="${2:-22}" timeout="${3:-60}"
    echo "Waiting for $host:$port (timeout: ${timeout}s)..."
    for (( i=0; i<timeout; i++ )); do
        timeout 1 bash -c ">/dev/tcp/$host/$port" 2>/dev/null && { echo "Online!"; return 0; }
        sleep 1
    done
    echo "Timed out waiting for $host:$port"
    return 1
}

# ===========================================================================
# FZF-POWERED FUNCTIONS
# ===========================================================================

# Fuzzy open file in editor
fo() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local f; f="$(find . -type f -name "*${1:-}*" 2>/dev/null | fzf \
        --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}')"
    [[ -n "$f" ]] && "$EDITOR" "$f"
}

# Fuzzy cd into directory
fcd() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local d; d="$(find . -type d -not -path '*/.git/*' 2>/dev/null | fzf \
        --preview 'tree -C {} | head -20 2>/dev/null || ls {}')"
    [[ -n "$d" ]] && builtin cd "$d"
}

# Fuzzy history search and execute
fh() {
    command -v fzf &>/dev/null || { echo "fzf not installed"; return 1; }
    local cmd; cmd="$(history | awk '{$1=""; print substr($0,2)}' | sort -u | fzf --tac --prompt='history> ')"
    [[ -n "$cmd" ]] && eval "$cmd"
}

# Fuzzy alias browser
falias() {
    command -v fzf &>/dev/null || { alias | less; return; }
    alias | fzf --prompt='alias> '
}

# Fuzzy environment variable browser
fenv() {
    command -v fzf &>/dev/null || { env | sort | less; return; }
    env | sort | fzf --prompt='env> '
}

# ===========================================================================
# YAZI / RANGER / FILE MANAGERS
# ===========================================================================

# Yazi with cd-on-exit
if command -v yazi &>/dev/null; then
    y() {
        local tmp; tmp="$(mktemp -t yazi-cwd.XXXXXX)"
        yazi "$@" --cwd-file="$tmp"
        local cwd; cwd="$(cat -- "$tmp")"
        [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
    }
fi

# Ranger with cd-on-exit
if command -v ranger &>/dev/null; then
    ranger-cd() {
        local tmp; tmp="$(mktemp -t ranger-cwd.XXXXXX)"
        ranger --choosedir="$tmp" "$@"
        local dir; dir="$(<"$tmp" 2>/dev/null)"
        rm -f "$tmp"
        [[ -d "$dir" && "$dir" != "$PWD" ]] && builtin cd "$dir"
    }
    alias r='ranger-cd'
fi

# ===========================================================================
# DIRECTORY BOOKMARKS
# ===========================================================================

BOOKMARKS_FILE="$HOME/.directory_bookmarks"

bm()     { pwd >> "$BOOKMARKS_FILE" && sort -u "$BOOKMARKS_FILE" -o "$BOOKMARKS_FILE" && echo "Bookmarked: $(pwd)"; }
bml()    { cat "$BOOKMARKS_FILE" 2>/dev/null || echo "No bookmarks."; }
bmrm()   { grep -v "^$(pwd)$" "$BOOKMARKS_FILE" > /tmp/bm.tmp && mv /tmp/bm.tmp "$BOOKMARKS_FILE" && echo "Removed: $(pwd)"; }
bmclear(){ true > "$BOOKMARKS_FILE" && echo "Bookmarks cleared."; }
bmgo() {
    command -v fzf &>/dev/null || { cat "$BOOKMARKS_FILE"; return; }
    local d; d="$(fzf --prompt='bookmark> ' < "$BOOKMARKS_FILE" 2>/dev/null --prompt='bookmark> ')"
    [[ -n "$d" ]] && builtin cd "$d"
}

# ===========================================================================
# MISC UTILITIES
# ===========================================================================

# Short pwd (last 2 components)

# Watch command output every 2s
watchcmd() { while true; do clear; "$@"; sleep 2; done; }

# Terminal title
title() { printf '\033]0;%s\007' "$*"; }

# Columns info
termsize() { echo "Columns: $COLUMNS  Lines: $LINES"; }

# Quick benchmark N runs of a command
bench() {
    local n="${1:-10}"; shift
    echo "Running $n iterations of: $*"
    local s; s="$(date +%s%N)"
    for (( i=0; i<n; i++ )); do "$@" &>/dev/null; done
    local e; e="$(date +%s%N)"
    printf "Total: %.3fs  Avg: %.3fs\n" \
        "$(echo "scale=3; ($e-$s)/1000000000" | bc)" \
        "$(echo "scale=3; ($e-$s)/1000000000/$n" | bc)"
}

# gzip size comparison
gz() {
    local orig gzip ratio
    orig="$(wc -c < "$1")"
    gzip="$(gzip -c "$1" | wc -c)"
    ratio="$(echo "scale=2; $gzip*100/$orig" | bc)"
    printf "orig: %d bytes\ngzip: %d bytes (%.2f%%)\n" "$orig" "$gzip" "$ratio"
}

# DNS over HTTPS (Cloudflare)
doh() {
    [[ -z "$1" ]] && { echo "Usage: doh <domain> [type]"; return 1; }
    curl -sH "accept: application/dns-json" \
        "https://cloudflare-dns.com/dns-query?name=$1&type=${2:-A}" | python3 -m json.tool 2>/dev/null
}

# Check HTTPS headers of a URL
httpheaders() {
    [[ -z "$1" ]] && { echo "Usage: httpheaders <url>"; return 1; }
    curl -sI --max-time 10 "$1"
}

# Follow redirects of a URL
redirects() {
    [[ -z "$1" ]] && { echo "Usage: redirects <url>"; return 1; }
    curl -sIL --max-time 15 "$1" | grep -E "^(HTTP|Location)"
}

# Merge PDFs (requires ghostscript)
mergepdf() {
    [[ $# -lt 2 ]] && { echo "Usage: mergepdf <out.pdf> <in1.pdf> <in2.pdf> ..."; return 1; }
    local out="$1"; shift
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$out" "$@" && echo "Merged → $out"
}

# Split PDF pages (requires pdftk)
splitpdf() {
    [[ -z "$1" ]] && { echo "Usage: splitpdf <file.pdf>"; return 1; }
    command -v pdftk &>/dev/null || { echo "Install pdftk"; return 1; }
    pdftk "$1" burst output "${1%.pdf}_%04d.pdf"
}

# Dotfiles error log viewer
dotlog() { dotlog_show 2>/dev/null || cat "${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}/errors.log" 2>/dev/null || echo "No logs."; }

# macOS-only: QuickLook preview
if [[ "$DOTFILES_OS" == "Darwin" ]]; then
    ql() { qlmanage -p "$@" &>/dev/null; }
fi

# Verbose cleanup /tmp
cleanup() { sudo rm -rf /tmp/* 2>/dev/null && echo "Cleaned /tmp"; }

# Usage stats top dirs
Usage() { du -sh ./* 2>/dev/null | sort -rh | head 10; }

# Count lines of code in a dir
cloc() {
    if command -v tokei &>/dev/null; then tokei "${1:-.}"
    elif command -v cloc &>/dev/null; then cloc "${1:-.}"
    else find "${1:-.}" -name "*.${2:-py}" -exec wc -l {} + 2>/dev/null | tail -1
    fi
}

# ===========================================================================
# FUNCTIONS (ZachBrowne / Titus)
# ===========================================================================
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf "$archive" ;;
			*.tar.gz) tar xvzf "$archive" ;;
			*.bz2) bunzip2 "$archive" ;;
			*.rar) rar x "$archive" ;;
			*.gz) gunzip "$archive" ;;
			*.tar) tar xvf "$archive" ;;
			*.tbz2) tar xvjf "$archive" ;;
			*.tgz) tar xvzf "$archive" ;;
			*.zip) unzip "$archive" ;;
			*.Z) uncompress "$archive" ;;
			*.7z) 7z x "$archive" ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

ftext() {
	grep -iIHrn --color=always "$1" . | less -r
}

cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++) printf "="
            printf ">"
            for (i=percent;i<100;i++) printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

cpg() {
	if [ -d "$2" ]; then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

mvg() {
	if [ -d "$2" ]; then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$2"
	fi
}

mkdirg() {
	mkdir -p "$1"
	cd "$1"
}

up() {
	local d=""
	limit=$1
	for ((i = 1; i <= limit; i++)); do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd "$d"
}

pwdtail() {
	pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

distribution () {
    local dtype="unknown"
    if [ -r /etc/os-release ]; then
        source /etc/os-release
        case $ID in
            fedora|rhel|centos) dtype="redhat" ;;
            sles|opensuse*) dtype="suse" ;;
            ubuntu|debian) dtype="debian" ;;
            gentoo) dtype="gentoo" ;;
            arch|manjaro) dtype="arch" ;;
            slackware) dtype="slackware" ;;
            *)
                if [ -n "$ID_LIKE" ]; then
                    case $ID_LIKE in
                        *fedora*|*rhel*|*centos*) dtype="redhat" ;;
                        *sles*|*opensuse*) dtype="suse" ;;
                        *ubuntu*|*debian*) dtype="debian" ;;
                        *gentoo*) dtype="gentoo" ;;
                        *arch*) dtype="arch" ;;
                        *slackware*) dtype="slackware" ;;
                    esac
                fi
                ;;
        esac
    fi
    echo $dtype
}

ver() {
    local dtype
    dtype=$(distribution)
    case $dtype in
        "redhat") if [ -s /etc/redhat-release ]; then cat /etc/redhat-release; else cat /etc/issue; fi; uname -a ;;
        "suse") cat /etc/SuSE-release ;;
        "debian") lsb_release -a ;;
        "gentoo") cat /etc/gentoo-release ;;
        "arch") cat /etc/os-release ;;
        "slackware") cat /etc/slackware-version ;;
        *) if [ -s /etc/issue ]; then cat /etc/issue; else echo "Error: Unknown distribution"; exit 1; fi ;;
    esac
}

install_bashrc_support() {
	local dtype; dtype=$(distribution)
	case $dtype in
		"redhat") sudo yum install multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
		"suse") sudo zypper install multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
		"debian")
			sudo apt-get install multitail tree zoxide trash-cli fzf bash-completion
			FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
			curl -sL "$FASTFETCH_URL" -o /tmp/fastfetch_latest_amd64.deb
			sudo apt-get install /tmp/fastfetch_latest_amd64.deb
			;;
		"arch") sudo paru multitail tree zoxide trash-cli fzf bash-completion fastfetch ;;
		"slackware") echo "No install support for Slackware" ;;
		*) echo "Unknown distribution" ;;
	esac
}

whatsmyip() {
    # Get the default interface
    local iface
    iface=$(ip route show default | awk '/default/ {print $5}' | head -n1)
    
    # Fallback to the first non-loopback interface if no default route
    if [[ -z "$iface" ]]; then
        iface=$(ip -o link show | awk -F': ' '$2 != "lo" {print $2}' | head -n1)
    fi

    if [[ -n "$iface" ]]; then
        echo -n "Internal IP (${iface}): "
        ip addr show "$iface" | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo "Internal IP: No interface found"
    fi

    echo -n "External IP: "
    curl -4s --max-time 5 ifconfig.me || echo "Timeout/Offline"
}

apachelog() {
	if [ -f /etc/httpd/conf/httpd.conf ]; then
		cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
	else
		cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
	fi
}

apacheconfig() {
	if [ -f /etc/httpd/conf/httpd.conf ]; then sedit /etc/httpd/conf/httpd.conf
	elif [ -f /etc/apache2/apache2.conf ]; then sedit /etc/apache2/apache2.conf
	else
		echo "Error: Apache config file could not be found."
		sudo updatedb && locate httpd.conf && locate apache2.conf
	fi
}

phpconfig() {
	if [ -f /etc/php.ini ]; then sedit /etc/php.ini
	elif [ -f /etc/php/php.ini ]; then sedit /etc/php/php.ini
	elif [ -f /etc/php5/php.ini ]; then sedit /etc/php5/php.ini
	elif [ -f /usr/bin/php5/bin/php.ini ]; then sedit /usr/bin/php5/bin/php.ini
	elif [ -f /etc/php5/apache2/php.ini ]; then sedit /etc/php5/apache2/php.ini
	else
		echo "Error: php.ini file could not be found."
		sudo updatedb && locate php.ini
	fi
}

mysqlconfig() {
	if [ -f /etc/my.cnf ]; then sedit /etc/my.cnf
	elif [ -f /etc/mysql/my.cnf ]; then sedit /etc/mysql/my.cnf
	elif [ -f /usr/local/etc/my.cnf ]; then sedit /usr/local/etc/my.cnf
	elif [ -f /usr/bin/mysql/my.cnf ]; then sedit /usr/bin/mysql/my.cnf
	elif [ -f ~/my.cnf ]; then sedit ~/my.cnf
	elif [ -f ~/.my.cnf ]; then sedit ~/.my.cnf
	else
		echo "Error: my.cnf file could not be found."
		sudo updatedb && locate my.cnf
	fi
}


gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
	git push
}

function hb {
    if [ $# -eq 0 ]; then
        echo "No file path specified."
        return
    elif [ ! -f "$1" ]; then
        echo "File path does not exist."
        return
    fi
    uri="http://bin.christitus.com/documents"
    if response=$(curl -s -X POST -d @"$1" "$uri"); then
        hasteKey=$(echo "$response" | jq -r '.key')
        echo "http://bin.christitus.com/$hasteKey"
    else
        echo "Failed to upload the document."
    fi
}

# ===========================================================================
# SUPREME FUNCTIONS (Advanced Workflows)
# ===========================================================================

# Git Show with FZF
fshow() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --multi --header 'Git Log (Enter to show, Tab to multi-select)' \
    --preview "git show --color=always \$(echo {} | grep -o '[a-f0-9]\{7,40\}' | head -n 1)" \
    --bind "enter:execute(git show --color=always \$(echo {} | grep -o '[a-f0-9]\{7,40\}' | head -n 1) | less -R)"
}

# Advanced GeoIP lookup
ipinfo() {
    curl -s "https://ipapi.co/${1:-}/json/" | jq . 2>/dev/null || curl -s "https://ipapi.co/${1:-}/json/"
}

# Upload to transfer.sh
transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguments specified."
        return 1
    fi
    local file=$1
    local filename; filename=$(basename "$file")
    curl --progress-bar --upload-file "$file" "https://transfer.sh/$filename"
}

# Simple shell-based speedtest
speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
}

# Create a temporary directory and enter it
tmpdir() {
    local dir; dir=$(mktemp -d)
    cd "$dir"
    echo "Temporary directory: $dir"
}

# Find and Replace in files
fnr() {
    if [ $# -lt 2 ]; then
        echo "Usage: fnr <search_string> <replace_string>"
        return 1
    fi
    grep -rl "$1" . | xargs sed -i "s/$1/$2/g"
}
