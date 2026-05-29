#!/usr/bin/env sh
# -----------------------------------------------------------------------------
# Navigation

_x() { if command -v "${1%% *}" >/dev/null 2>&1; then "$@"; else echo "missing: $1" >&2; return 127; fi; }


alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias a='cd ..'
alias aa='cd ../..'
alias aaa='cd ../../..'
alias aaaa='cd ../../../..'
alias aaaaa='cd ../../../..'
alias home='cd ~'
alias docs='cd ~/Documents'
alias dt='cd ~/Desktop'
alias tmp='cd /tmp'
alias root='cd /'
alias bk='cd -'
alias x='exit'
alias c='clear'
alias cls='clear'
alias clr='clear'
alias tmpdir='cd $(mktemp -d)'
dash() { cd -; }
alias -- -='dash'
alias :q='exit'
alias q='exit'

# -----------------------------------------------------------------------------
# File Listing
# -----------------------------------------------------------------------------


alias lsa='ls -a'
alias lsd='ls -d */'
alias lsdot='ls -d .*'
alias lsf='ls -p | grep -v /'
alias lsbig='ls -lS | head -20'
alias lshidden='ls -d .* 2>/dev/null'
alias ltree='eza --tree --level=3 --icons=auto 2>/dev/null || find . -maxdepth 3 -print'
alias l1='ls -1'
alias lh='command ls -lhS'
alias lr='command ls -lR'
alias le="command ls | grep -o '.[^.]*$' | sort | uniq"
alias lw='command ls -ldh $(pwd)'
alias ls='_x eza --group-directories-first --icons || _x exa --group-directories-first || command ls --color=auto || command ls -G'
alias ll='_x eza -l --group-directories-first --icons || _x exa -l || command ls -l'
alias la='_x eza -la --group-directories-first --icons || _x exa -la || command ls -la'
alias lal='_x eza -la --group-directories-first --icons || _x exa -la || command ls -la'
alias lsl='_x eza -l --group-directories-first --icons || _x exa -l || command ls -l'
alias tree='_x eza -T --icons || _x tree 2>/dev/null || echo "tree/eza needed"'
alias dirs='ls -d */'
alias ldir='ls -d */'
alias lf='find . -maxdepth 1 -type f -exec command ls -lh {} + 2>/dev/null | sort -k5 -h'

# -----------------------------------------------------------------------------
# System Information — Dotfiles Management
# -----------------------------------------------------------------------------


alias dots='bash "$DOTFILES_DIR/bin/dots"'
alias dot='bash "$DOTFILES_DIR/bin/dots"'
alias dotdoctor='bash "$DOTFILES_DIR/bin/dots" doctor'
alias dotupdate='bash "$DOTFILES_DIR/bin/dots" update'
alias dotrollback='bash "$DOTFILES_DIR/bin/dots" rollback'
alias dotstatus='bash "$DOTFILES_DIR/bin/dots" status'
alias dotprofile='bash "$DOTFILES_DIR/bin/dots" profile'
alias dotreload='bash "$DOTFILES_DIR/bin/dots" reload'
alias dotlogs='bash "$DOTFILES_DIR/bin/dots" logs'
alias dotfix='bash "$DOTFILES_DIR/bin/dots" install'
alias dotdocs='bash "$DOTFILES_DIR/bin/dots" docs'
alias dotbench='bash "$DOTFILES_DIR/bin/dots" benchmark'
alias dotsafe='bash "$DOTFILES_DIR/bin/dots" safe'
alias dotst='git -C "$DOTFILES_DIR" status --short --branch'
alias edots='$EDITOR "$DOTFILES_DIR"'
alias dotbranch='git -C "$DOTFILES_DIR" branch'
alias dotdiff='git -C "$DOTFILES_DIR" diff'
alias dotfetch='git -C "$DOTFILES_DIR" fetch --all --prune'
alias dotlog='git -C "$DOTFILES_DIR" log --oneline --graph --decorate -20'
alias dotpush='git -C "$DOTFILES_DIR" push'
alias dotver='echo "$DOTFILES_VERSION"'

# -----------------------------------------------------------------------------
# Git Operations
# -----------------------------------------------------------------------------


alias gap='git add -p'
alias gcm='git commit -m'
alias gcan='git commit --amend --no-edit'
alias gpl='git pull --rebase --autostash'
alias gsw='git switch'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'
alias gpr='git pull --rebase'
alias prune='git remote prune origin'
alias shipit='git status --short && git push'
alias glg='git log --oneline --decorate --graph'
alias gla='git log --oneline --decorate --graph --all'
alias gcount='git shortlog -sn'
alias gbl='git blame -w'
alias gcl='git clone'
alias gdf='git diff --name-only'
alias gdw='git diff --word-diff'
alias gdc='git diff --cached'
alias gpsup='git push --set-upstream origin HEAD'
alias grv='git remote -v'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gswc='git switch -c'
alias gcp='git cherry-pick'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gff='git merge --ff-only'
alias gwp='git worktree prune'
alias grepo='git init'
alias gtags='git tag -l'
alias gshow='git show'
alias gwip='git add -A && git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify -m "wip"'
alias gwipe='git reset --hard && git clean --force -df'
alias nah='git reset --hard && git clean -df'
gbage() { for k in $(git branch -a | sed 's/^..//;s/ ->.*//' 2>/dev/null); do echo -e "$(git show --pretty=format:"%ci %cr" "$k" -- 2>/dev/null | head -1)\t$k"; done | sort -r; }
alias gmn='git merge --no-ff --no-commit'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gau='git add -u'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbm='git branch -m'
alias gbc='git branch --show-current'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcam='git commit --amend --no-edit'
alias gcne='git commit --no-edit'
alias gcnv='git commit --no-verify'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --stat'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gfr='git fetch --prune'
alias gi='git init'
alias gl='git log --oneline -n 20'
alias gp='git push'
alias gpo='git push origin'
alias gpoh='git push origin HEAD'
alias gpu='git push --set-upstream origin'
alias gplr='git pull --rebase'
alias gr='git remote -v'
alias gra='git remote add'
alias grm='git remote remove'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gt='git tag'
alias gtl='git tag -l'
alias gtd='git tag -d'
alias gtop='gcd'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gm='git merge'
alias gmnf='git merge --no-ff'
alias gmt='git mergetool'
alias gmv='git mv'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gcl1='git clone --depth=1'
alias gcf='git config'
alias gcfl='git config -l'
alias gk='gitk'
alias gkw='gitk --all'
alias gsh='git show'
alias gshs='git show --stat'
alias gshn='git show --name-only'


# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------


