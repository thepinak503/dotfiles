#!/usr/bin/env bash
# =============================================================================
# DYNAMIC DOTFILES MODULE DETECTION SYSTEM
# Automatically detects installed tools and enables relevant features
# =============================================================================

# Global arrays to store detected modules
declare -A DETECTED_TOOLS
declare -A AVAILABLE_FEATURES

# Colors for output
declare -A COLORS=(
    ["green"]='\033[0;32m'
    ["blue"]='\033[0;34m'
    ["yellow"]='\033[1;33m'
    ["red"]='\033[0;31m'
    ["cyan"]='\033[0;36m'
    ["purple"]='\033[0;35m'
    ["white"]='\033[1;37m'
    ["reset"]='\033[0m'
)

# =============================================================================
# CORE DETECTION FUNCTIONS
# =============================================================================

detect_command() {
    local cmd="$1"
    local feature="$2"
    local description="$3"
    local priority="${4:-medium}"
    
    if command -v "$cmd" &>/dev/null; then
        DETECTED_TOOLS["$cmd"]="$description"
        AVAILABLE_FEATURES["$feature"]="$priority"
        return 0
    fi
    return 1
}

detect_file() {
    local file="$1"
    local feature="$2"
    local description="$3"
    local priority="${4:-medium}"
    
    if [[ -f "$file" ]]; then
        DETECTED_TOOLS["$file"]="$description"
        AVAILABLE_FEATURES["$feature"]="$priority"
        return 0
    fi
    return 1
}

detect_directory() {
    local dir="$1"
    local feature="$2"
    local description="$3"
    local priority="${4:-medium}"
    
    if [[ -d "$dir" ]]; then
        DETECTED_TOOLS["$dir"]="$description"
        AVAILABLE_FEATURES["$feature"]="$priority"
        return 0
    fi
    return 1
}

# =============================================================================
# COMPREHENSIVE MODULE DETECTION
# =============================================================================

detect_core_tools() {
    echo -e "${COLORS[blue]}🔍 Detecting core tools...${COLORS[reset]}"
    
    # Basic shell tools
    detect_command "git" "git" "Git version control" "high"
    detect_command "curl" "curl" "HTTP client" "high"
    detect_command "wget" "wget" "Download tool" "medium"
    detect_command "ssh" "ssh" "SSH client" "high"
    detect_command "rsync" "rsync" "Sync tool" "medium"
    
    # System monitoring
    detect_command "htop" "htop" "Process monitor" "medium"
    detect_command "btop" "btop" "Advanced process monitor" "medium"
    detect_command "neofetch" "neofetch" "System info" "low"
    detect_command "fastfetch" "fastfetch" "System info" "low"
    detect_command "screenfetch" "screenfetch" "System info" "low"
    
    # File management
    detect_command "tree" "tree" "Directory tree" "medium"
    detect_command "fd" "fd-find" "File finder" "high"
    detect_command "ripgrep" "ripgrep" "Fast search" "high"
    detect_command "fzf" "fzf" "Fuzzy finder" "high"
    
    # Modern replacements
    detect_command "eza" "eza" "Modern ls" "high"
    detect_command "exa" "exa" "Modern ls" "high"
    detect_command "bat" "bat" "Modern cat" "high"
    detect_command "batcat" "batcat" "Modern cat" "high"
    detect_command "dust" "dust" "Modern du" "medium"
    detect_command "duf" "duf" "Modern df" "medium"
    
    # Navigation
    detect_command "zoxide" "zoxide" "Smart navigation" "high"
    detect_command "autojump" "autojump" "Smart navigation" "medium"
}

