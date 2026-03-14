#!/usr/bin/env bash
# =============================================================================
# INSTALL SHELL SUPPORT - Unified Package Installer
# Works in: Bash, Zsh
# Usage: source ~/.dotfiles/scripts/install_shell_support.sh && install_shell_support
#        or: bash ~/.dotfiles/scripts/install_shell_support.sh
# =============================================================================

install_shell_support() {
    local pkg_manager=""
    local os=""
    local arch=""
    
    echo "════════════════════════════════════════════════════════════"
    echo "         SHELL SUPPORT INSTALLER v1.0"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    
    # Detect OS
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        os="$ID"
        OS_NAME="$NAME"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        os="macos"
        OS_NAME="macOS"
    else
        os="unknown"
        OS_NAME="Unknown"
    fi
    
    arch=$(uname -m)
    [[ "$arch" == "x86_64" ]] && arch="x86_64"
    [[ "$arch" == "aarch64" || "$arch" == "arm64" ]] && arch="aarch64"
    
    echo "Detected: $OS_NAME ($arch)"
    
    # Detect package manager
    if command -v brew &>/dev/null; then
        pkg_manager="brew"
    elif command -v pacman &>/dev/null; then
        pkg_manager="pacman"
    elif command -v apt &>/dev/null; then
        pkg_manager="apt"
    elif command -v dnf &>/dev/null; then
        pkg_manager="dnf"
    elif command -v zypper &>/dev/null; then
        pkg_manager="zypper"
    fi
    
    echo "Package manager: $pkg_manager"
    echo ""
    
    # Check if sudo needed
    local sudo_cmd=""
    if [[ "$os" != "macos" ]] && [[ ! -w /usr/local/bin ]] && ! command -v sudo &>/dev/null; then
        sudo_cmd="sudo"
    elif [[ "$os" != "macos" ]]; then
        sudo_cmd="sudo"
    fi
    
    echo "Installing core packages..."
    
    # Core packages
    local core_pkgs="git curl wget vim neovim fzf ripgrep tree htop tar gzip unzip"
    
    case "$pkg_manager" in
        brew)
            brew install coreutils findutils gawk gnu-sed gnu-tar grep 2>/dev/null || true
            brew install git curl wget vim neovim fzf ripgrep tree htop 2>/dev/null || true
            ;;
        pacman)
            $sudo_cmd pacman -Sy --noconfirm $core_pkgs 2>/dev/null || true
            ;;
        apt)
            $sudo_cmd apt update -qq 2>/dev/null || true
            $sudo_cmd apt install -y $core_pkgs 2>/dev/null || true
            ;;
        dnf)
            $sudo_cmd dnf install -y $core_pkgs 2>/dev/null || true
            ;;
        zypper)
            $sudo_cmd zypper install -y $core_pkgs 2>/dev/null || true
            ;;
    esac
    
    echo ""
    echo "Installing modern CLI tools..."
    
    # Install EZA (ls replacement)
    if ! command -v eza &>/dev/null; then
        echo "  → Installing eza..."
        local eza_url=""
        case "$os" in
            macos)
                brew install eza 2>/dev/null || true
                ;;
            arch|manjaro|endeavouros)
                $sudo_cmd pacman -S --noconfirm eza 2>/dev/null || true
                ;;
            *)
                eza_url="https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_${arch}-unknown-linux-gnu.tar.gz"
                curl -Ls "$eza_url" | $sudo_cmd tar xzf - -C /usr/local/bin eza 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install BAT (cat replacement)
    if ! command -v bat &>/dev/null; then
        echo "  → Installing bat..."
        local bat_url=""
        case "$os" in
            macos)
                brew install bat 2>/dev/null || true
                ;;
            arch|manjaro|endeavouros)
                $sudo_cmd pacman -S --noconfirm bat 2>/dev/null || true
                ;;
            *)
                bat_url="https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-${arch}-unknown-linux-gnu.tar.gz"
                curl -Ls "$bat_url" | $sudo_cmd tar xzf - -C /usr/local/bin bat 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install STARSHIP prompt
    if ! command -v starship &>/dev/null; then
        echo "  → Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
    fi
    
    # Install ZOXIDE (cd replacement)
    if ! command -v zoxide &>/dev/null; then
        echo "  → Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh 2>/dev/null || true
    fi
    
    # Install FZF
    if ! command -v fzf &>/dev/null; then
        echo "  → Installing fzf..."
        [[ -d ~/.fzf ]] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all 2>/dev/null || true
    fi
    
    # Install DELTA (git diff)
    if ! command -v delta &>/dev/null; then
        echo "  → Installing delta..."
        case "$os" in
            macos)
                brew install delta 2>/dev/null || true
                ;;
            arch|manjaro|endeavouros)
                $sudo_cmd pacman -S --noconfirm git-delta 2>/dev/null || true
                ;;
            *)
                local delta_url="https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-${arch}-unknown-linux-musl.tar.gz"
                curl -Ls "$delta_url" | $sudo_cmd tar xzf - -C /usr/local/bin delta 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install FD (find replacement)
    if ! command -v fd &>/dev/null; then
        echo "  → Installing fd..."
        case "$os" in
            macos)
                brew install fd 2>/dev/null || true
                ;;
            arch|manjaro|endeavouros)
                $sudo_cmd pacman -S --noconfirm fd 2>/dev/null || true
                ;;
            *)
                local fd_url="https://github.com/sharkdp/fd/releases/download/v8.7.3/fd-v8.7.3-${arch}-unknown-linux-gnu.tar.gz"
                curl -Ls "$fd_url" | $sudo_cmd tar xzf - -C /usr/local/bin fd 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install PROCS (ps replacement)
    if ! command -v procs &>/dev/null; then
        echo "  → Installing procs..."
        case "$os" in
            macos)
                brew install procs 2>/dev/null || true
                ;;
            *)
                local procs_url="https://github.com/dalance/procs/releases/download/v0.14.6/procs-v0.14.6-x86_64-linux.zip"
                curl -Ls "$procs_url" -o /tmp/procs.zip 2>/dev/null || true
                unzip -o /tmp/procs.zip -d /tmp/procs 2>/dev/null || true
                $sudo_cmd mv /tmp/procs/procs /usr/local/bin/ 2>/dev/null || true
                rm -rf /tmp/procs /tmp/procs.zip
                ;;
        esac
    fi
    
    # Install TLDR
    if ! command -v tldr &>/dev/null; then
        echo "  → Installing tldr..."
        case "$os" in
            macos)
                brew install tldr 2>/dev/null || true
                ;;
            arch|manjaro|endeavouros)
                $sudo_cmd pacman -S --noconfirm tldr 2>/dev/null || true
                ;;
            *)
                $sudo_cmd npm install -g tldr 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install YAZI
    if ! command -v yazi &>/dev/null; then
        echo "  → Installing yazi..."
        case "$os" in
            macos)
                brew install yazi 2>/dev/null || true
                ;;
            *)
                $sudo_cmd cargo install yazi 2>/dev/null || true
                ;;
        esac
    fi
    
    # Install shells if not present
    echo ""
    echo "Installing shells..."
    
    case "$pkg_manager" in
        brew)
            brew install zsh fish nushell 2>/dev/null || true
            ;;
        pacman)
            $sudo_cmd pacman -S --noconfirm zsh fish 2>/dev/null || true
            ;;
        apt)
            $sudo_cmd apt install -y zsh fish 2>/dev/null || true
            ;;
        dnf)
            $sudo_cmd dnf install -y zsh fish 2>/dev/null || true
            ;;
    esac
    
    # Install Oh-My-Zsh if using zsh
    if command -v zsh &>/dev/null && [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        echo "  → Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 2>/dev/null || true
    fi
    
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "         INSTALLATION COMPLETE!"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "Modern tools installed:"
    echo "  • eza      - Modern ls"
    echo "  • bat      - Modern cat"
    echo "  • starship - Prompt"
    echo "  • zoxide   - Smart cd"
    echo "  • fzf      - Fuzzy finder"
    echo "  • delta    - Git diff viewer"
    echo "  • fd       - Fast find"
    echo "  • procs    - Modern ps"
    echo ""
    echo "Restart your shell or run:"
    echo "  source ~/.bashrc    # Bash"
    echo "  source ~/.zshrc     # Zsh"
    echo ""
}

# Auto-run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_shell_support
fi
