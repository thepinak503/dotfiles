#!/usr/bin/env bash
# Environment variables
export DOTFILES_DIR="$HOME/.local/share/dotfiles"
export DOTFILES_STATE_DIR="$HOME/.local/share/dotfiles"
[[ "$TERM" == "dumb" || -z "$TERM" ]] && export TERM=xterm-256color
export DOTFILES_MODE="${DOTFILES_MODE:-supreme}"
export PATH="$HOME/.cargo/bin:$PATH"
export LS_COLORS="di=34;42:ln=35;42:so=33;42:pi=33;42:ex=31;42:bd=34;43:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=30;42:or=30;41:mi=00;35:st=00;32:do=00;32"
