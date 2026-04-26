#!/usr/bin/env sh
# =============================================================================
# Dynamic App Detection - Detects installed apps and provides their aliases/functions
# Sourced by all shells - errors are ignored for robustness
# =============================================================================

_detect_app() {
    command -v "$1" >/dev/null 2>&1
}

# Cleanup helper at the end
_cleanup_detection() {
    unset -f _detect_app
}

# =============================================================================
# Development Tools
# =============================================================================

if _detect_app git; then
    # Git aliases
    alias g='git'
    alias gs='git status --short --branch'
    alias ga='git add'
    alias gaa='git add -A'
    alias gc='git commit'
    alias gcm='git commit -m'
    alias gca='git commit --amend'
    alias gp='git push'
    alias gpf='git push --force-with-lease'
    alias gpl='git pull --rebase --autostash'
    alias gf='git fetch --all --prune'
    alias gl='git log --oneline --decorate --graph --all -20'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias gb='git branch'
    alias gco='git checkout'
    alias gsw='git switch'
    alias gst='git stash push -u'
    alias gsp='git stash pop'
    alias grbc='git rebase --continue'
    alias grba='git rebase --abort'
    alias gpr='git pull --rebase'
fi

if _detect_app docker; then
    alias d='docker'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dc='docker compose'
    alias dex='docker exec -it'
    alias dlogs='docker logs -f'
    alias dstop='docker stop $(docker ps -q)'
    alias drm='docker rm $(docker ps -aq)'
    alias dprune='docker system prune -af'
    alias dclean='docker system prune -af --volumes'
fi

if _detect_app podman; then
    alias pod='podman'
    alias podps='podman ps'
    alias podpsa='podman ps -a'
    alias podim='podman images'
    alias podex='podman exec -it'
    alias podlogs='podman logs -f'
fi

if _detect_app kubectl; then
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgd='kubectl get deployments'
    alias kga='kubectl get all'
    alias kctx='kubectl config current-context'
    alias kuse='kubectl config use-context'
    alias kd='kubectl describe'
    alias kl='kubectl logs'
    alias ka='kubectl apply -f'
    alias kdel='kubectl delete'
fi

if _detect_app helm; then
    alias h='helm'
    alias hl='helm list'
    alias hi='helm install'
    alias hu='helm upgrade'
fi

if _detect_app terraform; then
    alias tf='terraform'
    alias tfi='terraform init'
    alias tfp='terraform plan'
    alias tfa='terraform apply'
    alias tfd='terraform destroy'
    alias tfv='terraform validate'
fi

if _detect_app ansible; then
    alias a='ansible'
    alias ap='ansible-playbook'
    alias av='ansible-vault'
fi

# =============================================================================
# Programming Languages
# =============================================================================

if _detect_app python3; then
    alias py='python3'
    alias pipup='python3 -m pip install --upgrade pip'
    alias venv='python3 -m venv .venv'
    alias py激活='source .venv/bin/activate'
fi

if _detect_app python3 && _detect_app pip; then
    alias pi='pip install'
    alias piu='pip install -U'
    alias pir='pip install -r requirements.txt'
fi

if _detect_app python; then
    alias py='python'
fi

if _detect_app node; then
    alias node='node'
    alias nr='npm run'
    alias ni='npm install'
    alias nis='npm install --save'
    alias nid='npm install --save-dev'
    alias nt='npm test'
    alias nd='npm run dev'
    alias nb='npm run build'
    alias np='npm publish'
fi

if _detect_app pnpm; then
    alias pn='pnpm'
    alias pni='pnpm install'
    alias pnr='pnpm run'
fi

if _detect_app yarn; then
    alias y='yarn'
    alias yi='yarn add'
    alias yad='yarn add -D'
    alias yr='yarn run'
fi

if _detect_app go; then
    alias go='go'
    alias gor='go run'
    alias gob='go build'
    alias got='go test'
fi

if _detect_app cargo; then
    alias c='cargo'
    alias cb='cargo build'
    alias cr='cargo run'
    alias ct='cargo test'
    alias cb='cargo build --release'
    alias ccl='cargo clippy'
    alias cf='cargo fmt'
fi

if _detect_app rustc; then
    alias rs='rustc'
fi

if _detect_app dart; then
    alias dart='dart'
fi

if _detect_app flutter; then
    alias flutter='flutter'
fi

if _detect_app php; then
    alias php='php'
    alias p serve='php -S localhost:8000'
fi

if _detect_app ruby; then
    alias ruby='ruby'
    alias rb='ruby'
    alias rake='rake'
    alias bundler='bundler'
fi

if _detect_app julia; then
    alias julia='julia'
fi

if _detect_app R; then
    alias R='R'
fi

# =============================================================================
# CLI Enhancements
# =============================================================================

if _detect_app eza; then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -lah --icons=auto --group-directories-first'
    alias la='eza -a --icons=auto'
    alias lt='eza --tree --level=2 --icons=auto'
    alias l='eza -l --icons=auto'
fi

if _detect_app lsd; then
    alias ls='lsd --icon always --group-dirs-first'
    alias ll='lsd -l --icon always --group-dirs-first --date +"%Y-%m-%d %H:%M"'
    alias la='lsd -la --icon always'
    alias lt='lsd --tree --level 2'
fi

if _detect_app bat; then
    alias cat='bat --paging=never'
    alias less='bat'
fi

if _detect_app rg; then
    alias rg='rg --hidden --glob "!.git"'
fi

if _detect_app fzf; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border --preview-window=right:50%"
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -50'"
    export FZF_ALT_C_OPTS="--preview 'eza --icons --tree {} | head -30'"
