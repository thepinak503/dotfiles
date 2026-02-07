#!/usr/bin/env bash
# =============================================================================
# 10-PROMPT.SH - Prompt Configuration (Starship + Fallbacks)
# Applies to ALL modes
# =============================================================================

# =============================================================================
# STARSHIP PROMPT (Preferred)
# =============================================================================

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
    
    # Starship presets
    alias starship-minimal='starship preset plain-text-symbol -o ~/.config/starship.toml && echo "Starship set to minimal mode"'
    alias starship-nerd='starship preset nerd-font-symbols -o ~/.config/starship.toml && echo "Starship set to nerd mode"'
    alias starship-bubbles='starship preset bracketed-segments -o ~/.config/starship.toml && echo "Starship set to bubbles mode"'
    
    # Return early - Starship handles the prompt
    return 0
fi

# =============================================================================
# FALLBACK: POWERLINE-STYLE PROMPT (if available)
# =============================================================================

if [[ "$DOTFILES_MODE" != "basic" ]] && command -v powerline-shell &>/dev/null; then
    function _update_ps1() {
        PS1=$(powerline-shell $? 2>/dev/null)
    }
    
    if [[ "$TERM" != "linux" ]] && [[ -f "$HOME/.config/powerline-shell/config.json" ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        return 0
    fi
fi

# =============================================================================
# FALLBACK: CUSTOM ADVANCED PROMPT
# =============================================================================

# Colors
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    reset='\[\e[0m\]'
    bold='\[\e[1m\]'
    underline='\[\e[4m\]'
    
    # Normal colors
    black='\[\e[0;30m\]'
    red='\[\e[0;31m\]'
    green='\[\e[0;32m\]'
    yellow='\[\e[0;33m\]'
    blue='\[\e[0;34m\]'
    purple='\[\e[0;35m\]'
    cyan='\[\e[0;36m\]'
    white='\[\e[0;37m\]'
    
    # Bright colors
    bblack='\[\e[1;30m\]'
    bred='\[\e[1;31m\]'
    bgreen='\[\e[1;32m\]'
    byellow='\[\e[1;33m\]'
    bblue='\[\e[1;34m\]'
    bpurple='\[\e[1;35m\]'
    bcyan='\[\e[1;36m\]'
    bwhite='\[\e[1;37m\]'
else
    reset=''
    bold=''
    black=''
    red=''
    green=''
    yellow=''
    blue=''
    purple=''
    cyan=''
    white=''
    bblack=''
    bred=''
    bgreen=''
    byellow=''
    bblue=''
    bpurple=''
    bcyan=''
    bwhite=''
fi

# Git prompt function
__git_prompt() {
    local git_status=''
    local branch=''
    
    # Check if in git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get branch name
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        
        # Get status
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            git_status="${yellow}✗${reset}"  # Uncommitted changes
        else
            git_status="${green}✓${reset}"   # Clean
        fi
        
        echo " (${git_status} ${cyan}${branch}${reset})"
    fi
}

# Virtual environment prompt
__venv_prompt() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        echo " [${purple}${venv_name}${reset}]"
    fi
}

# Exit status indicator
__exit_status() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "${red}✗${exit_code}${reset} "
    else
        echo "${green}✓${reset} "
    fi
}

# Build prompt based on mode
case "$DOTFILES_MODE" in
    "basic")
        # Simple prompt
        PS1='\u@\h:\w\$ '
        ;;
    
    "advanced"|"ultra-nerd")
        # Advanced prompt with git and status
        __set_custom_prompt() {
            local exit_code=$?
            local status_indicator
            
            if [[ $exit_code -eq 0 ]]; then
                status_indicator="${green}➜${reset}"
            else
                status_indicator="${red}➜${exit_code}${reset}"
            fi
            
            PS1="${bold}${blue}\u${reset}@${bold}${cyan}\h${reset} "
            PS1+="${yellow}\w${reset}"
            PS1+="$(__git_prompt)"
            PS1+="$(__venv_prompt)"
            PS1+="\n${status_indicator} "
        }
        
        PROMPT_COMMAND='__set_custom_prompt'
        ;;
    
    *)
        # Default
        PS1='\u@\h:\w\$ '
        ;;
esac

# Secondary prompt
PS2='> '

# Continuation prompt
PS4='+ '
