#!/usr/bin/env fish
function _detect_app
    type -q $argv[1]
end

# Development Tools
if _detect_app git
    abbr -a g 'git'
    abbr -a gs 'git status --short --branch'
    abbr -a ga 'git add'
    abbr -a gaa 'git add -A'
    abbr -a gc 'git commit'
    abbr -a gcm 'git commit -m'
    abbr -a gca 'git commit --amend'
    abbr -a gp 'git push'
    abbr -a gpf 'git push --force-with-lease'
    abbr -a gpl 'git pull --rebase --autostash'
    abbr -a gl 'git log --oneline --decorate --graph --all -30'
    abbr -a gd 'git diff'
    abbr -a gb 'git branch'
    abbr -a gco 'git checkout'
    abbr -a gst 'git stash push -u'
end

if _detect_app docker
    abbr -a d 'docker'
    abbr -a dps 'docker ps'
    abbr -a dpsa 'docker ps -a'
    abbr -a di 'docker images'
    abbr -a dc 'docker compose'
    abbr -a dex 'docker exec -it'
    abbr -a dlogs 'docker logs -f'
    abbr -a drm 'docker rm $(docker ps -aq)'
end

if _detect_app kubectl
    abbr -a k 'kubectl'
    abbr -a kgp 'kubectl get pods'
    abbr -a kgs 'kubectl get svc'
    abbr -a kgd 'kubectl get deployments'
    abbr -a kga 'kubectl get all'
    abbr -a kctx 'kubectl config current-context'
    abbr -a kd 'kubectl describe'
    abbr -a kl 'kubectl logs'
end

if _detect_app helm
    abbr -a h 'helm'
    abbr -a hl 'helm list'
    abbr -a hi 'helm install'
end

if _detect_app terraform
    abbr -a tf 'terraform'
    abbr -a tfi 'terraform init'
    abbr -a tfp 'terraform plan'
    abbr -a tfa 'terraform apply'
end

# Programming Languages
if _detect_app python3
    abbr -a py 'python3'
    abbr -a pipup 'python3 -m pip install --upgrade pip'
end

if _detect_app node
    abbr -a nr 'npm run'
    abbr -a ni 'npm install'
    abbr -a nt 'npm test'
    abbr -a nd 'npm run dev'
end

if _detect_app pnpm
    abbr -a pn 'pnpm'
    abbr -a pni 'pnpm install'
end

if _detect_app yarn
    abbr -a y 'yarn'
    abbr -a yi 'yarn add'
end

if _detect_app go
    abbr -a go 'go'
    abbr -a gor 'go run'
    abbr -a gob 'go build'
end

if _detect_app cargo
    abbr -a c 'cargo'
    abbr -a cb 'cargo build'
    abbr -a cr 'cargo run'
    abbr -a ct 'cargo test'
end

# CLI Enhancements
if _detect_app eza
    abbr -a ls 'eza --icons=auto --group-directories-first'
    abbr -a ll 'eza -lah --icons=auto --group-directories-first'
    abbr -a la 'eza -a --icons=auto'
    abbr -a lt 'eza --tree --level=2 --icons=auto'
end

if _detect_app bat
    abbr -a cat 'bat --paging=never'
end

if _detect_app rg
    abbr -a rg 'rg --hidden --glob "!.git"'
end

if _detect_app fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

if _detect_app zoxide
    zoxide init fish | source
end

if _detect_app atuin
    atuin init fish | source
end

if _detect_app starship
    starship init fish | source
end

if _detect_app fastfetch
    abbr -a fetch 'fastfetch -c ~/.config/fastfetch/config.jsonc'
end

if _detect_app btop
    abbr -a htop 'btop'
    abbr -a top 'btop'
end

# DevOps & Cloud
if _detect_app aws
    abbr -a awsu 'awsudo'
    abbr -a awswho 'aws sts get-caller-identity'
end

if _detect_app gcloud
    abbr -a gcs 'gcloud compute ssh'
    abbr -a gcl 'gcloud compute instances list'
end

# Tmux & Screen
if _detect_app tmux
    abbr -a t 'tmux'
    abbr -a ta 'tmux attach'
    abbr -a tl 'tmux list-sessions'
    abbr -a tn 'tmux new-session -s'
end

if _detect_app screen
    abbr -a s 'screen'
    abbr -a sl 'screen -ls'
end

# System Tools
if _detect_app systemctl
    abbr -a sc 'systemctl'
    abbr -a scs 'systemctl status'
    abbr -a scst 'systemctl start'
    abbr -a scsp 'systemctl stop'
    abbr -a scsr 'systemctl restart'
end

# Package Managers
if _detect_app pacman
    abbr -a pacup 'sudo pacman -Syu'
    abbr -a pacin 'sudo pacman -S'
    abbr -a pacs 'pacman -Ss'
end

if _detect_app yay
    abbr -a yayi 'yay -S'
    abbr -a yayup 'yay -Syu'
end

if _detect_app apt
    abbr -a aptup 'sudo apt update && sudo apt upgrade -y'
    abbr -a aptin 'sudo apt install'
end

if _detect_app dnf
    abbr -a dnfup 'sudo dnf upgrade'
    abbr -a dnfi 'sudo dnf install'
end

if _detect_app brew
    abbr -a brewup 'brew update && brew upgrade'
    abbr -a brewin 'brew install'
end

# Network
if _detect_app curl
    abbr -a cur 'curl -fsSL'
end

# Text Editor
if _detect_app nvim
    abbr -a v 'nvim'
    abbr -a vi 'nvim'
    set -gx EDITOR 'nvim'
    set -gx VISUAL 'nvim'
end

if _detect_app code
    abbr -a codel 'code .'
end

# Tar/Zip
if _detect_app tar
    abbr -a tarx 'tar -xf'
    abbr -a tarc 'tar -czf'
end

if _detect_app zip
    abbr -a zip 'zip -r'
end

# Monitoring
if _detect_app glances
    abbr -a glances 'glances'
end

if _detect_app tldr
    abbr -a tldr 'tldr'
end