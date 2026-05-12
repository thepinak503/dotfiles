alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias a 'cd ..'
alias aa 'cd ../..'
alias aaa 'cd ../../..'
alias aaaa 'cd ../../../..'
alias aaaaa 'cd ../../../..'
alias home 'cd ~'
alias dots 'cd "$DOTFILES_DIR"'
alias dotfiles 'cd "$DOTFILES_DIR"'
alias dotst 'git -C "$DOTFILES_DIR" status --short --branch'
alias edots '$EDITOR "$DOTFILES_DIR"'
alias docs 'cd ~/Documents'
alias dt 'cd ~/Desktop'
alias tmp 'cd /tmp'
alias root 'cd /'
alias bk 'cd -'
alias x 'exit'
alias c 'clear'
alias cls 'clear'
alias ls 'eza --icons=auto --group-directories-first 2>/dev/null || command ls'
alias lsa 'ls -a'
alias lsd 'ls -d */'
alias lsdot 'ls -d .*'
alias lsf 'ls -p | grep -v /'
alias lsbig 'ls -lS | head -20'
alias lshidden 'ls -d .* 2>/dev/null'
alias tree 'eza --tree --icons=auto 2>/dev/null || find . -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"'
alias ltree 'eza --tree --level=3 --icons=auto 2>/dev/null || find . -maxdepth 3 -print'
alias l1 'ls -1'
alias lh 'ls -lhS'
alias lr 'ls -lR'
alias cat 'bat --paging=never 2>/dev/null || command cat'
alias grep 'rg 2>/dev/null || command grep'
alias find 'fd 2>/dev/null || command find'
alias duh 'du -sh'
alias dfh 'df -h'
alias freeh 'free -h'
alias h 'history'
alias j 'jobs -l'
alias clr 'clear'
alias please 'sudo'
function pathlines; printf "%s\n" $PATH; end
alias mkdirp 'mkdir -p'
alias focus 'printf "\033c" && date +"%F %T"'
alias dotupdate 'bash "$DOTFILES_DIR/bin/dotupdate.sh"'
alias dothealth 'bash "$DOTFILES_DIR/bin/health_check.sh"'
alias dotbench 'bash "$DOTFILES_DIR/bin/benchmark_shell.sh"'
alias dotfix 'sh "$DOTFILES_DIR/install/install.sh"'
alias dotloadfull '. "$DOTFILES_DIR/core/aliases.sh" && . "$DOTFILES_DIR/core/functions.sh"'
alias dotbranch 'git -C "$DOTFILES_DIR" branch'
alias dotdiff 'git -C "$DOTFILES_DIR" diff'
alias dotdocs 'xdg-open "$DOTFILES_DIR/docs/index.html" 2>/dev/null || open "$DOTFILES_DIR/docs/index.html" 2>/dev/null'
alias dotfetch 'git -C "$DOTFILES_DIR" fetch --all --prune'
alias dothelp 'echo "Pinak'\''s Dotfiles v$DOTFILES_VERSION — see dotdocs for docs"'
alias dotlog 'git -C "$DOTFILES_DIR" log --oneline --graph --decorate -20'
alias dotmode 'echo "$DOTFILES_MODE"'
alias dotpush 'git -C "$DOTFILES_DIR" push'
alias dotreload 'exec "$SHELL" -l'
alias dotver 'echo "$DOTFILES_VERSION"'
alias gap 'git add -p'
alias gcm 'git commit -m'
alias gcan 'git commit --amend --no-edit'
alias gpl 'git pull --rebase --autostash'
alias gsw 'git switch'
alias grbc 'git rebase --continue'
alias grba 'git rebase --abort'
alias grbs 'git rebase --skip'
alias gpr 'git pull --rebase'
alias prune 'git remote prune origin'
alias shipit 'git status --short && git push'
alias glg 'git log --oneline --decorate --graph'
alias gla 'git log --oneline --decorate --graph --all'
alias gcount 'git shortlog -sn'
alias gbl 'git blame -w'
alias gcl 'git clone'
alias gdf 'git diff --name-only'
alias gdw 'git diff --word-diff'
alias gdc 'git diff --cached'
alias gpsup 'git push --set-upstream origin HEAD'
alias grv 'git remote -v'
alias gsta 'git stash apply'
alias gstd 'git stash drop'
alias gswc 'git switch -c'
alias gcp 'git cherry-pick'
alias gmc 'git merge --continue'
alias gma 'git merge --abort'
alias gff 'git merge --ff-only'
alias gwp 'git worktree prune'
alias grepo 'git init'
alias gtags 'git tag -l'
alias gshow 'git show'
if type -q docker
    alias dk 'docker'
    alias dkps 'docker ps'
    alias dkpsa 'docker ps -a'
    alias dkim 'docker images'
    alias dkex 'docker exec -it'
    alias dklogs 'docker logs -f'
    alias dklogst 'docker logs --tail 100 -f'
    alias dkstop 'docker stop $(docker ps -q)'
    alias dkrm 'docker rm $(docker ps -aq)'
    alias dkrmi 'docker rmi $(docker images -q)'
    alias dkprune 'docker system prune -af'
    alias dkclean 'docker system prune -af --volumes'
    alias dkbuild 'docker build -t'
    alias dkrun 'docker run -it --rm'
    alias dkrunbg 'docker run -d'
    alias dkexec 'docker exec -it'
    alias dkstart 'docker start'
    alias dkrestart 'docker restart'
    alias dkpause 'docker pause'
    alias dkunpause 'docker unpause'
    alias dktop 'docker top'
    alias dkstats 'docker stats'
    alias dkcp 'docker cp'
    alias dkport 'docker port'
    alias dkcom 'docker compose'
    alias dkup 'docker compose up -d'
    alias dkdown 'docker compose down'
    alias dkpsall 'docker compose ps'
    alias dklogsall 'docker compose logs -f'
    alias dknet 'docker network ls'
    alias dkvol 'docker volume ls'
    alias dksys 'docker system df'
end
if type -q podman
    alias pod 'podman'
    alias podps 'podman ps'
    alias podpsa 'podman ps -a'
    alias podim 'podman images'
    alias podex 'podman exec -it'
    alias podlogs 'podman logs -f'
    alias podstop 'podman stop $(podman ps -q)'
    alias podrm 'podman rm $(podman ps -aq)'
    alias podprune 'podman system prune -af'
    alias podbuild 'podman build -t'
    alias podrun 'podman run -it --rm'
    alias podcom 'podman compose'
    alias podup 'podman compose up -d'
    alias poddown 'podman compose down'
end
if type -q kubectl
    alias kgpw 'kubectl get pods -w'
    alias kgns 'kubectl get namespaces'
    alias kuse 'kubectl config use-context'
    alias kd 'kubectl describe'
    alias kdp 'kubectl describe pod'
    alias kds 'kubectl describe svc'
    alias kdd 'kubectl describe deployment'
    alias kl 'kubectl logs'
    alias klf 'kubectl logs -f'
    alias ka 'kubectl apply -f'
    alias kpf 'kubectl port-forward'
    alias kexec 'kubectl exec -it'
    alias ktop 'kubectl top pods'
    alias ktopn 'kubectl top nodes'
    alias kedit 'kubectl edit'
    alias kc 'kubectl create'
    alias kcf 'kubectl create -f'
    alias kroll 'kubectl rollout status'
    alias krestart 'kubectl rollout restart'
    alias klabel 'kubectl label'
    alias ktaint 'kubectl taint'
    alias kcord 'kubectl cordon'
    alias kuncord 'kubectl uncordon'
    alias kdrain 'kubectl drain'
    alias kapi 'kubectl api-resources'
    alias kexplain 'kubectl explain'
end
if type -q systemctl
    alias scsr 'systemctl restart'
    alias scse 'systemctl enable'
    alias scsd 'systemctl disable'
    alias scn 'systemctl daemon-reload'
    alias scens 'systemctl enable --now'
    alias scdis 'systemctl disable --now'
    alias scu 'systemctl --user'
    alias scus 'systemctl --user status'
    alias scust 'systemctl --user start'
    alias scusp 'systemctl --user stop'
    alias scusr 'systemctl --user restart'
    alias scuse 'systemctl --user enable'
    alias scusd 'systemctl --user disable'
    alias scl 'systemctl list-units'
    alias scla 'systemctl list-units --all'
    alias scfail 'systemctl list-units --failed'
    alias scmask 'systemctl mask'
    alias scunmask 'systemctl unmask'
    alias sccat 'systemctl cat'
    alias sclist 'systemctl list-unit-files'
    alias scon 'systemctl is-active'
end
if type -q journalctl
    alias jc 'journalctl'
    alias jce 'journalctl -e'
    alias jcf 'journalctl -f'
    alias jcu 'journalctl -u'
    alias jcub 'journalctl -u -b'
    alias jcs 'journalctl --since'
    alias jct 'journalctl --until'
    alias jcp 'journalctl -p err'
    alias jcdf 'journalctl --disk-usage'
    alias jcro 'journalctl --rotate'
    alias jcv 'journalctl --verify'
    alias jcemerg 'journalctl -p emerg'
    alias jcalert 'journalctl -p alert'
    alias jccrit 'journalctl -p crit'
    alias jcwarn 'journalctl -p warning'
    alias jcnotice 'journalctl -p notice'
    alias jcinfo 'journalctl -p info'
    alias jcdebug 'journalctl -p debug'
    alias jcboot 'journalctl -b'
end
if type -q pacman
    alias pac 'sudo pacman'
    alias pacs 'pacman -Ss'
    alias pacsi 'pacman -Si'
    alias pacq 'pacman -Q'
    alias pacqi 'pacman -Qi'
    alias pacql 'pacman -Ql'
    alias pacqo 'pacman -Qo'
    alias pacqs 'pacman -Qs'
    alias pacup 'sudo pacman -Syu'
    alias pacin 'sudo pacman -S'
    alias pacrm 'sudo pacman -Rns'
    alias pacrmu 'sudo pacman -Rdd'
    alias pacor 'sudo pacman -Sc'
    alias pacowned 'pacman -Qii'
    alias pacorph 'pacman -Qtdq'
    alias pacclean 'sudo pacman -Rns $(pacman -Qtdq)'
    alias paclsorph 'pacman -Qtd'
    alias pacfiles 'pacman -Fl'
    alias pacdep 'pacman -Si'
    alias pacwhy 'pacman -D --asexplicit'
    alias fixpacman 'sudo rm -f /var/lib/pacman/db.lck'
end
# Detect any AUR helper
set -q _AUR_HELPER; or set -g _AUR_HELPER ""
for _h in paru yay pikaur aura pakku trizen
    type -q $_h; and set -g _AUR_HELPER $_h; and break
end

if test -n "$_AUR_HELPER"
    alias aurs "$_AUR_HELPER -Ss"
    alias aurq "$_AUR_HELPER -Q"
    alias auri "$_AUR_HELPER -S"
    alias aurup "$_AUR_HELPER -Syu"
    alias aurrm "$_AUR_HELPER -Rns"
    alias aurinfo "$_AUR_HELPER -Si"
    alias aurclean "$_AUR_HELPER -Sc"
    alias aurfiles "$_AUR_HELPER -Fl"

    function _aur_fzf
        $_AUR_HELPER -Slq 2>/dev/null | fzf --multi \
            --preview "$_AUR_HELPER -Sii {1} 2>/dev/null" \
            --preview-window=down:75% | xargs -ro $_AUR_HELPER -S
    end
    alias aurf '_aur_fzf'

    # Helper-specific aliases
    switch $_AUR_HELPER
        case paru
            alias paruf '_aur_fzf'
            alias paruq 'paru -Q'
            alias parudb 'paru -Y --gendb'
            alias parudev 'paru -S --devel'
            alias parunews 'paru -P --news'
        case yay
            alias yayf '_aur_fzf'
            alias yays 'yay -Ss'
            alias yayq 'yay -Q'
            alias yayup 'yay -Syu'
            alias yayi 'yay -S'
            alias yayrm 'yay -Rns'
            alias yayclean 'yay -Sc'
            alias yaygendb 'yay -Y --gendb'
            alias yaydev 'yay -S --devel'
            alias yayfiles 'yay -Fl'
        case pikaur
            alias pikaurf '_aur_fzf'
    end
end
if command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then
    alias apt 'apt'
    alias aptup 'sudo apt update && sudo apt upgrade -y'
    alias aptin 'sudo apt install'
    alias aptr 'sudo apt remove'
    alias aptp 'sudo apt purge'
    alias apts 'apt search'
    alias aptsh 'apt show'
    alias aptq 'dpkg -l'
    alias aptqi 'dpkg -l | grep'
    alias aptau 'sudo apt autoremove'
    alias aptd 'sudo apt download'
    alias aptsrc 'sudo apt source'
    alias aptbuild 'sudo apt build-dep'
    alias aptpolicy 'apt policy'
    alias aptchangelog 'apt changelog'
    alias aptlistup 'apt list --upgradable'
    alias aptlistins 'apt list --installed'
    alias apthold 'sudo apt-mark hold'
    alias aptunhold 'sudo apt-mark unhold'
    alias aptshowhold 'apt-mark showhold'
    alias aptfix 'sudo apt --fix-broken install'
    alias aptupdate 'sudo apt update'
    alias aptdistup 'sudo apt full-upgrade'
end
if type -q dnf
    alias dnf 'dnf'
    alias dnfs 'dnf search'
    alias dnfsi 'dnf info'
    alias dnfup 'sudo dnf upgrade'
    alias dnfi 'sudo dnf install'
    alias dnfrm 'sudo dnf remove'
    alias dnfau 'sudo dnf autoremove'
    alias dnfq 'dnf list installed'
    alias dnfqi 'dnf list installed | grep'
    alias dnfrep 'dnf repolist'
    alias dnfre 'dnf group list'
    alias dnfcache 'sudo dnf clean all'
    alias dnfhist 'dnf history'
    alias dnfhistinfo 'dnf history info'
    alias dnfroll 'dnf history rollback'
    alias dnfdowng 'dnf downgrade'
    alias dnflocal 'sudo dnf localinstall'
    alias dnfprov 'dnf provides'
    alias dnfchk 'dnf check-update'
    alias dnfmod 'dnf module'
end
if type -q brew
    alias brew 'brew'
    alias brews 'brew search'
    alias brewin 'brew install'
    alias brewrm 'brew uninstall'
    alias brewq 'brew list'
    alias brewsrv 'brew services'
    alias brewsrvl 'brew services list'
    alias brewsrvr 'brew services restart'
    alias brewup 'brew update && brew upgrade'
    alias brewupc 'brew update && brew upgrade && brew cleanup'
    alias brewclean 'brew cleanup'
    alias brewdoc 'brew doctor'
    alias brewout 'brew outdated'
    alias brewpin 'brew pin'
    alias brewsr 'brew tap'
    alias brewinfo 'brew info'
    alias brewcask 'brew install --cask'
    alias brewdep 'brew deps'
    alias brewuses 'brew uses'
    alias brewleaves 'brew leaves'
end
if type -q flatpak
    alias flat 'flatpak'
    alias flats 'flatpak search'
    alias flati 'flatpak install'
    alias flatrm 'flatpak uninstall'
    alias flatup 'flatpak update'
    alias flatq 'flatpak list'
    alias flatrun 'flatpak run'
    alias flatinfo 'flatpak info'
    alias flatover 'flatpak override'
end
if type -q snap
    alias snap 'snap'
    alias snaps 'snap search'
    alias snapi 'sudo snap install'
    alias snaprm 'sudo snap remove'
    alias snapup 'sudo snap refresh'
    alias snapq 'snap list'
    alias snapinfo 'snap info'
    alias snapch 'sudo snap changes'
end
if type -q nix
    alias nix 'nix'
    alias nixs 'nix search'
    alias nixsh 'nix shell'
    alias nixi 'nix profile install'
    alias nixrm 'nix profile remove'
    alias nixup 'nix profile upgrade'
    alias nixq 'nix profile list'
    alias nixdev 'nix develop'
    alias nixbuild 'nix build'
    alias nixrun 'nix run'
    alias nixgc 'nix store gc'
    alias nixopt 'nix store optimise'
end
if type -q zypper
    alias zyp 'sudo zypper'
    alias zyps 'zypper search'
    alias zypi 'sudo zypper install'
    alias zypr 'sudo zypper remove'
    alias zypup 'sudo zypper update'
    alias zypdup 'sudo zypper dist-upgrade'
    alias zypl 'zypper list-installed'
    alias zypclean 'sudo zypper clean'
    alias zyplr 'zypper lr'
    alias zypprov 'zypper what-provides'
end
if type -q apk
    alias apk 'apk'
    alias apks 'apk search'
    alias apki 'apk add'
    alias apkrm 'apk del'
    alias apkup 'apk update && apk upgrade'
    alias apkq 'apk list'
    alias apkqi 'apk list -I'
    alias apkinfo 'apk info'
    alias apkclean 'apk cache clean'
end
if type -q node
    alias node 'node'
    alias nt 'npm test'
    alias nb 'npm run build'
    alias nrn 'npm run --'
    alias np 'npm publish'
    alias nup 'npm update'
    alias nout 'npm outdated'
    alias nls 'npm list'
    alias ndoc 'npm docs'
    alias ninit 'npm init -y'
    alias nstar 'npm star'
    alias nuni 'npm uninstall'
    alias nlex 'npm exec'
    alias nwhy 'npm why'
    alias naud 'npm audit'
    alias naux 'npm audit fix'
end
if type -q npx
    alias npx 'npx'
end
if type -q pnpm
    alias pn 'pnpm'
    alias pni 'pnpm install'
    alias pnr 'pnpm run'
    alias pnd 'pnpm run dev'
    alias pnb 'pnpm run build'
    alias pnt 'pnpm test'
    alias pna 'pnpm add'
    alias pnad 'pnpm add -D'
    alias pnrm 'pnpm remove'
    alias pnup 'pnpm update'
    alias pnout 'pnpm outdated'
    alias pnls 'pnpm list'
    alias pninit 'pnpm init'
    alias pnpub 'pnpm publish'
    alias pnlint 'pnpm lint'
    alias pnex 'pnpm exec'
    alias pnlc 'pnpm lint:check'
    alias pnstore 'pnpm store'
