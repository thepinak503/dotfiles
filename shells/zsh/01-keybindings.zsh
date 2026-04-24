#!/usr/bin/env zsh
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word
bindkey '^[[3;3~' kill-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey '^k' kill-line
bindkey '^y' yank
bindkey '^_' undo
autoload -U select-word-style
select-word-style bash
