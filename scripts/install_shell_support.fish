#!/usr/bin/env fish
# =============================================================================
# INSTALL SHELL SUPPORT - Fish Shell Version
# Usage: source install_shell_support.fish
#        or: fish install_shell_support.fish
# =============================================================================

function install_shell_support
    set -l pkg_manager ""
    set -l os ""
    set -l arch (uname -m)
    
    echo "════════════════════════════════════════════════════════════"
    echo "         SHELL SUPPORT INSTALLER v1.0 (Fish)"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    
    # Detect OS
    if test -f /etc/os-release
        set -l os_id (grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"')
        set -l os_name (grep "^NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
        set os $os_id
    else if test (uname -s) = "Darwin"
        set os "macos"
        set os_name "macOS"
    else
        set os "unknown"
        set os_name "Unknown"
    end
    
    # Normalize arch
    if test "$arch" = "x86_64"
        set arch "x86_64"
    else if test "$arch" = "aarch64" -o "$arch" = "arm64"
        set arch "aarch64"
    end
    
    echo "Detected: $os_name ($arch)"
    
    # Detect package manager
    if type -q brew
        set pkg_manager "brew"
    else if type -q pacman
        set pkg_manager "pacman"
    else if type -q apt
        set pkg_manager "apt"
    else if type -q dnf
        set pkg_manager "dnf"
    end
    
    echo "Package manager: $pkg_manager"
    echo ""
    
    # Check sudo
    set -l sudo_cmd ""
    if test "$os" != "macos"
        if test ! -w /usr/local/bin
            set sudo_cmd "sudo"
        else
            set sudo_cmd "sudo"
        end
    end
    
    echo "Installing core packages..."
    set -l core_pkgs "git curl wget vim neovim fzf ripgrep tree htop tar gzip unzip"
    
    switch "$pkg_manager"
        case brew
            brew install coreutils findutils gawk gnu-sed gnu-tar grep 2>/dev/null || true
            brew install git curl wget vim neovam fzf ripgrep tree htop 2>/dev/null || true
        case pacman
            $sudo_cmd pacman -Sy --noconfirm $core_pkgs 2>/dev/null || true
        case apt
            $sudo_cmd apt update -qq 2>/dev/null || true
            $sudo_cmd apt install -y $core_pkgs 2>/dev/null || true
        case dnf
            $sudo_cmd dnf install -y $core_pkgs 2>/dev/null || true
    end
    
    echo ""
    echo "Installing modern CLI tools..."
    
    # Install EZA
    if not type -q eza
        echo "  → Installing eza..."
        switch "$pkg_manager"
            case brew
                brew install eza 2>/dev/null || true
            case pacman
                $sudo_cmd pacman -S --noconfirm eza 2>/dev/null || true
            case apt dnf
                set -l eza_url "https://github.com/eza-community/eza/releases/download/v0.20.0/eza_v0.20.0_${arch}-unknown-linux-gnu.tar.gz"
                curl -Ls "$eza_url" | $sudo_cmd tar xzf - -C /usr/local/bin eza 2>/dev/null || true
        end
    end
    
    # Install BAT
    if not type -q bat
        echo "  → Installing bat..."
        switch "$pkg_manager"
            case brew
                brew install bat 2>/dev/null || true
            case pacman
                $sudo_cmd pacman -S --noconfirm bat 2>/dev/null || true
            case apt dnf
                set -l bat_url "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-${arch}-unknown-linux-gnu.tar.gz"
                curl -Ls "$bat_url" | $sudo_cmd tar xzf - -C /usr/local/bin bat 2>/dev/null || true
        end
    end
    
    # Install STARSHIP
    if not type -q starship
        echo "  → Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true
    end
    
    # Install ZOXIDE
    if not type -q zoxide
        echo "  → Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh 2>/dev/null || true
    end
    
    # Install FZF
    if not type -q fzf
        echo "  → Installing fzf..."
        if not test -d ~/.fzf
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        end
        ~/.fzf/install --all 2>/dev/null || true
    end
    
    # Install DELTA
    if not type -q delta
        echo "  → Installing delta..."
        switch "$pkg_manager"
            case brew
                brew install delta 2>/dev/null || true
            case pacman
                $sudo_cmd pacman -S --noconfirm git-delta 2>/dev/null || true
        end
    end
    
    # Install FD
    if not type -q fd
        echo "  → Installing fd..."
        switch "$pkg_manager"
            case brew
                brew install fd 2>/dev/null || true
            case pacman
                $sudo_cmd pacman -S --noconfirm fd 2>/dev/null || true
        end
    end
    
    # Install shells
    echo ""
    echo "Installing shells..."
    
    switch "$pkg_manager"
        case brew
            brew install zsh fish 2>/dev/null || true
        case pacman
            $sudo_cmd pacman -S --noconfirm zsh fish 2>/dev/null || true
        case apt
            $sudo_cmd apt install -y zsh fish 2>/dev/null || true
        case dnf
            $sudo_cmd dnf install -y zsh fish 2>/dev/null || true
    end
    
    # Add Fish functions path
    if not contains "$__fish_config_dir/functions" $fish_function_path
        set -g fish_function_path $__fish_config_dir/functions $fish_function_path
    end
    
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "         INSTALLATION COMPLETE!"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "Restart your shell or run:"
    echo "  exec fish"
    echo ""
end

# Auto-run if executed directly
if status is-interactive
    # Don't auto-run in interactive mode
else
    install_shell_support
end
