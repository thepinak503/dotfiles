#!/usr/bin/env bash
# =============================================================================
# 01-FUNCTIONS.SH - Utility Functions Library
# Applies to: advanced, ultra-nerd modes
# =============================================================================

# =============================================================================
# FILE & DIRECTORY OPERATIONS
# =============================================================================

# Create directory and enter it
mkcd() {
    [[ -z "$1" ]] && { echo "Usage: mkcd <directory>"; return 1; }
    mkdir -p "$1" && cd "$1" || return 1
}

# Copy and change to destination directory
cpg() {
    [[ $# -lt 2 ]] && { echo "Usage: cpg <source> <destination>"; return 1; }
    local src="$1"
    local dst="$2"
    
    if [[ -d "$dst" ]]; then
        cp "$src" "$dst" && cd "$dst"
    else
        cp "$src" "$dst"
    fi
}

# Move and change to destination directory
mvg() {
    [[ $# -lt 2 ]] && { echo "Usage: mvg <source> <destination>"; return 1; }
    local src="$1"
    local dst="$2"
    
    if [[ -d "$dst" ]]; then
        mv "$src" "$dst" && cd "$dst"
    else
        mv "$src" "$dst"
    fi
}

# Go up N directories
up() {
    local count="${1:-1}"
    local path=""
    
    for ((i=0; i<count; i++)); do
        path="$path../"
    done
    
    cd "$path" || return 1
}

# Backup file with timestamp
bak() {
    [[ -z "$1" ]] && { echo "Usage: bak <file>"; return 1; }
    [[ ! -e "$1" ]] && { echo "Error: '$1' does not exist"; return 1; }
    
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local backup="${1}.bak.${timestamp}"
    
    cp -a "$1" "$backup"
    echo "Backed up: $1 → $backup"
}

# Swap two files
swap() {
    [[ $# -ne 2 ]] && { echo "Usage: swap <file1> <file2>"; return 1; }
    
    local tmp="$(mktemp)"
    mv "$1" "$tmp"
    mv "$2" "$1"
    mv "$tmp" "$2"
    
    echo "Swapped: $1 ↔ $2"
}

# Create a file with all parent directories
touchp() {
    [[ -z "$1" ]] && { echo "Usage: touchp <path>"; return 1; }
    
    local file="$1"
    local dir
    dir=$(dirname "$file")
    
    [[ ! -d "$dir" ]] && mkdir -p "$dir"
    touch "$file"
}

# Find and remove empty directories
cleanup_empty_dirs() {
    local dir="${1:-.}"
    echo "Finding empty directories in: $dir"
    find "$dir" -type d -empty -delete -print
}

# =============================================================================
# ARCHIVE EXTRACTION (Universal)
# =============================================================================

extract() {
    [[ -z "$1" ]] && { echo "Usage: extract <archive>"; return 1; }
    [[ ! -f "$1" ]] && { echo "Error: '$1' is not a file"; return 1; }
    
    local file="$1"
    local dest="${2:-.}"
    
    case "$file" in
        *.tar.bz2|*.tbz2)  tar -xjf "$file" -C "$dest" ;;
        *.tar.gz|*.tgz)    tar -xzf "$file" -C "$dest" ;;
        *.tar.xz|*.txz)    tar -xJf "$file" -C "$dest" ;;
        *.tar.zst)         tar --zstd -xf "$file" -C "$dest" ;;
        *.tar)             tar -xf "$file" -C "$dest" ;;
        *.bz2)             bunzip2 "$file" ;;
        *.gz)              gunzip "$file" ;;
        *.zip)             unzip "$file" -d "$dest" ;;
        *.rar)             unrar x "$file" "$dest" ;;
        *.7z)              7z x "$file" -o"$dest" ;;
        *.Z)               uncompress "$file" ;;
        *.xz)              xz -d "$file" ;;
        *.lzma)            lzma -d "$file" ;;
        *.zst)             zstd -d "$file" ;;
        *.deb)             dpkg-deb -x "$file" "$dest" ;;
        *.rpm)             rpm2cpio "$file" | cpio -idmv -D "$dest" ;;
        *)                 echo "Unknown archive format: $file"; return 1 ;;
    esac
}

