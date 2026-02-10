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
    [[ -z "$1" ]] && { echo "Usage: mkcd <directory>" >&2; return 1; }
    [[ "$1" =~ ^/ ]] || { echo "Error: Absolute path required" >&2; return 1; }
    [[ "$1" =~ \.\./ ]] && { echo "Error: Path traversal detected" >&2; return 1; }
    mkdir -p "$1" && cd "$1" || { echo "Error: Failed to create/enter directory" >&2; return 1; }
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
    [[ $# -ne 2 ]] && { echo "Usage: swap <file1> <file2>" >&2; return 1; }
    [[ ! -e "$1" ]] && { echo "Error: '$1' does not exist" >&2; return 1; }
    [[ ! -e "$2" ]] && { echo "Error: '$2' does not exist" >&2; return 1; }
    [[ "$1" == "$2" ]] && { echo "Error: Cannot swap file with itself" >&2; return 1; }
    
    local tmp
    tmp="$(mktemp)" || { echo "Error: Failed to create temp file" >&2; return 1; }
    
    if ! mv "$1" "$tmp"; then
        echo "Error: Failed to move '$1'" >&2
        rm -f "$tmp"
        return 1
    fi
    
    if ! mv "$2" "$1"; then
        echo "Error: Failed to move '$2' to '$1'" >&2
        mv "$tmp" "$1"  # Attempt to restore
        return 1
    fi
    
    if ! mv "$tmp" "$2"; then
        echo "Error: Failed to complete swap" >&2
        return 1
    fi
    
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
    [[ -z "$1" ]] && { echo "Usage: extract <archive> [destination]" >&2; return 1; }
    [[ ! -e "$1" ]] && { echo "Error: '$1' does not exist" >&2; return 1; }
    [[ -d "$1" ]] && { echo "Error: '$1' is a directory, not an archive" >&2; return 1; }
    [[ "$1" =~ \.\./ ]] && { echo "Error: Path traversal detected" >&2; return 1; }
    
    local file
    file="$(realpath "$1")" || { echo "Error: Cannot resolve path '$1'" >&2; return 1; }
    
    local dest="${2:-.}"
    if [[ "$dest" != "." ]]; then
        [[ "$dest" =~ \.\./ ]] && { echo "Error: Path traversal in destination" >&2; return 1; }
        [[ -d "$dest" ]] || mkdir -p "$dest" || { echo "Error: Cannot create destination directory" >&2; return 1; }
    fi
    
    case "$file" in
        *.tar.bz2|*.tbz2)  [[ -r "$file" ]] && tar -xjf "$file" -C "$dest" || { echo "Error: Failed to extract tar.bz2" >&2; return 1; } ;;
        *.tar.gz|*.tgz)    [[ -r "$file" ]] && tar -xzf "$file" -C "$dest" || { echo "Error: Failed to extract tar.gz" >&2; return 1; } ;;
        *.tar.xz|*.txz)    [[ -r "$file" ]] && tar -xJf "$file" -C "$dest" || { echo "Error: Failed to extract tar.xz" >&2; return 1; } ;;
        *.tar.zst)         [[ -r "$file" ]] && tar --zstd -xf "$file" -C "$dest" || { echo "Error: Failed to extract tar.zst" >&2; return 1; } ;;
        *.tar)             [[ -r "$file" ]] && tar -xf "$file" -C "$dest" || { echo "Error: Failed to extract tar" >&2; return 1; } ;;
        *.bz2)             [[ -r "$file" ]] && bunzip2 "$file" || { echo "Error: Failed to decompress bz2" >&2; return 1; } ;;
        *.gz)              [[ -r "$file" ]] && gunzip "$file" || { echo "Error: Failed to decompress gz" >&2; return 1; } ;;
        *.zip)             [[ -r "$file" ]] && unzip "$file" -d "$dest" || { echo "Error: Failed to extract zip" >&2; return 1; } ;;
        *.rar)             [[ -r "$file" ]] && unrar x "$file" "$dest" || { echo "Error: Failed to extract rar" >&2; return 1; } ;;
        *.7z)              [[ -r "$file" ]] && 7z x "$file" -o"$dest" || { echo "Error: Failed to extract 7z" >&2; return 1; } ;;
        *.Z)               [[ -r "$file" ]] && uncompress "$file" || { echo "Error: Failed to uncompress" >&2; return 1; } ;;
        *.xz)              [[ -r "$file" ]] && xz -d "$file" || { echo "Error: Failed to decompress xz" >&2; return 1; } ;;
        *.lzma)            [[ -r "$file" ]] && lzma -d "$file" || { echo "Error: Failed to decompress lzma" >&2; return 1; } ;;
        *.zst)             [[ -r "$file" ]] && zstd -d "$file" || { echo "Error: Failed to decompress zst" >&2; return 1; } ;;
        *.deb)             [[ -r "$file" ]] && dpkg-deb -x "$file" "$dest" || { echo "Error: Failed to extract deb" >&2; return 1; } ;;
        *.rpm)             [[ -r "$file" ]] && rpm2cpio "$file" | cpio -idmv -D "$dest" || { echo "Error: Failed to extract rpm" >&2; return 1; } ;;
        *)                 echo "Error: Unknown archive format: $file" >&2; return 1 ;;
    esac
    
    echo "Extracted: $file"
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