if command -v gh >/dev/null 2>&1; then
    alias ghs='gh status'
    alias ghp='gh pr'
    alias ghpl='gh pr list'
    alias ghpc='gh pr create'
    alias ghpm='gh pr merge'
    alias ghco='gh pr checkout'
    alias ghi='gh issue'
    alias ghil='gh issue list'
    alias ghic='gh issue create'
    alias ghr='gh release'
    alias ghrl='gh release list'
    alias ghrc='gh release create'
    alias ghrd='gh release download'
    alias ghrv='gh release view'
    alias ghrep='gh repo'
    alias ghrepv='gh repo view'
    alias ghcl='gh repo clone'
    alias ghcr='gh repo create'
    alias ghw='gh workflow'
fi

# -----------------------------------------------------------------------------
# Docker Management
# -----------------------------------------------------------------------------


if command -v docker >/dev/null 2>&1; then
    alias dk='_x docker'
    alias dkps='_x docker ps'
    alias dkpsa='_x docker ps -a'
    alias dkim='_x docker images'
    alias dkex='_x docker exec -it'
    alias dklogs='_x docker logs -f'
    alias dklogst='_x docker logs --tail 100 -f'
    alias dkstop='_x docker stop $(docker ps -q)'
    alias dkrm='_x docker rm $(docker ps -aq)'
    alias dkrmi='_x docker rmi $(docker images -q)'
    alias dkprune='_x docker system prune -af'
    alias dkclean='_x docker system prune -af --volumes'
    alias dkbuild='_x docker build -t'
    alias dkrun='_x docker run -it --rm'
    alias dkrunbg='_x docker run -d'
    alias dkexec='_x docker exec -it'
    alias dkstart='_x docker start'
    alias dkrestart='_x docker restart'
    alias dkpause='_x docker pause'
    alias dkunpause='_x docker unpause'
    alias dktop='_x docker top'
    alias dkstats='_x docker stats'
    alias dkcp='_x docker cp'
    alias dkport='_x docker port'
    alias dkcom='_x docker compose'
    alias dkup='_x docker compose up -d'
    alias dkdown='_x docker compose down'
    alias dkpsall='_x docker compose ps'
    alias dklogsall='_x docker compose logs -f'
    alias dknet='_x docker network ls'
    alias dkvol='_x docker volume ls'
    alias dksys='_x docker system df'
    alias docker-ip="_x docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 2>/dev/null"
    alias dstats='_x docker stats --no-stream'
fi

if command -v lazydocker >/dev/null 2>&1; then
    alias lzd='lazydocker'
fi

# -----------------------------------------------------------------------------
# Container Image Tools
# -----------------------------------------------------------------------------


if command -v skopeo >/dev/null 2>&1; then
    alias sk='skopeo'
    alias skc='skopeo copy'
    alias skl='skopeo list-tags'
    alias ski='skopeo inspect'
    alias sks='skopeo sync'
fi


if command -v hadolint >/dev/null 2>&1; then
    alias hado='hadolint'
fi

if command -v trivy >/dev/null 2>&1; then
    alias trivyi='trivy image'
    alias trivyf='trivy fs'
    alias trivyr='trivy repo'
fi

if command -v cosign >/dev/null 2>&1; then
    alias cosignv='cosign verify'
    alias cosigns='cosign sign'
fi

# -----------------------------------------------------------------------------
# Podman Management
# -----------------------------------------------------------------------------


if command -v podman >/dev/null 2>&1; then
    alias pod='_x podman'
    alias podps='_x podman ps'
    alias podpsa='_x podman ps -a'
    alias podim='_x podman images'
    alias podex='_x podman exec -it'
    alias podlogs='_x podman logs -f'
    alias podstop='_x podman stop $(podman ps -q)'
    alias podrm='_x podman rm $(podman ps -aq)'
    alias podprune='_x podman system prune -af'
    alias podbuild='_x podman build -t'
    alias podrun='_x podman run -it --rm'
    alias podcom='_x podman compose'
    alias podup='_x podman compose up -d'
    alias poddown='_x podman compose down'
fi

# -----------------------------------------------------------------------------
# Kubernetes Operations
# -----------------------------------------------------------------------------


if command -v kubectl >/dev/null 2>&1; then
    alias kgpw='_x kubectl get pods -w'
    alias kgns='_x kubectl get namespaces'
    alias kuse='_x kubectl config use-context'
    alias kd='_x kubectl describe'
    alias kdp='_x kubectl describe pod'
    alias kds='_x kubectl describe svc'
    alias kdd='_x kubectl describe deployment'
    alias kl='_x kubectl logs'
    alias klf='_x kubectl logs -f'
    alias ka='_x kubectl apply -f'
    alias kpf='_x kubectl port-forward'
    alias kexec='_x kubectl exec -it'
    alias ktop='_x kubectl top pods'
    alias ktopn='_x kubectl top nodes'
    alias kedit='_x kubectl edit'
    alias kc='_x kubectl create'
    alias kcf='_x kubectl create -f'
    alias kroll='_x kubectl rollout status'
    alias krestart='_x kubectl rollout restart'
    alias klabel='_x kubectl label'
    alias ktaint='_x kubectl taint'
    alias kcord='_x kubectl cordon'
    alias kuncord='_x kubectl uncordon'
    alias kdrain='_x kubectl drain'
    alias kapi='_x kubectl api-resources'
    alias kexplain='_x kubectl explain'
    alias kns='_x kubectl config set-context --namespace'
fi

if command -v kind >/dev/null 2>&1; then
    alias kindc='kind create cluster'
    alias kindd='kind delete cluster'
    alias kindg='kind get clusters'
    alias kindk='kind get kubeconfig'
fi

if command -v minikube >/dev/null 2>&1; then
    alias mk='minikube'
    alias mks='minikube start'
    alias mkstop='minikube stop'
    alias mkd='minikube delete'
    alias mkst='minikube status'
    alias mkpa='minikube pause'
    alias mkun='minikube unpause'
    alias mkdash='minikube dashboard'
    alias kip='minikube ip'
    alias mkadd='minikube addons list'
fi

if command -v k0s >/dev/null 2>&1; then
    alias k0='k0s'
    alias k0s='k0s status'
    alias k0c='k0s kubectl'
    alias k0start='k0s controller'
fi

if command -v talosctl >/dev/null 2>&1; then
    alias tals='talosctl version'
    alias talc='talosctl config'
fi

if command -v argocd >/dev/null 2>&1; then
    alias argo='argocd'
    alias argol='argocd login'
    alias argos='argocd app sync'
    alias argog='argocd app get'
    alias argolist='argocd app list'
    alias argodiff='argocd app diff'
fi

# -----------------------------------------------------------------------------
# Helm Operations
# -----------------------------------------------------------------------------


