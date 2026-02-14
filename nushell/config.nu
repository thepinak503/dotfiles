# Nushell Configuration
# The Ultimate Universal Shell Configuration

# =============================================================================
# CORE SETTINGS
# =============================================================================

# Configure the shell
$env.config = {
    show_banner: false
    table: {
        mode: rounded
        index_mode: always
    }
    history: {
        max_size: 10000
        sync_on_enter: true
        file_format: "plaintext"
    }
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
    }
    edit_mode: emacs
}

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# Dotfiles configuration
$env.DOTFILES_MODE = ($env.DOTFILES_MODE? | default "advanced")
$env.DOTFILES_DIR = ($env.DOTFILES_DIR? | default "~/.dotfiles")

# XDG directories
$env.XDG_DATA_HOME = "~/.local/share"
$env.XDG_CONFIG_HOME = "~/.config"
$env.XDG_STATE_HOME = "~/.local/state"
$env.XDG_CACHE_HOME = "~/.cache"

# Editor
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Locale
$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

# Disable annoying prompts
$env.VIRTUAL_ENV_DISABLE_PROMPT = "1"
$env.HOMEBREW_NO_ANALYTICS = "1"
$env.HOMEBREW_NO_ENV_HINTS = "1"

# =============================================================================
# PATH CONFIGURATION
# =============================================================================

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    "~/.local/bin"
    "~/.cargo/bin"
    "~/.dotnet/tools"
    "~/.npm-global/bin"
    "~/.poetry/bin"
    "~/go/bin"
])

# =============================================================================
# ALIASES
# =============================================================================

# Navigation
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..
alias home = cd ~
alias desk = cd ~/Desktop
alias docs = cd ~/Documents
alias dl = cd ~/Downloads

# Listing
alias l = ls -la
alias la = ls -a
alias ll = ls -l
alias lt = ls -laT

# File operations
alias mkdir = mkdir -v
alias cp = cp -i
alias mv = mv -i
alias rm = rm -i

# Editors
alias v = nvim
alias vi = nvim
alias vim = nvim
alias c = clear

# System
alias df = df -h
alias ps = ps auxf

# Git
alias g = git
alias ga = git add
alias gaa = git add --all
alias gc = git commit
alias gcm = git commit -m
alias gco = git checkout
alias gd = git diff
alias gl = git log --oneline --graph --decorate
alias gp = git push
alias gpl = git pull
alias gs = git status -sb

# Docker
alias d = docker
alias dc = docker-compose
alias dps = docker ps
alias di = docker images

# Kubernetes
alias k = kubectl
alias kg = kubectl get
alias kd = kubectl describe
alias kl = kubectl logs

# =============================================================================
# CUSTOM COMMANDS (Functions)
# =============================================================================

# Create directory and cd into it
def mkcd [dir: string] {
    mkdir $dir
    cd $dir
}

# Go up N directories
def up [n: int = 1] {
    let path = ("../" | str repeat $n)
    cd $path
}

# Backup file with timestamp
def bak [file: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let backup = $"($file).bak.($timestamp)"
    cp -a $file $backup
    echo $"Backed up: ($file) → ($backup)"
}

# Show internal and external IP
def myip [] {
    echo "Internal IPs:"
    ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1"
    
    echo "External IP:"
    curl -s -4 https://ifconfig.me
}

# Quick HTTP server
def serve [port: int = 8080] {
    echo $"Serving on http://localhost:($port)"
    python3 -m http.server $port
}

# Git add, commit, push
def lazyg [message: string] {
    git add .
    git commit -m $message
    git push
}

# Generate password
def passgen [length: int = 16] {
    openssl rand -base64 48 | str replace -a -r '[^a-zA-Z0-9!@#$%^&*]' '' | str substring 0..$length
}

# Extract archives
def extract [file: string] {
    match ($file | path parse).extension {
        "tar.bz2" | "tbz2" => { tar -xjf $file }
        "tar.gz" | "tgz" => { tar -xzf $file }
        "tar.xz" | "txz" => { tar -xJf $file }
        "tar" => { tar -xf $file }
        "bz2" => { bunzip2 $file }
        "gz" => { gunzip $file }
        "zip" => { unzip $file }
        "rar" => { unrar x $file }
        "7z" => { 7z x $file }
        _ => { echo "Unknown archive format: $file" }
    }
}

# Weather
def weather [location?: string] {
    let loc = ($location | default "")
    curl -s $"wttr.in/($loc)?format=v2"
}

# Calculate
def calc [expression: string] {
    if (which bc | is-empty) {
        python3 -c $"print($expression)"
    } else {
        echo $"scale=4; ($expression)" | bc -l
    }
}

# =============================================================================
# MODERN TOOLS INTEGRATION
# =============================================================================

# Starship prompt
if (which starship | is-not-empty) {
    use ($nu.default-config-dir | path join starship.nu) *
}

# Zoxide
def --env __zoxide_z [...rest: string] {
    let path = if ($rest | is-empty) {
        $env.HOME
    } else if ($rest | length) > 1 {
        $rest | str join " "
    } else if ($rest.0 == "-") {
        "-"
    } else {
        let arg0 = ($rest | first)
        if ($arg0 | path type) == "dir" {
            $arg0
        } else {
            (zoxide query -- $arg0)
        }
    }
    cd $path
}

def --env __zoxide_zi [...rest: string] {
    cd (zoxide query --interactive -- ...$rest)
}

alias z = __zoxide_z
alias zi = __zoxide_zi

# =============================================================================
# WELCOME MESSAGE (DISABLED)
# =============================================================================
# Welcome message removed for cleaner startup

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================
# Load local config if it exists
if ($"($nu.default-config-dir)/config.local.nu" | path exists) {
    source config.local.nu
}
