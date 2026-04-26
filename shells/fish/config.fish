set -g fish_greeting ""
set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"
set -gx DOTFILES_OS (uname -s)
set -gx DOTFILES_DISTRO "linux"
set -gx DOTFILES_PKG_MANAGER "none"
set -gx DOTFILES_INIT ""

if test -f /etc/os-release
    set -gx DOTFILES_DISTRO (cat /etc/os-release | grep "^ID=" | cut -d= -f2)
end

if test -d /run/systemd/system
    set -gx DOTFILES_INIT systemd
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

if command -v starship >/dev/null
    starship init fish --print-full-init | source
end

if command -v zoxide >/dev/null
    zoxide init fish | source
end

if command -v fastfetch >/dev/null
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
end

true