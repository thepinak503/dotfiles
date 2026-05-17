# -----------------------------------------------------------------------------
# Navigation
# -----------------------------------------------------------------------------
#
# This section provides directory navigation shortcuts. These aliases reduce
# keystrokes for common directory traversal patterns, directory bookmarks for
# frequently accessed locations, and shell session management commands.
#
# Notable aliases:
#   .. / ... / ....  — go up 1–5 directory levels (also a / aa / aaa / aaaa / aaaaa)
#   home             — cd to $HOME
#   docs / dt / tmp  — cd to ~/Documents, ~/Desktop, /tmp
#   root             — cd to filesystem root
#   bk               — return to previous directory (cd -)
#   tmpdir           — cd to a temporary directory created with mktemp
#   x / :q / q       — exit the shell
#   c / cls / clr    — clear the terminal
#   dash / -         — cd back (function + alias)
#
# See also: pushd, popd, zoxide (z, zi)
#
# Tip: use bk to toggle between two directories rapidly.
#

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
#
# This section provides file and directory listing aliases. These commands
# enhance the default ls experience with tree views, detailed listings, and
# modern alternatives (eza/exa) when available, falling back to standard ls.
#
# Notable aliases:
#   lsa / l1 / lh / lr  — various ls flag combinations (-a, -1, -lhS, -lR)
#   lsd / lsdot         — list only directories / dotfiles
#   lsf                 — list only regular files (via grep -v /)
#   lsbig               — largest files by size (ls -lS | head -20)
#   lshidden            — show hidden entries only
#   ltree               — eza --tree or fallback to find -maxdepth 3
#   le                  — list unique file extensions in pwd
#   lw                  — ls -ldh of current directory
#   ls / ll / la / tree — smart wrappers preferring eza, then exa, then ls
#   ldir / dirs         — list directories only
#   lf                  — list files with sizes sorted ascending
#
# See also: eza(1), exa(1), ls(1), tree(1)
#
# Warning: the fallback chain may produce different output formats across
#          systems where eza/exa are not installed.
#

alias lsa='ls -a'
alias lsd='ls -d */'
alias lsdot='ls -d .*'
alias lsf='ls -p | grep -v /'
alias lsbig='ls -lS | head -20'
alias lshidden='ls -d .* 2>/dev/null'
alias ltree='eza --tree --level=3 --icons=auto 2>/dev/null || find . -maxdepth 3 -print'
alias l1='ls -1'
alias lh='ls -lhS'
alias lr='ls -lR'
alias le="ls | grep -o '.[^.]*$' | sort | uniq"
alias lw='ls -ldh $(pwd)'
alias ls='_x eza --group-directories-first --icons 2>/dev/null || _x exa --group-directories-first 2>/dev/null || ls --color=auto 2>/dev/null || ls -G'
alias ll='_x eza -l --group-directories-first --icons 2>/dev/null || _x exa -l 2>/dev/null || ls -l'
alias la='_x eza -la --group-directories-first --icons 2>/dev/null || _x exa -la 2>/dev/null || ls -la'
alias tree='_x eza -T --icons 2>/dev/null || _x tree 2>/dev/null || echo "tree/eza needed"'
alias dirs='ls -d */'
alias ldir='ls -d */'
alias lf='find . -maxdepth 1 -type f -exec ls -lh {} + 2>/dev/null | sort -k5 -h'

# -----------------------------------------------------------------------------
# System Information — Dotfiles Management
# -----------------------------------------------------------------------------
#
# This section covers aliases for managing and inspecting the dotfiles
# repository itself. These commands provide shortcuts for common git
# operations scoped to $DOTFILES_DIR, health checks, version info, and
# reloading the shell configuration.
#
# Notable aliases:
#   dots / dotfiles   — cd to the dotfiles directory
#   dotst             — short git status of the dotfiles repo
#   dotupdate         — run the full dotfiles update script
#   dothealth         — run the health check script
#   dotbranch / dotdiff / dotlog / dotpush — git operations on dotfiles
#   dotreload         — exec $SHELL -l to reload the login shell
#   dsync             — run dot_sync (sync function)
#   chmode            — set $DOTFILES_MODE
#
# See also: git(1), chezmoi(1)
#
# Tip: run dothealth after any config change to catch regressions early.
#

alias dots='cd "$DOTFILES_DIR"'
alias dotfiles='cd "$DOTFILES_DIR"'
alias dotst='git -C "$DOTFILES_DIR" status --short --branch'
alias edots='$EDITOR "$DOTFILES_DIR"'
alias dotupdate='bash "$DOTFILES_DIR/bin/dotupdate.sh"'
alias dothealth='bash "$DOTFILES_DIR/bin/health_check.sh"'
alias dotbench='bash "$DOTFILES_DIR/bin/benchmark_shell.sh"'
alias dotfix='sh "$DOTFILES_DIR/install/install.sh"'
alias dotloadfull='. "$DOTFILES_DIR/core/aliases.sh" && . "$DOTFILES_DIR/core/functions.sh"'
alias dotbranch='git -C "$DOTFILES_DIR" branch'
alias dotdiff='git -C "$DOTFILES_DIR" diff'
alias dotdocs='xdg-open "$DOTFILES_DIR/docs/index.html" 2>/dev/null || open "$DOTFILES_DIR/docs/index.html" 2>/dev/null'
alias dotfetch='git -C "$DOTFILES_DIR" fetch --all --prune'
alias dothelp='echo "Pinak'\''s Dotfiles v$DOTFILES_VERSION — see dotdocs for docs"'
alias dotlog='git -C "$DOTFILES_DIR" log --oneline --graph --decorate -20'
alias dotmode='echo "$DOTFILES_MODE"'
alias dotpush='git -C "$DOTFILES_DIR" push'
alias dotreload='exec "$SHELL" -l'
alias dotver='echo "$DOTFILES_VERSION"'
alias dsync='dot_sync'
alias chmode='export DOTFILES_MODE'
alias modestat='echo "Mode: ${DOTFILES_MODE:-unknown}"'
alias dotinfo='echo "Dotfiles: $DOTFILES_DIR | Mode: ${DOTFILES_MODE:-unknown} | Shell: $SHELL"'

