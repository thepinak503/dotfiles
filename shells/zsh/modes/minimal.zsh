#!/usr/bin/env zsh
# v1.0 - All modes now source the unified ultimate config
# For backwards compatibility with old $DOTFILES_STATE_DIR/mode files
[[ -f "$DOTFILES_DIR/shells/zsh/modes/ultimate.zsh" ]] && source "$DOTFILES_DIR/shells/zsh/modes/ultimate.zsh"