detect_development_tools() {
    echo -e "${COLORS[blue]}🔍 Detecting development tools...${COLORS[reset]}"
    
    # Languages
    detect_command "node" "nodejs" "Node.js" "medium"
    detect_command "npm" "npm" "Node.js package manager" "medium"
    detect_command "yarn" "yarn" "Package manager" "medium"
    detect_command "pnpm" "pnpm" "Package manager" "medium"
    
    detect_command "python" "python" "Python" "medium"
    detect_command "python3" "python3" "Python 3" "medium"
    detect_command "pip" "pip" "Python package manager" "medium"
    detect_command "pip3" "pip3" "Python package manager" "medium"
    
    detect_command "go" "go" "Go language" "medium"
    detect_command "rustc" "rust" "Rust language" "medium"
    detect_command "cargo" "cargo" "Rust package manager" "medium"
    
    detect_command "java" "java" "Java" "medium"
    detect_command "javac" "java" "Java compiler" "medium"
    detect_command "mvn" "maven" "Maven" "medium"
    detect_command "gradle" "gradle" "Gradle" "medium"
    
    detect_command "ruby" "ruby" "Ruby" "medium"
    detect_command "gem" "gem" "Ruby package manager" "medium"
    
    detect_command "php" "php" "PHP" "medium"
    detect_command "composer" "composer" "PHP package manager" "medium"
    
    # Development tools
    detect_command "docker" "docker" "Docker" "high"
    detect_command "docker-compose" "docker-compose" "Docker Compose" "high"
    detect_command "kubectl" "kubectl" "Kubernetes CLI" "high"
    detect_command "helm" "helm" "Kubernetes Helm" "medium"
    
    detect_command "terraform" "terraform" "Infrastructure as Code" "high"
    detect_command "ansible" "ansible" "Configuration management" "medium"
    detect_command "packer" "packer" "Machine image builder" "medium"
    
    # Editors
    detect_command "vim" "vim" "Vim editor" "high"
    detect_command "nvim" "neovim" "Neovim editor" "high"
    detect_command "emacs" "emacs" "Emacs editor" "medium"
    detect_command "code" "vscode" "Visual Studio Code" "medium"
    detect_command "subl" "sublime" "Sublime Text" "medium"
}

detect_cloud_tools() {
    echo -e "${COLORS[blue]}🔍 Detecting cloud tools...${COLORS[reset]}"
    
    detect_command "aws" "aws-cli" "AWS CLI" "high"
    detect_command "awslocal" "aws-local" "AWS LocalStack" "medium"
    detect_command "gcloud" "gcloud" "Google Cloud CLI" "high"
    detect_command "az" "azure-cli" "Azure CLI" "high"
    detect_command "doctl" "digitalocean" "DigitalOcean CLI" "medium"
    detect_command "heroku" "heroku" "Heroku CLI" "medium"
    
    detect_command "terraform" "terraform" "Terraform" "high"
    detect_command "terragrunt" "terragrunt" "Terragrunt" "medium"
    detect_command "packer" "packer" "Packer" "medium"
}

detect_shell_environments() {
    echo -e "${COLORS[blue]}🔍 Detecting shell environments...${COLORS[reset]}"
    
    detect_command "zsh" "zsh" "Z Shell" "high"
    detect_command "bash" "bash" "Bash Shell" "high"
    detect_command "fish" "fish" "Fish Shell" "medium"
    detect_command "nu" "nushell" "Nushell" "low"
    
    # Shell frameworks
    detect_directory "$HOME/.oh-my-zsh" "oh-my-zsh" "Oh My Zsh" "high"
    detect_file "$HOME/.zprezto/init.zsh" "prezto" "Prezto" "medium"
    detect_directory "$HOME/.config/fish" "fish-config" "Fish configuration" "medium"
    
    # Shell tools
    detect_command "starship" "starship" "Starship prompt" "high"
    detect_command "thefuck" "thefuck" "Command correction" "medium"
    detect_command "autojump" "autojump" "Smart navigation" "medium"
}

detect_package_managers() {
    echo -e "${COLORS[blue]}🔍 Detecting package managers...${COLORS[reset]}"
    
    detect_command "apt" "apt" "APT package manager" "high"
    detect_command "apt-get" "apt" "APT package manager" "high"
    detect_command "dnf" "dnf" "DNF package manager" "high"
    detect_command "yum" "yum" "YUM package manager" "high"
    detect_command "pacman" "pacman" "Pacman package manager" "high"
    detect_command "zypper" "zypper" "Zypper package manager" "medium"
    detect_command "emerge" "portage" "Portage package manager" "medium"
    detect_command "xbps-install" "xbps" "XBPS package manager" "medium"
    detect_command "apk" "apk" "Alpine package manager" "medium"
    
    detect_command "brew" "homebrew" "Homebrew" "high"
    detect_command "flatpak" "flatpak" "Flatpak" "medium"
    detect_command "snap" "snap" "Snap" "medium"
    
    detect_command "pip" "pip" "Python pip" "medium"
    detect_command "conda" "conda" "Conda" "medium"
}

