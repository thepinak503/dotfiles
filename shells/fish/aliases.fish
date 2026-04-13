# AUTO-GENERATED

status is-interactive; or exit

#!/usr/bin/env bash
# =============================================================================
# REBUILT SUPREME ALIASES (Logic Fixed)
# =============================================================================
#!/usr/bin/env bash

# =============================================================================
# .bash/aliases.bash  —  2000+ Unique, distro-agnostic, security-aware aliases
# Synced with .zsh/aliases.zsh and .fish/conf.d/aliases.fish
# All modern-tool aliases fall back gracefully if the tool isn't installed.

# =============================================================================

# ===========================================================================
# SAFETY

# ===========================================================================
abbr -a rm 'rm -i'
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'
abbr -a ln 'ln -i'
abbr -a chown 'chown --preserve-root'
abbr -a chmod 'chmod --preserve-root'
abbr -a chgrp 'chgrp --preserve-root'

# ===========================================================================
# NAVIGATION

# ===========================================================================
abbr -a ~ 'cd ~'
abbr -a - 'cd -'
abbr -a home 'cd ~'
abbr -a back 'cd -'
abbr -a dots 'cd "$DOTFILES_DIR"'
abbr -a dotfiles 'cd "$DOTFILES_DIR"'
abbr -a dl 'cd ~/Downloads'
abbr -a desk 'cd ~/Desktop'
abbr -a docs 'cd ~/Documents'
abbr -a pics 'cd ~/Pictures'
abbr -a music 'cd ~/Music'
abbr -a vids 'cd ~/Videos'
abbr -a tmp 'cd /tmp'
abbr -a etc 'cd /etc'
abbr -a usrbin 'cd /usr/bin'
abbr -a localbin 'cd ~/.local/bin'
abbr -a confdir 'cd ~/.config'

# ===========================================================================
# LISTING  (eza → exa → ls)

# ===========================================================================
        abbr -a ltt 'eza --tree --level=3 --icons'
        abbr -a lttt 'eza --tree --level=4 --icons'
        abbr -a lll 'eza -la --icons --git --color=auto --time-style=long-iso'
        abbr -a llm 'eza -la --icons --git --sort=modified'
        abbr -a lls 'eza -la --icons --git --sort=size'
        abbr -a lle 'eza -la --icons --git --sort=extension'
        abbr -a lln 'eza -la --icons --git --sort=name'
        abbr -a treea 'eza --tree --icons -a'
        abbr -a tree 'exa --tree --icons'

# ===========================================================================
# FILE VIEWING  (bat → cat)

# ===========================================================================
        abbr -a catp 'bat --style=plain --paging=never'
        abbr -a bh 'bat --style=header'
        abbr -a bp 'bat --style=plain'
        abbr -a catn 'batcat --style=plain'

# ===========================================================================
# SEARCHING  (fd → find, rg → grep, delta → diff)

# ===========================================================================
        abbr -a find 'fd -H'
        abbr -a ff 'fd -H'
        abbr -a fdir 'fd -t d'
        abbr -a ffile 'fd -t f'
        abbr -a rgs 'rg --smart-case --hidden -l'     # list files only
        abbr -a rgn 'rg --smart-case --hidden -N'     # no line numbers
        abbr -a diff 'delta'

# ===========================================================================
# PROCESS / SYSTEM MONITORING

# ===========================================================================
        abbr -a htop 'btop'
        abbr -a top 'htop'
        abbr -a ps 'ps auxf'
abbr -a psg 'ps aux | grep -v grep | grep -i'
abbr -a pstree 'pstree -p'
abbr -a killi 'kill -9'
abbr -a killall9 'killall -9'

# ===========================================================================
# SYSTEM INFO

# ===========================================================================
abbr -a df 'df -hT'
abbr -a duh 'du -sh'
abbr -a free 'free -h'
abbr -a meminfo 'cat /proc/meminfo'
abbr -a cpuinfo 'cat /proc/cpuinfo'
abbr -a cpus 'nproc'
abbr -a arch 'uname -m'
abbr -a kernel 'uname -r'
abbr -a hostname 'hostname -f'
abbr -a uptime 'uptime -p'
abbr -a loadavg 'cat /proc/loadavg'
abbr -a boottime 'who -b'
abbr -a lscpu 'lscpu'
abbr -a lsblk 'lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT'
abbr -a lsusb 'lsusb -v 2>/dev/null | head -50'
abbr -a lspci 'lspci -v'
abbr -a dmidecode 'sudo dmidecode'
# Fastfetch / neofetch
        abbr -a neofetch 'fastfetch'
        abbr -a sf 'neofetch'
        abbr -a sysinfo 'neofetch'
        abbr -a fetch 'neofetch'

# ===========================================================================
# DISK / STORAGE

# ===========================================================================
abbr -a dff 'df -hT | grep -v tmpfs'
abbr -a diskfree 'df -h --total | tail -1'
        abbr -a du 'gdu'
abbr -a lsblka 'lsblk -a'
abbr -a mount 'mount | column -t'

# ===========================================================================
# EDITORS

# ===========================================================================
abbr -a vi 'nvim'
abbr -a vim 'nvim'
abbr -a nv 'nvim'
abbr -a svim 'sudo nvim'
abbr -a nano 'nano -l'                     # line numbers in nano
# Quick config edits
abbr -a ebash '$EDITOR ~/.bashrc'
abbr -a ezsh '$EDITOR ~/.zshrc'
abbr -a efish '$EDITOR ~/.config/fish/config.fish'
abbr -a egit '$EDITOR ~/.gitconfig'
abbr -a estarship '$EDITOR "$DOTFILES_DIR/apps/starship-linux.toml"'
abbr -a efastfetch '$EDITOR "$DOTFILES_DIR/apps/fastfetch/config.jsonc"'
abbr -a edots '$EDITOR "$DOTFILES_DIR"'
abbr -a etmux '$EDITOR ~/.tmux.conf'
abbr -a essh '$EDITOR ~/.ssh/config'
abbr -a evimrc '$EDITOR ~/.config/nvim/init.lua'
abbr -a dotupdate '$DOTFILES_DIR/bin/dotupdate.sh'
# Reload
abbr -a rbash 'source ~/.bashrc'
abbr -a rzsh 'source ~/.zshrc'

# ===========================================================================
# GIT  (comprehensive — ~120 aliases)