# -----------------------------------------------------------------------------
# Git Operations
# -----------------------------------------------------------------------------
#
# This section provides comprehensive git aliases for common version control
# workflows. These cover commit, push, pull, branch management, diff, stash,
# rebase, merge, cherry-pick, tag operations, and diagnostic commands, all
# using short two- and three-character mnemonics.
#
# Notable aliases:
#   g      — git (base command)
#   ga     — git add
#   gc     — git commit -v
#   gca    — git commit -a -v
#   gpl    — git pull (with or without --rebase --autostash)
#   gp     — git push
#   gco    — git checkout
#   gcb    — git checkout -b
#   gsw    — git switch
#   gswc   — git switch --create
#   gd     — git diff
#   gdc    — git diff --cached
#   gl     — git log --oneline -n 20
#   gla    — git log --oneline --graph --all --decorate
#   gs     — git status
#   gss    — git status --short
#   gst    — git stash
#   gsta   — git stash apply
#   grb    — git rebase
#   grbc   — git rebase --continue
#   gm     — git merge
#   gcp    — git cherry-pick
#   gbl    — git blame
#   gsh    — git show
#   gwip   — git add -A && git commit -m "wip" (--no-verify)
#   gwipe  — git reset --hard && git clean --force -df
#   nah    — hard reset + clean (same as gwipe)
#
# See also: git(1), git-workflow(7), lazygit (lg)
#
# Warning: gwipe / nah are destructive — they discard uncommitted changes.
#

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
alias gbage='for k in $(git branch -a | sed "s/^..//;s/ ->.*//" 2>/dev/null); do echo -e "$(git show --pretty=format:"%ci %cr" $k -- 2>/dev/null | head -1)\t$k"; done | sort -r'
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
alias gdf='git difftool'

