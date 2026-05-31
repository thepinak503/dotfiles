#!/usr/bin/env bash
# =============================================================================
# Bash Startup (.bashrc)
# =============================================================================
# This file is the main entrypoint for bash. All source calls are guarded with
# [[ -f ]] checks so that missing files never cause errors. Homebrew detection
# tries multiple installation paths before giving up silently.

# Reset state variables to avoid conflict with inherited shell environments
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION
unset DOTFILES_NAME DOTFILES_FASTFETCH_ON_STARTUP

# =============================================================================
# DOTFILES PATHS
# =============================================================================

export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_NAME="Pinak's Dotfiles"

# =============================================================================
# HOMEBREW DETECTION (multiple fallback paths)
# =============================================================================
# Tries standard and platform-specific Homebrew prefixes before giving up.
# Each eval is guarded by the preceding existence check on the brew binary.

if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

export DOTFILES_VERSION="1.0.0"

# =============================================================================
# SYSTEM BASHRC (if present)
# =============================================================================

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# =============================================================================
# EXPORTS
# =============================================================================

[[ -f "$DOTFILES_DIR/shells/bash/exports.bash" ]] && source "$DOTFILES_DIR/shells/bash/exports.bash"

# =============================================================================
# NON-INTERACTIVE GUARD
# =============================================================================
# If sourced from BASH_ENV (e.g. makepkg), only exports and essential PATH
# setup above are needed. Aliases/functions/prompt are skipped to prevent
# contaminating build tools' command substitution captures.
case "$-" in
    *i*) ;;
    *) return 0 ;;
esac

# =============================================================================
# INTERACTIVE-ONLY SETTINGS
# =============================================================================
# stty, shopt, history, and completion only apply to interactive shells.
# Guard: each command has || true to tolerate restricted environments.

case "$-" in
    *i*)
        stty -ixon 2>/dev/null || true                 # Disable flow control (^S/^Q)
        shopt -s checkwinsize 2>/dev/null || true      # Auto-update LINES/COLUMNS
        shopt -s histappend 2>/dev/null || true        # Append history, don't overwrite
        shopt -s cmdhist 2>/dev/null || true           # Multi-line commands as one entry

        export HISTCONTROL=ignoreboth:erasedups

        # Write history after each command (immediate persistence)
        PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

        # Bash completion: try multiple standard locations
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        elif [ -f /usr/local/share/bash-completion/bash_completion ]; then
            . /usr/local/share/bash-completion/bash_completion
        elif command -v brew >/dev/null 2>&1; then
            _brew_prefix="$(brew --prefix 2>/dev/null)"
            if [ -f "$_brew_prefix/share/bash-completion/bash_completion" ]; then
                . "$_brew_prefix/share/bash-completion/bash_completion"
            fi
            unset _brew_prefix
        fi
        ;;
esac

# =============================================================================
# PROMPT — STARSHIP
# =============================================================================
# Guard: starship init may fail on systems without completions directory

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash 2>/dev/null)" || true
fi

# =============================================================================
# CORE MODULE SOURCING (ORDERED)
# =============================================================================
# Each source is guarded with [[ -f ]] to tolerate missing files.
# The alias-disabling dance around functions.sh prevents alias expansion
# from corrupting function definitions.

[[ -f "$DOTFILES_DIR/core/__cache.sh" ]] && source "$DOTFILES_DIR/core/__cache.sh"
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && source "$DOTFILES_DIR/core/universal.sh"

[[ -f "$DOTFILES_DIR/shells/bash/detect_apps.bash" ]] && source "$DOTFILES_DIR/shells/bash/detect_apps.bash"

[[ -f "$DOTFILES_DIR/core/aliases.sh" ]] && source "$DOTFILES_DIR/core/aliases.sh"

[[ -f "$DOTFILES_DIR/shells/bash/aliases.bash" ]] && source "$DOTFILES_DIR/shells/bash/aliases.bash"

