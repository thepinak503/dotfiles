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

if _detect_app starship
    starship init fish --print-full-init | source
end

if _detect_app fastfetch
    fastfetch -c ~/.config/fastfetch/config.jsonc 2>/dev/null
end

if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish noprompt quiet
end