# ===========================================================================
abbr -a g 'git'
abbr -a gi 'git init'
abbr -a gcl 'git clone'
abbr -a gcld 'git clone --depth=1'
# Status
abbr -a gs 'git status'
abbr -a gss 'git status -sb'
abbr -a gsv 'git status -v'
# Add / stage
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gap 'git add -p'
abbr -a gau 'git add -u'
abbr -a gaf 'git add -f'
# Commit
abbr -a gc 'git commit -v'
abbr -a gcm 'git commit -m'
abbr -a gca 'git commit --amend'
abbr -a gcan 'git commit --amend --no-edit'
abbr -a gcas 'git commit --amend --squash'
abbr -a gcf 'git commit --fixup'
abbr -a gcs 'git commit -S'            # GPG-signed commit
# Branch
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbr 'git branch -r'
abbr -a gbd 'git branch -d'
abbr -a gbD 'git branch -D'
abbr -a gbm 'git branch -m'
abbr -a gbsort 'git branch --sort=-committerdate'
abbr -a gbclean 'git branch --merged | grep -v "\*\|main\|master\|develop" | xargs -r git branch -d'
# Checkout / Switch
abbr -a gco 'git checkout'
abbr -a gcob 'git checkout -b'
abbr -a gcop 'git checkout -p'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch -c'
abbr -a gswm 'git switch main 2>/dev/null || git switch master'
# Diff
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gdc 'git diff --cached'
abbr -a gdw 'git diff --word-diff'
abbr -a gdn 'git diff --name-only'
abbr -a gdstat 'git diff --stat'
# Fetch / Pull / Push
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --prune'
abbr -a gpl 'git pull'
abbr -a gplr 'git pull --rebase'
abbr -a gpla 'git pull --all'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'   # safe force push
abbr -a gpt 'git push --tags'
abbr -a gpu 'git push -u origin HEAD'
abbr -a gpd 'git push --dry-run'
# Log
abbr -a gg 'git log --oneline --graph --decorate'
abbr -a gga 'git log --oneline --graph --all --decorate'
abbr -a ggl 'git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
abbr -a ggla 'git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
abbr -a gls 'git log --stat'
abbr -a gll 'git log --pretty=fuller'
abbr -a glp 'git log --patch'
abbr -a glf 'git log --follow -p'           # follow file history
abbr -a gwho 'git shortlog -sn --all --no-merges'
# Rebase
abbr -a gr 'git rebase'
abbr -a gri 'git rebase -i'
abbr -a grim 'git rebase -i origin/main'
abbr -a grih 'git rebase -i HEAD~'
abbr -a gra 'git rebase --abort'
abbr -a grc 'git rebase --continue'
abbr -a grs 'git rebase --skip'
# Merge
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gmff 'git merge --ff-only'
abbr -a gmnff 'git merge --no-ff'
abbr -a gmsq 'git merge --squash'
# Cherry-pick
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
# Stash
abbr -a gh 'git stash'
abbr -a ghs 'git stash show -p'
abbr -a ghp 'git stash pop'
abbr -a gha 'git stash apply'
abbr -a ghd 'git stash drop'
abbr -a ghl 'git stash list'
abbr -a ghcl 'git stash clear'
# Reset
abbr -a gre 'git reset'
abbr -a greh 'git reset HEAD'
abbr -a grehh 'git reset --hard HEAD'
abbr -a grehs 'git reset --soft HEAD~1'   # undo last commit, keep changes staged
abbr -a gundo 'git reset --soft HEAD~1'
abbr -a gnuke 'git reset --hard && git clean -fd'
# Remote
abbr -a grm 'git remote'
abbr -a grma 'git remote add'
abbr -a grmr 'git remote remove'
abbr -a grmv 'git remote -v'
abbr -a grmu 'git remote set-url'
# Tag
abbr -a gt 'git tag'
abbr -a gta 'git tag -a'
abbr -a gtd 'git tag -d'
abbr -a gtl 'git tag -l'
abbr -a gtp 'git push --tags'
# Worktree
abbr -a gw 'git worktree'
abbr -a gwl 'git worktree list'
abbr -a gwa 'git worktree add'
abbr -a gwd 'git worktree remove'
# Submodule
abbr -a gsm 'git submodule'
abbr -a gsmu 'git submodule update --init --recursive'
abbr -a gsms 'git submodule sync'
# Bisect
abbr -a gbis 'git bisect'
abbr -a gbisr 'git bisect reset'
abbr -a gbiss 'git bisect start'
abbr -a gbisb 'git bisect bad'
abbr -a gbisg 'git bisect good'
# Reflog
abbr -a gref 'git reflog'
abbr -a grefl 'git reflog expire --expire=now --all'
# Misc
abbr -a gcln 'git clean -fd'
abbr -a gclnx 'git clean -fdx'
abbr -a gig 'git ls-files --others --exclude-standard'   # untracked
abbr -a gsig 'git verify-commit HEAD'   # verify GPG signature
abbr -a groot 'git rev-parse --show-toplevel'
abbr -a gcount 'git rev-list --count HEAD'
abbr -a gsize 'git count-objects -vH'
abbr -a gfix 'git add -A && git commit --amend --no-edit'
abbr -a glazyg 'git add . && git commit -m'

# ===========================================================================
# DOCKER  (~60 aliases)

# ===========================================================================
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a d 'docker'
abbr -a dv 'docker version'
abbr -a di 'docker images'
abbr -a dia 'docker images -a'
abbr -a dirm 'docker image rm'
abbr -a diprune 'docker image prune'
abbr -a dps 'docker ps'
abbr -a dpsa 'docker ps -a'
abbr -a drun 'docker run -it --rm'
abbr -a drunit 'docker run -it'
abbr -a dstart 'docker start'
abbr -a dstop 'docker stop'
abbr -a drestart 'docker restart'
abbr -a drm 'docker rm'
abbr -a drmf 'docker rm -f'
abbr -a dex 'docker exec -it'
abbr -a dlog 'docker logs -f'
abbr -a dlogs 'docker logs'
abbr -a dinsp 'docker inspect'
abbr -a dcp 'docker cp'
abbr -a dbuild 'docker build -t'
abbr -a dpull 'docker pull'
abbr -a dpush 'docker push'
abbr -a dnet 'docker network ls'
abbr -a dneta 'docker network inspect'
abbr -a dvol 'docker volume ls'
abbr -a dvola 'docker volume inspect'
abbr -a dprune 'docker system prune -af'
abbr -a dvprune 'docker volume prune -f'
abbr -a dnprune 'docker network prune -f'
abbr -a dcprune 'docker container prune -f'
abbr -a dstats 'docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
abbr -a dtop 'docker stats --no-stream'
abbr -a dip 'docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
# Docker Compose
abbr -a dc 'docker compose'           # v2 syntax
abbr -a dco 'docker-compose'         # v1 fallback
abbr -a dcu 'docker compose up -d'
abbr -a dcud 'docker compose up'
abbr -a dcd 'docker compose down'
abbr -a dcdv 'docker compose down -v'
abbr -a dcr 'docker compose restart'
abbr -a dcb 'docker compose build'
abbr -a dcl 'docker compose logs -f'
abbr -a dce 'docker compose exec'
abbr -a dcp2 'docker compose pull'
abbr -a dcps 'docker compose ps'
abbr -a dcconfig 'docker compose config'
end


# ===========================================================================
# CLOUD & DEVOPS (Supreme+ Only)