# -----------------------------------------------------------------------------
# GitHub CLI (gh)
# -----------------------------------------------------------------------------
#
# This section provides aliases for the GitHub CLI tool. These cover pull
# request management, issue tracking, release operations, repository
# inspection, and workflow actions.
#
# Notable aliases:
#   gh     — gh (base command)
#   ghs    — gh status
#   ghp    — gh pr
#   ghpl   — gh pr list
#   ghpc   — gh pr create
#   ghco   — gh pr checkout
#   ghi    — gh issue
#   ghr    — gh release
#   ghrep  — gh repo
#   ghw    — gh workflow
#
# See also: gh(1), https://cli.github.com/manual/
#

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
#
# This section provides aliases for Docker and Docker Compose. These cover
# container lifecycle (run, exec, stop, rm), image management (build, rmi),
# system pruning, compose stacks, volume/network inspection, and resource
# usage statistics.
#
# Notable aliases:
#   dk       — docker (base command via _x)
#   dkps     — docker ps
#   dkex     — docker exec -it
#   dklogs   — docker logs -f
#   dkstop   — stop all running containers
#   dkrm     — remove all stopped containers
#   dkprune  — docker system prune -af
#   dkclean  — docker system prune -af --volumes
#   dkup     — docker compose up -d
#   dkdown   — docker compose down
#   dstats   — docker stats --no-stream
#   lzd      — lazydocker TUI
#   docker-ip — inspect container IP address
#
# See also: docker(1), docker-compose(1), lazydocker
#
# Warning: dkstop, dkrm, dkprune, dkclean operate on ALL containers/images.
#

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
#
# This section provides aliases for container image inspection, analysis,
# and security scanning tools. These cover image inspection (skopeo, dive),
# Dockerfile linting (hadolint), vulnerability scanning (trivy), and
# signature verification (cosign).
#
# Notable aliases:
#   sk / skc / skl / ski / sks — skopeo (copy, list-tags, inspect, sync)
#   dive                        — image layer inspection TUI
#   hado                        — hadolint Dockerfile linter
#   trivy / trivyi / trivyf     — vulnerability scanner (image, fs, repo)
#   cosign / cosignv / cosigns  — container image signing and verification
#
# See also: skopeo(1), dive(1), hadolint(1), trivy(1), cosign(1)
#

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
#
# This section provides aliases for Podman, the daemonless container engine.
# These cover container lifecycle (run, exec, stop, rm), image management,
# system pruning, and compose operations, mirroring the Docker alias scheme.
#
# Notable aliases:
#   pod        — podman (base command via _x)
#   podps      — podman ps
#   podex      — podman exec -it
#   podlogs    — podman logs -f
#   podstop    — stop all running containers
#   podprune   — podman system prune -af
#   podcom     — podman compose
#   podrun     — podman run -it --rm
#
# See also: podman(1), containers-podman(1)
#
# Warning: podstop operates on ALL running containers.
#

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
#
# This section covers kubectl aliases for managing Kubernetes clusters.
# These address pod and deployment operations, service inspection, log
# streaming, port-forwarding, context switching, resource creation, and
# cluster administration (cordon, drain, taint).
#
# Notable aliases:
#   kgpw    — kubectl get pods -w
#   kd / kdp / kds / kdd — kubectl describe (pod, svc, deployment)
#   kl / klf — kubectl logs / -f
#   kpf     — kubectl port-forward
#   kexec   — kubectl exec -it
#   ka      — kubectl apply -f
#   ktop    — kubectl top pods
#   kns     — set namespace context
#   kind    — kind (Kubernetes in Docker) management
#   mk      — minikube management
#   k0      — k0s management
#
# See also: kubectl(1), kubeconfig(5), minikube(1), kind(1), k0s(1)
#
# Tip: use kns <namespace> to switch default namespace without editing kubeconfig.
#

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
#
# This section provides aliases for the Helm package manager for Kubernetes.
# These cover release management (install, upgrade, delete, rollback),
# chart inspection (show chart/values), repository operations (add, list,
# update), and search across Helm repositories.
#
# Notable aliases:
#   hl      — helm (base command via _x)
#   hls     — helm list
#   hli     — helm install
#   hlu     — helm upgrade
#   hlui    — helm upgrade --install
#   hld     — helm delete
#   hlr     — helm rollback
#   hlshc   — helm show chart
#   hlshv   — helm show values
#   hlrl    — helm repo list
#   hlra    — helm repo add
#   hlsea   — helm search
#
# See also: helm(1), helm-using(1)
#

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
#
# This section provides aliases for systemd service and unit management.
# These cover service lifecycle (start, stop, restart, enable, disable),
# user service units, unit listing by state (all, failed, masked), and
# daemon-reload operations.
#
# Notable aliases:
#   scsr / scse / scsd — systemctl restart / enable / disable
#   scens / scdis      — systemctl enable/disable --now
#   scu / scus / scust — systemctl --user (status, start, stop)
#   scl / scla / scfail — systemctl list-units (default, all, failed)
#   scmask / scunmask  — systemctl mask / unmask
#   serv               — _x systemctl (shortcut)
#
# See also: systemctl(1), systemd(1)
#

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
#
# This section provides aliases for journalctl to inspect systemd journal
# logs. These cover filtering by unit, priority level, time windows, boot
# sessions, and disk usage management for the journal.
#
# Notable aliases:
#   jc       — journalctl (base command)
#   jcf      — journalctl -f (follow)
#   jcu      — journalctl -u (by unit)
#   jcub     — journalctl -u -b (by unit, current boot)
#   jcs      — journalctl --since
#   jcp      — journalctl -p err (error priority and above)
#   jcdf     — journalctl --disk-usage
#   jcemerg / jcalert / jccrit / jcwarn / jcnotice / jcinfo / jcdebug
#            — journalctl filtered by specific priority levels
#   jrnl     — _x journalctl (shortcut)
#
# See also: journalctl(1), systemd-journald(8)
#

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
#
# This section provides aliases for Arch Linux package management with
# pacman and the AUR helper yay. These cover package search, install,
# removal, orphan cleanup, files query, and database operations.
#
# Notable aliases:
#   pac / pacs / pacsi   — pacman (sudo) / search / info
#   pacup / pacin / pacrm — pacman -Syu / -S / -Rns
#   pacorph / pacclean   — list / remove orphan packages
#   yay / yays / yayi    — AUR-aware search / install
#   yayup / yayrm       — AUR upgrade / remove
#   yayf                 — fzf-interactive AUR package browser + install
#
# See also: pacman(8), yay(1), makepkg(8)
#
# Warning: pacclean removes all orphan packages in one operation.
#

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
    alias pacclean='sudo pacman -Rns $(pacman -Qtdq)'
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
# Package Managers — APT (Debian/Ubuntu)
# -----------------------------------------------------------------------------
#
# This section provides aliases for APT on Debian-based systems. These cover
# package search, install, removal, purging, automatic removal of orphans,
# package holding, and source/build dependency management.
#
# Notable aliases:
#   apt / apts / aptsh   — apt search / show
#   aptup / aptin / aptr — apt update + upgrade / install / remove
#   aptp                 — apt purge
#   aptau                — apt autoremove
#   aptbuild             — apt build-dep
#   apthold / aptunhold  — apt-mark hold / unhold
#   aptfix               — apt --fix-broken install
#
# See also: apt(8), apt-get(8), dpkg(1)
#

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
# Package Managers — DNF (Fedora/RHEL)
# -----------------------------------------------------------------------------
#
# This section provides aliases for DNF on Fedora/RHEL-based systems.
# These cover package search, install, removal, automatic removal, history
# inspection and rollback, repository management, module operations,
# and downgrade workflows.
#
# Notable aliases:
#   dnf / dnfs / dnfsi   — dnf search / info
#   dnfup / dnfi / dnfrm — upgrade / install / remove
#   dnfau                — dnf autoremove
#   dnfhist / dnfroll    — history inspection / rollback
#   dnfdowng             — dnf downgrade
#   dnfcache             — dnf clean all
#   dnfprov              — dnf provides (what package owns file)
#
# See also: dnf(8), rpm(8)
#

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
# Package Managers — Homebrew (macOS/Linux)
# -----------------------------------------------------------------------------
#
# This section provides aliases for Homebrew on macOS and Linux. These cover
# package search, install, uninstall, service management, update/upgrade
# with cleanup, dependency inspection, and cask (GUI app) installation.
#
# Notable aliases:
#   brew / brews / brewin   — brew search / install
#   brewrm                  — brew uninstall
#   brewup / brewupc        — brew update && upgrade (with/without cleanup)
#   brewsrv / brewsrvl      — brew services list
#   brewcask                — brew install --cask
#   brewdep / brewuses      — dependency inspection / reverse deps
#   brewleaves              — packages not required by others
#
# See also: brew(1), https://brew.sh
#

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
#
# This section provides aliases for Flatpak (cross-distro sandboxed apps),
# Snap (Canonical's package format), Nix (purely functional package manager),
# Zypper (openSUSE), and APK (Alpine Linux). Each group covers search,
# install, remove, update, and inspection workflows.
#
# Notable aliases:
#   flat / flats / flati    — flatpak search / install
#   snap / snaps / snapi    — snap search / install
#   nix / nixs / nixi       — nix search / profile install
#   zyp / zyps / zypi       — zypper search / install
#   apk / apks / apki       — apk search / add
#
# See also: flatpak(1), snap(1), nix(1), zypper(8), apk(8)
#

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
# Node.js / JavaScript — npm / pnpm / yarn
# -----------------------------------------------------------------------------
#
# This section provides aliases for Node.js package management and
# development workflows. These cover npm (test, build, run, publish,
# audit, outdated), pnpm (fast, disk-efficient alternative), and
# yarn (classic) with per-tool conventions.
#
# Notable aliases:
#   nt / nb / nrn / np   — npm test / build / run / publish
#   naud / naux          — npm audit / audit fix
#   ninit / nls / nout   — npm init / list / outdated
#   pn / pni / pnr       — pnpm install / run
#   pna / pnad / pnrm    — pnpm add / add -D / remove
#   y / ya / yr / yb     — yarn add / run / build
#
# See also: npm(1), pnpm(1), yarn(1), package.json(5)
#
# Tip: pnpm store is shared across projects — run pnstore to inspect.
#

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
#
# This section provides aliases for Rust development with Cargo. These cover
# the full build-test-run cycle, code quality (clippy, fmt, check),
# documentation generation, publishing, benchmark, and nightly toolchain
# shortcuts.
#
# Notable aliases:
#   cr / crb / crbr    — cargo build / build --release
#   crr / crrr         — cargo run / run --release
#   crt / crcl / crf   — cargo test / clippy / fmt
#   crc / crd          — cargo check / doc
#   crp / cru / crout  — cargo publish / update / outdated
#   crbench / crfix    — cargo bench / fix
#   crl                — cargo +nightly (nightly toolchain)
#   crw                — cargo watch
#   cradd / crrm       — cargo add / remove
#
# See also: cargo(1), rustc(1), https://doc.rust-lang.org/cargo/
#

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
#
# This section provides aliases for Go development. These cover compilation
# (build, run), testing (verbose with ./...), module management (mod tidy,
# mod vendor), code quality (fmt, vet), documentation, code generation,
# and profiling (pprof).
#
# Notable aliases:
#   go / gor / gob     — go run / build
#   got / gotv         — go test / test -v ./...
#   goi                — go install
#   gom / gomt / gomv  — go mod / mod tidy / mod vendor
#   gof / gol          — go fmt ./... / go vet ./...
#   godoc              — go doc
#   gogen              — go generate ./...
#   goc                — go clean
#   gop                — go tool pprof
#
# See also: go(1), https://go.dev/doc/
#

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
#
# This section provides aliases for Python development. These cover
# interpreter selection (python2/3), virtual environment creation and
# activation, pip package management (install, freeze, list, check),
# testing with pytest and unittest, and JSON/YAML/CSV formatting.
#
# Notable aliases:
#   py / py2 / py3    — python3 / python2 / python3
#   pipup / pi / piu  — pip upgrade / install / install --upgrade
#   venv / akt / dakt — create venv / activate / deactivate
#   pyreq / pyr       — pip freeze > requirements.txt / install -r
#   pyt / pyun        — pytest / unittest
#   json / yaml / csv — stdin formatting pipelines
#   math              — python3 -c (inline calculator)
#
# See also: python(1), pip(1), pytest(1), venv(1)
#
# Tip: akt sources .venv/bin/activate; run dakt to leave the venv.
#

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
#
# This section provides aliases for SSH client operations, key management,
# and host-key verification. These cover agent forwarding, strict host key
# checking bypass (for trusted/transient hosts), key generation, key removal
# from known_hosts, and public-key copy to remote hosts.
#
# Notable aliases:
#   ssh     — ssh (via _x)
#   ssha    — ssh -A (agent forwarding enabled)
#   sshi    — ssh -o StrictHostKeyChecking=no (insecure, transient hosts only)
#   ssk     — ssh-keygen
#   sskr    — ssh-keygen -R (remove host key)
#   ssc     — ssh-copy-id
#   scp     — scp (secure copy)
#
# See also: ssh(1), sshd(8), ssh-keygen(1), ssh-copy-id(1)
#
# Warning: sshi disables host key checking — use only in trusted environments.
#

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
#
# This section provides aliases for GNU Privacy Guard operations. These
# cover encryption, decryption, signing, verification, key listing, key
# export/import, and key retrieval from keyservers.
#
# Notable aliases:
#   gpg      — gpg (base command via _x)
#   gpge     — gpg -e (encrypt)
#   gpgd     — gpg -d (decrypt)
#   gpgs     — gpg -s (sign)
#   gpgv     — gpg --verify
#   gpgl     — gpg --list-keys
#   gpgls    — gpg --list-secret-keys
#   gpgex    — gpg --export
#   gpgimport — gpg --import
#   gpgrecv  — gpg --recv-keys
#
# See also: gpg(1), gpg-agent(1)
#

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
#
# This section provides aliases for network diagnostics, DNS queries,
# port scanning, HTTP requests, and connectivity testing. These combine
# traditional tools (dig, nmap, curl, wget, ss, traceroute) with modern
# Rust alternatives (dog, bandwhich, gping) when available.
#
# Notable aliases:
#   dns / dnsx / dnsmx  — dig +short, ANY, MX
#   nm / nms / nmp      — nmap ping sweep / version scan / OS detect
#   cur / curh / curv   — curl -fsSL / -I / -v
#   wg / wgr            — wget -c (continue) / recursive mirror
#   net / ipa / ipr     — ip -br addr / route
#   nst / portlisten    — netstat / ss for listening ports
#   trace               — traceroute
#   myip / myipl        — public / local IP address
#   speed               — speedtest-cli via curl
#   flush               — flush DNS cache (systemd-resolve / mDNSResponder)
#   ping / pb           — prettyping / ping 8.8.8.8
#   band / bandl        — bandwhich (network utilization TUI)
#   gping               — graphical ping
#
# See also: ip(8), ss(8), dig(1), nmap(1), curl(1), wget(1), traceroute(1)
#

