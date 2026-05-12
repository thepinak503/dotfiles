#!/usr/bin/env bash
unset DOTFILES_DIR DOTFILES_STATE_DIR DOTFILES_MODE DOTFILES_VERSION DOTFILES_NAME DOTFILES_FASTFETCH_ON_STARTUP
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_NAME="Pinak's Dotfiles"

# Homebrew - supports both macOS (Intel/Apple Silicon) and Linux
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

# Source global definitions - /etc/bashrc exists on RHEL/Fedora/CentOS
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Interactive-only settings
case "$-" in
    *i*)
        # Disable ctrl-s from stopping flow (freezing terminal)
        stty -ixon 2>/dev/null || true

        # Check window size after each command, update LINES/COLUMNS
        shopt -s checkwinsize 2>/dev/null || true

        # Append to history instead of overwriting (critical for multi-terminal sessions)
        shopt -s histappend 2>/dev/null || true

        # Save multi-line commands as single entry in history
        shopt -s cmdhist 2>/dev/null || true

        # History control: ignore duplicates + commands starting with space
        # erasedups removes all previous duplicates of the current command
        export HISTCONTROL=ignoreboth:erasedups

        # Save history immediately after each command (with PROMPT_COMMAND)
        # -a: append new history lines from current session to histfile
        PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

        # Enable bash programmable completion (multi-distro path support)
        # /usr/share/bash-completion: Arch, Fedora, modern Debian/Ubuntu
        # /etc/bash_completion: Debian/Ubuntu legacy, some older systems
        # /usr/local/share/bash-completion: Homebrew, custom installs
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

# Environment exports (PATH, LS_COLORS, etc.)
[[ -f "$DOTFILES_DIR/shells/bash/exports.bash" ]] && source "$DOTFILES_DIR/shells/bash/exports.bash"

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Universal distro-agnostic config (OS detection + cross-distro aliases)
[[ -f "$DOTFILES_DIR/core/universal.sh" ]] && source "$DOTFILES_DIR/core/universal.sh"

# Dynamic app detection (only enables aliases if app is installed)
[[ -f "$DOTFILES_DIR/shells/bash/detect_apps.bash" ]] && source "$DOTFILES_DIR/shells/bash/detect_apps.bash"

# All aliases (merged into one file)
[[ -f "$DOTFILES_DIR/core/aliases.sh" ]] && source "$DOTFILES_DIR/core/aliases.sh"

# Bash-specific aliases (2000+)
[[ -f "$DOTFILES_DIR/shells/bash/aliases.bash" ]] && source "$DOTFILES_DIR/shells/bash/aliases.bash"

# All functions (merged into one file)
[[ -f "$DOTFILES_DIR/core/functions.sh" ]] && source "$DOTFILES_DIR/core/functions.sh"

# Distro-specific aliases (Arch, Debian, macOS, Fedora)
[[ -f "$DOTFILES_DIR/core/arch_aliases.sh" ]] && source "$DOTFILES_DIR/core/arch_aliases.sh"
[[ -f "$DOTFILES_DIR/core/debian_aliases.sh" ]] && source "$DOTFILES_DIR/core/debian_aliases.sh"
[[ -f "$DOTFILES_DIR/core/macos_aliases.sh" ]] && source "$DOTFILES_DIR/core/macos_aliases.sh"
[[ -f "$DOTFILES_DIR/core/fedora_aliases.sh" ]] && source "$DOTFILES_DIR/core/fedora_aliases.sh"

# Fastfetch at startup (interactive only)
case $- in *i*) if command -v fastfetch >/dev/null; then
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
fi;; esac

# Core modules (system detection, logging, ssh-agent, battery, tools)
[[ -f "$DOTFILES_DIR/core/system-detect.sh" ]] && source "$DOTFILES_DIR/core/system-detect.sh"
[[ -f "$DOTFILES_DIR/core/os_detect.sh" ]] && source "$DOTFILES_DIR/core/os_detect.sh"
[[ -f "$DOTFILES_DIR/core/logging.sh" ]] && source "$DOTFILES_DIR/core/logging.sh"
[[ -f "$DOTFILES_DIR/core/ssh-agent.sh" ]] && source "$DOTFILES_DIR/core/ssh-agent.sh"
[[ -f "$DOTFILES_DIR/core/battery.sh" ]] && source "$DOTFILES_DIR/core/battery.sh"
[[ -f "$DOTFILES_DIR/core/tools.sh" ]] && source "$DOTFILES_DIR/core/tools.sh"

# Auto-update check (background, every 7 days)
[[ -z "$DOTFILES_NO_UPDATE" && $- == *i* ]] && {
  _du_file="$DOTFILES_STATE_DIR/last_update_check"
  [[ -f "$_du_file" ]] && _du_age=$(( $(date +%s) - $(<"$_du_file") )) || _du_age=999999
  [[ $_du_age -gt 604800 ]] && { bash "$DOTFILES_DIR/bin/dotupdate.sh" --yes >/dev/null 2>&1 & disown; date +%s > "$_du_file"; }
  unset _du_file _du_age
}

true