if command -v helm >/dev/null 2>&1; then
    alias hl='_x helm'
    alias hls='_x helm list'
    alias hli='_x helm install'
    alias hlu='_x helm upgrade'
    alias hlui='_x helm upgrade --install'
    alias hld='_x helm delete'
    alias hlr='_x helm rollback'
    alias hlg='_x helm get'
    alias hlga='_x helm get all'
    alias hlgs='_x helm get values'
    alias hlh='_x helm history'
    alias hlsh='_x helm show'
    alias hlshc='_x helm show chart'
    alias hlshv='_x helm show values'
    alias hlrepo='_x helm repo'
    alias hlrl='_x helm repo list'
    alias hlra='_x helm repo add'
    alias hlru='_x helm repo update'
    alias hlsea='_x helm search'
    alias hlver='_x helm version'
    alias hlcomp='_x helm completion'
    alias hlplug='_x helm plugin'
    alias hlpl='_x helm plugin list'
fi

# -----------------------------------------------------------------------------
# Systemd Service Management
# -----------------------------------------------------------------------------


if command -v systemctl >/dev/null 2>&1; then
    alias scsr='_x systemctl restart'
    alias scse='_x systemctl enable'
    alias scsd='_x systemctl disable'
    alias scn='_x systemctl daemon-reload'
    alias scens='_x systemctl enable --now'
    alias scdis='_x systemctl disable --now'
    alias scu='_x systemctl --user'
    alias scus='_x systemctl --user status'
    alias scust='_x systemctl --user start'
    alias scusp='_x systemctl --user stop'
    alias scusr='_x systemctl --user restart'
    alias scuse='_x systemctl --user enable'
    alias scusd='_x systemctl --user disable'
    alias scl='_x systemctl list-units'
    alias scla='_x systemctl list-units --all'
    alias scfail='_x systemctl list-units --failed'
    alias scmask='_x systemctl mask'
    alias scunmask='_x systemctl unmask'
    alias sccat='_x systemctl cat'
    alias sclist='_x systemctl list-unit-files'
    alias scon='_x systemctl is-active'
    alias serv='_x systemctl'
fi

# -----------------------------------------------------------------------------
# Journalctl — System Log Inspection
# -----------------------------------------------------------------------------


if command -v journalctl >/dev/null 2>&1; then
    alias jc='_x journalctl'
    alias jce='_x journalctl -e'
    alias jcf='_x journalctl -f'
    alias jcu='_x journalctl -u'
    alias jcub='_x journalctl -u -b'
    alias jcs='_x journalctl --since'
    alias jct='_x journalctl --until'
    alias jcp='_x journalctl -p err'
    alias jcdf='_x journalctl --disk-usage'
    alias jcro='_x journalctl --rotate'
    alias jcv='_x journalctl --verify'
    alias jcemerg='_x journalctl -p emerg'
    alias jcalert='_x journalctl -p alert'
    alias jccrit='_x journalctl -p crit'
    alias jcwarn='_x journalctl -p warning'
    alias jcnotice='_x journalctl -p notice'
    alias jcinfo='_x journalctl -p info'
    alias jcdebug='_x journalctl -p debug'
    alias jcboot='_x journalctl -b'
    alias jrnl='_x journalctl'
fi

# -----------------------------------------------------------------------------
# Package Managers — pacman / yay
# -----------------------------------------------------------------------------


if command -v pacman >/dev/null 2>&1; then
    alias pac='sudo pacman'
    alias pacs='_x pacman -Ss'
    alias pacsi='_x pacman -Si'
    alias pacq='_x pacman -Q'
    alias pacqi='_x pacman -Qi'
    alias pacql='_x pacman -Ql'
    alias pacqo='_x pacman -Qo'
    alias pacqs='_x pacman -Qs'
    alias pacup='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacrm='sudo pacman -Rns'
    alias pacrmu='sudo pacman -Rdd'
    alias pacor='sudo pacman -Sc'
    alias pacowned='_x pacman -Qii'
    alias pacorph='_x pacman -Qtdq'
    alias pacclean='sudo pacman -Rns $(pacman -Qtdq 2>/dev/null)'
    alias paclsorph='_x pacman -Qtd'
    alias pacfiles='_x pacman -Fl'
    alias pacdep='_x pacman -Si'
    alias pacwhy='_x pacman -D --asexplicit'
    alias fixpacman='sudo rm -f /var/lib/pacman/db.lck'
fi

if command -v yay >/dev/null 2>&1; then
    alias yays='yay -Ss'
    alias yayq='yay -Q'
    alias yayup='yay -Syu'
    alias yayi='yay -S'
    alias yayrm='yay -Rns'
    alias yayclean='yay -Sc'
    alias yaygendb='yay -Y --gendb'
    alias yaydev='yay -S --devel'
    alias yayfiles='yay -Fl'
fi

if command -v yay >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
    alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
fi

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------


if command -v apt >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then
    alias apt='_x apt'
    alias aptup='sudo apt update && sudo apt upgrade -y'
    alias aptin='sudo apt install'
    alias aptr='sudo apt remove'
    alias aptp='sudo apt purge'
    alias apts='_x apt search'
    alias aptsh='_x apt show'
    alias aptq='dpkg -l'
    alias aptqi='dpkg -l | grep'
    alias aptau='sudo apt autoremove'
    alias aptd='sudo apt download'
    alias aptsrc='sudo apt source'
    alias aptbuild='sudo apt build-dep'
    alias aptpolicy='_x apt policy'
    alias aptchangelog='_x apt changelog'
    alias aptlistup='_x apt list --upgradable'
    alias aptlistins='_x apt list --installed'
    alias apthold='sudo apt-mark hold'
    alias aptunhold='sudo apt-mark unhold'
    alias aptshowhold='apt-mark showhold'
    alias aptfix='sudo apt --fix-broken install'
    alias aptupdate='sudo apt update'
    alias aptdistup='sudo apt full-upgrade'
fi

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------


if command -v dnf >/dev/null 2>&1; then
    alias dnf='_x dnf'
    alias dnfs='_x dnf search'
    alias dnfsi='_x dnf info'
    alias dnfup='sudo dnf upgrade'
    alias dnfi='sudo dnf install'
    alias dnfrm='sudo dnf remove'
    alias dnfau='sudo dnf autoremove'
    alias dnfq='_x dnf list installed'
    alias dnfqi='_x dnf list installed | grep'
    alias dnfrep='_x dnf repolist'
    alias dnfre='_x dnf group list'
    alias dnfcache='sudo dnf clean all'
    alias dnfhist='_x dnf history'
    alias dnfhistinfo='_x dnf history info'
    alias dnfroll='_x dnf history rollback'
    alias dnfdowng='_x dnf downgrade'
    alias dnflocal='sudo dnf localinstall'
    alias dnfprov='_x dnf provides'
    alias dnfchk='_x dnf check-update'
    alias dnfmod='_x dnf module'
fi

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------


