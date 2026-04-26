#!/usr/bin/env bash
_detect_app() { command -v "$1" >/dev/null 2>&1; }

# Development Tools
if _detect_app git; then
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
    alias gl='git log --oneline --decorate --graph --all -30'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias gb='git branch'
    alias gco='git checkout'
    alias gsw='git switch'
    alias gst='git stash push -u'
    alias gsp='git stash pop'
    alias grbc='git rebase --continue'
    alias grba='git rebase --abort'
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
fi

if _detect_app podman; then
    alias pod='podman'
    alias podps='podman ps'
    alias podpsa='podman ps -a'
    alias podim='podman images'
    alias podex='podman exec -it'
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

# Programming Languages
if _detect_app python3; then
    alias py='python3'
    alias pipup='python3 -m pip install --upgrade pip'
fi

if _detect_app node; then
    alias nr='npm run'
    alias ni='npm install'
    alias nis='npm install --save'
    alias nid='npm install --save-dev'
    alias nt='npm test'
    alias nd='npm run dev'
    alias nb='npm run build'
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
    alias cbr='cargo build --release'
    alias ccl='cargo clippy'
    alias cf='cargo fmt'
fi

# CLI Enhancements
if _detect_app eza; then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -lah --icons=auto --group-directories-first'
    alias la='eza -a --icons=auto'
    alias lt='eza --tree --level=2 --icons=auto'
fi

if _detect_app bat; then
    alias cat='bat --paging=never'
fi

if _detect_app rg; then
    alias rg='rg --hidden --glob "!.git"'
fi

if _detect_app fzf; then
    export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border"
fi

if _detect_app zoxide; then
    eval "$(zoxide init bash 2>/dev/null)"
fi

if _detect_app atuin; then
    eval "$(atuin init bash 2>/dev/null)"
fi

if _detect_app starship; then
    eval "$(starship init bash --print-full-init 2>/dev/null)"
fi

if _detect_app fastfetch; then
    alias fetch='fastfetch -c ~/.config/fastfetch/config.jsonc'
fi

if _detect_app btop; then
    alias htop='btop'
    alias top='btop'
elif _detect_app htop; then
    alias top='htop'
fi

# DevOps & Cloud
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

# Tmux & Screen
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

# System Tools
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

# Package Managers
if _detect_app pacman && ! _detect_app apt; then
    alias pacup='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacs='pacman -Ss'
    alias pacq='pacman -Qq'
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
fi

# Network
if _detect_app curl; then
    alias cur='curl -fsSL'
fi

# Text Editor
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

if _detect_app code; then
    alias codel='code .'
fi

if _detect_app ffmpeg; then
    alias ffmpeg='ffmpeg'
fi

# Tar/Zip
if _detect_app tar; then
    alias tarx='tar -xf'
    alias tarc='tar -czf'
fi

if _detect_app zip; then
    alias zip='zip -r'
fi

# Monitoring
if _detect_app glances; then
    alias glances='glances'
fi

if _detect_app tldr; then
    alias tldr='tldr'
fi