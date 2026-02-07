#!/usr/bin/env bash
# =============================================================================
# 09-SHELL-OPTIONS.SH - Bash Shell Options and Key Bindings
# Applies to ALL modes
# =============================================================================

# =============================================================================
# SHELL OPTIONS (shopt)
# =============================================================================

# Check window size after each command and update LINES/COLUMNS
shopt -s checkwinsize

# Append to history file, don't overwrite
shopt -s histappend

# Save multi-line commands as one entry
shopt -s cmdhist

# Autocorrect minor directory spelling errors
shopt -s cdspell

# Enable cd without typing 'cd'
shopt -s autocd

# Enable recursive globbing with **
shopt -s globstar 2>/dev/null

# Case insensitive globbing
shopt -s nocaseglob

# Include dotfiles in glob results
shopt -s dotglob 2>/dev/null

# Expand aliases
shopt -s expand_aliases

# Enable programmable completion
shopt -s progcomp

# Check command hash before executing
shopt -s checkhash

# =============================================================================
# KEY BINDINGS (readline)
# =============================================================================

# Enable case-insensitive tab completion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches immediately if ambiguous
bind "set show-all-if-ambiguous on"

# Display matches immediately if unmodified
bind "set show-all-if-unmodified on"

# Mark symlinked directories
bind "set mark-symlinked-directories on"

# Visible bell instead of beep
bind "set bell-style visible"

# Enable colored completion
bind "set colored-stats on"

# Enable colored completion prefix
bind "set colored-completion-prefix on"

# Skip completed text
bind "set skip-completed-text on"

# Menu complete (cycle through options with Tab)
bind "TAB: menu-complete"
bind "set menu-complete-display-prefix on"

# =============================================================================
# HISTORY NAVIGATION
# =============================================================================

# Up arrow - search backward in history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Page up/down - history search
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# Ctrl+P / Ctrl+N for history
bind '"\C-p": previous-history'
bind '"\C-n": next-history'

# =============================================================================
# CURSOR MOVEMENT
# =============================================================================

# Home / End keys
bind '"\e[H": beginning-of-line'
bind '"\e[F": end-of-line'
bind '"\e[OH": beginning-of-line'
bind '"\e[OF": end-of-line'

# Ctrl+Arrow for word movement
bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5A": previous-history'
bind '"\e[1;5B": next-history'

# Alt+Arrow for word movement
bind '"\e[1;3D": backward-word'
bind '"\e[1;3C": forward-word'
bind '"\e[1;3A": previous-history'
bind '"\e[1;3B": next-history'

# Ctrl+Home/End
bind '"\e[1;5H": beginning-of-line'
bind '"\e[1;5F": end-of-line'

# =============================================================================
# EDITING SHORTCUTS
# =============================================================================

# Ctrl+K - delete from cursor to end of line
bind '"\C-k": kill-line'

# Ctrl+U - delete from cursor to beginning of line
bind '"\C-u": backward-kill-line'

# Ctrl+W - delete word backward
bind '"\C-w": backward-kill-word'

# Alt+D - delete word forward
bind '"\e[3;3~": kill-word'

# Ctrl+A - beginning of line
bind '"\C-a": beginning-of-line'

# Ctrl+E - end of line
bind '"\C-e": end-of-line'

# Ctrl+Y - paste (yank)
bind '"\C-y": yank'

# Alt+Y - paste previous
bind '"\e[121;5u": yank-pop'

# =============================================================================
# TERMINAL CONTROL
# =============================================================================

# Disable XON/XOFF flow control (free up Ctrl+S/Ctrl+Q)
stty -ixon

# Disable Ctrl+D from exiting shell
set -o ignoreeof

# Enable extended globbing
shopt -s extglob 2>/dev/null

# =============================================================================
# HISTORY MANAGEMENT
# =============================================================================

# Write history after each command
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

# Sync history across terminals
history_sync() {
    history -a  # Append current session to history file
    history -c  # Clear current session history
    history -r  # Read history file
}

# Alias for manual sync
alias hsync='history_sync'

# =============================================================================
# DIRECTORY BOOKMARKS (for cdargs)
# =============================================================================

if command -v cv &>/dev/null; then
    alias cdb='cdargs'
fi

# =============================================================================
# ADVANCED COMPLETION
# =============================================================================

# Enable bash completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

# Load additional completions
if [[ -d /usr/share/bash-completion/completions ]]; then
    for file in /usr/share/bash-completion/completions/*; do
        [[ -r "$file" ]] && source "$file"
    done
fi

# =============================================================================
# MISC IMPROVEMENTS
# =============================================================================

# Make less more friendly for non-text input
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support for ls
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Disable terminal flow control for applications
stty stop ''
stty start ''
