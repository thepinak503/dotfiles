#!/bin/bash
# File Managers Configuration
# Ranger, nnn, lf, broot

# =============================================================================
# RANGER
# =============================================================================

if command -v ranger &>/dev/null; then
    export RANGER_LOAD_DEFAULT_RC=FALSE
    
    # Ranger aliases
    alias r='ranger'
    alias rc='ranger --clean'
    alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
fi

# =============================================================================
# NNN (N³ - THE MISSING TERMINAL FILE MANAGER)
# =============================================================================

if command -v nnn &>/dev/null; then
    # nnn configuration
    export NNN_OPTS="eHEx"
    export NNN_OPENER="xdg-open"
    export NNN_BMS="d:~/Documents;D:~/Downloads;p:~/Pictures;v:~/Videos;m:~/Music;c:~/.config;g:~/git"
    export NNN_PLUG="f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview"
    export NNN_USE_EDITOR=1
    export NNN_COLORS="#0a1b2c3d4e5f6789"
    export NNN_FCOLORS="c1e2272e006033f7c6d6abc4"
    export NNN_TRASH=1
    
    # nnn aliases
    alias n='nnn'
    alias nnn='nnn -e'
    
    # nnn cd on quit function
    n() {
        # Block nesting of nnn in subshells
        if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
            echo "nnn is already running"
            return
        fi
        
        # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
        # To cd on quit only on ^G, remove the "export" as in:
        #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        # NOTE: NNN_TMPFILE is fixed, should not be modified
        export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        
        # Unmask ^Q (if required, see `stty -a`) to Quit nnn
        # stty start undef
        # stty stop undef
        # stty lwrap undef
        # stty lnext undef
        
        nnn "$@"
        
        if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
        fi
    }
fi

# =============================================================================
# LF (LIST FILES)
# =============================================================================

if command -v lf &>/dev/null; then
    # lf aliases
    alias lf='lfcd'
    
    # lf cd on quit
    lfcd () {
        tmp="$(mktemp)"
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp"
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    }
fi

# =============================================================================
# BROOT
# =============================================================================

if command -v broot &>/dev/null; then
    # Source broot br function
    source ~/.config/broot/launcher/bash/br 2>/dev/null || true
    
    # broot aliases
    alias br='broot'
    alias bs='broot --sizes'
    alias bd='broot --dates'
    alias bc='broot --only-folders'
fi

# =============================================================================
# FZF FILE MANAGER MODE
# =============================================================================

# FZF file manager shortcuts
alias fzfcd='cd $(find . -type d -not -path "*/\.*" | fzf)'
alias fzfvim='vim $(fzf)'
alias fzfcode='code $(fzf)'

# Interactive file selection
fselect() {
    find . -type f -not -path "*/\.*" | fzf --preview 'bat --color=always {}' --preview-window='right:60%:wrap'
}

# Interactive directory selection with tree preview
fdselect() {
    find . -type d -not -path "*/\.*" | fzf --preview 'tree -C {} | head -50' --preview-window='right:60%:wrap'
}

# =============================================================================
# FUCTIONS
# =============================================================================

# Quick file manager launcher
fm() {
    # Prefer nnn, fallback to ranger, then lf
    if command -v nnn &>/dev/null; then
        n
    elif command -v ranger &>/dev/null; then
        ranger
    elif command -v lf &>/dev/null; then
        lfcd
    else
        echo "No file manager installed. Install nnn, ranger, or lf."
    fi
}

# Show directory tree with optional depth
treed() {
    local depth="${1:-3}"
    tree -d -L "$depth"
}

# Show directory sizes sorted
dusort() {
    du -sh * 2>/dev/null | sort -rh | head -20
}

# Find and delete empty directories
rmempty() {
    find . -type d -empty -delete
    echo "Empty directories removed"
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *.deb)       ar x "$1"      ;;
            *.tar.xz)    tar xf "$1"    ;;
            *.tar.zst)   unzstd "$1"    ;;
            *)           echo "Unknown archive format: '$1'" ;;
        esac
    else
        echo "'\$1' is not a valid file"
    fi
}