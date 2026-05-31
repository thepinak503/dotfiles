#!/usr/bin/env zsh
# =============================================================================
# ZSH MODE: SUPREME
# =============================================================================
# Maximum developer tooling — Docker, Kubernetes, cloud tools, databases,
# and everything needed for full-stack development. Best for power users
# who work across multiple tech stacks daily.
# =============================================================================

# =============================================================================
# ENHANCED FILE LISTING
# =============================================================================

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=auto --group-directories-first --time-style=long-iso'
    alias ll='eza -l --icons=auto --group-directories-first --time-style=long-iso --git'
    alias la='eza -a --icons=auto --group-directories-first'
    alias lal='eza -la --icons=auto --group-directories-first --time-style=long-iso --git'
    alias lta='eza -T --level=3 --icons=auto --group-directories-first -a'
fi

# =============================================================================
# QUICK DIRECTORY NAVIGATION
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias projects='cd ~/Projects'
alias dots='cd "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"'
alias cfg='cd ~/.config'
alias dev='cd ~/Projects'
alias tmp='cd /tmp'
alias back='cd -'

# =============================================================================
# EDITORS
# =============================================================================

if command -v nvim >/dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
    alias sv='sudo -E nvim'
    alias vimdiff='nvim -d'
fi

# =============================================================================
# GIT — Full Suite
# =============================================================================

alias g='git'
alias gst='git status'
alias gss='git status --short'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gaa='git add --all'
alias ga='git add'
alias gap='git add -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --oneline --graph -20'
alias gla='git log --oneline --graph --all -20'
alias gstash='git stash'
alias gstashp='git stash pop'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gmt='git mergetool'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gcp='git cherry-pick'
alias gbl='git blame'
alias gcl='git clone'
alias gclean='git clean -fd'
alias greset='git reset --hard'
alias gtags='git tag'
alias gsub='git submodule update --init --recursive'

# =============================================================================
# DOCKER & CONTAINERS
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
    alias dstop='docker stop $(docker ps -q) 2>/dev/null'
    alias drm='docker rm $(docker ps -aq) 2>/dev/null'
    alias drmi='docker rmi $(docker images -q) 2>/dev/null'
    alias dprune='docker system prune -af'
    alias dtop='docker stats --no-stream'
    alias dcup='docker compose up -d'
    alias dcdown='docker compose down'
    alias dclogs='docker compose logs -f'
    alias dcbuild='docker compose build'
fi

if command -v lazydocker >/dev/null 2>&1; then
    alias lzd='lazydocker'
fi

# =============================================================================
# KUBERNETES
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
    alias kexec='kubectl exec -it'
    alias kpf='kubectl port-forward'
    alias ktop='kubectl top pods'
    alias kctx='kubectx 2>/dev/null'
    alias kns='kubens 2>/dev/null'
fi

if command -v helm >/dev/null 2>&1; then
    alias hl='helm list'
    alias hls='helm list --all-namespaces'
    alias hui='helm upgrade --install'
fi

if command -v k9s >/dev/null 2>&1; then
    alias k9s='k9s'
fi

# =============================================================================
# TERRAFORM / PACKER
# =============================================================================

if command -v terraform >/dev/null 2>&1; then
    alias tf='terraform'
    alias tfi='terraform init'
    alias tfp='terraform plan'
    alias tfa='terraform apply'
    alias tfd='terraform destroy'
    alias tff='terraform fmt'
    alias tfv='terraform validate'
    alias tfw='terraform workspace'
fi

if command -v packer >/dev/null 2>&1; then
    alias packer='packer'
    alias pk='packer'
    alias pkb='packer build'
    alias pkf='packer fmt'
    alias pkv='packer validate'
fi

if command -v vagrant >/dev/null 2>&1; then
    alias vg='vagrant'
    alias vgu='vagrant up'
    alias vgs='vagrant status'
    alias vgh='vagrant halt'
    alias vgd='vagrant destroy'
    alias vgssh='vagrant ssh'
    alias vgp='vagrant provision'
fi

if command -v ansible >/dev/null 2>&1; then
    alias ans='ansible'
    alias ansp='ansible-playbook'
    alias ansg='ansible-galaxy'
    alias ansv='ansible-vault'
fi

# =============================================================================
# CLOUD TOOLS
# =============================================================================

if command -v aws >/dev/null 2>&1; then
    alias aws='aws'
    alias awsl='aws --profile'
    alias awswl='aws configure list'
    alias awss3='aws s3'
    alias awsec2='aws ec2'
    alias awsr53='aws route53'
fi

if command -v gcloud >/dev/null 2>&1; then
    alias gcloud='gcloud'
    alias gk='gcloud'
    alias gkconfig='gcloud config list'
    alias gkprojects='gcloud projects list'
fi

if command -v az >/dev/null 2>&1; then
    alias az='az'
    alias azlogin='az login'
    alias azvm='az vm'
    alias azaks='az aks'
fi

# =============================================================================
# DATABASES
# =============================================================================

if command -v psql >/dev/null 2>&1; then
    alias psql='psql'
    alias pgstart='pg_ctl start -D /var/lib/postgres/data 2>/dev/null || brew services start postgresql 2>/dev/null'
    alias pgstop='pg_ctl stop -D /var/lib/postgres/data 2>/dev/null || brew services stop postgresql 2>/dev/null'
