# =============================================================================
# .zsh/aliases.zsh  —  2000+ Unique, distro-agnostic, security-aware aliases
# All modern-tool aliases fall back gracefully if the tool isn't installed.
# =============================================================================

# ===========================================================================
# SAFETY

# ===========================================================================
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# ===========================================================================
# NAVIGATION

# ===========================================================================
alias "~" = "cd ~"
alias --='cd -'
alias home='cd ~'
alias back='cd -'
alias dots='cd "$DOTFILES_DIR"'
alias dotfiles='cd "$DOTFILES_DIR"'
alias dl='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias pics='cd ~/Pictures'
alias music='cd ~/Music'
alias vids='cd ~/Videos'
alias tmp='cd /tmp'
alias etc='cd /etc'
alias usrbin='cd /usr/bin'
alias localbin='cd ~/.local/bin'
alias confdir='cd ~/.config'

# ===========================================================================
# LISTING  (eza → exa → ls)

# ===========================================================================
    alias ltt='eza --tree --level=3 --icons'
    alias lttt='eza --tree --level=4 --icons'
    alias lll='eza -la --icons --git --color=auto --time-style=long-iso'
    alias llm='eza -la --icons --git --sort=modified'
    alias lls='eza -la --icons --git --sort=size'
    alias lle='eza -la --icons --git --sort=extension'
    alias lln='eza -la --icons --git --sort=name'
    alias treea='eza --tree --icons -a'
    alias tree='exa --tree --icons'

# ===========================================================================
# FILE VIEWING  (bat → cat)

# ===========================================================================
    alias catp='bat --style=plain --paging=never'
    alias bh='bat --style=header'
    alias bp='bat --style=plain'
    alias catn='batcat --style=plain'

# ===========================================================================
# SEARCHING  (fd → find, rg → grep, delta → diff)

# ===========================================================================
    alias find='fd -H'
    alias ff='fd -H'
    alias fdir='fd -t d'
    alias ffile='fd -t f'
    alias rgs='rg --smart-case --hidden -l'     # list files only
    alias rgn='rg --smart-case --hidden -N'     # no line numbers
    alias diff='delta'

# ===========================================================================
# PROCESS / SYSTEM MONITORING

# ===========================================================================
    alias htop='btop'
    alias top='htop'
    alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i'
alias pstree='pstree -p'
alias killi='kill -9'
alias killall9='killall -9'

# ===========================================================================
# SYSTEM INFO

# ===========================================================================
alias df='df -hT'
alias duh='du -sh'
alias free='free -h'
alias meminfo='cat /proc/meminfo'
alias cpuinfo='cat /proc/cpuinfo'
alias cpus='nproc'
alias arch='uname -m'
alias kernel='uname -r'
alias hostname='hostname -f'
alias uptime='uptime -p'
alias loadavg='cat /proc/loadavg'
alias boottime='who -b'
alias lscpu='lscpu'
alias lsblk='lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT'
alias lsusb='lsusb -v 2>/dev/null | head -50'
alias lspci='lspci -v'
alias dmidecode='sudo dmidecode'
# Fastfetch / neofetch
    alias neofetch='fastfetch'
    alias sf='neofetch'
    alias sysinfo='neofetch'
    alias fetch='neofetch'

# ===========================================================================
# DISK / STORAGE

# ===========================================================================
alias dff='df -hT | grep -v tmpfs'
alias diskfree='df -h --total | tail -1'
    alias du='gdu'
alias lsblka='lsblk -a'
alias mount='mount | column -t'

# ===========================================================================
# EDITORS

# ===========================================================================
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias svim='sudo nvim'
alias nano='nano -l'                     # line numbers in nano
# Quick config edits
alias ebash='$EDITOR ~/.bashrc'
alias ezsh='$EDITOR ~/.zshrc'
alias efish='$EDITOR ~/.config/fish/config.fish'
alias egit='$EDITOR ~/.gitconfig'
alias estarship='$EDITOR "$DOTFILES_DIR/apps/starship-linux.toml"'
alias efastfetch='$EDITOR "$DOTFILES_DIR/apps/fastfetch/config.jsonc"'
alias edots='$EDITOR "$DOTFILES_DIR"'
alias etmux='$EDITOR ~/.tmux.conf'
alias essh='$EDITOR ~/.ssh/config'
alias evimrc='$EDITOR ~/.config/nvim/init.lua'
alias dotupdate='$DOTFILES_DIR/bin/dotupdate.sh'
alias health='bash $DOTFILES_DIR/bin/health_check.sh'
alias dothealth='bash $DOTFILES_DIR/bin/health_check.sh'
# Reload
alias rbash='source ~/.bashrc'
alias rzsh='source ~/.zshrc'

# ===========================================================================
# GIT  (comprehensive — ~120 aliases)

