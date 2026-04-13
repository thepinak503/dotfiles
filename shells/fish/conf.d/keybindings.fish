function fish_user_key_bindings
    bind \e\[A history-search-backward
    bind \e\[B history-search-forward
    bind \e\[1\;5D backward-word
    bind \e\[1\;5C forward-word
    bind \e\[1\;3D backward-word
    bind \e\[1\;3C forward-word
    bind \e\[H beginning-of-line
    bind \e\[F end-of-line
    bind \e\x7f backward-kill-word
    bind \e\b backward-kill-word
    bind \e\[3\;3~ kill-word
    bind \ch backward-kill-word
    bind \e\[3\;5~ kill-word
    bind \cw backward-kill-word
    bind \ed kill-word
    bind \ck kill-line
    bind \cu backward-kill-line
    bind \cz undo
    bind \e\cz redo
    bind \cl 'clear; commandline -f repaint'
end
