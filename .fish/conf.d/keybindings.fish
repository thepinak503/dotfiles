# =============================================================================
# FISH KEYBINDINGS
# Custom keyboard shortcuts for a more productive shell
# =============================================================================

function fish_user_key_bindings
    # History search
    bind \e\[A history-search-backward
    bind \e\[B history-search-forward
    
    # Word movement (Ctrl + Arrow)
    bind \e\[1\;5D backward-word
    bind \e\[1\;5C forward-word
    
    # Word movement (Alt + Arrow)
    bind \e\[1\;3D backward-word
    bind \e\[1\;3C forward-word
    
    # Home / End
    bind \e\[H beginning-of-line
    bind \e\[F end-of-line
    
    # Word manipulation
    # Alt + Backspace
    bind \e\x7f backward-kill-word
    bind \e\b backward-kill-word
    
    # Alt + Delete
    bind \e\[3\;3~ kill-word
    
    # Ctrl + Backspace
    bind \ch backward-kill-word
    
    # Ctrl + Delete
    bind \e\[3\;5~ kill-word
    
    # Ctrl + W (Delete word backward)
    bind \cw backward-kill-word
    
    # Alt + D (Delete word forward)
    bind \ed kill-word
    
    # Ctrl + K (Delete to end of line)
    bind \ck kill-line
    
    # Ctrl + U (Delete to beginning of line)
    bind \cu backward-kill-line
    
    # Undo / Redo
    bind \cz undo
    bind \e\cz redo
    
    # Clear screen
    bind \cl 'clear; commandline -f repaint'
end