detect_utilities() {
    echo -e "${COLORS[blue]}🔍 Detecting utilities...${COLORS[reset]}"
    
    # Network tools
    detect_command "nmap" "nmap" "Network scanner" "medium"
    detect_command "netcat" "netcat" "Network utility" "medium"
    detect_command "nc" "netcat" "Netcat" "medium"
    detect_command "tcpdump" "tcpdump" "Packet analyzer" "medium"
    detect_command "wireshark" "wireshark" "Network analyzer" "medium"
    detect_command "iftop" "iftop" "Network monitor" "medium"
    
    # Archive tools
    detect_command "zip" "zip" "Zip archive" "medium"
    detect_command "unzip" "unzip" "Zip extractor" "medium"
    detect_command "tar" "tar" "Tar archive" "high"
    detect_command "gzip" "gzip" "Gzip compression" "high"
    detect_command "gunzip" "gunzip" "Gzip extraction" "high"
    
    # System tools
    detect_command "sudo" "sudo" "Superuser do" "high"
    detect_command "cron" "cron" "Task scheduler" "medium"
    detect_command "systemd" "systemd" "System manager" "high"
    
    # Media tools
    detect_command "ffmpeg" "ffmpeg" "Media converter" "low"
    detect_command "imagemagick" "imagemagick" "Image manipulation" "low"
}

# =============================================================================
# DETECTION MAIN FUNCTION
# =============================================================================

detect_all_modules() {
    echo -e "${COLORS[cyan]}🚀 Starting dynamic module detection...${COLORS[reset]}"
    
    # Clear previous detection
    DETECTED_TOOLS=()
    AVAILABLE_FEATURES=()
    
    # Run all detection functions
    detect_core_tools
    detect_development_tools
    detect_cloud_tools
    detect_shell_environments
    detect_package_managers
    detect_utilities
    
    echo -e "${COLORS[green]}✅ Module detection completed!${COLORS[reset]}"
    echo -e "${COLORS[white]}📊 Found ${#DETECTED_TOOLS[@]} tools with ${#AVAILABLE_FEATURES[@]} features${COLORS[reset]}"
}

# =============================================================================
# DYNAMIC ALIAS/FUNCTION GENERATION
# =============================================================================