if command -v brew >/dev/null 2>&1; then
    alias brew='_x brew'
    alias brews='_x brew search'
    alias brewin='_x brew install'
    alias brewrm='_x brew uninstall'
    alias brewq='_x brew list'
    alias brewsrv='_x brew services'
    alias brewsrvl='_x brew services list'
    alias brewsrvr='_x brew services restart'
    alias brewup='_x brew update && brew upgrade'
    alias brewupc='_x brew update && brew upgrade && brew cleanup'
    alias brewclean='_x brew cleanup'
    alias brewdoc='_x brew doctor'
    alias brewout='_x brew outdated'
    alias brewpin='_x brew pin'
    alias brewsr='_x brew tap'
    alias brewinfo='_x brew info'
    alias brewcask='_x brew install --cask'
    alias brewdep='_x brew deps'
    alias brewuses='_x brew uses'
    alias brewleaves='_x brew leaves'
fi

# -----------------------------------------------------------------------------
# Package Managers — Flatpak / Snap / Nix / Zypper / APK
# -----------------------------------------------------------------------------


if command -v flatpak >/dev/null 2>&1; then
    alias flat='flatpak'
    alias flats='flatpak search'
    alias flati='flatpak install'
    alias flatrm='flatpak uninstall'
    alias flatup='flatpak update'
    alias flatq='flatpak list'
    alias flatrun='flatpak run'
    alias flatinfo='flatpak info'
    alias flatover='flatpak override'
fi

if command -v snap >/dev/null 2>&1; then
    alias snaps='snap search'
    alias snapi='sudo snap install'
    alias snaprm='sudo snap remove'
    alias snapup='sudo snap refresh'
    alias snapq='snap list'
    alias snapinfo='snap info'
    alias snapch='sudo snap changes'
fi

if command -v nix >/dev/null 2>&1; then
    alias nixs='nix search'
    alias nixsh='nix shell'
    alias nixi='nix profile install'
    alias nixrm='nix profile remove'
    alias nixup='nix profile upgrade'
    alias nixq='nix profile list'
    alias nixdev='nix develop'
    alias nixbuild='nix build'
    alias nixrun='nix run'
    alias nixgc='nix store gc'
    alias nixopt='nix store optimise'
fi

if command -v zypper >/dev/null 2>&1; then
    alias zyp='sudo zypper'
    alias zyps='zypper search'
    alias zypi='sudo zypper install'
    alias zypr='sudo zypper remove'
    alias zypup='sudo zypper update'
    alias zypdup='sudo zypper dist-upgrade'
    alias zypl='zypper list-installed'
    alias zypclean='sudo zypper clean'
    alias zyplr='zypper lr'
    alias zypprov='zypper what-provides'
fi

if command -v apk >/dev/null 2>&1; then
    alias apks='apk search'
    alias apki='apk add'
    alias apkrm='apk del'
    alias apkup='apk update && apk upgrade'
    alias apkq='apk list'
    alias apkqi='apk list -I'
    alias apkinfo='apk info'
    alias apkclean='apk cache clean'
fi

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------


if command -v node >/dev/null 2>&1; then
    alias nt='_x npm test'
    alias nb='_x npm run build'
    alias nrn='_x npm run --'
    alias np='_x npm publish'
    alias nup='_x npm update'
    alias nout='_x npm outdated'
    alias nls='_x npm list'
    alias ndoc='_x npm docs'
    alias ninit='_x npm init -y'
    alias nstar='_x npm star'
    alias nuni='_x npm uninstall'
    alias nlex='_x npm exec'
    alias nwhy='_x npm why'
    alias naud='_x npm audit'
    alias naux='_x npm audit fix'
fi


if command -v pnpm >/dev/null 2>&1; then
    alias pn='_x pnpm'
    alias pni='_x pnpm install'
    alias pnr='_x pnpm run'
    alias pnd='_x pnpm run dev'
    alias pnb='_x pnpm run build'
    alias pnt='_x pnpm test'
    alias pna='_x pnpm add'
    alias pnad='_x pnpm add -D'
    alias pnrm='_x pnpm remove'
    alias pnup='_x pnpm update'
    alias pnout='_x pnpm outdated'
    alias pnls='_x pnpm list'
    alias pninit='_x pnpm init'
    alias pnpub='_x pnpm publish'
    alias pnlint='_x pnpm lint'
    alias pnex='_x pnpm exec'
    alias pnlc='_x pnpm lint:check'
    alias pnstore='_x pnpm store'
fi

if command -v yarn >/dev/null 2>&1; then
    alias y='yarn'
    alias ya='yarn add'
    alias yad='yarn add -D'
    alias yr='yarn run'
    alias yb='yarn build'
    alias yd='yarn dev'
    alias yt='yarn test'
    alias yrm='yarn remove'
    alias yls='yarn list'
    alias yinit='yarn init'
    alias ypub='yarn publish'
    alias ylint='yarn lint'
    alias ygl='yarn global list'
    alias yga='yarn global add'
fi

# -----------------------------------------------------------------------------
# Rust / Cargo Development
# -----------------------------------------------------------------------------


if command -v cargo >/dev/null 2>&1; then
    alias cr='_x cargo'
    alias crb='_x cargo build'
    alias crbr='_x cargo build --release'
    alias crr='_x cargo run'
    alias crrr='_x cargo run --release'
    alias crt='_x cargo test'
    alias crcl='_x cargo clippy'
    alias crf='_x cargo fmt'
    alias crc='_x cargo check'
    alias crd='_x cargo doc'
    alias crp='_x cargo publish'
    alias cru='_x cargo update'
    alias crout='_x cargo outdated'
    alias crclean='_x cargo clean'
    alias crbench='_x cargo bench'
    alias crfix='_x cargo fix'
    alias crl='_x cargo +nightly'
    alias crw='_x cargo watch'
    alias cradd='_x cargo add'
    alias crrm='_x cargo remove'
fi

# -----------------------------------------------------------------------------
# Go Development
# -----------------------------------------------------------------------------


if command -v go >/dev/null 2>&1; then
    alias go='_x go'
    alias gor='_x go run'
    alias gob='_x go build'
    alias got='_x go test'
    alias gotv='_x go test -v ./...'
    alias goi='_x go install'
    alias gom='_x go mod'
    alias gomt='_x go mod tidy'
    alias gomv='_x go mod vendor'
    alias gog='_x go get'
    alias gof='_x go fmt ./...'
    alias gol='_x go vet ./...'
    alias godoc='_x go doc'
    alias gogen='_x go generate ./...'
    alias goc='_x go clean'
    alias gocache='_x go clean -cache'
    alias goenv='_x go env'
    alias gop='_x go tool pprof'
fi

# -----------------------------------------------------------------------------
# Python Development
# -----------------------------------------------------------------------------