# Disable alias expansion temporarily while sourcing scripts to avoid function definition conflicts
_expand_aliases_was_on=0
shopt -q expand_aliases && _expand_aliases_was_on=1
shopt -u expand_aliases

[[ -f "$DOTFILES_DIR/core/functions.sh" ]] && source "$DOTFILES_DIR/core/functions.sh"

[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"

# Startup fetch: fastfetch runs once at shell start
case $- in *i*) if command -v fastfetch >/dev/null; then
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
fi;; esac

[[ -f "$DOTFILES_DIR/core/system-detect.sh" ]] && source "$DOTFILES_DIR/core/system-detect.sh"
[[ -f "$DOTFILES_DIR/core/os_detect.sh" ]] && source "$DOTFILES_DIR/core/os_detect.sh"
[[ -f "$DOTFILES_DIR/core/logging.sh" ]] && source "$DOTFILES_DIR/core/logging.sh"
[[ -f "$DOTFILES_DIR/core/ssh-agent.sh" ]] && source "$DOTFILES_DIR/core/ssh-agent.sh"
[[ -f "$DOTFILES_DIR/core/battery.sh" ]] && source "$DOTFILES_DIR/core/battery.sh"
[[ -f "$DOTFILES_DIR/core/tools.sh" ]] && source "$DOTFILES_DIR/core/tools.sh"

# Restore alias expansion if it was enabled — MUST happen after functions.sh sourcing
[ $_expand_aliases_was_on -eq 1 ] && shopt -s expand_aliases
unset _expand_aliases_was_on

# =============================================================================
# AUTO-UPDATE CHECK
# =============================================================================
# Checks every 7 days (604800 seconds). Write is guarded with || true so that
# a missing DOTFILES_STATE_DIR does not crash the shell.

[[ -z "$DOTFILES_NO_UPDATE" && $- == *i* ]] && {
  _du_file="$DOTFILES_STATE_DIR/last_update_check"
  [[ -f "$_du_file" ]] && _du_age=$(( $(date +%s) - $(<"$_du_file") )) || _du_age=999999
  [[ $_du_age -gt 604800 ]] && { bash "$DOTFILES_DIR/bin/dotupdate.sh" --yes >/dev/null 2>&1 & disown; date +%s > "$_du_file" 2>/dev/null || true; }
  unset _du_file _du_age
}

# =============================================================================
# ULTIMATE CINEMATIC FEATURES (Bash)
# =============================================================================
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function x() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.tar.zst)   tar --zstd -xf "$1" ;;
            *.zst)       unzstd "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function cheat() {
    if [ -z "$1" ]; then
        echo "Usage: cheat <language> <query>"
        return 1
    fi
    curl -s "cht.sh/$1/$2" | bat --style=plain --language="$1"
}

function weather() {
    curl -s "wttr.in/${1:-}?m"
}

fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m --prompt="Kill> " | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m --prompt="Kill> " | awk '{print $2}')
    fi
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
        echo "💀 Killed process: $pid"
    fi
}

fgbr() {
    local branches branch
    branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzf --prompt="Checkout branch> " | sed "s/.* //" | sed "s#remotes/[^/]*/##") &&
    git checkout "$branch"
}

cpfile() {
    if [ -z "$1" ]; then
        echo "Usage: cpfile <filename>"
        return 1
    fi
    if command -v wl-copy >/dev/null 2>&1; then
        cat "$1" | wl-copy && echo "📋 Copied $1 to Wayland clipboard!"
    elif command -v xclip >/dev/null 2>&1; then
        cat "$1" | xclip -sel clip && echo "📋 Copied $1 to X11 clipboard!"
    elif command -v pbcopy >/dev/null 2>&1; then
        cat "$1" | pbcopy && echo "📋 Copied $1 to macOS clipboard!"
    else
        echo "❌ No clipboard utility found (wl-copy, xclip, pbcopy)."
    fi
}

true
