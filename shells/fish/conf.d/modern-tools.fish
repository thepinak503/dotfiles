#!/usr/bin/env fish
# =============================================================================
# FISH MODERN TOOLS INTEGRATION
# =============================================================================

# =============================================================================
# FZF
# =============================================================================

if command -v fzf >/dev/null 2>&1
    # Advanced fzf functions
    
    function fbr
        set -l branch (git branch -vv | fzf --height=20 --reverse +m)
        if test -n "$branch"
            git checkout (echo "$branch" | awk '{print $1}' | sed "s/.* //")
        end
    end
    
    function fshow
        git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" |
        fzf --ansi --no-sort --reverse --tiebreak=index \
            --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R'"
    end
    
    function fenv
        printenv | fzf --preview 'echo {}' --preview-window=down:3:wrap
    end
    
    function fhist
        set -l cmd (history | fzf --tac +s | sed 's/^[ ]*[0-9]*[ ]*//')
        if test -n "$cmd"
            echo "$cmd"
            eval "$cmd"
        end
    end
end

# =============================================================================
# ZOXIDE
# =============================================================================

if command -v zoxide >/dev/null 2>&1
    # zoxide is initialized in config.fish
    # Additional aliases
    abbr -a z 'zoxide'
    abbr -a zi 'zoxide -i'
    abbr -a za 'zoxide add'
    abbr -a zq 'zoxide query'
    abbr -a zr 'zoxide remove'
end

# =============================================================================
# EZA / EXA
# =============================================================================

if command -v eza >/dev/null 2>&1
    # Main ls replacement
    alias ls='eza --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
    alias ltt='eza --tree --level=3 --icons'
    alias ltl='eza --tree --level=2 --long --icons'
    alias ltg='eza --tree --level=2 --git --icons'
    alias lsize='eza -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons'
    alias lold='eza -la --sort=modified --icons'
    alias lext='eza -la --sort=extension --icons'
    alias lname='eza -la --sort=name --icons'
    alias l.='eza -d --icons .*'
    alias l1='eza -1 --icons'
else if command -v exa >/dev/null 2>&1
    alias ls='exa --group-directories-first --icons'
    alias l='exa -la --group-directories-first --icons'
    alias la='exa -a --group-directories-first --icons'
    alias ll='exa -l --group-directories-first --icons'
    alias lt='exa --tree --level=2 --icons'
end

# =============================================================================
# BAT
# =============================================================================

if command -v bat >/dev/null 2>&1
    alias cat='bat --style=header,grid'
    alias catp='bat --style=plain --paging=never'
    alias catl='bat --style=header,grid --paging=always'
    alias catn='bat --style=numbers'
    
    # Export for man pages
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MANROFFOPT "-c"
else if command -v batcat >/dev/null 2>&1
    alias cat='batcat --style=header,grid'
    alias bat='batcat'
end

# =============================================================================
# RIPGREP
# =============================================================================

if command -v rg >/dev/null 2>&1
    alias grep='rg --color=always'
    alias rgi='rg -i'
    alias rgv='rg -v'
    alias rgf='rg -F'
    alias rgw='rg -w'
    alias rgc='rg -c'
    alias rgl='rg -l'
    alias rgno='rg --no-heading'
    alias rgn='rg -n'
    
    # File type shortcuts
    alias rgpy='rg -t py'
    alias rgjs='rg -t js'
    alias rgjsts='rg -t js -t ts'
    alias rgmd='rg -t md'
    alias rgrs='rg -t rust'
    alias rggo='rg -t go'
end

# =============================================================================
# FD
# =============================================================================

if command -v fd >/dev/null 2>&1
    alias find='fd'
    alias ff='fd --type f'
    alias fdir='fd --type d'
    alias fhidden='fd --hidden'
    alias ffi='fd -i'
    alias fabs='fd --absolute-path'
    alias ffollow='fd --follow'
    
    # Extensions
    alias fpy='fd -e py'
    alias fjs='fd -e js'
    alias fts='fd -e ts'
    alias frs='fd -e rs'
    alias fmd='fd -e md'
end

# =============================================================================
# DUST
# =============================================================================

if command -v dust >/dev/null 2>&1
    alias du='dust'
    alias du.='dust -d 1'
    alias du1='dust -d 1'
    alias du2='dust -d 2'
    alias du3='dust -d 3'
end

# =============================================================================
# BTOP
# =============================================================================

if command -v btop >/dev/null 2>&1
    alias top='btop'
    alias htop='btop'
end

# =============================================================================
# FASTFETCH / NEOFETCH
# =============================================================================

if command -v fastfetch >/dev/null 2>&1
    alias sysinfo='fastfetch'
else if command -v neofetch >/dev/null 2>&1
    alias sysinfo='neofetch'
end
