#!/usr/bin/env bash
# =============================================================================
# 09-SHELL-OPTIONS.SH - Bash Shell Options and Key Bindings
# Applies to: Bash only (not Zsh)
# =============================================================================

# Only run if we're in Bash
if [[ -z "$BASH_VERSION" ]]; then
    return 0
fi

# =============================================================================
# SHELL OPTIONS (shopt)
# =============================================================================

# Check window size after each command and update LINES/COLUMNS
shopt -s checkwinsize 2>/dev/null

# Append to history file, don't overwrite
shopt -s histappend 2>/dev/null

# Save multi-line commands as one entry
shopt -s cmdhist 2>/dev/null

# Autocorrect minor directory spelling errors
shopt -s cdspell 2>/dev/null

# Enable cd without typing 'cd'
shopt -s autocd 2>/dev/null

# Enable recursive globbing with **
shopt -s globstar 2>/dev/null

# Case insensitive globbing
shopt -s nocaseglob 2>/dev/null

# Include dotfiles in glob results
shopt -s dotglob 2>/dev/null

# Expand aliases
shopt -s expand_aliases 2>/dev/null

# Enable programmable completion
shopt -s progcomp 2>/dev/null

# Check command hash before executing
shopt -s checkhash 2>/dev/null

# =============================================================================
# KEY BINDINGS (readline)
# =============================================================================

# Only set up bind if bind command exists (bash-only)
if command -v bind &>/dev/null; then
    # Enable case-insensitive tab completion
    bind "set completion-ignore-case on" 2>/dev/null

    # Treat hyphens and underscores as equivalent
    bind "set completion-map-case on" 2>/dev/null

    # Display matches immediately if ambiguous
    bind "set show-all-if-ambiguous on" 2>/dev/null

    # Display matches immediately if unmodified
    bind "set show-all-if-unmodified on" 2>/dev/null

    # Mark symlinked directories
    bind "set mark-symlinked-directories on" 2>/dev/null

    # Visible bell instead of beep
    bind "set bell-style visible" 2>/dev/null

    # Enable colored completion
    bind "set colored-stats on" 2>/dev/null

    # Enable colored completion prefix
    bind "set colored-completion-prefix on" 2>/dev/null

    # Skip completed text
    bind "set skip-completed-text on" 2>/dev/null

    # Menu complete (cycle through options with Tab)
    bind "TAB: menu-complete" 2>/dev/null
    bind "set menu-complete-display-prefix on" 2>/dev/null

    # =============================================================================
    # HISTORY NAVIGATION
    # =============================================================================

    # Up arrow - search backward in history
    bind '"\e[A": history-search-backward' 2>/dev/null
    bind '"\e[B": history-search-forward' 2>/dev/null

    # Page up/down - history search
    bind '"\e[5~": history-search-backward' 2>/dev/null
    bind '"\e[6~": history-search-forward' 2>/dev/null

    # Ctrl+P / Ctrl+N for history
    bind '"\C-p": previous-history' 2>/dev/null
    bind '"\C-n": next-history' 2>/dev/null

    # =============================================================================
    # CURSOR MOVEMENT
    # =============================================================================

    # Home / End keys
    bind '"\e[H": beginning-of-line' 2>/dev/null
    bind '"\e[F": end-of-line' 2>/dev/null
    bind '"\e[OH": beginning-of-line' 2>/dev/null
    bind '"\e[OF": end-of-line' 2>/dev/null

    # Ctrl+Arrow for word movement
    bind '"\e[1;5D": backward-word' 2>/dev/null
    bind '"\e[1;5C": forward-word' 2>/dev/null
    bind '"\e[1;5A": previous-history' 2>/dev/null
    bind '"\e[1;5B": next-history' 2>/dev/null

    # Alt+Arrow for word movement
    bind '"\e[1;3D": backward-word' 2>/dev/null
    bind '"\e[1;3C": forward-word' 2>/dev/null
    bind '"\e[1;3A": previous-history' 2>/dev/null
    bind '"\e[1;3B": next-history' 2>/dev/null

    # Ctrl+Home/End
    bind '"\e[1;5H": beginning-of-line' 2>/dev/null
    bind '"\e[1;5F": end-of-line' 2>/dev/null

    # =============================================================================
    # EDITING SHORTCUTS
    # =============================================================================

    # Ctrl+K - delete from cursor to end of line
    bind '"\C-k": kill-line' 2>/dev/null

    # Ctrl+U - delete from cursor to beginning of line
    bind '"\C-u": backward-kill-line' 2>/dev/null

    # Ctrl+W - delete word backward
    bind '"\C-w": backward-kill-word' 2>/dev/null

    # Alt+D - delete word forward
    bind '"\e[3;3~": kill-word' 2>/dev/null

    # Ctrl+A - beginning of line
    bind '"\C-a": beginning-of-line' 2>/dev/null

    # Ctrl+E - end of line
    bind '"\C-e": end-of-line' 2>/dev/null

    # Ctrl+Y - paste (yank)
    bind '"\C-y": yank' 2>/dev/null

    # Alt+Y - paste previous
    bind '"\e[121;5u": yank-pop' 2>/dev/null
fi

# =============================================================================
# TERMINAL CONTROL
# =============================================================================

# Disable XON/XOFF flow control (free up Ctrl+S/Ctrl+Q)
[[ -t 0 ]] && stty -ixon 2>/dev/null

# Disable Ctrl+D from exiting shell
set -o ignoreeof 2>/dev/null

# =============================================================================
# HISTORY MANAGEMENT
# =============================================================================

# Write history after each command
if [[ -n "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND="${PROMPT_COMMAND}; history -a"
else
    PROMPT_COMMAND="history -a"
fi

# =============================================================================
# ADVANCED COMPLETION
# =============================================================================

# Enable bash completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion 2>/dev/null
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion 2>/dev/null
fi

# =============================================================================
# MISC IMPROVEMENTS
# =============================================================================

# Make less more friendly for non-text input
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)" 2>/dev/null

# Enable color support for ls
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Disable terminal flow control for applications
[[ -t 0 ]] && stty stop '' 2>/dev/null
[[ -t 0 ]] && stty start '' 2>/dev/null
