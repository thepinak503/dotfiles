#!/usr/bin/env bash
# =============================================================================
# MODE: BASIC - Minimal, lightweight configuration
# Safe for SSH sessions and resource-constrained environments
# =============================================================================

# Basic prompt (PS1)
if [[ -z "$STARSHIP_CONFIG" ]] && ! command -v starship &>/dev/null; then
    PS1='\[\033[0;32m\]\u@\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '
fi

# Minimal history settings
export HISTSIZE=1000
export HISTFILESIZE=1000

# Basic ls colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Basic aliases (override any that might cause issues in minimal mode)
alias ll='ls -l'
alias la='ls -la'
alias ..='cd ..'