end
if type -q yarn
    alias y 'yarn'
    alias ya 'yarn add'
    alias yad 'yarn add -D'
    alias yr 'yarn run'
    alias yb 'yarn build'
    alias yd 'yarn dev'
    alias yt 'yarn test'
    alias yrm 'yarn remove'
    alias yls 'yarn list'
    alias yinit 'yarn init'
    alias ypub 'yarn publish'
    alias ylint 'yarn lint'
    alias ygl 'yarn global list'
    alias yga 'yarn global add'
end
if type -q python3
    alias py 'python3'
    alias py2 'python2 2>/dev/null || python3'
    alias py3 'python3'
    alias pipup 'python3 -m pip install --upgrade pip'
    alias venv 'python3 -m venv .venv'
    alias akt 'source .venv/bin/activate'
    alias dakt 'deactivate'
    alias pyreq 'pip freeze > requirements.txt'
    alias pyr 'python3 -m pip install -r requirements.txt'
    alias pyi 'python3 -i'
    alias pym 'python3 -m'
    alias pyt 'python3 -m pytest'
    alias pyun 'python3 -m unittest'
end
if command -v pip >/dev/null 2>&1 || command -v pip3 >/dev/null 2>&1
    alias pip 'pip3 2>/dev/null || pip'
    alias pi 'pip install'
    alias piu 'pip install --upgrade'
    alias pir 'pip install -r requirements.txt'
    alias pls 'pip list'
    alias pout 'pip list --outdated'
    alias psh 'pip show'
    alias pch 'pip check'
    alias pdown 'pip download'
    alias phash 'pip hash'
end
if type -q cargo
    alias cr 'cargo'
    alias crb 'cargo build'
    alias crbr 'cargo build --release'
    alias crr 'cargo run'
    alias crrr 'cargo run --release'
    alias crt 'cargo test'
    alias crcl 'cargo clippy'
    alias crf 'cargo fmt'
    alias crc 'cargo check'
    alias crd 'cargo doc'
    alias crp 'cargo publish'
    alias cru 'cargo update'
    alias crout 'cargo outdated'
    alias crclean 'cargo clean'
    alias crbench 'cargo bench'
    alias crfix 'cargo fix'
    alias crl 'cargo +nightly'
    alias crw 'cargo watch'
    alias cradd 'cargo add'
    alias crrm 'cargo remove'
end
if type -q go
    alias go 'go'
    alias gor 'go run'
    alias gob 'go build'
    alias got 'go test'
    alias gotv 'go test -v ./...'
    alias goi 'go install'
    alias gom 'go mod'
    alias gomt 'go mod tidy'
    alias gomv 'go mod vendor'
    alias gog 'go get'
    alias gof 'go fmt ./...'
    alias gol 'go vet ./...'
    alias godoc 'go doc'
    alias gogen 'go generate ./...'
    alias goc 'go clean'
    alias gocache 'go clean -cache'
    alias goenv 'go env'
    alias gop 'go tool pprof'
end
if type -q terraform
    alias tfv 'terraform validate'
    alias tff 'terraform fmt'
    alias tfw 'terraform workspace'
    alias tfwl 'terraform workspace list'
    alias tfws 'terraform workspace select'
    alias tfs 'terraform show'
    alias tfo 'terraform output'
    alias tfst 'terraform state'
    alias tfstl 'terraform state list'
    alias tfimp 'terraform import'
    alias tfprov 'terraform providers'
    alias tfgraph 'terraform graph'
    alias tfconsole 'terraform console'
end
if type -q ansible
    alias an 'ansible'
    alias anp 'ansible-playbook'
    alias ang 'ansible-galaxy'
    alias anv 'ansible-vault'
    alias and 'ansible-doc'
    alias ancon 'ansible-config'
    alias aninv 'ansible-inventory'
end
if type -q helm
    alias hl 'helm'
    alias hls 'helm list'
    alias hli 'helm install'
    alias hlu 'helm upgrade'
    alias hlui 'helm upgrade --install'
    alias hld 'helm delete'
    alias hlr 'helm rollback'
    alias hlg 'helm get'
    alias hlga 'helm get all'
    alias hlgs 'helm get values'
    alias hlh 'helm history'
    alias hlsh 'helm show'
    alias hlshc 'helm show chart'
    alias hlshv 'helm show values'
    alias hlrepo 'helm repo'
    alias hlrl 'helm repo list'
    alias hlra 'helm repo add'
    alias hlru 'helm repo update'
    alias hlsea 'helm search'
    alias hlver 'helm version'
    alias hlcomp 'helm completion'
    alias hlplug 'helm plugin'
    alias hlpl 'helm plugin list'
end
if type -q tmux
    alias tad 'tmux attach -d'
    alias tl 'tmux list-sessions'
    alias tn 'tmux new-session -s'
    alias tk 'tmux kill-session -t'
    alias tks 'tmux kill-server'
    alias tsw 'tmux switch-client'
    alias trn 'tmux rename-session'
    alias tlp 'tmux list-panes'
    alias tsplit 'tmux split-window -h'
    alias tsplitv 'tmux split-window'
    alias tprev 'tmux previous-window'
    alias tnext 'tmux next-window'
    alias tswap 'tmux swap-window'
end
if type -q ssh
    alias ssh 'ssh'
    alias ssha 'ssh -A'
    alias sshi 'ssh -o StrictHostKeyChecking=no'
    alias ssk 'ssh-keygen'
    alias sskr 'ssh-keygen -R'
    alias ssc 'ssh-copy-id'
end
alias myipl 'ip addr show | grep "inet " | awk "{print \$2}" | cut -d/ -f1 | head -1'
alias weather 'curl -fsSL wttr.in'
alias portlisten 'ss -tlnp 2>/dev/null || netstat -tlnp'
alias pingf 'ping -c 100 -s 1472 -f'
alias pb 'ping -c 4 8.8.8.8'
alias net 'ip -br addr'
alias ipl 'ip -br link'
alias ipa 'ip -br addr'
alias ipr 'ip route'
alias nst 'netstat -tulanp 2>/dev/null || ss -tulanp'
alias trace 'traceroute'
if type -q dig
    alias dns 'dig +short'
    alias dnsx 'dig ANY +short'
    alias dnsmx 'dig MX +short'
    alias dnsns 'dig NS +short'
    alias dnstxt 'dig TXT +short'
    alias dnsany 'dig ANY'
end
if type -q nmap
    alias nm 'nmap'
    alias nms 'nmap -sn'
    alias nmp 'nmap -sV -sC'
    alias nmo 'nmap -O'
end
if type -q curl
    alias cur 'curl -fsSL'
    alias curh 'curl -I'
    alias curv 'curl -v'
    alias curj 'curl -s | jq .'
    alias curd 'curl -X DELETE'
    alias curp 'curl -X POST'
    alias curu 'curl -X PUT'
end
if type -q wget
    alias wg 'wget -c'
    alias wgr 'wget -r -np -nH'
end
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias rmr 'rm -r'
alias rmf 'rm -f'
alias cpf 'cp -f'
alias mvfs 'mv -f'
alias cpv 'rsync -ah --progress'
alias mkd 'mkdir -p'
alias rsync 'rsync -avz --progress'
alias rsyncdn 'rsync -avz --dry-run --progress'
alias chx 'chmod +x'
alias chm 'chmod'
alias chown 'chown'
alias chgrp 'chgrp'
alias ln 'ln -s'
alias lnh 'readlink -f'
function backup; cp -r $argv[1] "$argv[1].bak-"(date +%Y%m%d-%H%M%S); end
alias timestamp 'date +%s'
alias today 'date +%F'
alias week 'date +%V'
alias mount 'mount | column -t'
alias tart 'tar -tzf'
alias tarjx 'tar -xjf'
alias tarjc 'tar -cjf'
alias tarzx 'tar -xJf'
alias tarzc 'tar -cJf'
alias tarl 'tar -tvf'
alias gunz 'gunzip'
alias bz2 'bzip2'
alias bunz 'bunzip2'
alias xz 'xz'
alias unxz 'unxz'
alias 7z='7z'
alias 7zx='7z x'
alias 7za='7z a'
alias rarx 'unrar x'
alias ps 'ps auxf'
alias pse 'ps aux | grep'
alias pst 'pstree'
alias kill9 'kill -9'
alias kill15 'kill -15'
alias pkillf 'pkill -f'
alias pid 'pgrep -f'
alias nohup 'nohup'
alias disown 'disown'
alias bg 'bg'
alias fg 'fg'
alias nice 'nice -n'
alias renice 'renice -n'
alias topcpu 'ps aux --sort=-%cpu | head 2>/dev/null || ps aux -r | head'
alias topmem 'ps aux --sort=-%mem | head 2>/dev/null || ps aux -m | head'
alias iotop 'iotop -o 2>/dev/null || echo "iotop not found"'
alias gr 'grep'
alias gri 'grep -i'
alias grr 'grep -r'
alias grri 'grep -ri'
alias grl 'grep -rl'
alias grc 'grep -c'
alias sed 'sed'
alias awk 'awk'
alias sort 'sort'
alias uniq 'uniq'
alias uniqc 'sort | uniq -c | sort -rn'
alias wc 'wc'
alias wcw 'wc -w'
alias cut 'cut'
alias tr 'tr'
alias fold 'fold'
alias column 'column -t'
alias join 'join'
alias diff 'diff'
alias diffy 'diff -y'
alias cmp 'cmp'
alias head 'head'
alias tail 'tail'
alias tair 'tail -f'
alias taill 'tail -100'
alias headl 'head -100'
alias nl 'nl -ba'
alias tac 'tac 2>/dev/null || tail -r'
alias rev 'rev'
alias shuf 'shuf'
alias yes 'yes'
if type -q rg
    alias rg 'rg --hidden --glob "!.git"'
    alias rgi 'rg -i --hidden --glob "!.git"'
    alias rgf 'rg --files'
    alias rgl 'rg --files-with-matches'
    alias rgc 'rg --count'
end
if type -q fd
    alias fd 'fd --hidden'
    alias fdi 'fd -i'
end
if type -q gpg
    alias gpg 'gpg'
    alias gpge 'gpg -e'
    alias gpgd 'gpg -d'
    alias gpgs 'gpg -s'
    alias gpgv 'gpg --verify'
    alias gpgl 'gpg --list-keys'
    alias gpgls 'gpg --list-secret-keys'
    alias gpgk 'gpg --list-keys'
    alias gpgex 'gpg --export'
    alias gpgimport 'gpg --import'
    alias gpgrecv 'gpg --recv-keys'
    alias gpgens 'gpg --gen-key'
end
if type -q openssl
    alias ossl 'openssl'
    alias osslcsr 'openssl req -new -newkey rsa:2048 -nodes'
    alias osslchk 'openssl s_client -connect'
    alias osslx 'openssl x509 -in'
    alias osslr 'openssl rand -hex'
    alias osslgen 'openssl genrsa'
end
if type -q shred
    alias shred 'shred -uz'
    alias shredf 'shred -uz -n 7'
end
if type -q lsof
    alias lsof 'lsof'
    alias lsofi 'lsof -i'
    alias lsofp 'lsof -P'
    alias lsofn 'lsof -nP'
end
alias du 'du -h'
alias dud 'du -h --max-depth=1'
alias dfT 'df -hT'
alias blk 'lsblk -f'
alias findsuid 'find / -perm -4000 -type f'
alias disks 'lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT'
alias fdisk 'fdisk -l'
alias smart 'sudo smartctl -a'
alias cpuinfo 'lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string'
alias meminfo 'free -h'
alias diskspace 'df -h'
alias uptime 'uptime'
alias dmesg 'dmesg -T'
alias uname 'uname -a'
alias dateutc 'date -u'
alias caldate 'cal'
alias nproc 'nproc 2>/dev/null || sysctl -n hw.ncpu'
alias release 'cat /etc/os-release 2>/dev/null || cat /usr/lib/os-release'
alias arch 'uname -m'
alias vim 'nvim 2>/dev/null || command vim'
alias sv 'nvim 2>/dev/null || command vim'
alias nv 'nvim'
alias codel 'code .'
alias micro 'micro'
if type -q lazygit
    alias lg 'lazygit'
end
if type -q yazi
    alias yz 'yazi'
end
if type -q zellij
    alias zj 'zellij'
    alias zja 'zellij attach'
    alias zjl 'zellij list-sessions'
end
if type -q just
    alias just 'just'
    alias justl 'just --list'
end
if type -q make
    alias mk 'make'
    alias mkc 'make clean'
    alias mki 'make install'
    alias mkt 'make test'
end
if type -q mysql
    alias myq 'mysql'
    alias myqr 'mysql -u root -p'
    alias mydump 'mysqldump'
    alias mydumpr 'mysqldump -u root -p'
end
if type -q psql
    alias psql 'psql'
    alias psqlr 'psql -U postgres'
    alias pgdump 'pg_dump'
    alias pgres 'pg_restore'
end
if type -q sqlite3
    alias sq3 'sqlite3'
    alias sq3d 'sqlite3 .dump'
end
if type -q redis-cli
    alias rcli 'redis-cli'
    alias rcliping 'redis-cli ping'
    alias rcliinfo 'redis-cli info'
    alias rclimon 'redis-cli monitor'
end
alias s3 's3cmd'
alias mc 'mc'
if type -q aws
    alias aws 'aws'
    alias awsw 'aws sts get-caller-identity'
    alias awsinfo 'aws ec2 describe-instances'
    alias awss3 'aws s3'
    alias awss3ls 'aws s3 ls'
    alias awslb 'aws elb describe-load-balancers'
    alias awsecs 'aws ecs list-clusters'
    alias awsecr 'aws ecr describe-repositories'
    alias awslam 'aws lambda list-functions'
    alias awslog 'aws logs describe-log-groups'
    alias awscw 'aws cloudwatch'
    alias awsiam 'aws iam list-users'
    alias awsr53 'aws route53 list-hosted-zones'
end
if type -q gcloud
    alias gcl 'gcloud'
    alias gcls 'gcloud compute ssh'
    alias gcll 'gcloud compute instances list'
    alias gclc 'gcloud container clusters list'
    alias gclgke 'gcloud container clusters get-credentials'
    alias gcllogs 'gcloud logging list'
end
if type -q az
    alias az 'az'
    alias azl 'az vm list'
    alias azs 'az vm start'
    alias azst 'az vm stop'
    alias azr 'az vm restart'
    alias azg 'az group list'
    alias azaks 'az aks list'
end
if type -q ffmpeg
    alias ffp 'ffprobe'
    alias ffg 'ffplay'
    alias ffconvert 'ffmpeg -i'
    function ffmp3; ffmpeg -i $argv[1] -q:a 0 (string replace -r '\.[^.]+$' '.mp3' $argv[1]); end
    alias ffcompress 'ffmpeg -i "$1" -vcodec libx265 -crf 28'
    function ffgif; ffmpeg -i $argv[1] -vf "fps=10,scale=320:-1" (string replace -r '\.[^.]+$' '.gif' $argv[1]); end
    alias ffscreencap 'ffmpeg -f x11grab -video_size 1920x1080 -i :0.0'
end
if type -q convert
    alias img 'convert'
    alias imgres 'convert -resize'
    alias imgfmt 'convert -format'
    alias imgcompress 'convert -quality 85'
end
if type -q nvidia-smi
    alias gpul 'nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv'
    alias gputop 'nvidia-smi dmon -s pucvmet'
end
alias matrix 'printf "\01101000\01100101\01101100\01101100\01101111\n"'
alias coinflip 'awk "BEGIN{srand();print rand()<0.5?\"heads\":\"tails\"}"'
function dice; echo (random 1 6); end
alias randpw 'openssl rand -base64 16 2>/dev/null || python3 -c "import secrets; print(secrets.token_urlsafe(16))"'
alias sha 'shasum -a 256'
alias md5sum 'md5 2>/dev/null || command md5sum'
alias hex 'xxd'
alias base64e 'base64'
alias base64d 'base64 -d'
alias urlenc 'python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))"'
alias urldec 'python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))"'