# =============================================================================
# DOTFILES MANAGEMENT FUNCTIONS
# =============================================================================

# Comprehensive health check for dotfiles
dotfiles-doctor() {
    local ret=0
    
    echo "═══════════════════════════════════════════════════════════════"
    echo "                    DOTFILES HEALTH CHECK"
    echo "═══════════════════════════════════════════════════════════════"
    echo ""
    
    # Basic info
    echo "📋 Configuration"
    echo "  Mode: ${DOTFILES_MODE:-advanced}"
    echo "  Directory: ${DOTFILES_DIR:-$HOME/.dotfiles}"
    echo "  Version: ${DOTFILES_VERSION:-unknown}"
    echo ""
    
    # Shell info
    echo "🐚 Shell Environment"
    echo "  Current: $SHELL"
    echo "  Interactive: $([[ $- == *i* ]] && echo "yes" || echo "no")"
    echo "  Terminal: $([[ -t 1 ]] && echo "yes" || echo "no")"
    echo ""
    
    # Check symlinks
    echo "🔗 Symlinks"
    local broken_links
    broken_links=$(find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null | wc -l)
    if [[ "$broken_links" -eq 0 ]]; then
        echo "  ✓ No broken symlinks found"
    else
        echo "  ✗ Found $broken_links broken symlink(s)"
        find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null | sed 's/^/    /'
        ret=1
    fi
    echo ""
    
    # Check critical files
    echo "📁 Critical Files"
    local critical_files=(
        "${DOTFILES_DIR:-$HOME/.dotfiles}/.bashrc"
        "${DOTFILES_DIR:-$HOME/.dotfiles}/bash/00-core.sh"
        "${DOTFILES_DIR:-$HOME/.dotfiles}/bash/01-functions.sh"
    )
    for file in "${critical_files[@]}"; do
        if [[ -f "$file" ]]; then
            echo "  ✓ $(basename "$file")"
        else
            echo "  ✗ $(basename "$file") MISSING"
            ret=1
        fi
    done
    echo ""
    
    # Check required tools
    echo "🛠️  Required Tools"
    local required_tools=(git curl wget fzf zoxide)
    for tool in "${required_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            local version
            version=$("$tool" --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
            echo "  ✓ $tool ${version:+v$version}"
        else
            echo "  ✗ $tool (optional)"
        fi
    done
    echo ""
    
    # Check modern tools
    echo "⚡ Modern Tools"
    local modern_tools=(eza bat ripgrep fd starship btop)
    for tool in "${modern_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            echo "  ✓ $tool"
        else
            echo "  ⚠ $tool (recommended)"
        fi
    done
    echo ""
    
    # Check shell startup time
    echo "⏱️  Shell Startup Time"
    if command -v bash &>/dev/null; then
        local bash_time
        bash_time=$(bash -i -c 'exit' 2>&1 | tail -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
        [[ -n "$bash_time" ]] && echo "  Bash: ${bash_time}s"
    fi
    if command -v zsh &>/dev/null; then
        local zsh_time
        zsh_time=$(zsh -i -c 'exit' 2>&1 | tail -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
        [[ -n "$zsh_time" ]] && echo "  Zsh: ${zsh_time}s"
    fi
    echo ""
    
    # Check version managers (lazy loaded)
    echo "📦 Version Managers (Lazy Loaded)"
    local vms_checked=0
    [[ -d "$HOME/.nvm" ]] && { echo "  ✓ NVM detected"; ((vms_checked++)); }
    [[ -d "$HOME/.pyenv" ]] && { echo "  ✓ Pyenv detected"; ((vms_checked++)); }
    [[ -d "$HOME/.rbenv" ]] && { echo "  ✓ Rbenv detected"; ((vms_checked++)); }
    [[ -d "$HOME/.cargo" ]] && { echo "  ✓ Rust/Cargo detected"; ((vms_checked++)); }
    [[ $vms_checked -eq 0 ]] && echo "  ℹ None detected (optional)"
    echo ""
    
    # Check PATH
    echo "🛤️  PATH (${#PATH} characters, $(echo "$PATH" | tr ':' '\n' | wc -l) entries)"
    echo "  First entry: $(echo "$PATH" | cut -d':' -f1)"
    echo "  Last entry: $(echo "$PATH" | tr ':' '\n' | tail -1)"
    echo ""
    
    # Summary
    echo "═══════════════════════════════════════════════════════════════"
    if [[ $ret -eq 0 ]]; then
        echo "                    ✅ ALL CHECKS PASSED"
    else
        echo "                    ⚠️  ISSUES DETECTED"
    fi
    echo "═══════════════════════════════════════════════════════════════"
    
    return $ret
}

# Reload dotfiles configuration
dotfiles-reload() {
    local shell_rc=""
    
    case "${SHELL##*/}" in
        bash) shell_rc="$HOME/.bashrc" ;;
        zsh)  shell_rc="$HOME/.zshrc" ;;
        fish) shell_rc="$HOME/.config/fish/config.fish" ;;
        *)    echo "Unknown shell: $SHELL" >&2; return 1 ;;
    esac
    
    if [[ -f "$shell_rc" ]]; then
        echo "Reloading $shell_rc..."
        source "$shell_rc"
        echo "✓ Dotfiles reloaded!"
    else
        echo "Error: $shell_rc not found" >&2
        return 1
    fi
}