if command -v python3 >/dev/null 2>&1; then
    alias py='_x python3'
    alias py2='python2 2>/dev/null || python3'
    alias py3='_x python3'
    alias pipup='_x python3 -m pip install --upgrade pip'
    alias venv='_x python3 -m venv .venv'
    alias akt='source .venv/bin/activate'
    alias dakt='deactivate'
    alias pyreq='_x pip freeze > requirements.txt'
    alias pyr='_x python3 -m pip install -r requirements.txt'
    alias pyi='_x python3 -i'
    alias pym='_x python3 -m'
    alias pyt='_x python3 -m pytest'
    alias pyun='_x python3 -m unittest'
fi

if command -v pip >/dev/null 2>&1 || command -v pip3 >/dev/null 2>&1; then
    alias pip='pip3 2>/dev/null || pip'
    alias pi='_x pip install'
    alias piu='_x pip install --upgrade'
    alias pir='_x pip install -r requirements.txt'
    alias pls='_x pip list'
    alias pout='_x pip list --outdated'
    alias psh='_x pip show'
    alias pch='_x pip check'
    alias pdown='_x pip download'
    alias phash='_x pip hash'
fi

alias json='python3 -m json.tool 2>/dev/null || echo "python3 needed"'
alias xml='_x xmllint --format - 2>/dev/null || echo "xmllint needed"'
alias yaml='_x python3 -c "import sys,yaml; yaml.dump(yaml.safe_load(sys.stdin), sys.stdout, default_flow_style=False)" 2>/dev/null || echo "python3+yaml needed"'
alias csv='_x python3 -c "import sys,csv; r=csv.reader(sys.stdin); [print(l) for l in r]" 2>/dev/null || column -t -s, 2>/dev/null'
alias ts='_x python3 -c "import sys,json; [print(json.dumps(eval(l))) for l in sys.stdin]" 2>/dev/null'
alias math='_x python3 -c'
alias rstring='_x python3 -c "import secrets; print(secrets.token_hex())"'

# -----------------------------------------------------------------------------
# SSH Operations
# -----------------------------------------------------------------------------


if command -v ssh >/dev/null 2>&1; then
    alias ssh='_x ssh'
    alias ssha='_x ssh -A'
    alias sshi='_x ssh -o StrictHostKeyChecking=no'
    alias ssk='ssh-keygen'
    alias sskr='ssh-keygen -R'
    alias ssc='ssh-copy-id'
fi

# -----------------------------------------------------------------------------
# GPG Operations
# -----------------------------------------------------------------------------


if command -v gpg >/dev/null 2>&1; then
    alias gpg='_x gpg'
    alias gpge='_x gpg -e'
    alias gpgd='_x gpg -d'
    alias gpgs='_x gpg -s'
    alias gpgv='_x gpg --verify'
    alias gpgl='_x gpg --list-keys'
    alias gpgls='_x gpg --list-secret-keys'
    alias gpgk='_x gpg --list-keys'
    alias gpgex='_x gpg --export'
    alias gpgimport='_x gpg --import'
    alias gpgrecv='_x gpg --recv-keys'
    alias gpgens='_x gpg --gen-key'
fi

# -----------------------------------------------------------------------------
# Network Tools
# -----------------------------------------------------------------------------


myipl() { ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1; }
alias weather='curl -fsSL wttr.in'
alias portlisten='ss -tlnp 2>/dev/null || netstat -tlnp'
alias pingf='ping -c 100 -s 1472 -f'
alias pb='ping -c 4 8.8.8.8'
alias net='ip -br addr'
alias ipl='ip -br link'
alias ipa='ip -br addr'
alias ipr='ip route'
alias nst='netstat -tulanp 2>/dev/null || ss -tulanp'
alias trace='traceroute'


alias ip='ip -br addr'
alias myip='_x dig +short myip.opendns.com @resolver1.opendns.com || _x curl -s ifconfig.me 2>/dev/null || echo "N/A"'

alias dns='_x dig +short'
alias flush='_x sudo resolvectl flush-caches || _x sudo systemd-resolve --flush-caches || _x sudo killall -HUP mDNSResponder 2>/dev/null || echo "no flush"'
alias speed='_x curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | _x python3 - 2>/dev/null || echo "speedtest-cli needed"'

alias weather3='_x curl -fsSL "wttr.in?F" 2>/dev/null || echo "curl needed"'
alias moon='_x curl -fsSL "wttr.in/Moon" 2>/dev/null || echo "curl needed"'
alias dnst='dig +short'
alias iftop='sudo iftop'
alias ping='_x prettyping || command ping'
alias dig='_x dog || command dig'

if command -v dig >/dev/null 2>&1; then
    alias dns='dig +short'
    alias dnsx='dig ANY +short'
    alias dnsmx='dig MX +short'
    alias dnsns='dig NS +short'
    alias dnstxt='dig TXT +short'
    alias dnsany='dig ANY'
fi

if command -v nmap >/dev/null 2>&1; then
    alias nm='nmap'
    alias nms='nmap -sn'
    alias nmp='nmap -sV -sC'
    alias nmo='nmap -O'
fi

if command -v curl >/dev/null 2>&1; then
    alias cur='curl -fsSL'
    alias curh='curl -I'
    alias curv='curl -v'
    alias curj='curl -s | jq .'
    alias curd='curl -X DELETE'
    alias curp='curl -X POST'
    alias curu='curl -X PUT'
fi

if command -v wget >/dev/null 2>&1; then
    alias wg='wget -c'
    alias wgr='wget -r -np -nH'
fi

# -----------------------------------------------------------------------------
# Process Management
# -----------------------------------------------------------------------------


alias ps='ps auxf'
alias pse='ps aux | grep'
alias pst='_x pstree'
alias psea='ps -e'
alias kill9='kill -9'
alias kill15='kill -15'
alias pkillf='_x pkill -f'
alias pid='_x pgrep -f'
alias nice='nice -n'
alias renice='renice -n'
alias topcpu='ps aux --sort=-%cpu | head 2>/dev/null || ps aux -r | head'
alias topmem='ps aux --sort=-%mem | head 2>/dev/null || ps aux -m | head'
alias iotop='iotop -o 2>/dev/null || echo "iotop not found"'
alias pscpu='ps aux --sort=-%cpu'
alias psmem='ps aux --sort=-%mem'
alias psuser='ps -u'
alias psi='ps aux | grep -i'
alias psaux='ps aux'
alias psf='ps auxf'
alias psxl='ps aux --forest'
alias psymod='lsmod'
alias top='_x btop || _x htop || command top'

# -----------------------------------------------------------------------------
# Text Processing
# -----------------------------------------------------------------------------


alias gri='command grep -i'
alias grr='command grep -r'
alias grri='command grep -ri'
alias grl='command grep -rl'
alias grc='command grep -c'
alias uniqc='sort | uniq -c | sort -rn'
alias wcw='wc -w'
alias column='column -t'
alias diffy='diff -y'
alias tair='tail -f'
alias taill='tail -100'
alias headl='head -100'
alias nl='nl -ba'
alias tac='tac 2>/dev/null || tail -r'
alias grepw='command grep -w'
alias grepr='command grep -r'
alias grex='command grep -r --exclude-dir=.git --exclude-dir=node_modules'
alias grep='_x rg --color=auto || command grep --color=auto'
alias diff='_x delta || command diff --color=auto || command diff'

