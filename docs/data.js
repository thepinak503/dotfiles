const dotfilesData = {
  "aliases": [
    {
      "category": "General",
      "name": "rm",
      "cmd": "rm -i"
    },
    {
      "category": "General",
      "name": "cp",
      "cmd": "cp -i"
    },
    {
      "category": "General",
      "name": "mv",
      "cmd": "mv -i"
    },
    {
      "category": "General",
      "name": "ln",
      "cmd": "ln -i"
    },
    {
      "category": "General",
      "name": "chown",
      "cmd": "chown --preserve-root"
    },
    {
      "category": "General",
      "name": "chmod",
      "cmd": "chmod --preserve-root"
    },
    {
      "category": "General",
      "name": "chgrp",
      "cmd": "chgrp --preserve-root"
    },
    {
      "category": "General",
      "name": "~",
      "cmd": "cd ~"
    },
    {
      "category": "General",
      "name": "-- -",
      "cmd": "cd -"
    },
    {
      "category": "General",
      "name": "home",
      "cmd": "cd ~"
    },
    {
      "category": "General",
      "name": "back",
      "cmd": "cd -"
    },
    {
      "category": "General",
      "name": "dots",
      "cmd": "cd \"$DOTFILES_DIR\""
    },
    {
      "category": "General",
      "name": "dotfiles",
      "cmd": "cd \"$DOTFILES_DIR\""
    },
    {
      "category": "General",
      "name": "dl",
      "cmd": "cd ~/Downloads"
    },
    {
      "category": "General",
      "name": "desk",
      "cmd": "cd ~/Desktop"
    },
    {
      "category": "General",
      "name": "docs",
      "cmd": "cd ~/Documents"
    },
    {
      "category": "General",
      "name": "pics",
      "cmd": "cd ~/Pictures"
    },
    {
      "category": "General",
      "name": "music",
      "cmd": "cd ~/Music"
    },
    {
      "category": "General",
      "name": "vids",
      "cmd": "cd ~/Videos"
    },
    {
      "category": "General",
      "name": "tmp",
      "cmd": "cd /tmp"
    },
    {
      "category": "General",
      "name": "etc",
      "cmd": "cd /etc"
    },
    {
      "category": "General",
      "name": "usrbin",
      "cmd": "cd /usr/bin"
    },
    {
      "category": "General",
      "name": "localbin",
      "cmd": "cd ~/.local/bin"
    },
    {
      "category": "General",
      "name": "confdir",
      "cmd": "cd ~/.config"
    },
    {
      "category": "General",
      "name": "ltt",
      "cmd": "eza --tree --level=3 --icons"
    },
    {
      "category": "General",
      "name": "lttt",
      "cmd": "eza --tree --level=4 --icons"
    },
    {
      "category": "General",
      "name": "lll",
      "cmd": "eza -la --icons --git --color=auto --time-style=long-iso"
    },
    {
      "category": "General",
      "name": "llm",
      "cmd": "eza -la --icons --git --sort=modified"
    },
    {
      "category": "General",
      "name": "lls",
      "cmd": "eza -la --icons --git --sort=size"
    },
    {
      "category": "General",
      "name": "lle",
      "cmd": "eza -la --icons --git --sort=extension"
    },
    {
      "category": "General",
      "name": "lln",
      "cmd": "eza -la --icons --git --sort=name"
    },
    {
      "category": "General",
      "name": "treea",
      "cmd": "eza --tree --icons -a"
    },
    {
      "category": "General",
      "name": "tree",
      "cmd": "exa --tree --icons"
    },
    {
      "category": "General",
      "name": "catp",
      "cmd": "bat --style=plain --paging=never"
    },
    {
      "category": "General",
      "name": "bh",
      "cmd": "bat --style=header"
    },
    {
      "category": "General",
      "name": "bp",
      "cmd": "bat --style=plain"
    },
    {
      "category": "General",
      "name": "catn",
      "cmd": "batcat --style=plain"
    },
    {
      "category": "General",
      "name": "find",
      "cmd": "fd -H"
    },
    {
      "category": "General",
      "name": "ff",
      "cmd": "fd -H"
    },
    {
      "category": "General",
      "name": "fdir",
      "cmd": "fd -t d"
    },
    {
      "category": "General",
      "name": "ffile",
      "cmd": "fd -t f"
    },
    {
      "category": "General",
      "name": "rgs",
      "cmd": "rg --smart-case --hidden -l"
    },
    {
      "category": "General",
      "name": "rgn",
      "cmd": "rg --smart-case --hidden -N"
    },
    {
      "category": "General",
      "name": "diff",
      "cmd": "delta"
    },
    {
      "category": "General",
      "name": "htop",
      "cmd": "btop"
    },
    {
      "category": "General",
      "name": "top",
      "cmd": "htop"
    },
    {
      "category": "General",
      "name": "ps",
      "cmd": "ps auxf"
    },
    {
      "category": "General",
      "name": "psg",
      "cmd": "ps aux | grep -v grep | grep -i"
    },
    {
      "category": "General",
      "name": "pstree",
      "cmd": "pstree -p"
    },
    {
      "category": "General",
      "name": "killi",
      "cmd": "kill -9"
    },
    {
      "category": "General",
      "name": "killall9",
      "cmd": "killall -9"
    },
    {
      "category": "General",
      "name": "df",
      "cmd": "df -hT"
    },
    {
      "category": "General",
      "name": "duh",
      "cmd": "du -sh"
    },
    {
      "category": "General",
      "name": "free",
      "cmd": "free -h"
    },
    {
      "category": "General",
      "name": "meminfo",
      "cmd": "cat /proc/meminfo"
    },
    {
      "category": "General",
      "name": "cpuinfo",
      "cmd": "cat /proc/cpuinfo"
    },
    {
      "category": "General",
      "name": "cpus",
      "cmd": "nproc"
    },
    {
      "category": "General",
      "name": "arch",
      "cmd": "uname -m"
    },
    {
      "category": "General",
      "name": "kernel",
      "cmd": "uname -r"
    },
    {
      "category": "General",
      "name": "hostname",
      "cmd": "hostname -f"
    },
    {
      "category": "General",
      "name": "uptime",
      "cmd": "uptime -p"
    },
    {
      "category": "General",
      "name": "loadavg",
      "cmd": "cat /proc/loadavg"
    },
    {
      "category": "General",
      "name": "boottime",
      "cmd": "who -b"
    },
    {
      "category": "General",
      "name": "lscpu",
      "cmd": "lscpu"
    },
    {
      "category": "General",
      "name": "lsblk",
      "cmd": "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT"
    },
    {
      "category": "General",
      "name": "lsusb",
      "cmd": "lsusb -v 2>/dev/null | head -50"
    },
    {
      "category": "General",
      "name": "lspci",
      "cmd": "lspci -v"
    },
    {
      "category": "General",
      "name": "dmidecode",
      "cmd": "sudo dmidecode"
    },
    {
      "category": "General",
      "name": "neofetch",
      "cmd": "fastfetch"
    },
    {
      "category": "General",
      "name": "sf",
      "cmd": "neofetch"
    },
    {
      "category": "General",
      "name": "sysinfo",
      "cmd": "neofetch"
    },
    {
      "category": "General",
      "name": "fetch",
      "cmd": "neofetch"
    },
    {
      "category": "General",
      "name": "dff",
      "cmd": "df -hT | grep -v tmpfs"
    },
    {
      "category": "General",
      "name": "diskfree",
      "cmd": "df -h --total | tail -1"
    },
    {
      "category": "General",
      "name": "du",
      "cmd": "gdu"
    },
    {
      "category": "General",
      "name": "lsblka",
      "cmd": "lsblk -a"
    },
    {
      "category": "General",
      "name": "mount",
      "cmd": "mount | column -t"
    },
    {
      "category": "General",
      "name": "vi",
      "cmd": "nvim"
    },
    {
      "category": "General",
      "name": "vim",
      "cmd": "nvim"
    },
    {
      "category": "General",
      "name": "nv",
      "cmd": "nvim"
    },
    {
      "category": "General",
      "name": "svim",
      "cmd": "sudo nvim"
    },
    {
      "category": "General",
      "name": "nano",
      "cmd": "nano -l"
    },
    {
      "category": "General",
      "name": "ebash",
      "cmd": "$EDITOR ~/.bashrc"
    },
    {
      "category": "General",
      "name": "ezsh",
      "cmd": "$EDITOR ~/.zshrc"
    },
    {
      "category": "General",
      "name": "efish",
      "cmd": "$EDITOR ~/.config/fish/config.fish"
    },
    {
      "category": "General",
      "name": "egit",
      "cmd": "$EDITOR ~/.gitconfig"
    },
    {
      "category": "General",
      "name": "estarship",
      "cmd": "$EDITOR \"$DOTFILES_DIR/apps/starship-linux.toml\""
    },
    {
      "category": "General",
      "name": "efastfetch",
      "cmd": "$EDITOR \"$DOTFILES_DIR/apps/fastfetch/config.jsonc\""
    },
    {
      "category": "General",
      "name": "edots",
      "cmd": "$EDITOR \"$DOTFILES_DIR\""
    },
    {
      "category": "General",
      "name": "etmux",
      "cmd": "$EDITOR ~/.tmux.conf"
    },
    {
      "category": "General",
      "name": "essh",
      "cmd": "$EDITOR ~/.ssh/config"
    },
    {
      "category": "General",
      "name": "evimrc",
      "cmd": "$EDITOR ~/.config/nvim/init.lua"
    },
    {
      "category": "General",
      "name": "dotupdate",
      "cmd": "$DOTFILES_DIR/bin/dotupdate.sh"
    },
    {
      "category": "General",
      "name": "rbash",
      "cmd": "source ~/.bashrc"
    },
    {
      "category": "General",
      "name": "rzsh",
      "cmd": "source ~/.zshrc"
    },
    {
      "category": "General",
      "name": "g",
      "cmd": "git"
    },
    {
      "category": "General",
      "name": "gi",
      "cmd": "git init"
    },
    {
      "category": "General",
      "name": "gcl",
      "cmd": "git clone"
    },
    {
      "category": "General",
      "name": "gcld",
      "cmd": "git clone --depth=1"
    },
    {
      "category": "General",
      "name": "gs",
      "cmd": "git status"
    },
    {
      "category": "General",
      "name": "gss",
      "cmd": "git status -sb"
    },
    {
      "category": "General",
      "name": "gsv",
      "cmd": "git status -v"
    },
    {
      "category": "General",
      "name": "ga",
      "cmd": "git add"
    },
    {
      "category": "General",
      "name": "gaa",
      "cmd": "git add --all"
    },
    {
      "category": "General",
      "name": "gap",
      "cmd": "git add -p"
    },
    {
      "category": "General",
      "name": "gau",
      "cmd": "git add -u"
    },
    {
      "category": "General",
      "name": "gaf",
      "cmd": "git add -f"
    },
    {
      "category": "General",
      "name": "gc",
      "cmd": "git commit -v"
    },
    {
      "category": "General",
      "name": "gcm",
      "cmd": "git commit -m"
    },
    {
      "category": "General",
      "name": "gca",
      "cmd": "git commit --amend"
    },
    {
      "category": "General",
      "name": "gcan",
      "cmd": "git commit --amend --no-edit"
    },
    {
      "category": "General",
      "name": "gcas",
      "cmd": "git commit --amend --squash"
    },
    {
      "category": "General",
      "name": "gcf",
      "cmd": "git commit --fixup"
    },
    {
      "category": "General",
      "name": "gcs",
      "cmd": "git commit -S"
    },
    {
      "category": "General",
      "name": "gb",
      "cmd": "git branch"
    },
    {
      "category": "General",
      "name": "gba",
      "cmd": "git branch -a"
    },
    {
      "category": "General",
      "name": "gbr",
      "cmd": "git branch -r"
    },
    {
      "category": "General",
      "name": "gbd",
      "cmd": "git branch -d"
    },
    {
      "category": "General",
      "name": "gbD",
      "cmd": "git branch -D"
    },
    {
      "category": "General",
      "name": "gbm",
      "cmd": "git branch -m"
    },
    {
      "category": "General",
      "name": "gbsort",
      "cmd": "git branch --sort=-committerdate"
    },
    {
      "category": "General",
      "name": "gbclean",
      "cmd": "git branch --merged | grep -v \"\\*\\|main\\|master\\|develop\" | xargs -r git branch -d"
    },
    {
      "category": "General",
      "name": "gco",
      "cmd": "git checkout"
    },
    {
      "category": "General",
      "name": "gcob",
      "cmd": "git checkout -b"
    },
    {
      "category": "General",
      "name": "gcop",
      "cmd": "git checkout -p"
    },
    {
      "category": "General",
      "name": "gsw",
      "cmd": "git switch"
    },
    {
      "category": "General",
      "name": "gswc",
      "cmd": "git switch -c"
    },
    {
      "category": "General",
      "name": "gswm",
      "cmd": "git switch main 2>/dev/null || git switch master"
    },
    {
      "category": "General",
      "name": "gd",
      "cmd": "git diff"
    },
    {
      "category": "General",
      "name": "gds",
      "cmd": "git diff --staged"
    },
    {
      "category": "General",
      "name": "gdc",
      "cmd": "git diff --cached"
    },
    {
      "category": "General",
      "name": "gdw",
      "cmd": "git diff --word-diff"
    },
    {
      "category": "General",
      "name": "gdn",
      "cmd": "git diff --name-only"
    },
    {
      "category": "General",
      "name": "gdstat",
      "cmd": "git diff --stat"
    },
    {
      "category": "General",
      "name": "gf",
      "cmd": "git fetch"
    },
    {
      "category": "General",
      "name": "gfa",
      "cmd": "git fetch --all --prune"
    },
    {
      "category": "General",
      "name": "gpl",
      "cmd": "git pull"
    },
    {
      "category": "General",
      "name": "gplr",
      "cmd": "git pull --rebase"
    },
    {
      "category": "General",
      "name": "gpla",
      "cmd": "git pull --all"
    },
    {
      "category": "General",
      "name": "gp",
      "cmd": "git push"
    },
    {
      "category": "General",
      "name": "gpf",
      "cmd": "git push --force-with-lease"
    },
    {
      "category": "General",
      "name": "gpt",
      "cmd": "git push --tags"
    },
    {
      "category": "General",
      "name": "gpu",
      "cmd": "git push -u origin HEAD"
    },
    {
      "category": "General",
      "name": "gpd",
      "cmd": "git push --dry-run"
    },
    {
      "category": "General",
      "name": "gg",
      "cmd": "git log --oneline --graph --decorate"
    },
    {
      "category": "General",
      "name": "gga",
      "cmd": "git log --oneline --graph --all --decorate"
    },
    {
      "category": "General",
      "name": "ggl",
      "cmd": "git log --graph --pretty=\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\""
    },
    {
      "category": "General",
      "name": "ggla",
      "cmd": "git log --graph --pretty=\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\" --all"
    },
    {
      "category": "General",
      "name": "gls",
      "cmd": "git log --stat"
    },
    {
      "category": "General",
      "name": "gll",
      "cmd": "git log --pretty=fuller"
    },
    {
      "category": "General",
      "name": "glp",
      "cmd": "git log --patch"
    },
    {
      "category": "General",
      "name": "glf",
      "cmd": "git log --follow -p"
    },
    {
      "category": "General",
      "name": "gwho",
      "cmd": "git shortlog -sn --all --no-merges"
    },
    {
      "category": "General",
      "name": "gr",
      "cmd": "git rebase"
    },
    {
      "category": "General",
      "name": "gri",
      "cmd": "git rebase -i"
    },
    {
      "category": "General",
      "name": "grim",
      "cmd": "git rebase -i origin/main"
    },
    {
      "category": "General",
      "name": "grih",
      "cmd": "git rebase -i HEAD~"
    },
    {
      "category": "General",
      "name": "gra",
      "cmd": "git rebase --abort"
    },
    {
      "category": "General",
      "name": "grc",
      "cmd": "git rebase --continue"
    },
    {
      "category": "General",
      "name": "grs",
      "cmd": "git rebase --skip"
    },
    {
      "category": "General",
      "name": "gm",
      "cmd": "git merge"
    },
    {
      "category": "General",
      "name": "gma",
      "cmd": "git merge --abort"
    },
    {
      "category": "General",
      "name": "gmc",
      "cmd": "git merge --continue"
    },
    {
      "category": "General",
      "name": "gmff",
      "cmd": "git merge --ff-only"
    },
    {
      "category": "General",
      "name": "gmnff",
      "cmd": "git merge --no-ff"
    },
    {
      "category": "General",
      "name": "gmsq",
      "cmd": "git merge --squash"
    },
    {
      "category": "General",
      "name": "gcpa",
      "cmd": "git cherry-pick --abort"
    },
    {
      "category": "General",
      "name": "gcpc",
      "cmd": "git cherry-pick --continue"
    },
    {
      "category": "General",
      "name": "gh",
      "cmd": "git stash"
    },
    {
      "category": "General",
      "name": "ghs",
      "cmd": "git stash show -p"
    },
    {
      "category": "General",
      "name": "ghp",
      "cmd": "git stash pop"
    },
    {
      "category": "General",
      "name": "gha",
      "cmd": "git stash apply"
    },
    {
      "category": "General",
      "name": "ghd",
      "cmd": "git stash drop"
    },
    {
      "category": "General",
      "name": "ghl",
      "cmd": "git stash list"
    },
    {
      "category": "General",
      "name": "ghcl",
      "cmd": "git stash clear"
    },
    {
      "category": "General",
      "name": "gre",
      "cmd": "git reset"
    },
    {
      "category": "General",
      "name": "greh",
      "cmd": "git reset HEAD"
    },
    {
      "category": "General",
      "name": "grehh",
      "cmd": "git reset --hard HEAD"
    },
    {
      "category": "General",
      "name": "grehs",
      "cmd": "git reset --soft HEAD~1"
    },
    {
      "category": "General",
      "name": "gundo",
      "cmd": "git reset --soft HEAD~1"
    },
    {
      "category": "General",
      "name": "gnuke",
      "cmd": "git reset --hard && git clean -fd"
    },
    {
      "category": "General",
      "name": "grm",
      "cmd": "git remote"
    },
    {
      "category": "General",
      "name": "grma",
      "cmd": "git remote add"
    },
    {
      "category": "General",
      "name": "grmr",
      "cmd": "git remote remove"
    },
    {
      "category": "General",
      "name": "grmv",
      "cmd": "git remote -v"
    },
    {
      "category": "General",
      "name": "grmu",
      "cmd": "git remote set-url"
    },
    {
      "category": "General",
      "name": "gt",
      "cmd": "git tag"
    },
    {
      "category": "General",
      "name": "gta",
      "cmd": "git tag -a"
    },
    {
      "category": "General",
      "name": "gtd",
      "cmd": "git tag -d"
    },
    {
      "category": "General",
      "name": "gtl",
      "cmd": "git tag -l"
    },
    {
      "category": "General",
      "name": "gtp",
      "cmd": "git push --tags"
    },
    {
      "category": "General",
      "name": "gw",
      "cmd": "git worktree"
    },
    {
      "category": "General",
      "name": "gwl",
      "cmd": "git worktree list"
    },
    {
      "category": "General",
      "name": "gwa",
      "cmd": "git worktree add"
    },
    {
      "category": "General",
      "name": "gwd",
      "cmd": "git worktree remove"
    },
    {
      "category": "General",
      "name": "gsm",
      "cmd": "git submodule"
    },
    {
      "category": "General",
      "name": "gsmu",
      "cmd": "git submodule update --init --recursive"
    },
    {
      "category": "General",
      "name": "gsms",
      "cmd": "git submodule sync"
    },
    {
      "category": "General",
      "name": "gbis",
      "cmd": "git bisect"
    },
    {
      "category": "General",
      "name": "gbisr",
      "cmd": "git bisect reset"
    },
    {
      "category": "General",
      "name": "gbiss",
      "cmd": "git bisect start"
    },
    {
      "category": "General",
      "name": "gbisb",
      "cmd": "git bisect bad"
    },
    {
      "category": "General",
      "name": "gbisg",
      "cmd": "git bisect good"
    },
    {
      "category": "General",
      "name": "gref",
      "cmd": "git reflog"
    },
    {
      "category": "General",
      "name": "grefl",
      "cmd": "git reflog expire --expire=now --all"
    },
    {
      "category": "General",
      "name": "gcln",
      "cmd": "git clean -fd"
    },
    {
      "category": "General",
      "name": "gclnx",
      "cmd": "git clean -fdx"
    },
    {
      "category": "General",
      "name": "gig",
      "cmd": "git ls-files --others --exclude-standard"
    },
    {
      "category": "General",
      "name": "gsig",
      "cmd": "git verify-commit HEAD"
    },
    {
      "category": "General",
      "name": "groot",
      "cmd": "git rev-parse --show-toplevel"
    },
    {
      "category": "General",
      "name": "gcount",
      "cmd": "git rev-list --count HEAD"
    },
    {
      "category": "General",
      "name": "gsize",
      "cmd": "git count-objects -vH"
    },
    {
      "category": "General",
      "name": "gfix",
      "cmd": "git add -A && git commit --amend --no-edit"
    },
    {
      "category": "General",
      "name": "glazyg",
      "cmd": "git add . && git commit -m"
    },
    {
      "category": "General",
      "name": "d",
      "cmd": "docker"
    },
    {
      "category": "General",
      "name": "dv",
      "cmd": "docker version"
    },
    {
      "category": "General",
      "name": "di",
      "cmd": "docker images"
    },
    {
      "category": "General",
      "name": "dia",
      "cmd": "docker images -a"
    },
    {
      "category": "General",
      "name": "dirm",
      "cmd": "docker image rm"
    },
    {
      "category": "General",
      "name": "diprune",
      "cmd": "docker image prune"
    },
    {
      "category": "General",
      "name": "dps",
      "cmd": "docker ps"
    },
    {
      "category": "General",
      "name": "dpsa",
      "cmd": "docker ps -a"
    },
    {
      "category": "General",
      "name": "drun",
      "cmd": "docker run -it --rm"
    },
    {
      "category": "General",
      "name": "drunit",
      "cmd": "docker run -it"
    },
    {
      "category": "General",
      "name": "dstart",
      "cmd": "docker start"
    },
    {
      "category": "General",
      "name": "dstop",
      "cmd": "docker stop"
    },
    {
      "category": "General",
      "name": "drestart",
      "cmd": "docker restart"
    },
    {
      "category": "General",
      "name": "drm",
      "cmd": "docker rm"
    },
    {
      "category": "General",
      "name": "drmf",
      "cmd": "docker rm -f"
    },
    {
      "category": "General",
      "name": "dex",
      "cmd": "docker exec -it"
    },
    {
      "category": "General",
      "name": "dlog",
      "cmd": "docker logs -f"
    },
    {
      "category": "General",
      "name": "dlogs",
      "cmd": "docker logs"
    },
    {
      "category": "General",
      "name": "dinsp",
      "cmd": "docker inspect"
    },
    {
      "category": "General",
      "name": "dcp",
      "cmd": "docker cp"
    },
    {
      "category": "General",
      "name": "dbuild",
      "cmd": "docker build -t"
    },
    {
      "category": "General",
      "name": "dpull",
      "cmd": "docker pull"
    },
    {
      "category": "General",
      "name": "dpush",
      "cmd": "docker push"
    },
    {
      "category": "General",
      "name": "dnet",
      "cmd": "docker network ls"
    },
    {
      "category": "General",
      "name": "dneta",
      "cmd": "docker network inspect"
    },
    {
      "category": "General",
      "name": "dvol",
      "cmd": "docker volume ls"
    },
    {
      "category": "General",
      "name": "dvola",
      "cmd": "docker volume inspect"
    },
    {
      "category": "General",
      "name": "dprune",
      "cmd": "docker system prune -af"
    },
    {
      "category": "General",
      "name": "dvprune",
      "cmd": "docker volume prune -f"
    },
    {
      "category": "General",
      "name": "dnprune",
      "cmd": "docker network prune -f"
    },
    {
      "category": "General",
      "name": "dcprune",
      "cmd": "docker container prune -f"
    },
    {
      "category": "General",
      "name": "dstats",
      "cmd": "docker stats --format \"table {{.Name}}\\t{{.CPUPerc}}\\t{{.MemUsage}}\\t{{.NetIO}}\""
    },
    {
      "category": "General",
      "name": "dtop",
      "cmd": "docker stats --no-stream"
    },
    {
      "category": "General",
      "name": "dip",
      "cmd": "docker inspect --format \"{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}\""
    },
    {
      "category": "General",
      "name": "dc",
      "cmd": "docker compose"
    },
    {
      "category": "General",
      "name": "dco",
      "cmd": "docker-compose"
    },
    {
      "category": "General",
      "name": "dcu",
      "cmd": "docker compose up -d"
    },
    {
      "category": "General",
      "name": "dcud",
      "cmd": "docker compose up"
    },
    {
      "category": "General",
      "name": "dcd",
      "cmd": "docker compose down"
    },
    {
      "category": "General",
      "name": "dcdv",
      "cmd": "docker compose down -v"
    },
    {
      "category": "General",
      "name": "dcr",
      "cmd": "docker compose restart"
    },
    {
      "category": "General",
      "name": "dcb",
      "cmd": "docker compose build"
    },
    {
      "category": "General",
      "name": "dcl",
      "cmd": "docker compose logs -f"
    },
    {
      "category": "General",
      "name": "dce",
      "cmd": "docker compose exec"
    },
    {
      "category": "General",
      "name": "dcp2",
      "cmd": "docker compose pull"
    },
    {
      "category": "General",
      "name": "dcps",
      "cmd": "docker compose ps"
    },
    {
      "category": "General",
      "name": "dcconfig",
      "cmd": "docker compose config"
    },
    {
      "category": "General",
      "name": "k",
      "cmd": "kubectl"
    },
    {
      "category": "General",
      "name": "kv",
      "cmd": "kubectl version"
    },
    {
      "category": "General",
      "name": "kctx",
      "cmd": "kubectl config use-context"
    },
    {
      "category": "General",
      "name": "kns",
      "cmd": "kubectl config set-context --current --namespace"
    },
    {
      "category": "General",
      "name": "kgctx",
      "cmd": "kubectl config get-contexts"
    },
    {
      "category": "General",
      "name": "kccfg",
      "cmd": "kubectl config view"
    },
    {
      "category": "General",
      "name": "kg",
      "cmd": "kubectl get"
    },
    {
      "category": "General",
      "name": "kgp",
      "cmd": "kubectl get pods"
    },
    {
      "category": "General",
      "name": "kgpa",
      "cmd": "kubectl get pods -A"
    },
    {
      "category": "General",
      "name": "kgd",
      "cmd": "kubectl get deployments"
    },
    {
      "category": "General",
      "name": "kgda",
      "cmd": "kubectl get deployments -A"
    },
    {
      "category": "General",
      "name": "kgs",
      "cmd": "kubectl get svc"
    },
    {
      "category": "General",
      "name": "kgsa",
      "cmd": "kubectl get svc -A"
    },
    {
      "category": "General",
      "name": "kgi",
      "cmd": "kubectl get ingress"
    },
    {
      "category": "General",
      "name": "kgn",
      "cmd": "kubectl get nodes"
    },
    {
      "category": "General",
      "name": "kgno",
      "cmd": "kubectl get nodes -o wide"
    },
    {
      "category": "General",
      "name": "kgcm",
      "cmd": "kubectl get configmap"
    },
    {
      "category": "General",
      "name": "kgsec",
      "cmd": "kubectl get secret"
    },
    {
      "category": "General",
      "name": "kgpv",
      "cmd": "kubectl get pv"
    },
    {
      "category": "General",
      "name": "kgpvc",
      "cmd": "kubectl get pvc"
    },
    {
      "category": "General",
      "name": "kgns",
      "cmd": "kubectl get namespace"
    },
    {
      "category": "General",
      "name": "kga",
      "cmd": "kubectl get all"
    },
    {
      "category": "General",
      "name": "kgaa",
      "cmd": "kubectl get all -A"
    },
    {
      "category": "General",
      "name": "kgcj",
      "cmd": "kubectl get cronjob"
    },
    {
      "category": "General",
      "name": "kgj",
      "cmd": "kubectl get job"
    },
    {
      "category": "General",
      "name": "kgrs",
      "cmd": "kubectl get replicaset"
    },
    {
      "category": "General",
      "name": "kgss",
      "cmd": "kubectl get statefulset"
    },
    {
      "category": "General",
      "name": "kgds",
      "cmd": "kubectl get daemonset"
    },
    {
      "category": "General",
      "name": "kghpa",
      "cmd": "kubectl get hpa"
    },
    {
      "category": "General",
      "name": "kd",
      "cmd": "kubectl describe"
    },
    {
      "category": "General",
      "name": "kdp",
      "cmd": "kubectl describe pod"
    },
    {
      "category": "General",
      "name": "kdd",
      "cmd": "kubectl describe deployment"
    },
    {
      "category": "General",
      "name": "kds",
      "cmd": "kubectl describe svc"
    },
    {
      "category": "General",
      "name": "kdn",
      "cmd": "kubectl describe node"
    },
    {
      "category": "General",
      "name": "ka",
      "cmd": "kubectl apply -f"
    },
    {
      "category": "General",
      "name": "kar",
      "cmd": "kubectl apply -R -f"
    },
    {
      "category": "General",
      "name": "kc",
      "cmd": "kubectl create"
    },
    {
      "category": "General",
      "name": "kdel",
      "cmd": "kubectl delete"
    },
    {
      "category": "General",
      "name": "kdelp",
      "cmd": "kubectl delete pod"
    },
    {
      "category": "General",
      "name": "kdeld",
      "cmd": "kubectl delete deployment"
    },
    {
      "category": "General",
      "name": "kl",
      "cmd": "kubectl logs -f"
    },
    {
      "category": "General",
      "name": "kla",
      "cmd": "kubectl logs -f --all-containers"
    },
    {
      "category": "General",
      "name": "klp",
      "cmd": "kubectl logs -f --previous"
    },
    {
      "category": "General",
      "name": "kex",
      "cmd": "kubectl exec -it"
    },
    {
      "category": "General",
      "name": "kpf",
      "cmd": "kubectl port-forward"
    },
    {
      "category": "General",
      "name": "ksc",
      "cmd": "kubectl scale"
    },
    {
      "category": "General",
      "name": "kro",
      "cmd": "kubectl rollout"
    },
    {
      "category": "General",
      "name": "kros",
      "cmd": "kubectl rollout status"
    },
    {
      "category": "General",
      "name": "kroh",
      "cmd": "kubectl rollout history"
    },
    {
      "category": "General",
      "name": "krou",
      "cmd": "kubectl rollout undo"
    },
    {
      "category": "General",
      "name": "ktop",
      "cmd": "kubectl top"
    },
    {
      "category": "General",
      "name": "ktopp",
      "cmd": "kubectl top pod"
    },
    {
      "category": "General",
      "name": "ktonn",
      "cmd": "kubectl top node"
    },
    {
      "category": "General",
      "name": "krun",
      "cmd": "kubectl run -it --rm --image"
    },
    {
      "category": "General",
      "name": "kcurl",
      "cmd": "kubectl run curl-test --image=curlimages/curl -it --rm --"
    },
    {
      "category": "General",
      "name": "kdrain",
      "cmd": "kubectl drain --ignore-daemonsets --delete-emptydir-data"
    },
    {
      "category": "General",
      "name": "kuncordon",
      "cmd": "kubectl uncordon"
    },
    {
      "category": "General",
      "name": "kcordon",
      "cmd": "kubectl cordon"
    },
    {
      "category": "General",
      "name": "ktaint",
      "cmd": "kubectl taint"
    },
    {
      "category": "General",
      "name": "tf",
      "cmd": "terraform"
    },
    {
      "category": "General",
      "name": "tfi",
      "cmd": "terraform init"
    },
    {
      "category": "General",
      "name": "tfiu",
      "cmd": "terraform init -upgrade"
    },
    {
      "category": "General",
      "name": "tfp",
      "cmd": "terraform plan"
    },
    {
      "category": "General",
      "name": "tfpa",
      "cmd": "terraform plan -out=tfplan"
    },
    {
      "category": "General",
      "name": "tfa",
      "cmd": "terraform apply"
    },
    {
      "category": "General",
      "name": "tfaa",
      "cmd": "terraform apply -auto-approve"
    },
    {
      "category": "General",
      "name": "tfd",
      "cmd": "terraform destroy"
    },
    {
      "category": "General",
      "name": "tfda",
      "cmd": "terraform destroy -auto-approve"
    },
    {
      "category": "General",
      "name": "tfv",
      "cmd": "terraform validate"
    },
    {
      "category": "General",
      "name": "tff",
      "cmd": "terraform fmt"
    },
    {
      "category": "General",
      "name": "tffr",
      "cmd": "terraform fmt -recursive"
    },
    {
      "category": "General",
      "name": "tfs",
      "cmd": "terraform show"
    },
    {
      "category": "General",
      "name": "tfo",
      "cmd": "terraform output"
    },
    {
      "category": "General",
      "name": "tfstate",
      "cmd": "terraform state"
    },
    {
      "category": "General",
      "name": "tfsl",
      "cmd": "terraform state list"
    },
    {
      "category": "General",
      "name": "tfsshow",
      "cmd": "terraform state show"
    },
    {
      "category": "General",
      "name": "tfg",
      "cmd": "terraform graph | dot -Tpng > graph.png"
    },
    {
      "category": "General",
      "name": "tfwl",
      "cmd": "terraform workspace list"
    },
    {
      "category": "General",
      "name": "tfwn",
      "cmd": "terraform workspace new"
    },
    {
      "category": "General",
      "name": "tfws",
      "cmd": "terraform workspace select"
    },
    {
      "category": "General",
      "name": "tfimport",
      "cmd": "terraform import"
    },
    {
      "category": "General",
      "name": "tftaint",
      "cmd": "terraform taint"
    },
    {
      "category": "General",
      "name": "tfuntaint",
      "cmd": "terraform untaint"
    },
    {
      "category": "General",
      "name": "tfdoc",
      "cmd": "terraform-docs markdown . 2>/dev/null"
    },
    {
      "category": "General",
      "name": "hls",
      "cmd": "helm list"
    },
    {
      "category": "General",
      "name": "hlsa",
      "cmd": "helm list -A"
    },
    {
      "category": "General",
      "name": "hin",
      "cmd": "helm install"
    },
    {
      "category": "General",
      "name": "hup",
      "cmd": "helm upgrade"
    },
    {
      "category": "General",
      "name": "hupi",
      "cmd": "helm upgrade --install"
    },
    {
      "category": "General",
      "name": "hdel",
      "cmd": "helm uninstall"
    },
    {
      "category": "General",
      "name": "hsr",
      "cmd": "helm search repo"
    },
    {
      "category": "General",
      "name": "hsh",
      "cmd": "helm search hub"
    },
    {
      "category": "General",
      "name": "hre",
      "cmd": "helm repo"
    },
    {
      "category": "General",
      "name": "hrea",
      "cmd": "helm repo add"
    },
    {
      "category": "General",
      "name": "hreu",
      "cmd": "helm repo update"
    },
    {
      "category": "General",
      "name": "hrel",
      "cmd": "helm repo list"
    },
    {
      "category": "General",
      "name": "hstat",
      "cmd": "helm status"
    },
    {
      "category": "General",
      "name": "hhist",
      "cmd": "helm history"
    },
    {
      "category": "General",
      "name": "hroll",
      "cmd": "helm rollback"
    },
    {
      "category": "General",
      "name": "hget",
      "cmd": "helm get"
    },
    {
      "category": "General",
      "name": "hgetv",
      "cmd": "helm get values"
    },
    {
      "category": "General",
      "name": "hgetn",
      "cmd": "helm get notes"
    },
    {
      "category": "General",
      "name": "htp",
      "cmd": "helm template"
    },
    {
      "category": "General",
      "name": "hlint",
      "cmd": "helm lint"
    },
    {
      "category": "General",
      "name": "hdry",
      "cmd": "helm install --dry-run --debug"
    },
    {
      "category": "General",
      "name": "henv",
      "cmd": "helm env"
    },
    {
      "category": "General",
      "name": "ans",
      "cmd": "ansible"
    },
    {
      "category": "General",
      "name": "ansplay",
      "cmd": "ansible-playbook"
    },
    {
      "category": "General",
      "name": "ansinv",
      "cmd": "ansible-inventory"
    },
    {
      "category": "General",
      "name": "anscheck",
      "cmd": "ansible-playbook --check"
    },
    {
      "category": "General",
      "name": "ansdiff",
      "cmd": "ansible-playbook --check --diff"
    },
    {
      "category": "General",
      "name": "ansvault",
      "cmd": "ansible-vault"
    },
    {
      "category": "General",
      "name": "ansenc",
      "cmd": "ansible-vault encrypt"
    },
    {
      "category": "General",
      "name": "ansdec",
      "cmd": "ansible-vault decrypt"
    },
    {
      "category": "General",
      "name": "ansgalaxy",
      "cmd": "ansible-galaxy"
    },
    {
      "category": "General",
      "name": "ansping",
      "cmd": "ansible all -m ping"
    },
    {
      "category": "General",
      "name": "ansfacts",
      "cmd": "ansible all -m setup"
    },
    {
      "category": "General",
      "name": "fastping",
      "cmd": "ping -c 100 -s.2"
    },
    {
      "category": "General",
      "name": "ping6",
      "cmd": "ping6 -c 5"
    },
    {
      "category": "General",
      "name": "tracert",
      "cmd": "traceroute"
    },
    {
      "category": "General",
      "name": "myip",
      "cmd": "curl -4s ifconfig.me && echo"
    },
    {
      "category": "General",
      "name": "myip6",
      "cmd": "curl -6s ifconfig.me && echo"
    },
    {
      "category": "General",
      "name": "myips",
      "cmd": "ip -br addr"
    },
    {
      "category": "General",
      "name": "ipl",
      "cmd": "ip -br link"
    },
    {
      "category": "General",
      "name": "ipa",
      "cmd": "ip -br addr"
    },
    {
      "category": "General",
      "name": "ipr",
      "cmd": "ip route"
    },
    {
      "category": "General",
      "name": "ipn",
      "cmd": "ip neigh"
    },
    {
      "category": "General",
      "name": "ipstats",
      "cmd": "ip -s link"
    },
    {
      "category": "General",
      "name": "ports",
      "cmd": "ss -tulanp"
    },
    {
      "category": "General",
      "name": "listening",
      "cmd": "ss -tlnp"
    },
    {
      "category": "General",
      "name": "established",
      "cmd": "ss -tnp state established"
    },
    {
      "category": "General",
      "name": "portcheck",
      "cmd": "nc -zv"
    },
    {
      "category": "General",
      "name": "curl",
      "cmd": "curl -L --retry 3"
    },
    {
      "category": "General",
      "name": "httpd",
      "cmd": "python3 -m http.server"
    },
    {
      "category": "General",
      "name": "dig",
      "cmd": "dog"
    },
    {
      "category": "General",
      "name": "nsl",
      "cmd": "nslookup"
    },
    {
      "category": "General",
      "name": "digany",
      "cmd": "dig +nocmd any +multiline +noall +answer"
    },
    {
      "category": "General",
      "name": "digtrace",
      "cmd": "dig +trace"
    },
    {
      "category": "General",
      "name": "digshort",
      "cmd": "dig +short"
    },
    {
      "category": "General",
      "name": "flushDNS",
      "cmd": "sudo resolvectl flush-caches 2>/dev/null || sudo systemd-resolve --flush-caches 2>/dev/null || sudo dscacheutil -flushcache 2>/dev/null"
    },
    {
      "category": "General",
      "name": "ssha",
      "cmd": "ssh-add"
    },
    {
      "category": "General",
      "name": "sshl",
      "cmd": "ssh-add -l"
    },
    {
      "category": "General",
      "name": "sshD",
      "cmd": "ssh-add -D"
    },
    {
      "category": "General",
      "name": "sshk",
      "cmd": "ssh-keyscan"
    },
    {
      "category": "General",
      "name": "sshfp",
      "cmd": "ssh-keygen -lf"
    },
    {
      "category": "General",
      "name": "sshcopy",
      "cmd": "ssh-copy-id"
    },
    {
      "category": "General",
      "name": "sshrm",
      "cmd": "ssh-keygen -R"
    },
    {
      "category": "General",
      "name": "sshconfig",
      "cmd": "$EDITOR ~/.ssh/config"
    },
    {
      "category": "General",
      "name": "fwstatus",
      "cmd": "sudo ufw status verbose 2>/dev/null || sudo iptables -L -n -v 2>/dev/null"
    },
    {
      "category": "General",
      "name": "fwenable",
      "cmd": "sudo ufw enable"
    },
    {
      "category": "General",
      "name": "fwdisable",
      "cmd": "sudo ufw disable"
    },
    {
      "category": "General",
      "name": "fwall",
      "cmd": "sudo ufw allow"
    },
    {
      "category": "General",
      "name": "fwdeny",
      "cmd": "sudo ufw deny"
    },
    {
      "category": "General",
      "name": "sslcheck",
      "cmd": "openssl s_client -connect"
    },
    {
      "category": "General",
      "name": "sslcert",
      "cmd": "openssl x509 -noout -text -in"
    },
    {
      "category": "General",
      "name": "ssldate",
      "cmd": "openssl s_client -connect -servername </dev/null 2>/dev/null | openssl x509 -noout -dates"
    },
    {
      "category": "General",
      "name": "genkey",
      "cmd": "openssl genrsa -out"
    },
    {
      "category": "General",
      "name": "gencsr",
      "cmd": "openssl req -new -key"
    },
    {
      "category": "General",
      "name": "gpglist",
      "cmd": "gpg --list-keys"
    },
    {
      "category": "General",
      "name": "gpglistsec",
      "cmd": "gpg --list-secret-keys"
    },
    {
      "category": "General",
      "name": "gpgenc",
      "cmd": "gpg --encrypt --armor"
    },
    {
      "category": "General",
      "name": "gpgdec",
      "cmd": "gpg --decrypt"
    },
    {
      "category": "General",
      "name": "gpgsign",
      "cmd": "gpg --clearsign"
    },
    {
      "category": "General",
      "name": "gpgverify",
      "cmd": "gpg --verify"
    },
    {
      "category": "General",
      "name": "gpgimport",
      "cmd": "gpg --import"
    },
    {
      "category": "General",
      "name": "gpgexport",
      "cmd": "gpg --armor --export"
    },
    {
      "category": "General",
      "name": "gpgrecv",
      "cmd": "gpg --recv-keys"
    },
    {
      "category": "General",
      "name": "gpgsend",
      "cmd": "gpg --send-keys"
    },
    {
      "category": "General",
      "name": "gpgfp",
      "cmd": "gpg --fingerprint"
    },
    {
      "category": "General",
      "name": "nmap",
      "cmd": "nmap -v"
    },
    {
      "category": "General",
      "name": "nmapfast",
      "cmd": "nmap -T4 -F"
    },
    {
      "category": "General",
      "name": "nmapfull",
      "cmd": "nmap -T4 -A -v"
    },
    {
      "category": "General",
      "name": "nmapstealth",
      "cmd": "sudo nmap -sS -O"
    },
    {
      "category": "General",
      "name": "nmapudp",
      "cmd": "sudo nmap -sU"
    },
    {
      "category": "General",
      "name": "nmapvuln",
      "cmd": "nmap --script vuln"
    },
    {
      "category": "General",
      "name": "portscan",
      "cmd": "nmap -sV --version-intensity 5"
    },
    {
      "category": "General",
      "name": "sha256",
      "cmd": "sha256sum"
    },
    {
      "category": "General",
      "name": "sha512",
      "cmd": "sha512sum"
    },
    {
      "category": "General",
      "name": "md5",
      "cmd": "md5sum"
    },
    {
      "category": "General",
      "name": "checksum",
      "cmd": "sha256sum"
    },
    {
      "category": "General",
      "name": "srm",
      "cmd": "shred -u -z -n 3"
    },
    {
      "category": "General",
      "name": "sc",
      "cmd": "systemctl"
    },
    {
      "category": "General",
      "name": "scs",
      "cmd": "systemctl status"
    },
    {
      "category": "General",
      "name": "scst",
      "cmd": "systemctl start"
    },
    {
      "category": "General",
      "name": "scsp",
      "cmd": "systemctl stop"
    },
    {
      "category": "General",
      "name": "scena",
      "cmd": "systemctl enable"
    },
    {
      "category": "General",
      "name": "scenas",
      "cmd": "systemctl enable --now"
    },
    {
      "category": "General",
      "name": "scdis",
      "cmd": "systemctl disable"
    },
    {
      "category": "General",
      "name": "scdiss",
      "cmd": "systemctl disable --now"
    },
    {
      "category": "General",
      "name": "scl",
      "cmd": "systemctl list-units --type=service"
    },
    {
      "category": "General",
      "name": "scla",
      "cmd": "systemctl list-units --type=service --all"
    },
    {
      "category": "General",
      "name": "scfail",
      "cmd": "systemctl --failed"
    },
    {
      "category": "General",
      "name": "scedit",
      "cmd": "systemctl edit"
    },
    {
      "category": "General",
      "name": "sccat",
      "cmd": "systemctl cat"
    },
    {
      "category": "General",
      "name": "scdep",
      "cmd": "systemctl list-dependencies"
    },
    {
      "category": "General",
      "name": "scboot",
      "cmd": "systemctl list-units --type=service --state=running"
    },
    {
      "category": "General",
      "name": "jc",
      "cmd": "journalctl"
    },
    {
      "category": "General",
      "name": "jce",
      "cmd": "journalctl -xe"
    },
    {
      "category": "General",
      "name": "jcf",
      "cmd": "journalctl -f"
    },
    {
      "category": "General",
      "name": "jcu",
      "cmd": "journalctl -u"
    },
    {
      "category": "General",
      "name": "jcb",
      "cmd": "journalctl -b"
    },
    {
      "category": "General",
      "name": "jcp",
      "cmd": "journalctl -p err"
    },
    {
      "category": "General",
      "name": "jcn",
      "cmd": "journalctl -n 50"
    },
    {
      "category": "General",
      "name": "jcclear",
      "cmd": "sudo journalctl --vacuum-time=7d"
    },
    {
      "category": "General",
      "name": "rcs",
      "cmd": "rc-service"
    },
    {
      "category": "General",
      "name": "rcst",
      "cmd": "rc-service start"
    },
    {
      "category": "General",
      "name": "rcsp",
      "cmd": "rc-service stop"
    },
    {
      "category": "General",
      "name": "rcr",
      "cmd": "rc-service restart"
    },
    {
      "category": "General",
      "name": "rcu",
      "cmd": "rc-update"
    },
    {
      "category": "General",
      "name": "pac",
      "cmd": "sudo pacman"
    },
    {
      "category": "General",
      "name": "paci",
      "cmd": "sudo pacman -S --noconfirm"
    },
    {
      "category": "General",
      "name": "pacI",
      "cmd": "sudo pacman -S"
    },
    {
      "category": "General",
      "name": "pacr",
      "cmd": "sudo pacman -Rns"
    },
    {
      "category": "General",
      "name": "pacu",
      "cmd": "sudo pacman -Syu"
    },
    {
      "category": "General",
      "name": "pacs",
      "cmd": "pacman -Ss"
    },
    {
      "category": "General",
      "name": "pacl",
      "cmd": "pacman -Q"
    },
    {
      "category": "General",
      "name": "pacll",
      "cmd": "pacman -Qe"
    },
    {
      "category": "General",
      "name": "paclo",
      "cmd": "pacman -Qdtq"
    },
    {
      "category": "General",
      "name": "paclf",
      "cmd": "pacman -Ql"
    },
    {
      "category": "General",
      "name": "pacown",
      "cmd": "pacman -Qo"
    },
    {
      "category": "General",
      "name": "pacinfo",
      "cmd": "pacman -Qi"
    },
    {
      "category": "General",
      "name": "pacclean",
      "cmd": "sudo pacman -Rns $(pacman -Qdtq)"
    },
    {
      "category": "General",
      "name": "pacmirror",
      "cmd": "sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"
    },
    {
      "category": "General",
      "name": "packeys",
      "cmd": "sudo pacman-key --refresh-keys"
    },
    {
      "category": "General",
      "name": "y",
      "cmd": "yay"
    },
    {
      "category": "General",
      "name": "ys",
      "cmd": "yay -Ss"
    },
    {
      "category": "General",
      "name": "par",
      "cmd": "paru"
    },
    {
      "category": "General",
      "name": "paru",
      "cmd": "paru -Syu"
    },
    {
      "category": "General",
      "name": "apti",
      "cmd": "sudo apt-get install -y"
    },
    {
      "category": "General",
      "name": "aptI",
      "cmd": "sudo apt-get install"
    },
    {
      "category": "General",
      "name": "aptr",
      "cmd": "sudo apt-get remove -y"
    },
    {
      "category": "General",
      "name": "aptrm",
      "cmd": "sudo apt-get purge -y"
    },
    {
      "category": "General",
      "name": "aptu",
      "cmd": "sudo apt-get update && sudo apt-get upgrade -y"
    },
    {
      "category": "General",
      "name": "aptfu",
      "cmd": "sudo apt-get update && sudo apt-get full-upgrade -y"
    },
    {
      "category": "General",
      "name": "apts",
      "cmd": "apt-cache search"
    },
    {
      "category": "General",
      "name": "aptsh",
      "cmd": "apt-cache show"
    },
    {
      "category": "General",
      "name": "aptl",
      "cmd": "dpkg -l"
    },
    {
      "category": "General",
      "name": "aptll",
      "cmd": "apt list --installed 2>/dev/null"
    },
    {
      "category": "General",
      "name": "aptclean",
      "cmd": "sudo apt-get autoremove -y && sudo apt-get autoclean"
    },
    {
      "category": "General",
      "name": "aptfix",
      "cmd": "sudo apt-get install -f"
    },
    {
      "category": "General",
      "name": "aptheld",
      "cmd": "apt-mark showhold"
    },
    {
      "category": "General",
      "name": "apthold",
      "cmd": "sudo apt-mark hold"
    },
    {
      "category": "General",
      "name": "aptunhold",
      "cmd": "sudo apt-mark unhold"
    },
    {
      "category": "General",
      "name": "dnfi",
      "cmd": "sudo dnf install -y"
    },
    {
      "category": "General",
      "name": "dnfI",
      "cmd": "sudo dnf install"
    },
    {
      "category": "General",
      "name": "dnfr",
      "cmd": "sudo dnf remove -y"
    },
    {
      "category": "General",
      "name": "dnfu",
      "cmd": "sudo dnf upgrade -y"
    },
    {
      "category": "General",
      "name": "dnfs",
      "cmd": "dnf search"
    },
    {
      "category": "General",
      "name": "dnfl",
      "cmd": "dnf list installed"
    },
    {
      "category": "General",
      "name": "dnfc",
      "cmd": "sudo dnf clean all"
    },
    {
      "category": "General",
      "name": "dnfh",
      "cmd": "dnf history"
    },
    {
      "category": "General",
      "name": "dnfinfo",
      "cmd": "dnf info"
    },
    {
      "category": "General",
      "name": "dnfgrp",
      "cmd": "dnf grouplist"
    },
    {
      "category": "General",
      "name": "dnfcheck",
      "cmd": "dnf check-update"
    },
    {
      "category": "General",
      "name": "yumi",
      "cmd": "sudo yum install -y"
    },
    {
      "category": "General",
      "name": "yumr",
      "cmd": "sudo yum remove -y"
    },
    {
      "category": "General",
      "name": "yumu",
      "cmd": "sudo yum update -y"
    },
    {
      "category": "General",
      "name": "yums",
      "cmd": "yum search"
    },
    {
      "category": "General",
      "name": "yuml",
      "cmd": "yum list installed"
    },
    {
      "category": "General",
      "name": "zypi",
      "cmd": "sudo zypper install -y"
    },
    {
      "category": "General",
      "name": "zypr",
      "cmd": "sudo zypper remove -y"
    },
    {
      "category": "General",
      "name": "zypu",
      "cmd": "sudo zypper update -y"
    },
    {
      "category": "General",
      "name": "zypdu",
      "cmd": "sudo zypper dist-upgrade -y"
    },
    {
      "category": "General",
      "name": "zyps",
      "cmd": "zypper search"
    },
    {
      "category": "General",
      "name": "zypl",
      "cmd": "zypper packages --installed-only"
    },
    {
      "category": "General",
      "name": "zypc",
      "cmd": "sudo zypper clean"
    },
    {
      "category": "General",
      "name": "zypinfo",
      "cmd": "zypper info"
    },
    {
      "category": "General",
      "name": "xbpsi",
      "cmd": "sudo xbps-install -Sy"
    },
    {
      "category": "General",
      "name": "xbpsr",
      "cmd": "sudo xbps-remove -R"
    },
    {
      "category": "General",
      "name": "xbpsu",
      "cmd": "sudo xbps-install -Su"
    },
    {
      "category": "General",
      "name": "xbpss",
      "cmd": "xbps-query -Rs"
    },
    {
      "category": "General",
      "name": "xbpsl",
      "cmd": "xbps-query -l"
    },
    {
      "category": "General",
      "name": "xbpsc",
      "cmd": "sudo xbps-remove -O"
    },
    {
      "category": "General",
      "name": "apki",
      "cmd": "sudo apk add"
    },
    {
      "category": "General",
      "name": "apkr",
      "cmd": "sudo apk del"
    },
    {
      "category": "General",
      "name": "apku",
      "cmd": "sudo apk upgrade"
    },
    {
      "category": "General",
      "name": "apks",
      "cmd": "apk search"
    },
    {
      "category": "General",
      "name": "apkl",
      "cmd": "apk list --installed"
    },
    {
      "category": "General",
      "name": "apkinfo",
      "cmd": "apk info"
    },
    {
      "category": "General",
      "name": "emeri",
      "cmd": "sudo emerge -av"
    },
    {
      "category": "General",
      "name": "emerr",
      "cmd": "sudo emerge --unmerge"
    },
    {
      "category": "General",
      "name": "emeru",
      "cmd": "sudo emerge --update --deep --newuse @world"
    },
    {
      "category": "General",
      "name": "emers",
      "cmd": "emerge -s"
    },
    {
      "category": "General",
      "name": "emerc",
      "cmd": "sudo eclean-dist && sudo eclean-pkg"
    },
    {
      "category": "General",
      "name": "nixi",
      "cmd": "nix-env -iA"
    },
    {
      "category": "General",
      "name": "nixr",
      "cmd": "nix-env -e"
    },
    {
      "category": "General",
      "name": "nixu",
      "cmd": "nix-env -u"
    },
    {
      "category": "General",
      "name": "nixs",
      "cmd": "nix-env -qaP"
    },
    {
      "category": "General",
      "name": "nixl",
      "cmd": "nix-env -q"
    },
    {
      "category": "General",
      "name": "nixgc",
      "cmd": "nix-collect-garbage -d"
    },
    {
      "category": "General",
      "name": "nixrebuild",
      "cmd": "sudo nixos-rebuild switch"
    },
    {
      "category": "General",
      "name": "nixtest",
      "cmd": "sudo nixos-rebuild test"
    },
    {
      "category": "General",
      "name": "brewi",
      "cmd": "brew install"
    },
    {
      "category": "General",
      "name": "brewr",
      "cmd": "brew uninstall"
    },
    {
      "category": "General",
      "name": "brewu",
      "cmd": "brew update && brew upgrade"
    },
    {
      "category": "General",
      "name": "brews",
      "cmd": "brew search"
    },
    {
      "category": "General",
      "name": "brewl",
      "cmd": "brew list"
    },
    {
      "category": "General",
      "name": "brewinfo",
      "cmd": "brew info"
    },
    {
      "category": "General",
      "name": "brewc",
      "cmd": "brew cleanup"
    },
    {
      "category": "General",
      "name": "brewd",
      "cmd": "brew doctor"
    },
    {
      "category": "General",
      "name": "brewdep",
      "cmd": "brew deps --tree"
    },
    {
      "category": "General",
      "name": "brewcask",
      "cmd": "brew install --cask"
    },
    {
      "category": "General",
      "name": "brewcaskr",
      "cmd": "brew uninstall --cask"
    },
    {
      "category": "General",
      "name": "brewcasklist",
      "cmd": "brew list --cask"
    },
    {
      "category": "General",
      "name": "brewpin",
      "cmd": "brew pin"
    },
    {
      "category": "General",
      "name": "brewunpin",
      "cmd": "brew unpin"
    },
    {
      "category": "General",
      "name": "brewpinned",
      "cmd": "brew list --pinned"
    },
    {
      "category": "General",
      "name": "flati",
      "cmd": "flatpak install -y"
    },
    {
      "category": "General",
      "name": "flatr",
      "cmd": "flatpak uninstall -y"
    },
    {
      "category": "General",
      "name": "flatu",
      "cmd": "flatpak update -y"
    },
    {
      "category": "General",
      "name": "flats",
      "cmd": "flatpak search"
    },
    {
      "category": "General",
      "name": "flatl",
      "cmd": "flatpak list"
    },
    {
      "category": "General",
      "name": "flatrun",
      "cmd": "flatpak run"
    },
    {
      "category": "General",
      "name": "flatc",
      "cmd": "flatpak uninstall --unused -y"
    },
    {
      "category": "General",
      "name": "snapi",
      "cmd": "sudo snap install"
    },
    {
      "category": "General",
      "name": "snapr",
      "cmd": "sudo snap remove"
    },
    {
      "category": "General",
      "name": "snapu",
      "cmd": "sudo snap refresh"
    },
    {
      "category": "General",
      "name": "snaps",
      "cmd": "snap find"
    },
    {
      "category": "General",
      "name": "snapl",
      "cmd": "snap list"
    },
    {
      "category": "General",
      "name": "awswho",
      "cmd": "aws sts get-caller-identity"
    },
    {
      "category": "General",
      "name": "awsprofile",
      "cmd": "aws configure list"
    },
    {
      "category": "General",
      "name": "awsprofiles",
      "cmd": "aws configure list-profiles"
    },
    {
      "category": "General",
      "name": "awsregion",
      "cmd": "aws configure get region"
    },
    {
      "category": "General",
      "name": "awsec2",
      "cmd": "aws ec2 describe-instances"
    },
    {
      "category": "General",
      "name": "awss3",
      "cmd": "aws s3 ls"
    },
    {
      "category": "General",
      "name": "awss3cp",
      "cmd": "aws s3 cp"
    },
    {
      "category": "General",
      "name": "awss3sync",
      "cmd": "aws s3 sync"
    },
    {
      "category": "General",
      "name": "awseks",
      "cmd": "aws eks list-clusters"
    },
    {
      "category": "General",
      "name": "awslambda",
      "cmd": "aws lambda list-functions"
    },
    {
      "category": "General",
      "name": "awsrds",
      "cmd": "aws rds describe-db-instances"
    },
    {
      "category": "General",
      "name": "awslogs",
      "cmd": "aws logs describe-log-groups"
    },
    {
      "category": "General",
      "name": "awsiam",
      "cmd": "aws iam list-users"
    },
    {
      "category": "General",
      "name": "awscost",
      "cmd": "aws ce get-cost-and-usage"
    },
    {
      "category": "General",
      "name": "awssm",
      "cmd": "aws secretsmanager list-secrets"
    },
    {
      "category": "General",
      "name": "awsssm",
      "cmd": "aws ssm describe-parameters"
    },
    {
      "category": "General",
      "name": "awsecs",
      "cmd": "aws ecs list-clusters"
    },
    {
      "category": "General",
      "name": "gcp",
      "cmd": "gcloud"
    },
    {
      "category": "General",
      "name": "gcpwho",
      "cmd": "gcloud auth list"
    },
    {
      "category": "General",
      "name": "gcpproj",
      "cmd": "gcloud config get-value project"
    },
    {
      "category": "General",
      "name": "gcpprojs",
      "cmd": "gcloud projects list"
    },
    {
      "category": "General",
      "name": "gcpset",
      "cmd": "gcloud config set project"
    },
    {
      "category": "General",
      "name": "gcpvm",
      "cmd": "gcloud compute instances list"
    },
    {
      "category": "General",
      "name": "gcpgke",
      "cmd": "gcloud container clusters list"
    },
    {
      "category": "General",
      "name": "gcprun",
      "cmd": "gcloud run services list"
    },
    {
      "category": "General",
      "name": "azwho",
      "cmd": "az account show"
    },
    {
      "category": "General",
      "name": "azsub",
      "cmd": "az account list"
    },
    {
      "category": "General",
      "name": "azrg",
      "cmd": "az group list"
    },
    {
      "category": "General",
      "name": "azvm",
      "cmd": "az vm list"
    },
    {
      "category": "General",
      "name": "azaks",
      "cmd": "az aks list"
    },
    {
      "category": "General",
      "name": "py",
      "cmd": "python3"
    },
    {
      "category": "General",
      "name": "py2",
      "cmd": "python2"
    },
    {
      "category": "General",
      "name": "pip",
      "cmd": "pip3"
    },
    {
      "category": "General",
      "name": "pipi",
      "cmd": "pip3 install"
    },
    {
      "category": "General",
      "name": "pipiu",
      "cmd": "pip3 install --upgrade"
    },
    {
      "category": "General",
      "name": "pipun",
      "cmd": "pip3 uninstall -y"
    },
    {
      "category": "General",
      "name": "pipl",
      "cmd": "pip3 list"
    },
    {
      "category": "General",
      "name": "pipf",
      "cmd": "pip3 freeze"
    },
    {
      "category": "General",
      "name": "pipfr",
      "cmd": "pip3 freeze > requirements.txt"
    },
    {
      "category": "General",
      "name": "pipir",
      "cmd": "pip3 install -r requirements.txt"
    },
    {
      "category": "General",
      "name": "pipout",
      "cmd": "pip3 list --outdated"
    },
    {
      "category": "General",
      "name": "pipcheck",
      "cmd": "pip3 check"
    },
    {
      "category": "General",
      "name": "pipsec",
      "cmd": "pip3 audit 2>/dev/null || pip3 install pip-audit && pip-audit"
    },
    {
      "category": "General",
      "name": "venv",
      "cmd": "python3 -m venv"
    },
    {
      "category": "General",
      "name": "venva",
      "cmd": "source .venv/bin/activate"
    },
    {
      "category": "General",
      "name": "venvd",
      "cmd": "deactivate"
    },
    {
      "category": "General",
      "name": "mkvenv",
      "cmd": "python3 -m venv .venv && source .venv/bin/activate"
    },
    {
      "category": "General",
      "name": "uvi",
      "cmd": "uv pip install"
    },
    {
      "category": "General",
      "name": "uviu",
      "cmd": "uv pip install --upgrade"
    },
    {
      "category": "General",
      "name": "uvir",
      "cmd": "uv pip install -r requirements.txt"
    },
    {
      "category": "General",
      "name": "uvl",
      "cmd": "uv pip list"
    },
    {
      "category": "General",
      "name": "uvf",
      "cmd": "uv pip freeze"
    },
    {
      "category": "General",
      "name": "uvvenv",
      "cmd": "uv venv"
    },
    {
      "category": "General",
      "name": "uvrun",
      "cmd": "uv run"
    },
    {
      "category": "General",
      "name": "uvadd",
      "cmd": "uv add"
    },
    {
      "category": "General",
      "name": "uvrem",
      "cmd": "uv remove"
    },
    {
      "category": "General",
      "name": "uvsync",
      "cmd": "uv sync"
    },
    {
      "category": "General",
      "name": "uvlock",
      "cmd": "uv lock"
    },
    {
      "category": "General",
      "name": "po",
      "cmd": "poetry"
    },
    {
      "category": "General",
      "name": "poa",
      "cmd": "poetry add"
    },
    {
      "category": "General",
      "name": "poad",
      "cmd": "poetry add --group dev"
    },
    {
      "category": "General",
      "name": "poar",
      "cmd": "poetry add --group test"
    },
    {
      "category": "General",
      "name": "porm",
      "cmd": "poetry remove"
    },
    {
      "category": "General",
      "name": "pou",
      "cmd": "poetry update"
    },
    {
      "category": "General",
      "name": "poi",
      "cmd": "poetry install"
    },
    {
      "category": "General",
      "name": "por",
      "cmd": "poetry run"
    },
    {
      "category": "General",
      "name": "pos",
      "cmd": "poetry shell"
    },
    {
      "category": "General",
      "name": "pob",
      "cmd": "poetry build"
    },
    {
      "category": "General",
      "name": "popub",
      "cmd": "poetry publish"
    },
    {
      "category": "General",
      "name": "pock",
      "cmd": "poetry check"
    },
    {
      "category": "General",
      "name": "polock",
      "cmd": "poetry lock"
    },
    {
      "category": "General",
      "name": "poenv",
      "cmd": "poetry env info"
    },
    {
      "category": "General",
      "name": "poenvl",
      "cmd": "poetry env list"
    },
    {
      "category": "General",
      "name": "conl",
      "cmd": "conda env list"
    },
    {
      "category": "General",
      "name": "concr",
      "cmd": "conda create -n"
    },
    {
      "category": "General",
      "name": "conad",
      "cmd": "conda activate"
    },
    {
      "category": "General",
      "name": "conde",
      "cmd": "conda deactivate"
    },
    {
      "category": "General",
      "name": "conrm",
      "cmd": "conda env remove -n"
    },
    {
      "category": "General",
      "name": "coni",
      "cmd": "conda install"
    },
    {
      "category": "General",
      "name": "conu",
      "cmd": "conda update"
    },
    {
      "category": "General",
      "name": "cons",
      "cmd": "conda search"
    },
    {
      "category": "General",
      "name": "conex",
      "cmd": "conda export > environment.yml"
    },
    {
      "category": "General",
      "name": "confr",
      "cmd": "conda env create -f environment.yml"
    },
    {
      "category": "General",
      "name": "node",
      "cmd": "node"
    },
    {
      "category": "General",
      "name": "ni",
      "cmd": "npm install"
    },
    {
      "category": "General",
      "name": "nid",
      "cmd": "npm install --save-dev"
    },
    {
      "category": "General",
      "name": "nig",
      "cmd": "npm install -g"
    },
    {
      "category": "General",
      "name": "nrm",
      "cmd": "npm uninstall"
    },
    {
      "category": "General",
      "name": "nr",
      "cmd": "npm run"
    },
    {
      "category": "General",
      "name": "nrs",
      "cmd": "npm run start"
    },
    {
      "category": "General",
      "name": "nrd",
      "cmd": "npm run dev"
    },
    {
      "category": "General",
      "name": "nrb",
      "cmd": "npm run build"
    },
    {
      "category": "General",
      "name": "nrt",
      "cmd": "npm run test"
    },
    {
      "category": "General",
      "name": "nrl",
      "cmd": "npm run lint"
    },
    {
      "category": "General",
      "name": "nrf",
      "cmd": "npm run format"
    },
    {
      "category": "General",
      "name": "nrp",
      "cmd": "npm run preview"
    },
    {
      "category": "General",
      "name": "nu",
      "cmd": "npm update"
    },
    {
      "category": "General",
      "name": "nout",
      "cmd": "npm outdated"
    },
    {
      "category": "General",
      "name": "nls",
      "cmd": "npm list --depth=0"
    },
    {
      "category": "General",
      "name": "nlsg",
      "cmd": "npm list -g --depth=0"
    },
    {
      "category": "General",
      "name": "ninfo",
      "cmd": "npm info"
    },
    {
      "category": "General",
      "name": "naudit",
      "cmd": "npm audit"
    },
    {
      "category": "General",
      "name": "nfix",
      "cmd": "npm audit fix"
    },
    {
      "category": "General",
      "name": "ninit",
      "cmd": "npm init -y"
    },
    {
      "category": "General",
      "name": "nci",
      "cmd": "npm ci"
    },
    {
      "category": "General",
      "name": "ncache",
      "cmd": "npm cache clean --force"
    },
    {
      "category": "General",
      "name": "npx",
      "cmd": "npx --yes"
    },
    {
      "category": "General",
      "name": "ya",
      "cmd": "yarn add"
    },
    {
      "category": "General",
      "name": "yad",
      "cmd": "yarn add --dev"
    },
    {
      "category": "General",
      "name": "yrm",
      "cmd": "yarn remove"
    },
    {
      "category": "General",
      "name": "yr",
      "cmd": "yarn run"
    },
    {
      "category": "General",
      "name": "yrs",
      "cmd": "yarn start"
    },
    {
      "category": "General",
      "name": "yrd",
      "cmd": "yarn dev"
    },
    {
      "category": "General",
      "name": "yrb",
      "cmd": "yarn build"
    },
    {
      "category": "General",
      "name": "yrt",
      "cmd": "yarn test"
    },
    {
      "category": "General",
      "name": "yi",
      "cmd": "yarn install"
    },
    {
      "category": "General",
      "name": "yu",
      "cmd": "yarn upgrade"
    },
    {
      "category": "General",
      "name": "yout",
      "cmd": "yarn outdated"
    },
    {
      "category": "General",
      "name": "yls",
      "cmd": "yarn list --depth=0"
    },
    {
      "category": "General",
      "name": "pni",
      "cmd": "pnpm install"
    },
    {
      "category": "General",
      "name": "pna",
      "cmd": "pnpm add"
    },
    {
      "category": "General",
      "name": "pnad",
      "cmd": "pnpm add --save-dev"
    },
    {
      "category": "General",
      "name": "pnrm",
      "cmd": "pnpm remove"
    },
    {
      "category": "General",
      "name": "pnr",
      "cmd": "pnpm run"
    },
    {
      "category": "General",
      "name": "pnd",
      "cmd": "pnpm dev"
    },
    {
      "category": "General",
      "name": "pnb",
      "cmd": "pnpm build"
    },
    {
      "category": "General",
      "name": "pnt",
      "cmd": "pnpm test"
    },
    {
      "category": "General",
      "name": "pnu",
      "cmd": "pnpm update"
    },
    {
      "category": "General",
      "name": "pnls",
      "cmd": "pnpm list"
    },
    {
      "category": "General",
      "name": "pnx",
      "cmd": "pnpm dlx"
    },
    {
      "category": "General",
      "name": "bi",
      "cmd": "bun install"
    },
    {
      "category": "General",
      "name": "ba",
      "cmd": "bun add"
    },
    {
      "category": "General",
      "name": "bad",
      "cmd": "bun add --dev"
    },
    {
      "category": "General",
      "name": "brm",
      "cmd": "bun remove"
    },
    {
      "category": "General",
      "name": "brun",
      "cmd": "bun run"
    },
    {
      "category": "General",
      "name": "bx",
      "cmd": "bunx"
    },
    {
      "category": "General",
      "name": "bu",
      "cmd": "bun update"
    },
    {
      "category": "General",
      "name": "cr",
      "cmd": "cargo run"
    },
    {
      "category": "General",
      "name": "crr",
      "cmd": "cargo run --release"
    },
    {
      "category": "General",
      "name": "cb",
      "cmd": "cargo build"
    },
    {
      "category": "General",
      "name": "cbr",
      "cmd": "cargo build --release"
    },
    {
      "category": "General",
      "name": "ct",
      "cmd": "cargo test"
    },
    {
      "category": "General",
      "name": "cta",
      "cmd": "cargo test --all"
    },
    {
      "category": "General",
      "name": "cc",
      "cmd": "cargo check"
    },
    {
      "category": "General",
      "name": "cf",
      "cmd": "cargo fmt"
    },
    {
      "category": "General",
      "name": "cfl",
      "cmd": "cargo clippy"
    },
    {
      "category": "General",
      "name": "cflfix",
      "cmd": "cargo clippy --fix"
    },
    {
      "category": "General",
      "name": "cdoc",
      "cmd": "cargo doc --open"
    },
    {
      "category": "General",
      "name": "cnew",
      "cmd": "cargo new"
    },
    {
      "category": "General",
      "name": "cinit",
      "cmd": "cargo init"
    },
    {
      "category": "General",
      "name": "cadd",
      "cmd": "cargo add"
    },
    {
      "category": "General",
      "name": "crm",
      "cmd": "cargo remove"
    },
    {
      "category": "General",
      "name": "cclean",
      "cmd": "cargo clean"
    },
    {
      "category": "General",
      "name": "cupdate",
      "cmd": "cargo update"
    },
    {
      "category": "General",
      "name": "ctree",
      "cmd": "cargo tree"
    },
    {
      "category": "General",
      "name": "csearch",
      "cmd": "cargo search"
    },
    {
      "category": "General",
      "name": "cpub",
      "cmd": "cargo publish"
    },
    {
      "category": "General",
      "name": "clogin",
      "cmd": "cargo login"
    },
    {
      "category": "General",
      "name": "cinstall",
      "cmd": "cargo install"
    },
    {
      "category": "General",
      "name": "cben",
      "cmd": "cargo bench"
    },
    {
      "category": "General",
      "name": "cwatch",
      "cmd": "cargo watch -x run"
    },
    {
      "category": "General",
      "name": "gor",
      "cmd": "go run ."
    },
    {
      "category": "General",
      "name": "gob",
      "cmd": "go build ."
    },
    {
      "category": "General",
      "name": "got",
      "cmd": "go test ./..."
    },
    {
      "category": "General",
      "name": "gotv",
      "cmd": "go test -v ./..."
    },
    {
      "category": "General",
      "name": "gotc",
      "cmd": "go test -cover ./..."
    },
    {
      "category": "General",
      "name": "gomod",
      "cmd": "go mod tidy"
    },
    {
      "category": "General",
      "name": "gomodinit",
      "cmd": "go mod init"
    },
    {
      "category": "General",
      "name": "goget",
      "cmd": "go get"
    },
    {
      "category": "General",
      "name": "goinst",
      "cmd": "go install"
    },
    {
      "category": "General",
      "name": "govet",
      "cmd": "go vet ./..."
    },
    {
      "category": "General",
      "name": "gofmt",
      "cmd": "gofmt -w ."
    },
    {
      "category": "General",
      "name": "golint",
      "cmd": "golangci-lint run"
    },
    {
      "category": "General",
      "name": "gobuild",
      "cmd": "CGO_ENABLED=0 go build -ldflags=\"-s -w\""
    },
    {
      "category": "General",
      "name": "goenv",
      "cmd": "go env"
    },
    {
      "category": "General",
      "name": "gopath",
      "cmd": "echo $GOPATH"
    },
    {
      "category": "General",
      "name": "gowork",
      "cmd": "go work"
    },
    {
      "category": "General",
      "name": "mk",
      "cmd": "make"
    },
    {
      "category": "General",
      "name": "mkc",
      "cmd": "make clean"
    },
    {
      "category": "General",
      "name": "mki",
      "cmd": "make install"
    },
    {
      "category": "General",
      "name": "mkt",
      "cmd": "make test"
    },
    {
      "category": "General",
      "name": "mkj",
      "cmd": "make -j$(nproc)"
    },
    {
      "category": "General",
      "name": "cmake",
      "cmd": "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
    },
    {
      "category": "General",
      "name": "cmakeb",
      "cmd": "cmake --build build"
    },
    {
      "category": "General",
      "name": "cmakec",
      "cmd": "cmake --build build --target clean"
    },
    {
      "category": "General",
      "name": "ninja",
      "cmd": "ninja -C build"
    },
    {
      "category": "General",
      "name": "javac",
      "cmd": "javac -encoding UTF-8"
    },
    {
      "category": "General",
      "name": "mvnc",
      "cmd": "mvn clean"
    },
    {
      "category": "General",
      "name": "mvni",
      "cmd": "mvn clean install"
    },
    {
      "category": "General",
      "name": "mvnt",
      "cmd": "mvn test"
    },
    {
      "category": "General",
      "name": "mvnp",
      "cmd": "mvn package"
    },
    {
      "category": "General",
      "name": "mvns",
      "cmd": "mvn spring-boot:run"
    },
    {
      "category": "General",
      "name": "gradle",
      "cmd": "./gradlew"
    },
    {
      "category": "General",
      "name": "gradleb",
      "cmd": "./gradlew build"
    },
    {
      "category": "General",
      "name": "gradlet",
      "cmd": "./gradlew test"
    },
    {
      "category": "General",
      "name": "gradlec",
      "cmd": "./gradlew clean"
    },
    {
      "category": "General",
      "name": "gradlew",
      "cmd": "./gradlew"
    },
    {
      "category": "General",
      "name": "rbi",
      "cmd": "bundle install"
    },
    {
      "category": "General",
      "name": "rbu",
      "cmd": "bundle update"
    },
    {
      "category": "General",
      "name": "rbe",
      "cmd": "bundle exec"
    },
    {
      "category": "General",
      "name": "rbr",
      "cmd": "bundle exec rails"
    },
    {
      "category": "General",
      "name": "rbrs",
      "cmd": "bundle exec rails server"
    },
    {
      "category": "General",
      "name": "rbrc",
      "cmd": "bundle exec rails console"
    },
    {
      "category": "General",
      "name": "rspec",
      "cmd": "bundle exec rspec"
    },
    {
      "category": "General",
      "name": "phpi",
      "cmd": "php -a"
    },
    {
      "category": "General",
      "name": "compi",
      "cmd": "composer install"
    },
    {
      "category": "General",
      "name": "compu",
      "cmd": "composer update"
    },
    {
      "category": "General",
      "name": "compr",
      "cmd": "composer require"
    },
    {
      "category": "General",
      "name": "compa",
      "cmd": "composer dump-autoload"
    },
    {
      "category": "General",
      "name": "artisan",
      "cmd": "php artisan"
    },
    {
      "category": "General",
      "name": "ptest",
      "cmd": "./vendor/bin/phpunit"
    },
    {
      "category": "General",
      "name": "pgdbs",
      "cmd": "psql -c \"\\l\""
    },
    {
      "category": "General",
      "name": "pgtbls",
      "cmd": "psql -c \"\\dt\""
    },
    {
      "category": "General",
      "name": "pgdump",
      "cmd": "pg_dump"
    },
    {
      "category": "General",
      "name": "pgrestore",
      "cmd": "pg_restore"
    },
    {
      "category": "General",
      "name": "mqdbs",
      "cmd": "mysql -e \"SHOW DATABASES;\""
    },
    {
      "category": "General",
      "name": "mqdump",
      "cmd": "mysqldump"
    },
    {
      "category": "General",
      "name": "redisping",
      "cmd": "redis-cli ping"
    },
    {
      "category": "General",
      "name": "redisflush",
      "cmd": "redis-cli flushall"
    },
    {
      "category": "General",
      "name": "rediskeys",
      "cmd": "redis-cli keys \"*\""
    },
    {
      "category": "General",
      "name": "redismon",
      "cmd": "redis-cli monitor"
    },
    {
      "category": "General",
      "name": "mongodbs",
      "cmd": "mongosh --eval \"db.adminCommand({listDatabases:1})\""
    },
    {
      "category": "General",
      "name": "sq",
      "cmd": "sqlite3"
    },
    {
      "category": "General",
      "name": "t",
      "cmd": "tmux"
    },
    {
      "category": "General",
      "name": "ta",
      "cmd": "tmux attach"
    },
    {
      "category": "General",
      "name": "tl",
      "cmd": "tmux list-sessions"
    },
    {
      "category": "General",
      "name": "tn",
      "cmd": "tmux new-session -s"
    },
    {
      "category": "General",
      "name": "tk",
      "cmd": "tmux kill-session -t"
    },
    {
      "category": "General",
      "name": "tka",
      "cmd": "tmux kill-server"
    },
    {
      "category": "General",
      "name": "tr",
      "cmd": "tmux rename-session -t"
    },
    {
      "category": "General",
      "name": "tls",
      "cmd": "tmux list-windows"
    },
    {
      "category": "General",
      "name": "tsh",
      "cmd": "tmux split-window -h"
    },
    {
      "category": "General",
      "name": "tsv",
      "cmd": "tmux split-window -v"
    },
    {
      "category": "General",
      "name": "zj",
      "cmd": "zellij"
    },
    {
      "category": "General",
      "name": "zja",
      "cmd": "zellij attach"
    },
    {
      "category": "General",
      "name": "zjl",
      "cmd": "zellij list-sessions"
    },
    {
      "category": "General",
      "name": "zjk",
      "cmd": "zellij kill-session"
    },
    {
      "category": "General",
      "name": "zjka",
      "cmd": "zellij kill-all-sessions"
    },
    {
      "category": "General",
      "name": "scr",
      "cmd": "screen"
    },
    {
      "category": "General",
      "name": "scra",
      "cmd": "screen -r"
    },
    {
      "category": "General",
      "name": "scrl",
      "cmd": "screen -ls"
    },
    {
      "category": "General",
      "name": "lg",
      "cmd": "lazygit"
    },
    {
      "category": "General",
      "name": "ld",
      "cmd": "lazydocker"
    },
    {
      "category": "General",
      "name": "Y",
      "cmd": "yazi'                # capital Y = yazi (lowercase y = function that cd"
    },
    {
      "category": "General",
      "name": "fzfp",
      "cmd": "fzf --preview \"bat --style=numbers --color=always {}\""
    },
    {
      "category": "General",
      "name": "zi",
      "cmd": "z -i"
    },
    {
      "category": "General",
      "name": "bench",
      "cmd": "hyperfine"
    },
    {
      "category": "General",
      "name": "cloc",
      "cmd": "tokei"
    },
    {
      "category": "General",
      "name": "duu",
      "cmd": "dust"
    },
    {
      "category": "General",
      "name": "duff",
      "cmd": "duf"
    },
    {
      "category": "General",
      "name": "ping",
      "cmd": "gping"
    },
    {
      "category": "General",
      "name": "xh",
      "cmd": "curlie"
    },
    {
      "category": "General",
      "name": "jqp",
      "cmd": "jq --color-output ."
    },
    {
      "category": "General",
      "name": "json",
      "cmd": "jq ."
    },
    {
      "category": "General",
      "name": "yaml",
      "cmd": "yq ."
    },
    {
      "category": "General",
      "name": "md",
      "cmd": "glow"
    },
    {
      "category": "General",
      "name": "help",
      "cmd": "tldr"
    },
    {
      "category": "General",
      "name": "man2",
      "cmd": "tldr"
    },
    {
      "category": "General",
      "name": "fuck",
      "cmd": "thefuck $(history -p !!)"
    },
    {
      "category": "General",
      "name": "targz",
      "cmd": "tar -zcvf"
    },
    {
      "category": "General",
      "name": "tarbz",
      "cmd": "tar -jcvf"
    },
    {
      "category": "General",
      "name": "tarxz",
      "cmd": "tar -Jcvf"
    },
    {
      "category": "General",
      "name": "tarzst",
      "cmd": "tar --zstd -cvf"
    },
    {
      "category": "General",
      "name": "unzip",
      "cmd": "unzip -q"
    },
    {
      "category": "General",
      "name": "zip",
      "cmd": "zip -r"
    },
    {
      "category": "General",
      "name": "mkzip",
      "cmd": "zip -r"
    },
    {
      "category": "General",
      "name": "mktarbz",
      "cmd": "tar -cjvf"
    },
    {
      "category": "General",
      "name": "mktarxz",
      "cmd": "tar -cJvf"
    },
    {
      "category": "General",
      "name": "now",
      "cmd": "date +\"%Y-%m-%d %H:%M:%S\""
    },
    {
      "category": "General",
      "name": "nowutc",
      "cmd": "date -u +\"%Y-%m-%dT%H:%M:%SZ\""
    },
    {
      "category": "General",
      "name": "today",
      "cmd": "date +\"%Y-%m-%d\""
    },
    {
      "category": "General",
      "name": "week",
      "cmd": "date +%V"
    },
    {
      "category": "General",
      "name": "ts",
      "cmd": "date +%s"
    },
    {
      "category": "General",
      "name": "epoch",
      "cmd": "date +%s"
    },
    {
      "category": "General",
      "name": "clr",
      "cmd": "clear"
    },
    {
      "category": "General",
      "name": "c",
      "cmd": "clear"
    },
    {
      "category": "General",
      "name": "q",
      "cmd": "exit"
    },
    {
      "category": "General",
      "name": ":q",
      "cmd": "exit"
    },
    {
      "category": "General",
      "name": "logout",
      "cmd": "exit"
    },
    {
      "category": "General",
      "name": "sudoo",
      "cmd": "sudo "
    },
    {
      "category": "General",
      "name": "root",
      "cmd": "sudo -i"
    },
    {
      "category": "General",
      "name": "whoami",
      "cmd": "whoami"
    },
    {
      "category": "General",
      "name": "id",
      "cmd": "id"
    },
    {
      "category": "General",
      "name": "groups",
      "cmd": "groups"
    },
    {
      "category": "General",
      "name": "path",
      "cmd": "echo $PATH | tr \":\" \"\\n\" | nl"
    },
    {
      "category": "General",
      "name": "envv",
      "cmd": "env | sort | less"
    },
    {
      "category": "General",
      "name": "reload",
      "cmd": "exec $SHELL -l"
    },
    {
      "category": "General",
      "name": "brew-up",
      "cmd": "brew bundle dump --force --file=\"$DOTFILES_DIR/apps/brew/Brewfile\" && brew bundle"
    },
    {
      "category": "General",
      "name": "histg",
      "cmd": "history | grep"
    },
    {
      "category": "General",
      "name": "hh",
      "cmd": "history | head -20"
    },
    {
      "category": "General",
      "name": "ht",
      "cmd": "history | tail -20"
    },
    {
      "category": "General",
      "name": "weather",
      "cmd": "curl -s wttr.in"
    },
    {
      "category": "General",
      "name": "wttr",
      "cmd": "curl -s \"wttr.in?format=3\""
    },
    {
      "category": "General",
      "name": "wttrf",
      "cmd": "curl -s \"wttr.in?format=v2\""
    },
    {
      "category": "General",
      "name": "starwars",
      "cmd": "telnet towel.blinkenlights.nl 2>/dev/null || echo \"telnet not installed\""
    },
    {
      "category": "General",
      "name": "matrix",
      "cmd": "cmatrix -C cyan 2>/dev/null"
    },
    {
      "category": "General",
      "name": "pipes",
      "cmd": "pipes.sh 2>/dev/null"
    },
    {
      "category": "General",
      "name": "cowsay",
      "cmd": "cowsay -f tux"
    },
    {
      "category": "General",
      "name": "sl",
      "cmd": "ls"
    },
    {
      "category": "General",
      "name": "Grep",
      "cmd": "grep"
    },
    {
      "category": "General",
      "name": "GREP",
      "cmd": "grep"
    },
    {
      "category": "General",
      "name": "dotlog",
      "cmd": "git -C \"$DOTFILES_DIR\" log --oneline -15"
    },
    {
      "category": "General",
      "name": "dotst",
      "cmd": "git -C \"$DOTFILES_DIR\" status"
    },
    {
      "category": "General",
      "name": "dotdiff",
      "cmd": "git -C \"$DOTFILES_DIR\" diff"
    },
    {
      "category": "General",
      "name": "dotpull",
      "cmd": "git -C \"$DOTFILES_DIR\" pull"
    },
    {
      "category": "General",
      "name": "dotpush",
      "cmd": "git -C \"$DOTFILES_DIR\" add -A && git -C \"$DOTFILES_DIR\" commit && git -C \"$DOTFILES_DIR\" push"
    },
    {
      "category": "General",
      "name": "dotdocs",
      "cmd": "$BROWSER \"$HOME/.dotfiles/docs/index.html\""
    },
    {
      "category": "General",
      "name": "dh",
      "cmd": "du -h --max-depth=1 | sort -rh"
    },
    {
      "category": "General",
      "name": "biggest",
      "cmd": "du -h --max-depth=1 | sort -rh | head 10"
    },
    {
      "category": "General",
      "name": "copy",
      "cmd": "pbcopy"
    },
    {
      "category": "General",
      "name": "paste",
      "cmd": "pbpaste"
    },
    {
      "category": "General",
      "name": "copy",
      "cmd": "wl-copy"
    },
    {
      "category": "General",
      "name": "paste",
      "cmd": "wl-paste"
    },
    {
      "category": "General",
      "name": "copy",
      "cmd": "xclip -selection clipboard"
    },
    {
      "category": "General",
      "name": "paste",
      "cmd": "xclip -selection clipboard -o"
    },
    {
      "category": "General",
      "name": "copy",
      "cmd": "xsel --clipboard --input"
    },
    {
      "category": "General",
      "name": "paste",
      "cmd": "xsel --clipboard --output"
    },
    {
      "category": "General",
      "name": "open",
      "cmd": "open"
    },
    {
      "category": "General",
      "name": "open",
      "cmd": "xdg-open"
    },
    {
      "category": "General",
      "name": "o",
      "cmd": "open"
    },
    {
      "category": "General",
      "name": "spico",
      "cmd": "sudo pico"
    },
    {
      "category": "General",
      "name": "snano",
      "cmd": "sudo nano"
    },
    {
      "category": "General",
      "name": "web",
      "cmd": "cd /var/www/html"
    },
    {
      "category": "General",
      "name": "alert",
      "cmd": "notify-send \"Done!\""
    },
    {
      "category": "General",
      "name": "ebrc",
      "cmd": "edit ~/.bashrc"
    },
    {
      "category": "General",
      "name": "hlp",
      "cmd": "less ~/.bashrc_help"
    },
    {
      "category": "General",
      "name": "da",
      "cmd": "date \"+%Y-%m-%d %A %T %Z\""
    },
    {
      "category": "General",
      "name": "cls",
      "cmd": "clear"
    },
    {
      "category": "General",
      "name": "multitail",
      "cmd": "multitail --no-repeat -c"
    },
    {
      "category": "General",
      "name": "freshclam",
      "cmd": "sudo freshclam"
    },
    {
      "category": "General",
      "name": "svi",
      "cmd": "sudo vi"
    },
    {
      "category": "General",
      "name": "vis",
      "cmd": "nvim \"+set si\""
    },
    {
      "category": "General",
      "name": "yayf",
      "cmd": "yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
    },
    {
      "category": "General",
      "name": "bd",
      "cmd": "cd \"$OLDPWD\""
    },
    {
      "category": "General",
      "name": "rmd",
      "cmd": "/bin/rm  --recursive --force --verbose "
    },
    {
      "category": "General",
      "name": "lx",
      "cmd": "ls -lXBh"
    },
    {
      "category": "General",
      "name": "lk",
      "cmd": "ls -lSrh"
    },
    {
      "category": "General",
      "name": "lc",
      "cmd": "ls -ltcrh"
    },
    {
      "category": "General",
      "name": "lu",
      "cmd": "ls -lturh"
    },
    {
      "category": "General",
      "name": "lr",
      "cmd": "ls -lRh"
    },
    {
      "category": "General",
      "name": "lm",
      "cmd": "ls -alh |more"
    },
    {
      "category": "General",
      "name": "lw",
      "cmd": "ls -xAh"
    },
    {
      "category": "General",
      "name": "labc",
      "cmd": "ls -lap"
    },
    {
      "category": "General",
      "name": "lf",
      "cmd": "ls -l | egrep -v '^d'"
    },
    {
      "category": "General",
      "name": "ldir",
      "cmd": "ls -l | egrep '^d'"
    },
    {
      "category": "General",
      "name": "mx",
      "cmd": "chmod a+x"
    },
    {
      "category": "General",
      "name": "000",
      "cmd": "chmod -R 000"
    },
    {
      "category": "General",
      "name": "644",
      "cmd": "chmod -R 644"
    },
    {
      "category": "General",
      "name": "666",
      "cmd": "chmod -R 666"
    },
    {
      "category": "General",
      "name": "755",
      "cmd": "chmod -R 755"
    },
    {
      "category": "General",
      "name": "777",
      "cmd": "chmod -R 777"
    },
    {
      "category": "General",
      "name": "h",
      "cmd": "history | grep "
    },
    {
      "category": "General",
      "name": "p",
      "cmd": "ps aux | grep "
    },
    {
      "category": "General",
      "name": "topcpu",
      "cmd": "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
    },
    {
      "category": "General",
      "name": "f",
      "cmd": "find . | grep "
    },
    {
      "category": "General",
      "name": "checkcommand",
      "cmd": "type -t"
    },
    {
      "category": "General",
      "name": "openports",
      "cmd": "netstat -nape --inet"
    },
    {
      "category": "General",
      "name": "rebootsafe",
      "cmd": "sudo shutdown -r now"
    },
    {
      "category": "General",
      "name": "rebootforce",
      "cmd": "sudo shutdown -r -n now"
    },
    {
      "category": "General",
      "name": "diskspace",
      "cmd": "du -S | sort -n -r |more"
    },
    {
      "category": "General",
      "name": "folders",
      "cmd": "du -h --max-depth=1"
    },
    {
      "category": "General",
      "name": "folderssort",
      "cmd": "find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn"
    },
    {
      "category": "General",
      "name": "treed",
      "cmd": "tree -CAFd"
    },
    {
      "category": "General",
      "name": "mountedinfo",
      "cmd": "df -hT"
    },
    {
      "category": "General",
      "name": "mktar",
      "cmd": "tar -cvf"
    },
    {
      "category": "General",
      "name": "mkbz2",
      "cmd": "tar -cvjf"
    },
    {
      "category": "General",
      "name": "mkgz",
      "cmd": "tar -cvzf"
    },
    {
      "category": "General",
      "name": "unbz2",
      "cmd": "tar -xvjf"
    },
    {
      "category": "General",
      "name": "ungz",
      "cmd": "tar -xvzf"
    },
    {
      "category": "General",
      "name": "sha1",
      "cmd": "openssl sha1"
    },
    {
      "category": "General",
      "name": "clickpaste",
      "cmd": "sleep 3; xdotool type \"$(xclip -o -selection clipboard)\""
    },
    {
      "category": "General",
      "name": "kssh",
      "cmd": "kitty +kitten ssh"
    },
    {
      "category": "General",
      "name": "docker-clean",
      "cmd": " docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f "
    },
    {
      "category": "General",
      "name": "hug",
      "cmd": "systemctl --user restart hugo"
    },
    {
      "category": "General",
      "name": "lanm",
      "cmd": "systemctl --user restart lan-mouse"
    },
    {
      "category": "General",
      "name": "ls",
      "cmd": "eza -al --color=always --group-directories-first --icons"
    },
    {
      "category": "General",
      "name": "la",
      "cmd": "eza -a --color=always --group-directories-first --icons"
    },
    {
      "category": "General",
      "name": "ll",
      "cmd": "eza -l --color=always --group-directories-first --icons"
    },
    {
      "category": "General",
      "name": "lt",
      "cmd": "eza -aT --color=always --group-directories-first --icons"
    },
    {
      "category": "General",
      "name": "l.",
      "cmd": "eza -ald --color=always --group-directories-first --icons .*"
    },
    {
      "category": "General",
      "name": "cat",
      "cmd": "bat --style header --style snip --style changes --style header"
    },
    {
      "category": "General",
      "name": "grubup",
      "cmd": "sudo update-grub"
    },
    {
      "category": "General",
      "name": "fixpacman",
      "cmd": "sudo rm /var/lib/pacman/db.lck"
    },
    {
      "category": "General",
      "name": "tarnow",
      "cmd": "tar -acf "
    },
    {
      "category": "General",
      "name": "untar",
      "cmd": "tar -zxvf "
    },
    {
      "category": "General",
      "name": "wget",
      "cmd": "wget -c "
    },
    {
      "category": "General",
      "name": "rmpkg",
      "cmd": "sudo pacman -Rdd"
    },
    {
      "category": "General",
      "name": "psmem",
      "cmd": "ps auxf | sort -nr -k 4"
    },
    {
      "category": "General",
      "name": "psmem10",
      "cmd": "ps auxf | sort -nr -k 4 | head -10"
    },
    {
      "category": "General",
      "name": "upd",
      "cmd": "/usr/bin/garuda-update"
    },
    {
      "category": "General",
      "name": "..",
      "cmd": "cd .."
    },
    {
      "category": "General",
      "name": "...",
      "cmd": "cd ../.."
    },
    {
      "category": "General",
      "name": "....",
      "cmd": "cd ../../.."
    },
    {
      "category": "General",
      "name": ".....",
      "cmd": "cd ../../../.."
    },
    {
      "category": "General",
      "name": "......",
      "cmd": "cd ../../../../.."
    },
    {
      "category": "General",
      "name": "dir",
      "cmd": "dir --color=auto"
    },
    {
      "category": "General",
      "name": "vdir",
      "cmd": "vdir --color=auto"
    },
    {
      "category": "General",
      "name": "grep",
      "cmd": "ugrep --color=auto"
    },
    {
      "category": "General",
      "name": "fgrep",
      "cmd": "ugrep -F --color=auto"
    },
    {
      "category": "General",
      "name": "egrep",
      "cmd": "ugrep -E --color=auto"
    },
    {
      "category": "General",
      "name": "hw",
      "cmd": "hwinfo --short"
    },
    {
      "category": "General",
      "name": "big",
      "cmd": "expac -H M '%m\\t%n' | sort -h | nl"
    },
    {
      "category": "General",
      "name": "gitpkg",
      "cmd": "pacman -Q | grep -i \"\\-git\" | wc -l"
    },
    {
      "category": "General",
      "name": "ip",
      "cmd": "ip -color"
    },
    {
      "category": "General",
      "name": "mirror",
      "cmd": "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    },
    {
      "category": "General",
      "name": "mirrord",
      "cmd": "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    },
    {
      "category": "General",
      "name": "mirrors",
      "cmd": "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    },
    {
      "category": "General",
      "name": "mirrora",
      "cmd": "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
    },
    {
      "category": "General",
      "name": "apt",
      "cmd": "man pacman"
    },
    {
      "category": "General",
      "name": "apt-get",
      "cmd": "man pacman"
    },
    {
      "category": "General",
      "name": "please",
      "cmd": "sudo"
    },
    {
      "category": "General",
      "name": "tb",
      "cmd": "nc termbin.com 9999"
    },
    {
      "category": "General",
      "name": "helpme",
      "cmd": "cht.sh --shell"
    },
    {
      "category": "General",
      "name": "pacdiff",
      "cmd": "sudo -H DIFFPROG=meld pacdiff"
    },
    {
      "category": "General",
      "name": "cleanup",
      "cmd": "sudo pacman -Rns $(pacman -Qtdq)"
    },
    {
      "category": "General",
      "name": "jctl",
      "cmd": "journalctl -p 3 -xb"
    },
    {
      "category": "General",
      "name": "rip",
      "cmd": "expac --timefmt='%Y-%m-%d %T' '%l\\t%n %v' | sort | tail -200 | nl"
    },
    {
      "category": "General",
      "name": "cdf",
      "cmd": "cd \"$(osascript -e \"tell app \\\"Finder\\\" to POSIX path of (insertion location as alias)\" 2>/dev/null || echo .)\""
    },
    {
      "category": "General",
      "name": "emptytrash",
      "cmd": "sudo rm -rfv /Volumes/*/.Trashes && sudo rm -rfv ~/.Trash"
    },
    {
      "category": "General",
      "name": "showfiles",
      "cmd": "defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
    },
    {
      "category": "General",
      "name": "hidefiles",
      "cmd": "defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
    },
    {
      "category": "General",
      "name": "pclean",
      "cmd": "find . -type d -name \"__pycache__\" -exec rm -rf {} + && find . -type f -name \"*.pyc\" -delete"
    },
    {
      "category": "General",
      "name": "nuke-node",
      "cmd": "find . -name \"node_modules\" -type d -prune -exec rm -rf \"{}\" +"
    },
    {
      "category": "General",
      "name": "v",
      "cmd": "fd --type f --hidden --exclude .git | fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\" | xargs -r $EDITOR"
    },
    {
      "category": "General",
      "name": "fz",
      "cmd": "zoxide query -i"
    },
    {
      "category": "General",
      "name": "gpristine",
      "cmd": "git reset --hard && git clean -fdx"
    },
    {
      "category": "General",
      "name": "gwt",
      "cmd": "git worktree"
    },
    {
      "category": "General",
      "name": "gwta",
      "cmd": "git worktree add"
    },
    {
      "category": "General",
      "name": "gwtl",
      "cmd": "git worktree list"
    },
    {
      "category": "General",
      "name": "gwtrm",
      "cmd": "git worktree remove"
    }
  ],
  "functions": [
    {
      "category": "DOTFILES MODES & SYSTEM",
      "name": "chmode",
      "desc": "Change the operational mode of the dotfiles Change the operational mode of the dotfiles (Unified)"
    },
    {
      "category": "DOTFILES MODES & SYSTEM",
      "name": "dotfix",
      "desc": "Fix and re-link all dotfiles"
    },
    {
      "category": "NAVIGATION",
      "name": "cd",
      "desc": "cd with auto-ls after entering"
    },
    {
      "category": "NAVIGATION",
      "name": "mkcd",
      "desc": "Create directory and cd into it"
    },
    {
      "category": "NAVIGATION",
      "name": "groot",
      "desc": "cd to git root"
    },
    {
      "category": "NAVIGATION",
      "name": "dot",
      "desc": "quick jump to dotfiles"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "excd",
      "desc": "Extract and cd into the directory"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "mktar",
      "desc": "Create a .tar.gz of a path"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "mktarbz",
      "desc": "Create a .tar.gz of a path"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "mktarxz",
      "desc": "Create a .tar.gz of a path"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "mkzst",
      "desc": "Create a .tar.gz of a path"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "bak",
      "desc": "Backup file with timestamp"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "unbak",
      "desc": "Restore the latest backup"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "touchp",
      "desc": "Touch with automatic parent dir creation"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "swap",
      "desc": "Swap two files atomically"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "cpv",
      "desc": "Copy with progress bar (rsync)"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "ff",
      "desc": "Find file by name (fd → find fallback)"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "ffd",
      "desc": "Find file by name (fd → find fallback)"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "largest",
      "desc": "Largest N files in a directory"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "largestdirs",
      "desc": "Largest N files in a directory"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "diskusage",
      "desc": "Disk usage summary"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "countfiles",
      "desc": "Count files / links / directories"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "fs",
      "desc": "Show file size (mathiasbynens)"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "xopen",
      "desc": "Open file/URL (cross-platform)"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "note",
      "desc": "Quick note with timestamp"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "notes-clear",
      "desc": "Show, clear, or search notes"
    },
    {
      "category": "FILES & ARCHIVES",
      "name": "notes-search",
      "desc": "Show, clear, or search notes"
    },
    {
      "category": "GIT",
      "name": "sosgit",
      "desc": "Emergency git push — add everything, commit, force-push, no questions asked Usage: sos \"message\"  or just: sos  (auto-generates timestamp message)"
    },
    {
      "category": "GIT",
      "name": "gcall",
      "desc": "git add -A + commit (distinct from gca = --amend)"
    },
    {
      "category": "GIT",
      "name": "gcmsign",
      "desc": "Signed commit (requires GPG key)"
    },
    {
      "category": "GIT",
      "name": "grib",
      "desc": "Interactive rebase N commits"
    },
    {
      "category": "GIT",
      "name": "git-clean",
      "desc": "Clean merged branches"
    },
    {
      "category": "GIT",
      "name": "gsquash",
      "desc": "Squash last N commits"
    },
    {
      "category": "GIT",
      "name": "ginfo",
      "desc": "Git repo info"
    },
    {
      "category": "GIT",
      "name": "gstats",
      "desc": "Git statistics"
    },
    {
      "category": "GIT",
      "name": "glog",
      "desc": "Pretty log (N lines)"
    },
    {
      "category": "GIT",
      "name": "gdiffs",
      "desc": "Show git diff stat"
    },
    {
      "category": "GIT",
      "name": "gnewbranch",
      "desc": "Create and push new branch"
    },
    {
      "category": "GIT",
      "name": "gdelb",
      "desc": "Delete branch locally and remotely"
    },
    {
      "category": "GIT",
      "name": "gchanged",
      "desc": "Show files changed in last N commits"
    },
    {
      "category": "GIT",
      "name": "fgco",
      "desc": "Interactive fuzzy branch checkout (requires fzf)"
    },
    {
      "category": "GIT",
      "name": "fgstash",
      "desc": "Fuzzy stash picker"
    },
    {
      "category": "GIT",
      "name": "gsync",
      "desc": "Git sync: pull, prune, and clean"
    },
    {
      "category": "GIT",
      "name": "dsync",
      "desc": "Dotfiles sync"
    },
    {
      "category": "GIT",
      "name": "dpush",
      "desc": "Dotfiles push (add, commit, push)"
    },
    {
      "category": "DOCKER",
      "name": "docker-clean",
      "desc": "System prune all"
    },
    {
      "category": "DOCKER",
      "name": "docker-stop-all",
      "desc": "Stop all running containers"
    },
    {
      "category": "DOCKER",
      "name": "docker-rm-all",
      "desc": "Remove all containers"
    },
    {
      "category": "DOCKER",
      "name": "docker-rmi-all",
      "desc": "Remove all images"
    },
    {
      "category": "DOCKER",
      "name": "docker-du",
      "desc": "Docker disk usage"
    },
    {
      "category": "DOCKER",
      "name": "dexec",
      "desc": "Interactive exec into running container (fzf)"
    },
    {
      "category": "DOCKER",
      "name": "dlf",
      "desc": "Follow logs from container (fzf picker)"
    },
    {
      "category": "DOCKER",
      "name": "dip",
      "desc": "Docker container IP"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "kwatch",
      "desc": "Watch pods in current namespace"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "klf",
      "desc": "Tail logs from pod matching pattern (fzf)"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "kexf",
      "desc": "Exec into pod (fzf)"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "ksecret",
      "desc": "Get secret value decoded"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "kns",
      "desc": "Switch k8s namespace"
    },
    {
      "category": "KUBERNETES HELPERS",
      "name": "kctxf",
      "desc": "Switch k8s context"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "sysupdate",
      "desc": "Cross-distro system update"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "myip",
      "desc": "Get internal + external IP"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "portopen",
      "desc": "Check open port on remote host"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "killport",
      "desc": "Kill process on a port"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "portused",
      "desc": "What is using port"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "reachable",
      "desc": "Check if host is reachable"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "weather",
      "desc": "Weather (wttr.in)"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "serve",
      "desc": "Quick HTTP server"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "digga",
      "desc": "DNS lookup all records"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "sslcheck",
      "desc": "SSL certificate check"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "certnames",
      "desc": "Get cert SAN names"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "psg",
      "desc": "Search process"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "fkill",
      "desc": "Fuzzy kill process"
    },
    {
      "category": "SYSTEM & NETWORK",
      "name": "ww",
      "desc": "Show who's logged in with IPs"
    },
    {
      "category": "SECURITY",
      "name": "genpass",
      "desc": "Generate cryptographically strong password"
    },
    {
      "category": "SECURITY",
      "name": "genphrase",
      "desc": "Generate passphrase (memorable)"
    },
    {
      "category": "SECURITY",
      "name": "hashfile",
      "desc": "Hash a string or file"
    },
    {
      "category": "SECURITY",
      "name": "securerm",
      "desc": "Securely wipe a file (3-pass)"
    },
    {
      "category": "SECURITY",
      "name": "encrypt",
      "desc": "Encrypt a file with GPG"
    },
    {
      "category": "SECURITY",
      "name": "decrypt",
      "desc": "Decrypt a GPG file"
    },
    {
      "category": "SECURITY",
      "name": "gpgsign",
      "desc": "Sign a file with GPG"
    },
    {
      "category": "SECURITY",
      "name": "gpgverify",
      "desc": "Check GPG signature"
    },
    {
      "category": "SECURITY",
      "name": "b64e",
      "desc": "Base64 encode/decode"
    },
    {
      "category": "SECURITY",
      "name": "b64d",
      "desc": "Base64 encode/decode"
    },
    {
      "category": "SECURITY",
      "name": "urlencode",
      "desc": "URL encode/decode"
    },
    {
      "category": "SECURITY",
      "name": "urldecode",
      "desc": "URL encode/decode"
    },
    {
      "category": "SECURITY",
      "name": "jwtdecode",
      "desc": "JWT decode (without verification — for inspection only)"
    },
    {
      "category": "SECURITY",
      "name": "is_root",
      "desc": "Check if running as root"
    },
    {
      "category": "SECURITY",
      "name": "require_root",
      "desc": "Require root or exit"
    },
    {
      "category": "SECURITY",
      "name": "audit_suid",
      "desc": "Audit SUID/SGID binaries"
    },
    {
      "category": "SECURITY",
      "name": "audit_worldwrite",
      "desc": "Find world-writable files"
    },
    {
      "category": "SECURITY",
      "name": "audit_ssh",
      "desc": "Check SSH configuration for weak settings"
    },
    {
      "category": "SECURITY",
      "name": "dataurl",
      "desc": "Data URL from file (for embedding in HTML)"
    },
    {
      "category": "SECURITY",
      "name": "hb",
      "desc": "Upload to hastebin shellcheck disable=SC2317"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "timer",
      "desc": "Timer for a command"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "calc",
      "desc": "Calculator (bc → python3)"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "qr",
      "desc": "QR code in terminal"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "cheat",
      "desc": "Cheat sheet (cheat.sh)"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "tman",
      "desc": "Look up a man page in tldr format"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "json",
      "desc": "JSON pretty print"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "yamlfmt",
      "desc": "YAML pretty print"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "json2yaml",
      "desc": "Convert JSON to YAML"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "yaml2json",
      "desc": "Convert YAML to JSON"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "colorize",
      "desc": "Colorize log output (ERROR=red WARN=yellow INFO=green DEBUG=cyan)"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "logtail",
      "desc": "Follow log with colorize"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "httping",
      "desc": "HTTP status code check"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "jsoncheck",
      "desc": "Validate JSON file"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "yamlcheck",
      "desc": "Validate YAML file"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "tomlcheck",
      "desc": "Validate TOML file"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "diffcmds",
      "desc": "Quick diff between two commands"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "watchc",
      "desc": "Watch a command with color"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "repeatn",
      "desc": "Repeat command N times"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "bg_run",
      "desc": "Run command in background silently"
    },
    {
      "category": "DEVELOPMENT UTILITIES",
      "name": "wait_for",
      "desc": "Wait for a host to come online"
    },
    {
      "category": "FZF-POWERED FUNCTIONS",
      "name": "fo",
      "desc": "Fuzzy open file in editor"
    },
    {
      "category": "FZF-POWERED FUNCTIONS",
      "name": "fcd",
      "desc": "Fuzzy cd into directory"
    },
    {
      "category": "FZF-POWERED FUNCTIONS",
      "name": "fh",
      "desc": "Fuzzy history search and execute"
    },
    {
      "category": "FZF-POWERED FUNCTIONS",
      "name": "falias",
      "desc": "Fuzzy alias browser"
    },
    {
      "category": "FZF-POWERED FUNCTIONS",
      "name": "fenv",
      "desc": "Fuzzy environment variable browser"
    },
    {
      "category": "YAZI / RANGER / FILE MANAGERS",
      "name": "y",
      "desc": "No description available."
    },
    {
      "category": "YAZI / RANGER / FILE MANAGERS",
      "name": "ranger-cd",
      "desc": "No description available."
    },
    {
      "category": "DIRECTORY BOOKMARKS",
      "name": "bm",
      "desc": "No description available."
    },
    {
      "category": "DIRECTORY BOOKMARKS",
      "name": "bml",
      "desc": "No description available."
    },
    {
      "category": "DIRECTORY BOOKMARKS",
      "name": "bmrm",
      "desc": "No description available."
    },
    {
      "category": "DIRECTORY BOOKMARKS",
      "name": "bmclear",
      "desc": "No description available."
    },
    {
      "category": "DIRECTORY BOOKMARKS",
      "name": "bmgo",
      "desc": "No description available."
    },
    {
      "category": "MISC UTILITIES",
      "name": "watchcmd",
      "desc": "Watch command output every 2s"
    },
    {
      "category": "MISC UTILITIES",
      "name": "title",
      "desc": "Terminal title"
    },
    {
      "category": "MISC UTILITIES",
      "name": "termsize",
      "desc": "Columns info"
    },
    {
      "category": "MISC UTILITIES",
      "name": "bench",
      "desc": "Quick benchmark N runs of a command"
    },
    {
      "category": "MISC UTILITIES",
      "name": "gz",
      "desc": "gzip size comparison"
    },
    {
      "category": "MISC UTILITIES",
      "name": "doh",
      "desc": "DNS over HTTPS (Cloudflare)"
    },
    {
      "category": "MISC UTILITIES",
      "name": "httpheaders",
      "desc": "Check HTTPS headers of a URL"
    },
    {
      "category": "MISC UTILITIES",
      "name": "redirects",
      "desc": "Follow redirects of a URL"
    },
    {
      "category": "MISC UTILITIES",
      "name": "mergepdf",
      "desc": "Merge PDFs (requires ghostscript)"
    },
    {
      "category": "MISC UTILITIES",
      "name": "splitpdf",
      "desc": "Split PDF pages (requires pdftk)"
    },
    {
      "category": "MISC UTILITIES",
      "name": "dotlog",
      "desc": "Dotfiles error log viewer"
    },
    {
      "category": "MISC UTILITIES",
      "name": "ql",
      "desc": "No description available."
    },
    {
      "category": "MISC UTILITIES",
      "name": "cleanup",
      "desc": "Verbose cleanup /tmp"
    },
    {
      "category": "MISC UTILITIES",
      "name": "Usage",
      "desc": "Usage stats top dirs"
    },
    {
      "category": "MISC UTILITIES",
      "name": "cloc",
      "desc": "Count lines of code in a dir"
    },
    {
      "category": "extract() {",
      "name": "extract",
      "desc": "FUNCTIONS (ZachBrowne / Titus)"
    },
    {
      "category": "extract() {",
      "name": "ftext",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "cpp",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "cpg",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "mvg",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "mkdirg",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "up",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "pwdtail",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "distribution",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "ver",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "install_bashrc_support",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "whatsmyip",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "apachelog",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "apacheconfig",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "phpconfig",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "mysqlconfig",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "trim",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "gcom",
      "desc": "No description available."
    },
    {
      "category": "extract() {",
      "name": "lazyg",
      "desc": "No description available."
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "fshow",
      "desc": "Git Show with FZF"
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "ipinfo",
      "desc": "Advanced GeoIP lookup"
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "transfer",
      "desc": "Upload to transfer.sh"
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "speedtest",
      "desc": "Simple shell-based speedtest"
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "tmpdir",
      "desc": "Create a temporary directory and enter it"
    },
    {
      "category": "SUPREME FUNCTIONS (Advanced Workflows)",
      "name": "fnr",
      "desc": "Find and Replace in files"
    }
  ],
  "generatedAt": "2026-04-12T15:39:16.603Z"
};