# ===========================================================================
# Kubernetes (~70 aliases)
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a k 'kubectl'
abbr -a kv 'kubectl version'
abbr -a kctx 'kubectl config use-context'
abbr -a kns 'kubectl config set-context --current --namespace'
abbr -a kgctx 'kubectl config get-contexts'
abbr -a kccfg 'kubectl config view'
# Get
abbr -a kg 'kubectl get'
abbr -a kgp 'kubectl get pods'
abbr -a kgpa 'kubectl get pods -A'
abbr -a kgd 'kubectl get deployments'
abbr -a kgda 'kubectl get deployments -A'
abbr -a kgs 'kubectl get svc'
abbr -a kgsa 'kubectl get svc -A'
abbr -a kgi 'kubectl get ingress'
abbr -a kgn 'kubectl get nodes'
abbr -a kgno 'kubectl get nodes -o wide'
abbr -a kgcm 'kubectl get configmap'
abbr -a kgsec 'kubectl get secret'
abbr -a kgpv 'kubectl get pv'
abbr -a kgpvc 'kubectl get pvc'
abbr -a kgns 'kubectl get namespace'
abbr -a kga 'kubectl get all'
abbr -a kgaa 'kubectl get all -A'
abbr -a kgcj 'kubectl get cronjob'
abbr -a kgj 'kubectl get job'
abbr -a kgrs 'kubectl get replicaset'
abbr -a kgss 'kubectl get statefulset'
abbr -a kgds 'kubectl get daemonset'
abbr -a kghpa 'kubectl get hpa'
# Describe
abbr -a kd 'kubectl describe'
abbr -a kdp 'kubectl describe pod'
abbr -a kdd 'kubectl describe deployment'
abbr -a kds 'kubectl describe svc'
abbr -a kdn 'kubectl describe node'
# Apply / Create / Delete
abbr -a ka 'kubectl apply -f'
abbr -a kar 'kubectl apply -R -f'
abbr -a kc 'kubectl create'
abbr -a kdel 'kubectl delete'
abbr -a kdelp 'kubectl delete pod'
abbr -a kdeld 'kubectl delete deployment'
# Logs / Exec
abbr -a kl 'kubectl logs -f'
abbr -a kla 'kubectl logs -f --all-containers'
abbr -a klp 'kubectl logs -f --previous'
abbr -a kex 'kubectl exec -it'
abbr -a kpf 'kubectl port-forward'
# Scale / Rollout
abbr -a ksc 'kubectl scale'
abbr -a kro 'kubectl rollout'
abbr -a kros 'kubectl rollout status'
abbr -a kroh 'kubectl rollout history'
abbr -a krou 'kubectl rollout undo'
# Misc
abbr -a ktop 'kubectl top'
abbr -a ktopp 'kubectl top pod'
abbr -a ktonn 'kubectl top node'
abbr -a krun 'kubectl run -it --rm --image'
abbr -a kcurl 'kubectl run curl-test --image=curlimages/curl -it --rm --'
abbr -a kdrain 'kubectl drain --ignore-daemonsets --delete-emptydir-data'
abbr -a kuncordon 'kubectl uncordon'
abbr -a kcordon 'kubectl cordon'
abbr -a ktaint 'kubectl taint'
end


# ===========================================================================
# TERRAFORM (~30 aliases)

# ===========================================================================
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a tf 'terraform'
abbr -a tfi 'terraform init'
abbr -a tfiu 'terraform init -upgrade'
abbr -a tfp 'terraform plan'
abbr -a tfpa 'terraform plan -out=tfplan'
abbr -a tfa 'terraform apply'
abbr -a tfaa 'terraform apply -auto-approve'
abbr -a tfd 'terraform destroy'
abbr -a tfda 'terraform destroy -auto-approve'
abbr -a tfv 'terraform validate'
abbr -a tff 'terraform fmt'
abbr -a tffr 'terraform fmt -recursive'
abbr -a tfs 'terraform show'
abbr -a tfo 'terraform output'
abbr -a tfstate 'terraform state'
abbr -a tfsl 'terraform state list'
abbr -a tfsshow 'terraform state show'
abbr -a tfg 'terraform graph | dot -Tpng > graph.png'
abbr -a tfwl 'terraform workspace list'
abbr -a tfwn 'terraform workspace new'
abbr -a tfws 'terraform workspace select'
abbr -a tfimport 'terraform import'
abbr -a tftaint 'terraform taint'
abbr -a tfuntaint 'terraform untaint'
abbr -a tfdoc 'terraform-docs markdown . 2>/dev/null'
end


# ===========================================================================
# HELM (~25 aliases)

# ===========================================================================
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a hls 'helm list'
abbr -a hlsa 'helm list -A'
abbr -a hin 'helm install'
abbr -a hup 'helm upgrade'
abbr -a hupi 'helm upgrade --install'
abbr -a hdel 'helm uninstall'
abbr -a hsr 'helm search repo'
abbr -a hsh 'helm search hub'
abbr -a hre 'helm repo'
abbr -a hrea 'helm repo add'
abbr -a hreu 'helm repo update'
abbr -a hrel 'helm repo list'
abbr -a hstat 'helm status'
abbr -a hhist 'helm history'
abbr -a hroll 'helm rollback'
abbr -a hget 'helm get'
abbr -a hgetv 'helm get values'
abbr -a hgetn 'helm get notes'
abbr -a htp 'helm template'
abbr -a hlint 'helm lint'
abbr -a hdry 'helm install --dry-run --debug'
abbr -a henv 'helm env'
end


# ===========================================================================
# ANSIBLE (~20 aliases)

# ===========================================================================
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a ans 'ansible'
abbr -a ansplay 'ansible-playbook'
abbr -a ansinv 'ansible-inventory'
abbr -a anscheck 'ansible-playbook --check'
abbr -a ansdiff 'ansible-playbook --check --diff'
abbr -a ansvault 'ansible-vault'
abbr -a ansenc 'ansible-vault encrypt'
abbr -a ansdec 'ansible-vault decrypt'
abbr -a ansgalaxy 'ansible-galaxy'
abbr -a ansping 'ansible all -m ping'
abbr -a ansfacts 'ansible all -m setup'
end


# ===========================================================================
# NETWORK & SECURITY (~80 aliases)

# ===========================================================================
abbr -a fastping 'ping -c 100 -s.2'
abbr -a ping6 'ping6 -c 5'
abbr -a tracert 'traceroute'
abbr -a myip 'curl -4s ifconfig.me && echo'
abbr -a myip6 'curl -6s ifconfig.me && echo'
abbr -a myips 'ip -br addr'
abbr -a ipl 'ip -br link'
abbr -a ipa 'ip -br addr'
abbr -a ipr 'ip route'
abbr -a ipn 'ip neigh'
abbr -a ipstats 'ip -s link'
abbr -a ports 'ss -tulanp'
abbr -a listening 'ss -tlnp'
abbr -a established 'ss -tnp state established'
abbr -a portcheck 'nc -zv'
abbr -a curl 'curl -L --retry 3'
abbr -a httpd 'python3 -m http.server'
# DNS
        abbr -a dig 'dog'