# ===========================================================================
alias g='git'
alias gi='git init'
alias gcl='git clone'
alias gcld='git clone --depth=1'
# Status
alias gs='git status'
alias gss='git status -sb'
alias gsv='git status -v'
# Add / stage
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gau='git add -u'
alias gaf='git add -f'
# Commit
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcas='git commit --amend --squash'
alias gcf='git commit --fixup'
alias gcs='git commit -S'            # GPG-signed commit
# Branch
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch -r'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'
alias gbsort='git branch --sort=-committerdate'
alias gbclean='git branch --merged | grep -v "\*\|main\|master\|develop" | xargs -r git branch -d'
# Checkout / Switch
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcop='git checkout -p'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch main 2>/dev/null || git switch master'
# Diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias gdw='git diff --word-diff'
alias gdn='git diff --name-only'
alias gdstat='git diff --stat'
# Fetch / Pull / Push
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gpla='git pull --all'
alias gp='git push'
alias gpf='git push --force-with-lease'   # safe force push
alias gpt='git push --tags'
alias gpu='git push -u origin HEAD'
alias gpd='git push --dry-run'
# Log
alias gg='git log --oneline --graph --decorate'
alias gga='git log --oneline --graph --all --decorate'
alias ggl='git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias ggla='git log --graph --pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias gls='git log --stat'
alias gll='git log --pretty=fuller'
alias glp='git log --patch'
alias glf='git log --follow -p'           # follow file history
alias gwho='git shortlog -sn --all --no-merges'
# Rebase
alias gr='git rebase'
alias gri='git rebase -i'
alias grim='git rebase -i origin/main'
alias grih='git rebase -i HEAD~'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmnff='git merge --no-ff'
alias gmsq='git merge --squash'
# Cherry-pick
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
# Stash
alias gh='git stash'
alias ghs='git stash show -p'
alias ghp='git stash pop'
alias gha='git stash apply'
alias ghd='git stash drop'
alias ghl='git stash list'
alias ghcl='git stash clear'
# Reset
alias gre='git reset'
alias greh='git reset HEAD'
alias grehh='git reset --hard HEAD'
alias grehs='git reset --soft HEAD~1'   # undo last commit, keep changes staged
alias gundo='git reset --soft HEAD~1'
alias gnuke='git reset --hard && git clean -fd'
# Remote
alias grm='git remote'
alias grma='git remote add'
alias grmr='git remote remove'
alias grmv='git remote -v'
alias grmu='git remote set-url'
# Tag
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'
alias gtp='git push --tags'
# Worktree
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwd='git worktree remove'
# Submodule
alias gsm='git submodule'
alias gsmu='git submodule update --init --recursive'
alias gsms='git submodule sync'
# Bisect
alias gbis='git bisect'
alias gbisr='git bisect reset'
alias gbiss='git bisect start'
alias gbisb='git bisect bad'
alias gbisg='git bisect good'
# Reflog
alias gref='git reflog'
alias grefl='git reflog expire --expire=now --all'
# Misc
alias gcln='git clean -fd'
alias gclnx='git clean -fdx'
alias gig='git ls-files --others --exclude-standard'   # untracked
alias gsig='git verify-commit HEAD'   # verify GPG signature
alias groot='git rev-parse --show-toplevel'
alias gcount='git rev-list --count HEAD'
alias gsize='git count-objects -vH'
alias gfix='git add -A && git commit --amend --no-edit'
alias glazyg='git add . && git commit -m'

# ===========================================================================
# DOCKER  (~60 aliases)

# ===========================================================================
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias d='docker'
alias dv='docker version'
alias di='docker images'
alias dia='docker images -a'
alias dirm='docker image rm'
alias diprune='docker image prune'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drun='docker run -it --rm'
alias drunit='docker run -it'
alias dstart='docker start'
alias dstop='docker stop'
alias drestart='docker restart'
alias drm='docker rm'
alias drmf='docker rm -f'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dlogs='docker logs'
alias dinsp='docker inspect'
alias dcp='docker cp'
alias dbuild='docker build -t'
alias dpull='docker pull'
alias dpush='docker push'
alias dnet='docker network ls'
alias dneta='docker network inspect'
alias dvol='docker volume ls'
alias dvola='docker volume inspect'
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'
alias dnprune='docker network prune -f'
alias dcprune='docker container prune -f'
alias dstats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
alias dtop='docker stats --no-stream'
alias dip='docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
# Docker Compose
alias dc='docker compose'           # v2 syntax
alias dco='docker-compose'         # v1 fallback
alias dcu='docker compose up -d'
alias dcud='docker compose up'
alias dcd='docker compose down'
alias dcdv='docker compose down -v'
alias dcr='docker compose restart'
alias dcb='docker compose build'
alias dcl='docker compose logs -f'
alias dce='docker compose exec'
alias dcp2='docker compose pull'
alias dcps='docker compose ps'
alias dcconfig='docker compose config'
fi


# ===========================================================================
# CLOUD & DEVOPS (Supreme+ Only)