generate_dynamic_aliases() {
    local shell_type="$1"
    local output_file="$2"
    
    echo -e "${COLORS[yellow]}🔧 Generating dynamic aliases for $shell_type...${COLORS[reset]}"
    
    # Create header
    cat > "$output_file" << EOF
# =============================================================================
# DYNAMICALLY GENERATED ALIASES FOR $shell_type
# Generated on $(date)
# Total detected tools: ${#DETECTED_TOOLS[@]}
# =============================================================================

EOF
    
    # Core tool aliases
    if [[ -n "${AVAILABLE_FEATURES[git]}" ]]; then
        cat >> "$output_file" << 'EOF'
# Git aliases (enhanced)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gr='git remote'
alias gm='git merge'
alias gsh='git stash'
alias glog='git log --oneline --graph'
alias gcl='git clone'
alias gclean='git clean -fd'
EOF
    fi
    
    # Modern tool aliases
    if [[ -n "${AVAILABLE_FEATURES[fzf]}" ]]; then
        cat >> "$output_file" << 'EOF'

# FZF aliases
alias f='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" 2>/dev/null || fzf'
alias fv='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" 2>/dev/null | xargs -r $EDITOR || fzf | xargs -r $EDITOR'
alias fcd='cd $(find . -type d -not -path "*/\.*" | fzf)'
alias fkill='ps aux | fzf --multi | awk "{print \$2}" | xargs -r kill -9'
EOF
    fi
    
    if [[ -n "${AVAILABLE_FEATURES[eza]}" ]] || [[ -n "${AVAILABLE_FEATURES[exa]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Modern ls aliases (eza/exa)
if command -v eza &>/dev/null; then
    alias ls='eza --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
elif command -v exa &>/dev/null; then
    alias ls='exa --group-directories-first --icons'
    alias l='exa -la --group-directories-first --icons'
    alias la='exa -a --group-directories-first --icons'
    alias ll='exa -l --group-directories-first --icons'
    alias lt='exa --tree --level=2 --icons'
fi
EOF
    fi
    
    if [[ -n "${AVAILABLE_FEATURES[bat]}" ]] || [[ -n "${AVAILABLE_FEATURES[batcat]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Modern cat aliases (bat/batcat)
if command -v bat &>/dev/null; then
    alias cat='bat --style=header,grid'
    alias catp='bat --style=plain --paging=never'
elif command -v batcat &>/dev/null; then
    alias cat='batcat --style=header,grid'
    alias catp='batcat --style=plain --paging=never'
fi
EOF
    fi
    
    if [[ -n "${AVAILABLE_FEATURES[ripgrep]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Ripgrep aliases
alias rg='rg --color=always'
alias rgi='rg -i'
alias rgv='rg -v'
alias rgf='rg -F'
alias rgw='rg -w'
EOF
    fi
    
    if [[ -n "${AVAILABLE_FEATURES[fd-find]}" ]]; then
        cat >> "$output_file" << 'EOF'

# fd aliases
alias find='fd'
alias ff='fd --type f'
alias fdir='fd --type d'
alias fhidden='fd --hidden'
EOF
    fi
    
    # Development tool aliases
    if [[ -n "${AVAILABLE_FEATURES[docker]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Docker aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias di='docker images'
alias drun='docker run'
alias dexec='docker exec -it'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -a -q)'
EOF
    fi
    
    if [[ -n "${AVAILABLE_FEATURES[kubectl]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply'
alias kdel='kubectl delete'
alias klogs='kubectl logs'
alias kexec='kubectl exec -it'
alias kctx='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'
EOF
    fi
    
    # Navigation aliases
    if [[ -n "${AVAILABLE_FEATURES[zoxide]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Zoxide aliases
alias z='__zoxide_z'
alias zi='__zoxide_zi'
alias za='zoxide add'
alias zq='zoxide query'
alias zr='zoxide remove'
alias cd='z'
EOF
    fi
    
    # System monitoring aliases
    if [[ -n "${AVAILABLE_FEATURES[btop]}" ]]; then
        cat >> "$output_file" << 'EOF'

# System monitoring aliases
alias top='btop'
alias htop='btop'
EOF
    fi
    
    # Package manager aliases
    if [[ -n "${AVAILABLE_FEATURES[apt]}" ]]; then
        cat >> "$output_file" << 'EOF'

# APT aliases
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias search='apt search'
alias show='apt show'
EOF
    elif [[ -n "${AVAILABLE_FEATURES[pacman]}" ]]; then
        cat >> "$output_file" << 'EOF'

# Pacman aliases
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='pacman -Ss'
alias show='pacman -Si'
EOF
    elif [[ -n "${AVAILABLE_FEATURES[dnf]}" ]]; then
        cat >> "$output_file" << 'EOF'

# DNF aliases
alias update='sudo dnf update'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias search='dnf search'
alias show='dnf info'
EOF
    fi
    
    echo -e "${COLORS[green]}✅ Dynamic aliases generated for $shell_type${COLORS[reset]}"
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

main() {
    local action="${1:-detect}"
    local shell_type="${2:-auto}"
    local output_dir="${3:-/tmp/dotfiles-generated}"
    
    case "$action" in
        "detect")
            detect_all_modules
            ;;
        "generate")
            detect_all_modules
            mkdir -p "$output_dir"
            
            case "$shell_type" in
                "bash")
                    generate_dynamic_aliases "bash" "$output_dir/dynamic-bash.sh"
                    ;;
                "zsh")
                    generate_dynamic_aliases "zsh" "$output_dir/dynamic-zsh.sh"
                    ;;
                "fish")
                    generate_dynamic_aliases "fish" "$output_dir/dynamic-fish.fish"
                    ;;
                "nushell")
                    generate_dynamic_aliases "nushell" "$output_dir/dynamic-nu.nu"
                    ;;
                "all"|"auto")
                    generate_dynamic_aliases "bash" "$output_dir/dynamic-bash.sh"
                    generate_dynamic_aliases "zsh" "$output_dir/dynamic-zsh.sh"
                    generate_dynamic_aliases "fish" "$output_dir/dynamic-fish.fish"
                    generate_dynamic_aliases "nushell" "$output_dir/dynamic-nu.nu"
                    ;;
                *)
                    echo -e "${COLORS[red]}❌ Unknown shell type: $shell_type${COLORS[reset]}"
                    echo "Available: bash, zsh, fish, nushell, all"
                    exit 1
                    ;;
            esac
            ;;
        "report")
            detect_all_modules
            echo -e "${COLORS[cyan]}📋 Detection Report:${COLORS[reset]}"
            echo ""
            echo -e "${COLORS[white]}Detected Tools:${COLORS[reset]}"
            for tool in "${!DETECTED_TOOLS[@]}"; do
                echo "  • $tool: ${DETECTED_TOOLS[$tool]}"
            done
            echo ""
            echo "Available Features:"
            echo "  Feature detection completed"
            ;;
        *)
            echo "Usage: $0 {detect|generate|report} [shell_type] [output_dir]"
            echo ""
            echo "Commands:"
            echo "  detect     - Run module detection only"
            echo "  generate   - Generate dynamic configuration files"
            echo "  report     - Show detection report"
            echo ""
            echo "Shell types: bash, zsh, fish, nushell, all, auto"
            exit 1
            ;;
    esac
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi