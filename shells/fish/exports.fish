# Clear any inherited dotfiles vars
set -e DOTFILES_MODE DOTFILES_VERSION STARSHIP_CONFIG DOTFILES_FASTFETCH_ON_STARTUP
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme


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


set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;38;5;74m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[38;5;246m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[04;38;5;146m'

# Secure umask - files 0644, dirs 0755
umask 022

# Locale
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_COLLATE C
set -gx LC_TIME en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8
set -gx LC_MONETARY en_US.UTF-8

# Editors
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx BROWSER xdg-open
set -gx TERMINAL alacritty
set -gx MANPAGER less
set -gx MANWIDTH 80

# XDG
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_RUNTIME_DIR /run/user/(id -u)
set -gx XDG_DATA_DIRS /usr/local/share:/usr/share
set -gx XDG_CONFIG_DIRS /etc/xdg

# X11
set -q XAUTHORITY; or set -gx XAUTHORITY $HOME/.Xauthority

# Wayland
set -q XDG_RUNTIME_DIR; or set -gx XDG_RUNTIME_DIR /run/user/(id -u)
set -q WAYLAND_DISPLAY; or set -gx WAYLAND_DISPLAY wayland-0

# Development
set -gx CARGO_HOME $HOME/.cargo
set -gx GOBIN $HOME/.go/bin
set -gx GOPATH $HOME/.go
set -gx RUSTUP_HOME $HOME/.rustup
set -gx PNPM_HOME $HOME/.local/share/pnpm
set -gx TF_PLUGIN_CACHE_DIR $HOME/.terraform.d/plugin-cache

# Language
set -gx PYTHONDONTWRITEBYTECODE 1
set -gx RUST_BACKTRACE 1
set -gx RUST_LOG info

# Tools
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore-vcs"
set -gx FZF_DEFAULT_OPTS "--color=16 --height=40% --layout=reverse --border"
set -gx BAT_THEME Nord
set -gx BAT_STYLE numbers,changes
set -gx DELTA_FEATURES +line-numbers
set -gx EZA_COLORS di=36:ex=32
set -gx LESS RFX
set -gx SYSTEMD_PAGER "less -RFX"
set -gx SYSTEMD_COLORS 1

# Security
set -gx GPG_TTY (tty 2>/dev/null)
set -gx GNUPGHOME $HOME/.gnupg

# Git
set -gx GIT_PAGER delta
set -gx GIT_SEQUENCE_EDITOR nvim

# Docker
set -gx DOCKER_BUILDKIT 1
set -gx COMPOSE_DOCKER_CLI_BUILD 1
set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx BUILDKIT_PROGRESS plain

# Misc
set -gx TMPDIR /tmp
set -gx MAILCHECK 0
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx KUBE_EDITOR nvim
set -gx GH_EDITOR nvim
set -gx AWS_PAGER ""
