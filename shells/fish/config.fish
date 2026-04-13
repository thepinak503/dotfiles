set -g fish_greeting ""
set -l script_path (status filename)
set -gx DOTFILES_DIR (dirname (dirname (dirname (realpath $script_path))))
if not test -d "$DOTFILES_DIR/shells"
    if test -d "$HOME/git/dotfiles"
        set -gx DOTFILES_DIR "$HOME/git/dotfiles"
    else
        set -gx DOTFILES_DIR "$HOME/.dotfiles"
    end
end
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme
set -q DOTFILES_STATE_DIR; or set -gx DOTFILES_STATE_DIR "$HOME/.local/share/dotfiles"
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null
set -l extra_paths ~/.local/bin ~/Applications/depot_tools
for p in $extra_paths
    if test -d $p; and not contains $p $PATH
        set -p PATH $p
    end
end
source "$DOTFILES_DIR/shells/fish/exports.fish"
source "$DOTFILES_DIR/shells/fish/functions.fish"
source "$DOTFILES_DIR/shells/fish/aliases.fish"
set -l d "$DOTFILES_DIR/shells/fish/modes"
switch "$DOTFILES_MODE"
    case minimal
        source "$d/minimal.fish"
    case standard
        source "$d/minimal.fish"
        source "$d/standard.fish"
    case supreme
        source "$d/minimal.fish"
        source "$d/standard.fish"
        source "$d/supreme.fish"
    case ultra-nerd
        source "$d/minimal.fish"
        source "$d/standard.fish"
        source "$d/supreme.fish"
        source "$d/ultra-nerd.fish"
    case "*"
        source "$d/minimal.fish"
        source "$d/standard.fish"
        source "$d/supreme.fish"
end
if test -f ~/.fish_profile
    source ~/.fish_profile
end
if test (uname) = "Darwin"
    if test (uname) = "Darwin"
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-mac.toml"
else
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-linux.toml"
end
else
    if test (uname) = "Darwin"
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-mac.toml"
else
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-linux.toml"
end
end
if type -q starship
    starship init fish 2>>"$DOTFILES_STATE_DIR/errors.log" | source
end
if type -q zoxide
    zoxide init fish | source
end
if test -f "$DOTFILES_DIR/bin/dotupdate_bg.sh"; and test "$DOTFILES_MODE" != "minimal"
    bash "$DOTFILES_DIR/bin/dotupdate_bg.sh" &
    if test -f "$DOTFILES_STATE_DIR/update_ready"
        echo -e "\n\033[1;33m⚡ Dotfiles updates are available! Run 'dotupdate' to apply.\033[0m"
    end
end
if status is-interactive; and type -q fastfetch
    fastfetch --config "$DOTFILES_DIR/apps/fastfetch/config.jsonc" 2>/dev/null; or fastfetch --config neofetch.jsonc 2>/dev/null; or fastfetch 2>/dev/null
end
