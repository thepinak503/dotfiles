set -g fish_greeting ""
set -gx DOTFILES_DIR "$HOME/.local/share/dotfiles"

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

function enable_starship
    type -q starship; and starship init fish | source
    functions -e enable_starship
end
bind \es 'enable_starship; commandline -f repaint'

command -v fastfetch >/dev/null; and fastfetch 2>/dev/null &

true