alias myipl='ip addr show | grep "inet " | awk "{print \$2}" | cut -d/ -f1 | head -1'
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
alias net='_x ip -br addr 2>/dev/null || _x ifconfig 2>/dev/null'
alias ipa='_x ip -br addr 2>/dev/null || _x ifconfig 2>/dev/null'
alias trace='_x traceroute 2>/dev/null || _x traceroute6 2>/dev/null || echo "no traceroute"'
alias ip='ip -br addr'
alias myip='_x dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || _x curl -s ifconfig.me 2>/dev/null || echo "N/A"'
alias myipl='_x ip addr show scope global 2>/dev/null | grep -oP "inet \K[\d.]+" || _x ifconfig 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | awk "{print \$2}"'
alias dns='_x dig +short'
alias flush='_x sudo resolvectl flush-caches 2>/dev/null || _x sudo systemd-resolve --flush-caches 2>/dev/null || _x sudo killall -HUP mDNSResponder 2>/dev/null || echo "no flush"'
alias speed='_x curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | _x python3 - 2>/dev/null || echo "speedtest-cli needed"'
alias weather='_x curl -fsSL wttr.in 2>/dev/null || echo "curl needed"'
alias weather3='_x curl -fsSL "wttr.in?F" 2>/dev/null || echo "curl needed"'
alias moon='_x curl -fsSL "wttr.in/Moon" 2>/dev/null || echo "curl needed"'
alias dnst='dig +short'
alias iftop='sudo iftop'
alias ping='_x prettyping 2>/dev/null || command ping'
alias dig='_x dog 2>/dev/null || command dig'

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
#
# This section provides aliases for process inspection, signal handling,
# and scheduling. These cover process listing with various sort orders,
# tree views, kill signals, searching by name/pattern, priority adjustment
# with nice/renice, and resource monitoring (CPU, memory, I/O).
#
# Notable aliases:
#   ps / psf / psxl     — ps auxf / forest view
#   pse / psi / pid     — search processes by name/pattern
#   pst                 — pstree (process tree)
#   kill9 / kill15      — kill -9 / kill -15
#   pkillf              — pkill -f (kill by pattern)
#   topcpu / topmem     — top processes by CPU/memory
#   iotop               — I/O monitoring TUI
#   procs               — modern process viewer (Rust)
#   nohup / disown / bg / fg — job control
#   nice / renice       — priority adjustment
#
# See also: ps(1), kill(1), pkill(1), nice(1), renice(1), top(1)
#

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
alias top='_x btop 2>/dev/null || _x htop 2>/dev/null || command top'