alias count 'wc -l'
alias lines 'cat -n'
alias cht 'curl -fsSL "https://cht.sh/$1"'
alias learn 'curl -fsSL "https://learnxinyminutes.com/docs/$1"'
alias cheat 'curl -fsSL "https://cheat.sh/$1"'
alias man 'man'
alias help 'help'
alias info 'info'
alias what 'type'
alias ali 'alias'
alias envg 'env | grep'
alias fn 'declare -f 2>/dev/null || typeset -f'
alias dsync 'dot_sync'
alias chmode 'export DOTFILES_MODE'
function modestat; echo "Mode: $DOTFILES_MODE"; end
function dotinfo; echo "Dotfiles: $DOTFILES_DIR | Mode: $DOTFILES_MODE | Shell: $SHELL"; end
alias pgit 'git'
alias pgitst 'git status --short --branch'
alias pgitadd 'git add'
alias pgitaddall 'git add -A'
alias pgitaddpatch 'git add -p'
alias pgitbr 'git branch'
alias pgitbrd 'git branch -d'
alias pgitbrD 'git branch -D'
alias pgitbrall 'git branch -a'
alias pgitbrnm 'git branch -m'
alias pgitco 'git checkout'
alias pgitsw 'git switch'
alias pgitswc 'git switch -c'
alias pgitcl 'git clone'
alias pgitcm 'git commit'
alias pgitcmm 'git commit -m'
alias pgitcma 'git commit --amend'
alias pgitcmne 'git commit --amend --no-edit'
alias pgitdf 'git diff'
alias pgitdfs 'git diff --staged'
alias pgitdfw 'git diff --word-diff'
alias pgitdfn 'git diff --name-only'
alias pgitft 'git fetch'
alias pgitftp 'git fetch --all --prune'
alias pgitlg 'git log --oneline --graph -20'
alias pgitlga 'git log --oneline --graph --all -20'
alias pgitlgs 'git log --oneline --graph --all --simplify-by-decoration'
alias pgitmg 'git merge'
alias pgitmgff 'git merge --ff-only'
alias pgitmgnc 'git merge --no-commit'
alias pgitph 'git push'
alias pgitphf 'git push --force-with-lease'
alias pgitphu 'git push -u origin HEAD'
alias pgitpl 'git pull'
alias pgitplr 'git pull --rebase --autostash'
alias pgitpr 'git remote prune origin'
alias pgitsh 'git stash'
alias pgitshp 'git stash pop'
alias pgitshl 'git stash list'
alias pgitsha 'git stash apply'
alias pgitshd 'git stash drop'
alias pgitshw 'git stash show -p'
alias pgitrb 'git rebase'
alias pgitrbc 'git rebase --continue'
alias pgitrba 'git rebase --abort'
alias pgitrbs 'git rebase --skip'
alias pgitrbi 'git rebase -i'
alias pgitrs 'git reset'
alias pgitrsf 'git reset --hard'
alias pgitrss 'git reset --soft'
alias pgitrm 'git remote -v'
alias pgitrma 'git remote add'
alias pgitrmrm 'git remote remove'
alias pgitcp 'git cherry-pick'
alias pgitcpnc 'git cherry-pick --no-commit'
alias pgitbl 'git blame'
alias pgitgr 'git grep'
alias pgittg 'git tag'
alias pgitcfg 'git config'
alias pgitcfgg 'git config --global'
alias pgitwrk 'git worktree'
alias pgitwrka 'git worktree add'
alias pgitwrkl 'git worktree list'
alias pgitwrkpr 'git worktree prune'
alias pgitign 'git update-index --assume-unchanged'
alias pgitignn 'git update-index --no-assume-unchanged'
alias pgitignl 'git ls-files -v | grep "^[a-z]"'
alias pgitarc 'git archive'
alias pgitbnd 'git bundle'
alias pgitdesc 'git describe'
alias pgitref 'git reflog'
alias pgitci 'git clean -fd'
alias pgitshow 'git show'
alias pgitsm 'git submodule'
alias pgitinit 'git init'
alias pgitbis 'git bisect'
alias pdk 'docker'
alias pdkps 'docker ps'
alias pdkpsa 'docker ps -a'
alias pdkpsq 'docker ps -q'
alias pdkpsl 'docker ps -l'
alias pdkim 'docker images'
alias pdkima 'docker images -a'
alias pdkimq 'docker images -q'
alias pdkimrm 'docker rmi'
alias pdkex 'docker exec -it'
alias pdkexsh 'docker exec -it /bin/sh'
alias pdkexba 'docker exec -it /bin/bash'
alias pdkcp 'docker cp'
alias pdklogs 'docker logs'
alias pdklogsf 'docker logs -f'
alias pdklogst 'docker logs --tail 100 -f'
alias pdkrun 'docker run -it --rm'
alias pdkrund 'docker run -d'
alias pdkrunp 'docker run -it --rm -p'
alias pdkrunv 'docker run -it --rm -v'
alias pdkrn 'docker run --name'
alias pdkst 'docker start'
alias pdkstp 'docker stop'
alias pdkstpa 'docker stop $(docker ps -q)'
alias pdkrs 'docker restart'
alias pdkrm 'docker rm'
alias pdkrma 'docker rm $(docker ps -aq)'
alias pdkrmv 'docker rm -v'
alias pdkbl 'docker build'
alias pdkblt 'docker build -t'
alias pdkblnc 'docker build --no-cache -t'
alias pdkblpus 'docker buildx build --push'
alias pdkpush 'docker push'
alias pdkpull 'docker pull'
alias pdkpsh 'docker push'
alias pdkcm 'docker commit'
alias pdknet 'docker network'
alias pdknetls 'docker network ls'
alias pdknetcr 'docker network create'
alias pdknetrm 'docker network rm'
alias pdkvol 'docker volume'
alias pdkvolls 'docker volume ls'
alias pdkvolrm 'docker volume rm'
alias pdkvolpr 'docker volume prune'
alias pdkstts 'docker stats'
alias pdkstop 'docker top'
alias pdkpr 'docker system prune'
alias pdkpra 'docker system prune -af'
alias pdkprv 'docker system prune -af --volumes'
alias pdkdf 'docker system df'
alias pdkdh 'docker system df'
alias pdkpsf 'docker ps --format'
alias pdkcom 'docker compose'
alias pdkcomp 'docker compose ps'
alias pdkcomup 'docker compose up -d'
alias pdkcomdown 'docker compose down'
alias pdkcomlogs 'docker compose logs -f'
alias pdkcombuild 'docker compose build'
alias pdkcompull 'docker compose pull'
alias pdkcomrestart 'docker compose restart'
alias pdkcomstop 'docker compose stop'
alias pdkcomstart 'docker compose start'
alias pdkcomrm 'docker compose rm'
alias pdkcomex 'docker compose exec'
alias pdkcomrun 'docker compose run --rm'
alias pdkcomcr 'docker compose create'
alias pdkcomsc 'docker compose scale'
alias pdkcomtop 'docker compose top'
alias pdkcomps 'docker compose images'
alias pk 'kubectl'
alias pkgs 'kubectl get all'
alias pkgp 'kubectl get pods'
alias pkgpw 'kubectl get pods -w'
alias pkgsv 'kubectl get svc'
alias pkgdep 'kubectl get deployments'
alias pkgng 'kubectl get nodes'
alias pkgns 'kubectl get namespaces'
alias pkgst 'kubectl get statefulsets'
alias pkgds 'kubectl get daemonsets'
alias pkgcj 'kubectl get cronjobs'
alias pkgj 'kubectl get jobs'
alias pkgi 'kubectl get ingress'
alias pkgcm 'kubectl get configmaps'
alias pkgsec 'kubectl get secrets'
alias pkgpv 'kubectl get pv'
alias pkgpvc 'kubectl get pvc'
alias pkgsc 'kubectl get storageclass'
alias pkgn 'kubectl get networkpolicies'
alias pkgall 'kubectl get all --all-namespaces'
alias pkdesc 'kubectl describe'
alias pkdp 'kubectl describe pod'
alias pkds 'kubectl describe svc'
alias pkdd 'kubectl describe deployment'
alias pkdn 'kubectl describe node'
alias kdl 'kubectl describe pod -l app'
alias pklog 'kubectl logs'
alias pklogf 'kubectl logs -f'
alias pklogp 'kubectl logs --previous'
alias pkapp 'kubectl apply -f'
alias pkappl 'kubectl apply -f --recursive'
alias pkdel 'kubectl delete'
alias pkdelp 'kubectl delete pod'
alias pkdels 'kubectl delete svc'
alias pkex 'kubectl exec -it'
alias pkexsh 'kubectl exec -it -- /bin/sh'
alias pkexba 'kubectl exec -it -- /bin/bash'
alias pkpf 'kubectl port-forward'
alias pktop 'kubectl top pods'
alias pktopn 'kubectl top nodes'
alias pkedit 'kubectl edit'
alias pkcr 'kubectl create -f'
alias pkroll 'kubectl rollout status'
alias pkrollh 'kubectl rollout history'
alias pkrollu 'kubectl rollout undo'
alias pkres 'kubectl rollout restart'
alias pkscale 'kubectl scale'
alias pklab 'kubectl label'
alias pktaint 'kubectl taint'
alias pkcord 'kubectl cordon'
alias pkuncord 'kubectl uncordon'
alias pkdrain 'kubectl drain'
alias pkapi 'kubectl api-resources'
alias pkapiv 'kubectl api-versions'
alias pkexpl 'kubectl explain'
alias pkctx 'kubectl config current-context'
alias pkuse 'kubectl config use-context'
alias pkgetctx 'kubectl config get-contexts'
alias pksetctx 'kubectl config set-context'
alias pkview 'kubectl config view'
alias pkcns 'kubectl config set-context --namespace'
alias pkcp 'kubectl cp'
alias pkauth 'kubectl auth can-i'
alias pkcomp 'kubectl completion'
alias pkwatch 'kubectl get pods --watch'
alias psc 'systemctl'
alias pscst 'systemctl status'
alias pscup 'systemctl start'
alias pscdown 'systemctl stop'
alias pscrs 'systemctl restart'
alias pscen 'systemctl enable'
alias pscdis 'systemctl disable'
alias pscenow 'systemctl enable --now'
alias pscdisn 'systemctl disable --now'
alias pscmask 'systemctl mask'
alias pscunmask 'systemctl unmask'
alias pscrel 'systemctl daemon-reload'
alias psclist 'systemctl list-units'
alias psclista 'systemctl list-units --all'
alias psclistf 'systemctl list-unit-files'
alias pscfail 'systemctl list-units --failed'
alias pscisact 'systemctl is-active'
alias pscisen 'systemctl is-enabled'
alias psccat 'systemctl cat'
alias pscedit 'systemctl edit'
alias pscadd 'systemctl add-wants'
alias pschlp 'systemctl help'
alias psctim 'systemd-analyze'
alias pscblame 'systemd-analyze blame'
alias psccrit 'systemd-analyze critical-chain'
alias pscca 'systemd-analyze calendar'
alias psccond 'systemd-analyze condition'
alias pjc 'journalctl'
alias pjce 'journalctl -e'
alias pjcf 'journalctl -f'
alias pjcu 'journalctl -u'
alias pjcub 'journalctl -u -b'
alias pjcs 'journalctl --since'
alias pjct 'journalctl -n'
alias pjcp 'journalctl -p'
alias pjcerr 'journalctl -p err'
alias pjcwarn 'journalctl -p warning'
alias pjcinfo 'journalctl -p info'
alias pjcdebug 'journalctl -p debug'
alias pjcb 'journalctl -b'
alias pjcb1 'journalctl -b -1'
alias pjcb2 'journalctl -b -2'
alias pjcboot 'journalctl --list-boots'
alias pjcdsk 'journalctl --disk-usage'
alias pjcro 'journalctl --rotate'
alias pjcvac 'journalctl --vacuum-size'
alias pjcvact 'journalctl --vacuum-time'
alias ppod 'podman'
alias ppodps 'podman ps'
alias ppodpsa 'podman ps -a'
alias ppodim 'podman images'
alias ppodimrm 'podman rmi'
alias ppodex 'podman exec -it'
alias ppodlogs 'podman logs'
alias ppodlogsf 'podman logs -f'
alias ppodrun 'podman run -it --rm'
alias ppodrund 'podman run -d'
alias ppodst 'podman start'
alias ppodstp 'podman stop'
alias ppodrs 'podman restart'
alias ppodrm 'podman rm'
alias ppodbl 'podman build -t'
alias ppodpull 'podman pull'
alias ppodpush 'podman push'
alias ppodpr 'podman system prune -af'
alias ppodnet 'podman network ls'
alias ppodvol 'podman volume ls'
alias ppodcom 'podman compose'
alias ppodcomp 'podman compose ps'
alias ppodcompup 'podman compose up -d'
alias ppodcompdown 'podman compose down'
alias ppodcomplogs 'podman compose logs -f'
alias ptf 'terraform'
alias ptfinit 'terraform init'
alias ptfinitup 'terraform init -upgrade'
alias ptfpl 'terraform plan'
alias ptfplo 'terraform plan -out=tfplan'
alias ptfap 'terraform apply'
alias ptfapo 'terraform apply tfplan'
alias ptfdes 'terraform destroy'
alias ptfval 'terraform validate'
alias ptffmt 'terraform fmt'
alias ptffmtr 'terraform fmt -recursive'
alias ptfws 'terraform workspace'
alias ptfwsl 'terraform workspace list'
alias ptfwss 'terraform workspace select'
alias ptfwsn 'terraform workspace new'
alias ptfwsd 'terraform workspace delete'
alias ptfsh 'terraform show'
alias ptfout 'terraform output'
alias ptfst 'terraform state list'
alias ptfstsh 'terraform state show'
alias ptfstmv 'terraform state mv'
alias ptfstrm 'terraform state rm'
alias ptfstpull 'terraform state pull'
alias ptfstpush 'terraform state push'
alias ptfim 'terraform import'
alias ptfprv 'terraform providers'
alias ptfprvlock 'terraform providers lock'
alias ptfprvmir 'terraform providers mirror'
alias ptfgr 'terraform graph'
alias ptfcon 'terraform console'
alias ptfun 'terraform untaint'
alias ptftaint 'terraform taint'
alias ptfvers 'terraform version'
alias ptfref 'terraform refesh'
alias pan 'ansible'
alias panall 'ansible all -m'
alias panping 'ansible all -m ping'
alias pangath 'ansible all -m gather_facts'
alias pansh 'ansible all -m shell -a'
alias panpl 'ansible-playbook'
alias panplchk 'ansible-playbook --check'
alias panplsy 'ansible-playbook --syntax-check'
alias pangal 'ansible-galaxy'
alias pangals 'ansible-galaxy search'
alias pangalin 'ansible-galaxy install'
alias pangup 'ansible-galaxy collection install --upgrade'
alias panvault 'ansible-vault'
alias panvenc 'ansible-vault encrypt'
alias panvdec 'ansible-vault decrypt'
alias panved 'ansible-vault edit'
alias panvcr 'ansible-vault create'
alias panvvi 'ansible-vault view'
alias pandoc 'ansible-doc'
alias pandocl 'ansible-doc -l'
alias pnaconf 'ansible-config list'
alias paninv 'ansible-inventory --graph'
alias ph 'helm'
alias phls 'helm list'
alias phlsa 'helm list --all'
alias phlsn 'helm list -n'
alias phi 'helm install'
alias phin 'helm install --namespace'
alias phiu 'helm upgrade --install'
alias phup 'helm upgrade'
alias phupn 'helm upgrade --namespace'
alias phdel 'helm delete'
alias phdeln 'helm delete --purge'
alias phroll 'helm rollback'
alias phrold 'helm rollback --dry-run'
alias phget 'helm get all'
alias phgv 'helm get values'
alias phgvc 'helm get values --all'
alias phgn 'helm get notes'
alias phgh 'helm get hooks'
alias phgm 'helm get manifest'
alias phhis 'helm history'
alias phhisn 'helm history --namespace'
alias phsh 'helm show chart'
alias phshv 'helm show values'
alias phshr 'helm show readme'
alias phshc 'helm show crds'
alias phrp 'helm repo'
alias phrpl 'helm repo list'
alias phrpa 'helm repo add'
alias phrprm 'helm repo remove'
alias phrpu 'helm repo update'
alias phrpidx 'helm repo index'
alias phsea 'helm search hub'
alias phsr 'helm search repo'
alias phver 'helm version'
alias phenv 'helm env'
alias phcomp 'helm completion'
alias phplg 'helm plugin'
alias phplgl 'helm plugin list'
alias phplgi 'helm plugin install'
alias phplgrm 'helm plugin remove'
alias ptmx 'tmux'
alias ptmxls 'tmux list-sessions'
alias ptmxnew 'tmux new-session -s'
alias ptmxatt 'tmux attach'
alias ptmxattd 'tmux attach -d'
alias ptmxkill 'tmux kill-session -t'
alias ptmxkillall 'tmux kill-server'
alias ptmxsw 'tmux switch-client -t'
alias ptmxren 'tmux rename-session -t'
alias ptmxlist 'tmux list-windows -a'
alias ptmxpanes 'tmux list-panes -a'
alias ptmxsp 'tmux split-window -h'
alias ptmxspv 'tmux split-window'
alias ptmxwin 'tmux new-window'
alias ptmxclose 'tmux kill-pane'
alias ptmxprev 'tmux previous-window'
alias tmxn 'tmux next-window'
alias ptmxmv 'tmux move-window'
alias ptmxswp 'tmux swap-window -t'
alias ptmxsync 'tmux setw synchronize-panes'
alias ptmxcap 'tmux capture-pane -pS -'
alias ptmxbuf 'tmux save-buffer'
alias ptmxchoos 'tmux choose-session'
alias pbr 'brew'
alias pbrls 'brew list'
alias pbrsr 'brew search'
alias pbri 'brew install'
alias pbrci 'brew install --cask'
alias pbrrm 'brew uninstall'
alias pbrupg 'brew upgrade'
alias pbrup 'brew update && brew upgrade'
alias pbrcl 'brew cleanup'
alias pbrcln 'brew cleanup --prune=all'
alias pbrdoc 'brew doctor'
alias pbrout 'brew outdated'
alias pbrinfo 'brew info'
alias pbrdep 'brew deps'
alias pbrtree 'brew deps --tree'
alias pbruses 'brew uses'
alias pbrleaves 'brew leaves'
alias pbrpin 'brew pin'
alias pbrunpin 'brew unpin'
alias pbrsvc 'brew services'
alias pbrsvcls 'brew services list'
alias pbrsvcst 'brew services start'
alias pbrsvcsp 'brew services stop'
alias pbrsvcrs 'brew services restart'
alias pbrserv 'brew services'
alias pbrbun 'brew bundle'
alias pbrbund 'brew bundle dump'
alias pbrbunc 'brew bundle cleanup'
alias pbrcask 'brew casks'
alias pbrform 'brew formulae'
alias ppac 'pacman'
alias ppaq 'pacman -Q'
alias ppaqi 'pacman -Qi'
alias ppaql 'pacman -Ql'
alias ppaqo 'pacman -Qo'
alias ppaqs 'pacman -Qs'
alias ppaqdt 'pacman -Qdt'
alias ppaqd 'pacman -Qd'
alias ppaqe 'pacman -Qe'
alias ppaqm 'pacman -Qm'
alias ppas 'pacman -Ss'
alias ppasi 'pacman -Si'
alias ppaup 'sudo pacman -Syu'
alias ppain 'sudo pacman -S'
alias pparm 'sudo pacman -Rns'
alias ppard 'sudo pacman -Rdd'
alias ppasc 'sudo pacman -Sc'
alias ppaf 'pacman -Fl'
alias ppaowns 'pacman -Qo'
alias ppafiles 'pacman -Fl'
alias ppaorph 'pacman -Qtdq'
alias ppaclean 'sudo pacman -Rns $(pacman -Qtdq)'
alias ppaar 'sudo pacman -Syu --noconfirm'
alias ppau 'sudo pacman -Syu'
alias ppasy 'sudo pacman -Sy'
alias ppauma 'sudo pacman -Syu --noconfirm'
alias ppah 'pacman -Qii'
alias papt 'apt'
alias papts 'apt search'
alias paptsh 'apt show'
alias paptup 'sudo apt update'
alias paptug 'sudo apt upgrade -y'
alias paptfu 'sudo apt full-upgrade -y'
alias paptin 'sudo apt install'
alias paptrm 'sudo apt remove'
alias paptpur 'sudo apt purge'
alias paptau 'sudo apt autoremove -y'
alias paptcl 'sudo apt clean'
alias paptac 'sudo apt autoclean'
alias paptfix 'sudo apt --fix-broken install'
alias paptdw 'sudo apt download'
alias paptsrc 'sudo apt source'
alias paptbd 'sudo apt build-dep'
alias paptpl 'apt policy'
alias paptlu 'apt list --upgradable'
alias paptli 'apt list --installed'
alias paptsrv 'apt list --installed | grep -i'
alias paph 'apt-mark hold'
alias papunh 'apt-mark unhold'
alias papsh 'apt-mark showhold'
alias papch 'apt-get changelog'
alias pdnf 'dnf'
alias pdnfs 'dnf search'
alias pdnfsi 'dnf info'
alias pdnfup 'sudo dnf upgrade -y'
alias pdnfi 'sudo dnf install'
alias pdnfrm 'sudo dnf remove'
alias pdnfau 'sudo dnf autoremove -y'
alias pdnfq 'dnf list installed'
alias pdnfqi 'dnf list installed | grep'
alias pdnfre 'dnf repolist'
alias pdnfgl 'dnf group list'
alias pdnfcc 'sudo dnf clean all'
alias pdnfhi 'dnf history'
alias pdnfhiu 'dnf history userinstalled'
alias pdnfroll 'dnf history rollback'
alias pdnfdw 'dnf downgrade'
alias pdnfli 'sudo dnf localinstall'
alias pdnfprov 'dnf provides'
alias pdnfchk 'dnf check-update'
alias pdnfmod 'dnf module list'
if type -q yay
    alias pyay 'yay'
    alias pyays 'yay -Ss'
    alias pyayq 'yay -Q'
    alias pyayqi 'yay -Qi'
    alias pyayup 'yay -Syu'
    alias pyayin 'yay -S'
    alias pyayrm 'yay -Rns'
    alias pyaycl 'yay -Sc'
    alias pyaydb 'yay -Y --gendb'
    alias pyaydev 'yay -S --devel'
    alias pyayfl 'yay -Fl'
    alias pyaynews 'yay -P --news'
    alias pyaycf 'yay -Pg'