abbr -a nsl 'nslookup'
abbr -a digany 'dig +nocmd any +multiline +noall +answer'
abbr -a digtrace 'dig +trace'
abbr -a digshort 'dig +short'
abbr -a flushDNS 'sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches 2>/dev/null || sudo dscacheutil -flushcache 2>/dev/null'
# SSH
abbr -a ssha 'ssh-add'
abbr -a sshl 'ssh-add -l'
abbr -a sshD 'ssh-add -D'
abbr -a sshk 'ssh-keyscan'
abbr -a sshfp 'ssh-keygen -lf'
abbr -a sshcopy 'ssh-copy-id'
abbr -a sshrm 'ssh-keygen -R'
abbr -a sshconfig '$EDITOR ~/.ssh/config'
# Firewall shortcuts (ufw / iptables / pfctl)
abbr -a fwstatus 'sudo ufw status verbose 2>/dev/null || sudo iptables -L -n -v 2>/dev/null'
abbr -a fwenable 'sudo ufw enable'
abbr -a fwdisable 'sudo ufw disable'
abbr -a fwall 'sudo ufw allow'
abbr -a fwdeny 'sudo ufw deny'
# OpenSSL / TLS
abbr -a sslcheck 'openssl s_client -connect'
abbr -a sslcert 'openssl x509 -noout -text -in'
abbr -a ssldate 'openssl s_client -connect -servername </dev/null 2>/dev/null | openssl x509 -noout -dates'
abbr -a genkey 'openssl genrsa -out'
abbr -a gencsr 'openssl req -new -key'
# GPG / PGP
abbr -a gpglist 'gpg --list-keys'
abbr -a gpglistsec 'gpg --list-secret-keys'
abbr -a gpgenc 'gpg --encrypt --armor'
abbr -a gpgdec 'gpg --decrypt'
abbr -a gpgsign 'gpg --clearsign'
abbr -a gpgverify 'gpg --verify'
abbr -a gpgimport 'gpg --import'
abbr -a gpgexport 'gpg --armor --export'
abbr -a gpgrecv 'gpg --recv-keys'
abbr -a gpgsend 'gpg --send-keys'
abbr -a gpgfp 'gpg --fingerprint'
# Security scanning
abbr -a nmap 'nmap -v'
abbr -a nmapfast 'nmap -T4 -F'
abbr -a nmapfull 'nmap -T4 -A -v'
abbr -a nmapstealth 'sudo nmap -sS -O'
abbr -a nmapudp 'sudo nmap -sU'
abbr -a nmapvuln 'nmap --script vuln'
abbr -a portscan 'nmap -sV --version-intensity 5'
# File integrity
abbr -a sha256 'sha256sum'
abbr -a sha512 'sha512sum'
abbr -a md5 'md5sum'
abbr -a checksum 'sha256sum'
# Secure delete
abbr -a srm 'shred -u -z -n 3'   # secure remove (3-pass)

# ===========================================================================
# SYSTEMD / SERVICE MANAGEMENT

# ===========================================================================
abbr -a sc 'systemctl'
abbr -a scs 'systemctl status'
abbr -a scst 'systemctl start'
abbr -a scsp 'systemctl stop'
abbr -a scena 'systemctl enable'
abbr -a scenas 'systemctl enable --now'
abbr -a scdis 'systemctl disable'
abbr -a scdiss 'systemctl disable --now'
abbr -a scl 'systemctl list-units --type=service'
abbr -a scla 'systemctl list-units --type=service --all'
abbr -a scfail 'systemctl --failed'
abbr -a scedit 'systemctl edit'
abbr -a sccat 'systemctl cat'
abbr -a scdep 'systemctl list-dependencies'
abbr -a scboot 'systemctl list-units --type=service --state=running'
abbr -a jc 'journalctl'
abbr -a jce 'journalctl -xe'
abbr -a jcf 'journalctl -f'
abbr -a jcu 'journalctl -u'
abbr -a jcb 'journalctl -b'
abbr -a jcp 'journalctl -p err'     # errors only
abbr -a jcn 'journalctl -n 50'      # last 50 lines
abbr -a jcclear 'sudo journalctl --vacuum-time=7d'
# RC/OpenRC (Gentoo/Alpine/Void)
abbr -a rcs 'rc-service'
abbr -a rcst 'rc-service start'
abbr -a rcsp 'rc-service stop'
abbr -a rcr 'rc-service restart'
abbr -a rcu 'rc-update'

# ===========================================================================
# PACKAGE MANAGERS — per-distro  (all conditional on binary existence)

# ===========================================================================
# ── Arch / Manjaro ──────────────────────────────────────────────────────────
        abbr -a pac 'sudo pacman'
        abbr -a paci 'sudo pacman -S --noconfirm'
        abbr -a pacI 'sudo pacman -S'              # with confirmation
        abbr -a pacr 'sudo pacman -Rns'
        abbr -a pacu 'sudo pacman -Syu'
        abbr -a pacs 'pacman -Ss'
        abbr -a pacl 'pacman -Q'
        abbr -a pacll 'pacman -Qe'               # explicitly installed
        abbr -a paclo 'pacman -Qdtq'             # orphans
        abbr -a paclf 'pacman -Ql'              # files in package
        abbr -a pacown 'pacman -Qo'             # which pkg owns file
        abbr -a pacinfo 'pacman -Qi'
        abbr -a pacclean 'sudo pacman -Rns $(pacman -Qdtq)'
        abbr -a pacmirror 'sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
        abbr -a packeys 'sudo pacman-key --refresh-keys'
        abbr -a y 'yay'
        abbr -a ys 'yay -Ss'
        abbr -a par 'paru'
        abbr -a paru 'paru -Syu'
# ── Debian / Ubuntu ─────────────────────────────────────────────────────────
        abbr -a apti 'sudo apt-get install -y'
        abbr -a aptI 'sudo apt-get install'
        abbr -a aptr 'sudo apt-get remove -y'
        abbr -a aptrm 'sudo apt-get purge -y'
        abbr -a aptu 'sudo apt-get update && sudo apt-get upgrade -y'
        abbr -a aptfu 'sudo apt-get update && sudo apt-get full-upgrade -y'
        abbr -a apts 'apt-cache search'
        abbr -a aptsh 'apt-cache show'
        abbr -a aptl 'dpkg -l'
        abbr -a aptll 'apt list --installed 2>/dev/null'
        abbr -a aptclean 'sudo apt-get autoremove -y && sudo apt-get autoclean'
        abbr -a aptfix 'sudo apt-get install -f'
        abbr -a aptheld 'apt-mark showhold'
        abbr -a apthold 'sudo apt-mark hold'
        abbr -a aptunhold 'sudo apt-mark unhold'