fi

if command -v mysql >/dev/null 2>&1; then
    alias mysql='mysql'
    alias mysqlstart='systemctl start mysql 2>/dev/null || brew services start mysql 2>/dev/null'
fi

if command -v redis-cli >/dev/null 2>&1; then
    alias redis='redis-cli'
    alias redstart='redis-server --daemonize yes 2>/dev/null || brew services start redis 2>/dev/null'
fi

if command -v mongosh >/dev/null 2>&1; then
    alias mongo='mongosh'
fi

# =============================================================================
# SYSTEM MONITORING
# =============================================================================

alias top='btop 2>/dev/null || htop 2>/dev/null || top'
alias cpuinfo='lscpu'
alias meminfo='free -h'
alias diskinfo='df -h'
alias diskusage='du -sh * | sort -rh'
alias psg='ps aux | grep -v grep | grep -i'
alias ports='ss -tuln'
alias journal='journalctl -xe --no-pager -n 50'
alias jf='journalctl -f'
alias ju='journalctl -u'
alias sysinfo='fastfetch 2>/dev/null || neofetch 2>/dev/null'

# =============================================================================
# PACKAGE MANAGEMENT
# =============================================================================

alias update='bash ~/.local/share/dotfiles/bin/sysupdate.sh'
alias cleanup='bash ~/.local/share/dotfiles/bin/syscleanup.sh'

# =============================================================================
# NETWORK
# =============================================================================

alias ping='ping -c 5'
alias myip='curl -s ifconfig.me 2>/dev/null || curl -s icanhazip.com'
alias ipa='ip -br addr'
alias ipr='ip route'
alias tracepath='tracepath -n'
alias dig='dig +short'
alias whois='whois'

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================

if command -v npm >/dev/null 2>&1; then
    alias ni='npm install'
    alias nid='npm install --save-dev'
    alias nig='npm install -g'
    alias nrd='npm run dev'
    alias nrs='npm run start'
    alias nrb='npm run build'
    alias nrt='npm run test'
    alias npx='npx'
fi

if command -v yarn >/dev/null 2>&1; then
    alias y='yarn'
    alias ya='yarn add'
    alias yad='yarn add --dev'
    alias yrm='yarn remove'
    alias ydev='yarn dev'
    alias ybuild='yarn build'
    alias ytest='yarn test'
fi

if command -v pnpm >/dev/null 2>&1; then
    alias pn='pnpm'
    alias pna='pnpm add'
    alias pndev='pnpm dev'
    alias pnbuild='pnpm build'
    alias pntest='pnpm test'
fi

if command -v cargo >/dev/null 2>&1; then
    alias cr='cargo'
    alias crb='cargo build'
    alias crr='cargo run'
    alias crt='cargo test'
    alias crc='cargo check'
    alias crf='cargo fmt'
    alias crcl='cargo clippy'
    alias crn='cargo new'
    alias cra='cargo add'
fi

if command -v go >/dev/null 2>&1; then
    alias go='go'
    alias gor='go run'
    alias gob='go build'
    alias got='go test'
    alias gof='go fmt'
    alias gom='go mod'
fi

# =============================================================================
# MISC UTILITIES
# =============================================================================

alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias path='echo $PATH | tr ":" "\n" | nl'
alias h='history'
alias hg='history | grep'
alias szrc='source ~/.zshrc'
alias reload='source ~/.zshrc'
alias reexec='exec zsh'
alias weather='curl -s wttr.in 2>/dev/null'

# =============================================================================
# TOOL INTEGRATIONS
# =============================================================================

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Atuin
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

# Starship
if command -v starship >/dev/null 2>&1; then
    if [[ "$(uname)" == "Darwin" ]]; then
        export STARSHIP_CONFIG="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}/apps/starship-linux.toml"
    fi
fi

# =============================================================================
# SHELL OPTIONS
# =============================================================================

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T "

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt AUTO_MENU
setopt PROMPT_SUBST

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz|*.tgz)  tar xzf "$1"  ;;
            *.tar.bz2|*.tbz2) tar xjf "$1" ;;
            *.tar.xz)        tar xJf "$1"  ;;
            *.tar)           tar xf "$1"   ;;
            *.zip)           unzip "$1"    ;;
            *.rar)           unrar x "$1"  ;;
            *.7z)            7z x "$1"    ;;
            *)               echo "Cannot extract: $1" ;;
        esac
    fi
}

ff() { find . -type f -name "*$1*" 2>/dev/null; }
fd() { find . -type d -name "*$1*" 2>/dev/null; }
genpass() { openssl rand -base64 48 | tr -d '+/=' | cut -c1-"${1:-32}"; }
sslinfo() { echo | openssl s_client -connect "${1}:${2:-443}" -servername "$1" 2>/dev/null | openssl x509 -noout -dates -subject -issuer; }
dot_sync() { git -C "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" fetch --all --prune && git -C "${DOTFILES_DIR:-$HOME/.local/share/dotfiles}" pull --rebase --autostash; }
alias dsync='dot_sync'
