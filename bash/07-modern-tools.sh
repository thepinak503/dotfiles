#!/usr/bin/env bash
# =============================================================================
# 07-MODERN-TOOLS.SH - Modern CLI Tool Integration
# Modes: advanced, ultra-nerd
# =============================================================================

[[ "$DOTFILES_MODE" == "basic" ]] && return

# =============================================================================
# FZF (Fuzzy Finder) INTEGRATION
# =============================================================================

if command -v fzf &>/dev/null; then
    # Source fzf completions and key bindings (bash only)
    if [[ -n "$BASH_VERSION" ]]; then
        [[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash 2>/dev/null
        [[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash 2>/dev/null
        [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]] && source /usr/share/doc/fzf/examples/key-bindings.bash 2>/dev/null
        [[ -f /usr/share/doc/fzf/examples/completion.bash ]] && source /usr/share/doc/fzf/examples/completion.bash 2>/dev/null
        [[ -f ~/.fzf.bash ]] && source ~/.fzf.bash 2>/dev/null
    fi

    # Advanced fzf functions

    # Interactive cd
    fcd() {
        local dir
        dir=$(find "${1:-.}" -type d -not -path '*/.*' 2>/dev/null | fzf --preview 'tree -C {} | head -20') && cd "$dir"
    }

    # Interactive file edit
    fe() {
        local files
        IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --preview 'bat --style=numbers --color=always --line-range :500 {}'))
        [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
    }

    # Interactive kill
    fkill() {
        local pid
        pid=$(ps -ef | sed 1d | fzf --multi --header='[kill process]' | awk '{print $2}')
        [[ -n "$pid" ]] && echo "$pid" | xargs kill -${1:-9}
    }

    # Git branch checkout
    fbr() {
        local branches branch
        branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf --height=20 --reverse +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    }

    # Git commit browser
    fshow() {
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
    }

    # Environment variable viewer
    fenv() {
        printenv | fzf --preview 'echo {}' --preview-window=down:3:wrap
    }

    # History search
    fhist() {
        local cmd
        cmd=$(history | fzf --tac +s --query="$1" | sed 's/^[ ]*[0-9]*[ ]*//')
        [[ -n "$cmd" ]] && echo "$cmd" && eval "$cmd"
    }
fi

# =============================================================================
# ZOXIDE (Smarter cd)
# =============================================================================

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"

    # Aliases for zoxide
    alias z='__zoxide_z'
    alias zi='__zoxide_zi'
    alias za='zoxide add'
    alias zq='zoxide query'
    alias zr='zoxide remove'
    alias zl='zoxide list'

    # Keep cd as z
    alias cd='z'
fi

# =============================================================================
# EZA / EXA (Modern ls)
# =============================================================================

if command -v eza &>/dev/null; then
    # Main ls replacement
    alias ls='eza --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'

    # Advanced eza features
    alias lt='eza --tree --level=2 --icons'
    alias ltt='eza --tree --level=3 --icons'
    alias ltl='eza --tree --level=2 --long --icons'
    alias ltg='eza --tree --level=2 --git --icons'

    # Sorting
    alias lsize='eza -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons'
    alias lold='eza -la --sort=modified --icons'
    alias lext='eza -la --sort=extension --icons'
    alias lname='eza -la --sort=name --icons'

    # Git integration
    alias lg='eza -la --git --icons'
    alias lgi='eza -la --git-ignore --icons'

    # Hidden files
    alias l.='eza -d --icons .*'
    alias lah='eza -la --icons'

    # One column
    alias l1='eza -1 --icons'

elif command -v exa &>/dev/null; then
    # Fallback to exa
    alias ls='exa --group-directories-first --icons'
    alias l='exa -la --group-directories-first --icons'
    alias la='exa -a --group-directories-first --icons'
    alias ll='exa -l --group-directories-first --icons'
    alias lt='exa --tree --level=2 --icons'
    alias ltt='exa --tree --level=3 --icons'
fi

# =============================================================================
# BAT (Cat with syntax highlighting)
# =============================================================================

if command -v bat &>/dev/null; then
    # Main cat replacement
    alias cat='bat --style=header,grid'

    # Plain mode for scripts
    alias catp='bat --style=plain --paging=never'

    # With paging
    alias catl='bat --style=header,grid --paging=always'

    # Numbers only
    alias catn='bat --style=numbers'

    # Diff mode
    alias batdiff='bat --diff'

    # Man pages with bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"

    # Note: --help alias removed (zsh-specific syntax not compatible with bash)

elif command -v batcat &>/dev/null; then
    # Debian/Ubuntu alternative name
    alias cat='batcat --style=header,grid'
    alias catp='batcat --style=plain --paging=never'
    alias catl='batcat --style=header,grid --paging=always'
    alias catn='batcat --style=numbers'
    alias bat='batcat'
fi

# =============================================================================
# RIPGREP (rg) - Fast grep replacement
# =============================================================================

if command -v rg &>/dev/null; then
    # Main grep replacement
    alias grep='rg --color=always'

    # Common options
    alias rgi='rg -i'
    alias rgv='rg -v'
    alias rgf='rg -F'
    alias rgw='rg -w'
    alias rgc='rg -c'
    alias rgl='rg -l'
    alias rgu='rg -u'
    alias rgff='rg --files-with-matches'
    alias rgno='rg --no-heading'
    alias rgn='rg -n'

    # Specific file types
    alias rgpy='rg -t py'
    alias rgjs='rg -t js'
    alias rgjsts='rg -t js -t ts'
    alias rgmd='rg -t md'
    alias rgrs='rg -t rust'
    alias rggo='rg -t go'
    alias rgc='rg -t c -t cpp'
    alias rgjava='rg -t java'
    alias rgphp='rg -t php'
    alias rgrb='rg -t rb'
    alias rghs='rg -t hs'
fi

# =============================================================================
# FD (Find replacement)
# =============================================================================

if command -v fd &>/dev/null; then
    # Main find replacement
    alias find='fd'

    # Files only
    alias ff='fd --type f'
    alias ffind='fd --type f'

    # Directories only
    alias fdir='fd --type d'

    # Hidden files
    alias fhidden='fd --hidden'

    # Case insensitive
    alias ffi='fd -i'

    # Absolute path
    alias fabs='fd --absolute-path'

    # Follow symlinks
    alias ffollow='fd --follow'

    # Execute command
    alias fexec='fd --exec'

    # Specific extensions
    alias fpy='fd -e py'
    alias fjs='fd -e js'
    alias fts='fd -e ts'
    alias frs='fd -e rs'
    alias fmd='fd -e md'
    alias flog='fd -e log'
fi

# =============================================================================
# DUST (du replacement)
# =============================================================================

if command -v dust &>/dev/null; then
    # Main du replacement
    alias du='dust'
    alias du.='dust -d 1'
    alias du1='dust -d 1'
    alias du2='dust -d 2'
    alias du3='dust -d 3'
    alias dusort='dust -r'
fi

# =============================================================================
# BTOP / BTOP++ (Resource monitor)
# =============================================================================

if command -v btop &>/dev/null; then
    alias top='btop'
    alias htop='btop'
elif command -v bpytop &>/dev/null; then
    alias top='bpytop'
    alias htop='bpytop'
fi

# =============================================================================
# DELTA (Git diff viewer)
# =============================================================================

if command -v delta &>/dev/null; then
    # Configure git to use delta
    git config --global core.pager delta 2>/dev/null || true
    git config --global interactive.diffFilter 'delta --color-only' 2>/dev/null || true
    git config --global delta.navigate true 2>/dev/null || true
    git config --global delta.light false 2>/dev/null || true
    git config --global merge.conflictStyle diff3 2>/dev/null || true
    git config --global diff.colorMoved default 2>/dev/null || true
fi

# =============================================================================
# THEFUCK (Command correction)
# =============================================================================

if command -v thefuck &>/dev/null; then
    eval "$(thefuck --alias)"
    eval "$(thefuck --alias fk)"
fi

# =============================================================================
# AUTOJUMP / Z (Legacy support)
# =============================================================================

if [[ -f /usr/share/autojump/autojump.bash ]]; then
    source /usr/share/autojump/autojump.bash
elif [[ -f /usr/share/autojump/autojump.sh ]]; then
    source /usr/share/autojump/autojump.sh
fi