end
alias pnpm 'npm'
alias pnmini 'npm init -y'
alias pnminst 'npm install'
alias pnmins 'npm install --save'
alias pnmisd 'npm install --save-dev'
alias pnmig 'npm install -g'
alias pnmrm 'npm uninstall'
alias pnmrms 'npm uninstall --save'
alias pnmrmd 'npm uninstall --save-dev'
alias pnmrmg 'npm uninstall -g'
alias pnmup 'npm update'
alias pnmout 'npm outdated'
alias pnmls 'npm list'
alias pnmlsg 'npm list -g --depth=0'
alias pnmrun 'npm run'
alias pnmt 'npm test'
alias pnmb 'npm run build'
alias pnmd 'npm run dev'
alias pnms 'npm run start'
alias pnmlnt 'npm run lint'
alias pnmfmt 'npm run format'
alias pnmpub 'npm publish'
alias pnmvers 'npm version'
alias pnmhr 'npm run'
alias pnmcx 'npm cache clean --force'
alias pnmaud 'npm audit'
alias pnmaudf 'npm audit fix'
alias pnmwho 'npm whoami'
alias pnmlog 'npm login'
alias pnmdc 'npm docs'
alias pnmbug 'npm bugs'
alias pnmrepo 'npm repo'
alias pnmex 'npm exec'
alias pnmwhy 'npm why'
alias pnmdedup 'npm dedupe'
alias pnmci 'npm ci'
alias pnmprune 'npm prune'
alias pnpn 'pnpm'
alias pnpni 'pnpm install'
alias pnpnr 'pnpm run'
alias pnpnd 'pnpm run dev'
alias pnpnb 'pnpm run build'
alias pnpnt 'pnpm test'
alias pnpnl 'pnpm run lint'
alias pnpna 'pnpm add'
alias pnpnad 'pnpm add -D'
alias pnpnag 'pnpm add -g'
alias pnpnrm 'pnpm remove'
alias pnpnup 'pnpm update'
alias pnpnout 'pnpm outdated'
alias pnpnls 'pnpm list'
alias pnpnlsg 'pnpm list -g'
alias pnpninit 'pnpm init'
alias pnpnpub 'pnpm publish'
alias pnpnex 'pnpm exec'
alias pnpnst 'pnpm store'
alias pnpnstp 'pnpm store prune'
alias pnpnstst 'pnpm store status'
alias pcr 'cargo'
alias pcrbl 'cargo build'
alias pcrblr 'cargo build --release'
alias pcrun 'cargo run'
alias pcrrunr 'cargo run --release'
alias pcrt 'cargo test'
alias pcrtf 'cargo test -- --nocapture'
alias pcrck 'cargo check'
alias pcrcl 'cargo clippy'
alias pcrfmt 'cargo fmt'
alias pcrfix 'cargo fix'
alias pcrdoc 'cargo doc'
alias pcrpub 'cargo publish'
alias pcrup 'cargo update'
alias pcrau 'cargo outdated'
alias pcradd 'cargo add'
alias pcrrm 'cargo remove'
alias pcrcln 'cargo clean'
alias pcrinit 'cargo init'
alias pcrnew 'cargo new'
alias pcrw 'cargo watch'
alias pcrl 'cargo +nightly'
alias pcret 'cargo expand'
alias pgo 'go'
alias pgorun 'go run'
alias pgob 'go build'
alias pgobld 'go build -o'
alias pgoget 'go get'
alias pgoin 'go install'
alias pgot 'go test'
alias pgotv 'go test -v ./...'
alias pgotc 'go test -cover ./...'
alias pgom 'go mod'
alias pgomi 'go mod init'
alias pgomt 'go mod tidy'
alias pgomv 'go mod vendor'
alias pgomd 'go mod download'
alias pgomgl 'go mod graph'
alias pgomwh 'go mod why'
alias pgof 'go fmt ./...'
alias pgov 'go vet ./...'
alias pgoenv 'go env'
alias pgocln 'go clean -cache'
alias pgodoc 'go doc'
alias pgover 'go version'
alias pgogen 'go generate'
alias pgolint 'golint ./...'
alias pgost 'go tool pprof'
alias ppy 'python3'
alias ppys 'python3 -S'
alias ppyi 'python3 -i'
alias ppym 'python3 -m'
alias ppyhttp 'python3 -m http.server'
alias ppyjson 'python3 -m json.tool'
alias ppyv 'python3 -m venv'
alias ppyactivate 'source .venv/bin/activate'
alias ppypip 'python3 -m pip'
alias ppypia 'pip install'
alias ppypir 'pip install -r requirements.txt'
alias ppyfreeze 'pip freeze > requirements.txt'
alias ppyinst 'pip list'
alias ppyout 'pip list --outdated'
alias ppyt 'python3 -m pytest'
alias ppytv 'python3 -m pytest -v'
alias ppyun 'python3 -m unittest'
alias ppyvrb 'python3 -m unittest -v'
alias ppycov 'python3 -m pytest --cov'
alias ppyblack 'python3 -m black'
alias ppyflk 'python3 -m flake8'
alias ppymb 'python3 -m mypy'
alias ppylint 'python3 -m pylint'
alias ppyband 'python3 -m bandit'
alias ppysa 'python3 -m safety check'
alias ppyuv 'pip install uv && uv'
alias ppytut 'python3 -m pendulum'
alias ppychk 'python3 -m py_compile'
alias ppycfg 'python3 -m site'
alias ppyupip 'python3 -m pip install --upgrade pip'
alias psh 'ssh'
alias psha 'ssh -A'
alias pshc 'ssh-copy-id'
alias pshk 'ssh-keygen'
alias pshkr 'ssh-keygen -R'
alias pshkf 'ssh-keygen -F'
alias pshK 'ssh -o StrictHostKeyChecking=no'
alias pshp 'ssh -p'
alias pshj 'ssh -J'
alias pshl 'ssh -L'
alias pshr 'ssh -R'
alias pshD 'ssh -D'
alias pshv 'ssh -v'
alias pshf 'ssh -f'
alias pshN 'ssh -N'
alias pshcp 'scp -r'
alias pshrsync 'rsync -avz -e ssh'
alias pgg 'gpg'
alias pggc 'gpg -c'
alias pgge 'gpg -e'
alias pggd 'gpg -d'
alias pggs 'gpg -s'
alias pggv 'gpg --verify'
alias pggls 'gpg --list-keys'
alias pgglssec 'gpg --list-secret-keys'
alias pgglo 'gpg --list-keys --keyid-format LONG'
alias pggks 'gpg --list-keys | grep "^pub\|^sub"'
alias pggk 'gpg --keyserver keyserver.ubuntu.com --search-keys'
alias pggrecv 'gpg --recv-keys'
alias pggen 'gpg --full-generate-key'
alias pggexp 'gpg --export -a'
alias pggimp 'gpg --import'
alias pggxprt 'gpg --export-secret-keys -a'
alias pggdel 'gpg --delete-key'
alias pggdels 'gpg --delete-secret-key'
alias pggsign 'gpg --sign-key'
alias pggenc 'gpg --encrypt'
alias pggchm 'gpg --change-passphrase'
alias pggkys 'gpg --show-key'
alias pggarm 'gpg --armor'
alias pggcle 'gpgconf --kill gpg-agent'
alias pggrel 'gpgconf --reload gpg-agent'
alias psys 'cat /etc/os-release'
alias psysk 'uname -a'
alias psysh 'hostnamectl'
alias psyld 'uptime'
alias psym 'free -h'
alias psyd 'df -h'
alias psyc 'lscpu'
alias psyp 'ps aux | head -20'
alias psyu 'who'
alias psyw 'who -b'
alias psyl 'last'
alias psyda 'date'
alias psyche 'cal'
alias psymod 'lsmod'
alias psypci 'lspci'
alias psyusb 'lsusb'
alias psydm 'dmesg -T'
alias psykrn 'uname -r'
alias pnet 'ip addr'
alias pnetl 'ip link'
alias pnetr 'ip route'
alias pnetn 'ip neigh'
alias pnets 'ip -stats'
alias pnetns 'ip netns'
alias pnetst 'ss -tulanp'
alias pnetstt 'ss -tunap'
alias pnets4 'ss -t4'
alias pnetstl 'ss -tlnp'
alias pnetfw 'iptables -L -n -v'
alias pnetfw6 'ip6tables -L -n -v'
alias pnetm 'nmap -sn'
alias pnetmp 'nmap -sV -sC'
alias pnett 'traceroute'
alias pnetp 'ping -c 4'
alias pnetpf 'ping -c 100 -f'
alias pnetd 'dig'
alias pnetdns 'dig +short'
alias pneth 'host'
alias pnetw 'wget -c'
alias pnetcur 'curl -fsSL'
alias pnetmyip 'curl -fsSL ifconfig.me'
alias pnetdh 'dhclient'
alias pnettcp 'tcptraceroute'
alias pnetbw 'iperf3'
alias pnetwbw 'speedtest-cli'
alias pproc 'ps auxf'
alias pproca 'ps aux'
alias pprocf 'ps aux | grep'
alias pproct 'pstree'
alias pprocpid 'pgrep -f'
alias pprock 'kill -9'
alias pprocterm 'kill -15'
alias pprocpk 'pkill -f'
alias pprocn 'nice -n'
alias pprocrn 'renice -n'
alias pprocnohup 'nohup'
alias pprocnice 'nice -n 19'
alias pproci 'iotop -o'
alias pprocs 'ps --sort=-%cpu | head'
alias ptexg 'grep'
alias ptexgr 'grep -r'
alias ptexgi 'grep -i'
alias ptexv 'grep -v'
alias ptexl 'grep -l'
alias ptexc 'grep -c'
alias ptexs 'sed'
alias ptexx 'sed -n'
alias ptexa 'awk'
alias ptexaw 'awk "{print}"'
alias ptexsr 'sort -r'
alias ptexu 'uniq'
alias ptexuc 'sort | uniq -c | sort -rn'
alias ptexwc 'wc -l'
alias ptexww 'wc -w'
alias ptexcut 'cut -d'
alias ptextr 'tr'
alias ptexpd 'paste -d'
alias ptexcol 'column -t'
alias ptexdf 'diff'
alias ptexdiy 'diff -y'
alias ptexhd 'head -n'
alias ptextl 'tail -n'
alias ptextf 'tail -f'
alias ptexxm 'xmllint --format'
alias ptexj 'python3 -m json.tool'
alias ptexy 'yq eval'
alias ptexb 'bat --language'
alias ptexxd 'xxd'
alias psec 'openssl version'
alias pseca 'openssl enc -aes-256-cbc -salt -in'
alias psecd 'openssl enc -d -aes-256-cbc -in'
alias psecr 'openssl rand -hex'
alias psecrs 'openssl rand -base64'
alias pseck 'openssl genrsa -out'
alias psecreq 'openssl req -new -key'
alias psecx 'openssl x509 -in'
alias psecs 'openssl s_client -connect'
alias psecv 'openssl verify'
alias psech 'sha256sum'
alias psecsh 'shasum -a 256'
alias psecmd5 'md5sum'
alias psecshred 'shred -uz'
alias psecharden 'chmod 600'
alias pfilecp 'cp -i'
alias pfilemv 'mv -i'
alias pfilerm 'rm -i'
alias pfilecpf 'cp -f'
alias pfilemvf 'mv -f'
alias pfilermf 'rm -f'
alias pfilermr 'rm -r'
alias pfilersync 'rsync -avz'
alias pfilemk 'mkdir -p'
alias pfilechx 'chmod +x'
alias pfilechm 'chmod'
alias pfileown 'chown'
alias pfilegrp 'chgrp'
alias pfileln 'ln -sf'
alias pfilebak 'cp -r "$1" "$1.bak"'
alias pfiletouch 'touch'
alias pfileread 'cat -n'
alias pfileless 'less -N'
alias pfilehead 'head -n'
alias pfiletail 'tail -n'
alias pfilefoll 'tail -f'
alias pfilewatch 'watch -n 2'
alias pfilefind 'find . -name'
alias pfilerca 'fd'
alias pfiletree 'tree'
alias pfilestat 'stat'
alias parcx 'tar -xf'
alias parct 'tar -czf'
alias parctxz 'tar -xJf'
alias parctzx 'tar -cJf'
alias parcjx 'tar -xjf'
alias parctl 'tar -tvf'
alias parczip 'zip -r'
alias parczipd 'zip -r -d .'
alias parcunz 'unzip'
alias parcunzl 'unzip -l'
alias parcunzt 'unzip -t'
alias parc7z '7z x'
alias parc7za '7z a'
alias parc7zl '7z l'
alias parc7zt '7z t'
alias parcr 'unrar x'
alias parcgl 'gunzip'
alias parcgz 'gzip'
alias parcbl 'bunzip2'
alias parcbz 'bzip2'
alias parcxl 'unxz'
alias parcxz 'xz'
alias pdbm 'mysql -u root -p'
alias pdbmd 'mysqldump -u root -p'
alias pdbms 'mysql -u root -p -e'
alias pdbps 'psql -U postgres'
alias pdbpsd 'pg_dump -U postgres'
alias pdbsq 'sqlite3'
alias pdbredis 'redis-cli'
alias pdbredping 'redis-cli ping'
alias pdbmong 'mongosh'
alias pdevv 'nvim'
alias pdevcode 'code'
alias pdevmake 'make'
alias pdevjust 'just'
alias pdevlazy 'lazygit'
alias pdevyazi 'yazi'
alias pdevzellij 'zellij'
alias pdevgit 'git'
alias pdevgh 'gh'
alias pdevglb 'glab'
alias pcaws 'aws'
alias pcawss3 'aws s3 ls'
alias pcawsec2 'aws ec2 describe-instances'
alias pcawsiam 'aws iam list-users'
alias pcawsinfo 'aws sts get-caller-identity'
alias pcgcl 'gcloud'
alias pcgclls 'gcloud compute instances list'
alias pcgclgke 'gcloud container clusters list'
alias pcaz 'az'
alias pcazls 'az vm list'
alias pcazaks 'az aks list'
alias pmediaff 'ffmpeg -i'
alias pmediafp 'ffprobe'
alias pmediafg 'ffplay'
alias pmediaimg 'convert'
alias pmediaimgr 'convert -resize'
alias pmediaimgg 'convert -gravity center'
alias pmediaimgq 'convert -quality 85'
alias pmediaexif 'exiftool'
alias putiltime 'date +%s'
alias putilnow 'date +"%F %T"'
alias putiltoday 'date +%F'
alias putilsum 'sha256sum'
alias putilmd5 'md5sum'
alias putilb64 'base64'
alias putilb64d 'base64 -d'
alias putiluuid 'uuidgen'
alias putilpw 'openssl rand -base64 16'
alias putilurle 'python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))"'
alias putilurld 'python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))"'
alias putiljson 'python3 -m json.tool'
alias putilyaml 'python3 -c "import sys,yaml,json; print(yaml.dump(json.load(sys.stdin)))"'
alias putilxml 'xmllint --format'
function putiltimer; set start (date +%s); eval $argv; set code $status; set end (date +%s); echo "elapsed: "(math "$end - $start")"s"; return $code; end
alias putilbench 'hyperfine'
alias putilrand 'shuf -i'
alias putilseq 'seq'
alias putilcls 'clear'
alias puticlean 'rm -rf ~/.cache/*'
alias putilps 'ps auxf'
alias putilkill 'kill -9'
alias putilhs 'history | grep'
alias putilhist 'history'
alias putilsr 'source "$HOME/.zshrc"'
alias pfd 'fd'
alias pbat 'bat'
alias prg 'rg'
alias peza 'eza'
alias pdu 'dust'
alias pdf 'duf'
alias ptop 'btop'