if command -v rg >/dev/null 2>&1; then
    alias rg='rg --hidden --glob "!.git"'
    alias rgi='rg -i --hidden --glob "!.git"'
    alias rgf='rg --files'
    alias rgl='rg --files-with-matches'
    alias rgc='rg --count'
fi


# -----------------------------------------------------------------------------
# File Operations
# -----------------------------------------------------------------------------


alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmr='rm -r'
alias rmf='rm -f'
alias cpf='cp -f'
alias mvfs='mv -f'
alias cpv='_x rsync -ah --progress'
alias mkd='mkdir -p'
alias rsync='_x rsync -avz --progress'
alias rsyncdn='_x rsync -avz --dry-run --progress'
alias chx='chmod +x'
alias chm='chmod'
alias ln='ln -s'
alias lnh='readlink -f'
# defined as function in core/functions.sh (backup_file)
alias mount='mount | column -t'


alias mkdir='mkdir -p'
alias bc='bc -l'
alias find='_x fd || command find'
alias cat='command cat'
alias fd='_x fd 2>/dev/null || find'
alias ff='find . -type f -name'

alias wget='_x wget || _x curl -fSL -o 2>/dev/null || echo "no download tool"'

if command -v fd >/dev/null 2>&1; then
    alias fd='fd --hidden'
    alias fdi='fd -i'
fi

if command -v shred >/dev/null 2>&1; then
    alias shred='shred -uz'
    alias shredf='shred -uz -n 7'
fi

if command -v lsof >/dev/null 2>&1; then
    alias lsofi='lsof -i'
    alias lsofp='lsof -P'
    alias lsofn='lsof -nP'
fi

alias lsof='_x lsof -i -P -n 2>/dev/null || echo "lsof needed"'

# -----------------------------------------------------------------------------
# Archive Operations
# -----------------------------------------------------------------------------


alias tart='tar -tzf'
alias tarjx='tar -xjf'
alias tarjc='tar -cjf'
alias tarzx='tar -xJf'
alias tarzc='tar -cJf'
alias tarl='tar -tvf'
alias gunz='gunzip'
alias bz2='bzip2'
alias bunz='bunzip2'
alias 7z='7z'
alias 7zx='7z x'
alias 7za='7z a'
alias rarx='unrar x'

if command -v ouch >/dev/null 2>&1; then
    alias ouchd='ouch decompress'
    alias ouchc='ouch compress'
    alias ouchl='ouch list'
fi

# -----------------------------------------------------------------------------
# Database Operations
# -----------------------------------------------------------------------------


if command -v mysql >/dev/null 2>&1; then
    alias myq='mysql'
    alias myqr='mysql -u root -p'
    alias mydump='mysqldump'
    alias mydumpr='mysqldump -u root -p'
fi

if command -v psql >/dev/null 2>&1; then
    alias psqlr='psql -U postgres'
    alias pgdump='pg_dump'
    alias pgres='pg_restore'
fi

if command -v sqlite3 >/dev/null 2>&1; then
    alias sq3='sqlite3'
    alias sq3d='sqlite3 .dump'
fi

if command -v redis-cli >/dev/null 2>&1; then
    alias rcli='redis-cli'
    alias rcliping='redis-cli ping'
    alias rcliinfo='redis-cli info'
    alias rclimon='redis-cli monitor'
fi

# -----------------------------------------------------------------------------
# Cloud CLI — AWS / GCP / Azure
# -----------------------------------------------------------------------------


alias s3='_x s3cmd'

if command -v aws >/dev/null 2>&1; then
    alias awsw='aws sts get-caller-identity'
    alias awsinfo='aws ec2 describe-instances'
    alias awss3='aws s3'
    alias awss3ls='aws s3 ls'
    alias awslb='aws elb describe-load-balancers'
    alias awsecs='aws ecs list-clusters'
    alias awsecr='aws ecr describe-repositories'
    alias awslam='aws lambda list-functions'
    alias awslog='aws logs describe-log-groups'
    alias awscw='aws cloudwatch'
    alias awsiam='aws iam list-users'
    alias awsr53='aws route53 list-hosted-zones'
fi

if command -v gcloud >/dev/null 2>&1; then
    alias gcl='gcloud'
    alias gcls='gcloud compute ssh'
    alias gcll='gcloud compute instances list'
    alias gclc='gcloud container clusters list'
    alias gclgke='gcloud container clusters get-credentials'
    alias gcllogs='gcloud logging list'
fi

if command -v az >/dev/null 2>&1; then
    alias azl='az vm list'
    alias azs='az vm start'
    alias azst='az vm stop'
    alias azr='az vm restart'
    alias azg='az group list'
    alias azaks='az aks list'
fi

# -----------------------------------------------------------------------------
# Media Tools — FFmpeg / ImageMagick / NVIDIA
# -----------------------------------------------------------------------------


if command -v ffmpeg >/dev/null 2>&1; then
    alias ffp='ffprobe'
    alias ffg='ffplay'
    alias ffconvert='ffmpeg -i'
    ffmp3() { ffmpeg -i "$1" -q:a 0 "${1%.*}.mp3"; }
    ffcompress() { ffmpeg -i "$1" -vcodec libx265 -crf 28 "${1%.*}-compressed.mp4"; }
    ffgif() { ffmpeg -i "$1" -vf "fps=10,scale=320:-1" "${1%.*}.gif"; }
    alias ffscreencap='ffmpeg -f x11grab -video_size 1920x1080 -i :0.0'
fi

if command -v convert >/dev/null 2>&1; then
    alias img='convert'
    alias imgres='convert -resize'
    alias imgfmt='convert -format'
    alias imgcompress='convert -quality 85'
fi

if command -v nvidia-smi >/dev/null 2>&1; then
    alias gpul='nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv'
    alias gputop='nvidia-smi dmon -s pucvmet'
fi

# -----------------------------------------------------------------------------
# Utility Operations — Clipboard / Hashing / Encoding / Help
# -----------------------------------------------------------------------------


# Clipboard
if command -v xclip >/dev/null 2>&1; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
elif command -v wl-copy >/dev/null 2>&1; then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
fi
alias pbc='pbcopy'
alias pbp='pbpaste'
alias cpy='(command -v xclip >/dev/null 2>&1 && xclip -selection clipboard) || (command -v wl-copy >/dev/null 2>&1 && wl-copy) || (command -v pbcopy >/dev/null 2>&1 && pbcopy) || echo "missing: clipboard tool" >&2'


if command -v xdotool >/dev/null 2>&1 && command -v xclip >/dev/null 2>&1; then
    alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
fi