# -----------------------------------------------------------------------------
# Text Processing
# -----------------------------------------------------------------------------
#
# This section provides aliases for text search, filtering, transformation,
# and comparison. These cover grep (with ripgrep fallback), sed, awk, sort,
# uniq, diff, column formatting, and common pipeline helpers. Modern
# alternatives (rg, sd, delta) are used when available.
#
# Notable aliases:
#   gr / gri / grr      — grep / grep -i / grep -r
#   rg / rgi            — ripgrep (with hidden files, excluding .git)
#   sed / awk / sort / uniq — standard text tools
#   uniqc               — sort | uniq -c | sort -rn (frequency count)
#   diff / diffy        — diff / diff -y (side-by-side), delta fallback
#   head / tail         — head/tail with common defaults
#   tair / taill        — tail -f / tail -100
#   nl / tac / rev      — line numbering / reverse / reverse chars
#   cut / tr / fold / column / join — field/column operations
#   grepw / grepr / grex — grep word / recursive / exclude dirs
#   delta               — modern diff viewer (Rust)
#   sd                  — find-and-replace (sed alternative, Rust)
#
# See also: grep(1), rg(1), sed(1), awk(1), diff(1), delta(1)
#

alias gr='grep'
alias gri='grep -i'
alias grr='grep -r'
alias grri='grep -ri'
alias grl='grep -rl'
alias grc='grep -c'
alias uniqc='sort | uniq -c | sort -rn'
alias wcw='wc -w'
alias column='column -t'
alias diffy='diff -y'
alias tair='tail -f'
alias taill='tail -100'
alias headl='head -100'
alias nl='nl -ba'
alias tac='tac 2>/dev/null || tail -r'
alias grepw='grep -w'
alias grepr='grep -r'
alias grex='grep -r --exclude-dir=.git --exclude-dir=node_modules'
alias grep='_x rg --color=auto 2>/dev/null || command grep --color=auto'
alias diff='_x delta 2>/dev/null || command diff --color=auto 2>/dev/null || command diff'

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
#
# This section provides aliases for file manipulation, copying, moving,
# deletion, permissions, symlinks, and disk usage. These use interactive
# flags (-i) by default for safety, and include modern alternatives
# (bat, fd, rsync) when available.
#
# Notable aliases:
#   cp / mv / rm        — interactive copy/move/remove
#   rmr / rmf / cpf     — recursive / force variants
#   cpv                 — rsync-based copy with progress
#   rsync / rsyncdn     — rsync with archive/compress/dry-run
#   chx / chm           — chmod +x / chmod
#   ln / lnh            — symlink / readlink
#   backup              — timestamped backup copy
#   fd / fdi            — fd (find alternative) with hidden
#   find                — fd with hidden fallback to find
#   cat                 — bat with fallback to cat
#   shred / shredf      — secure file deletion
#   lsof / lsofi        — list open files / by port
#   du / dud / du2      — disk usage with depth control
#
# See also: cp(1), mv(1), rm(1), rsync(1), fd(1), bat(1), shred(1)
#
# Warning: rmf / shred are destructive and irreversible.
#

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
alias backup='cp -r "$1" "${1}.bak-$(date +%Y%m%d-%H%M%S)"'
alias mount='mount | column -t'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias bc='bc -l'
alias find='_x fd 2>/dev/null || command find'
alias cat='_x bat --style=plain --paging=never 2>/dev/null || _x batcat --style=plain --paging=never 2>/dev/null || command cat'
alias fd='_x fd 2>/dev/null || find'
alias ff='find . -type f -name'
alias mkdir='mkdir -p'
alias wget='_x wget 2>/dev/null || _x curl -fSL -o 2>/dev/null || echo "no download tool"'

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
#
# This section provides aliases for archive creation, extraction, and
# inspection across multiple formats. These cover tar (gz, bz2, xz),
# gzip, bzip2, xz, 7z, rar, zip, and the modern ouch tool with
# format-agnostic compression.
#
# Notable aliases:
#   tart / tarjx / tarjc  — tar list / extract bz2 / create bz2
#   tarzx / tarzc        — tar extract xz / create xz
#   tarl                  — tar list verbose
#   gunz / bz2 / bunz    — gzip / bzip2 / bunzip2
#   xz / unxz            — xz / unxz
#   7z / 7zx / 7za       — 7z base / extract / add
#   rarx                  — unrar extract
#   ouch / ouchd / ouchc — modern format-agnostic compress/decompress
#
# See also: tar(1), gzip(1), bzip2(1), xz(1), 7z(1), unrar(1), ouch(1)
#

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
#
# This section provides aliases for relational and NoSQL database clients.
# These cover MySQL (client, dump, root access), PostgreSQL (client, dump,
# restore), SQLite (interactive, dump), and Redis (ping, info, monitor).
#
# Notable aliases:
#   myq / myqr          — mysql / mysql -u root -p
#   mydump / mydumpr    — mysqldump / mysqldump -u root -p
#   psql / psqlr        — psql / psql -U postgres
#   pgdump / pgres      — pg_dump / pg_restore
#   sq3 / sq3d          — sqlite3 / sqlite3 .dump
#   rcli / rcliping     — redis-cli / ping
#   rcliinfo / rclimon  — redis info / monitor
#
# See also: mysql(1), psql(1), sqlite3(1), redis-cli(1)
#

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
#
# This section provides aliases for major cloud provider CLIs. These cover
# AWS (STS, EC2, S3, ECS, ECR, Lambda, CloudWatch, IAM, Route53), GCP
# (Compute SSH, instances, GKE clusters, logs), and Azure (VM management,
# resource groups, AKS).
#
# Notable aliases:
#   aws / awsw / awsinfo  — aws sts get-caller-identity / ec2 describe
#   awss3 / awss3ls       — aws s3 / aws s3 ls
#   awsecs / awsecr       — ECS clusters / ECR repos
#   gcl / gcls / gcll     — gcloud / compute ssh / instances list
#   gclgke                — gcloud container clusters get-credentials
#   az / azl / azs        — az / vm list / vm start
#
# See also: aws(1), gcloud(1), az(1)
#

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
#
# This section provides aliases for multimedia processing. These cover
# FFmpeg (probe, play, format conversion, compression, GIF creation,
# screen capture), ImageMagick (resize, format conversion, compression),
# and NVIDIA GPU monitoring (utilization, memory, temperature).
#
# Notable aliases:
#   ffp / ffg          — ffprobe / ffplay
#   ffconvert          — ffmpeg -i (generic conversion)
#   ffmp3              — extract audio as MP3
#   ffcompress         — H.265/HEVC compression
#   ffgif              — video to GIF
#   ffscreencap        — X11 screen capture
#   img / imgres       — ImageMagick convert / resize
#   gpul / gputop      — nvidia-smi query / dmon
#
# See also: ffmpeg(1), ffprobe(1), convert(1), nvidia-smi(1)
#