# ── Fedora / RHEL / CentOS ──────────────────────────────────────────────────
        abbr -a dnfi 'sudo dnf install -y'
        abbr -a dnfI 'sudo dnf install'
        abbr -a dnfr 'sudo dnf remove -y'
        abbr -a dnfu 'sudo dnf upgrade -y'
        abbr -a dnfs 'dnf search'
        abbr -a dnfl 'dnf list installed'
        abbr -a dnfc 'sudo dnf clean all'
        abbr -a dnfh 'dnf history'
        abbr -a dnfinfo 'dnf info'
        abbr -a dnfgrp 'dnf grouplist'
        abbr -a dnfcheck 'dnf check-update'
        abbr -a yumi 'sudo yum install -y'
        abbr -a yumr 'sudo yum remove -y'
        abbr -a yumu 'sudo yum update -y'
        abbr -a yums 'yum search'
        abbr -a yuml 'yum list installed'
# ── openSUSE / SLES ─────────────────────────────────────────────────────────
        abbr -a zypi 'sudo zypper install -y'
        abbr -a zypr 'sudo zypper remove -y'
        abbr -a zypu 'sudo zypper update -y'
        abbr -a zypdu 'sudo zypper dist-upgrade -y'
        abbr -a zyps 'zypper search'
        abbr -a zypl 'zypper packages --installed-only'
        abbr -a zypc 'sudo zypper clean'
        abbr -a zypinfo 'zypper info'
# ── Void Linux ──────────────────────────────────────────────────────────────
        abbr -a xbpsi 'sudo xbps-install -Sy'
        abbr -a xbpsr 'sudo xbps-remove -R'
        abbr -a xbpsu 'sudo xbps-install -Su'
        abbr -a xbpss 'xbps-query -Rs'
        abbr -a xbpsl 'xbps-query -l'
        abbr -a xbpsc 'sudo xbps-remove -O'
# ── Alpine Linux ─────────────────────────────────────────────────────────────
        abbr -a apki 'sudo apk add'
        abbr -a apkr 'sudo apk del'
        abbr -a apku 'sudo apk upgrade'
        abbr -a apks 'apk search'
        abbr -a apkl 'apk list --installed'
        abbr -a apkinfo 'apk info'
# ── Gentoo ──────────────────────────────────────────────────────────────────
        abbr -a emeri 'sudo emerge -av'
        abbr -a emerr 'sudo emerge --unmerge'
        abbr -a emeru 'sudo emerge --update --deep --newuse @world'
        abbr -a emers 'emerge -s'
        abbr -a emerc 'sudo eclean-dist && sudo eclean-pkg'
# ── NixOS ───────────────────────────────────────────────────────────────────
        abbr -a nixi 'nix-env -iA'
        abbr -a nixr 'nix-env -e'
        abbr -a nixu 'nix-env -u'
        abbr -a nixs 'nix-env -qaP'
        abbr -a nixl 'nix-env -q'
        abbr -a nixgc 'nix-collect-garbage -d'
        abbr -a nixrebuild 'sudo nixos-rebuild switch'
        abbr -a nixtest 'sudo nixos-rebuild test'
# ── macOS Homebrew ───────────────────────────────────────────────────────────
        abbr -a brewi 'brew install'
        abbr -a brewr 'brew uninstall'
        abbr -a brewu 'brew update && brew upgrade'
        abbr -a brews 'brew search'
        abbr -a brewl 'brew list'
        abbr -a brewinfo 'brew info'
        abbr -a brewc 'brew cleanup'
        abbr -a brewd 'brew doctor'
        abbr -a brewdep 'brew deps --tree'
        abbr -a brewcask 'brew install --cask'
        abbr -a brewcaskr 'brew uninstall --cask'
        abbr -a brewcasklist 'brew list --cask'
        abbr -a brewpin 'brew pin'
        abbr -a brewunpin 'brew unpin'
        abbr -a brewpinned 'brew list --pinned'
# ── Flatpak ──────────────────────────────────────────────────────────────────
        abbr -a flati 'flatpak install -y'
        abbr -a flatr 'flatpak uninstall -y'
        abbr -a flatu 'flatpak update -y'
        abbr -a flats 'flatpak search'
        abbr -a flatl 'flatpak list'
        abbr -a flatrun 'flatpak run'
        abbr -a flatc 'flatpak uninstall --unused -y'
# ── Snap ─────────────────────────────────────────────────────────────────────
        abbr -a snapi 'sudo snap install'
        abbr -a snapr 'sudo snap remove'
        abbr -a snapu 'sudo snap refresh'
        abbr -a snaps 'snap find'
        abbr -a snapl 'snap list'

# ===========================================================================
# CLOUD — AWS CLI

# ===========================================================================
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
        abbr -a awswho 'aws sts get-caller-identity'
        abbr -a awsprofile 'aws configure list'
        abbr -a awsprofiles 'aws configure list-profiles'
        abbr -a awsregion 'aws configure get region'
        abbr -a awsec2 'aws ec2 describe-instances'
        abbr -a awss3 'aws s3 ls'
        abbr -a awss3cp 'aws s3 cp'
        abbr -a awss3sync 'aws s3 sync'
        abbr -a awseks 'aws eks list-clusters'
        abbr -a awslambda 'aws lambda list-functions'
        abbr -a awsrds 'aws rds describe-db-instances'
        abbr -a awslogs 'aws logs describe-log-groups'
        abbr -a awsiam 'aws iam list-users'
        abbr -a awscost 'aws ce get-cost-and-usage'
        abbr -a awssm 'aws secretsmanager list-secrets'
        abbr -a awsssm 'aws ssm describe-parameters'
        abbr -a awsecs 'aws ecs list-clusters'
# ── GCP ──────────────────────────────────────────────────────────────────────
        abbr -a gcp 'gcloud'
        abbr -a gcpwho 'gcloud auth list'
        abbr -a gcpproj 'gcloud config get-value project'
        abbr -a gcpprojs 'gcloud projects list'
        abbr -a gcpset 'gcloud config set project'
        abbr -a gcpvm 'gcloud compute instances list'
        abbr -a gcpgke 'gcloud container clusters list'
        abbr -a gcprun 'gcloud run services list'
# ── Azure ─────────────────────────────────────────────────────────────────────
end

        abbr -a azwho 'az account show'
        abbr -a azsub 'az account list'
        abbr -a azrg 'az group list'
        abbr -a azvm 'az vm list'
        abbr -a azaks 'az aks list'

# ===========================================================================
# DEVELOPMENT — Python / pip / uv / poetry

