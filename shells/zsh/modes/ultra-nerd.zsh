#!/usr/bin/env zsh
# =============================================================================
# ZSH MODE: ULTRA NERD
# =============================================================================
# Maximum visual density with Nerd Font icons, enhanced prompts, rich git
# integration, and comprehensive developer tooling. This mode assumes Nerd
# Font patched fonts are installed for maximum visual quality.
# =============================================================================

# =============================================================================
# FILE LISTING — Enhanced with Nerd Font Icons
# =============================================================================

# Primary: eza with icons (Nerd Font enhanced)
# Fallback: ls with colorized output

if command -v eza >/dev/null 2>&1; then
    lt() { eza -T --level=2 --icons=auto --group-directories-first "$@" 2>/dev/null || tree -L 2 "$@"; }
    lta() { eza -T --level=3 --icons=auto --group-directories-first -a "$@" 2>/dev/null || tree -L 3 -a "$@"; }
    lsf() { eza --icons=auto --group-directories-first --only-files "$@" 2>/dev/null || ls -p "$@"; }
    lsd() { eza --icons=auto --group-directories-first --only-dirs "$@" 2>/dev/null || ls -d */ "$@"; }
elif command -v exa >/dev/null 2>&1; then
    alias ls='exa --icons --group-directories-first'
    alias ll='exa -l --icons --group-directories-first --git'
    alias la='exa -a --icons --group-directories-first'
    alias lal='exa -la --icons --group-directories-first --git'
    alias lsl='exa -l --icons --group-directories-first'
    lt() { exa -T --level=2 --icons "$@"; }
fi

# =============================================================================
# DIRECTORY NAVIGATION — Quick Jump
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias desk='cd ~/Desktop'
alias pics='cd ~/Pictures'
alias vids='cd ~/Videos'
alias music='cd ~/Music'
alias projects='cd ~/Projects'
alias cfg='cd ~/.config'
alias dots='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"'
alias dev='cd ~/Projects'
alias tmp='cd /tmp'
alias root='cd /'
alias back='cd -'

# =============================================================================
# FILE MANAGERS
# =============================================================================

if command -v ranger >/dev/null 2>&1; then
    alias r='ranger'
    alias ranger='ranger'
fi

if command -v nnn >/dev/null 2>&1; then
    alias n='nnn'
    alias nnn='nnn'
fi

if command -v yazi >/dev/null 2>&1; then
    alias y='yazi'
    alias yazi='yazi'
fi

if command -v lf >/dev/null 2>&1; then
    alias lf='lf'
fi

# =============================================================================
# TEXT EDITORS — Nerd Font Enhanced
# =============================================================================

# Primary editor: neovim (if available)
if command -v nvim >/dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
    alias sv='sudo -E nvim'
    alias svim='sudo -E nvim'
    alias vimdiff='nvim -d'
    alias vimrc='nvim ~/.config/nvim/init.lua'
elif command -v vim >/dev/null 2>&1; then
    alias v='vim'
    alias vi='vim'
    alias sv='sudo vim'
    alias svim='sudo vim'
fi

# Standby editors
if command -v nano >/dev/null 2>&1; then
    alias nano='nano'
fi

if command -v micro >/dev/null 2>&1; then
    alias micro='micro'
fi

# =============================================================================
# GIT — Comprehensive Aliases with Nerd Font Icons
# =============================================================================

alias g='git'
alias gst='git status'
alias gstl='git status --long'
alias gss='git status --short'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias gpst='git push --tags'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gaa='git add --all'
alias ga='git add'
alias gap='git add -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --stat'
alias gl='git log --oneline --graph --decorate -20'
alias gla='git log --oneline --graph --decorate --all -20'
alias glg='git log --oneline --graph --decorate --all'
alias gstash='git stash'
alias gstashp='git stash pop'
alias gstashl='git stash list'
alias gstd='git stash drop'
alias gb='git branch'
alias gbr='git branch -r'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gmt='git mergetool'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gcp='git cherry-pick'
alias gbl='git blame'
alias gcl='git clone'
alias gclean='git clean -fd'
alias greset='git reset --hard'
alias gresets='git reset --soft'
alias gtags='git tag'
alias gsub='git submodule update --init --recursive'
alias gfixup='git commit --fixup'
alias gsquash='git rebase -i --autosquash'

# =============================================================================
# DOCKER — Container Management
# =============================================================================

