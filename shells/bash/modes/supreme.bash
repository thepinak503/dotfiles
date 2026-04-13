#!/usr/bin/env bash
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="
        --height=60%
        --layout=reverse
        --border=rounded
        --preview-window=right:50%
        --bind='ctrl-f:page-down,ctrl-b:page-up,ctrl-u:half-page-up,ctrl-d:half-page-down'
        --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
        --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0,pointer:#ff6188'
    "
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f -not -path '*/\.*'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d -not -path '*/\.*'"
    if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
        source /usr/share/fzf/key-bindings.bash
    elif [[ -f /etc/fzf.bash ]]; then
        source /etc/fzf.bash
    fi
fi
if command -v bat &>/dev/null; then
    export BAT_THEME="TwoDark"
    export BAT_STYLE="numbers,changes,header"
fi
if command -v rg &>/dev/null; then
    export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi
if command -v eza &>/dev/null; then
    export EZA_ICONS_AUTO=1
fi
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dcu='docker-compose up -d'
    alias dcd='docker-compose down'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dprune='docker system prune -af --volumes'
    alias dclean='docker system prune -af --volumes'
    alias dnet='docker network ls'
    alias dvol='docker volume ls'
fi
if command -v kubectl &>/dev/null; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi
if command -v tmux &>/dev/null; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
    alias tn='tmux new-session -s'
fi
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:ignorespace
export HISTTIMEFORMAT="%F %T "
shopt -s autocd 2>/dev/null
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null
shopt -s dotglob 2>/dev/null
shopt -s cdspell 2>/dev/null
shopt -s checkwinsize 2>/dev/null
shopt -s histappend 2>/dev/null
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
[[ $- == *i* ]] && stty -ixon 2>/dev/null