if command -v ffmpeg >/dev/null 2>&1; then
    alias ffp='ffprobe'
    alias ffg='ffplay'
    alias ffconvert='ffmpeg -i'
    alias ffmp3='ffmpeg -i "$1" -q:a 0 "${1%.*}.mp3"'
    alias ffcompress='ffmpeg -i "$1" -vcodec libx265 -crf 28'
    alias ffgif='ffmpeg -i "$1" -vf "fps=10,scale=320:-1" "${1%.*}.gif"'
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
#
# This section provides general-purpose utility aliases. These cover
# clipboard access (pbcopy/pbpaste for X11/Wayland), hashing and checksums
# (SHA256, MD5), encoding (base64, hex, URL), random password generation,
# cheat sheet access (cht.sh, cheat.sh, learnxinyminutes), shell info
# (history, path, env), and system data (disk, memory, CPU).
#
# Notable aliases:
#   pbcopy / pbpaste   — clipboard copy/paste (xclip or wl-clipboard)
#   sha / md5sum / hex — hashing / hex dump
#   base64e / base64d  — base64 encode / decode
#   urlenc / urldec    — URL encode / decode
#   randpw             — random 16-byte base64 password
#   cht / cheat / learn — online cheat sheets (cht.sh, cheat.sh)
#   please             — sudo (politely)
#   focus              — clear screen + timestamp
#   path / pathlines   — display PATH entries
#   port / ports       — listening ports via ss/netstat/lsof
#   connections        — active connections via ss/netstat
#   sep                — horizontal rule across terminal width
#   countfiles         — count files/links/dirs in pwd
#
# See also: xclip(1), openssl(1), xxd(1), cht.sh
#

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
alias pst='(command -v xclip >/dev/null 2>&1 && xclip -selection clipboard -o) || (command -v wl-paste >/dev/null 2>&1 && wl-paste) || (command -v pbpaste >/dev/null 2>&1 && pbpaste) || echo "missing: clipboard tool" >&2'