if command -v docker >/dev/null 2>&1; then
    alias d='docker'
    alias dc='docker compose'
    alias docker-compose='docker compose'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dex='docker exec -it'
    alias dlog='docker logs -f'
    alias dlogt='docker logs -f --tail 50'
    alias dstop='docker stop $(docker ps -q) 2>/dev/null'
    alias drm='docker rm $(docker ps -aq) 2>/dev/null'
    alias drmi='docker rmi $(docker images -q) 2>/dev/null'
    alias dprune='docker system prune -af'
    alias dprunev='docker system prune -af --volumes'
    alias dtop='docker stats --no-stream'
    alias dinspect='docker inspect'
    alias dnetwork='docker network ls'
    alias dvolume='docker volume ls'
    alias dcurl='docker run --rm --network host curlimages/curl'
    alias dbash='docker exec -it $(docker ps -q | head -1) bash'
    alias dsh='docker exec -it $(docker ps -q | head -1) sh'
    alias dcompose='docker compose'
    alias dcps='docker compose ps'
    alias dcup='docker compose up -d'
    alias dcud='docker compose up -d'
    alias dcdown='docker compose down'
    alias dclogs='docker compose logs -f'
    alias dcstop='docker compose stop'
    alias dcstart='docker compose start'
    alias dcrestart='docker compose restart'
    alias dcbuild='docker compose build'
fi

# =============================================================================
# KUBERNETES — k8s Management
# =============================================================================

if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kg='kubectl get'
    alias kgp='kubectl get pods'
    alias kgd='kubectl get deployments'
    alias kgs='kubectl get services'
    alias kgn='kubectl get nodes'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias klf='kubectl logs -f'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
    alias kcn='kubectl config set-context --current --namespace'
    alias kexec='kubectl exec -it'
    alias kpf='kubectl port-forward'
    alias ktop='kubectl top pods'
    alias kctx='kubectx'
    alias kns='kubens'
fi

# =============================================================================
# HELM — Package Manager for Kubernetes
# =============================================================================

if command -v helm >/dev/null 2>&1; then
    alias helm='helm'
    alias hl='helm list'
    alias hls='helm list --all-namespaces'
    alias hui='helm upgrade --install'
    alias hst='helm status'
    alias hg='helm get'
    alias hr='helm rollback'
fi

# =============================================================================
# TMUX — Terminal Multiplexer
# =============================================================================

if command -v tmux >/dev/null 2>&1; then
    alias t='tmux'
    alias ta='tmux attach -t'
    alias tls='tmux list-sessions'
    alias tn='tmux new-session -s'
    alias tks='tmux kill-session -t'
    alias tksv='tmux kill-server'
    alias trn='tmux rename-session -t'
    alias tconf='$EDITOR ~/.config/tmux/tmux.conf'
fi

# =============================================================================
# FZF — Fuzzy Finder
# =============================================================================

if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border --info=inline --prompt='❯ ' --pointer='▶' --marker='✓'"
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .cache 2>/dev/null || find . -type f'
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules 2>/dev/null || find . -type d'

    # Preview file content using bat (if available) or cat
    if command -v bat >/dev/null 2>&1; then
        export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    elif command -v batcat >/dev/null 2>&1; then
        export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :500 {}'"
    else
        export FZF_CTRL_T_OPTS="--preview 'cat {}'"
    fi
    export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {} | head -50'"
fi

# =============================================================================
# NETWORK UTILITIES
# =============================================================================

alias ports='netstat -tulanp 2>/dev/null || ss -tuln'
alias ipl='ip -br link 2>/dev/null || ifconfig 2>/dev/null'
alias ipa='ip -br addr 2>/dev/null || ifconfig 2>/dev/null'
alias ipr='ip route 2>/dev/null || netstat -rn 2>/dev/null'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias tracepath='tracepath -n 2>/dev/null || traceroute -n'
alias myip='curl -s ifconfig.me 2>/dev/null || curl -s icanhazip.com 2>/dev/null || wget -qO- ifconfig.me 2>/dev/null'
alias myipl='ip -br addr show scope global 2>/dev/null | awk "{print \$1, \$3}"'
alias dnslookup='nslookup'
alias dig='dig +short'
alias whois='whois'
alias nmapfast='nmap -T4 -F'

# =============================================================================
# SYSTEM INFORMATION
# =============================================================================

