set -g fish_greeting ""

# Minimal fast config
set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"

# Simple instant prompt
function fish_prompt
    set_color green
    echo -n (whoami)@(hostname)
    set_color normal
    echo -n ':'
    set_color blue
    echo -n (pwd)
    set_color normal
    echo -n '$ '
end

# Lazy load starship - press Alt+s to enable
function enable_starship
    type -q starship; and starship init fish | source
    functions -e enable_starship
end
bind \es 'enable_starship; commandline -f repaint'

# Fastfetch on startup - runs in background
if type -q fastfetch
    fastfetch 2>/dev/null &
end

true