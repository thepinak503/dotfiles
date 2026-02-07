#!/usr/bin/env fish
# =============================================================================
# FISH DEVELOPMENT TOOLS
# =============================================================================

# =============================================================================
# PYTHON
# =============================================================================

abbr -a py 'python3'
abbr -a py3 'python3'
abbr -a pip 'pip3'
abbr -a pipi 'pip install'
abbr -a pipu 'pip install --upgrade'
abbr -a pipun 'pip uninstall'
abbr -a pipl 'pip list'
abbr -a pipf 'pip freeze'

# Virtual environments
abbr -a venv 'python3 -m venv'
abbr -a venva 'source venv/bin/activate.fish'

# Poetry
if command -v poetry >/dev/null 2>&1
    abbr -a po 'poetry'
    abbr -a poa 'poetry add'
    abbr -a pou 'poetry update'
    abbr -a poi 'poetry install'
    abbr -a por 'poetry run'
    abbr -a pos 'poetry shell'
end

# =============================================================================
# NODE.JS
# =============================================================================

abbr -a nr 'npm run'
abbr -a ns 'npm start'
abbr -a nb 'npm run build'
abbr -a nt 'npm test'
abbr -a ni 'npm install'
abbr -a nid 'npm install --save-dev'
abbr -a nig 'npm install -g'
abbr -a nu 'npm uninstall'
abbr -a nup 'npm update'
abbr -a nls 'npm list --depth=0'
abbr -a nout 'npm outdated'

# Yarn
if command -v yarn >/dev/null 2>&1
    abbr -a yr 'yarn run'
    abbr -a ys 'yarn start'
    abbr -a yb 'yarn build'
    abbr -a yt 'yarn test'
    abbr -a ya 'yarn add'
    abbr -a yad 'yarn add --dev'
    abbr -a yrm 'yarn remove'
end

# PNPM
if command -v pnpm >/dev/null 2>&1
    abbr -a pn 'pnpm'
    abbr -a pnr 'pnpm run'
    abbr -a pns 'pnpm start'
    abbr -a pni 'pnpm install'
end

# =============================================================================
# RUST
# =============================================================================

if command -v cargo >/dev/null 2>&1
    abbr -a c 'cargo'
    abbr -a cb 'cargo build'
    abbr -a cbr 'cargo build --release'
    abbr -a cr 'cargo run'
    abbr -a ct 'cargo test'
    abbr -a cc 'cargo check'
    abbr -a cf 'cargo fmt'
    abbr -a cl 'cargo clippy'
    abbr -a cdoc 'cargo doc --open'
    abbr -a cnew 'cargo new'
end

# =============================================================================
# GIT ENHANCED
# =============================================================================

abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gap 'git add --patch'
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gc 'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gca 'git commit -v -a'
abbr -a gcam 'git commit -a -m'
abbr -a gcb 'git checkout -b'
abbr -a gcm 'git checkout master; or git checkout main'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --prune'
abbr -a gl 'git log --oneline --graph --decorate'
abbr -a glg 'git log --graph --decorate --all'
abbr -a gm 'git merge'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gpl 'git pull'
abbr -a gpr 'git pull --rebase'
abbr -a gr 'git remote -v'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grh 'git reset'
abbr -a grhh 'git reset --hard'
abbr -a gs 'git status -sb'
abbr -a gst 'git stash push'
abbr -a gstp 'git stash pop'
abbr -a gsta 'git stash apply'
abbr -a gstl 'git stash list'

# =============================================================================
# DOCKER
# =============================================================================

abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dps 'docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
abbr -a dpa 'docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
abbr -a di 'docker images'
abbr -a dr 'docker run -it --rm'
abbr -a dri 'docker run -it'
abbr -a dex 'docker exec -it'
abbr -a dl 'docker logs -f'
abbr -a dlf 'docker logs -f'
abbr -a dprune 'docker system prune -af'
abbr -a dstats 'docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# Docker Compose
abbr -a dcu 'docker-compose up'
abbr -a dcud 'docker-compose up -d'
abbr -a dcd 'docker-compose down'
abbr -a dcdv 'docker-compose down -v'
abbr -a dcr 'docker-compose restart'
abbr -a dcb 'docker-compose build'
abbr -a dcl 'docker-compose logs -f'
abbr -a dce 'docker-compose exec'

# =============================================================================
# KUBERNETES
# =============================================================================

if command -v kubectl >/dev/null 2>&1
    abbr -a k 'kubectl'
    abbr -a kg 'kubectl get'
    abbr -a kd 'kubectl describe'
    abbr -a ka 'kubectl apply'
    abbr -a kdel 'kubectl delete'
    abbr -a kex 'kubectl exec -it'
    abbr -a kl 'kubectl logs -f'
    abbr -a kgp 'kubectl get pods'
    abbr -a kgs 'kubectl get svc'
    abbr -a kgd 'kubectl get deployment'
    abbr -a kgn 'kubectl get nodes'
    abbr -a kgns 'kubectl get namespace'
    abbr -a kga 'kubectl get all'
    abbr -a kgaa 'kubectl get all --all-namespaces'
    abbr -a ktop 'kubectl top'
end

# Helm
if command -v helm >/dev/null 2>&1
    abbr -a h 'helm'
    abbr -a hin 'helm install'
    abbr -a hup 'helm upgrade'
    abbr -a hdel 'helm delete'
    abbr -a hls 'helm list'
end

# =============================================================================
# TERRAFORM
# =============================================================================

if command -v terraform >/dev/null 2>&1
    abbr -a tf 'terraform'
    abbr -a tfa 'terraform apply'
    abbr -a tfauto 'terraform apply -auto-approve'
    abbr -a tfd 'terraform destroy'
    abbr -a tff 'terraform fmt'
    abbr -a tfi 'terraform init'
    abbr -a tfo 'terraform output'
    abbr -a tfp 'terraform plan'
    abbr -a tfv 'terraform validate'
    abbr -a tfw 'terraform workspace'
end

# =============================================================================
# PACKAGE MANAGERS (Distro-specific loaded separately)
# =============================================================================

if test "$DISTRO_ID" = "arch"; or string match -q "*arch*" "$DISTRO_ID"
    abbr -a pacs 'sudo pacman -S'
    abbr -a pacr 'sudo pacman -Rs'
    abbr -a pacu 'sudo pacman -Syu'
    abbr -a pacq 'pacman -Q'
    abbr -a pacss 'pacman -Ss'
    abbr -a pacsc 'sudo pacman -Sc'
else if test "$DISTRO_ID" = "debian"; or test "$DISTRO_ID" = "ubuntu"
    abbr -a apti 'sudo apt install'
    abbr -a aptr 'sudo apt remove'
    abbr -a aptu 'sudo apt update && sudo apt upgrade'
    abbr -a apts 'apt search'
    abbr -a aptc 'sudo apt autoremove'
else if test "$DISTRO_ID" = "fedora"
    abbr -a dnfi 'sudo dnf install'
    abbr -a dnfr 'sudo dnf remove'
    abbr -a dnfu 'sudo dnf upgrade'
    abbr -a dnfs 'dnf search'
    abbr -a dnfc 'sudo dnf autoremove'
end

# =============================================================================
# SERVERS & SERVICES
# =============================================================================

abbr -a serve 'python3 -m http.server'
abbr -a serve-php 'php -S localhost:8000'
abbr -a serve-node 'npx serve'