alias cpuinfo='lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string 2>/dev/null'
alias meminfo='free -h 2>/dev/null || vm_stat 2>/dev/null'
alias diskinfo='df -h 2>/dev/null'
alias diskinfoi='df -h -i 2>/dev/null'
alias diskusage='du -sh * 2>/dev/null'
alias diskusagea='du -sh .[!.]* * 2>/dev/null | sort -rh'
alias psinfo='ps auxf 2>/dev/null'
alias psg='ps aux | grep -v grep | grep -i'
alias update='bash ~/.local/share/dotfiles/bin/sysupdate.sh'
alias cleanup='bash ~/.local/share/dotfiles/bin/syscleanup.sh'
alias journal='journalctl -xe --no-pager -n 50 2>/dev/null || log show --last 1h 2>/dev/null'
alias jf='journalctl -f 2>/dev/null'
alias ju='journalctl -u 2>/dev/null'
alias sysinfo='fastfetch 2>/dev/null || neofetch 2>/dev/null || screenfetch 2>/dev/null'
alias kernel='uname -a'
alias osrel='cat /etc/os-release 2>/dev/null | head -5'
alias uptime='uptime'
alias dateinfo='date "+%Y-%m-%d %H:%M:%S %Z"'
alias calendar='cal -3'
alias calyear='cal -y'

# =============================================================================
# DATE & TIME
# =============================================================================

alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias nowdatetime='date +"%Y-%m-%d %H:%M:%S"'
alias nowepoch='date +%s'
alias timestamp='date +%s'
alias path='echo $PATH | tr ":" "\n" | nl'

# =============================================================================
# HISTORY
# =============================================================================

alias h='history'
alias hg='history | grep'
alias h10='history 10'
alias h20='history 20'
alias h50='history 50'
alias hstat='history -l 1 | awk "{CMD[\$2]++;count++;} END {for (a in CMD) print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}" | grep -v "./" | column -c3 -s " " | sort -rn | nl | head -20'

# =============================================================================
# DOTFILES & CONFIG RELOADING
# =============================================================================

alias bconf='$EDITOR ~/.zshrc'
alias szrc='source ~/.zshrc'
alias reload='source ~/.zshrc'
alias zshrc='$EDITOR ~/.zshrc'
alias zprofile='$EDITOR ~/.zprofile'
alias dotup='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" && git pull && cd -'
alias dotstatus='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" && git status && cd -'
alias dotlog='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" && git log --oneline -10 && cd -'
alias reexec='exec zsh'

# =============================================================================
# STARSHIP PROMPT — Cross-platform Detection
# =============================================================================

if command -v starship >/dev/null 2>&1; then
    if [[ "$(uname)" == "Darwin" ]]; then
        export STARSHIP_CONFIG="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}/apps/starship-linux.toml"
    fi
fi

# =============================================================================
# ZOXIDE — Smart Directory Jumping
# =============================================================================

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# ATUIN — Shell History with Search
# =============================================================================

if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

# =============================================================================
# HISTORY SETTINGS
# =============================================================================

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="ls:ll:la:lal:cd:pwd:exit:clear:history:h"

# =============================================================================
# SHELL OPTIONS
# =============================================================================

setopt AUTO_CD
setopt CD_SILENT
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt GLOB_COMPLETE
setopt GLOB_DOTS
setopt HASH_LISTALL
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_NO_STORE
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt MENU_COMPLETE
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt CORRECT
setopt CORRECT_ALL
setopt NUMERIC_GLOB_SORT
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

# =============================================================================
# DOTFILES SYNC FUNCTION
# =============================================================================

dot_sync() {
  local repo_root="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
  if [[ -z "$repo_root" || ! -d "$repo_root/.git" ]]; then
    echo "Dotfiles repo not found at: $repo_root"
    return 1
  fi
  echo "⟳ Syncing dotfiles in $repo_root..."
  git -C "$repo_root" fetch --all --prune
  git -C "$repo_root" pull --rebase --autostash || git -C "$repo_root" pull --ff-only
  echo "✓ Dotfiles synced successfully"
}
alias dsync='dot_sync'

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Create a directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives based on extension
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.xz)        unxz "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Search for files by name
ff() {
    find . -type f -name "*$1*" 2>/dev/null
}

# Search for directories by name
fd() {
    find . -type d -name "*$1*" 2>/dev/null
}

# Find and replace in files
freplace() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: freplace <file_pattern> <old_string> <new_string>"
        return 1
    fi
    find . -type f -name "$1" -exec sed -i "s/$2/$3/g" {} +
}

# Process tree
ptree() {
    ps auxf | grep -v grep | grep -i "$1"
}

# Weather info
weather() {
    local city="${1:-}"
    if [[ -n "$city" ]]; then
        curl -s "wttr.in/$city" 2>/dev/null || echo "Weather service unavailable"
    else
        curl -s "wttr.in" 2>/dev/null || echo "Weather service unavailable"
    fi
}

