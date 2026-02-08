#!/usr/bin/env bash
# =============================================================================
# 04-ALIASES-NERD.SH - Ultra-Nerd Aliases
# Mode: ultra-nerd only
# For power users with modern tools and nerd fonts
# =============================================================================

[[ "$DOTFILES_MODE" != "ultra-nerd" ]] && return

# =============================================================================
# FZF ADVANCED INTEGRATION
# =============================================================================

# File finder with preview
alias f='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias fv='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" | xargs -r $EDITOR'
alias fvim='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" | xargs -r nvim'

# Directory navigation (fcd is defined as a function in 07-modern-tools.sh)
alias fd='fzf --preview "tree -C {} | head -200"'

# Git integration with fzf
alias fbr='git branch -a | fzf | xargs git checkout'
alias fco='git log --oneline | fzf | cut -d" " -f1 | xargs git checkout'
alias fshow='git log --oneline | fzf --preview "git show --stat --color {1}"'
alias fstash='git stash list | fzf --preview "git stash show -p {1}" | cut -d: -f1 | xargs git stash pop'

# Process killer with fzf (fkill is defined as a function in 07-modern-tools.sh)

# Environment variable viewer
alias fenv='env | fzf'

# History search
alias fhist='history | fzf --tac | sed "s/^[ ]*[0-9]*[ ]*//"'

# =============================================================================
# ADVANCED SYSTEM MONITORING
# =============================================================================

# System info with icons (if nerd fonts available)
alias sysinfo='neofetch 2>/dev/null || fastfetch 2>/dev/null || screenfetch'
alias cpu='lscpu | grep -E "Model name|Socket|Core|Thread|MHz"'
alias memdetailed='cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree"'
alias disks='lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,UUID'
alias temps='sensors 2>/dev/null || echo "lm-sensors not installed"'
alias power='upower -i $(upower -e | grep BAT) 2>/dev/null || echo "No battery found"'

# =============================================================================
# ADVANCED NETWORKING
# =============================================================================
alias nmap-fast='nmap -F -T4'
alias nmap-full='nmap -sS -sV -sC -A -O'
alias nmap-vuln='nmap --script vuln'
alias nmap-udp='nmap -sU -sV --version-intensity 0'
alias sniff='sudo tcpdump -i any -s0 -w'
alias ss-http='ss -tulnp | grep -E "(:80|:443)"'
alias bandwhich='sudo bandwhich'  # bandwidth monitor
alias iftop='sudo iftop'
alias iotop='sudo iotop'
alias powertop='sudo powertop'

# =============================================================================
# KUBERNETES ALIASES
# =============================================================================
alias k='kubectl'
alias kaf='kubectl apply -f'
alias kca='kubectl --all-namespaces'
alias kccc='kubectl config current-context'
alias kcdc='kubectl config delete-context'
alias kcgc='kubectl config get-contexts'
alias kcn='kubectl config set-context --current --namespace'
alias kcp='kubectl cp'
alias kcsc='kubectl config set-context'
alias kcuc='kubectl config use-context'
alias kdcj='kubectl describe cronjob'
alias kdd='kubectl describe deployment'
alias kdds='kubectl describe daemonset'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kdi='kubectl describe ingress'
alias kdp='kubectl describe pods'
alias kds='kubectl describe svc'
alias kdss='kubectl describe statefulset'
alias ke='kubectl edit'
alias keti='kubectl exec -ti'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
alias kgcj='kubectl get cronjob'
alias kgd='kubectl get deployment'
alias kgdw='kubectl get deployment --watch'
alias kgdwide='kubectl get deployment -o wide'
alias kgds='kubectl get daemonset'
alias kge='kubectl get events'
alias kgew='kubectl get events --watch'
alias kgi='kubectl get ingress'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgpo='kubectl get pods -o wide'
alias kgpw='kubectl get pods --watch'
alias kgpwide='kubectl get pods -o wide'
alias kgpy='kubectl get pods -o yaml'
alias kgrs='kubectl get rs'
alias kgs='kubectl get svc'
alias kgss='kubectl get statefulset'
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'
alias kp='kubectl proxy'
alias kpf='kubectl port-forward'
alias krh='kubectl rollout history'
alias krsd='kubectl rollout status deployment'
alias kru='kubectl rollout undo'
alias ksd='kubectl scale deployment'
alias ktop='kubectl top'
alias ktopn='kubectl top node'
alias ktopnd='kubectl top node --sort-by=cpu'
alias ktopp='kubectl top pod'
alias ktopps='kubectl top pod --sort-by=cpu'

# Helm aliases
alias h='helm'
alias hin='helm install'
alias hup='helm upgrade'
alias hdel='helm delete'
alias hls='helm list'
alias hsearch='helm search hub'

# =============================================================================
# TERRAFORM / INFRASTRUCTURE
# =============================================================================
alias tf='terraform'
alias tfa='terraform apply'
alias tfc='terraform console'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfi='terraform init'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfv='terraform validate'
alias tfw='terraform workspace'
alias tfs='terraform state'

# =============================================================================
# AWS CLI ALIASES
# =============================================================================
alias awsls='aws s3 ls'
alias awscfg='aws configure'
alias awswho='aws sts get-caller-identity'

# =============================================================================
# DEVELOPMENT ADVANCED
# =============================================================================

# Quick server in current directory with SSL
alias serve-ssl='openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout localhost.key -out localhost.crt && python3 -m http.server --bind 127.0.0.1 8443 --directory . &'

# Development servers
alias rails-server='bundle exec rails server'
alias django-server='python manage.py runserver'
alias flask-server='flask run'
alias node-server='node server.js'
alias php-server='php -S localhost:8000'

# Testing shortcuts
alias test-watch='npm test -- --watch'
alias pytest-watch='ptw'
alias cargo-watch='cargo watch -x run'

# =============================================================================
# FUN & PRODUCTIVITY
# =============================================================================
alias weather='curl -s wttr.in/?format=v2'
alias weather-full='curl -s wttr.in/'
alias moon='curl -s wttr.in/Moon'
alias qr='curl -s qrenco.de/'
alias cheat='curl -s cheat.sh/'
alias dict='curl -s dict://dict.org/d:'

# Matrix effect
alias matrix='cmatrix'

# Star Wars
alias starwars='telnet towel.blinkenlights.nl 2>/dev/null || echo "telnet not available"'

# =============================================================================
# ADVANCED FILE OPERATIONS
# =============================================================================

# Find and replace in files
alias findreplace='find . -type f -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.md" | xargs sed -i'

# Mass rename
alias mmv='noglob zmv -W'

# Better tree
if command -v tree &>/dev/null; then
    alias tree='tree -C --dirsfirst'
    alias treed='tree -d'
    alias tree1='tree -L 1'
    alias tree2='tree -L 2'
    alias tree3='tree -L 3'
fi

# =============================================================================
# CLIPBOARD OPERATIONS (Cross-platform)
# =============================================================================
if command -v xclip &>/dev/null; then
    alias copy='xclip -selection clipboard'
    alias paste='xclip -o -selection clipboard'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -o -selection clipboard'
elif command -v xsel &>/dev/null; then
    alias copy='xsel --clipboard --input'
    alias paste='xsel --clipboard --output'
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias copy='pbcopy'
    alias paste='pbpaste'
fi

# =============================================================================
# ADVANCED TAR OPERATIONS
# =============================================================================
alias tarx='tar -xvf'
alias tarc='tar -cvf'
alias tarcz='tar -czvf'
alias tarcj='tar -cjvf'
alias tarxz='tar -xJvf'
alias tarlist='tar -tvf'