if type -q atuin
    alias atu 'atuin'
    alias atus 'atuin search'
    alias atul 'atuin login'
    alias atur 'atuin register'
    alias atusync 'atuin sync'
    alias atust 'atuin status'
    alias atuh 'atuin history'
    alias atuhl 'atuin history list'
    alias atustats 'atuin stats'
end

if type -q direnv
    alias dir 'direnv'
    alias dira 'direnv allow'
    alias dird 'direnv deny'
    alias dirr 'direnv reload'
    alias dire 'direnv edit'
    alias dirv 'direnv view'
    alias dirh 'direnv hook'
end

if type -q zoxide
    alias z 'zoxide'
    alias zi 'zoxide query -i'
end

if type -q fzf
    alias fz 'fzf'
    alias fzp 'fzf --preview'
end

if type -q gh
    alias gh 'gh'
    alias ghs 'gh status'
    alias ghp 'gh pr'
    alias ghpl 'gh pr list'
    alias ghpc 'gh pr create'
    alias ghpm 'gh pr merge'
    alias ghco 'gh pr checkout'
    alias ghi 'gh issue'
    alias ghil 'gh issue list'
    alias ghic 'gh issue create'
    alias ghr 'gh release'
    alias ghrl 'gh release list'
    alias ghrc 'gh release create'
    alias ghrd 'gh release download'
    alias ghrv 'gh release view'
    alias ghr 'gh repo'
    alias ghrv 'gh repo view'
    alias ghcl 'gh repo clone'
    alias ghcr 'gh repo create'
    alias ghw 'gh workflow'
end

if type -q fastfetch
    alias ffet 'fastfetch'
    alias ffetl 'fastfetch -l'
end

if type -q hyperfine
    alias hf 'hyperfine'
    alias hfw 'hyperfine --warmup'
end

if type -q delta
    alias delta 'delta'
end

if type -q jq
    alias jq 'jq'
    alias jqc 'jq -c'
    alias jqr 'jq -r'
    alias jqs 'jq -S'
end

if type -q yq
    alias yq 'yq'
    alias yqe 'yq eval'
    alias yqp 'yq eval -P'
end

if type -q glow
    alias glow 'glow'
    alias glows 'glow -s'
end

if type -q dog
    alias dog 'dog'
    alias doga 'dog A'
    alias dogmx 'dog MX'
    alias dogns 'dog NS'
    alias dogtxt 'dog TXT'
end

if type -q http
    alias https 'https'
end

if command -v procs >/dev/null 2>&1 || command -v bottom >/dev/null 2>&1; then
    alias procs 'procs'
end

if type -q bandwhich
    alias band 'bandwhich'
    alias bandl 'bandwhich -r'
end

if type -q gping
    alias gping 'gping'
end

if type -q ouch
    alias ouch 'ouch'
    alias ouchd 'ouch decompress'
    alias ouchc 'ouch compress'
    alias ouchl 'ouch list'
end

if type -q sd
    alias sd 'sd'
end

if type -q navi
    alias navi 'navi'
    alias naviq 'navi --query'
end

if command -v tldr >/dev/null 2>&1 || command -v tealdeer >/dev/null 2>&1
    alias tldr 'tldr 2>/dev/null || tealdeer'
end

if type -q lazydocker
    alias lzd 'lazydocker'
end

if type -q vivid
    alias vivid 'vivid'
    alias vividg 'vivid generate'
    alias vividt 'vivid themes'
end

if type -q chezmoi
    alias chez 'chezmoi'
    alias cheza 'chezmoi apply'
    alias chezd 'chezmoi diff'
    alias cheze 'chezmoi edit'
    alias chezad 'chezmoi add'
    alias chezup 'chezmoi update'
    alias chezcd 'chezmoi cd'
    alias chezi 'chezmoi init'
    alias chezs 'chezmoi status'
    alias chezr 'chezmoi re-add'
end

if type -q act
    alias act 'act'
    alias actl 'act -l'
    alias actp 'act -p'
    alias actpush 'act push'
    alias actpr 'act pull_request'
    alias actw 'act -W'
end

if type -q vault
    alias vault 'vault'
    alias vaults 'vault status'
    alias vaultl 'vault login'
    alias vaultkv 'vault kv'
    alias vaultkvg 'vault kv get'
    alias vaultkvp 'vault kv put'
    alias vaultkvd 'vault kv delete'
    alias vaultr 'vault read'
    alias vaultw 'vault write'
end

if type -q kind
    alias kind 'kind'
    alias kindc 'kind create cluster'
    alias kindd 'kind delete cluster'
    alias kindg 'kind get clusters'
    alias kindk 'kind get kubeconfig'
end

if type -q vagrant
    alias vg 'vagrant'
    alias vgu 'vagrant up'
    alias vgh 'vagrant halt'
    alias vgd 'vagrant destroy'
    alias vgs 'vagrant status'
    alias vgssh 'vagrant ssh'
    alias vgp 'vagrant provision'
    alias vgreload 'vagrant reload'
    alias vgbox 'vagrant box list'
end

if type -q packer
    alias pk 'packer'
    alias pkb 'packer build'
    alias pkv 'packer validate'
    alias pkf 'packer fmt'
    alias pkinit 'packer init'
end

if type -q age
    alias age 'age'
    alias agee 'age -e'
    alias aged 'age -d'
    alias agegen 'age-keygen'
end

if type -q sops
    alias sops 'sops'
    alias sopse 'sops -e'
    alias sopsd 'sops -d'
    alias sopsi 'sops -i'
end

if type -q argocd
    alias argo 'argocd'
    alias argol 'argocd login'
    alias argos 'argocd app sync'
    alias argog 'argocd app get'
    alias argolist 'argocd app list'
    alias argodiff 'argocd app diff'
end

if type -q minikube
    alias mk 'minikube'
    alias mks 'minikube start'
    alias mkst 'minikube stop'
    alias mkd 'minikube delete'
    alias mkst 'minikube status'
    alias mkpa 'minikube pause'
    alias mkun 'minikube unpause'
    alias mkdash 'minikube dashboard'
    alias kip 'minikube ip'
    alias mkadd 'minikube addons list'
end

if type -q k0s
    alias k0 'k0s'
    alias k0s 'k0s status'
    alias k0c 'k0s kubectl'
    alias k0start 'k0s controller'
end

if type -q talosctl
    alias tals 'talosctl version'
    alias talc 'talosctl config'
end

if type -q skopeo
    alias sk 'skopeo'
    alias skc 'skopeo copy'
    alias skl 'skopeo list-tags'
    alias ski 'skopeo inspect'
    alias sks 'skopeo sync'
end

if type -q dive
    alias dive 'dive'
end

if type -q hadolint
    alias hado 'hadolint'
end

if type -q trivy
    alias trivy 'trivy'
    alias trivyi 'trivy image'
    alias trivyf 'trivy fs'
    alias trivyr 'trivy repo'
end

if type -q cosign
    alias cosign 'cosign'
    alias cosignv 'cosign verify'
    alias cosigns 'cosign sign'
end

alias try 'curl -fsSL https://cht.sh'
alias tldrl 'curl -fsSL https://cheat.sh'

if type -q rclone
    alias rcl 'rclone'
    alias rclls 'rclone ls'
    alias rclsync 'rclone sync'
    alias rclc 'rclone copy'
    alias rclmv 'rclone move'
end

if type -q restic
    alias rest 'restic'
    alias restb 'restic backup'
    alias restr 'restic restore'
    alias rests 'restic snapshots'
    alias restc 'restic check'
end

if type -q borg
    alias borg 'borg'
    alias borgc 'borg create'
    alias borge 'borg extract'
    alias borgl 'borg list'
    alias borgi 'borg info'
    alias borgd 'borg delete'
    alias borgpr 'borg prune'
end

if type -q kopia
    alias kop 'kopia'
    alias kops 'kopia snapshot create'
    alias kopl 'kopia snapshot list'
    alias kopm 'kopia mount'
    alias kopc 'kopia cache clear'
end

alias pclr 'clear'
alias pdup 'docker compose up -d'
alias pddown 'docker compose down'

alias py='python3'
alias ip='ip -br addr'
alias free='free -h'
alias pscpu='ps aux --sort=-%cpu'
alias psmem='ps aux --sort=-%mem'
alias psuser='ps -u'
alias nslookup='nslookup'
alias curl='curl'
alias tar='tar'
alias unzip='unzip'
alias ssh='ssh'
alias scp='scp'
alias mkdir='mkdir -p'
alias rmdir='rmdir'
alias chmod='chmod'
alias xargs='xargs'
alias touch='touch'
alias watch='watch'
alias date='date'
alias bc='bc -l'
alias expr='expr'
alias printf='printf'
alias duk='du -sh * | sort -h'
alias psi='ps aux | grep -i'
alias psaux='ps aux'
alias psf='ps auxf'
alias psxl='ps aux --forest'
alias iftop='sudo iftop'
alias dnst='dig +short'
alias idg='id -g'
alias idu='id -u'
alias groups='groups'
alias last='last'
alias w='w'
alias tmpdir='cd (mktemp -d)'
alias math='python3 -c'
alias seq='seq'
alias shuffle='shuf'
alias expand='expand'
alias unexpand='unexpand'
alias od='od'
alias strings='strings'
alias comm='comm'
alias grepw='grep -w'
alias grepr='grep -r'
alias grex='grep -r --exclude-dir=.git --exclude-dir=node_modules'

