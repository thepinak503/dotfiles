# =============================================================================
# Fish Configuration  —  Supremely Synchronized & Garuda Enhanced
# =============================================================================

# 1. INITIALIZE GLOBAL STATE
set -g fish_greeting ""

# 2. DYNAMIC PATH DISCOVERY & ENHANCEMENT
set -l script_path (status filename)
set -gx DOTFILES_DIR (dirname (dirname (dirname (realpath $script_path))))

# Fallback check
if not test -d "$DOTFILES_DIR/shells"
    if test -d "$HOME/git/dotfiles"
        set -gx DOTFILES_DIR "$HOME/git/dotfiles"
    else if test -d "/home/pinak/git/dotfiles"
        set -gx DOTFILES_DIR "/home/pinak/git/dotfiles"
    else
        set -gx DOTFILES_DIR "$HOME/.dotfiles"
    end
end
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme

# Additional Paths
set -l extra_paths ~/.local/bin ~/Applications/depot_tools
for p in $extra_paths
    if test -d $p; and not contains $p $PATH
        set -p PATH $p
    end
end

# 3. SOURCE MODULAR HELPERS
source "$DOTFILES_DIR/shells/fish/exports.fish"
source "$DOTFILES_DIR/shells/fish/functions.fish"
source "$DOTFILES_DIR/shells/fish/aliases.fish"

# Compatibility: Apply .fish_profile if it exists
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# 4. TOOLS & PROMPT
if test (uname) = "Darwin"
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-mac.toml"
else
    set -gx STARSHIP_CONFIG "$DOTFILES_DIR/apps/starship-linux.toml"
end

if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

# 5. STARTUP INFO
if status is-interactive; and type -q fastfetch
    fastfetch --config "$DOTFILES_DIR/apps/fastfetch/config.jsonc" 2>/dev/null; or fastfetch --config neofetch.jsonc 2>/dev/null; or fastfetch 2>/dev/null
end