# Show dotfiles configuration
dotfiles-config() {
    cat << EOF
═══════════════════════════════════════════════════════════════
                    DOTFILES CONFIGURATION
═══════════════════════════════════════════════════════════════

Mode: ${DOTFILES_MODE:-advanced}
Directory: ${DOTFILES_DIR:-$HOME/.dotfiles}
Version: ${DOTFILES_VERSION:-2.0.0}

Environment:
  EDITOR: $EDITOR
  VISUAL: $VISUAL
  SHELL: $SHELL
  TERM: $TERM

PATH:
$(echo "$PATH" | tr ':' '\n' | nl -w2 -s'. ')

Aliases loaded: $(alias | wc -l)
Functions loaded: $(declare -f | grep -E "^[a-z].*\(\)" | wc -l)

═══════════════════════════════════════════════════════════════
EOF
}

# Profile shell startup time
dotfiles-profile() {
    local iterations="${1:-3}"
    local shell="${2:-bash}"
    
    echo "Profiling $shell startup time ($iterations iterations)..."
    echo ""
    
    local total=0
    for ((i=1; i<=iterations; i++)); do
        local start end elapsed
        start=$(date +%s%N)
        $shell -i -c 'exit' 2>/dev/null
        end=$(date +%s%N)
        elapsed=$(( (end - start) / 1000000 ))  # Convert to milliseconds
        total=$((total + elapsed))
        echo "  Run $i: ${elapsed}ms"
    done
    
    local avg=$((total / iterations))
    echo ""
    echo "Average: ${avg}ms"
    
    if [[ $avg -lt 100 ]]; then
        echo "✓ Excellent startup time"
    elif [[ $avg -lt 300 ]]; then
        echo "✓ Good startup time"
    elif [[ $avg -lt 500 ]]; then
        echo "⚠ Acceptable startup time"
    else
        echo "✗ Slow startup time - consider optimizations"
    fi
}

# =============================================================================
# SAFE FILE OPERATIONS
# =============================================================================

# Safe remove with protection for critical paths
_safe_rm() {
    # List of protected paths (absolute paths only)
    local protected_paths=(
        "/" "/bin" "/boot" "/dev" "/etc" "/home" "/lib" "/lib64"
        "/proc" "/root" "/run" "/sbin" "/sys" "/usr" "/var"
        "/nix" "/opt" "/srv" "/tmp" "/mnt" "/media"
    )
    
    # Check each argument
    for target in "$@"; do
        # Skip options
        [[ "$target" == -* ]] && continue
        
        # Get absolute path
        local abs_path
        if [[ -e "$target" ]]; then
            abs_path=$(realpath "$target" 2>/dev/null || echo "$target")
        else
            abs_path="$target"
        fi
        
        # Check against protected paths
        for protected in "${protected_paths[@]}"; do
            if [[ "$abs_path" == "$protected" ]] || [[ "$abs_path" == "$protected/"* ]]; then
                echo "ERROR: Refusing to delete protected path: $target" >&2
                echo "       (matches protected: $protected)" >&2
                return 1
            fi
        done
        
        # Check for dangerous patterns
        if [[ "$target" == "/" ]] || [[ "$target" == "/*" && "$target" != *[![:space:]]* ]]; then
            echo "ERROR: Dangerous path pattern detected: '$target'" >&2
            return 1
        fi
    done
    
    # Use trash-cli if available, otherwise use rm -i
    if command -v trash &>/dev/null; then
        command trash "$@"
    else
        command rm -i "$@"
    fi
}

# Export the safe rm function for use as alias
export -f _safe_rm