# ===========================================================================
# Kubernetes (~70 aliases)
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias k='kubectl'
alias kv='kubectl version'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
alias kgctx='kubectl config get-contexts'
alias kccfg='kubectl config view'
# Get
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgd='kubectl get deployments'
alias kgda='kubectl get deployments -A'
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc -A'
alias kgi='kubectl get ingress'
alias kgn='kubectl get nodes'
alias kgno='kubectl get nodes -o wide'
alias kgcm='kubectl get configmap'
alias kgsec='kubectl get secret'
alias kgpv='kubectl get pv'
alias kgpvc='kubectl get pvc'
alias kgns='kubectl get namespace'
alias kga='kubectl get all'
alias kgaa='kubectl get all -A'
alias kgcj='kubectl get cronjob'
alias kgj='kubectl get job'
alias kgrs='kubectl get replicaset'
alias kgss='kubectl get statefulset'
alias kgds='kubectl get daemonset'
alias kghpa='kubectl get hpa'
# Describe
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe svc'
alias kdn='kubectl describe node'
# Apply / Create / Delete
alias ka='kubectl apply -f'
alias kar='kubectl apply -R -f'
alias kc='kubectl create'
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'
alias kdeld='kubectl delete deployment'
# Logs / Exec
alias kl='kubectl logs -f'
alias kla='kubectl logs -f --all-containers'
alias klp='kubectl logs -f --previous'
alias kex='kubectl exec -it'
alias kpf='kubectl port-forward'
# Scale / Rollout
alias ksc='kubectl scale'
alias kro='kubectl rollout'
alias kros='kubectl rollout status'
alias kroh='kubectl rollout history'
alias krou='kubectl rollout undo'
# Misc
alias ktop='kubectl top'
alias ktopp='kubectl top pod'
alias ktonn='kubectl top node'
alias krun='kubectl run -it --rm --image'
alias kcurl='kubectl run curl-test --image=curlimages/curl -it --rm --'
alias kdrain='kubectl drain --ignore-daemonsets --delete-emptydir-data'
alias kuncordon='kubectl uncordon'
alias kcordon='kubectl cordon'
alias ktaint='kubectl taint'
fi


# ===========================================================================
# TERRAFORM (~30 aliases)

# ===========================================================================
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias tf='terraform'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfp='terraform plan'
alias tfpa='terraform plan -out=tfplan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tfs='terraform show'
alias tfo='terraform output'
alias tfstate='terraform state'
alias tfsl='terraform state list'
alias tfsshow='terraform state show'
alias tfg='terraform graph | dot -Tpng > graph.png'
alias tfwl='terraform workspace list'
alias tfwn='terraform workspace new'
alias tfws='terraform workspace select'
alias tfimport='terraform import'
alias tftaint='terraform taint'
alias tfuntaint='terraform untaint'
alias tfdoc='terraform-docs markdown . 2>/dev/null'
fi


# ===========================================================================
# HELM (~25 aliases)

# ===========================================================================
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias hls='helm list'
alias hlsa='helm list -A'
alias hin='helm install'
alias hup='helm upgrade'
alias hupi='helm upgrade --install'
alias hdel='helm uninstall'
alias hsr='helm search repo'
alias hsh='helm search hub'
alias hre='helm repo'
alias hrea='helm repo add'
alias hreu='helm repo update'
alias hrel='helm repo list'
alias hstat='helm status'
alias hhist='helm history'
alias hroll='helm rollback'
alias hget='helm get'
alias hgetv='helm get values'
alias hgetn='helm get notes'
alias htp='helm template'
alias hlint='helm lint'
alias hdry='helm install --dry-run --debug'
alias henv='helm env'
fi


# ===========================================================================
# ANSIBLE (~20 aliases)

# ===========================================================================
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias ans='ansible'
alias ansplay='ansible-playbook'
alias ansinv='ansible-inventory'
alias anscheck='ansible-playbook --check'
alias ansdiff='ansible-playbook --check --diff'
alias ansvault='ansible-vault'
alias ansenc='ansible-vault encrypt'
alias ansdec='ansible-vault decrypt'
alias ansgalaxy='ansible-galaxy'
alias ansping='ansible all -m ping'
alias ansfacts='ansible all -m setup'
fi


# ===========================================================================
# NETWORK & SECURITY (~80 aliases)

# ===========================================================================
alias fastping='ping -c 100 -s.2'
alias ping6='ping6 -c 5'
alias tracert='traceroute'
alias myip='curl -4s ifconfig.me && echo'
alias myip6='curl -6s ifconfig.me && echo'
alias myips='ip -br addr'
alias ipl='ip -br link'
alias ipa='ip -br addr'
alias ipr='ip route'
alias ipn='ip neigh'
alias ipstats='ip -s link'
alias ports='ss -tulanp'
alias listening='ss -tlnp'
alias established='ss -tnp state established'
alias portcheck='nc -zv'
alias curl='curl -L --retry 3'
alias httpd='python3 -m http.server'
# DNS
    alias dig='dog'