if command -v xdotool >/dev/null 2>&1 && command -v xclip >/dev/null 2>&1; then
    alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
fi

# Hashing / Encoding
alias randpw='openssl rand -base64 16 2>/dev/null || python3 -c "import secrets; print(secrets.token_urlsafe(16))"'
alias sha='shasum -a 256'
alias md5sum='md5 2>/dev/null || command md5sum'
alias hex='xxd'
alias base64e='base64'
alias base64d='base64 -d'
alias urlenc='_x python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))"'
alias urldec='_x python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))"'
alias sha='_x shasum -a 256 2>/dev/null || _x sha256sum 2>/dev/null'
alias hex='_x xxd 2>/dev/null || _x od -A x -t x1z 2>/dev/null'

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
alias disks='_x lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT 2>/dev/null || _x diskutil list 2>/dev/null'
alias fdisk='fdisk -l'
alias smart='sudo smartctl -a'
alias smart='_x sudo smartctl -a 2>/dev/null || echo "no smartctl"'
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
alias cht='curl -fsSL "https://cht.sh/$1"'
alias cht='_x curl -fsSL "https://cht.sh/$1" 2>/dev/null || echo "curl needed"'
alias learn='curl -fsSL "https://learnxinyminutes.com/docs/$1"'
alias learn='_x curl -fsSL "https://learnxinyminutes.com/docs/$1" 2>/dev/null'
alias cheat='curl -fsSL "https://cheat.sh/$1"'
alias try='curl -fsSL https://cht.sh'
alias tldrl='curl -fsSL https://cheat.sh'
alias what='type'
alias ali='alias'
alias envg='env | grep'
alias envg="env | grep -i"
alias fn='declare -f 2>/dev/null || typeset -f'
alias path="echo \$PATH | tr ':' '\\n' | sort -u"
alias nohist='unset HISTFILE'
alias clhist='HISTSIZE=0; HISTSIZE=5000'
alias histgrep='history | grep -i'
alias cleanshell='env - bash --norc --noprofile'
alias topcmds='topcommands'
alias port='_x ss -tlnp 2>/dev/null || _x netstat -tlnp 2>/dev/null || echo "no port tool"'
alias ports='_x ss -tulpn 2>/dev/null || _x netstat -tulpn 2>/dev/null || _x lsof -i -n -P 2>/dev/null'
alias ports='_x ss -tlnp 2>/dev/null || _x netstat -tlnp 2>/dev/null || _x lsof -i -P -n 2>/dev/null | grep LISTEN'
alias listen='_x ss -tlnp 2>/dev/null || _x netstat -tlnp 2>/dev/null'
alias connections='_x ss -tunp 2>/dev/null || _x netstat -tunp 2>/dev/null'
alias dsstore='find . -name ".DS_Store" -type f -delete -print 2>/dev/null'
alias mirrorsite='_x wget -m -k -K -E -e robots=off 2>/dev/null || echo "wget needed"'
alias sep='printf "=%.0s" $(seq 1 $(tput cols))'
alias countfiles='for t in files links directories; do echo $(find . -type ${t:0:1} 2>/dev/null | wc -l) $t; done 2>/dev/null'
alias tstamp='stamp'
alias idg='id -g'
alias idu='id -u'
alias shuffle='shuf'
alias rsample='shuf -n'
alias man='_x tldr 2>/dev/null || command man'

# -----------------------------------------------------------------------------
# Development Tools — Tmux / Editors / Lazygit / Just
# -----------------------------------------------------------------------------
#
# This section provides aliases for development tooling beyond language
# runtimes. These cover tmux (session management, window splitting),
# editors (Neovim with sudo variant), lazygit TUI, yazi file manager,
# zellij multiplexer, just command runner, make, chezmoi dotfile manager,
# Vagrant VM management, Packer image builder, and act GitHub Actions runner.
#
# Notable aliases:
#   tad / tl / tn       — tmux attach / list / new session
#   lg                  — lazygit TUI
#   yz                  — yazi file manager
#   zj / zja / zjl      — zellij / attach / list
#   just / justl         — just command runner / list
#   mk / mkc / mkt      — make / clean / test
#   vim / nv / sv       — Neovim / sudo Neovim
#   chez / cheza        — chezmoi / apply
#   vg / vgu / vgh      — vagrant / up / halt
#   pk / pkb / pkv      — packer / build / validate
#   act / actl          — GitHub Actions locally / list
#
# See also: tmux(1), nvim(1), lazygit(1), yazi(1), zellij(1), just(1)
#

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
alias vim='nvim 2>/dev/null || command vim'
alias sv='nvim 2>/dev/null || command vim'
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

