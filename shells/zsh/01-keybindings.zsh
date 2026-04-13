#!/usr/bin/env zsh
# =============================================================================
# ZSH KEYBINDINGS
# Bash-like keybindings for Zsh
# =============================================================================

# Emacs-like keybindings (default)
bindkey -e

# History navigation
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# Line movement
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Word movement (Ctrl + Arrow)
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Word movement (Alt + Arrow)
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# Word manipulation
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word
bindkey '^[[3;3~' kill-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Standard bash-like
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey '^k' kill-line
bindkey '^y' yank

# Undo
bindkey '^_' undo

# Word style
autoload -U select-word-style
select-word-style bash