alias nsl='nslookup'
alias digany='dig +nocmd any +multiline +noall +answer'
alias digtrace='dig +trace'
alias digshort='dig +short'
alias flushDNS='sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches 2>/dev/null || sudo dscacheutil -flushcache 2>/dev/null'
# SSH
alias ssha='ssh-add'
alias sshl='ssh-add -l'
alias sshD='ssh-add -D'
alias sshk='ssh-keyscan'
alias sshfp='ssh-keygen -lf'
alias sshcopy='ssh-copy-id'
alias sshrm='ssh-keygen -R'
alias sshconfig='$EDITOR ~/.ssh/config'
# Firewall shortcuts (ufw / iptables / pfctl)
alias fwstatus='sudo ufw status verbose 2>/dev/null || sudo iptables -L -n -v 2>/dev/null'
alias fwenable='sudo ufw enable'
alias fwdisable='sudo ufw disable'
alias fwall='sudo ufw allow'
alias fwdeny='sudo ufw deny'
# OpenSSL / TLS
alias sslcheck='openssl s_client -connect'
alias sslcert='openssl x509 -noout -text -in'
alias ssldate='openssl s_client -connect -servername </dev/null 2>/dev/null | openssl x509 -noout -dates'
alias genkey='openssl genrsa -out'
alias gencsr='openssl req -new -key'
# GPG / PGP
alias gpglist='gpg --list-keys'
alias gpglistsec='gpg --list-secret-keys'
alias gpgenc='gpg --encrypt --armor'
alias gpgdec='gpg --decrypt'
alias gpgsign='gpg --clearsign'
alias gpgverify='gpg --verify'
alias gpgimport='gpg --import'
alias gpgexport='gpg --armor --export'
alias gpgrecv='gpg --recv-keys'
alias gpgsend='gpg --send-keys'
alias gpgfp='gpg --fingerprint'
# Security scanning
alias nmap='nmap -v'
alias nmapfast='nmap -T4 -F'
alias nmapfull='nmap -T4 -A -v'
alias nmapstealth='sudo nmap -sS -O'
alias nmapudp='sudo nmap -sU'
alias nmapvuln='nmap --script vuln'
alias portscan='nmap -sV --version-intensity 5'
# File integrity
alias sha256='sha256sum'
alias sha512='sha512sum'
alias md5='md5sum'
alias checksum='sha256sum'
# Secure delete
alias srm='shred -u -z -n 3'   # secure remove (3-pass)

# ===========================================================================
# SYSTEMD / SERVICE MANAGEMENT

# ===========================================================================
alias sc='systemctl'
alias scs='systemctl status'
alias scst='systemctl start'
alias scsp='systemctl stop'
alias scena='systemctl enable'
alias scenas='systemctl enable --now'
alias scdis='systemctl disable'
alias scdiss='systemctl disable --now'
alias scl='systemctl list-units --type=service'
alias scla='systemctl list-units --type=service --all'
alias scfail='systemctl --failed'
alias scedit='systemctl edit'
alias sccat='systemctl cat'
alias scdep='systemctl list-dependencies'
alias scboot='systemctl list-units --type=service --state=running'
alias jc='journalctl'
alias jce='journalctl -xe'
alias jcf='journalctl -f'
alias jcu='journalctl -u'
alias jcb='journalctl -b'
alias jcp='journalctl -p err'     # errors only
alias jcn='journalctl -n 50'      # last 50 lines
alias jcclear='sudo journalctl --vacuum-time=7d'
# RC/OpenRC (Gentoo/Alpine/Void)
alias rcs='rc-service'
alias rcst='rc-service start'
alias rcsp='rc-service stop'
alias rcr='rc-service restart'
alias rcu='rc-update'

# ===========================================================================
# PACKAGE MANAGERS — per-distro  (all conditional on binary existence)

# ===========================================================================
# ── Arch / Manjaro ──────────────────────────────────────────────────────────
    alias pac='sudo pacman'
    alias paci='sudo pacman -S --noconfirm'
    alias pacI='sudo pacman -S'              # with confirmation
    alias pacr='sudo pacman -Rns'
    alias pacu='sudo pacman -Syu'
    alias pacs='pacman -Ss'
    alias pacl='pacman -Q'
    alias pacll='pacman -Qe'               # explicitly installed
    alias paclo='pacman -Qdtq'             # orphans
    alias paclf='pacman -Ql'              # files in package
    alias pacown='pacman -Qo'             # which pkg owns file
    alias pacinfo='pacman -Qi'
    alias pacclean='sudo pacman -Rns $(pacman -Qdtq)'
    alias pacmirror='sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
    alias packeys='sudo pacman-key --refresh-keys'
    alias y='yay'
    alias ys='yay -Ss'
    alias par='paru'
    alias paru='paru -Syu'
# ── Debian / Ubuntu ─────────────────────────────────────────────────────────
    alias apti='sudo apt-get install -y'
    alias aptI='sudo apt-get install'
    alias aptr='sudo apt-get remove -y'
    alias aptrm='sudo apt-get purge -y'
    alias aptu='sudo apt-get update && sudo apt-get upgrade -y'
    alias aptfu='sudo apt-get update && sudo apt-get full-upgrade -y'
    alias apts='apt-cache search'
    alias aptsh='apt-cache show'
    alias aptl='dpkg -l'
    alias aptll='apt list --installed 2>/dev/null'
    alias aptclean='sudo apt-get autoremove -y && sudo apt-get autoclean'
    alias aptfix='sudo apt-get install -f'
    alias aptheld='apt-mark showhold'
    alias apthold='sudo apt-mark hold'
    alias aptunhold='sudo apt-mark unhold'
