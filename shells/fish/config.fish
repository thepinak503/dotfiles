set -g fish_greeting ""
set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"

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