# ===========================================================================
abbr -a py 'python3'
abbr -a py2 'python2'
abbr -a pip 'pip3'
abbr -a pipi 'pip3 install'
abbr -a pipiu 'pip3 install --upgrade'
abbr -a pipun 'pip3 uninstall -y'
abbr -a pipl 'pip3 list'
abbr -a pipf 'pip3 freeze'
abbr -a pipfr 'pip3 freeze > requirements.txt'
abbr -a pipir 'pip3 install -r requirements.txt'
abbr -a pipout 'pip3 list --outdated'
abbr -a pipcheck 'pip3 check'
abbr -a pipsec 'pip3 audit 2>/dev/null || pip3 install pip-audit && pip-audit'
abbr -a venv 'python3 -m venv'
abbr -a venva 'source .venv/bin/activate'
abbr -a venvd 'deactivate'
abbr -a mkvenv 'python3 -m venv .venv && source .venv/bin/activate'
        abbr -a uvi 'uv pip install'
        abbr -a uviu 'uv pip install --upgrade'
        abbr -a uvir 'uv pip install -r requirements.txt'
        abbr -a uvl 'uv pip list'
        abbr -a uvf 'uv pip freeze'
        abbr -a uvvenv 'uv venv'
        abbr -a uvrun 'uv run'
        abbr -a uvadd 'uv add'
        abbr -a uvrem 'uv remove'
        abbr -a uvsync 'uv sync'
        abbr -a uvlock 'uv lock'
        abbr -a po 'poetry'
        abbr -a poa 'poetry add'
        abbr -a poad 'poetry add --group dev'
        abbr -a poar 'poetry add --group test'
        abbr -a porm 'poetry remove'
        abbr -a pou 'poetry update'
        abbr -a poi 'poetry install'
        abbr -a por 'poetry run'
        abbr -a pos 'poetry shell'
        abbr -a pob 'poetry build'
        abbr -a popub 'poetry publish'
        abbr -a pock 'poetry check'
        abbr -a polock 'poetry lock'
        abbr -a poenv 'poetry env info'
        abbr -a poenvl 'poetry env list'
        abbr -a conl 'conda env list'
        abbr -a concr 'conda create -n'
        abbr -a conad 'conda activate'
        abbr -a conde 'conda deactivate'
        abbr -a conrm 'conda env remove -n'
        abbr -a coni 'conda install'
        abbr -a conu 'conda update'
        abbr -a cons 'conda search'
        abbr -a conex 'conda export > environment.yml'
        abbr -a confr 'conda env create -f environment.yml'

# ===========================================================================
# DEVELOPMENT — Node.js / npm / yarn / pnpm / bun

# ===========================================================================
abbr -a node 'node'
abbr -a ni 'npm install'
abbr -a nid 'npm install --save-dev'
abbr -a nig 'npm install -g'
abbr -a nrm 'npm uninstall'
abbr -a nr 'npm run'
abbr -a nrs 'npm run start'
abbr -a nrd 'npm run dev'
abbr -a nrb 'npm run build'
abbr -a nrt 'npm run test'
abbr -a nrl 'npm run lint'
abbr -a nrf 'npm run format'
abbr -a nrp 'npm run preview'
abbr -a nu 'npm update'
abbr -a nout 'npm outdated'
abbr -a nls 'npm list --depth=0'
abbr -a nlsg 'npm list -g --depth=0'
abbr -a ninfo 'npm info'
abbr -a naudit 'npm audit'
abbr -a nfix 'npm audit fix'
abbr -a ninit 'npm init -y'
abbr -a nci 'npm ci'
abbr -a ncache 'npm cache clean --force'
abbr -a npx 'npx --yes'
        abbr -a ya 'yarn add'
        abbr -a yad 'yarn add --dev'
        abbr -a yrm 'yarn remove'
        abbr -a yr 'yarn run'
        abbr -a yrs 'yarn start'
        abbr -a yrd 'yarn dev'
        abbr -a yrb 'yarn build'
        abbr -a yrt 'yarn test'
        abbr -a yi 'yarn install'
        abbr -a yu 'yarn upgrade'
        abbr -a yout 'yarn outdated'
        abbr -a yls 'yarn list --depth=0'
        abbr -a pni 'pnpm install'
        abbr -a pna 'pnpm add'
        abbr -a pnad 'pnpm add --save-dev'
        abbr -a pnrm 'pnpm remove'
        abbr -a pnr 'pnpm run'
        abbr -a pnd 'pnpm dev'
        abbr -a pnb 'pnpm build'
        abbr -a pnt 'pnpm test'
        abbr -a pnu 'pnpm update'
        abbr -a pnls 'pnpm list'
        abbr -a pnx 'pnpm dlx'
        abbr -a bi 'bun install'
        abbr -a ba 'bun add'
        abbr -a bad 'bun add --dev'
        abbr -a brm 'bun remove'
        abbr -a brun 'bun run'
        abbr -a bx 'bunx'
        abbr -a bu 'bun update'

# ===========================================================================
# DEVELOPMENT — Rust / Cargo

# ===========================================================================
abbr -a cr 'cargo run'
abbr -a crr 'cargo run --release'
abbr -a cb 'cargo build'
abbr -a cbr 'cargo build --release'
abbr -a ct 'cargo test'
abbr -a cta 'cargo test --all'
abbr -a cc 'cargo check'
abbr -a cf 'cargo fmt'
abbr -a cfl 'cargo clippy'
abbr -a cflfix 'cargo clippy --fix'
abbr -a cdoc 'cargo doc --open'
abbr -a cnew 'cargo new'
abbr -a cinit 'cargo init'
abbr -a cadd 'cargo add'
abbr -a crm 'cargo remove'
abbr -a cclean 'cargo clean'
abbr -a cupdate 'cargo update'
abbr -a ctree 'cargo tree'
abbr -a csearch 'cargo search'
abbr -a cpub 'cargo publish'
abbr -a clogin 'cargo login'
abbr -a cinstall 'cargo install'
abbr -a cben 'cargo bench'
abbr -a cwatch 'cargo watch -x run'

# ===========================================================================
# DEVELOPMENT — Go

# ===========================================================================
abbr -a gor 'go run .'
abbr -a gob 'go build .'
abbr -a got 'go test ./...'
abbr -a gotv 'go test -v ./...'
abbr -a gotc 'go test -cover ./...'
abbr -a gomod 'go mod tidy'
abbr -a gomodinit 'go mod init'
abbr -a goget 'go get'
abbr -a goinst 'go install'
abbr -a govet 'go vet ./...'
abbr -a gofmt 'gofmt -w .'
abbr -a golint 'golangci-lint run'
abbr -a gobuild 'CGO_ENABLED=0 go build -ldflags="-s -w"'
abbr -a goenv 'go env'
abbr -a gopath 'echo $GOPATH'
abbr -a gowork 'go work'

# ===========================================================================
# DEVELOPMENT — Rust / Make / CMake / misc

# ===========================================================================
abbr -a mk 'make'
abbr -a mkc 'make clean'
abbr -a mki 'make install'
abbr -a mkt 'make test'
abbr -a mkj 'make -j$(nproc)'
abbr -a cmake 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
abbr -a cmakeb 'cmake --build build'
abbr -a cmakec 'cmake --build build --target clean'
abbr -a ninja 'ninja -C build'

# ===========================================================================
# DEVELOPMENT — Java / Maven / Gradle

# ===========================================================================
abbr -a javac 'javac -encoding UTF-8'
abbr -a mvnc 'mvn clean'
abbr -a mvni 'mvn clean install'
abbr -a mvnt 'mvn test'
abbr -a mvnp 'mvn package'
abbr -a mvns 'mvn spring-boot:run'
abbr -a gradle './gradlew'
abbr -a gradleb './gradlew build'
abbr -a gradlet './gradlew test'
abbr -a gradlec './gradlew clean'
abbr -a gradlew './gradlew'