# ── Fedora / RHEL / CentOS ──────────────────────────────────────────────────
    alias dnfi='sudo dnf install -y'
    alias dnfI='sudo dnf install'
    alias dnfr='sudo dnf remove -y'
    alias dnfu='sudo dnf upgrade -y'
    alias dnfs='dnf search'
    alias dnfl='dnf list installed'
    alias dnfc='sudo dnf clean all'
    alias dnfh='dnf history'
    alias dnfinfo='dnf info'
    alias dnfgrp='dnf grouplist'
    alias dnfcheck='dnf check-update'
    alias yumi='sudo yum install -y'
    alias yumr='sudo yum remove -y'
    alias yumu='sudo yum update -y'
    alias yums='yum search'
    alias yuml='yum list installed'
# ── openSUSE / SLES ─────────────────────────────────────────────────────────
    alias zypi='sudo zypper install -y'
    alias zypr='sudo zypper remove -y'
    alias zypu='sudo zypper update -y'
    alias zypdu='sudo zypper dist-upgrade -y'
    alias zyps='zypper search'
    alias zypl='zypper packages --installed-only'
    alias zypc='sudo zypper clean'
    alias zypinfo='zypper info'
# ── Void Linux ──────────────────────────────────────────────────────────────
    alias xbpsi='sudo xbps-install -Sy'
    alias xbpsr='sudo xbps-remove -R'
    alias xbpsu='sudo xbps-install -Su'
    alias xbpss='xbps-query -Rs'
    alias xbpsl='xbps-query -l'
    alias xbpsc='sudo xbps-remove -O'
# ── Alpine Linux ─────────────────────────────────────────────────────────────
    alias apki='sudo apk add'
    alias apkr='sudo apk del'
    alias apku='sudo apk upgrade'
    alias apks='apk search'
    alias apkl='apk list --installed'
    alias apkinfo='apk info'
# ── Gentoo ──────────────────────────────────────────────────────────────────
    alias emeri='sudo emerge -av'
    alias emerr='sudo emerge --unmerge'
    alias emeru='sudo emerge --update --deep --newuse @world'
    alias emers='emerge -s'
    alias emerc='sudo eclean-dist && sudo eclean-pkg'
# ── NixOS ───────────────────────────────────────────────────────────────────
    alias nixi='nix-env -iA'
    alias nixr='nix-env -e'
    alias nixu='nix-env -u'
    alias nixs='nix-env -qaP'
    alias nixl='nix-env -q'
    alias nixgc='nix-collect-garbage -d'
    alias nixrebuild='sudo nixos-rebuild switch'
    alias nixtest='sudo nixos-rebuild test'
# ── macOS Homebrew ───────────────────────────────────────────────────────────
    alias brewi='brew install'
    alias brewr='brew uninstall'
    alias brewu='brew update && brew upgrade'
    alias brews='brew search'
    alias brewl='brew list'
    alias brewinfo='brew info'
    alias brewc='brew cleanup'
    alias brewd='brew doctor'
    alias brewdep='brew deps --tree'
    alias brewcask='brew install --cask'
    alias brewcaskr='brew uninstall --cask'
    alias brewcasklist='brew list --cask'
    alias brewpin='brew pin'
    alias brewunpin='brew unpin'
    alias brewpinned='brew list --pinned'
# ── Flatpak ──────────────────────────────────────────────────────────────────
    alias flati='flatpak install -y'
    alias flatr='flatpak uninstall -y'
    alias flatu='flatpak update -y'
    alias flats='flatpak search'
    alias flatl='flatpak list'
    alias flatrun='flatpak run'
    alias flatc='flatpak uninstall --unused -y'
# ── Snap ─────────────────────────────────────────────────────────────────────
    alias snapi='sudo snap install'
    alias snapr='sudo snap remove'
    alias snapu='sudo snap refresh'
    alias snaps='snap find'
    alias snapl='snap list'

# ===========================================================================
# CLOUD — AWS CLI

# ===========================================================================
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    alias awswho='aws sts get-caller-identity'
    alias awsprofile='aws configure list'
    alias awsprofiles='aws configure list-profiles'
    alias awsregion='aws configure get region'
    alias awsec2='aws ec2 describe-instances'
    alias awss3='aws s3 ls'
    alias awss3cp='aws s3 cp'
    alias awss3sync='aws s3 sync'
    alias awseks='aws eks list-clusters'
    alias awslambda='aws lambda list-functions'
    alias awsrds='aws rds describe-db-instances'
    alias awslogs='aws logs describe-log-groups'
    alias awsiam='aws iam list-users'
    alias awscost='aws ce get-cost-and-usage'
    alias awssm='aws secretsmanager list-secrets'
    alias awsssm='aws ssm describe-parameters'
    alias awsecs='aws ecs list-clusters'
# ── GCP ──────────────────────────────────────────────────────────────────────
    alias gcp='gcloud'
    alias gcpwho='gcloud auth list'
    alias gcpproj='gcloud config get-value project'
    alias gcpprojs='gcloud projects list'
    alias gcpset='gcloud config set project'
    alias gcpvm='gcloud compute instances list'
    alias gcpgke='gcloud container clusters list'
    alias gcprun='gcloud run services list'
