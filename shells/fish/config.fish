set -g fish_greeting ""
set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"

# =============================================================================
# OS Detection (Fish)
# =============================================================================

set -gx DOTFILES_OS (uname -s)

switch (uname -s)
    case Linux*
        if test -f /etc/os-release
            source /etc/os-release
            set -gx DOTFILES_DISTRO $ID
        else if test -f /etc/arch-release
            set -gx DOTFILES_DISTRO arch
        else if test -f /etc/debian_version
            set -gx DOTFILES_DISTRO debian
        else
            set -gx DOTFILES_DISTRO linux
        end
    case Darwin*
        set -gx DOTFILES_DISTRO macos
    case '*'
        set -gx DOTFILES_DISTRO unknown
end

# Package manager detection
set -gx DOTFILES_PKG_MANAGER "none"
switch "$DOTFILES_DISTRO"
    case arch artix manjaro endeavour
        if type -q yay
            set -gx DOTFILES_PKG_MANAGER yay
        else if type -q pacman
            set -gx DOTFILES_PKG_MANAGER pacman
        end
    case debian ubuntu linuxmint pop zorin
        if type -q apt
            set -gx DOTFILES_PKG_MANAGER apt
        else if type -q apt-get
            set -gx DOTFILES_PKG_MANAGER apt-get
        end
    case fedora centos rhel rocky alma
        if type -q dnf
            set -gx DOTFILES_PKG_MANAGER dnf
        else if type -q yum
            set -gx DOTFILES_PKG_MANAGER yum
        end
    case opensuse sles
        if type -q zypper
            set -gx DOTFILES_PKG_MANAGER zypper
        end
    case void
        if type -q xbps-install
            set -gx DOTFILES_PKG_MANAGER xbps
        end
    case alpine
        if type -q apk
            set -gx DOTFILES_PKG_MANAGER apk
        end
    case gentoo
        if type -q emerge
            set -gx DOTFILES_PKG_MANAGER emerge
        end
    case macos
        if type -q brew
            set -gx DOTFILES_PKG_MANAGER brew
        else if type -q port
            set -gx DOTFILES_PKG_MANAGER port
        end
end

# Init system
if test -d /run/systemd/system
    set -gx DOTFILES_INIT systemd
else if test -f /proc/1/comm
    set -gx DOTFILES_INIT (cat /proc/1/comm)
else
    set -gx DOTFILES_INIT unknown
end

# =============================================================================
# Cross-distro Aliases (Fish)
# =============================================================================

# System update
function update --description "Update system packages"
    switch "$DOTFILES_PKG_MANAGER"
        case yay pacman
            sudo pacman -Syu
        case apt
            sudo apt update; and sudo apt upgrade
        case dnf yum
            sudo dnf upgrade
        case brew
            brew update; and brew upgrade
        case apk
            apk update; and apk upgrade
        case zypper
            sudo zypper update
        case xbps
            sudo xbps-install -S
        case emerge
            sudo emerge -DuDaN world
        case '*'
            echo "No supported package manager found"
    end
end
abbr -a ins -k update

# Install packages
function ins --description "Install package"
    switch "$DOTFILES_PKG_MANAGER"
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
        case zypper
            sudo zypper install $argv
        case xbps
            sudo xbps-install -S $argv
        case port
            sudo port install $argv
        case '*'
            echo "No supported package manager found"
    end
end
abbr -a ins

# Remove packages
function rem --description "Remove package"
    switch "$DOTFILES_PKG_MANAGER"
        case yay pacman
            sudo pacman -Rns $argv
        case apt
            sudo apt remove $argv
        case dnf
            sudo dnf remove $argv
        case brew
            brew remove $argv
        case apk
            apk del $argv
        case zypper
            sudo zypper remove $argv
        case xbps
            sudo xbps-remove -R $argv
        case '*'
            echo "No supported package manager found"
    end
end
abbr -a rem

# Search packages
function se --description "Search packages"
    switch "$DOTFILES_PKG_MANAGER"
        case yay pacman
            pacman -Ss $argv
        case apt apt-get
            apt search $argv
        case dnf yum
            dnf search $argv
        case brew
            brew search $argv
        case apk
            apk search $argv
        case zypper
            zypper search $argv
        case xbps
            xbps-query -Rs $argv
        case '*'
            echo "No supported package manager found"
    end
end
abbr -a se

# List packages
function lsp --description "List installed packages"
    switch "$DOTFILES_PKG_MANAGER"
        case yay pacman
            pacman -Qq
        case apt apt-get
            dpkg -l | tail -n +3
        case dnf
            dnf list installed
        case brew
            brew list
        case apk
            apk list
        case '*'
            echo "No supported package manager found"
    end
end
abbr -a lsp

# Systemctl (systemd)
if test "$DOTFILES_INIT" = "systemd"
    abbr -a sc systemctl
    abbr -a scs systemctl status
    abbr -a scst systemctl start
    abbr -a scsp systemctl stop
    abbr -a scsr systemctl restart
    abbr -a scse systemctl enable
    abbr -a scsd systemctl disable
    abbr -a jc journalctl
    abbr -a jce journalctl -e
    abbr -a jcf journalctl -f
    abbr -a jcu journalctl -u
end

# Neofetch
abbr -a neo neofetch
abbr -a fetch fastfetch

# Sysinfo
function sysinfo --description "Show system info"
    echo "OS: $DOTFILES_DISTRO"
    echo "Kernel: "(uname -r)
    echo "Shell: $SHELL"
    echo "Pkg Manager: $DOTFILES_PKG_MANAGER"
    echo "Init: $DOTFILES_INIT"
end

# Cleanup
abbr -a cleancache rm -rf ~/.cache/*
abbr -a cleanpkg rm -rf /var/cache/*

# Dynamic app detection
if test -f "$DOTFILES_DIR/shells/fish/detect_apps.fish"
    source "$DOTFILES_DIR/shells/fish/detect_apps.fish"
end

# Starship prompt
if command -v starship >/dev/null
    if uname -s | string match -q Darwin
        set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-mac.toml"
    else
        set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-linux.toml"
    end
    starship init fish --print-full-init | source
end

# Zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# Fastfetch at startup
command -v fastfetch >/dev/null; and fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null

true