fi

if _detect_app zoxide; then
    eval "$(zoxide init "$SHELL_NAME" 2>/dev/null)"
fi

if _detect_app atuin; then
    eval "$(atuin init "$SHELL_NAME" 2>/dev/null)"
fi

if _detect_app starship; then
    if [ "$DOTFILES_DISTRO" = "macos" ]; then
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    fi
    eval "$(starship init "$SHELL_NAME" 2>/dev/null)"
fi

if _detect_app fastfetch; then
    alias fetch='fastfetch -c ~/.config/fastfetch/config.jsonc'
fi

if _detect_app neofetch; then
    alias neo='neofetch'
fi

if _detect_app btop; then
    alias htop='btop'
    alias top='btop'
elif _detect_app htop; then
    alias top='htop'
elif _detect_app top; then
    # use built-in
    :
fi

# =============================================================================
# DevOps & Cloud
# =============================================================================

if _detect_app aws; then
    alias awsu='awsudo'
    alias awswho='aws sts get-caller-identity'
fi

if _detect_app gcloud; then
    alias gcs='gcloud compute ssh'
    alias gcl='gcloud compute instances list'
fi

if _detect_app az; then
    alias azl='az vm list'
    alias azs='az vm start'
    alias azst='az vm stop'
fi

if _detect_app terraform; then
    # already added above
    :
fi

if _detect_app ansible; then
    # already added above
    :
fi

if _detect_app vault; then
    alias vault='vault'
fi

# =============================================================================
# Tmux & Screen
# =============================================================================

if _detect_app tmux; then
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
    alias tn='tmux new-session -s'
    alias tk='tmux kill-session -t'
fi

if _detect_app screen; then
    alias s='screen'
    alias sl='screen -ls'
    alias ss='screen -S'
fi

# =============================================================================
# System Tools
# =============================================================================

if _detect_app systemctl; then
    alias sc='systemctl'
    alias scs='systemctl status'
    alias scst='systemctl start'
    alias scsp='systemctl stop'
    alias scsr='systemctl restart'
    alias scse='systemctl enable'
    alias scsd='systemctl disable'
fi

if _detect_app journalctl; then
    alias jc='journalctl'
    alias jce='journalctl -e'
    alias jcf='journalctl -f'
    alias jcu='journalctl -u'
fi

if _detect_app nvidia-smi; then
    alias gpu='nvidia-smi'
    alias gpul='nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv'
fi

if _detect_app pacman && ! _detect_app apt; then
    # pacman-only distros
    alias pacup='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacs='pacman -Ss'
    alias pacq='pacman -Qq'
    alias pacqi='pacman -Qi'
fi

if _detect_app yay; then
    alias yayi='yay -S'
    alias yayd='yay -R'
    alias yays='yay -Ss'
    alias yayup='yay -Syu'
fi

if _detect_app apt; then
    alias aptup='sudo apt update && sudo apt upgrade -y'
    alias aptin='sudo apt install'
    alias aptr='sudo apt remove'
    alias apts='apt search'
    alias aptq='dpkg -l'
fi

if _detect_app dnf; then
    alias dnfup='sudo dnf upgrade'
    alias dnfi='sudo dnf install'
    alias dnfr='sudo dnf remove'
    alias dnfs='dnf search'
fi

if _detect_app brew; then
    alias brewup='brew update && brew upgrade'
    alias brewin='brew install'
    alias brewrm='brew uninstall'
    alias brews='brew search'
    alias brewq='brew list'
fi

# =============================================================================
# Network & Security
# =============================================================================

if _detect_app ssh; then
    alias ssh='ssh'
fi

if _detect_app scp; then
    alias scp='scp -r'
fi

if _detect_app nmap; then
    alias nmap='nmap'
fi

if _detect_app curl; then
    alias cur='curl -fsSL'
fi

if _detect_app wget; then
    alias wget='wget'
fi

# =============================================================================
# Text & Media
# =============================================================================

if _detect_app nvim; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
    export EDITOR='nvim'
    export VISUAL='nvim'
elif _detect_app vim; then
    alias v='vim'
    alias vi='vim'
    export EDITOR='vim'
    export VISUAL='vim'
fi

if _detect_app micro; then
    alias m='micro'
fi

if _detect_app code; then
    alias codel='code .'
fi

if _detect_app ffmpeg; then
    alias ffmpeg='ffmpeg'
    alias ffprobe='ffprobe'
    alias ffcat='ffmpeg -i input.mp4 -c copy output.mp4'
fi

if _detect_app convert; then
    alias convert='convert'
fi

if _detect_app rsvg-convert; then
    alias svgtopng='rsvg-convert'
fi

# =============================================================================
# Archive & Compress
# =============================================================================

if _detect_app tar; then
    alias tarx='tar -xf'
    alias tarc='tar -czf'
    alias tart='tar -tzf'
fi

if _detect_app zip; then
    alias zip='zip -r'
    alias unzip='unzip'
fi

if _detect_app 7z; then
    alias 7z='7z a'
fi

# =============================================================================
# System Monitoring
# =============================================================================

if _detect_app glances; then
    alias glances='glances'
fi

if _detect_app bpytop; then
    alias bpytop='bpytop'
fi

if _detect_app bashtop; then
    alias bashtop='bashtop'
fi

# =============================================================================
# Utils
# =============================================================================

if _detect_app tldr; then
    alias tldr='tldr'
fi

if _detect_app cheat; then
    alias cheat='cheat'
fi

if _detect_app bottom; then
    alias bt='btop'
fi