# ── Azure ─────────────────────────────────────────────────────────────────────
fi

    alias azwho='az account show'
    alias azsub='az account list'
    alias azrg='az group list'
    alias azvm='az vm list'
    alias azaks='az aks list'

# ===========================================================================
# DEVELOPMENT — Python / pip / uv / poetry

# ===========================================================================
alias py='python3'
alias py2='python2'
alias pip='pip3'
alias pipi='pip3 install'
alias pipiu='pip3 install --upgrade'
alias pipun='pip3 uninstall -y'
alias pipl='pip3 list'
alias pipf='pip3 freeze'
alias pipfr='pip3 freeze > requirements.txt'
alias pipir='pip3 install -r requirements.txt'
alias pipout='pip3 list --outdated'
alias pipcheck='pip3 check'
alias pipsec='pip3 audit 2>/dev/null || pip3 install pip-audit && pip-audit'
alias venv='python3 -m venv'
alias venva='source .venv/bin/activate'
alias venvd='deactivate'
alias mkvenv='python3 -m venv .venv && source .venv/bin/activate'
    alias uvi='uv pip install'
    alias uviu='uv pip install --upgrade'
    alias uvir='uv pip install -r requirements.txt'
    alias uvl='uv pip list'
    alias uvf='uv pip freeze'
    alias uvvenv='uv venv'
    alias uvrun='uv run'
    alias uvadd='uv add'
    alias uvrem='uv remove'
    alias uvsync='uv sync'
    alias uvlock='uv lock'
    alias po='poetry'
    alias poa='poetry add'
    alias poad='poetry add --group dev'
    alias poar='poetry add --group test'
    alias porm='poetry remove'
    alias pou='poetry update'
    alias poi='poetry install'
    alias por='poetry run'
    alias pos='poetry shell'
    alias pob='poetry build'
    alias popub='poetry publish'
    alias pock='poetry check'
    alias polock='poetry lock'
    alias poenv='poetry env info'
    alias poenvl='poetry env list'
    alias conl='conda env list'
    alias concr='conda create -n'
    alias conad='conda activate'
    alias conde='conda deactivate'
    alias conrm='conda env remove -n'
    alias coni='conda install'
    alias conu='conda update'
    alias cons='conda search'
    alias conex='conda export > environment.yml'
    alias confr='conda env create -f environment.yml'

# ===========================================================================
# DEVELOPMENT — Node.js / npm / yarn / pnpm / bun

# ===========================================================================
alias node='node'
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nrm='npm uninstall'
alias nr='npm run'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias nrl='npm run lint'
alias nrf='npm run format'
alias nrp='npm run preview'
alias nu='npm update'
alias nout='npm outdated'
alias nls='npm list --depth=0'
alias nlsg='npm list -g --depth=0'
alias ninfo='npm info'
alias naudit='npm audit'
alias nfix='npm audit fix'
alias ninit='npm init -y'
alias nci='npm ci'
alias ncache='npm cache clean --force'
alias npx='npx --yes'
    alias ya='yarn add'
    alias yad='yarn add --dev'
    alias yrm='yarn remove'
    alias yr='yarn run'
    alias yrs='yarn start'
    alias yrd='yarn dev'
    alias yrb='yarn build'
    alias yrt='yarn test'
    alias yi='yarn install'
    alias yu='yarn upgrade'
    alias yout='yarn outdated'
    alias yls='yarn list --depth=0'
    alias pni='pnpm install'
    alias pna='pnpm add'
    alias pnad='pnpm add --save-dev'
    alias pnrm='pnpm remove'
    alias pnr='pnpm run'
    alias pnd='pnpm dev'
    alias pnb='pnpm build'
    alias pnt='pnpm test'
    alias pnu='pnpm update'
    alias pnls='pnpm list'
    alias pnx='pnpm dlx'
    alias bi='bun install'
    alias ba='bun add'
    alias bad='bun add --dev'
    alias brm='bun remove'
    alias brun='bun run'
    alias bx='bunx'
    alias bu='bun update'

# ===========================================================================
# DEVELOPMENT — Rust / Cargo

# ===========================================================================
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias cbr='cargo build --release'
alias ct='cargo test'
alias cta='cargo test --all'
alias cc='cargo check'
alias cf='cargo fmt'
alias cfl='cargo clippy'
alias cflfix='cargo clippy --fix'
alias cdoc='cargo doc --open'
alias cnew='cargo new'
alias cinit='cargo init'
alias cadd='cargo add'
alias crm='cargo remove'
alias cclean='cargo clean'
alias cupdate='cargo update'
alias ctree='cargo tree'
alias csearch='cargo search'
alias cpub='cargo publish'
alias clogin='cargo login'
alias cinstall='cargo install'
alias cben='cargo bench'
alias cwatch='cargo watch -x run'

# ===========================================================================
# DEVELOPMENT — Go

# ===========================================================================
alias gor='go run .'
alias gob='go build .'
alias got='go test ./...'
alias gotv='go test -v ./...'
alias gotc='go test -cover ./...'
alias gomod='go mod tidy'
alias gomodinit='go mod init'
alias goget='go get'
alias goinst='go install'
alias govet='go vet ./...'
alias gofmt='gofmt -w .'
alias golint='golangci-lint run'
alias gobuild='CGO_ENABLED=0 go build -ldflags="-s -w"'
alias goenv='go env'
alias gopath='echo $GOPATH'
alias gowork='go work'

