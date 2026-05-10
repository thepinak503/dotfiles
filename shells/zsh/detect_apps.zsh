#!/usr/bin/env zsh
_detect_app() { command -v "$1" >/dev/null 2>&1; }

if _detect_app nvim; then
    export EDITOR='nvim'
    export VISUAL='nvim'
elif _detect_app vim; then
    export EDITOR='vim'
    export VISUAL='vim'
fi

if _detect_app fzf; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

if _detect_app zoxide; then
    eval "$(zoxide init zsh)"
fi

if _detect_app atuin; then
    eval "$(atuin init zsh)"
fi

[[ -f /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh noprompt quiet