# ===========================================================================
# DEVELOPMENT — Ruby / PHP / Perl

# ===========================================================================
        abbr -a rbi 'bundle install'
        abbr -a rbu 'bundle update'
        abbr -a rbe 'bundle exec'
        abbr -a rbr 'bundle exec rails'
        abbr -a rbrs 'bundle exec rails server'
        abbr -a rbrc 'bundle exec rails console'
        abbr -a rspec 'bundle exec rspec'
        abbr -a phpi 'php -a'               # interactive REPL
        abbr -a compi 'composer install'
        abbr -a compu 'composer update'
        abbr -a compr 'composer require'
        abbr -a compa 'composer dump-autoload'
        abbr -a artisan 'php artisan'
        abbr -a ptest './vendor/bin/phpunit'

# ===========================================================================
# DATABASE CLIENTS

# ===========================================================================
        abbr -a pgdbs 'psql -c "\l"'
        abbr -a pgtbls 'psql -c "\dt"'
        abbr -a pgdump 'pg_dump'
        abbr -a pgrestore 'pg_restore'
        abbr -a mqdbs 'mysql -e "SHOW DATABASES;"'
        abbr -a mqdump 'mysqldump'
        abbr -a redisping 'redis-cli ping'
        abbr -a redisflush 'redis-cli flushall'
        abbr -a rediskeys 'redis-cli keys "*"'
        abbr -a redismon 'redis-cli monitor'
        abbr -a mongodbs 'mongosh --eval "db.adminCommand({listDatabases:1})"'
        abbr -a sq 'sqlite3'

# ===========================================================================
# TMUX

# ===========================================================================
        abbr -a t 'tmux'
        abbr -a ta 'tmux attach'
        abbr -a tl 'tmux list-sessions'
        abbr -a tn 'tmux new-session -s'
        abbr -a tk 'tmux kill-session -t'
        abbr -a tka 'tmux kill-server'
        abbr -a tr 'tmux rename-session -t'
        abbr -a tls 'tmux list-windows'
        abbr -a tsh 'tmux split-window -h'
        abbr -a tsv 'tmux split-window -v'

# ===========================================================================
# TERMINAL MULTIPLEXERS

# ===========================================================================
        abbr -a zj 'zellij'
        abbr -a zja 'zellij attach'
        abbr -a zjl 'zellij list-sessions'
        abbr -a zjk 'zellij kill-session'
        abbr -a zjka 'zellij kill-all-sessions'
        abbr -a scr 'screen'
        abbr -a scra 'screen -r'
        abbr -a scrl 'screen -ls'

# ===========================================================================
# MODERN CLI TOOLS

# ===========================================================================
        abbr -a lg 'lazygit'
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
        abbr -a ld 'lazydocker'
end

        abbr -a Y 'yazi'                # capital Y = yazi (lowercase y = function that cd's)
        abbr -a fzfp 'fzf --preview "bat --style=numbers --color=always {}"'
        abbr -a zi 'z -i'              # interactive zoxide
        abbr -a bench 'hyperfine'
        abbr -a cloc 'tokei'
        abbr -a duu 'dust'
        abbr -a duff 'duf'
        abbr -a ping 'gping'
        abbr -a xh 'curlie'
        abbr -a jqp 'jq --color-output .'
        abbr -a json 'jq .'
        abbr -a yaml 'yq .'
        abbr -a md 'glow'
        abbr -a help 'tldr'
        abbr -a man2 'tldr'
        abbr -a fuck 'thefuck $(history -p !!)'

# ===========================================================================
# ARCHIVES / COMPRESSION

# ===========================================================================
abbr -a targz 'tar -zcvf'
abbr -a tarbz 'tar -jcvf'
abbr -a tarxz 'tar -Jcvf'
abbr -a tarzst 'tar --zstd -cvf'
abbr -a unzip 'unzip -q'
abbr -a zip 'zip -r'
abbr -a mkzip 'zip -r'
abbr -a mktarbz 'tar -cjvf'
abbr -a mktarxz 'tar -cJvf'

# ===========================================================================
# UTILITIES

# ===========================================================================
abbr -a now 'date +"%Y-%m-%d %H:%M:%S"'
abbr -a nowutc 'date -u +"%Y-%m-%dT%H:%M:%SZ"'
abbr -a today 'date +"%Y-%m-%d"'
abbr -a week 'date +%V'
abbr -a ts 'date +%s'               # unix timestamp
abbr -a epoch 'date +%s'
abbr -a clr 'clear'
abbr -a c 'clear'
abbr -a q 'exit'
abbr -a :q 'exit'
abbr -a logout 'exit'
abbr -a sudoo 'sudo '
abbr -a root 'sudo -i'
abbr -a whoami 'whoami'
abbr -a id 'id'
abbr -a groups 'groups'
abbr -a path 'echo $PATH | tr ":" "\n" | nl'
abbr -a envv 'env | sort | less'
abbr -a reload 'exec $SHELL -l'
abbr -a brew-up 'brew bundle dump --force --file="$DOTFILES_DIR/apps/brew/Brewfile" && brew bundle'
abbr -a histg 'history | grep'
abbr -a hh 'history | head -20'
abbr -a ht 'history | tail -20'
function dupl
    history | awk '{print $argv[2]}' | sort | uniq -c | sort -rn | head -20
end
# Weather
abbr -a weather 'curl -s wttr.in'
abbr -a wttr 'curl -s "wttr.in?format=3"'
abbr -a wttrf 'curl -s "wttr.in?format=v2"'
# Fun / misc
abbr -a starwars 'telnet towel.blinkenlights.nl 2>/dev/null || echo "telnet not installed"'
abbr -a matrix 'cmatrix -C cyan 2>/dev/null'
abbr -a pipes 'pipes.sh 2>/dev/null'
abbr -a cowsay 'cowsay -f tux'
abbr -a sl 'ls'                    # typo fix
abbr -a Grep 'grep'                # typo fix
abbr -a GREP 'grep'                # typo fix
# Dotfiles management
abbr -a dotlog 'git -C "$DOTFILES_DIR" log --oneline -15'
abbr -a dotst 'git -C "$DOTFILES_DIR" status'
abbr -a dotdiff 'git -C "$DOTFILES_DIR" diff'
abbr -a dotpull 'git -C "$DOTFILES_DIR" pull'
abbr -a dotpush 'git -C "$DOTFILES_DIR" add -A && git -C "$DOTFILES_DIR" commit && git -C "$DOTFILES_DIR" push'
abbr -a dotdocs '$BROWSER "$HOME/.dotfiles/docs/index.html"'
# Quick file/dir sizes
abbr -a dh 'du -h --max-depth=1 | sort -rh'
abbr -a biggest 'du -h --max-depth=1 | sort -rh | head 10'
# Clipboard (Linux xclip/xsel/wl-copy, macOS pbcopy)
if test "$DOTFILES_OS" = "Darwin"
        abbr -a copy 'pbcopy'
        abbr -a paste 'pbpaste'
