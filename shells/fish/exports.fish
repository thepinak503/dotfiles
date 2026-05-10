# Clear any inherited dotfiles vars
set -e DOTFILES_MODE DOTFILES_VERSION STARSHIP_CONFIG DOTFILES_FASTFETCH_ON_STARTUP
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme

# Nord LS_COLORS for ls consistency
set -gx LS_COLORS "di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"

set -gx fish_user_paths $HOME/.cargo/bin $fish_user_paths
