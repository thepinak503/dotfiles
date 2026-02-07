#!/usr/bin/env bash
# =============================================================================
# 03-ALIASES-EXTENDED.SH - Advanced Aliases
# Modes: advanced, ultra-nerd
# =============================================================================

[[ "$DOTFILES_MODE" == "basic" ]] && return

# =============================================================================
# MODERN TOOL ALTERNATIVES
# =============================================================================

# Cat replacement
if command -v bat &>/dev/null; then
    alias cat='bat --style=header,grid'
    alias catp='bat --style=plain --paging=never'
    alias catl='bat --style=header,grid --paging=always'
    alias catn='bat --style=numbers'
elif command -v batcat &>/dev/null; then
    alias cat='batcat --style=header,grid'
    alias bat='batcat'
fi

# Find replacement
if command -v fd &>/dev/null; then
    alias find='fd'
    alias f='fd --type f'
    alias fd='fd --type d'
fi

# Grep replacement
if command -v rg &>/dev/null; then
    alias grep='rg --color=always'
    alias rgi='rg -i'
    alias rgf='rg --files-with-matches'
    alias rgc='rg --count'
elif command -v ugrep &>/dev/null; then
    alias grep='ugrep --color=auto'
    alias grepi='ugrep -i'
    alias grepv='ugrep -v'
    alias grepc='ugrep -c'
fi

# Du replacement
if command -v dust &>/dev/null; then
    alias du='dust'
    alias du.='dust -d 1'
fi

# Ps replacement
if command -v procs &>/dev/null; then
    alias ps='procs'
fi

# =============================================================================
# EZA/EXA ADVANCED ALIASES
# =============================================================================
if command -v eza &>/dev/null || command -v exa &>/dev/null; then
    alias ls='eza --group-directories-first --icons 2>/dev/null || exa --group-directories-first --icons'
    alias la='eza -a --group-directories-first --icons 2>/dev/null || exa -a --group-directories-first --icons'
    alias ll='eza -l --group-directories-first --icons 2>/dev/null || exa -l --group-directories-first --icons'
    alias l='eza -la --group-directories-first --icons 2>/dev/null || exa -la --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons 2>/dev/null || exa --tree --level=2 --icons'
    alias ltt='eza --tree --level=3 --icons 2>/dev/null || exa --tree --level=3 --icons'
    alias ltg='eza --tree --level=2 --git --icons 2>/dev/null || exa --tree --level=2 --git --icons'
    alias l.='eza -d --icons .* 2>/dev/null || exa -d --icons .*'
    alias lsize='eza -la --sort=size --reverse --icons 2>/dev/null || exa -la --sort=size --reverse --icons'
    alias ltime='eza -la --sort=modified --reverse --icons 2>/dev/null || exa -la --sort=modified --reverse --icons'
    alias lold='eza -la --sort=modified --icons 2>/dev/null || exa -la --sort=modified --icons'
    alias lext='eza -la --sort=extension --icons 2>/dev/null || exa -la --sort=extension --icons'
    alias lonly='eza -1 --icons 2>/dev/null || exa -1 --icons'
fi

# =============================================================================
# ADVANCED GIT ALIASES
# =============================================================================
alias gaa='git add --all'
alias gap='git add --patch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcam='git commit -a -m'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gclean='git clean -fd'
alias gcl='git clone --recurse-submodules'
alias gcm='git checkout master || git checkout main'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gcsm='git commit -s -m'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfg='git ls-files | grep'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
alias gk='gitk --all --branches'
alias gke='gitk --all $(git log -g --pretty=%h)'
alias gl='git log --oneline --graph --decorate'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty='
alias glods='git log --graph --pretty='
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty='
alias glola='git log --graph --pretty='
alias glols='git log --graph --pretty='
alias glp='_git_log_prettily'
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpristine='git reset --hard && git clean -dfx'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch master'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\\-\\-wip\\-\\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias gupv='git pull --rebase -v'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'

# =============================================================================
# DOCKER ALIASES
# =============================================================================
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias di='docker images'
alias dip='docker inspect --format="{{.NetworkSettings.IPAddress}}"'
alias dl='docker logs -f'
alias dr='docker run -it --rm'
alias drc='docker-compose'
alias dex='docker exec -it'
alias dvol='docker volume'
alias dnet='docker network'
alias dprune='docker system prune -af'
alias dprunev='docker volume prune -f'
alias dstats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'

# =============================================================================
# SYSTEM MONITORING
# =============================================================================
alias meminfo='free -h -l -t'
alias cpuinfo='lscpu'
alias dfh='df -h'
alias dfi='df -hi'
alias dus='du -sh'
alias dusort='du -h --max-depth=1 | sort -h'
alias dux='du -h --max-depth=1 | sort -h | xargs -I {} du -sh {}'
alias load='uptime'
alias mem='free -h'
alias io='iostat -xz 1'
alias net='ss -tulanp'
alias listening='ss -tulanp | grep LISTEN'

# =============================================================================
# DEVELOPMENT SHORTCUTS
# =============================================================================
alias py='python3'
alias py2='python2'
alias py3='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias json='python3 -m json.tool'

# Node.js
alias nr='npm run'
alias ns='npm start'
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nu='npm uninstall'
alias nls='npm list --depth=0'
alias nout='npm outdated'
alias nup='npm update'

# =============================================================================
# NETWORK ADVANCED
# =============================================================================
alias myip='curl -s ifconfig.me'
alias localip='ip -4 addr show | grep -oP "(?<=inet\s)\d+(\.\d+){3}" | grep -v "127.0.0.1"'
alias ips='ip -4 addr show | grep -oP "(?<=inet\s)\d+(\.\d+){3}"'
alias traceroute=' traceroute'
alias tracepath='tracepath'
alias dig='dig +short'
alias ns='nslookup'
alias whois='whois -H'

# =============================================================================
# FILE OPERATIONS
# =============================================================================
alias cp='cp -i --reflink=auto 2>/dev/null || cp -i'
alias cpv='rsync -ah --info=progress2'
alias mv='mv -i'
alias rm='rm -i --preserve-root'
alias shred='shred -vfz -n 10'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# =============================================================================
# SAFETY
# =============================================================================
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# =============================================================================
# CONVENIENCE
# =============================================================================
alias timestamp='date +%Y%m%d_%H%M%S'
alias datestamp='date +%Y%m%d'
alias week='date +%V'
alias timer='echo "Timer started. Stop with Ctrl+D." && date && time cat && date'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias trc='tmux rename-window $(basename $(pwd))'
