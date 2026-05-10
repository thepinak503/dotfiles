#!/usr/bin/env fish
function _detect_app
    type -q $argv[1]
end

if _detect_app nvim
    set -gx EDITOR 'nvim'
    set -gx VISUAL 'nvim'
end

if _detect_app fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

if _detect_app zoxide
    zoxide init fish | source
end

if _detect_app atuin
    atuin init fish | source
end