else if type -q wl-copy >/dev/null 2>&1
        abbr -a copy 'wl-copy'
        abbr -a paste 'wl-paste'
else if type -q xclip >/dev/null 2>&1
        abbr -a copy 'xclip -selection clipboard'
        abbr -a paste 'xclip -selection clipboard -o'
else if type -q xsel >/dev/null 2>&1
        abbr -a copy 'xsel --clipboard --input'
        abbr -a paste 'xsel --clipboard --output'
end
# Open file/URL (cross-platform)
        abbr -a open 'open'
        abbr -a open 'xdg-open'
abbr -a o 'open'

# ===========================================================================
# ALIASES (ZachBrowne / Titus)

# ===========================================================================
abbr -a spico 'sudo pico'
abbr -a snano 'sudo nano'
abbr -a web 'cd /var/www/html'
abbr -a alert 'notify-send "Done!"'
abbr -a ebrc 'edit ~/.bashrc'
abbr -a hlp 'less ~/.bashrc_help'
abbr -a da 'date "+%Y-%m-%d %A %T %Z"'
abbr -a cls 'clear'
abbr -a multitail 'multitail --no-repeat -c'
abbr -a freshclam 'sudo freshclam'
abbr -a svi 'sudo vi'
abbr -a vis 'nvim "+set si"'
abbr -a yayf "yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
abbr -a bd 'cd "$OLDPWD"'
abbr -a rmd '/bin/rm  --recursive --force --verbose '
abbr -a lx 'ls -lXBh'
abbr -a lk 'ls -lSrh'
abbr -a lc 'ls -ltcrh'
abbr -a lu 'ls -lturh'
abbr -a lr 'ls -lRh'
abbr -a lm 'ls -alh |more'
abbr -a lw 'ls -xAh'
abbr -a labc 'ls -lap'
abbr -a lf "ls -l | egrep -v '^d'"
abbr -a ldir "ls -l | egrep '^d'"
abbr -a mx 'chmod a+x'
abbr -a 000 'chmod -R 000'
abbr -a 644 'chmod -R 644'
abbr -a 666 'chmod -R 666'
abbr -a 755 'chmod -R 755'
abbr -a 777 'chmod -R 777'
abbr -a h "history | grep "
abbr -a p "ps aux | grep "
abbr -a topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
abbr -a f "find . | grep "
function countfiles
    for t in files links directories
    ; echo (find . -type $t:0:1 | wc -l) "$t"
    end 2> /dev/null
end
abbr -a checkcommand "type -t"
abbr -a openports 'netstat -nape --inet'
abbr -a rebootsafe 'sudo shutdown -r now'
abbr -a rebootforce 'sudo shutdown -r -n now'
abbr -a diskspace "du -S | sort -n -r |more"
abbr -a folders 'du -h --max-depth=1'
abbr -a folderssort 'find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
abbr -a treed 'tree -CAFd'
abbr -a mountedinfo 'df -hT'
abbr -a mktar 'tar -cvf'
abbr -a mkbz2 'tar -cvjf'
abbr -a mkgz 'tar -cvzf'
abbr -a unbz2 'tar -xvjf'
abbr -a ungz 'tar -xvzf'
abbr -a sha1 'openssl sha1'
abbr -a clickpaste 'sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
abbr -a kssh "kitty +kitten ssh"
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
abbr -a docker-clean ' docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f '
end

abbr -a hug "systemctl --user restart hugo"
abbr -a lanm "systemctl --user restart lan-mouse"

# ===========================================================================
# NEW ALIASES (Garuda/Awesome)

# ===========================================================================
    abbr -a ls 'eza -al --color=always --group-directories-first --icons'
    abbr -a la 'eza -a --color=always --group-directories-first --icons'
    abbr -a ll 'eza -l --color=always --group-directories-first --icons'
    abbr -a lt 'eza -aT --color=always --group-directories-first --icons'
    abbr -a l. 'eza -ald --color=always --group-directories-first --icons .*'
    abbr -a cat 'bat --style header --style snip --style changes --style header'
abbr -a grubup "sudo update-grub"
abbr -a fixpacman "sudo rm /var/lib/pacman/db.lck"
abbr -a tarnow 'tar -acf '
abbr -a untar 'tar -zxvf '
abbr -a wget 'wget -c '
abbr -a rmpkg "sudo pacman -Rdd"
abbr -a psmem 'ps auxf | sort -nr -k 4'
abbr -a psmem10 'ps auxf | sort -nr -k 4 | head -10'
abbr -a upd '/usr/bin/garuda-update'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a ...... 'cd ../../../../..'
abbr -a dir 'dir --color=auto'
abbr -a vdir 'vdir --color=auto'
abbr -a grep 'ugrep --color=auto'
abbr -a fgrep 'ugrep -F --color=auto'
abbr -a egrep 'ugrep -E --color=auto'
abbr -a hw 'hwinfo --short'
abbr -a big "expac -H M '%m\t%n' | sort -h | nl"
abbr -a gitpkg 'pacman -Q | grep -i "\-git" | wc -l'
abbr -a ip 'ip -color'
abbr -a mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
abbr -a mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
abbr -a mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
abbr -a mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
abbr -a apt 'man pacman'
abbr -a apt-get 'man pacman'
abbr -a please 'sudo'
abbr -a tb 'nc termbin.com 9999'
abbr -a helpme 'cht.sh --shell'
abbr -a pacdiff 'sudo -H DIFFPROG=meld pacdiff'
abbr -a cleanup 'sudo pacman -Rns $(pacman -Qtdq)'
abbr -a jctl "journalctl -p 3 -xb"
abbr -a rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ===========================================================================
# SUPREME UPGRADE (Paul Irish / Mathias Bynens / Modern)

# ===========================================================================
# Navigation & System
abbr -a cdf 'cd "$(osascript -e "tell app \"Finder\" to POSIX path of (insertion location as alias)" 2>/dev/null || echo .)"'
abbr -a emptytrash "sudo rm -rfv /Volumes/*/.Trashes && sudo rm -rfv ~/.Trash"
abbr -a showfiles 'defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
abbr -a hidefiles 'defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
# Project Management Cleanup
abbr -a pclean 'find . -type d -name "__pycache__" -exec rm -rf {} + && find . -type f -name "*.pyc" -delete'
abbr -a nuke-node 'find . -name "node_modules" -type d -prune -exec rm -rf "{}" +'
# Modern Tools Shorthands
abbr -a v 'fd --type f --hidden --exclude .git | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" | xargs -r $EDITOR'
abbr -a fz 'zoxide query -i'
# Git Refinements
abbr -a gpristine 'git reset --hard && git clean -fdx'
abbr -a gwt 'git worktree'
abbr -a gwta 'git worktree add'
abbr -a gwtl 'git worktree list'
abbr -a gwtrm 'git worktree remove'