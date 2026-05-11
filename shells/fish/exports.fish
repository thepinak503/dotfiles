# Clear any inherited dotfiles vars
set -e DOTFILES_MODE DOTFILES_VERSION STARSHIP_CONFIG DOTFILES_FASTFETCH_ON_STARTUP
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme

# Nord LS_COLORS for ls consistency
set -gx LS_COLORS "di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"

# Cargo path
set -gx fish_user_paths $HOME/.cargo/bin $fish_user_paths

# Flatpak paths - works on all Linux distros
test (uname -s) = "Linux"
and begin
    test -d "/var/lib/flatpak/exports/bin"
    and set -gx fish_user_paths /var/lib/flatpak/exports/bin $fish_user_paths
    
    test -d "$HOME/.local/share/flatpak/exports/bin"
    and set -gx fish_user_paths $HOME/.local/share/flatpak/exports/bin $fish_user_paths
end

# LESS_TERMCAP - Colored man pages for fish
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;38;5;74m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[38;5;246m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[04;38;5;146m'

# Secure umask - files 0644, dirs 0755
umask 022