# Create archive from files
compress() {
    [[ $# -lt 2 ]] && { echo "Usage: compress <archive-name> <files...>"; return 1; }
    
    local archive="$1"
    shift
    
    case "$archive" in
        *.tar.bz2) tar -cjf "$archive" "$@" ;;
        *.tar.gz)  tar -czf "$archive" "$@" ;;
        *.tar.xz)  tar -cJf "$archive" "$@" ;;
        *.tar.zst) tar --zstd -cf "$archive" "$@" ;;
        *.tar)     tar -cf "$archive" "$@" ;;
        *.zip)     zip -r "$archive" "$@" ;;
        *.7z)      7z a "$archive" "$@" ;;
        *)         echo "Unknown archive format: $archive"; return 1 ;;
    esac
}

# =============================================================================
# SEARCH & FIND
# =============================================================================

# Fuzzy text search in files
ftext() {
    [[ -z "$1" ]] && { echo "Usage: ftext <pattern> [directory]"; return 1; }
    
    local pattern="$1"
    local dir="${2:-.}"
    
    if command -v rg &>/dev/null; then
        rg -i --color=always "$pattern" "$dir"
    elif command -v ugrep &>/dev/null; then
        ugrep -i --color=always "$pattern" "$dir"
    else
        grep -ri --color=always "$pattern" "$dir" 2>/dev/null
    fi
}

# Find file by name
ff() {
    [[ -z "$1" ]] && { echo "Usage: ff <filename> [directory]"; return 1; }
    
    local name="$1"
    local dir="${2:-.}"
    
    if command -v fd &>/dev/null; then
        fd "$name" "$dir"
    else
        find "$dir" -type f -iname "*$name*" 2>/dev/null
    fi
}

# Find directory by name
fd() {
    [[ -z "$1" ]] && { echo "Usage: fd <dirname> [directory]"; return 1; }
    
    local name="$1"
    local dir="${2:-.}"
    
    if command -v fd &>/dev/null; then
        command fd -t d "$name" "$dir"
    else
        find "$dir" -type d -iname "*$name*" 2>/dev/null
    fi
}