# ===========================================================================
# DEVELOPMENT — Rust / Make / CMake / misc

# ===========================================================================
alias mk='make'
alias mkc='make clean'
alias mki='make install'
alias mkt='make test'
alias mkj='make -j$(nproc)'
alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias cmakeb='cmake --build build'
alias cmakec='cmake --build build --target clean'
alias ninja='ninja -C build'

# ===========================================================================
# DEVELOPMENT — Java / Maven / Gradle

# ===========================================================================
alias javac='javac -encoding UTF-8'
alias mvnc='mvn clean'
alias mvni='mvn clean install'
alias mvnt='mvn test'
alias mvnp='mvn package'
alias mvns='mvn spring-boot:run'
alias gradle='./gradlew'
alias gradleb='./gradlew build'
alias gradlet='./gradlew test'
alias gradlec='./gradlew clean'
alias gradlew='./gradlew'

# ===========================================================================
# DEVELOPMENT — Ruby / PHP / Perl

# ===========================================================================
    alias rbi='bundle install'
    alias rbu='bundle update'
    alias rbe='bundle exec'
    alias rbr='bundle exec rails'
    alias rbrs='bundle exec rails server'
    alias rbrc='bundle exec rails console'
    alias rspec='bundle exec rspec'
    alias phpi='php -a'               # interactive REPL
    alias compi='composer install'
    alias compu='composer update'
    alias compr='composer require'
    alias compa='composer dump-autoload'
    alias artisan='php artisan'
    alias ptest='./vendor/bin/phpunit'

# ===========================================================================
# DATABASE CLIENTS

# ===========================================================================
    alias pgdbs='psql -c "\l"'
    alias pgtbls='psql -c "\dt"'
    alias pgdump='pg_dump'
    alias pgrestore='pg_restore'
    alias mqdbs='mysql -e "SHOW DATABASES;"'
    alias mqdump='mysqldump'
    alias redisping='redis-cli ping'
    alias redisflush='redis-cli flushall'
    alias rediskeys='redis-cli keys "*"'
    alias redismon='redis-cli monitor'
    alias mongodbs='mongosh --eval "db.adminCommand({listDatabases:1})"'
    alias sq='sqlite3'

# ===========================================================================
# TMUX

# ===========================================================================
    alias t='tmux'
    alias ta='tmux attach'
    alias tl='tmux list-sessions'
    alias tn='tmux new-session -s'
    alias tk='tmux kill-session -t'
    alias tka='tmux kill-server'
    alias tr='tmux rename-session -t'
    alias tls='tmux list-windows'
    alias tsh='tmux split-window -h'
    alias tsv='tmux split-window -v'

# ===========================================================================
# TERMINAL MULTIPLEXERS

# ===========================================================================
    alias zj='zellij'
    alias zja='zellij attach'
    alias zjl='zellij list-sessions'
    alias zjk='zellij kill-session'
    alias zjka='zellij kill-all-sessions'
    alias scr='screen'
    alias scra='screen -r'
    alias scrl='screen -ls'

# ===========================================================================
# MODERN CLI TOOLS

# ===========================================================================
    alias lg='lazygit'
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    alias ld='lazydocker'
fi

    alias Y='yazi'                # capital Y = yazi (lowercase y = function that cd's)
    alias fzfp='fzf --preview "bat --style=numbers --color=always {}"'
    alias zi='z -i'              # interactive zoxide
    alias bench='hyperfine'
    alias cloc='tokei'
    alias duu='dust'
    alias duff='duf'
    alias ping='gping'
    alias xh='curlie'
    alias jqp='jq --color-output .'
    alias json='jq .'
    alias yaml='yq .'
    alias md='glow'
    alias help='tldr'
    alias man2='tldr'
    alias fuck='thefuck $(history -p !!)'

# ===========================================================================
# ARCHIVES / COMPRESSION

# ===========================================================================
alias targz='tar -zcvf'
alias tarbz='tar -jcvf'
alias tarxz='tar -Jcvf'
alias tarzst='tar --zstd -cvf'
alias unzip='unzip -q'
alias zip='zip -r'
alias mkzip='zip -r'
alias mktarbz='tar -cjvf'
alias mktarxz='tar -cJvf'

# ===========================================================================
# UTILITIES