# Generate a random password
genpass() {
    local len="${1:-32}"
    openssl rand -base64 48 | tr -d '+/=' | cut -c1-"$len"
}

# SSL certificate info
sslinfo() {
    if [[ -z "$1" ]]; then
        echo "Usage: sslinfo <hostname> [port]"
        return 1
    fi
    local host="$1"
    local port="${2:-443}"
    echo | openssl s_client -connect "${host}:${port}" -servername "${host}" 2>/dev/null | openssl x509 -noout -dates -subject -issuer 2>/dev/null
}

# Network scan
netscan() {
    local subnet="${1:-192.168.1.0/24}"
    echo "Scanning $subnet..."
    if command -v nmap >/dev/null 2>&1; then
        nmap -sn "$subnet" 2>/dev/null | grep "Nmap scan" | awk '{print $5, $6}'
    else
        echo "nmap not installed"
    fi
}

# Kill process by name
killp() {
    pkill -f "$1" 2>/dev/null && echo "✓ Killed processes matching: $1" || echo "No processes found matching: $1"
}

# Count files in directory
countf() {
    local dir="${1:-.}"
    echo "Files: $(find "$dir" -type f 2>/dev/null | wc -l)"
    echo "Dirs:  $(find "$dir" -type d 2>/dev/null | wc -l)"
}

# Display directory tree
treev() {
    local dir="${1:-.}"
    local depth="${2:-2}"
    if command -v eza >/dev/null 2>&1; then
        eza -T --level="$depth" --icons=auto "$dir"
    elif command -v tree >/dev/null 2>&1; then
        tree -L "$depth" --dirsfirst "$dir"
    else
        find "$dir" -maxdepth "$depth" | sed 's|[^/]*/|- |g'
    fi
}

# =============================================================================
# ULTIMATE CINEMATIC FEATURES
# =============================================================================

# 1. Auto-LS on Directory Change
# Every time you cd, automatically list the contents of the directory gorgeously.
function chpwd() {
    echo "" # Add a breathing space before listing
    if command -v eza >/dev/null 2>&1; then
        eza --icons=auto --group-directories-first
    elif command -v exa >/dev/null 2>&1; then
        exa --icons
    else
        ls --color=auto 2>/dev/null || ls -G
    fi
    echo "" # Add a breathing space after listing
}

# 2. Interactive Process Killer (fkill)
# Searches processes with FZF and kills the selected one(s).
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m --prompt="Kill> " | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m --prompt="Kill> " | awk '{print $2}')
    fi
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
        echo "💀 Killed process: $pid"
    fi
}

# 3. Interactive Git Branch Switcher (fgbr)
# Switch git branches instantly using FZF
fgbr() {
    local branches branch
    branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzf --prompt="Checkout branch> " | sed "s/.* //" | sed "s#remotes/[^/]*/##") &&
    git checkout "$branch"
}

# 4. OS-Aware File Copier
# Copies a file's contents to the clipboard instantly on ANY OS
cpfile() {
    if [ -z "$1" ]; then
        echo "Usage: cpfile <filename>"
        return 1
    fi
    if command -v wl-copy >/dev/null 2>&1; then
        cat "$1" | wl-copy && echo "📋 Copied $1 to Wayland clipboard!"
    elif command -v xclip >/dev/null 2>&1; then
        cat "$1" | xclip -sel clip && echo "📋 Copied $1 to X11 clipboard!"
    elif command -v pbcopy >/dev/null 2>&1; then
        cat "$1" | pbcopy && echo "📋 Copied $1 to macOS clipboard!"
    else
        echo "❌ No clipboard utility found (wl-copy, xclip, pbcopy)."
    fi
}

# 5. Yazi with cwd-on-exit (y)
# The best file manager experience. When you exit Yazi, your terminal instantly follows.
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# 6. Ultimate Extractor (x)
# Extracts ANY archive format instantly without needing to remember the flag.
function x() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.tar.zst)   tar --zstd -xf "$1" ;;
            *.zst)       unzstd "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# 7. Instant Cheatsheets (cheat)
# Fetches code snippets from cht.sh via curl and bats them!
function cheat() {
    if [ -z "$1" ]; then
        echo "Usage: cheat <language> <query>"
        return 1
    fi
    curl -s "cht.sh/$1/$2" | bat --style=plain --language="$1"
}

# 8. Instant Weather (weather)
function weather() {
    curl -s "wttr.in/${1:-}?m"
}