# Hashing / Encoding
alias randpw='openssl rand -base64 16 2>/dev/null || python3 -c "import secrets; print(secrets.token_urlsafe(16))"'
alias sha='shasum -a 256'
alias md5sum='md5 || command md5sum'
alias hex='xxd'
alias base64e='base64'
alias base64d='base64 -d'
alias urlenc='_x python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))"'
alias urldec='_x python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))"'


# Shell / System Utilities
alias please='sudo'
alias pathlines='printf "%s\n" ${PATH//:/\\n}'
alias mkdirp='mkdir -p'
alias focus='printf "\033c" && date +"%F %T"'
alias h='history'
alias j='jobs -l'
alias duh='du -sh'
alias dfh='df -h'
alias freeh='free -h'
alias free='free -h'
alias du='du -h'
alias dud='du -h --max-depth=1'
alias du2='du -sh --max-depth=2'
alias dux='du -sh * | sort -h'
alias duk='du -sh * | sort -h'
alias duf='du -sh * | sort -h'
alias duls='du -sm * | sort -n'
alias dus='du -sh .[!.]* * 2>/dev/null | sort -h'
alias usage='du -sh * 2>/dev/null | sort -h'
alias dfT='df -hT'
alias df='df -h'
alias diskspace='df -h'
alias blk='lsblk -f'
alias disks='lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT'

alias fdisk='fdisk -l'
alias smart='sudo smartctl -a'

alias cpuinfo='lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string'
alias meminfo='free -h'
alias dmesg='dmesg -T'
alias uname='uname -a'
alias dateutc='date -u'
alias caldate='cal'
alias nproc='nproc 2>/dev/null || sysctl -n hw.ncpu'
alias release='cat /etc/os-release 2>/dev/null || cat /usr/lib/os-release'
alias arch='uname -m'
alias findsuid='find / -perm -4000 -type f'
alias timestamp='date +%s'
alias today='date +%F'
alias week='date +%V'
alias count='wc -l'
alias lines='cat -n'
cht() { curl -fsSL "https://cht.sh/$1"; }

learn() { curl -fsSL "https://learnxinyminutes.com/docs/$1"; }

cheat() { curl -fsSL "https://cheat.sh/$1"; }
alias try='curl -fsSL https://cht.sh'
alias tldrl='curl -fsSL https://cheat.sh'
alias what='type'
alias ali='alias'
alias envg='env | grep'

alias fn='declare -f 2>/dev/null || typeset -f'
alias path="echo \$PATH | tr ':' '\\n' | sort -u"
alias nohist='unset HISTFILE'
alias clhist='HISTSIZE=0; HISTSIZE=5000'
alias histgrep='history | grep -i'
alias cleanshell='env - bash --norc --noprofile'
alias topcmds='topcommands'
alias port='_x ss -tlnp || _x netstat -tlnp 2>/dev/null || echo "no port tool"'
alias ports='_x ss -tulpn || _x netstat -tulpn || _x lsof -i -n -P 2>/dev/null'

alias listen='_x ss -tlnp || _x netstat -tlnp 2>/dev/null'
alias connections='_x ss -tunp || _x netstat -tunp 2>/dev/null'
alias dsstore='find . -name ".DS_Store" -type f -delete -print 2>/dev/null'
alias mirrorsite='_x wget -m -k -K -E -e robots=off 2>/dev/null || echo "wget needed"'
alias sep='printf "=%.0s" $(seq 1 $(tput cols))'
countfiles() { echo "$(find . -type f 2>/dev/null | wc -l) files"; echo "$(find . -type l 2>/dev/null | wc -l) links"; echo "$(find . -type d 2>/dev/null | wc -l) directories"; }
alias tstamp='stamp'
alias idg='id -g'
alias idu='id -u'
alias shuffle='shuf'
alias rsample='shuf -n'
alias man='_x tldr || command man'

# -----------------------------------------------------------------------------
# Development Tools — Tmux / Editors / Lazygit / Just
# -----------------------------------------------------------------------------


# Tmux
if command -v tmux >/dev/null 2>&1; then
    alias tad='_x tmux attach -d'
    alias tl='_x tmux list-sessions'
    alias tn='_x tmux new-session -s'
    alias tk='_x tmux kill-session -t'
    alias tks='_x tmux kill-server'
    alias tsw='_x tmux switch-client'
    alias trn='_x tmux rename-session'
    alias tlp='_x tmux list-panes'
    alias tsplit='_x tmux split-window -h'
    alias tsplitv='_x tmux split-window'
    alias tprev='_x tmux previous-window'
    alias tnext='_x tmux next-window'
    alias tswap='_x tmux swap-window'
fi

# Editors
alias vim='nvim || command vim'
alias sv='nvim || command vim'
alias nv='nvim'
alias codel='code .'

if command -v nvim >/dev/null 2>&1; then
    alias svi='sudo nvim'
    alias vis='nvim "+set si"'
elif command -v vim >/dev/null 2>&1; then
    alias svi='sudo vim'
    alias vis='vim "+set si"'
fi

# Lazygit / Yazi / Zellij / Just / Make
if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
fi

if command -v yazi >/dev/null 2>&1; then
    alias yz='yazi'
fi

if command -v zellij >/dev/null 2>&1; then
    alias zj='zellij'
    alias zja='zellij attach'
    alias zjl='zellij list-sessions'
fi

if command -v just >/dev/null 2>&1; then
    alias justl='just --list'
fi

if command -v make >/dev/null 2>&1; then
    alias mk='make'
    alias mkc='make clean'
    alias mki='make install'
    alias mkt='make test'
fi


if command -v atuin >/dev/null 2>&1; then
    alias atu='atuin'
    alias atus='atuin search'
    alias atul='atuin login'
    alias atur='atuin register'
    alias atusync='atuin sync'
    alias atust='atuin status'
    alias atuh='atuin history'
    alias atuhl='atuin history list'
    alias atustats='atuin stats'
fi


if command -v direnv >/dev/null 2>&1; then
    alias dir='direnv'
    alias dira='direnv allow'
    alias dird='direnv deny'
    alias dirr='direnv reload'
    alias dire='direnv edit'
    alias dirv='direnv view'
    alias dirh='direnv hook'
fi


# z and zi are functions provided by zoxide init


if command -v fzf >/dev/null 2>&1; then
    alias fz='fzf'
    alias fzp='fzf --preview'
fi

# JSON / YAML processors
if command -v jq >/dev/null 2>&1; then
    alias jqc='jq -c'
    alias jqr='jq -r'
    alias jqs='jq -S'
fi

if command -v yq >/dev/null 2>&1; then
    alias yqe='yq eval'
    alias yqp='yq eval -P'
fi


if command -v glow >/dev/null 2>&1; then
    alias glows='glow -s'
fi

