# =============================================================================
# All Functions - Manually merged from all sources
# =============================================================================

# Directory & Files
function mkcd --description "Create directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end

function take --description "Create directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end

function extract --description "Extract archive"
    switch (string match -r '\.([^.]+)$' $argv[1])
        case tar.bz2; tar xjf $argv[1]
        case tar.gz; tar xzf $argv[1]
        case bz2; bunzip2 $argv[1]
        case rar; unrar x $argv[1]
        case gz; gunzip $argv[1]
        case tar; tar xf $argv[1]
        case tbz2; tar xjf $argv[1]
        case tgz; tar xzf $argv[1]
        case zip; unzip $argv[1]
        case Z; uncompress $argv[1]
        case 7z; 7z x $argv[1]
        case '*'
            echo "unknown archive: "(string join '' $argv[1])
            return 1
    end
end

function dothealth --description "Run dotfiles health check"
    if test -n "$DOTFILES_DIR"
        bash "$DOTFILES_DIR/bin/health_check.sh"
    end
end

function dotbench --description "Run shell benchmark"
    if test -n "$DOTFILES_DIR"
        bash "$DOTFILES_DIR/bin/benchmark_shell.sh"
    end
end

function dotfix --description "Fix/reinstall dotfiles"
    if test -n "$DOTFILES_DIR"
        sh "$DOTFILES_DIR/install/install.sh"
    end
end

function recent --description "Find recent files"
    find . -type f -mtime -1 -print 2>/dev/null | head -100
end

function jsonfmt --description "Format JSON"
    python3 -m json.tool $argv
end

function timer --description "Time a command"
    set -l start (date +%s)
    eval $argv
    set -l code $status
    set -l end (date +%s)
    echo "elapsed: "(math $end - $start)"s"
    return $code
end

function dotloadfull --description "Load all functions and aliases"
    if test -n "$DOTFILES_DIR"
        source "$DOTFILES_DIR/shells/fish/functions_all.fish"
        source "$DOTFILES_DIR/shells/fish/aliases_all.fish"
    end
end

function dot_sync --description "Sync dotfiles"
    set -l repo_root "$DOTFILES_DIR"
    if test -z "$repo_root" -o ! -d "$repo_root/.git"
        echo "Dotfiles repo not found."
        return 1
    end
    echo "Syncing dotfiles in $repo_root..."
    git -C "$repo_root" fetch --all --prune
    git -C "$repo_root" pull --rebase --autostash || git -C "$repo_root" pull --ff-only
end

function detect_pkg_manager --description "Detect package manager"
    if type -q yay
        echo "yay"
    else if type -q pacman
        echo "pacman"
    else if type -q apt
        echo "apt"
    else if type -q dnf
        echo "dnf"
    else if type -q brew
        echo "brew"
    else
        echo "none"
    end
end

function search --description "Search packages"
    switch (detect_pkg_manager)
        case yay pacman
            pacman -Ss $argv
        case apt
            apt search $argv
        case dnf
            dnf search $argv
        case brew
            brew search $argv
        case '*'
            echo "No supported package manager"
    end
end

# Network
function myip --description "Get public IP"
    curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null
end

function weather --description "Get weather"
    curl -fsSL wttr.in
end

function portcheck --description "Check port usage"
    netstat -tulanp 2>/dev/null | grep $argv[1] || ss -tulanp | grep $argv[1]
end

function pkillf --description "Kill process by name"
    pkill -f $argv[1] 2>/dev/null || killall $argv[1] 2>/dev/null
end

# Docker
function dexec --description "Docker exec into container"
    docker exec -it $argv[1] /bin/bash
end

function dlogs --description "Docker logs follow"
    docker logs -f $argv[1]
end

function dclean --description "Docker system prune"
    docker system prune -af --volumes
end

# K8s
function kexec --description "Kubectl exec into pod"
    kubectl exec -it $argv[1] -- /bin/bash
end

function klogs --description "Kubectl logs follow"
    kubectl logs -f $argv[1]
end

# Git
function glog --description "Git log graph"
    git log --oneline --graph --all -20
end

function gdiff --description "Git diff"
    git diff $argv
end

function gcontrib --description "Git contributors"
    git shortlog -sne
end

# Process
function topcpu --description "Top processes by CPU"
    ps aux --sort=-%cpu | head -20
end

function topmem --description "Top processes by memory"
    ps aux --sort=-%mem | head -20
end

function psgrep --description "Grep processes"
    ps aux | grep -i $argv[1]
end

# Archive
function targz --description "Create tar.gz"
    tar -czf "$argv[1].tar.gz" $argv[1]
end

function tarxz --description "Extract tar.gz"
    tar -xzf $argv[1]
end

# Web
function serve --description "HTTP server"
    python3 -m http.server $argv[1]
end

# Tmux
function ta --description "Tmux attach"
    tmux attach -t $argv[1]
end

function tn --description "Tmux new session"
    tmux new-session -s $argv[1]
end

function tl --description "Tmux list sessions"
    tmux list-sessions
end

# Python
function venv --description "Create Python venv"
    python3 -m venv $argv[1]
end

function pyactivate --description "Activate Python venv"
    source $argv[1]/bin/activate.fish
end

function pipup --description "Upgrade pip"
    python3 -m pip install --upgrade pip
end

# Rust
function ccheck --description "Cargo check"
    cargo check
end

function cbuild --description "Cargo build"
    cargo build --release
end

function crt --description "Cargo run"
    cargo run --release
end

function ctest --description "Cargo test"
    cargo test
end

function cfmt --description "Cargo fmt"
    cargo fmt
end

# Go
function gobuild --description "Go build"
    CGO_ENABLED=0 go build -ldflags="-s -w" -o $argv[1] main.go
end

# System update (cross-distro)
function update --description "Update system packages"
    switch (detect_pkg_manager)
        case yay pacman
            sudo pacman -Syu
        case apt
            sudo apt update; and sudo apt upgrade
        case dnf
            sudo dnf upgrade
        case brew
            brew update; and brew upgrade
        case apk
            apk update; and apk upgrade
        case '*'
            echo "No supported package manager"
    end
end

# Install packages (cross-distro)
function install --description "Install package"
    switch (detect_pkg_manager)
        case yay pacman
            sudo pacman -S $argv
        case apt
            sudo apt install $argv
        case dnf
            sudo dnf install $argv
        case brew
            brew install $argv
        case apk
            apk add $argv
        case '*'
            echo "No supported package manager"
    end
end