# ===========================================================================
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias nowutc='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias today='date +"%Y-%m-%d"'
alias week='date +%V'
alias ts='date +%s'               # unix timestamp
alias epoch='date +%s'
alias clr='clear'
alias c='clear'
alias q='exit'
alias :q='exit'
alias logout='exit'
alias sudoo='sudo '
alias root='sudo -i'
alias whoami='whoami'
alias id='id'
alias groups='groups'
alias path='echo $PATH | tr ":" "\n" | nl'
alias envv='env | sort | less'
alias reload='exec $SHELL -l'
alias brew-up='brew bundle dump --force --file="$DOTFILES_DIR/apps/brew/Brewfile" && brew bundle'
alias histg='history | grep'
alias hh='history | head -20'
alias ht='history | tail -20'
dupl() { history | awk '{print $2}' | sort | uniq -c | sort -rn | head -20; }
# Weather
alias weather='curl -s wttr.in'
alias wttr='curl -s "wttr.in?format=3"'
alias wttrf='curl -s "wttr.in?format=v2"'
# Fun / misc
alias starwars='telnet towel.blinkenlights.nl 2>/dev/null || echo "telnet not installed"'
alias matrix='cmatrix -C cyan 2>/dev/null'
alias pipes='pipes.sh 2>/dev/null'
alias cowsay='cowsay -f tux'
alias sl='ls'                    # typo fix
alias Grep='grep'                # typo fix
alias GREP='grep'                # typo fix
# Dotfiles management
alias dotlog='git -C "$DOTFILES_DIR" log --oneline -15'
alias dotst='git -C "$DOTFILES_DIR" status'
alias dotdiff='git -C "$DOTFILES_DIR" diff'
alias dotpull='git -C "$DOTFILES_DIR" pull'
alias dotpush='git -C "$DOTFILES_DIR" add -A && git -C "$DOTFILES_DIR" commit && git -C "$DOTFILES_DIR" push'
alias dotdocs='$BROWSER "$HOME/.dotfiles/docs/index.html"'
# Quick file/dir sizes
alias dh='du -h --max-depth=1 | sort -rh'
alias biggest='du -h --max-depth=1 | sort -rh | head 10'
# Clipboard (Linux xclip/xsel/wl-copy, macOS pbcopy)
if [[ "$DOTFILES_OS" == "Darwin" ]]; then
    alias copy='pbcopy'
    alias paste='pbpaste'
elif command -v wl-copy &>/dev/null; then
    alias copy='wl-copy'
    alias paste='wl-paste'
elif command -v xclip &>/dev/null; then
    alias copy='xclip -selection clipboard'
    alias paste='xclip -selection clipboard -o'
elif command -v xsel &>/dev/null; then
    alias copy='xsel --clipboard --input'
    alias paste='xsel --clipboard --output'
fi
# Open file/URL (cross-platform)
    alias open='open'
    alias open='xdg-open'
alias o='open'

# ===========================================================================
# ALIASES (ZachBrowne / Titus)

# ===========================================================================
alias spico='sudo pico'
alias snano='sudo nano'
alias web='cd /var/www/html'
alias alert='notify-send "Done!"'
alias ebrc='edit ~/.bashrc'
alias hlp='less ~/.bashrc_help'
alias da='date "+%Y-%m-%d %A %T %Z"'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias svi='sudo vi'
alias vis='nvim "+set si"'
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias bd='cd "$OLDPWD"'
alias rmd='/bin/rm  --recursive --force --verbose '
alias lx='ls -lXBh'
alias lk='ls -lSrh'
alias lc='ls -ltcrh'
alias lu='ls -lturh'
alias lr='ls -lRh'
alias lm='ls -alh |more'
alias lw='ls -xAh'
alias labc='ls -lap'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep "
countfiles() { for t in files links directories; do echo "$(find . -type ${t:0:1} | wc -l)" "$t"; done 2> /dev/null; }
alias checkcommand="type -t"
alias openports='netstat -nape --inet'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'
alias sha1='openssl sha1'
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias kssh="kitty +kitten ssh"
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
alias docker-clean=' docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f '
fi

alias hug="systemctl --user restart hugo"
alias lanm="systemctl --user restart lan-mouse"

# ===========================================================================
# NEW ALIASES (Garuda/Awesome)

# ===========================================================================
  alias ls='eza -al --color=always --group-directories-first --icons'
  alias la='eza -a --color=always --group-directories-first --icons'
  alias ll='eza -l --color=always --group-directories-first --icons'
  alias lt='eza -aT --color=always --group-directories-first --icons'
  alias l.='eza -ald --color=always --group-directories-first --icons .*'
  alias cat='bat --style header --style snip --style changes --style header'
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/garuda-update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='ugrep --color=auto'
alias fgrep='ugrep -F --color=auto'
alias egrep='ugrep -E --color=auto'
alias hw='hwinfo --short'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias ip='ip -color'
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias helpme='cht.sh --shell'
alias pacdiff='sudo -H DIFFPROG=meld pacdiff'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ===========================================================================
# SUPREME UPGRADE (Paul Irish / Mathias Bynens / Modern)

# ===========================================================================
# Navigation & System
alias cdf='cd "$(osascript -e "tell app \"Finder\" to POSIX path of (insertion location as alias)" 2>/dev/null || echo .)"'
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes && sudo rm -rfv ~/.Trash"
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
# Project Management Cleanup
alias pclean='find . -type d -name "__pycache__" -exec rm -rf {} + && find . -type f -name "*.pyc" -delete'
alias nuke-node='find . -name "node_modules" -type d -prune -exec rm -rf "{}" +'
# Modern Tools Shorthands
alias v='fd --type f --hidden --exclude .git | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" | xargs -r $EDITOR'
alias fz='zoxide query -i'
# Git Refinements
alias gpristine='git reset --hard && git clean -fdx'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtrm='git worktree remove'