if command -v dog >/dev/null 2>&1; then
    alias doga='dog A'
    alias dogmx='dog MX'
    alias dogns='dog NS'
    alias dogtxt='dog TXT'
fi


if command -v bandwhich >/dev/null 2>&1; then
    alias band='bandwhich'
    alias bandl='bandwhich -r'
fi


if command -v navi >/dev/null 2>&1; then
    alias naviq='navi --query'
fi

if command -v tldr >/dev/null 2>&1 || command -v tealdeer >/dev/null 2>&1; then
    alias tldr='command tldr 2>/dev/null || tealdeer'
fi

if command -v vivid >/dev/null 2>&1; then
    alias vividg='vivid generate'
    alias vividt='vivid themes'
fi


if command -v chezmoi >/dev/null 2>&1; then
    alias chez='chezmoi'
    alias cheza='chezmoi apply'
    alias chezd='chezmoi diff'
    alias cheze='chezmoi edit'
    alias chezad='chezmoi add'
    alias chezup='chezmoi update'
    alias chezcd='chezmoi cd'
    alias chezi='chezmoi init'
    alias chezs='chezmoi status'
    alias chezr='chezmoi re-add'
fi


if command -v act >/dev/null 2>&1; then
    alias actl='act -l'
    alias actp='act -p'
    alias actpush='act push'
    alias actpr='act pull_request'
    alias actw='act -W'
fi

# Vagrant
if command -v vagrant >/dev/null 2>&1; then
    alias vg='vagrant'
    alias vgu='vagrant up'
    alias vgh='vagrant halt'
    alias vgd='vagrant destroy'
    alias vgs='vagrant status'
    alias vgssh='vagrant ssh'
    alias vgp='vagrant provision'
    alias vgreload='vagrant reload'
    alias vgbox='vagrant box list'
fi

# Packer
if command -v packer >/dev/null 2>&1; then
    alias pk='packer'
    alias pkb='packer build'
    alias pkv='packer validate'
    alias pkf='packer fmt'
    alias pkinit='packer init'
fi

# -----------------------------------------------------------------------------
# Infrastructure as Code — Terraform / Ansible
# -----------------------------------------------------------------------------


if command -v terraform >/dev/null 2>&1; then
    alias tfv='_x terraform validate'
    alias tff='_x terraform fmt'
    alias tfw='_x terraform workspace'
    alias tfwl='_x terraform workspace list'
    alias tfws='_x terraform workspace select'
    alias tfs='_x terraform show'
    alias tfo='_x terraform output'
    alias tfst='_x terraform state'
    alias tfstl='_x terraform state list'
    alias tfimp='_x terraform import'
    alias tfprov='_x terraform providers'
    alias tfgraph='_x terraform graph'
    alias tfconsole='_x terraform console'
fi

if command -v ansible >/dev/null 2>&1; then
    alias an='_x ansible'
    alias anp='_x ansible-playbook'
    alias ang='_x ansible-galaxy'
    alias anv='_x ansible-vault'
    alias and='_x ansible-doc'
    alias ancon='_x ansible-config'
    alias aninv='_x ansible-inventory'
fi

# -----------------------------------------------------------------------------
# Secret Management — Age / SOPS / Vault / OpenSSL
# -----------------------------------------------------------------------------


if command -v age >/dev/null 2>&1; then
    alias agee='age -e'
    alias aged='age -d'
    alias agegen='age-keygen'
fi

if command -v sops >/dev/null 2>&1; then
    alias sopse='sops -e'
    alias sopsd='sops -d'
    alias sopsi='sops -i'
fi

if command -v vault >/dev/null 2>&1; then
    alias vaults='vault status'
    alias vaultl='vault login'
    alias vaultkv='vault kv'
    alias vaultkvg='vault kv get'
    alias vaultkvp='vault kv put'
    alias vaultkvd='vault kv delete'
    alias vaultr='vault read'
    alias vaultw='vault write'
fi

if command -v openssl >/dev/null 2>&1; then
    alias ossl='openssl'
    alias osslcsr='openssl req -new -newkey rsa:2048 -nodes'
    alias osslchk='openssl s_client -connect'
    alias osslx='openssl x509 -in'
    alias osslr='openssl rand -hex'
    alias osslgen='openssl genrsa'
fi

# -----------------------------------------------------------------------------
# Backup Tools — Rclone / Restic / Borg / Kopia
# -----------------------------------------------------------------------------


if command -v rclone >/dev/null 2>&1; then
    alias rcl='rclone'
    alias rclls='rclone ls'
    alias rclsync='rclone sync'
    alias rclc='rclone copy'
    alias rclmv='rclone move'
fi

if command -v restic >/dev/null 2>&1; then
    alias rest='restic'
    alias restb='restic backup'
    alias restr='restic restore'
    alias rests='restic snapshots'
    alias restc='restic check'
fi

if command -v borg >/dev/null 2>&1; then
    alias borgc='borg create'
    alias borge='borg extract'
    alias borgl='borg list'
    alias borgi='borg info'
    alias borgd='borg delete'
    alias borgpr='borg prune'
fi

if command -v kopia >/dev/null 2>&1; then
    alias kop='kopia'
    alias kops='kopia snapshot create'
    alias kopl='kopia snapshot list'
    alias kopm='kopia mount'
    alias kopc='kopia cache clear'
fi

# -----------------------------------------------------------------------------
# Performance / Benchmarking
# -----------------------------------------------------------------------------


if command -v hyperfine >/dev/null 2>&1; then
    alias hf='hyperfine'
    alias hfw='hyperfine --warmup'
fi

if command -v fastfetch >/dev/null 2>&1; then
    alias ffet='_x fastfetch'
    alias ffetl='_x fastfetch -l'
fi

# -----------------------------------------------------------------------------
# Miscellaneous — Additional Aliases
# -----------------------------------------------------------------------------


pur() { _x curl -fsSL "https://cht.sh/$1" 2>/dev/null; }

# Standalone compatibility aliases — kept outside conditional blocks for quick access.
# All guarded with _x() so missing tools print a warning instead of crashing the shell.
alias pod='_x podman'
alias podps='_x podman ps'
alias podrun='_x podman run -it --rm'
alias podimg='_x podman images'
alias dstats='_x docker stats --no-stream'
alias kns='_x kubectl config set-context --namespace'
alias py='_x python3'

# Clipboard paste via xdotool — guarded against missing tools
# Uses command -v check instead of _x() because it chains two tools
alias clickpaste='command -v xdotool >/dev/null 2>&1 && command -v xclip >/dev/null 2>&1 && sleep 3 && xdotool type "$(xclip -o -selection clipboard)" || echo "missing: xdotool/xclip" >&2'

# Clean up opencode cache — guarded with || true and 2>/dev/null for missing directories
alias nuke-opencode='rm -rf ~/.local/share/opencode ~/.cache/opencode 2>/dev/null; echo "opencode cache cleaned"'


