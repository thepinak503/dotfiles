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
        end
    case fedora centos rhel rocky alma
        if type -q dnf
            set -gx DOTFILES_PKG_MANAGER dnf
        end
    case macos
        if type -q brew
            set -gx DOTFILES_PKG_MANAGER brew
        end
end

# Init system
if test -d /run/systemd/system
    set -gx DOTFILES_INIT systemd
end

# =============================================================================
# All Aliases (merged)
# =============================================================================

if test -f "$DOTFILES_DIR/shells/fish/aliases_all.fish"
    source "$DOTFILES_DIR/shells/fish/aliases_all.fish"
end

# =============================================================================
# All Functions (merged)
# =============================================================================

if test -f "$DOTFILES_DIR/shells/fish/functions_all.fish"
    source "$DOTFILES_DIR/shells/fish/functions_all.fish"
end

# =============================================================================
# Dynamic App Detection (Fish)
# =============================================================================

if test -f "$DOTFILES_DIR/shells/fish/detect_apps.fish"
    source "$DOTFILES_DIR/shells/fish/detect_apps.fish"
end

# =============================================================================
# Starship Prompt
# =============================================================================

if command -v starship >/dev/null
    if uname -s | string match -q Darwin
        set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-mac.toml"
    else
        set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-linux.toml"
    end
    starship init fish --print-full-init | source
end

# =============================================================================
# Zoxide
# =============================================================================

if command -v zoxide >/dev/null
    zoxide init fish | source
end

# Fastfetch at startup
command -v fastfetch >/dev/null; and fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null

true