alias du2='du -sh --max-depth=2'
alias dux='du -sh * | sort -h'
alias pr='pr'
alias rsample='shuf -n'
alias rstring='python3 -c "import secrets; print(secrets.token_hex())"'
alias serv='systemctl'
alias jrnl='journalctl'
alias pod='podman'
alias podps='podman ps'
alias podrun='podman run -it --rm'
alias podimg='podman images'
alias dstats='docker stats --no-stream'
alias kns='kubectl config set-context --namespace'
alias kpf='kubectl port-forward'
alias psea "ps -e"
alias pgitcln "git clean -fd"
alias pyay "yay"
alias pyays "yay -Ss"
alias pyayq "yay -Q"
alias pyayqi "yay -Qi"
alias pyayup "yay -Syu"
alias pyayin "yay -S"
alias pyayrm "yay -Rns"
alias pyaycl "yay -Sc"
alias pyaydb "yay -Y --gendb"
alias pyaydev "yay -S --devel"
alias pyayfl "yay -Fl"
alias pyaynews "yay -P --news"
alias pyaycf "yay -Pg"
alias pcrbn "cargo bench"
alias psyblk "lsblk"
alias pnslk "nslookup"
alias parcjc "tar -cjf"
alias pac "sudo pacman"
alias pacup "sudo pacman -Syu"
alias pacin "sudo pacman -S"
alias pacrm "sudo pacman -Rns"
alias pacs "pacman -Ss"
alias pacq "pacman -Q"
alias pacqi "pacman -Qi"
alias pacqii "pacman -Qii"
alias pacql "pacman -Ql"
alias pacqo "pacman -Qo"
alias pacqs "pacman -Qs"
alias pacqdt "pacman -Qdt"
alias pacqd "pacman -Qd"
alias pacqe "pacman -Qe"
alias pacqm "pacman -Qm"
alias pacqg "pacman -Qg"
alias pacqu "pacman -Qu"
alias pacqtt "pacman -Qt"
alias pacqk "pacman -Qk"
alias pacsi "pacman -Si"
alias pacsii "pacman -Sii"
alias pacsl "pacman -Sl"
alias pacslo "pacman -Slo"
alias pacsp "pacman -Sp"
alias pacsu "pacman -Su"
alias pacsw "pacman -Sw"
alias pacscc "sudo pacman -Scc"
alias pacsc "sudo pacman -Sc"
alias pacown "pacman -Qo"
alias pacdiff "pacman -Si"
alias pacfiles "pacman -Fl"
alias paclsorph "pacman -Qtd"
alias pacdep "pacman -Si"
alias pacwhy "pacman -D --asexplicit"
alias pacasex "pacman -D --asexplicit"
alias pacasdep "pacman -D --asdeps"
alias fixpacman "sudo rm -f /var/lib/pacman/db.lck"
alias pacls "pacman -Qql"
alias pacupg "sudo pacman -Syu --noconfirm"
alias pacupd "sudo pacman -Sy"
alias pacug "sudo pacman -Su"
alias pacref "sudo pacman -Syy"
alias pacre "sudo pacman -R"
alias pacrem "sudo pacman -R"
alias pacrems "sudo pacman -Rs"
alias pacrmc "sudo pacman -Rc"
alias pacrmcs "sudo pacman -Rcs"
alias pacrmn "sudo pacman -Rn"
alias pacrmns "sudo pacman -Rns"
alias pacrmu "sudo pacman -Rdd"
alias pacget "pacman -Sw"
alias pacwget "pacman -Sw"
alias pacor "sudo pacman -Sc"
alias pacocc "sudo pacman -Scc"
alias pacowned "pacman -Qii"
alias paccheckdb "pacman -Dk"
alias pactest "pacman -Dk"
alias pacdis "pacman -D"
alias pacdbg "pacman -Qqg base-devel"
alias pacbase "sudo pacman -S base base-devel"
alias pacorph "pacman -Qtdq"
alias jlog "journalctl -xe"
alias jboot "journalctl -b"
alias jfail "journalctl -p 3 -xb"
alias jefail "journalctl -p 3 -xb --no-hostname"
alias jfollow "journalctl -f"
alias jservice "journalctl -fu"
alias jservicelast "journalctl -u -n 50"
alias aptg "sudo apt-get"
alias aptgi "sudo apt-get install"
alias aptgr "sudo apt-get remove"
alias aptgp "sudo apt-get purge"
alias aptgu "sudo apt-get update"
alias aptgup "sudo apt-get upgrade"
alias aptgupg "sudo apt-get dist-upgrade"
alias aptgfull "sudo apt-get full-upgrade"
alias aptgd "sudo apt-get download"
alias aptgsrc "sudo apt-get source"
alias aptgbd "sudo apt-get build-dep"
alias aptgcheck "sudo apt-get check"
alias aptga "sudo apt-get autoremove"
alias aptgac "sudo apt-get autoclean"
alias aptgc "sudo apt-get clean"
alias aptgf "sudo apt-get install -f"
alias aptgfix "sudo apt-get --fix-broken install"
alias aptgdr "sudo apt-get --dry-run install"
alias aptgsim "sudo apt-get --simulate"
alias aptgre "sudo apt-get install --reinstall"
alias aptgnu "sudo apt-get install --no-upgrade"
alias aptgou "sudo apt-get install --only-upgrade"
alias aptgdu "sudo apt-get dist-upgrade --dry-run"
alias aptgsh "sudo apt-get -s install"
alias aptup "sudo apt update && sudo apt upgrade"
alias aptin "sudo apt install"
alias aptr "sudo apt remove"
alias aptp "sudo apt purge"
alias apts "apt search"
alias aptq "dpkg -l"
alias aptshow "apt show"
alias aptfiles "dpkg -L"
alias aptown "dpkg -S"
alias aptclean "sudo apt autoremove && sudo apt autoclean"
alias aptfix "sudo apt install -f"
alias aptdl "apt download"
alias aptlist "apt list"
alias aptli "apt list --installed"
alias aptlu "apt list --upgradable"
alias aptla "apt list --all-versions"
alias aptpolicy "apt policy"
alias aptfu "sudo apt full-upgrade"
alias aptau "sudo apt autoremove"
alias aptac "sudo apt autoclean"
alias aptcc "sudo apt clean"
alias aptdr "sudo apt --dry-run"
alias aptch "apt changelog"
alias acs "apt-cache search"
alias acsh "apt-cache show"
alias acsp "apt-cache showpkg"
alias acsrc "apt-cache showsrc"
alias acst "apt-cache stats"
alias acdep "apt-cache depends"
alias acrdep "apt-cache rdepends"
alias acpn "apt-cache pkgnames"
alias acpol "apt-cache policy"
alias acdump "apt-cache dump"
alias acdumav "apt-cache dumpavail"
alias acun "apt-cache unmet"
alias amh "sudo apt-mark hold"
alias amuh "sudo apt-mark unhold"
alias amsh "apt-mark showhold"
alias ama "sudo apt-mark auto"
alias amm "sudo apt-mark manual"
alias amsa "apt-mark showauto"
alias assm "apt-mark showmanual"
alias aedit "sudo apt edit-sources"
alias asat "apt satisfies"
alias dpi "sudo dpkg -i"
alias dpr "sudo dpkg -r"
alias dpp "sudo dpkg -P"
alias dpl "dpkg -l"
alias dpq "dpkg --list"
alias dpqi "dpkg -l | grep"
alias dpqf "dpkg -L"
alias dpqo "dpkg -S"
alias dpqs "dpkg -s"
alias dpqc "dpkg -c"
alias dpqI "dpkg -I"
alias dpqa "dpkg --audit"
alias dpcfg "sudo dpkg --configure -a"
alias dpfunpack "sudo dpkg --unpack"
alias dpfconfig "sudo dpkg --configure"
alias dpfstatus "dpkg --status"
alias dpfsearch "dpkg --search"
alias dpfprint "dpkg --print-architecture"
alias dpff "dpkg --force-all -i"
alias dpdiv "dpkg --compare-versions"
alias dpclr "sudo dpkg --clear-avail"
alias dpfor "sudo dpkg --force-depends -i"
alias dppurge "sudo dpkg --purge"
alias dpdeb "dpkg-deb"
alias dpdebc "dpkg-deb -c"
alias dpdebi "dpkg-deb -I"
alias dpdebf "dpkg-deb -f"
alias dpdebe "dpkg-deb -e"
alias dpdebx "dpkg-deb -x"
alias dpdebX "dpkg-deb -X"
alias dpdebv "dpkg-deb --vextract"
alias dpqry "dpkg-query"
alias dpqryW "dpkg-query -W"
alias dpqryf "dpkg-query -f"
alias dpqryl "dpkg-query -L"
alias dpqrys "dpkg-query -S"
alias dpqryp "dpkg-query -p"
alias dprec "sudo dpkg-reconfigure"
alias dpreca "sudo dpkg-reconfigure -a"
alias dprecp "sudo dpkg-reconfigure --priority"
alias dprecf "sudo dpkg-reconfigure --frontend"
alias aptkey "sudo apt-key"
alias aptkeya "sudo apt-key adv"
alias aptkeyl "sudo apt-key list"
alias aptkeyf "sudo apt-key finger"
alias aptkeyd "sudo apt-key del"
alias aptkeyadd "sudo apt-key add"
alias srclist "ls /etc/apt/sources.list.d/"
alias srcshow "cat /etc/apt/sources.list"
alias srcbackup "sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak"
alias srcrestore "sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list"
alias supd "sudo apt-get update 2>&1 | grep -E \"(Hit|Ign|Err|Get)\""
alias supdlist "sudo apt-get update 2>&1 | grep -v \"^Hit:\""
alias osr "cat /etc/os-release"
alias osid "grep ^ID= /etc/os-release"
alias osver "grep ^VERSION_ID= /etc/os-release"
alias oslike "grep ^ID_LIKE= /etc/os-release"
alias aptfull "sudo apt update && sudo apt dist-upgrade -y"
alias aptfixall "sudo apt update && sudo apt install -f && sudo dpkg --configure -a && sudo apt autoremove"
alias aptnuke "sudo apt purge ~c"
alias aptrmlock "sudo rm -f /var/lib/apt/lists/lock /var/lib/dpkg/lock /var/cache/apt/archives/lock"
alias aptshowheld "apt-mark showhold"
alias aptlog "cat /var/log/apt/history.log"
alias aptlogterm "cat /var/log/apt/term.log"
alias aptloglast "tail -50 /var/log/apt/history.log"
alias aptindex "sudo apt-cache gencaches"
alias aptmkidx "sudo apt-file update 2>/dev/null; sudo apt-get update"
alias dnfup "sudo dnf upgrade"
alias dnfu "sudo dnf upgrade"
alias dnfi "sudo dnf install"
alias dnfr "sudo dnf remove"
alias dnfs "dnf search"
alias dnfq "dnf list"
alias dnfiinfo "dnf info"
alias dnflist "dnf list available"
alias dnfinstalled "dnf list installed"
alias dnfclean "sudo dnf clean all"
alias dnfmark "dnf mark"
alias dnfhistory "dnf history"
alias dnfrequires "dnf repoquery --requires"
alias dnfprovides "dnf provides"
alias dnfri "sudo dnf reinstall"
alias dnfd "sudo dnf downgrade"
alias dnfdl "sudo dnf download"
alias dnfmake "sudo dnf makecache"
alias dnfmc "sudo dnf makecache"
alias dnfupd "dnf check-update"
alias dnfchk "dnf check-update"
alias dnfse "dnf search"
alias dnfg "dnf group list"
alias dnfgv "dnf group list -v"
alias dnfgi "sudo dnf group install"
alias dnfgr "sudo dnf group remove"
alias dnfgu "sudo dnf group upgrade"
alias dnfgup "sudo dnf group upgrade"
alias dnfgf "dnf group info"
alias dnfm "dnf module list"
alias dnfml "dnf module list"
alias dnfmi "sudo dnf module install"
alias dnfmr "sudo dnf module remove"
alias dnfme "sudo dnf module enable"
alias dnfmd "sudo dnf module disable"
alias dnfmu "sudo dnf module update"
alias dnfmup "sudo dnf module upgrade"
alias dnfminfo "dnf module info"
alias dnfrepo "dnf repolist"
alias dnfrepos "dnf repolist"
alias dnfrepoa "dnf repolist --all"
alias dnfrepoe "dnf repolist --enabled"
alias dnfrpod "dnf repolist --disabled"
alias dnfrepoup "sudo dnf update --refresh"
alias dnfcc "sudo dnf clean all"
alias dnfccdb "sudo dnf clean dbcache"
alias dnfccmeta "sudo dnf clean metadata"
alias dnfccpkg "sudo dnf clean packages"
alias dnfccexp "sudo dnf clean expire-cache"
alias dnfconfig "dnf config-manager"
alias dnfrepoadd "sudo dnf config-manager --add-repo"
alias dfnenable "sudo dnf config-manager --set-enabled"
alias dnfdisable "sudo dnf config-manager --set-disabled"
alias dnfhi "dnf history list"
alias dnfhiu "dnf history undo"
alias dnfhir "dnf history rollback"
alias dnfhis "dnf history info"
alias dnfhistore "dnf history store"
alias dnfhistl "dnf history list"
alias dnfseconly "sudo dnf upgrade --security"
alias dnfsecinfo "dnf updateinfo --list --security"
alias dnfsecadvisory "dnf updateinfo --advisory"
alias dnfau "sudo dnf autoremove"
alias dnfauto "sudo dnf autoremove"
alias dnflsorph "dnf list extras"
alias dnfleaves "dnf list extras"
alias dnfsync "sudo dnf distro-sync"
alias dnfswap "sudo dnf swap"
alias rpm "rpm"
alias rpmi "sudo rpm -ivh"
alias rpmu "sudo rpm -Uvh"
alias rpmf "sudo rpm -e"
alias rpmrm "sudo rpm -e"
alias rpmq "rpm -qa"
alias rpmqi "rpm -qi"
alias rpmql "rpm -ql"
alias rpmqc "rpm -qc"
alias rpmqd "rpm -qd"
alias rpmqr "rpm -qR"
alias rpmqo "rpm -qf"
alias rpmqp "rpm -qp"
alias rpmqpl "rpm -qpl"
alias rpmqpi "rpm -qpi"
alias rpmqs "rpm -qs"
alias rpmqwhat "rpm -q --whatprovides"
alias rpmqreq "rpm -q --whatrequires"
alias rpmqrec "rpm -q --whatrecommends"
alias rpmqsup "rpm -q --whatsupplements"
alias rpmqconf "rpm -q --whatconflicts"
alias rpmqobso "rpm -q --whatobsoletes"
alias rpmqv "rpm -q --qf"
alias rpmsig "rpm -K"
alias rpmv "rpm -V"
alias rpmva "rpm -Va"
alias rpmvf "rpm -Vf"
alias rpmdb "sudo rpm --rebuilddb"
alias rpmdbinit "sudo rpm --initdb"
alias rpmimp "sudo rpm --import"
alias rpmerase "sudo rpm -e"
alias rpmverify "rpm -V"
alias rpmvers "rpm --version"
alias rpmchecks "rpm -K --nosignature"
alias brewup "brew update && brew upgrade"
alias brewin "brew install"
alias brewrm "brew uninstall"
alias brews "brew search"
alias brewq "brew list"
alias brewli "brew leaves"
alias brewdeps "brew deps"
alias brewc "brew cleanup"
alias brewinfo "brew info"
alias brewdo "brew doctor"
alias brewpin "brew pin"
alias brewunpin "brew unpin"
alias brewupg "brew upgrade"
alias brewlink "brew link"
alias brewunlink "brew unlink"
alias brewout "brew outdated"
alias brewo "brew outdated"
alias brewcl "brew cleanup"
alias brewcln "brew cleanup --prune=all"
alias brewdesc "brew desc"
alias brewcat "brew cat"
alias brewlog "brew log"
alias brewtap "brew tap"
alias brewtapinfo "brew tap-info"
alias brewuntap "brew untap"
alias brewuses "brew uses"
alias brewrdeps "brew uses --installed"
alias brewmissing "brew missing"
alias brewsrvc "brew services"
alias brewsrvcl "brew services list"
alias brewsrvr "brew services restart"
alias brewsrvstart "brew services start"
alias brewsrvstop "brew services stop"
alias brewsrvrun "brew services run"
alias brewcask "brew install --cask"
alias brewci "brew install --cask"
alias brewcasl "brew list --cask"
alias brewcasinfo "brew info --cask"
alias brewcasrm "brew uninstall --cask"
alias brewcasup "brew upgrade --cask"
alias brewcasout "brew outdated --cask"
alias brewbundle "brew bundle"
alias brewbundl "brew bundle"
alias brewbundd "brew bundle dump"
alias brewbundc "brew bundle cleanup"
alias brewbundi "brew bundle install"
alias brewbundch "brew bundle check"
alias brewconfig "brew config"
alias pbcopy "pbcopy"
alias pbpaste "pbpaste"
alias pbc "pbcopy"
alias pbp "pbpaste"
alias mdfind "mdfind"
alias mdls "mdls"
alias mdutil "mdutil"
alias open "open"
alias o "open"
alias screencapture "screencapture"
alias afplay "afplay"
alias say "say"
alias diskut "diskutil"
alias diskutl "diskutil list"
alias diskutif "diskutil info"
alias diskutmount "diskutil mount"
alias diskutumount "diskutil unmount"
alias diskuteject "diskutil eject"
alias diskutr "diskutil rename"
alias diskutud "sudo diskutil unmountDisk"
alias diskutv "diskutil verifyVolume"
alias diskutrv "diskutil repairVolume"
alias diskutvp "diskutil verifyPermissions"
alias diskutrp "diskutil repairPermissions"
alias diskutap "diskutil apfs"
alias diskutapfl "diskutil apfs list"
alias diskutapfc "diskutil apfs create"
alias diskutapfd "diskutil apfs delete"
alias diskutapfs "diskutil apfs resize"
alias diskutapfv "diskutil apfs lock"
alias diskutapfu "diskutil apfs unlock"
alias netstat "netstat"
alias nstop "sudo lsof -iTCP -sTCP:LISTEN -P"
alias nstoppid "sudo lsof -iTCP -sTCP:LISTEN -P -p"
alias netext "sudo lsof -i"
alias dnsflush "sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias dnsclear "sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias arp "arp -a"
alias ifconfig "ifconfig"
alias route "netstat -r"
alias networksetup "networksetup"
alias nw "networksetup"
alias nwlist "networksetup -listallnetworkservices"
alias nwhw "networksetup -listallhardwareports"
alias nwget "networksetup -getinfo"
alias nwset "sudo networksetup -setnetworkserviceenabled"
alias nwdns "networksetup -getdnsservers"
alias nwsetdns "networksetup -setdnsservers"
alias airport "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s"
alias airporti "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I"
alias airportscan "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s"
alias airportl "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --prefs"
alias wifion "networksetup -setairportpower en0 on"
alias wifioff "networksetup -setairportpower en0 off"
alias wifiname "networksetup -getairportnetwork en0"
alias sysprefs "open -a System\\ Preferences"
alias sysmem "system_profiler SPMemoryDataType"
alias sysstorage "system_profiler SPStorageDataType"
alias syspower "system_profiler SPPowerDataType"
alias sysusb "system_profiler SPUSBDataType"
alias sysbluetooth "system_profiler SPBluetoothDataType"
alias sysnet "system_profiler SPNetworkDataType"
alias sysdisplays "system_profiler SPDisplaysDataType"
alias sysprints "system_profiler SPPrintersDataType"
alias sysapps "system_profiler SPApplicationsDataType"
alias sysstartup "system_profiler SPStartupItemDataType"
alias syslogs "system_profiler SPSoftwareDataType"
alias sysfonts "system_profiler SPFontsDataType"
alias sysaudio "system_profiler SPAudioDataType"
alias syscamera "system_profiler SPCameraDataType"
alias sysbatt "system_profiler SPPowerDataType | grep -E \"Condition|Cycle|Charge|Health\""
alias lctl "launchctl"
alias lctll "launchctl list"
alias lctlload "launchctl load"
alias lctlunload "launchctl unload"
alias lctlk "launchctl kickstart"
alias lctlkick "launchctl kickstart -k"
alias lctlboot "launchctl bootstrap"
alias lctlbootout "launchctl bootout"
alias lctlenv "launchctl setenv"
alias lctlunenv "launchctl unsetenv"
alias lctlgetenv "launchctl getenv"
alias lctlstart "launchctl start"
alias lctlstop "launchctl stop"
alias lctlinst "launchctl submit"
alias lctlrm "launchctl remove"
alias lctlprint "launchctl print"
alias lctlerr "launchctl error"
alias def "defaults"
alias defr "defaults read"
alias defw "defaults write"
alias defd "defaults delete"
alias deff "defaults find"
alias deft "defaults read -g"
alias defhost "defaults -currentHost"
alias defv "defaults -domain"
alias fdsoft "ulimit -S -n"
alias fdhard "ulimit -H -n"
alias fdmax "ulimit -n 1024"
alias swv "sw_vers"
alias swvpd "sw_vers -productName"
alias swvpv "sw_vers -productVersion"
alias swvpb "sw_vers -buildVersion"
alias update "_update_sys"
alias ins "_install_pkg"
alias install "_install_pkg"
alias i "_install_pkg"
alias rem "_remove_pkg"
alias uninstall "_remove_pkg"
alias rmv "_remove_pkg"
alias se "_search_pkg"
alias search "_search_pkg"
alias findpkg "_search_pkg"
alias lsp "_list_pkgs"
alias listpkgs "_list_pkgs"
alias installed "_list_pkgs"
alias neo "neofetch"
alias fetch "fastfetch -c ~/.config/fastfetch/config.jsonc"
alias cleancache "rm -rf ~/.cache/*"
alias cleanpkg "rm -rf /var/cache/*"
alias install_deps "install_shell_support"
alias sec "secstatus"
alias hardening "secstatus"
alias pathsec "check_path_security"
alias audit "secaudit"
alias security "secaudit"
alias tips "sectips"
alias mus "cd ~/Music"
alias pic "cd ~/Pictures"
alias vid "cd ~/Videos"
alias proj "cd ~/Projects"
alias dev "cd ~/dev"
alias src "cd ~/src"
alias work "cd ~/work"
alias etc "cd /etc"
alias var "cd /var"
alias usr "cd /usr"
alias bin "cd /usr/local/bin"
alias opt "cd /opt"
alias srv "cd /srv"
alias prev "cd -"
alias quit "exit"
alias clearh "history -c"
alias clearhist "history -c && history -w"
alias hist "history"
alias hs "history | grep"
alias hsi "history | grep -i"
alias h10 "history 10"
alias h20 "history 20"
alias h50 "history 50"
alias h100 "history 100"
alias hg "history | grep"
alias hgr "history -r"
alias hw "history -w"
alias plz "sudo"
alias sud "sudo"
alias shoptl "shopt"
alias shopts "shopt -s"
alias shopton "shopt -s"
alias shoptu "shopt -u"
alias shoptoff "shopt -u"
alias setl "set -o"
alias setx "set -x"
alias setv "set -v"
alias sete "set -e"
alias setu "set -u"
alias setpipefail "set -o pipefail"
alias unsetv "unset -v"
alias unsetf "unset -f"
alias builtins "enable"
alias builtinl "enable"
alias ltr "ls -ltr"
alias lc "ls -lc"
alias lu "ls -lu"
alias lat "ls -lat"
alias latr "ls -latr"
alias lsize "ls -lS"
alias lext "ls --group-directories-first"
alias ldir "ls -d */"
alias lfile "ls -p | grep -v /"
alias lold "ls -ltr"
alias lnew "ls -lt"
alias lrec "ls -R"
alias linode "ls -i"
alias lcolor "ls --color=auto"
alias lno "ls -N"
alias lauth "'ls -lZ' 2>/dev/null || true"
alias lctx "'ls -lZ' 2>/dev/null || true"
alias jobs "jobs -l"
alias pager "less"
alias less "less -R"
alias more "less"
alias m "less"
alias gsb "git status --short --branch"
alias gai "git add -i"
alias gu "git add -u"
alias gus "git add --update"
alias gcam "git commit -a -m"
alias gcas "git commit -a --squash"
alias gcane "git commit --amend --no-edit"
alias gcom "git checkout master"
alias gcod "git checkout develop"
alias gcop "git checkout -"
alias gswm "git switch master"
alias gswd "git switch develop"
alias gswp "git switch -"
alias gph "git push origin HEAD"
alias gphu "git push -u origin HEAD"
alias gpp "git push production"
alias gps "git push staging"
alias gpt "git push --tags"
alias gpm "git merge"
alias gpff "git merge --ff-only"
alias gpnf "git merge --no-ff"
alias gls "git log --oneline --decorate --graph --all --simplify-by-decoration"
alias glp "git log -p"
alias gls2 "git log --stat"
alias glg2 "git log --graph"
alias glo "git log --oneline"
alias glol "git log --graph --oneline"
alias glola "git log --graph --oneline --all"
alias gdn "git diff --name-only"
alias gdt "git diff --stat"
alias gda "git diff HEAD"
alias gdn2 "git diff --no-index"
alias gra "git remote add"
alias grrm "git remote remove"
alias grset "git remote set-url"
alias gru "git remote update"
alias gsh "git stash"
alias gsha "git stash apply"
alias gshp "git stash pop"
alias gshl "git stash list"
alias gshs "git stash show"
alias gshsp "git stash show -p"
alias gshd "git stash drop"
alias gshc "git stash clear"
alias gshn "git stash push -m"
alias gshu "git stash -u"
alias gshk "git stash -k"
alias gbr "git branch"
alias gbra "git branch -a"
alias gbrr "git branch -r"
alias gbrd "git branch -d"
alias gbrD "git branch -D"
alias gbrm "git branch -m"
alias gbrM "git branch -M"
alias gbru "git branch -u"
alias gbrvv "git branch -vv"
alias ginit "git init"
alias gtagl "git tag -l"
alias gtagsa "git tag -a"
alias gtagsm "git tag -s"
alias gtagv "git tag -v"
alias gsho "git show"
alias gshows "git show --stat"
alias gshowp "git show -p"
alias grb "git rebase"
alias grbi "git rebase -i"
alias grbi2 "git rebase -i HEAD~"
alias grbim "git rebase -i origin/master"
alias grcp "git cherry-pick"
alias grcpa "git cherry-pick --abort"
alias grcpc "git cherry-pick --continue"
alias grcpx "git cherry-pick -x"
alias grs "git reset"
alias grsh "git reset --hard"
alias grss "git reset --soft"
alias grsm "git reset --mixed"
alias grshh "git reset HEAD~1"
alias grssh "git reset --soft HEAD~1"
alias gcln "git clean -fd"
alias gcleanx "git clean -fdx"
alias gclnx "git clean -fdx"
alias gign "git update-index --assume-unchanged"
alias gignn "git update-index --no-assume-unchanged"
alias gignl "git ls-files -v | grep \"^[a-z]\""
alias gskip "git update-index --skip-worktree"
alias gskipn "git update-index --no-skip-worktree"
alias gref "git reflog"
alias gfl "git reflog"
alias garch "git archive"
alias gbund "git bundle"
alias gdesc "git describe"
alias gdesct "git describe --tags"
alias gcfg "git config"
alias gcfgg "git config --global"
alias gcfgl "git config --local"
alias gcfgs "git config --system"
alias gcfge "git config --global --edit"
alias gwrk "git worktree"
alias gwrka "git worktree add"
alias gwrkl "git worktree list"
alias gwrkp "git worktree prune"
alias gwrkr "git worktree remove"
alias gsm "git submodule"
alias gsma "git submodule add"
alias gsmi "git submodule init"
alias gsmu "git submodule update"
alias gsmui "git submodule update --init"
alias gsmuir "git submodule update --init --recursive"
alias gsms "git submodule status"
alias gsmf "git submodule foreach"
alias gbis "git bisect"
alias gbisgood "git bisect good"
alias gbisbad "git bisect bad"
alias gbisr "git bisect reset"
alias gbissta "git bisect start"
alias glaz "lazygit 2>/dev/null || git"
alias lg "lazygit 2>/dev/null || git"
alias ghc "gh"
alias ghs "gh status"
alias ghp "gh pr"
alias ghpl "gh pr list"
alias ghpc "gh pr create"
alias ghpm "gh pr merge"
alias ghco "gh pr checkout"
alias ghi "gh issue"
alias ghil "gh issue list"
alias ghic "gh issue create"
alias ghr "gh release"
alias ghrl "gh release list"
alias ghrc "gh release create"
alias ghrd "gh release download"
alias ghrv "gh release view"
alias ghrep "gh repo"
alias ghrepv "gh repo view"
alias ghcl "gh repo clone"
alias ghcr "gh repo create"
alias ghw "gh workflow"
alias ghlab "glab"
alias dk "docker"
alias dkps "docker ps"
alias dkpsa "docker ps -a"
alias dkpsq "docker ps -q"
alias dkpsl "docker ps -l"
alias dkim "docker images"
alias dkima "docker images -a"
alias dkimq "docker images -q"
alias dkrmim "docker rmi"
alias dkex "docker exec -it"
alias dkexsh "docker exec -it /bin/sh"
alias dkexba "docker exec -it /bin/bash"
alias dkcp "docker cp"
alias dklogs "docker logs"
alias dklogsf "docker logs -f"
alias dklogst "docker logs --tail 100 -f"
alias dkrun "docker run -it --rm"
alias dkrund "docker run -d"
alias dkrunp "docker run -it --rm -p"
alias dkrunv "docker run -it --rm -v"
alias dkrnn "docker run --name"
alias dkst "docker start"
alias dkstp "docker stop"
alias dkrs "docker restart"
alias dkrm "docker rm"
alias dkrmv "docker rm -v"
alias dkbl "docker build"
alias dkblt "docker build -t"
alias dkblnc "docker build --no-cache -t"
alias dkblpus "docker buildx build --push"
alias dkpush "docker push"
alias dkpull "docker pull"
alias dkpsh "docker push"
alias dkcm "docker commit"
alias dknet "docker network"
alias dknetls "docker network ls"
alias dknetcr "docker network create"
alias dknetrm "docker network rm"
alias dknetcon "docker network connect"
alias dknetdis "docker network disconnect"
alias dknetins "docker network inspect"
alias dkvol "docker volume"
alias dkvolls "docker volume ls"
alias dkvolrm "docker volume rm"
alias dkvolpr "docker volume prune"
alias dkvolin "docker volume inspect"
alias dkvolcr "docker volume create"
alias dkstts "docker stats"
alias dktop "docker top"
alias dkpr "docker system prune"
alias dkpra "docker system prune -af"
alias dkprv "docker system prune -af --volumes"
alias dkdf "docker system df"
alias dkpsf "docker ps --format"
alias dkcom "docker compose"
alias dkup "docker compose up -d"
alias dkdown "docker compose down"
alias dklogsall "docker compose logs -f"
alias dkcomb "docker compose build"
alias dkcompr "docker compose pull"
alias dkcomres "docker compose restart"
alias dkcomstp "docker compose stop"
alias dkcomsta "docker compose start"
alias dkcomrm "docker compose rm"
alias dkconex "docker compose exec"
alias dkcomru "docker compose run --rm"
alias dkcomps "docker compose ps"
alias dkcompsa "docker compose ps -a"
alias dkcomcon "docker compose config"
alias dkcomtop "docker compose top"
alias dkcomimg "docker compose images"
alias dkpss "docker ps --format \"table {{.Names}}\\t{{.Image}}\\t{{.Status}}\""
alias dkdif "docker diff"
alias dkeve "docker events"
alias dkhis "docker history"
alias dkins "docker inspect"
alias dkport "docker port"
alias dkren "docker rename"
alias dkwai "docker wait"
alias dkexp "docker export"
alias dkimp "docker import"
alias dksav "docker save"
alias dkloa "docker load"
alias dkinf "docker info"
alias dkver "docker version"
alias dksys "docker system"
alias dkx "docker exec -it"
alias dkb "docker build"
alias dklzd "lazydocker 2>/dev/null || docker"
alias dksc "'docker scout' 2>/dev/null || true"
alias dkscout "'docker scout' 2>/dev/null || true"
alias podpsa "podman ps -a"
alias podpsq "podman ps -q"
alias podim "podman images"
alias podima "podman images -a"
alias podimq "podman images -q"
alias podrmim "podman rmi"
alias podex "podman exec -it"
alias podexsh "podman exec -it /bin/sh"
alias podexba "podman exec -it /bin/bash"
alias podlogs "podman logs"
alias podlogsf "podman logs -f"
alias podlogst "podman logs --tail 100 -f"
alias podrund "podman run -d"
alias podst "podman start"
alias podstp "podman stop"
alias podrs "podman restart"
alias podrm "podman rm"
alias podbl "podman build"
alias podblt "podman build -t"
alias podpush "podman push"
alias podpull "podman pull"
alias podpr "podman system prune -af"
alias podnet "podman network ls"
alias podvol "podman volume ls"
alias podcom "podman compose"
alias podup "podman compose up -d"
alias poddown "podman compose down"
alias podlogsall "podman compose logs -f"
alias podpss "podman ps"
alias podinfo "podman info"
alias podver "podman version"
alias podmachine "podman machine"
alias podstart "podman machine start"
alias podstop "podman machine stop"
alias podssh "podman machine ssh"
alias podins "podman inspect"
alias kg "kubectl get"
alias kgpw "kubectl get pods -w"
alias kgsv "kubectl get svc"
alias kgdep "kubectl get deployments"
alias kgns "kubectl get namespaces"
alias kgst "kubectl get statefulsets"
alias kgds "kubectl get daemonsets"
alias kgcj "kubectl get cronjobs"
alias kgj "kubectl get jobs"
alias kgi "kubectl get ingress"
alias kgcm "kubectl get configmaps"
alias kgsec "kubectl get secrets"
alias kgpv "kubectl get pv"
alias kgpvc "kubectl get pvc"
alias kgsc "kubectl get storageclass"
alias kgnetpol "kubectl get networkpolicies"
alias kgall "kubectl get all"
alias kgallns "kubectl get all --all-namespaces"
alias kd "kubectl describe"
alias kdp "kubectl describe pod"
alias kds "kubectl describe svc"
alias kdd "kubectl describe deployment"
alias kdn "kubectl describe node"
alias kdns "kubectl describe namespace"
alias kdi "kubectl describe ingress"
alias kdsec "kubectl describe secret"
alias kl "kubectl logs"
alias klf "kubectl logs -f"
alias klp "kubectl logs --previous"
alias klt "kubectl logs --tail 100"
alias kltf "kubectl logs --tail 100 -f"
alias kltl "kubectl logs --tail 500"
alias klc "kubectl logs -c"
alias klall "kubectl logs --all-containers"
alias ka "kubectl apply -f"
alias kar "kubectl apply -R -f"
alias kaf "kubectl apply -f"
alias kapp "kubectl apply -k"
alias kdelp "kubectl delete pod"
alias kdels "kubectl delete svc"
alias kdeld "kubectl delete deployment"
alias kdelf "kubectl delete -f"
alias kdelforce "kubectl delete --grace-period=0 --force"
alias kexsh "kubectl exec -it -- /bin/sh"
alias kexba "kubectl exec -it -- /bin/bash"
alias kpfs "kubectl port-forward svc/"
alias ktop "kubectl top pods"
alias ktn "kubectl top nodes"
alias ktops "kubectl top pods --sort-by=cpu"
alias ktopm "kubectl top pods --sort-by=memory"
alias ked "kubectl edit"
alias keds "kubectl edit svc"
alias kedd "kubectl edit deployment"
alias kc "kubectl create"
alias kcf "kubectl create -f"
alias kcns "kubectl create namespace"
alias kroll "kubectl rollout status"
alias krollh "kubectl rollout history"
alias krollu "kubectl rollout undo"
alias kres "kubectl rollout restart"
alias klab "kubectl label"
alias ktnt "kubectl taint"
alias kcord "kubectl cordon"
alias kuncord "kubectl uncordon"
alias kdrain "kubectl drain"
alias kapi "kubectl api-resources"
alias kapiv "kubectl api-versions"
alias kexpl "kubectl explain"
alias kuse "kubectl config use-context"
alias kctxl "kubectl config get-contexts"
alias kctxs "kubectl config set-context"
alias kview "kubectl config view"
alias knsx "kubectl config set-context --namespace"
alias kcp "kubectl cp"
alias kauth "kubectl auth can-i"
alias kauthlist "kubectl auth can-i --list"
alias kcomp "kubectl completion"
alias kcompbash "source <(kubectl completion bash)"
alias kwatch "kubectl get pods --watch"
alias kw "kubectl get pods --watch"
alias kdebug "kubectl debug"
alias kephemeral "kubectl debug -it --image=nicolaka/netshoot"
alias kpat "kubectl patch"
alias krepl "kubectl replace"
alias kwait "kubectl wait"
alias kproxy "kubectl proxy"
alias krun "kubectl run"
alias kattach "kubectl attach -it"
alias klogsall "kubectl logs -f -l"
alias kgrep "kubectl get | grep"
alias ksort "kubectl get pods --sort-by=.metadata.creationTimestamp"
alias kpodip "kubectl get pods -o wide"
alias ksvcip "kubectl get svc -o wide"
alias kjson "kubectl get -o json"
alias kyaml "kubectl get -o yaml"
alias kwide "kubectl get -o wide"
alias knsl "'kubens' 2>/dev/null || true"
alias kmink "minikube"
alias mks "minikube start"
alias mkstop "minikube stop"
alias mkst "minikube status"
alias mkpa "minikube pause"
alias mkun "minikube unpause"
alias mkdash "minikube dashboard"
alias kip "minikube ip"
alias mkadd "minikube addons list"
alias mktunnel "minikube tunnel"
alias mkservice "minikube service"
alias mkssh "minikube ssh"
alias mkscp "minikube scp"
alias mkls "minikube kubectl --"
alias kkind "kind"
alias kindc "kind create cluster"
alias kindd "kind delete cluster"
alias kindg "kind get clusters"
alias kindk "kind get kubeconfig"
alias kindl "kind load docker-image"
alias kindexp "kind export kubeconfig"
alias k0s "k0s"
alias k0start "k0s controller"
alias k0worker "k0s worker"
alias k0status "k0s status"
alias k0kubectl "k0s kubectl"
alias k0config "k0s config"
alias talos "talosctl"
alias tals "talosctl version"
alias talc "talosctl config"
alias tald "talosctl dashboard"
alias tale "talosctl etcd"
alias tali "talosctl inspect"
alias kalm "talosctl machine"
alias talu "talosctl upgrade"
alias argo "argocd"
alias argol "argocd login"
alias argos "argocd app sync"
alias argog "argocd app get"
alias argolist "argocd app list"
alias argodiff "argocd app diff"
alias argosync "argocd app sync"
alias argofresh "argocd app sync --force"
alias hls "helm list"
alias hlsa "helm list --all"
alias hlsn "helm list -n"
alias hlsall "helm list --all-namespaces"
alias hi "helm install"
alias hin "helm install --namespace"
alias hiu "helm upgrade --install"
alias hup "helm upgrade"
alias hupn "helm upgrade --namespace"
alias hdel "helm delete"
alias hdelp "helm delete --purge"
alias hroll "helm rollback"
alias hrold "helm rollback --dry-run"
alias hhis "helm history"
alias hhisn "helm history --namespace"
alias hget "helm get all"
alias hgv "helm get values"
alias hgvc "helm get values --all"
alias hgn "helm get notes"
alias hgh "helm get hooks"
alias hgm "helm get manifest"
alias hsh "helm show chart"
alias hshv "helm show values"
alias hshr "helm show readme"
alias hshc "helm show crds"
alias hshall "helm show all"
alias hrp "helm repo"
alias hrpl "helm repo list"
alias hrpa "helm repo add"
alias hrprm "helm repo remove"
alias hrpu "helm repo update"
alias hrpidx "helm repo index"
alias hsea "helm search hub"
alias hsr "helm search repo"
alias hsra "helm search repo --versions"
alias hver "helm version"
alias henv "helm env"
alias hcomp "helm completion"
alias hplug "helm plugin"
alias hplgl "helm plugin list"
alias hplgi "helm plugin install"
alias hplgrm "helm plugin remove"
alias hplgup "helm plugin update"
alias hdep "helm dependency"
alias hdepl "helm dependency list"
alias hdepb "helm dependency build"
alias hdepu "helm dependency update"
alias htmpl "helm template"
alias hlint "helm lint"
alias hpack "helm package"
alias hpush "helm push"
alias hpull "helm pull"
alias huninstall "helm uninstall"
alias hstatus "helm status"
alias htest "helm test"
alias hcreate "helm create"
alias hrep "helm repo"
alias scr "systemctl restart"
alias scrst "systemctl restart"
alias sce "systemctl enable"
alias scd "systemctl disable"
alias scen "systemctl enable --now"
alias scdn "systemctl disable --now"
alias scm "systemctl mask"
alias scum "systemctl unmask"
alias scdae "systemctl daemon-reload"
alias scl "systemctl list-units"
alias scla "systemctl list-units --all"
alias sclf "systemctl list-unit-files"
alias sclt "systemctl list-units --type="
alias scfail "systemctl list-units --failed"
alias scisa "systemctl is-active"
alias scisen "systemctl is-enabled"
alias scisf "systemctl is-failed"
alias sccat "systemctl cat"
alias sced "systemctl edit"
alias scedf "systemctl edit --full"
alias scadd "systemctl add-wants"
alias scwants "systemctl add-wants"
alias schlp "systemctl help"
alias sctim "systemd-analyze"
alias scblame "systemd-analyze blame"
alias sccrit "systemd-analyze critical-chain"
alias sccan "systemd-analyze calendar"
alias scand "systemd-analyze condition"
alias scu "systemctl --user"
alias scus "systemctl --user status"
alias scust "systemctl --user start"
alias scusp "systemctl --user stop"
alias scusr "systemctl --user restart"
alias scuse "systemctl --user enable"
alias scusd "systemctl --user disable"
alias scusl "systemctl --user list-units"
alias scusla "systemctl --user list-units --all"
alias scusf "systemctl --user list-unit-files"
alias scusdae "systemctl --user daemon-reload"
alias scusc "systemctl --user is-active"
alias scusen "systemctl --user is-enabled"
alias sctimers "systemctl list-timers"
alias sctimeru "systemctl --user list-timers"
alias sctimera "systemctl list-timers --all"
alias sciso "systemctl isolate"
alias scresc "systemctl rescue"
alias scemer "systemctl emergency"
alias scdef "systemctl default"
alias scpow "systemctl poweroff"
alias screb "systemctl reboot"
alias schib "systemctl hibernate"
alias scsus "systemctl suspend"
alias scsleep "systemctl suspend-then-hibernate"
alias scbl "systemctl list-boots"
alias scmsg "systemd-cat"
alias sckill "systemctl kill"
alias scset "systemctl set-property"
alias scshow "systemctl show"
alias scver "systemctl --version"
alias scenv "systemctl show-environment"
alias scsetenv "systemctl set-environment"
alias scunsetenv "systemctl unset-environment"
alias scimport "systemctl import-environment"
alias screvok "systemctl revert"
alias sclink "systemctl link"
alias screl "systemctl reenable"
alias scpres "systemctl preset"
alias scpresall "systemctl preset-all"
alias scaddw "systemctl add-wants"
alias scaddr "systemctl add-requires"
alias scconflicts "systemctl list-dependencies --before"
alias scdeps "systemctl list-dependencies"
alias scdepsr "systemctl list-dependencies --reverse"
alias jc "journalctl"
alias jce "journalctl -e"
alias jcf "journalctl -f"
alias jclf "journalctl -f"
alias jcu "journalctl -u"
alias jcub "journalctl -u -b"
alias jcs "journalctl --since"
alias jct "journalctl --until"
alias jcp "journalctl -p"
alias jcerr "journalctl -p err"
alias jcw "journalctl -p warning"
alias jcn "journalctl -p notice"
alias jci "journalctl -p info"
alias jcd "journalctl -p debug"
alias jcboot "journalctl -b"
alias jcb0 "journalctl -b"
alias jcb1 "journalctl -b -1"
alias jcb2 "journalctl -b -2"
alias jcb3 "journalctl -b -3"
alias jclb "journalctl --list-boots"
alias jcds "journalctl --disk-usage"
alias jcro "journalctl --rotate"
alias jcv "journalctl --verify"
alias jcemerg "journalctl -p emerg"
alias jcalert "journalctl -p alert"
alias jccrit "journalctl -p crit"
alias jcwar "journalctl -p warning"
alias jctoday "journalctl --since=today"
alias jcyesterday "journalctl --since=yesterday --until=today"
alias jcthisweek "journalctl --since=\"7 days ago\""
alias jcthismonth "journalctl --since=\"30 days ago\""
alias jck "journalctl -k"
alias jckern "journalctl -k"
alias jcdmesg "journalctl -k"
alias jcuser "journalctl --user"
alias jcus "journalctl --user -u"
alias jcusf "journalctl --user -f"
alias jcoutput "journalctl -o"
alias jcjson "journalctl -o json"
alias jcjq "journalctl -o json-pretty"
alias jcshort "journalctl -o short"
alias jcshortiso "journalctl -o short-iso"
alias jcshortprecise "journalctl -o short-precise"
alias jcshortmono "journalctl -o short-monotonic"
alias jcverbose "journalctl -o verbose"
alias jcwithunit "journalctl -o with-unit"
alias jcunix "journalctl -o unix"
alias jccat "journalctl -o cat"
alias jclines "journalctl -n"
alias jc100 "journalctl -n 100"
alias jc200 "journalctl -n 200"
alias jc500 "journalctl -n 500"
alias jc1000 "journalctl -n 1000"
alias jcnolog "journalctl --no-pager"
alias jcpg "journalctl --no-full"
alias jcm "journalctl -m"
alias jcmerge "journalctl -m"
alias jcq "journalctl -q"
alias jcquiet "journalctl -q"
alias jcvac "journalctl --vacuum-size"
alias jcvacs "journalctl --vacuum-size=100M"
alias jcvact "journalctl --vacuum-time"
alias jcvactd "journalctl --vacuum-time=1d"
alias jcvactw "journalctl --vacuum-time=1w"
alias jcvactm "journalctl --vacuum-time=1month"
alias jcfile "journalctl --file"
alias jcroot "journalctl --directory"
alias jcimage "journalctl --image"
alias jccursor "journalctl --cursor"
alias jcshowcursor "journalctl --show-cursor"
alias jcreverse "journalctl -r"
alias jcrev "journalctl -r"
alias jco "journalctl -o cat"
alias jcgrep "journalctl | grep"
alias jcident "journalctl -t"
alias jcpid "journalctl _PID="
alias jcuid "journalctl _UID="
alias jcgid "journalctl _GID="
alias jcunit "journalctl _SYSTEMD_UNIT="
alias jcsl "journalctl -x"
alias jcexplain "journalctl -x"
alias pacqt "pacman -Qo"
alias pacu "sudo pacman -Syu"
alias pacsyu "sudo pacman -Syu"
alias pacins "sudo pacman -S"
alias pacr "sudo pacman -Rns"
alias pacf "pacman -F"
alias pacfs "pacman -Fs"
alias pacmir "'sudo pacman-mirrors -f 5' 2>/dev/null || true"
alias pacmiru "'sudo pacman-mirrors -u' 2>/dev/null || true"
alias pact "'pactree' 2>/dev/null || true"
alias pactd "'pactree -d' 2>/dev/null || true"
alias pactr "'pactree -r' 2>/dev/null || true"
alias paccheck "pacman -Dk"
alias yay "yay"
alias yays "yay -Ss"
alias yayq "yay -Q"
alias yayqi "yay -Qi"
alias yayqs "yay -Qs"
alias yayql "yay -Ql"
alias yayqo "yay -Qo"
alias yayup "yay -Syu"
alias yayu "yay -Syu"
alias yayin "yay -S"
alias yayrm "yay -Rns"
alias yaycl "yay -Sc"
alias yaycc "yay -Scc"
alias yaydb "yay -Y --gendb"
alias yaydev "yay -S --devel"
alias yaynews "yay -P --news"
alias yaypg "yay -Pg"
alias yayps "yay -Ps"
alias yaypc "yay -Pc"
alias yaystats "yay -Ps"
alias yayclean "yay -Sc"
alias yayfiles "yay -Fl"
alias yayf "yay -F"
alias yayfs "yay -Fs"
alias yayorph "yay -Qtdq"
alias yaylsorph "yay -Qtd"
alias yaycleandeps "yay -Yc"
alias yaydepclean "yay -Yc"
alias paru "paru"
alias parus "paru -Ss"
alias paruq "paru -Q"
alias paruin "paru -S"
alias parurm "paru -Rns"
alias paruup "paru -Syu"
alias parudev "paru -S --devel"
alias parunews "paru -P --news"
alias paruclean "paru -Sc"
alias aur "yay 2>/dev/null || paru 2>/dev/null || echo \"No AUR helper found\""
alias aurs "yay -Ss 2>/dev/null || paru -Ss"
alias auri "yay -S 2>/dev/null || paru -S"
alias aurup "yay -Syu 2>/dev/null || paru -Syu"
alias apt "apt"
alias aptu "sudo apt update && sudo apt upgrade -y"
alias apti "sudo apt install"
alias aptrem "sudo apt remove"
alias aptpurge "sudo apt purge"
alias aptsearch "apt search"
alias aptsh "apt show"
alias aptqi "dpkg -l | grep"
alias aptqf "dpkg -L"
alias aptqfile "dpkg -S"
alias aptstats "apt-cache stats"
alias aptshowpkg "apt-cache showpkg"
alias aptshowsrc "apt-cache showsrc"
alias aptdep "apt-cache depends"
alias aptrdep "apt-cache rdepends"
alias aptauto "sudo apt autoremove"
alias aptcl "sudo apt clean"
alias aptautoclean "sudo apt autoclean"
alias aptd "sudo apt download"
alias aptdownload "sudo apt download"
alias aptsrc "sudo apt source"
alias aptsource "sudo apt source"
alias aptbuild "sudo apt build-dep"
alias aptbd "sudo apt build-dep"
alias aptb "sudo apt build-dep"
alias aptchangelog "apt changelog"
alias aptclog "apt changelog"
alias apthold "sudo apt-mark hold"
alias aptunhold "sudo apt-mark unhold"
alias aptshowhold "apt-mark showhold"
alias aptmarkauto "sudo apt-mark auto"
alias aptmarkmanual "sudo apt-mark manual"
alias aptshowauto "apt-mark showauto"
alias aptshowmanual "apt-mark showmanual"
alias aptfb "sudo apt --fix-broken install"
alias aptf "sudo apt install -f"
alias aptupdate "sudo apt update"
alias aptupd "sudo apt update"
alias aptdistup "sudo apt full-upgrade -y"
alias aptdu "sudo apt full-upgrade -y"
alias aptupg "sudo apt upgrade -y"
alias aptug "sudo apt upgrade -y"
alias aptsim "apt-get --simulate"
alias aptdry "apt-get --dry-run"
alias dselect "'sudo apt install dselect && sudo dselect' 2>/dev/null || true"
alias tasksel "'sudo tasksel' 2>/dev/null || true"
alias aptitude "'sudo aptitude' 2>/dev/null || true"
alias aptcache "apt-cache"
alias aptfile "'apt-file' 2>/dev/null || true"
alias aptfilelist "'apt-file list' 2>/dev/null || true"
alias aptfileupdate "'sudo apt-file update' 2>/dev/null || true"
alias debin "sudo dpkg -i"
alias debl "dpkg -l"
alias debc "dpkg -c"
alias debf "dpkg -L"
alias debs "dpkg -s"
alias debp "dpkg -P"
alias debr "dpkg -r"
alias debcfg "sudo dpkg-reconfigure"
alias debunpack "dpkg --unpack"
alias debconfig "dpkg --configure"
alias debstatus "dpkg --status"
alias deblist "dpkg --list"
alias debget "apt-get download"
alias snaps "snap list"
alias snapin "sudo snap install"
alias snaprm "sudo snap remove"
alias snapup "sudo snap refresh"
alias snapfind "snap find"
alias snapinfo "snap info"
alias dnf "dnf"
alias dnfsi "dnf info"
alias dnfinfo "dnf info"
alias dnfin "sudo dnf install"
alias dnfrm "sudo dnf remove"
alias dnfqi "dnf list installed | grep"
alias dnfinst "dnf list installed"
alias dnfrep "dnf repolist"
alias dnfrepall "dnf repolist --all"
alias dnfre "dnf group list"
alias dnfgrp "dnf group list"
alias dnfgrpi "sudo dnf group install"
alias dnfgrpr "sudo dnf group remove"
alias dnfgrpu "sudo dnf group upgrade"
alias dnfinstall "sudo dnf install"
alias dnfreinstall "sudo dnf reinstall"
alias dnfinstallr "sudo dnf install --nogpgcheck"
alias dnfinstallf "sudo dnf install --skip-broken"
alias dnflocal "sudo dnf localinstall"
alias dnfinstalll "sudo dnf localinstall"
alias dnfprov "dnf provides"
alias dnfwhat "dnf provides"
alias dnfmod "dnf module list"
alias dnfmodule "dnf module list"
alias dnfmodulei "sudo dnf module install"
alias dnfmmoduler "sudo dnf module remove"
alias dnfmmoduled "sudo dnf module disable"
alias dnfmmodulee "sudo dnf module enable"
alias dnfhist "dnf history"
alias dnfhisinfo "dnf history info"
alias dnfhislist "dnf history list"
alias dnfhisundo "dnf history undo"
alias dnfhisroll "dnf history rollback"
alias dnfroll "dnf history rollback"
alias dnfdowng "dnf downgrade"
alias dnfdown "dnf downgrade"
alias dnfmarkinstall "dnf mark install"
alias dnfmarkremove "dnf mark remove"
alias dnfmarkuser "dnf mark user"
alias dnfmarkgroup "dnf mark group"
alias dnfcleandb "sudo dnf clean dbcache"
alias dnfcleanexpire "sudo dnf clean expire-cache"
alias dnfcleanpackages "sudo dnf clean packages"
alias dnfmetadata "dnf clean metadata"
alias dnfmkdir "dnf makecache"
alias dnfcache "dnf makecache"
alias dnfcachef "dnf makecache fast"
alias dnfcfgm "dnf config-manager"
alias dnfenablerepo "sudo dnf config-manager --set-enabled"
alias dnfdisablerepo "sudo dnf config-manager --set-disabled"
alias dnfaddrepo "sudo dnf config-manager --add-repo"
alias rpmqrequires "rpm -q --whatrequires"
alias rpmqrecommends "rpm -q --whatrecommends"
alias rpms "rpm -K"
alias rpmquery "rpm -q"
alias yum "dnf"
alias yumi "sudo dnf install"
alias yumup "sudo dnf upgrade"
alias yumrm "sudo dnf remove"
alias yumsearch "dnf search"
alias yumclean "sudo dnf clean all"
alias brew "brew"
alias brewse "brew search"
alias brewlist "brew list"
alias brewls "brew list"
alias brewleaves "brew leaves"
alias brewgraph "brew deps --graph"
alias brewii "brew install"
alias brewremove "brew uninstall"
alias brewunin "brew uninstall"
alias brewupdate "brew update"
alias brewupgrade "brew upgrade"
alias brewupc "brew update && brew upgrade && brew cleanup"
alias brewclean "brew cleanup"
alias brewdoc "brew doctor"
alias brewd "brew doctor"
alias brewsr "brew tap"
alias brewdeptree "brew deps --tree"
alias brewdep "brew deps"
alias brewover "brew outdated"
alias brewcreate "brew create"
alias breweditor "brew edit"
alias brewhome "brew home"
alias brewserv "brew services"
alias brewsvc "brew services"
alias brewsrvl "brew services list"
alias brewsrvclean "brew services cleanup"
alias brewcasklist "brew list --cask"
alias brewcaskinfo "brew info --cask"
alias brewcaskrm "brew uninstall --cask"
alias brewcaskupgrade "brew upgrade --cask"
alias brewcaskout "brew outdated --cask"
alias brewcaskclean "brew cleanup --prune=all"
alias brewcaskdoctor "brew doctor"
alias brewbund "brew bundle"
alias brewform "brew formulae"
alias brewcasks "brew casks"
alias brewf "brew formulae"
alias brewanalytics "brew analytics"
alias brewanal "brew analytics"
alias brewoff "brew analytics off"
alias brewon "brew analytics on"
alias brewstate "brew analytics state"
alias brewcellar "brew --cellar"
alias brewrepo "brew --repository"
alias brewprefix "brew --prefix"
alias brewversion "brew --version"
alias brewenvs "brew shellenv"
alias flat "flatpak"
alias flakpak "flatpak"
alias flats "flatpak search"
alias flatsea "flatpak search"
alias flati "flatpak install"
alias flatin "flatpak install"
alias flatins "flatpak install"
alias flatrm "flatpak uninstall"
alias flatunin "flatpak uninstall"
alias flatrem "flatpak uninstall"
alias flatup "flatpak update"
alias flatupg "flatpak update"
alias flatupdate "flatpak update"
alias flatq "flatpak list"
alias flatls "flatpak list"
alias flatlist "flatpak list"
alias flatrun "flatpak run"
alias flatr "flatpak run"
alias flatinfo "flatpak info"
alias flatinf "flatpak info"
alias flatover "flatpak override"
alias flatovr "flatpak override"
alias flatovrd "flatpak override --device=all"
alias flatovrfs "flatpak override --filesystem=home"
alias flatovrall "flatpak override --socket=all --device=all --filesystem=host"
alias flatps "flatpak ps"
alias flatproc "flatpak ps"
alias flatent "flatpak enter"
alias flatkill "flatpak kill"
alias flatrepo "flatpak remotes"
alias flatremotes "flatpak remotes"
alias flatrep "flatpak remotes"
alias flatrepadd "flatpak remote-add"
alias flatreprm "flatpak remote-delete"
alias flatrepm "flatpak remote-modify"
alias flatreps "flatpak remote-ls"
alias flatmet "flatpak info -m"
alias flatfile "flatpak info --file-access"
alias flatshow "flatpak show"
alias flatsh "flatpak run --command=sh"
alias flatbash "flatpak run --command=bash"
alias flatupapp "flatpak update --appstream"
alias flatfix "flatpak repair"
alias flatunused "flatpak uninstall --unused"
alias flatcln "flatpak uninstall --unused"
alias flathistory "flatpak history"
alias flatlistapp "flatpak list --app"
alias flatlistrt "flatpak list --runtime"
alias flatinstapp "flatpak install --app"
alias flatinstrt "flatpak install --runtime"
alias flatrmapp "flatpak uninstall --app"
alias flatrmrt "flatpak uninstall --runtime"
alias flatupsys "flatpak update --system"
alias flatupuser "flatpak update --user"
alias flatuser "flatpak --user"
alias flatsys "flatpak --system"
alias flataddflathub "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
alias flataddflathubbeta "flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo"
alias nix "nix"
alias nixs "nix search"
alias nixsearch "nix search"
alias nixsh "nix shell"
alias nixi "nix profile install"
alias nixin "nix profile install"
alias nixrm "nix profile remove"
alias nixup "nix profile upgrade"
alias nixq "nix profile list"
alias nixls "nix profile list"
alias nixdev "nix develop"
alias nixbuild "nix build"
alias nixrun "nix run"
alias nixgc "nix store gc"
alias nixopt "nix store optimise"
alias nixpath "nix path-info"
alias nixlog "nix log"
alias nixdiff "nix diff"
alias nixrepl "nix repl"
alias nixedit "nix edit"
alias nixfmt "nix fmt"
alias nixpkgs "nix-env -f \"<nixpkgs>\""
alias nixenv "nix-env"
alias nixenvi "nix-env -i"
alias nixenvq "nix-env -q"
alias nixenvrm "nix-env -e"
alias nixenvup "nix-env -u"
alias nixch "nix-channel"
alias nixchls "nix-channel --list"
alias nixchup "nix-channel --update"
alias nixchadd "nix-channel --add"
alias nixchrm "nix-channel --remove"
alias nixrollback "nix-env --rollback"
alias nixswitch "nix-env --switch-profile"
alias nixgen "nix-env --list-generations"
alias nixdelgen "nix-env --delete-generations"
alias homectl "home-manager"
alias hm "home-manager"
alias hmb "home-manager build"
alias hms "home-manager switch"
alias hmg "home-manager generations"
alias hme "home-manager edit"
alias hmc "home-manager generations"
