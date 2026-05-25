set -g fish_greeting ""

function fish_user_key_bindings
    bind \e\[A history-search-backward
    bind \e\[B history-search-forward
    bind \e\[1\;5D backward-word
    bind \e\[1\;5C forward-word
    bind \e\[1\;3D backward-word
    bind \e\[1\;3C forward-word
    bind \e\[H beginning-of-line
    bind \e\[F end-of-line
    bind \e\x7f backward-kill-word
    bind \e\b backward-kill-word
    bind \e\[3\;3~ kill-word
    bind \ch backward-kill-word
    bind \e\[3\;5~ kill-word
    bind \cw backward-kill-word
    bind \ed kill-word
    bind \ck kill-line
    bind \cu backward-kill-line
    bind \cz undo
    bind \e\cz redo
    bind \cl 'clear; commandline -f repaint'
end

# =============================================================================


# =============================================================================

set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"
set -gx DOTFILES_STATE_DIR "$HOME/.local/share/dotfiles"
set -gx DOTFILES_VERSION "1.0.0"
set -gx DOTFILES_ARCH (uname -m)

# =============================================================================

# =============================================================================

set -l brew_prefix ""
if type -q brew
    set brew_prefix (brew --prefix)
    eval (brew shellenv)
else if test -f "/opt/homebrew/bin/brew"
    set brew_prefix "/opt/homebrew"
    eval (/opt/homebrew/bin/brew shellenv)
else if test -f "/usr/local/bin/brew"
    set brew_prefix "/usr/local"
    eval (/usr/local/bin/brew shellenv)
else if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
    set brew_prefix "/home/linuxbrew/.linuxbrew"
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# =============================================================================

# =============================================================================

set -gx DOTFILES_OS (uname -s)
set -gx DOTFILES_DISTRO "linux"
set -gx DOTFILES_PKG_MANAGER "none"
set -gx DOTFILES_INIT ""


if test "$DOTFILES_OS" = "Darwin"
    set -gx DOTFILES_DISTRO "macos"
else

    if test -f /etc/os-release
        set -l id ""
        set -l id_like ""

        for line in (cat /etc/os-release)
            if string match -r '^ID=' $line >/dev/null
                set id (string split -m1 = $line)[2]
                set id (string replace -a '"' '' $id)
            end
            if string match -r '^ID_LIKE=' $line >/dev/null
                set id_like (string split -m1 = $line)[2]
                set id_like (string replace -a '"' '' $id_like)
            end
        end
        

        switch "$id"
            case 'arch' 'artix' 'manjaro' 'endeavouros' 'garuda' 'archlabs'
                set -gx DOTFILES_DISTRO "arch"
            case 'debian' 'ubuntu' 'linuxmint' 'pop' 'elementary' 'zorin' 'neon' 'mx'
                set -gx DOTFILES_DISTRO "debian"
            case 'fedora' 'centos' 'stream' 'rhel' 'rocky' 'alma' 'nobara'
                set -gx DOTFILES_DISTRO "fedora"
            case 'opensuse' 'sles' 'leap' 'tumbleweed' 'gecko'
                set -gx DOTFILES_DISTRO "suse"
            case 'void'
                set -gx DOTFILES_DISTRO "void"
            case 'alpine'
                set -gx DOTFILES_DISTRO "alpine"
            case 'gentoo' 'funtoo' 'calculate'
                set -gx DOTFILES_DISTRO "gentoo"
            case 'nixos'
                set -gx DOTFILES_DISTRO "nix"
            case 'slackware' 'slint' 'salix' 'vector'
                set -gx DOTFILES_DISTRO "slackware"
            case '*'

                if test -n "$id_like"
                    switch "$id_like"
                        case '*arch*'
                            set -gx DOTFILES_DISTRO "arch"
                        case '*debian*' '*ubuntu*'
                            set -gx DOTFILES_DISTRO "debian"
                        case '*fedora*' '*rhel*' '*centos*'
                            set -gx DOTFILES_DISTRO "fedora"
                        case '*suse*' '*opensuse*'
                            set -gx DOTFILES_DISTRO "suse"
                        case '*gentoo*'
                            set -gx DOTFILES_DISTRO "gentoo"
                        case '*slackware*'
                            set -gx DOTFILES_DISTRO "slackware"
                        case '*'
                            set -gx DOTFILES_DISTRO "$id"
                    end
                else
                    set -gx DOTFILES_DISTRO "$id"
                end
        end
    else if test -f /etc/arch-release
        set -gx DOTFILES_DISTRO "arch"
    else if test -f /etc/debian_version
        set -gx DOTFILES_DISTRO "debian"
    else if test -f /etc/fedora-release
        set -gx DOTFILES_DISTRO "fedora"
    else if test -f /etc/SuSE-release
        set -gx DOTFILES_DISTRO "suse"
    else if test -f /etc/gentoo-release
        set -gx DOTFILES_DISTRO "gentoo"
    else if test -f /etc/slackware-version
        set -gx DOTFILES_DISTRO "slackware"
    else if test -f /etc/alpine-release
        set -gx DOTFILES_DISTRO "alpine"
    end
end

# =============================================================================
# PACKAGE MANAGER DETECTION - by priority
# =============================================================================

if type -q paru
    set -gx DOTFILES_PKG_MANAGER "paru"
else if type -q yay
    set -gx DOTFILES_PKG_MANAGER "yay"
else if type -q brew
    set -gx DOTFILES_PKG_MANAGER "brew"
else if type -q pacman
    set -gx DOTFILES_PKG_MANAGER "pacman"
else if type -q apt
    set -gx DOTFILES_PKG_MANAGER "apt"
else if type -q apt-get
    set -gx DOTFILES_PKG_MANAGER "apt-get"
else if type -q dnf
    set -gx DOTFILES_PKG_MANAGER "dnf"
else if type -q yum
    set -gx DOTFILES_PKG_MANAGER "yum"
else if type -q zypper
    set -gx DOTFILES_PKG_MANAGER "zypper"
else if type -q apk
    set -gx DOTFILES_PKG_MANAGER "apk"
else if type -q xbps-install
    set -gx DOTFILES_PKG_MANAGER "xbps"
else if type -q slackpkg
    set -gx DOTFILES_PKG_MANAGER "slackpkg"
else if type -q emerge
    set -gx DOTFILES_PKG_MANAGER "emerge"
else if type -q nix
    set -gx DOTFILES_PKG_MANAGER "nix"
else if type -q port
    set -gx DOTFILES_PKG_MANAGER "port"
end

# =============================================================================
# INIT SYSTEM DETECTION - systemd / sysvinit / openrc / runit
# =============================================================================

if test -d /run/systemd/system
    set -gx DOTFILES_INIT "systemd"
else if test -f /proc/1/comm
    set -gx DOTFILES_INIT (cat /proc/1/comm 2>/dev/null; or echo "unknown")
else if test -f /etc/init.d/cron
    set -gx DOTFILES_INIT "sysv"
else
    set -gx DOTFILES_INIT "unknown"
end

# =============================================================================
# SOURCE DOTFILES MODULES
# =============================================================================


if test -f "$DOTFILES_DIR/shells/fish/exports.fish"
    source "$DOTFILES_DIR/shells/fish/exports.fish"
end


if test -f "$DOTFILES_DIR/shells/fish/aliases.fish"
    source "$DOTFILES_DIR/shells/fish/aliases.fish"
end


if test -f "$DOTFILES_DIR/shells/fish/detect_apps.fish"
    source "$DOTFILES_DIR/shells/fish/detect_apps.fish"
end


if test -f "$DOTFILES_DIR/shells/fish/functions.fish"
    source "$DOTFILES_DIR/shells/fish/functions.fish"
end

# =============================================================================
# SECURITY UPGRADE - FBI-APPROVED HARDENING

# =============================================================================

# Fish history deduplication - suppress errors if option is unsupported in older fish versions
set fish_history_unique true 2>/dev/null