# Find and execute command
fexec() {
    [[ $# -lt 2 ]] && { echo "Usage: fexec <pattern> <command> [args...]"; return 1; }
    
    local pattern="$1"
    shift
    local cmd="$1"
    shift
    
    find . -name "$pattern" -exec "$cmd" {} + "$@"
}

# =============================================================================
# NETWORK & SYSTEM
# =============================================================================

# Display internal and external IP
myip() {
    echo "Internal IPs:"
    command -v ip &>/dev/null && ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1" | sed 's/^/  /'
    
    echo "External IP:"
    curl -s -4 https://ifconfig.me 2>/dev/null | sed 's/^/  /'
}

# Port scanning helper
ports() {
    local host="${1:-localhost}"
    local start="${2:-1}"
    local end="${3:-1000}"
    
    echo "Scanning $host ports $start-$end..."
    
    if command -v nmap &>/dev/null; then
        nmap -p "$start-$end" "$host"
    else
        for port in $(seq "$start" "$end"); do
            (echo >/dev/tcp/"$host"/"$port") 2>/dev/null && echo "Port $port: OPEN"
        done
    fi
}

# Quick HTTP server
serve() {
    local port="${1:-8080}"
    local dir="${2:-.}"
    
    echo "Serving $dir on http://localhost:$port"
    
    if command -v python3 &>/dev/null; then
        python3 -m http.server "$port" --directory "$dir"
    elif command -v python &>/dev/null; then
        cd "$dir" && python -m SimpleHTTPServer "$port"
    elif command -v php &>/dev/null; then
        php -S "localhost:$port" -t "$dir"
    else
        echo "No suitable server found (python3, python, or php)"
        return 1
    fi
}

# Download with progress
dl() {
    [[ -z "$1" ]] && { echo "Usage: dl <url> [output]"; return 1; }
    
    local url="$1"
    local output="${2:-$(basename "$url")}"
    
    if command -v curl &>/dev/null; then
        curl -L --progress-bar -o "$output" "$url"
    elif command -v wget &>/dev/null; then
        wget --progress=bar:force -O "$output" "$url"
    else
        echo "Neither curl nor wget found"
        return 1
    fi
}

# Check SSL certificate
sslcheck() {
    [[ -z "$1" ]] && { echo "Usage: sslcheck <hostname> [port]"; return 1; }
    
    local host="$1"
    local port="${2:-443}"
    
    echo | openssl s_client -servername "$host" -connect "$host:$port" 2>/dev/null | openssl x509 -noout -dates -subject -issuer
}

# =============================================================================
# PROCESS MANAGEMENT
# =============================================================================

# Find process by name
psgrep() {
    [[ -z "$1" ]] && { echo "Usage: psgrep <pattern>"; return 1; }
    ps aux | grep -i "$1" | grep -v grep
}

# Kill process by name
killp() {
    [[ -z "$1" ]] && { echo "Usage: killp <pattern> [-9]"; return 1; }
    
    local pattern="$1"
    local signal="${2:--TERM}"
    
    pgrep -f "$pattern" | xargs -r kill "$signal"
}

# Show top processes by memory
memhogs() {
    local count="${1:-10}"
    ps aux --sort=-%mem | head -n "$((count + 1))" | tail -n "$count"
}

# Show top processes by CPU
cpuhogs() {
    local count="${1:-10}"
    ps aux --sort=-%cpu | head -n "$((count + 1))" | tail -n "$count"
}

# =============================================================================
# DEVELOPMENT HELPERS
# =============================================================================

# Git add, commit, push in one command
lazyg() {
    [[ -z "$1" ]] && { echo "Usage: lazyg <commit-message>"; return 1; }
    
    git add . && git commit -m "$1" && git push
}

# Create new git repository and push to origin
gitsetup() {
    [[ ! -d .git ]] && git init
    
    [[ -z "$1" ]] && { echo "Usage: gitsetup <remote-url>"; return 1; }
    
    git remote add origin "$1" 2>/dev/null || git remote set-url origin "$1"
    
    [[ ! -f .gitignore ]] && curl -sL https://www.toptal.com/developers/gitignore/api/linux,macos,windows,visualstudiocode,intellij+all,vim,emacs -o .gitignore
    
    git add .
    git commit -m "Initial commit"
    git push -u origin HEAD
}

# Docker cleanup
docker_clean() {
    echo "Removing stopped containers..."
    docker container prune -f
    
    echo "Removing unused images..."
    docker image prune -f
    
    echo "Removing unused volumes..."
    docker volume prune -f
    
    echo "Removing unused networks..."
    docker network prune -f
    
    echo "Docker cleanup complete!"
}

# =============================================================================
# DATA CONVERSION
# =============================================================================

# JSON pretty print
json() {
    [[ -z "$1" ]] && { echo "Usage: json <file-or-string>"; return 1; }
    
    if [[ -f "$1" ]]; then
        cat "$1" | python3 -m json.tool 2>/dev/null || python -m json.tool 2>/dev/null
    else
        echo "$1" | python3 -m json.tool 2>/dev/null || python -m json.tool 2>/dev/null
    fi
}

# Base64 encode/decode
b64() {
    [[ -z "$1" ]] && { echo "Usage: b64 <string> (or pipe input)"; return 1; }
    
    if [[ "$1" == "-d" ]]; then
        shift
        echo -n "$*" | base64 -d
    else
        echo -n "$*" | base64
    fi
}

# URL encode/decode
urlencode() {
    [[ -z "$1" ]] && { echo "Usage: urlencode <string>"; return 1; }
    
    local string="$1"
    local encoded=""
    local pos c o
    
    for (( pos=0; pos<${#string}; pos++ )); do
        c=${string:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9]) encoded+="$c" ;;
            *) encoded+=$(printf '%%%02X' "'$c") ;;
        esac
    done
    
    echo "$encoded"
}

urldecode() {
    [[ -z "$1" ]] && { echo "Usage: urldecode <string>"; return 1; }
    printf '%b\n' "${1//%/\\x}"
}

# =============================================================================
# UTILITY
# =============================================================================

# Generate random password
passgen() {
    local length="${1:-16}"
    local count="${2:-1}"
    
    for ((i=0; i<count; i++)); do
        openssl rand -base64 48 | tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c "$length"
        echo
    done
}

# Calculate expression
calc() {
    [[ -z "$1" ]] && { echo "Usage: calc <expression>"; return 1; }
    
    if command -v bc &>/dev/null; then
        echo "scale=4; $*" | bc -l
    else
        python3 -c "print($*)" 2>/dev/null || python -c "print($*)"
    fi
}

# Weather in terminal
weather() {
    local location="${1:-}"
    curl -s "wttr.in/${location}?format=v2"
}

# Dictionary lookup
define() {
    [[ -z "$1" ]] && { echo "Usage: define <word>"; return 1; }
    curl -s "dict://dict.org/d:$1" 2>/dev/null || echo "Could not reach dictionary server"
}

# QR code generator
qr() {
    [[ -z "$1" ]] && { echo "Usage: qr <text>"; return 1; }
    curl -s "qrenco.de/$1"
}