# Atuin (shell history)
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

# Direnv (env loader)
if command -v direnv >/dev/null 2>&1; then
    alias dir='direnv'
    alias dira='direnv allow'
    alias dird='direnv deny'
    alias dirr='direnv reload'
    alias dire='direnv edit'
    alias dirv='direnv view'
    alias dirh='direnv hook'
fi

# Zoxide (smarter cd)
if command -v zoxide >/dev/null 2>&1; then
    alias z='zoxide'
    alias zi='zoxide query -i'
fi

# Fzf (fuzzy finder)
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

# Glow (markdown renderer)
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

# Chezmoi (dotfile manager)
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

# Act (GitHub Actions locally)
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
#
# This section provides aliases for infrastructure provisioning and
# configuration management tools. These cover Terraform (validate, fmt,
# workspace, state, import, graph, console) and Ansible (playbook, galaxy,
# vault, doc, config, inventory).
#
# Notable aliases:
#   tfv / tff / tfw     — terraform validate / fmt / workspace
#   tfs / tfo           — terraform show / output
#   tfst / tfstl        — terraform state / state list
#   tfimp / tfgraph     — terraform import / graph
#   an / anp / ang      — ansible / ansible-playbook / galaxy
#   anv / and           — ansible-vault / ansible-doc
#
# See also: terraform(1), ansible(1), ansible-playbook(1)
#

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
#
# This section provides aliases for encryption, secret storage, and
# certificate management. These cover age (modern file encryption),
# SOPS (encrypted YAML/JSON for configs), HashiCorp Vault (KV store,
# login, status), and OpenSSL (CSR generation, cert inspection, random).
#
# Notable aliases:
#   age / agee / aged   — age encrypt / decrypt
#   sops / sopse / sopsd — SOPS encrypt / decrypt / in-place
#   vault / vaults      — vault status
#   vaultkv / vaultkvg  — vault kv get
#   ossl / osslcsr      — openssl / CSR generation
#   osslchk / osslx     — TLS connection check / x509 inspect
#
# See also: age(1), sops(1), vault(1), openssl(1)
#

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
#
# This section provides aliases for file backup, synchronization, and
# archival tools. These cover rclone (cloud storage sync), restic
# (encrypted backups), Borg (deduplicating backup), and Kopia
# (fast encrypted snapshots).
#
# Notable aliases:
#   rcl / rclls / rclsync — rclone ls / sync / copy / move
#   rest / restb / restr  — restic backup / restore / snapshots
#   borg / borgc / borge  — borg create / extract / list / prune
#   kop / kops / kopl     — kopia snapshot create / list / mount
#
# See also: rclone(1), restic(1), borg(1), kopia(1)
#

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
#
# This section provides aliases for performance benchmarking and system
# information tools. These cover hyperfine (command benchmarking) and
# fastfetch (system information display).
#
# Notable aliases:
#   hf / hfw     — hyperfine / hyperfine --warmup
#   ffet / ffetl — fastfetch / fastfetch -l
#
# See also: hyperfine(1), fastfetch(1)
#

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
#
# This section collects additional aliases that provide standalone
# convenience wrappers, duplicate definitions preserved for compatibility,
# and fallback commands outside conditional blocks.
#
# Notable aliases:
#   tstamp / topcmds   — stamp / topcommands wrappers
#   idg / idu / groups — user identity queries
#   last / w           — login history / who is online
#   seq / expand / od  — standard text utilities
#   grex               — grep excluding .git and node_modules
#   rstring            — random hex token via Python secrets
#   clickpaste         — xdotool type clipboard content after 3s delay
#   dsstore            — delete .DS_Store files recursively
#   mirrorsite         — wget full site mirror
#   countfiles         — count files, links, directories in pwd
#   sep                — print horizontal rule across terminal
#

alias tstamp='stamp'
alias topcmds='topcommands'
alias idg='id -g'
alias idu='id -u'
alias shuffle='shuf'
alias rsample='shuf -n'
alias pur='_x curl -fsSL "https://cht.sh/$1" 2>/dev/null'

# Standalone duplicates preserved for compatibility
alias pod='_x podman'
alias podps='_x podman ps'
alias podrun='_x podman run -it --rm'
alias podimg='_x podman images'
alias dstats='_x docker stats --no-stream'
alias kns='_x kubectl config set-context --namespace'
alias py='_x python3'
alias ip='ip -br addr'
alias free='free -h'
alias bc='bc -l'
alias wget='_x wget 2>/dev/null || _x curl -fSL -o 2>/dev/null || echo "no download tool"'

# Miscellaneous shell utilities
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias dsstore='find . -name ".DS_Store" -type f -delete -print 2>/dev/null'
alias mirrorsite='_x wget -m -k -K -E -e robots=off 2>/dev/null || echo "wget needed"'
alias sep='printf "=%.0s" $(seq 1 $(tput cols))'
alias countfiles='for t in files links directories; do echo $(find . -type ${t:0:1} 2>/dev/null | wc -l) $t; done 2>/dev/null'
alias psymod='lsmod'
