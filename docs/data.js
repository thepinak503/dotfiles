const dotfilesData = {
  "aliases": [
    {
      "category": "",
      "name": "..",
      "cmd": "cd .."
    },
    {
      "category": "",
      "name": "...",
      "cmd": "cd ../.."
    },
    {
      "category": "",
      "name": "....",
      "cmd": "cd ../../.."
    },
    {
      "category": "",
      "name": ".....",
      "cmd": "cd ../../../.."
    },
    {
      "category": "",
      "name": "a",
      "cmd": "cd .."
    },
    {
      "category": "",
      "name": "aa",
      "cmd": "cd ../.."
    },
    {
      "category": "",
      "name": "aaa",
      "cmd": "cd ../../.."
    },
    {
      "category": "",
      "name": "aaaa",
      "cmd": "cd ../../../.."
    },
    {
      "category": "",
      "name": "aaaaa",
      "cmd": "cd ../../../.."
    },
    {
      "category": "",
      "name": "home",
      "cmd": "cd ~"
    },
    {
      "category": "",
      "name": "docs",
      "cmd": "cd ~/Documents"
    },
    {
      "category": "",
      "name": "dt",
      "cmd": "cd ~/Desktop"
    },
    {
      "category": "",
      "name": "tmp",
      "cmd": "cd /tmp"
    },
    {
      "category": "",
      "name": "root",
      "cmd": "cd /"
    },
    {
      "category": "",
      "name": "bk",
      "cmd": "cd -"
    },
    {
      "category": "",
      "name": "x",
      "cmd": "exit"
    },
    {
      "category": "",
      "name": "c",
      "cmd": "clear"
    },
    {
      "category": "",
      "name": "cls",
      "cmd": "clear"
    },
    {
      "category": "",
      "name": "clr",
      "cmd": "clear"
    },
    {
      "category": "",
      "name": "tmpdir",
      "cmd": "cd $(mktemp -d)"
    },
    {
      "category": "",
      "name": "-- -",
      "cmd": "dash"
    },
    {
      "category": "",
      "name": ":q",
      "cmd": "exit"
    },
    {
      "category": "",
      "name": "q",
      "cmd": "exit"
    },
    {
      "category": "",
      "name": "lsa",
      "cmd": "ls -a"
    },
    {
      "category": "",
      "name": "lsd",
      "cmd": "ls -d */"
    },
    {
      "category": "",
      "name": "lsdot",
      "cmd": "ls -d .*"
    },
    {
      "category": "",
      "name": "lsf",
      "cmd": "ls -p | grep -v /"
    },
    {
      "category": "",
      "name": "lsbig",
      "cmd": "ls -lS | head -20"
    },
    {
      "category": "",
      "name": "lshidden",
      "cmd": "ls -d .* 2>/dev/null"
    },
    {
      "category": "",
      "name": "ltree",
      "cmd": "eza --tree --level=3 --icons=auto 2>/dev/null || find . -maxdepth 3 -print"
    },
    {
      "category": "",
      "name": "l1",
      "cmd": "ls -1"
    },
    {
      "category": "",
      "name": "lh",
      "cmd": "command ls -lhS"
    },
    {
      "category": "",
      "name": "lr",
      "cmd": "command ls -lR"
    },
    {
      "category": "",
      "name": "le",
      "cmd": "command ls | grep -o '.[^.]*$' | sort | uniq"
    },
    {
      "category": "",
      "name": "lw",
      "cmd": "command ls -ldh $(pwd)"
    },
    {
      "category": "",
      "name": "ls",
      "cmd": "_x eza --group-directories-first --icons 2>/dev/null || _x exa --group-directories-first 2>/dev/null || command ls --color=auto 2>/dev/null || command ls -G"
    },
    {
      "category": "",
      "name": "ll",
      "cmd": "_x eza -l --group-directories-first --icons 2>/dev/null || _x exa -l 2>/dev/null || command ls -l"
    },
    {
      "category": "",
      "name": "la",
      "cmd": "_x eza -la --group-directories-first --icons 2>/dev/null || _x exa -la 2>/dev/null || command ls -la"
    },
    {
      "category": "",
      "name": "lal",
      "cmd": "_x eza -la --group-directories-first --icons 2>/dev/null || _x exa -la 2>/dev/null || command ls -la"
    },
    {
      "category": "",
      "name": "lsl",
      "cmd": "_x eza -l --group-directories-first --icons 2>/dev/null || _x exa -l 2>/dev/null || command ls -l"
    },
    {
      "category": "",
      "name": "tree",
      "cmd": "_x eza -T --icons 2>/dev/null || _x tree 2>/dev/null || echo \"tree/eza needed\""
    },
    {
      "category": "",
      "name": "dirs",
      "cmd": "ls -d */"
    },
    {
      "category": "",
      "name": "ldir",
      "cmd": "ls -d */"
    },
    {
      "category": "",
      "name": "lf",
      "cmd": "find . -maxdepth 1 -type f -exec command ls -lh {} + 2>/dev/null | sort -k5 -h"
    },
    {
      "category": "",
      "name": "dots",
      "cmd": "cd \"$DOTFILES_DIR\""
    },
    {
      "category": "",
      "name": "dotfiles",
      "cmd": "cd \"$DOTFILES_DIR\""
    },
    {
      "category": "",
      "name": "dotst",
      "cmd": "git -C \"$DOTFILES_DIR\" status --short --branch"
    },
    {
      "category": "",
      "name": "edots",
      "cmd": "$EDITOR \"$DOTFILES_DIR\""
    },
    {
      "category": "",
      "name": "dotupdate",
      "cmd": "bash \"$DOTFILES_DIR/bin/dotupdate.sh\""
    },
    {
      "category": "",
      "name": "dothealth",
      "cmd": "bash \"$DOTFILES_DIR/bin/health_check.sh\""
    },
    {
      "category": "",
      "name": "dotbench",
      "cmd": "bash \"$DOTFILES_DIR/bin/benchmark_shell.sh\""
    },
    {
      "category": "",
      "name": "dotfix",
      "cmd": "sh \"$DOTFILES_DIR/install/install.sh\""
    },
    {
      "category": "",
      "name": "dotloadfull",
      "cmd": ". \"$DOTFILES_DIR/core/aliases.sh\" && . \"$DOTFILES_DIR/core/functions.sh\""
    },
    {
      "category": "",
      "name": "dotbranch",
      "cmd": "git -C \"$DOTFILES_DIR\" branch"
    },
    {
      "category": "",
      "name": "dotdiff",
      "cmd": "git -C \"$DOTFILES_DIR\" diff"
    },
    {
      "category": "",
      "name": "dotdocs",
      "cmd": "xdg-open \"$DOTFILES_DIR/docs/index.html\" 2>/dev/null || open \"$DOTFILES_DIR/docs/index.html\" 2>/dev/null"
    },
    {
      "category": "",
      "name": "dotfetch",
      "cmd": "git -C \"$DOTFILES_DIR\" fetch --all --prune"
    },
    {
      "category": "",
      "name": "dothelp",
      "cmd": "echo \"Pinak'\\''s Dotfiles v$DOTFILES_VERSION — see dotdocs for docs\""
    },
    {
      "category": "",
      "name": "dotlog",
      "cmd": "git -C \"$DOTFILES_DIR\" log --oneline --graph --decorate -20"
    },
    {
      "category": "",
      "name": "dotmode",
      "cmd": "echo \"$DOTFILES_MODE\""
    },
    {
      "category": "",
      "name": "dotpush",
      "cmd": "git -C \"$DOTFILES_DIR\" push"
    },
    {
      "category": "",
      "name": "dotreload",
      "cmd": "exec \"$SHELL\" -l"
    },
    {
      "category": "",
      "name": "dotver",
      "cmd": "echo \"$DOTFILES_VERSION\""
    },
    {
      "category": "",
      "name": "dsync",
      "cmd": "dot_sync"
    },
    {
      "category": "",
      "name": "chmode",
      "cmd": "export DOTFILES_MODE"
    },
    {
      "category": "",
      "name": "modestat",
      "cmd": "echo \"Mode: ${DOTFILES_MODE:-unknown}\""
    },
    {
      "category": "",
      "name": "dotinfo",
      "cmd": "echo \"Dotfiles: $DOTFILES_DIR | Mode: ${DOTFILES_MODE:-unknown} | Shell: $SHELL\""
    },
    {
      "category": "",
      "name": "gap",
      "cmd": "git add -p"
    },
    {
      "category": "",
      "name": "gcm",
      "cmd": "git commit -m"
    },
    {
      "category": "",
      "name": "gcan",
      "cmd": "git commit --amend --no-edit"
    },
    {
      "category": "",
      "name": "gpl",
      "cmd": "git pull --rebase --autostash"
    },
    {
      "category": "",
      "name": "gsw",
      "cmd": "git switch"
    },
    {
      "category": "",
      "name": "grbc",
      "cmd": "git rebase --continue"
    },
    {
      "category": "",
      "name": "grba",
      "cmd": "git rebase --abort"
    },
    {
      "category": "",
      "name": "grbs",
      "cmd": "git rebase --skip"
    },
    {
      "category": "",
      "name": "gpr",
      "cmd": "git pull --rebase"
    },
    {
      "category": "",
      "name": "prune",
      "cmd": "git remote prune origin"
    },
    {
      "category": "",
      "name": "shipit",
      "cmd": "git status --short && git push"
    },
    {
      "category": "",
      "name": "glg",
      "cmd": "git log --oneline --decorate --graph"
    },
    {
      "category": "",
      "name": "gla",
      "cmd": "git log --oneline --decorate --graph --all"
    },
    {
      "category": "",
      "name": "gcount",
      "cmd": "git shortlog -sn"
    },
    {
      "category": "",
      "name": "gbl",
      "cmd": "git blame -w"
    },
    {
      "category": "",
      "name": "gcl",
      "cmd": "git clone"
    },
    {
      "category": "",
      "name": "gdf",
      "cmd": "git diff --name-only"
    },
    {
      "category": "",
      "name": "gdw",
      "cmd": "git diff --word-diff"
    },
    {
      "category": "",
      "name": "gdc",
      "cmd": "git diff --cached"
    },
    {
      "category": "",
      "name": "gpsup",
      "cmd": "git push --set-upstream origin HEAD"
    },
    {
      "category": "",
      "name": "grv",
      "cmd": "git remote -v"
    },
    {
      "category": "",
      "name": "gsta",
      "cmd": "git stash apply"
    },
    {
      "category": "",
      "name": "gstd",
      "cmd": "git stash drop"
    },
    {
      "category": "",
      "name": "gswc",
      "cmd": "git switch -c"
    },
    {
      "category": "",
      "name": "gcp",
      "cmd": "git cherry-pick"
    },
    {
      "category": "",
      "name": "gmc",
      "cmd": "git merge --continue"
    },
    {
      "category": "",
      "name": "gma",
      "cmd": "git merge --abort"
    },
    {
      "category": "",
      "name": "gff",
      "cmd": "git merge --ff-only"
    },
    {
      "category": "",
      "name": "gwp",
      "cmd": "git worktree prune"
    },
    {
      "category": "",
      "name": "grepo",
      "cmd": "git init"
    },
    {
      "category": "",
      "name": "gtags",
      "cmd": "git tag -l"
    },
    {
      "category": "",
      "name": "gshow",
      "cmd": "git show"
    },
    {
      "category": "",
      "name": "gwip",
      "cmd": "git add -A && git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify -m \"wip\""
    },
    {
      "category": "",
      "name": "gwipe",
      "cmd": "git reset --hard && git clean --force -df"
    },
    {
      "category": "",
      "name": "nah",
      "cmd": "git reset --hard && git clean -df"
    },
    {
      "category": "",
      "name": "gbage",
      "cmd": "for k in $(git branch -a | sed \"s/^..//;s/ ->.*//\" 2>/dev/null); do echo -e \"$(git show --pretty=format:\"%ci %cr\" $k -- 2>/dev/null | head -1)\\t$k\"; done | sort -r"
    },
    {
      "category": "",
      "name": "gmn",
      "cmd": "git merge --no-ff --no-commit"
    },
    {
      "category": "",
      "name": "g",
      "cmd": "git"
    },
    {
      "category": "",
      "name": "ga",
      "cmd": "git add"
    },
    {
      "category": "",
      "name": "gaa",
      "cmd": "git add --all"
    },
    {
      "category": "",
      "name": "gau",
      "cmd": "git add -u"
    },
    {
      "category": "",
      "name": "gb",
      "cmd": "git branch"
    },
    {
      "category": "",
      "name": "gba",
      "cmd": "git branch -a"
    },
    {
      "category": "",
      "name": "gbd",
      "cmd": "git branch -d"
    },
    {
      "category": "",
      "name": "gbm",
      "cmd": "git branch -m"
    },
    {
      "category": "",
      "name": "gbc",
      "cmd": "git branch --show-current"
    },
    {
      "category": "",
      "name": "gc",
      "cmd": "git commit -v"
    },
    {
      "category": "",
      "name": "gca",
      "cmd": "git commit -a -v"
    },
    {
      "category": "",
      "name": "gcam",
      "cmd": "git commit --amend --no-edit"
    },
    {
      "category": "",
      "name": "gcne",
      "cmd": "git commit --no-edit"
    },
    {
      "category": "",
      "name": "gcnv",
      "cmd": "git commit --no-verify"
    },
    {
      "category": "",
      "name": "gco",
      "cmd": "git checkout"
    },
    {
      "category": "",
      "name": "gcb",
      "cmd": "git checkout -b"
    },
    {
      "category": "",
      "name": "gd",
      "cmd": "git diff"
    },
    {
      "category": "",
      "name": "gds",
      "cmd": "git diff --stat"
    },
    {
      "category": "",
      "name": "gf",
      "cmd": "git fetch"
    },
    {
      "category": "",
      "name": "gfa",
      "cmd": "git fetch --all"
    },
    {
      "category": "",
      "name": "gfr",
      "cmd": "git fetch --prune"
    },
    {
      "category": "",
      "name": "gi",
      "cmd": "git init"
    },
    {
      "category": "",
      "name": "gl",
      "cmd": "git log --oneline -n 20"
    },
    {
      "category": "",
      "name": "gp",
      "cmd": "git push"
    },
    {
      "category": "",
      "name": "gpo",
      "cmd": "git push origin"
    },
    {
      "category": "",
      "name": "gpoh",
      "cmd": "git push origin HEAD"
    },
    {
      "category": "",
      "name": "gpu",
      "cmd": "git push --set-upstream origin"
    },
    {
      "category": "",
      "name": "gplr",
      "cmd": "git pull --rebase"
    },
    {
      "category": "",
      "name": "gr",
      "cmd": "git remote -v"
    },
    {
      "category": "",
      "name": "gra",
      "cmd": "git remote add"
    },
    {
      "category": "",
      "name": "grm",
      "cmd": "git remote remove"
    },
    {
      "category": "",
      "name": "gs",
      "cmd": "git status"
    },
    {
      "category": "",
      "name": "gss",
      "cmd": "git status --short"
    },
    {
      "category": "",
      "name": "gst",
      "cmd": "git stash"
    },
    {
      "category": "",
      "name": "gstl",
      "cmd": "git stash list"
    },
    {
      "category": "",
      "name": "gstp",
      "cmd": "git stash pop"
    },
    {
      "category": "",
      "name": "gt",
      "cmd": "git tag"
    },
    {
      "category": "",
      "name": "gtl",
      "cmd": "git tag -l"
    },
    {
      "category": "",
      "name": "gtd",
      "cmd": "git tag -d"
    },
    {
      "category": "",
      "name": "gtop",
      "cmd": "gcd"
    },
    {
      "category": "",
      "name": "grh",
      "cmd": "git reset --hard"
    },
    {
      "category": "",
      "name": "grs",
      "cmd": "git reset --soft"
    },
    {
      "category": "",
      "name": "gm",
      "cmd": "git merge"
    },
    {
      "category": "",
      "name": "gmnf",
      "cmd": "git merge --no-ff"
    },
    {
      "category": "",
      "name": "gmt",
      "cmd": "git mergetool"
    },
    {
      "category": "",
      "name": "gmv",
      "cmd": "git mv"
    },
    {
      "category": "",
      "name": "grb",
      "cmd": "git rebase"
    },
    {
      "category": "",
      "name": "grbi",
      "cmd": "git rebase -i"
    },
    {
      "category": "",
      "name": "gcl1",
      "cmd": "git clone --depth=1"
    },
    {
      "category": "",
      "name": "gcf",
      "cmd": "git config"
    },
    {
      "category": "",
      "name": "gcfl",
      "cmd": "git config -l"
    },
    {
      "category": "",
      "name": "gk",
      "cmd": "gitk"
    },
    {
      "category": "",
      "name": "gkw",
      "cmd": "gitk --all"
    },
    {
      "category": "",
      "name": "gsh",
      "cmd": "git show"
    },
    {
      "category": "",
      "name": "gshs",
      "cmd": "git show --stat"
    },
    {
      "category": "",
      "name": "gshn",
      "cmd": "git show --name-only"
    },
    {
      "category": "",
      "name": "ghs",
      "cmd": "gh status"
    },
    {
      "category": "",
      "name": "ghp",
      "cmd": "gh pr"
    },
    {
      "category": "",
      "name": "ghpl",
      "cmd": "gh pr list"
    },
    {
      "category": "",
      "name": "ghpc",
      "cmd": "gh pr create"
    },
    {
      "category": "",
      "name": "ghpm",
      "cmd": "gh pr merge"
    },
    {
      "category": "",
      "name": "ghco",
      "cmd": "gh pr checkout"
    },
    {
      "category": "",
      "name": "ghi",
      "cmd": "gh issue"
    },
    {
      "category": "",
      "name": "ghil",
      "cmd": "gh issue list"
    },
    {
      "category": "",
      "name": "ghic",
      "cmd": "gh issue create"
    },
    {
      "category": "",
      "name": "ghr",
      "cmd": "gh release"
    },
    {
      "category": "",
      "name": "ghrl",
      "cmd": "gh release list"
    },
    {
      "category": "",
      "name": "ghrc",
      "cmd": "gh release create"
    },
    {
      "category": "",
      "name": "ghrd",
      "cmd": "gh release download"
    },
    {
      "category": "",
      "name": "ghrv",
      "cmd": "gh release view"
    },
    {
      "category": "",
      "name": "ghrep",
      "cmd": "gh repo"
    },
    {
      "category": "",
      "name": "ghrepv",
      "cmd": "gh repo view"
    },
    {
      "category": "",
      "name": "ghcl",
      "cmd": "gh repo clone"
    },
    {
      "category": "",
      "name": "ghcr",
      "cmd": "gh repo create"
    },
    {
      "category": "",
      "name": "ghw",
      "cmd": "gh workflow"
    },
    {
      "category": "",
      "name": "dk",
      "cmd": "_x docker"
    },
    {
      "category": "",
      "name": "dkps",
      "cmd": "_x docker ps"
    },
    {
      "category": "",
      "name": "dkpsa",
      "cmd": "_x docker ps -a"
    },
    {
      "category": "",
      "name": "dkim",
      "cmd": "_x docker images"
    },
    {
      "category": "",
      "name": "dkex",
      "cmd": "_x docker exec -it"
    },
    {
      "category": "",
      "name": "dklogs",
      "cmd": "_x docker logs -f"
    },
    {
      "category": "",
      "name": "dklogst",
      "cmd": "_x docker logs --tail 100 -f"
    },
    {
      "category": "",
      "name": "dkstop",
      "cmd": "_x docker stop $(docker ps -q)"
    },
    {
      "category": "",
      "name": "dkrm",
      "cmd": "_x docker rm $(docker ps -aq)"
    },
    {
      "category": "",
      "name": "dkrmi",
      "cmd": "_x docker rmi $(docker images -q)"
    },
    {
      "category": "",
      "name": "dkprune",
      "cmd": "_x docker system prune -af"
    },
    {
      "category": "",
      "name": "dkclean",
      "cmd": "_x docker system prune -af --volumes"
    },
    {
      "category": "",
      "name": "dkbuild",
      "cmd": "_x docker build -t"
    },
    {
      "category": "",
      "name": "dkrun",
      "cmd": "_x docker run -it --rm"
    },
    {
      "category": "",
      "name": "dkrunbg",
      "cmd": "_x docker run -d"
    },
    {
      "category": "",
      "name": "dkexec",
      "cmd": "_x docker exec -it"
    },
    {
      "category": "",
      "name": "dkstart",
      "cmd": "_x docker start"
    },
    {
      "category": "",
      "name": "dkrestart",
      "cmd": "_x docker restart"
    },
    {
      "category": "",
      "name": "dkpause",
      "cmd": "_x docker pause"
    },
    {
      "category": "",
      "name": "dkunpause",
      "cmd": "_x docker unpause"
    },
    {
      "category": "",
      "name": "dktop",
      "cmd": "_x docker top"
    },
    {
      "category": "",
      "name": "dkstats",
      "cmd": "_x docker stats"
    },
    {
      "category": "",
      "name": "dkcp",
      "cmd": "_x docker cp"
    },
    {
      "category": "",
      "name": "dkport",
      "cmd": "_x docker port"
    },
    {
      "category": "",
      "name": "dkcom",
      "cmd": "_x docker compose"
    },
    {
      "category": "",
      "name": "dkup",
      "cmd": "_x docker compose up -d"
    },
    {
      "category": "",
      "name": "dkdown",
      "cmd": "_x docker compose down"
    },
    {
      "category": "",
      "name": "dkpsall",
      "cmd": "_x docker compose ps"
    },
    {
      "category": "",
      "name": "dklogsall",
      "cmd": "_x docker compose logs -f"
    },
    {
      "category": "",
      "name": "dknet",
      "cmd": "_x docker network ls"
    },
    {
      "category": "",
      "name": "dkvol",
      "cmd": "_x docker volume ls"
    },
    {
      "category": "",
      "name": "dksys",
      "cmd": "_x docker system df"
    },
    {
      "category": "",
      "name": "docker-ip",
      "cmd": "_x docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 2>/dev/null"
    },
    {
      "category": "",
      "name": "dstats",
      "cmd": "_x docker stats --no-stream"
    },
    {
      "category": "",
      "name": "lzd",
      "cmd": "lazydocker"
    },
    {
      "category": "",
      "name": "sk",
      "cmd": "skopeo"
    },
    {
      "category": "",
      "name": "skc",
      "cmd": "skopeo copy"
    },
    {
      "category": "",
      "name": "skl",
      "cmd": "skopeo list-tags"
    },
    {
      "category": "",
      "name": "ski",
      "cmd": "skopeo inspect"
    },
    {
      "category": "",
      "name": "sks",
      "cmd": "skopeo sync"
    },
    {
      "category": "",
      "name": "hado",
      "cmd": "hadolint"
    },
    {
      "category": "",
      "name": "trivyi",
      "cmd": "trivy image"
    },
    {
      "category": "",
      "name": "trivyf",
      "cmd": "trivy fs"
    },
    {
      "category": "",
      "name": "trivyr",
      "cmd": "trivy repo"
    },
    {
      "category": "",
      "name": "cosignv",
      "cmd": "cosign verify"
    },
    {
      "category": "",
      "name": "cosigns",
      "cmd": "cosign sign"
    },
    {
      "category": "",
      "name": "pod",
      "cmd": "_x podman"
    },
    {
      "category": "",
      "name": "podps",
      "cmd": "_x podman ps"
    },
    {
      "category": "",
      "name": "podpsa",
      "cmd": "_x podman ps -a"
    },
    {
      "category": "",
      "name": "podim",
      "cmd": "_x podman images"
    },
    {
      "category": "",
      "name": "podex",
      "cmd": "_x podman exec -it"
    },
    {
      "category": "",
      "name": "podlogs",
      "cmd": "_x podman logs -f"
    },
    {
      "category": "",
      "name": "podstop",
      "cmd": "_x podman stop $(podman ps -q)"
    },
    {
      "category": "",
      "name": "podrm",
      "cmd": "_x podman rm $(podman ps -aq)"
    },
    {
      "category": "",
      "name": "podprune",
      "cmd": "_x podman system prune -af"
    },
    {
      "category": "",
      "name": "podbuild",
      "cmd": "_x podman build -t"
    },
    {
      "category": "",
      "name": "podrun",
      "cmd": "_x podman run -it --rm"
    },
    {
      "category": "",
      "name": "podcom",
      "cmd": "_x podman compose"
    },
    {
      "category": "",
      "name": "podup",
      "cmd": "_x podman compose up -d"
    },
    {
      "category": "",
      "name": "poddown",
      "cmd": "_x podman compose down"
    },
    {
      "category": "",
      "name": "kgpw",
      "cmd": "_x kubectl get pods -w"
    },
    {
      "category": "",
      "name": "kgns",
      "cmd": "_x kubectl get namespaces"
    },
    {
      "category": "",
      "name": "kuse",
      "cmd": "_x kubectl config use-context"
    },
    {
      "category": "",
      "name": "kd",
      "cmd": "_x kubectl describe"
    },
    {
      "category": "",
      "name": "kdp",
      "cmd": "_x kubectl describe pod"
    },
    {
      "category": "",
      "name": "kds",
      "cmd": "_x kubectl describe svc"
    },
    {
      "category": "",
      "name": "kdd",
      "cmd": "_x kubectl describe deployment"
    },
    {
      "category": "",
      "name": "kl",
      "cmd": "_x kubectl logs"
    },
    {
      "category": "",
      "name": "klf",
      "cmd": "_x kubectl logs -f"
    },
    {
      "category": "",
      "name": "ka",
      "cmd": "_x kubectl apply -f"
    },
    {
      "category": "",
      "name": "kpf",
      "cmd": "_x kubectl port-forward"
    },
    {
      "category": "",
      "name": "kexec",
      "cmd": "_x kubectl exec -it"
    },
    {
      "category": "",
      "name": "ktop",
      "cmd": "_x kubectl top pods"
    },
    {
      "category": "",
      "name": "ktopn",
      "cmd": "_x kubectl top nodes"
    },
    {
      "category": "",
      "name": "kedit",
      "cmd": "_x kubectl edit"
    },
    {
      "category": "",
      "name": "kc",
      "cmd": "_x kubectl create"
    },
    {
      "category": "",
      "name": "kcf",
      "cmd": "_x kubectl create -f"
    },
    {
      "category": "",
      "name": "kroll",
      "cmd": "_x kubectl rollout status"
    },
    {
      "category": "",
      "name": "krestart",
      "cmd": "_x kubectl rollout restart"
    },
    {
      "category": "",
      "name": "klabel",
      "cmd": "_x kubectl label"
    },
    {
      "category": "",
      "name": "ktaint",
      "cmd": "_x kubectl taint"
    },
    {
      "category": "",
      "name": "kcord",
      "cmd": "_x kubectl cordon"
    },
    {
      "category": "",
      "name": "kuncord",
      "cmd": "_x kubectl uncordon"
    },
    {
      "category": "",
      "name": "kdrain",
      "cmd": "_x kubectl drain"
    },
    {
      "category": "",
      "name": "kapi",
      "cmd": "_x kubectl api-resources"
    },
    {
      "category": "",
      "name": "kexplain",
      "cmd": "_x kubectl explain"
    },
    {
      "category": "",
      "name": "kns",
      "cmd": "_x kubectl config set-context --namespace"
    },
    {
      "category": "",
      "name": "kindc",
      "cmd": "kind create cluster"
    },
    {
      "category": "",
      "name": "kindd",
      "cmd": "kind delete cluster"
    },
    {
      "category": "",
      "name": "kindg",
      "cmd": "kind get clusters"
    },
    {
      "category": "",
      "name": "kindk",
      "cmd": "kind get kubeconfig"
    },
    {
      "category": "",
      "name": "mk",
      "cmd": "minikube"
    },
    {
      "category": "",
      "name": "mks",
      "cmd": "minikube start"
    },
    {
      "category": "",
      "name": "mkstop",
      "cmd": "minikube stop"
    },
    {
      "category": "",
      "name": "mkd",
      "cmd": "minikube delete"
    },
    {
      "category": "",
      "name": "mkst",
      "cmd": "minikube status"
    },
    {
      "category": "",
      "name": "mkpa",
      "cmd": "minikube pause"
    },
    {
      "category": "",
      "name": "mkun",
      "cmd": "minikube unpause"
    },
    {
      "category": "",
      "name": "mkdash",
      "cmd": "minikube dashboard"
    },
    {
      "category": "",
      "name": "kip",
      "cmd": "minikube ip"
    },
    {
      "category": "",
      "name": "mkadd",
      "cmd": "minikube addons list"
    },
    {
      "category": "",
      "name": "k0",
      "cmd": "k0s"
    },
    {
      "category": "",
      "name": "k0s",
      "cmd": "k0s status"
    },
    {
      "category": "",
      "name": "k0c",
      "cmd": "k0s kubectl"
    },
    {
      "category": "",
      "name": "k0start",
      "cmd": "k0s controller"
    },
    {
      "category": "",
      "name": "tals",
      "cmd": "talosctl version"
    },
    {
      "category": "",
      "name": "talc",
      "cmd": "talosctl config"
    },
    {
      "category": "",
      "name": "argo",
      "cmd": "argocd"
    },
    {
      "category": "",
      "name": "argol",
      "cmd": "argocd login"
    },
    {
      "category": "",
      "name": "argos",
      "cmd": "argocd app sync"
    },
    {
      "category": "",
      "name": "argog",
      "cmd": "argocd app get"
    },
    {
      "category": "",
      "name": "argolist",
      "cmd": "argocd app list"
    },
    {
      "category": "",
      "name": "argodiff",
      "cmd": "argocd app diff"
    },
    {
      "category": "",
      "name": "hl",
      "cmd": "_x helm"
    },
    {
      "category": "",
      "name": "hls",
      "cmd": "_x helm list"
    },
    {
      "category": "",
      "name": "hli",
      "cmd": "_x helm install"
    },
    {
      "category": "",
      "name": "hlu",
      "cmd": "_x helm upgrade"
    },
    {
      "category": "",
      "name": "hlui",
      "cmd": "_x helm upgrade --install"
    },
    {
      "category": "",
      "name": "hld",
      "cmd": "_x helm delete"
    },
    {
      "category": "",
      "name": "hlr",
      "cmd": "_x helm rollback"
    },
    {
      "category": "",
      "name": "hlg",
      "cmd": "_x helm get"
    },
    {
      "category": "",
      "name": "hlga",
      "cmd": "_x helm get all"
    },
    {
      "category": "",
      "name": "hlgs",
      "cmd": "_x helm get values"
    },
    {
      "category": "",
      "name": "hlh",
      "cmd": "_x helm history"
    },
    {
      "category": "",
      "name": "hlsh",
      "cmd": "_x helm show"
    },
    {
      "category": "",
      "name": "hlshc",
      "cmd": "_x helm show chart"
    },
    {
      "category": "",
      "name": "hlshv",
      "cmd": "_x helm show values"
    },
    {
      "category": "",
      "name": "hlrepo",
      "cmd": "_x helm repo"
    },
    {
      "category": "",
      "name": "hlrl",
      "cmd": "_x helm repo list"
    },
    {
      "category": "",
      "name": "hlra",
      "cmd": "_x helm repo add"
    },
    {
      "category": "",
      "name": "hlru",
      "cmd": "_x helm repo update"
    },
    {
      "category": "",
      "name": "hlsea",
      "cmd": "_x helm search"
    },
    {
      "category": "",
      "name": "hlver",
      "cmd": "_x helm version"
    },
    {
      "category": "",
      "name": "hlcomp",
      "cmd": "_x helm completion"
    },
    {
      "category": "",
      "name": "hlplug",
      "cmd": "_x helm plugin"
    },
    {
      "category": "",
      "name": "hlpl",
      "cmd": "_x helm plugin list"
    },
    {
      "category": "",
      "name": "scsr",
      "cmd": "_x systemctl restart"
    },
    {
      "category": "",
      "name": "scse",
      "cmd": "_x systemctl enable"
    },
    {
      "category": "",
      "name": "scsd",
      "cmd": "_x systemctl disable"
    },
    {
      "category": "",
      "name": "scn",
      "cmd": "_x systemctl daemon-reload"
    },
    {
      "category": "",
      "name": "scens",
      "cmd": "_x systemctl enable --now"
    },
    {
      "category": "",
      "name": "scdis",
      "cmd": "_x systemctl disable --now"
    },
    {
      "category": "",
      "name": "scu",
      "cmd": "_x systemctl --user"
    },
    {
      "category": "",
      "name": "scus",
      "cmd": "_x systemctl --user status"
    },
    {
      "category": "",
      "name": "scust",
      "cmd": "_x systemctl --user start"
    },
    {
      "category": "",
      "name": "scusp",
      "cmd": "_x systemctl --user stop"
    },
    {
      "category": "",
      "name": "scusr",
      "cmd": "_x systemctl --user restart"
    },
    {
      "category": "",
      "name": "scuse",
      "cmd": "_x systemctl --user enable"
    },
    {
      "category": "",
      "name": "scusd",
      "cmd": "_x systemctl --user disable"
    },
    {
      "category": "",
      "name": "scl",
      "cmd": "_x systemctl list-units"
    },
    {
      "category": "",
      "name": "scla",
      "cmd": "_x systemctl list-units --all"
    },
    {
      "category": "",
      "name": "scfail",
      "cmd": "_x systemctl list-units --failed"
    },
    {
      "category": "",
      "name": "scmask",
      "cmd": "_x systemctl mask"
    },
    {
      "category": "",
      "name": "scunmask",
      "cmd": "_x systemctl unmask"
    },
    {
      "category": "",
      "name": "sccat",
      "cmd": "_x systemctl cat"
    },
    {
      "category": "",
      "name": "sclist",
      "cmd": "_x systemctl list-unit-files"
    },
    {
      "category": "",
      "name": "scon",
      "cmd": "_x systemctl is-active"
    },
    {
      "category": "",
      "name": "serv",
      "cmd": "_x systemctl"
    },
    {
      "category": "",
      "name": "jc",
      "cmd": "_x journalctl"
    },
    {
      "category": "",
      "name": "jce",
      "cmd": "_x journalctl -e"
    },
    {
      "category": "",
      "name": "jcf",
      "cmd": "_x journalctl -f"
    },
    {
      "category": "",
      "name": "jcu",
      "cmd": "_x journalctl -u"
    },
    {
      "category": "",
      "name": "jcub",
      "cmd": "_x journalctl -u -b"
    },
    {
      "category": "",
      "name": "jcs",
      "cmd": "_x journalctl --since"
    },
    {
      "category": "",
      "name": "jct",
      "cmd": "_x journalctl --until"
    },
    {
      "category": "",
      "name": "jcp",
      "cmd": "_x journalctl -p err"
    },
    {
      "category": "",
      "name": "jcdf",
      "cmd": "_x journalctl --disk-usage"
    },
    {
      "category": "",
      "name": "jcro",
      "cmd": "_x journalctl --rotate"
    },
    {
      "category": "",
      "name": "jcv",
      "cmd": "_x journalctl --verify"
    },
    {
      "category": "",
      "name": "jcemerg",
      "cmd": "_x journalctl -p emerg"
    },
    {
      "category": "",
      "name": "jcalert",
      "cmd": "_x journalctl -p alert"
    },
    {
      "category": "",
      "name": "jccrit",
      "cmd": "_x journalctl -p crit"
    },
    {
      "category": "",
      "name": "jcwarn",
      "cmd": "_x journalctl -p warning"
    },
    {
      "category": "",
      "name": "jcnotice",
      "cmd": "_x journalctl -p notice"
    },
    {
      "category": "",
      "name": "jcinfo",
      "cmd": "_x journalctl -p info"
    },
    {
      "category": "",
      "name": "jcdebug",
      "cmd": "_x journalctl -p debug"
    },
    {
      "category": "",
      "name": "jcboot",
      "cmd": "_x journalctl -b"
    },
    {
      "category": "",
      "name": "jrnl",
      "cmd": "_x journalctl"
    },
    {
      "category": "",
      "name": "pac",
      "cmd": "sudo pacman"
    },
    {
      "category": "",
      "name": "pacs",
      "cmd": "_x pacman -Ss"
    },
    {
      "category": "",
      "name": "pacsi",
      "cmd": "_x pacman -Si"
    },
    {
      "category": "",
      "name": "pacq",
      "cmd": "_x pacman -Q"
    },
    {
      "category": "",
      "name": "pacqi",
      "cmd": "_x pacman -Qi"
    },
    {
      "category": "",
      "name": "pacql",
      "cmd": "_x pacman -Ql"
    },
    {
      "category": "",
      "name": "pacqo",
      "cmd": "_x pacman -Qo"
    },
    {
      "category": "",
      "name": "pacqs",
      "cmd": "_x pacman -Qs"
    },
    {
      "category": "",
      "name": "pacup",
      "cmd": "sudo pacman -Syu"
    },
    {
      "category": "",
      "name": "pacin",
      "cmd": "sudo pacman -S"
    },
    {
      "category": "",
      "name": "pacrm",
      "cmd": "sudo pacman -Rns"
    },
    {
      "category": "",
      "name": "pacrmu",
      "cmd": "sudo pacman -Rdd"
    },
    {
      "category": "",
      "name": "pacor",
      "cmd": "sudo pacman -Sc"
    },
    {
      "category": "",
      "name": "pacowned",
      "cmd": "_x pacman -Qii"
    },
    {
      "category": "",
      "name": "pacorph",
      "cmd": "_x pacman -Qtdq"
    },
    {
      "category": "",
      "name": "pacclean",
      "cmd": "sudo pacman -Rns $(pacman -Qtdq 2>/dev/null)"
    },
    {
      "category": "",
      "name": "paclsorph",
      "cmd": "_x pacman -Qtd"
    },
    {
      "category": "",
      "name": "pacfiles",
      "cmd": "_x pacman -Fl"
    },
    {
      "category": "",
      "name": "pacdep",
      "cmd": "_x pacman -Si"
    },
    {
      "category": "",
      "name": "pacwhy",
      "cmd": "_x pacman -D --asexplicit"
    },
    {
      "category": "",
      "name": "fixpacman",
      "cmd": "sudo rm -f /var/lib/pacman/db.lck"
    },
    {
      "category": "",
      "name": "yays",
      "cmd": "yay -Ss"
    },
    {
      "category": "",
      "name": "yayq",
      "cmd": "yay -Q"
    },
    {
      "category": "",
      "name": "yayup",
      "cmd": "yay -Syu"
    },
    {
      "category": "",
      "name": "yayi",
      "cmd": "yay -S"
    },
    {
      "category": "",
      "name": "yayrm",
      "cmd": "yay -Rns"
    },
    {
      "category": "",
      "name": "yayclean",
      "cmd": "yay -Sc"
    },
    {
      "category": "",
      "name": "yaygendb",
      "cmd": "yay -Y --gendb"
    },
    {
      "category": "",
      "name": "yaydev",
      "cmd": "yay -S --devel"
    },
    {
      "category": "",
      "name": "yayfiles",
      "cmd": "yay -Fl"
    },
    {
      "category": "",
      "name": "yayf",
      "cmd": "yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
    },
    {
      "category": "",
      "name": "apt",
      "cmd": "_x apt"
    },
    {
      "category": "",
      "name": "aptup",
      "cmd": "sudo apt update && sudo apt upgrade -y"
    },
    {
      "category": "",
      "name": "aptin",
      "cmd": "sudo apt install"
    },
    {
      "category": "",
      "name": "aptr",
      "cmd": "sudo apt remove"
    },
    {
      "category": "",
      "name": "aptp",
      "cmd": "sudo apt purge"
    },
    {
      "category": "",
      "name": "apts",
      "cmd": "_x apt search"
    },
    {
      "category": "",
      "name": "aptsh",
      "cmd": "_x apt show"
    },
    {
      "category": "",
      "name": "aptq",
      "cmd": "dpkg -l"
    },
    {
      "category": "",
      "name": "aptqi",
      "cmd": "dpkg -l | grep"
    },
    {
      "category": "",
      "name": "aptau",
      "cmd": "sudo apt autoremove"
    },
    {
      "category": "",
      "name": "aptd",
      "cmd": "sudo apt download"
    },
    {
      "category": "",
      "name": "aptsrc",
      "cmd": "sudo apt source"
    },
    {
      "category": "",
      "name": "aptbuild",
      "cmd": "sudo apt build-dep"
    },
    {
      "category": "",
      "name": "aptpolicy",
      "cmd": "_x apt policy"
    },
    {
      "category": "",
      "name": "aptchangelog",
      "cmd": "_x apt changelog"
    },
    {
      "category": "",
      "name": "aptlistup",
      "cmd": "_x apt list --upgradable"
    },
    {
      "category": "",
      "name": "aptlistins",
      "cmd": "_x apt list --installed"
    },
    {
      "category": "",
      "name": "apthold",
      "cmd": "sudo apt-mark hold"
    },
    {
      "category": "",
      "name": "aptunhold",
      "cmd": "sudo apt-mark unhold"
    },
    {
      "category": "",
      "name": "aptshowhold",
      "cmd": "apt-mark showhold"
    },
    {
      "category": "",
      "name": "aptfix",
      "cmd": "sudo apt --fix-broken install"
    },
    {
      "category": "",
      "name": "aptupdate",
      "cmd": "sudo apt update"
    },
    {
      "category": "",
      "name": "aptdistup",
      "cmd": "sudo apt full-upgrade"
    },
    {
      "category": "",
      "name": "dnf",
      "cmd": "_x dnf"
    },
    {
      "category": "",
      "name": "dnfs",
      "cmd": "_x dnf search"
    },
    {
      "category": "",
      "name": "dnfsi",
      "cmd": "_x dnf info"
    },
    {
      "category": "",
      "name": "dnfup",
      "cmd": "sudo dnf upgrade"
    },
    {
      "category": "",
      "name": "dnfi",
      "cmd": "sudo dnf install"
    },
    {
      "category": "",
      "name": "dnfrm",
      "cmd": "sudo dnf remove"
    },
    {
      "category": "",
      "name": "dnfau",
      "cmd": "sudo dnf autoremove"
    },
    {
      "category": "",
      "name": "dnfq",
      "cmd": "_x dnf list installed"
    },
    {
      "category": "",
      "name": "dnfqi",
      "cmd": "_x dnf list installed | grep"
    },
    {
      "category": "",
      "name": "dnfrep",
      "cmd": "_x dnf repolist"
    },
    {
      "category": "",
      "name": "dnfre",
      "cmd": "_x dnf group list"
    },
    {
      "category": "",
      "name": "dnfcache",
      "cmd": "sudo dnf clean all"
    },
    {
      "category": "",
      "name": "dnfhist",
      "cmd": "_x dnf history"
    },
    {
      "category": "",
      "name": "dnfhistinfo",
      "cmd": "_x dnf history info"
    },
    {
      "category": "",
      "name": "dnfroll",
      "cmd": "_x dnf history rollback"
    },
    {
      "category": "",
      "name": "dnfdowng",
      "cmd": "_x dnf downgrade"
    },
    {
      "category": "",
      "name": "dnflocal",
      "cmd": "sudo dnf localinstall"
    },
    {
      "category": "",
      "name": "dnfprov",
      "cmd": "_x dnf provides"
    },
    {
      "category": "",
      "name": "dnfchk",
      "cmd": "_x dnf check-update"
    },
    {
      "category": "",
      "name": "dnfmod",
      "cmd": "_x dnf module"
    },
    {
      "category": "",
      "name": "brew",
      "cmd": "_x brew"
    },
    {
      "category": "",
      "name": "brews",
      "cmd": "_x brew search"
    },
    {
      "category": "",
      "name": "brewin",
      "cmd": "_x brew install"
    },
    {
      "category": "",
      "name": "brewrm",
      "cmd": "_x brew uninstall"
    },
    {
      "category": "",
      "name": "brewq",
      "cmd": "_x brew list"
    },
    {
      "category": "",
      "name": "brewsrv",
      "cmd": "_x brew services"
    },
    {
      "category": "",
      "name": "brewsrvl",
      "cmd": "_x brew services list"
    },
    {
      "category": "",
      "name": "brewsrvr",
      "cmd": "_x brew services restart"
    },
    {
      "category": "",
      "name": "brewup",
      "cmd": "_x brew update && brew upgrade"
    },
    {
      "category": "",
      "name": "brewupc",
      "cmd": "_x brew update && brew upgrade && brew cleanup"
    },
    {
      "category": "",
      "name": "brewclean",
      "cmd": "_x brew cleanup"
    },
    {
      "category": "",
      "name": "brewdoc",
      "cmd": "_x brew doctor"
    },
    {
      "category": "",
      "name": "brewout",
      "cmd": "_x brew outdated"
    },
    {
      "category": "",
      "name": "brewpin",
      "cmd": "_x brew pin"
    },
    {
      "category": "",
      "name": "brewsr",
      "cmd": "_x brew tap"
    },
    {
      "category": "",
      "name": "brewinfo",
      "cmd": "_x brew info"
    },
    {
      "category": "",
      "name": "brewcask",
      "cmd": "_x brew install --cask"
    },
    {
      "category": "",
      "name": "brewdep",
      "cmd": "_x brew deps"
    },
    {
      "category": "",
      "name": "brewuses",
      "cmd": "_x brew uses"
    },
    {
      "category": "",
      "name": "brewleaves",
      "cmd": "_x brew leaves"
    },
    {
      "category": "",
      "name": "flat",
      "cmd": "flatpak"
    },
    {
      "category": "",
      "name": "flats",
      "cmd": "flatpak search"
    },
    {
      "category": "",
      "name": "flati",
      "cmd": "flatpak install"
    },
    {
      "category": "",
      "name": "flatrm",
      "cmd": "flatpak uninstall"
    },
    {
      "category": "",
      "name": "flatup",
      "cmd": "flatpak update"
    },
    {
      "category": "",
      "name": "flatq",
      "cmd": "flatpak list"
    },
    {
      "category": "",
      "name": "flatrun",
      "cmd": "flatpak run"
    },
    {
      "category": "",
      "name": "flatinfo",
      "cmd": "flatpak info"
    },
    {
      "category": "",
      "name": "flatover",
      "cmd": "flatpak override"
    },
    {
      "category": "",
      "name": "snaps",
      "cmd": "snap search"
    },
    {
      "category": "",
      "name": "snapi",
      "cmd": "sudo snap install"
    },
    {
      "category": "",
      "name": "snaprm",
      "cmd": "sudo snap remove"
    },
    {
      "category": "",
      "name": "snapup",
      "cmd": "sudo snap refresh"
    },
    {
      "category": "",
      "name": "snapq",
      "cmd": "snap list"
    },
    {
      "category": "",
      "name": "snapinfo",
      "cmd": "snap info"
    },
    {
      "category": "",
      "name": "snapch",
      "cmd": "sudo snap changes"
    },
    {
      "category": "",
      "name": "nixs",
      "cmd": "nix search"
    },
    {
      "category": "",
      "name": "nixsh",
      "cmd": "nix shell"
    },
    {
      "category": "",
      "name": "nixi",
      "cmd": "nix profile install"
    },
    {
      "category": "",
      "name": "nixrm",
      "cmd": "nix profile remove"
    },
    {
      "category": "",
      "name": "nixup",
      "cmd": "nix profile upgrade"
    },
    {
      "category": "",
      "name": "nixq",
      "cmd": "nix profile list"
    },
    {
      "category": "",
      "name": "nixdev",
      "cmd": "nix develop"
    },
    {
      "category": "",
      "name": "nixbuild",
      "cmd": "nix build"
    },
    {
      "category": "",
      "name": "nixrun",
      "cmd": "nix run"
    },
    {
      "category": "",
      "name": "nixgc",
      "cmd": "nix store gc"
    },
    {
      "category": "",
      "name": "nixopt",
      "cmd": "nix store optimise"
    },
    {
      "category": "",
      "name": "zyp",
      "cmd": "sudo zypper"
    },
    {
      "category": "",
      "name": "zyps",
      "cmd": "zypper search"
    },
    {
      "category": "",
      "name": "zypi",
      "cmd": "sudo zypper install"
    },
    {
      "category": "",
      "name": "zypr",
      "cmd": "sudo zypper remove"
    },
    {
      "category": "",
      "name": "zypup",
      "cmd": "sudo zypper update"
    },
    {
      "category": "",
      "name": "zypdup",
      "cmd": "sudo zypper dist-upgrade"
    },
    {
      "category": "",
      "name": "zypl",
      "cmd": "zypper list-installed"
    },
    {
      "category": "",
      "name": "zypclean",
      "cmd": "sudo zypper clean"
    },
    {
      "category": "",
      "name": "zyplr",
      "cmd": "zypper lr"
    },
    {
      "category": "",
      "name": "zypprov",
      "cmd": "zypper what-provides"
    },
    {
      "category": "",
      "name": "apks",
      "cmd": "apk search"
    },
    {
      "category": "",
      "name": "apki",
      "cmd": "apk add"
    },
    {
      "category": "",
      "name": "apkrm",
      "cmd": "apk del"
    },
    {
      "category": "",
      "name": "apkup",
      "cmd": "apk update && apk upgrade"
    },
    {
      "category": "",
      "name": "apkq",
      "cmd": "apk list"
    },
    {
      "category": "",
      "name": "apkqi",
      "cmd": "apk list -I"
    },
    {
      "category": "",
      "name": "apkinfo",
      "cmd": "apk info"
    },
    {
      "category": "",
      "name": "apkclean",
      "cmd": "apk cache clean"
    },
    {
      "category": "",
      "name": "nt",
      "cmd": "_x npm test"
    },
    {
      "category": "",
      "name": "nb",
      "cmd": "_x npm run build"
    },
    {
      "category": "",
      "name": "nrn",
      "cmd": "_x npm run --"
    },
    {
      "category": "",
      "name": "np",
      "cmd": "_x npm publish"
    },
    {
      "category": "",
      "name": "nup",
      "cmd": "_x npm update"
    },
    {
      "category": "",
      "name": "nout",
      "cmd": "_x npm outdated"
    },
    {
      "category": "",
      "name": "nls",
      "cmd": "_x npm list"
    },
    {
      "category": "",
      "name": "ndoc",
      "cmd": "_x npm docs"
    },
    {
      "category": "",
      "name": "ninit",
      "cmd": "_x npm init -y"
    },
    {
      "category": "",
      "name": "nstar",
      "cmd": "_x npm star"
    },
    {
      "category": "",
      "name": "nuni",
      "cmd": "_x npm uninstall"
    },
    {
      "category": "",
      "name": "nlex",
      "cmd": "_x npm exec"
    },
    {
      "category": "",
      "name": "nwhy",
      "cmd": "_x npm why"
    },
    {
      "category": "",
      "name": "naud",
      "cmd": "_x npm audit"
    },
    {
      "category": "",
      "name": "naux",
      "cmd": "_x npm audit fix"
    },
    {
      "category": "",
      "name": "pn",
      "cmd": "_x pnpm"
    },
    {
      "category": "",
      "name": "pni",
      "cmd": "_x pnpm install"
    },
    {
      "category": "",
      "name": "pnr",
      "cmd": "_x pnpm run"
    },
    {
      "category": "",
      "name": "pnd",
      "cmd": "_x pnpm run dev"
    },
    {
      "category": "",
      "name": "pnb",
      "cmd": "_x pnpm run build"
    },
    {
      "category": "",
      "name": "pnt",
      "cmd": "_x pnpm test"
    },
    {
      "category": "",
      "name": "pna",
      "cmd": "_x pnpm add"
    },
    {
      "category": "",
      "name": "pnad",
      "cmd": "_x pnpm add -D"
    },
    {
      "category": "",
      "name": "pnrm",
      "cmd": "_x pnpm remove"
    },
    {
      "category": "",
      "name": "pnup",
      "cmd": "_x pnpm update"
    },
    {
      "category": "",
      "name": "pnout",
      "cmd": "_x pnpm outdated"
    },
    {
      "category": "",
      "name": "pnls",
      "cmd": "_x pnpm list"
    },
    {
      "category": "",
      "name": "pninit",
      "cmd": "_x pnpm init"
    },
    {
      "category": "",
      "name": "pnpub",
      "cmd": "_x pnpm publish"
    },
    {
      "category": "",
      "name": "pnlint",
      "cmd": "_x pnpm lint"
    },
    {
      "category": "",
      "name": "pnex",
      "cmd": "_x pnpm exec"
    },
    {
      "category": "",
      "name": "pnlc",
      "cmd": "_x pnpm lint:check"
    },
    {
      "category": "",
      "name": "pnstore",
      "cmd": "_x pnpm store"
    },
    {
      "category": "",
      "name": "y",
      "cmd": "yarn"
    },
    {
      "category": "",
      "name": "ya",
      "cmd": "yarn add"
    },
    {
      "category": "",
      "name": "yad",
      "cmd": "yarn add -D"
    },
    {
      "category": "",
      "name": "yr",
      "cmd": "yarn run"
    },
    {
      "category": "",
      "name": "yb",
      "cmd": "yarn build"
    },
    {
      "category": "",
      "name": "yd",
      "cmd": "yarn dev"
    },
    {
      "category": "",
      "name": "yt",
      "cmd": "yarn test"
    },
    {
      "category": "",
      "name": "yrm",
      "cmd": "yarn remove"
    },
    {
      "category": "",
      "name": "yls",
      "cmd": "yarn list"
    },
    {
      "category": "",
      "name": "yinit",
      "cmd": "yarn init"
    },
    {
      "category": "",
      "name": "ypub",
      "cmd": "yarn publish"
    },
    {
      "category": "",
      "name": "ylint",
      "cmd": "yarn lint"
    },
    {
      "category": "",
      "name": "ygl",
      "cmd": "yarn global list"
    },
    {
      "category": "",
      "name": "yga",
      "cmd": "yarn global add"
    },
    {
      "category": "",
      "name": "cr",
      "cmd": "_x cargo"
    },
    {
      "category": "",
      "name": "crb",
      "cmd": "_x cargo build"
    },
    {
      "category": "",
      "name": "crbr",
      "cmd": "_x cargo build --release"
    },
    {
      "category": "",
      "name": "crr",
      "cmd": "_x cargo run"
    },
    {
      "category": "",
      "name": "crrr",
      "cmd": "_x cargo run --release"
    },
    {
      "category": "",
      "name": "crt",
      "cmd": "_x cargo test"
    },
    {
      "category": "",
      "name": "crcl",
      "cmd": "_x cargo clippy"
    },
    {
      "category": "",
      "name": "crf",
      "cmd": "_x cargo fmt"
    },
    {
      "category": "",
      "name": "crc",
      "cmd": "_x cargo check"
    },
    {
      "category": "",
      "name": "crd",
      "cmd": "_x cargo doc"
    },
    {
      "category": "",
      "name": "crp",
      "cmd": "_x cargo publish"
    },
    {
      "category": "",
      "name": "cru",
      "cmd": "_x cargo update"
    },
    {
      "category": "",
      "name": "crout",
      "cmd": "_x cargo outdated"
    },
    {
      "category": "",
      "name": "crclean",
      "cmd": "_x cargo clean"
    },
    {
      "category": "",
      "name": "crbench",
      "cmd": "_x cargo bench"
    },
    {
      "category": "",
      "name": "crfix",
      "cmd": "_x cargo fix"
    },
    {
      "category": "",
      "name": "crl",
      "cmd": "_x cargo +nightly"
    },
    {
      "category": "",
      "name": "crw",
      "cmd": "_x cargo watch"
    },
    {
      "category": "",
      "name": "cradd",
      "cmd": "_x cargo add"
    },
    {
      "category": "",
      "name": "crrm",
      "cmd": "_x cargo remove"
    },
    {
      "category": "",
      "name": "go",
      "cmd": "_x go"
    },
    {
      "category": "",
      "name": "gor",
      "cmd": "_x go run"
    },
    {
      "category": "",
      "name": "gob",
      "cmd": "_x go build"
    },
    {
      "category": "",
      "name": "got",
      "cmd": "_x go test"
    },
    {
      "category": "",
      "name": "gotv",
      "cmd": "_x go test -v ./..."
    },
    {
      "category": "",
      "name": "goi",
      "cmd": "_x go install"
    },
    {
      "category": "",
      "name": "gom",
      "cmd": "_x go mod"
    },
    {
      "category": "",
      "name": "gomt",
      "cmd": "_x go mod tidy"
    },
    {
      "category": "",
      "name": "gomv",
      "cmd": "_x go mod vendor"
    },
    {
      "category": "",
      "name": "gog",
      "cmd": "_x go get"
    },
    {
      "category": "",
      "name": "gof",
      "cmd": "_x go fmt ./..."
    },
    {
      "category": "",
      "name": "gol",
      "cmd": "_x go vet ./..."
    },
    {
      "category": "",
      "name": "godoc",
      "cmd": "_x go doc"
    },
    {
      "category": "",
      "name": "gogen",
      "cmd": "_x go generate ./..."
    },
    {
      "category": "",
      "name": "goc",
      "cmd": "_x go clean"
    },
    {
      "category": "",
      "name": "gocache",
      "cmd": "_x go clean -cache"
    },
    {
      "category": "",
      "name": "goenv",
      "cmd": "_x go env"
    },
    {
      "category": "",
      "name": "gop",
      "cmd": "_x go tool pprof"
    },
    {
      "category": "",
      "name": "py",
      "cmd": "_x python3"
    },
    {
      "category": "",
      "name": "py2",
      "cmd": "python2 2>/dev/null || python3"
    },
    {
      "category": "",
      "name": "py3",
      "cmd": "_x python3"
    },
    {
      "category": "",
      "name": "pipup",
      "cmd": "_x python3 -m pip install --upgrade pip"
    },
    {
      "category": "",
      "name": "venv",
      "cmd": "_x python3 -m venv .venv"
    },
    {
      "category": "",
      "name": "akt",
      "cmd": "source .venv/bin/activate"
    },
    {
      "category": "",
      "name": "dakt",
      "cmd": "deactivate"
    },
    {
      "category": "",
      "name": "pyreq",
      "cmd": "_x pip freeze > requirements.txt"
    },
    {
      "category": "",
      "name": "pyr",
      "cmd": "_x python3 -m pip install -r requirements.txt"
    },
    {
      "category": "",
      "name": "pyi",
      "cmd": "_x python3 -i"
    },
    {
      "category": "",
      "name": "pym",
      "cmd": "_x python3 -m"
    },
    {
      "category": "",
      "name": "pyt",
      "cmd": "_x python3 -m pytest"
    },
    {
      "category": "",
      "name": "pyun",
      "cmd": "_x python3 -m unittest"
    },
    {
      "category": "",
      "name": "pip",
      "cmd": "pip3 2>/dev/null || pip"
    },
    {
      "category": "",
      "name": "pi",
      "cmd": "_x pip install"
    },
    {
      "category": "",
      "name": "piu",
      "cmd": "_x pip install --upgrade"
    },
    {
      "category": "",
      "name": "pir",
      "cmd": "_x pip install -r requirements.txt"
    },
    {
      "category": "",
      "name": "pls",
      "cmd": "_x pip list"
    },
    {
      "category": "",
      "name": "pout",
      "cmd": "_x pip list --outdated"
    },
    {
      "category": "",
      "name": "psh",
      "cmd": "_x pip show"
    },
    {
      "category": "",
      "name": "pch",
      "cmd": "_x pip check"
    },
    {
      "category": "",
      "name": "pdown",
      "cmd": "_x pip download"
    },
    {
      "category": "",
      "name": "phash",
      "cmd": "_x pip hash"
    },
    {
      "category": "",
      "name": "json",
      "cmd": "python3 -m json.tool 2>/dev/null || echo \"python3 needed\""
    },
    {
      "category": "",
      "name": "xml",
      "cmd": "_x xmllint --format - 2>/dev/null || echo \"xmllint needed\""
    },
    {
      "category": "",
      "name": "yaml",
      "cmd": "_x python3 -c \"import sys,yaml; yaml.dump(yaml.safe_load(sys.stdin), sys.stdout, default_flow_style=False)\" 2>/dev/null || echo \"python3+yaml needed\""
    },
    {
      "category": "",
      "name": "csv",
      "cmd": "_x python3 -c \"import sys,csv; r=csv.reader(sys.stdin); [print(l) for l in r]\" 2>/dev/null || column -t -s, 2>/dev/null"
    },
    {
      "category": "",
      "name": "ts",
      "cmd": "_x python3 -c \"import sys,json; [print(json.dumps(eval(l))) for l in sys.stdin]\" 2>/dev/null"
    },
    {
      "category": "",
      "name": "math",
      "cmd": "_x python3 -c"
    },
    {
      "category": "",
      "name": "rstring",
      "cmd": "_x python3 -c \"import secrets; print(secrets.token_hex())\""
    },
    {
      "category": "",
      "name": "ssh",
      "cmd": "_x ssh"
    },
    {
      "category": "",
      "name": "ssha",
      "cmd": "_x ssh -A"
    },
    {
      "category": "",
      "name": "sshi",
      "cmd": "_x ssh -o StrictHostKeyChecking=no"
    },
    {
      "category": "",
      "name": "ssk",
      "cmd": "ssh-keygen"
    },
    {
      "category": "",
      "name": "sskr",
      "cmd": "ssh-keygen -R"
    },
    {
      "category": "",
      "name": "ssc",
      "cmd": "ssh-copy-id"
    },
    {
      "category": "",
      "name": "gpg",
      "cmd": "_x gpg"
    },
    {
      "category": "",
      "name": "gpge",
      "cmd": "_x gpg -e"
    },
    {
      "category": "",
      "name": "gpgd",
      "cmd": "_x gpg -d"
    },
    {
      "category": "",
      "name": "gpgs",
      "cmd": "_x gpg -s"
    },
    {
      "category": "",
      "name": "gpgv",
      "cmd": "_x gpg --verify"
    },
    {
      "category": "",
      "name": "gpgl",
      "cmd": "_x gpg --list-keys"
    },
    {
      "category": "",
      "name": "gpgls",
      "cmd": "_x gpg --list-secret-keys"
    },
    {
      "category": "",
      "name": "gpgk",
      "cmd": "_x gpg --list-keys"
    },
    {
      "category": "",
      "name": "gpgex",
      "cmd": "_x gpg --export"
    },
    {
      "category": "",
      "name": "gpgimport",
      "cmd": "_x gpg --import"
    },
    {
      "category": "",
      "name": "gpgrecv",
      "cmd": "_x gpg --recv-keys"
    },
    {
      "category": "",
      "name": "gpgens",
      "cmd": "_x gpg --gen-key"
    },
    {
      "category": "",
      "name": "myipl",
      "cmd": "ip addr show | grep \"inet \" | awk \"{print \\$2}\" | cut -d/ -f1 | head -1"
    },
    {
      "category": "",
      "name": "weather",
      "cmd": "curl -fsSL wttr.in"
    },
    {
      "category": "",
      "name": "portlisten",
      "cmd": "ss -tlnp 2>/dev/null || netstat -tlnp"
    },
    {
      "category": "",
      "name": "pingf",
      "cmd": "ping -c 100 -s 1472 -f"
    },
    {
      "category": "",
      "name": "pb",
      "cmd": "ping -c 4 8.8.8.8"
    },
    {
      "category": "",
      "name": "net",
      "cmd": "ip -br addr"
    },
    {
      "category": "",
      "name": "ipl",
      "cmd": "ip -br link"
    },
    {
      "category": "",
      "name": "ipa",
      "cmd": "ip -br addr"
    },
    {
      "category": "",
      "name": "ipr",
      "cmd": "ip route"
    },
    {
      "category": "",
      "name": "nst",
      "cmd": "netstat -tulanp 2>/dev/null || ss -tulanp"
    },
    {
      "category": "",
      "name": "trace",
      "cmd": "traceroute"
    },
    {
      "category": "",
      "name": "ip",
      "cmd": "ip -br addr"
    },
    {
      "category": "",
      "name": "myip",
      "cmd": "_x dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || _x curl -s ifconfig.me 2>/dev/null || echo \"N/A\""
    },
    {
      "category": "",
      "name": "dns",
      "cmd": "_x dig +short"
    },
    {
      "category": "",
      "name": "flush",
      "cmd": "_x sudo resolvectl flush-caches 2>/dev/null || _x sudo systemd-resolve --flush-caches 2>/dev/null || _x sudo killall -HUP mDNSResponder 2>/dev/null || echo \"no flush\""
    },
    {
      "category": "",
      "name": "speed",
      "cmd": "_x curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null | _x python3 - 2>/dev/null || echo \"speedtest-cli needed\""
    },
    {
      "category": "",
      "name": "weather3",
      "cmd": "_x curl -fsSL \"wttr.in?F\" 2>/dev/null || echo \"curl needed\""
    },
    {
      "category": "",
      "name": "moon",
      "cmd": "_x curl -fsSL \"wttr.in/Moon\" 2>/dev/null || echo \"curl needed\""
    },
    {
      "category": "",
      "name": "dnst",
      "cmd": "dig +short"
    },
    {
      "category": "",
      "name": "iftop",
      "cmd": "sudo iftop"
    },
    {
      "category": "",
      "name": "ping",
      "cmd": "_x prettyping 2>/dev/null || command ping"
    },
    {
      "category": "",
      "name": "dig",
      "cmd": "_x dog 2>/dev/null || command dig"
    },
    {
      "category": "",
      "name": "dns",
      "cmd": "dig +short"
    },
    {
      "category": "",
      "name": "dnsx",
      "cmd": "dig ANY +short"
    },
    {
      "category": "",
      "name": "dnsmx",
      "cmd": "dig MX +short"
    },
    {
      "category": "",
      "name": "dnsns",
      "cmd": "dig NS +short"
    },
    {
      "category": "",
      "name": "dnstxt",
      "cmd": "dig TXT +short"
    },
    {
      "category": "",
      "name": "dnsany",
      "cmd": "dig ANY"
    },
    {
      "category": "",
      "name": "nm",
      "cmd": "nmap"
    },
    {
      "category": "",
      "name": "nms",
      "cmd": "nmap -sn"
    },
    {
      "category": "",
      "name": "nmp",
      "cmd": "nmap -sV -sC"
    },
    {
      "category": "",
      "name": "nmo",
      "cmd": "nmap -O"
    },
    {
      "category": "",
      "name": "cur",
      "cmd": "curl -fsSL"
    },
    {
      "category": "",
      "name": "curh",
      "cmd": "curl -I"
    },
    {
      "category": "",
      "name": "curv",
      "cmd": "curl -v"
    },
    {
      "category": "",
      "name": "curj",
      "cmd": "curl -s | jq ."
    },
    {
      "category": "",
      "name": "curd",
      "cmd": "curl -X DELETE"
    },
    {
      "category": "",
      "name": "curp",
      "cmd": "curl -X POST"
    },
    {
      "category": "",
      "name": "curu",
      "cmd": "curl -X PUT"
    },
    {
      "category": "",
      "name": "wg",
      "cmd": "wget -c"
    },
    {
      "category": "",
      "name": "wgr",
      "cmd": "wget -r -np -nH"
    },
    {
      "category": "",
      "name": "ps",
      "cmd": "ps auxf"
    },
    {
      "category": "",
      "name": "pse",
      "cmd": "ps aux | grep"
    },
    {
      "category": "",
      "name": "pst",
      "cmd": "_x pstree"
    },
    {
      "category": "",
      "name": "psea",
      "cmd": "ps -e"
    },
    {
      "category": "",
      "name": "kill9",
      "cmd": "kill -9"
    },
    {
      "category": "",
      "name": "kill15",
      "cmd": "kill -15"
    },
    {
      "category": "",
      "name": "pkillf",
      "cmd": "_x pkill -f"
    },
    {
      "category": "",
      "name": "pid",
      "cmd": "_x pgrep -f"
    },
    {
      "category": "",
      "name": "nice",
      "cmd": "nice -n"
    },
    {
      "category": "",
      "name": "renice",
      "cmd": "renice -n"
    },
    {
      "category": "",
      "name": "topcpu",
      "cmd": "ps aux --sort=-%cpu | head 2>/dev/null || ps aux -r | head"
    },
    {
      "category": "",
      "name": "topmem",
      "cmd": "ps aux --sort=-%mem | head 2>/dev/null || ps aux -m | head"
    },
    {
      "category": "",
      "name": "iotop",
      "cmd": "iotop -o 2>/dev/null || echo \"iotop not found\""
    },
    {
      "category": "",
      "name": "pscpu",
      "cmd": "ps aux --sort=-%cpu"
    },
    {
      "category": "",
      "name": "psmem",
      "cmd": "ps aux --sort=-%mem"
    },
    {
      "category": "",
      "name": "psuser",
      "cmd": "ps -u"
    },
    {
      "category": "",
      "name": "psi",
      "cmd": "ps aux | grep -i"
    },
    {
      "category": "",
      "name": "psaux",
      "cmd": "ps aux"
    },
    {
      "category": "",
      "name": "psf",
      "cmd": "ps auxf"
    },
    {
      "category": "",
      "name": "psxl",
      "cmd": "ps aux --forest"
    },
    {
      "category": "",
      "name": "psymod",
      "cmd": "lsmod"
    },
    {
      "category": "",
      "name": "top",
      "cmd": "_x btop 2>/dev/null || _x htop 2>/dev/null || command top"
    },
    {
      "category": "",
      "name": "gri",
      "cmd": "grep -i"
    },
    {
      "category": "",
      "name": "grr",
      "cmd": "grep -r"
    },
    {
      "category": "",
      "name": "grri",
      "cmd": "grep -ri"
    },
    {
      "category": "",
      "name": "grl",
      "cmd": "grep -rl"
    },
    {
      "category": "",
      "name": "grc",
      "cmd": "grep -c"
    },
    {
      "category": "",
      "name": "uniqc",
      "cmd": "sort | uniq -c | sort -rn"
    },
    {
      "category": "",
      "name": "wcw",
      "cmd": "wc -w"
    },
    {
      "category": "",
      "name": "column",
      "cmd": "column -t"
    },
    {
      "category": "",
      "name": "diffy",
      "cmd": "diff -y"
    },
    {
      "category": "",
      "name": "tair",
      "cmd": "tail -f"
    },
    {
      "category": "",
      "name": "taill",
      "cmd": "tail -100"
    },
    {
      "category": "",
      "name": "headl",
      "cmd": "head -100"
    },
    {
      "category": "",
      "name": "nl",
      "cmd": "nl -ba"
    },
    {
      "category": "",
      "name": "tac",
      "cmd": "tac 2>/dev/null || tail -r"
    },
    {
      "category": "",
      "name": "grepw",
      "cmd": "grep -w"
    },
    {
      "category": "",
      "name": "grepr",
      "cmd": "grep -r"
    },
    {
      "category": "",
      "name": "grex",
      "cmd": "grep -r --exclude-dir=.git --exclude-dir=node_modules"
    },
    {
      "category": "",
      "name": "grep",
      "cmd": "_x rg --color=auto 2>/dev/null || command grep --color=auto"
    },
    {
      "category": "",
      "name": "diff",
      "cmd": "_x delta 2>/dev/null || command diff --color=auto 2>/dev/null || command diff"
    },
    {
      "category": "",
      "name": "rg",
      "cmd": "rg --hidden --glob \"!.git\""
    },
    {
      "category": "",
      "name": "rgi",
      "cmd": "rg -i --hidden --glob \"!.git\""
    },
    {
      "category": "",
      "name": "rgf",
      "cmd": "rg --files"
    },
    {
      "category": "",
      "name": "rgl",
      "cmd": "rg --files-with-matches"
    },
    {
      "category": "",
      "name": "rgc",
      "cmd": "rg --count"
    },
    {
      "category": "",
      "name": "cp",
      "cmd": "cp -i"
    },
    {
      "category": "",
      "name": "mv",
      "cmd": "mv -i"
    },
    {
      "category": "",
      "name": "rm",
      "cmd": "rm -i"
    },
    {
      "category": "",
      "name": "rmr",
      "cmd": "rm -r"
    },
    {
      "category": "",
      "name": "rmf",
      "cmd": "rm -f"
    },
    {
      "category": "",
      "name": "cpf",
      "cmd": "cp -f"
    },
    {
      "category": "",
      "name": "mvfs",
      "cmd": "mv -f"
    },
    {
      "category": "",
      "name": "cpv",
      "cmd": "_x rsync -ah --progress"
    },
    {
      "category": "",
      "name": "mkd",
      "cmd": "mkdir -p"
    },
    {
      "category": "",
      "name": "rsync",
      "cmd": "_x rsync -avz --progress"
    },
    {
      "category": "",
      "name": "rsyncdn",
      "cmd": "_x rsync -avz --dry-run --progress"
    },
    {
      "category": "",
      "name": "chx",
      "cmd": "chmod +x"
    },
    {
      "category": "",
      "name": "chm",
      "cmd": "chmod"
    },
    {
      "category": "",
      "name": "ln",
      "cmd": "ln -s"
    },
    {
      "category": "",
      "name": "lnh",
      "cmd": "readlink -f"
    },
    {
      "category": "",
      "name": "mount",
      "cmd": "mount | column -t"
    },
    {
      "category": "",
      "name": "mkdir",
      "cmd": "mkdir -p"
    },
    {
      "category": "",
      "name": "bc",
      "cmd": "bc -l"
    },
    {
      "category": "",
      "name": "find",
      "cmd": "_x fd 2>/dev/null || command find"
    },
    {
      "category": "",
      "name": "cat",
      "cmd": "_x bat --style=plain --paging=never 2>/dev/null || _x batcat --style=plain --paging=never 2>/dev/null || command cat"
    },
    {
      "category": "",
      "name": "fd",
      "cmd": "_x fd 2>/dev/null || find"
    },
    {
      "category": "",
      "name": "ff",
      "cmd": "find . -type f -name"
    },
    {
      "category": "",
      "name": "wget",
      "cmd": "_x wget 2>/dev/null || _x curl -fSL -o 2>/dev/null || echo \"no download tool\""
    },
    {
      "category": "",
      "name": "fd",
      "cmd": "fd --hidden"
    },
    {
      "category": "",
      "name": "fdi",
      "cmd": "fd -i"
    },
    {
      "category": "",
      "name": "shred",
      "cmd": "shred -uz"
    },
    {
      "category": "",
      "name": "shredf",
      "cmd": "shred -uz -n 7"
    },
    {
      "category": "",
      "name": "lsofi",
      "cmd": "lsof -i"
    },
    {
      "category": "",
      "name": "lsofp",
      "cmd": "lsof -P"
    },
    {
      "category": "",
      "name": "lsofn",
      "cmd": "lsof -nP"
    },
    {
      "category": "",
      "name": "lsof",
      "cmd": "_x lsof -i -P -n 2>/dev/null || echo \"lsof needed\""
    },
    {
      "category": "",
      "name": "tart",
      "cmd": "tar -tzf"
    },
    {
      "category": "",
      "name": "tarjx",
      "cmd": "tar -xjf"
    },
    {
      "category": "",
      "name": "tarjc",
      "cmd": "tar -cjf"
    },
    {
      "category": "",
      "name": "tarzx",
      "cmd": "tar -xJf"
    },
    {
      "category": "",
      "name": "tarzc",
      "cmd": "tar -cJf"
    },
    {
      "category": "",
      "name": "tarl",
      "cmd": "tar -tvf"
    },
    {
      "category": "",
      "name": "gunz",
      "cmd": "gunzip"
    },
    {
      "category": "",
      "name": "bz2",
      "cmd": "bzip2"
    },
    {
      "category": "",
      "name": "bunz",
      "cmd": "bunzip2"
    },
    {
      "category": "",
      "name": "7z",
      "cmd": "7z"
    },
    {
      "category": "",
      "name": "7zx",
      "cmd": "7z x"
    },
    {
      "category": "",
      "name": "7za",
      "cmd": "7z a"
    },
    {
      "category": "",
      "name": "rarx",
      "cmd": "unrar x"
    },
    {
      "category": "",
      "name": "ouchd",
      "cmd": "ouch decompress"
    },
    {
      "category": "",
      "name": "ouchc",
      "cmd": "ouch compress"
    },
    {
      "category": "",
      "name": "ouchl",
      "cmd": "ouch list"
    },
    {
      "category": "",
      "name": "myq",
      "cmd": "mysql"
    },
    {
      "category": "",
      "name": "myqr",
      "cmd": "mysql -u root -p"
    },
    {
      "category": "",
      "name": "mydump",
      "cmd": "mysqldump"
    },
    {
      "category": "",
      "name": "mydumpr",
      "cmd": "mysqldump -u root -p"
    },
    {
      "category": "",
      "name": "psqlr",
      "cmd": "psql -U postgres"
    },
    {
      "category": "",
      "name": "pgdump",
      "cmd": "pg_dump"
    },
    {
      "category": "",
      "name": "pgres",
      "cmd": "pg_restore"
    },
    {
      "category": "",
      "name": "sq3",
      "cmd": "sqlite3"
    },
    {
      "category": "",
      "name": "sq3d",
      "cmd": "sqlite3 .dump"
    },
    {
      "category": "",
      "name": "rcli",
      "cmd": "redis-cli"
    },
    {
      "category": "",
      "name": "rcliping",
      "cmd": "redis-cli ping"
    },
    {
      "category": "",
      "name": "rcliinfo",
      "cmd": "redis-cli info"
    },
    {
      "category": "",
      "name": "rclimon",
      "cmd": "redis-cli monitor"
    },
    {
      "category": "",
      "name": "s3",
      "cmd": "_x s3cmd"
    },
    {
      "category": "",
      "name": "awsw",
      "cmd": "aws sts get-caller-identity"
    },
    {
      "category": "",
      "name": "awsinfo",
      "cmd": "aws ec2 describe-instances"
    },
    {
      "category": "",
      "name": "awss3",
      "cmd": "aws s3"
    },
    {
      "category": "",
      "name": "awss3ls",
      "cmd": "aws s3 ls"
    },
    {
      "category": "",
      "name": "awslb",
      "cmd": "aws elb describe-load-balancers"
    },
    {
      "category": "",
      "name": "awsecs",
      "cmd": "aws ecs list-clusters"
    },
    {
      "category": "",
      "name": "awsecr",
      "cmd": "aws ecr describe-repositories"
    },
    {
      "category": "",
      "name": "awslam",
      "cmd": "aws lambda list-functions"
    },
    {
      "category": "",
      "name": "awslog",
      "cmd": "aws logs describe-log-groups"
    },
    {
      "category": "",
      "name": "awscw",
      "cmd": "aws cloudwatch"
    },
    {
      "category": "",
      "name": "awsiam",
      "cmd": "aws iam list-users"
    },
    {
      "category": "",
      "name": "awsr53",
      "cmd": "aws route53 list-hosted-zones"
    },
    {
      "category": "",
      "name": "gcl",
      "cmd": "gcloud"
    },
    {
      "category": "",
      "name": "gcls",
      "cmd": "gcloud compute ssh"
    },
    {
      "category": "",
      "name": "gcll",
      "cmd": "gcloud compute instances list"
    },
    {
      "category": "",
      "name": "gclc",
      "cmd": "gcloud container clusters list"
    },
    {
      "category": "",
      "name": "gclgke",
      "cmd": "gcloud container clusters get-credentials"
    },
    {
      "category": "",
      "name": "gcllogs",
      "cmd": "gcloud logging list"
    },
    {
      "category": "",
      "name": "azl",
      "cmd": "az vm list"
    },
    {
      "category": "",
      "name": "azs",
      "cmd": "az vm start"
    },
    {
      "category": "",
      "name": "azst",
      "cmd": "az vm stop"
    },
    {
      "category": "",
      "name": "azr",
      "cmd": "az vm restart"
    },
    {
      "category": "",
      "name": "azg",
      "cmd": "az group list"
    },
    {
      "category": "",
      "name": "azaks",
      "cmd": "az aks list"
    },
    {
      "category": "",
      "name": "ffp",
      "cmd": "ffprobe"
    },
    {
      "category": "",
      "name": "ffg",
      "cmd": "ffplay"
    },
    {
      "category": "",
      "name": "ffconvert",
      "cmd": "ffmpeg -i"
    },
    {
      "category": "",
      "name": "ffmp3",
      "cmd": "ffmpeg -i \"$1\" -q:a 0 \"${1%.*}.mp3\""
    },
    {
      "category": "",
      "name": "ffcompress",
      "cmd": "ffmpeg -i \"$1\" -vcodec libx265 -crf 28"
    },
    {
      "category": "",
      "name": "ffgif",
      "cmd": "ffmpeg -i \"$1\" -vf \"fps=10,scale=320:-1\" \"${1%.*}.gif\""
    },
    {
      "category": "",
      "name": "ffscreencap",
      "cmd": "ffmpeg -f x11grab -video_size 1920x1080 -i :0.0"
    },
    {
      "category": "",
      "name": "img",
      "cmd": "convert"
    },
    {
      "category": "",
      "name": "imgres",
      "cmd": "convert -resize"
    },
    {
      "category": "",
      "name": "imgfmt",
      "cmd": "convert -format"
    },
    {
      "category": "",
      "name": "imgcompress",
      "cmd": "convert -quality 85"
    },
    {
      "category": "",
      "name": "gpul",
      "cmd": "nvidia-smi --query-gpu=index,name,utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv"
    },
    {
      "category": "",
      "name": "gputop",
      "cmd": "nvidia-smi dmon -s pucvmet"
    },
    {
      "category": "",
      "name": "pbcopy",
      "cmd": "xclip -selection clipboard"
    },
    {
      "category": "",
      "name": "pbpaste",
      "cmd": "xclip -selection clipboard -o"
    },
    {
      "category": "",
      "name": "pbcopy",
      "cmd": "wl-copy"
    },
    {
      "category": "",
      "name": "pbpaste",
      "cmd": "wl-paste"
    },
    {
      "category": "",
      "name": "pbc",
      "cmd": "pbcopy"
    },
    {
      "category": "",
      "name": "pbp",
      "cmd": "pbpaste"
    },
    {
      "category": "",
      "name": "cpy",
      "cmd": "(command -v xclip >/dev/null 2>&1 && xclip -selection clipboard) || (command -v wl-copy >/dev/null 2>&1 && wl-copy) || (command -v pbcopy >/dev/null 2>&1 && pbcopy) || echo \"missing: clipboard tool\" >&2"
    },
    {
      "category": "",
      "name": "clickpaste",
      "cmd": "sleep 3; xdotool type \"$(xclip -o -selection clipboard)\""
    },
    {
      "category": "",
      "name": "randpw",
      "cmd": "openssl rand -base64 16 2>/dev/null || python3 -c \"import secrets; print(secrets.token_urlsafe(16))\""
    },
    {
      "category": "",
      "name": "sha",
      "cmd": "shasum -a 256"
    },
    {
      "category": "",
      "name": "md5sum",
      "cmd": "md5 2>/dev/null || command md5sum"
    },
    {
      "category": "",
      "name": "hex",
      "cmd": "xxd"
    },
    {
      "category": "",
      "name": "base64e",
      "cmd": "base64"
    },
    {
      "category": "",
      "name": "base64d",
      "cmd": "base64 -d"
    },
    {
      "category": "",
      "name": "urlenc",
      "cmd": "_x python3 -c \"import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))\""
    },
    {
      "category": "",
      "name": "urldec",
      "cmd": "_x python3 -c \"import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))\""
    },
    {
      "category": "",
      "name": "please",
      "cmd": "sudo"
    },
    {
      "category": "",
      "name": "pathlines",
      "cmd": "printf \"%s\\n\" ${PATH//:/\\\\n}"
    },
    {
      "category": "",
      "name": "mkdirp",
      "cmd": "mkdir -p"
    },
    {
      "category": "",
      "name": "focus",
      "cmd": "printf \"\\033c\" && date +\"%F %T\""
    },
    {
      "category": "",
      "name": "h",
      "cmd": "history"
    },
    {
      "category": "",
      "name": "j",
      "cmd": "jobs -l"
    },
    {
      "category": "",
      "name": "duh",
      "cmd": "du -sh"
    },
    {
      "category": "",
      "name": "dfh",
      "cmd": "df -h"
    },
    {
      "category": "",
      "name": "freeh",
      "cmd": "free -h"
    },
    {
      "category": "",
      "name": "free",
      "cmd": "free -h"
    },
    {
      "category": "",
      "name": "du",
      "cmd": "du -h"
    },
    {
      "category": "",
      "name": "dud",
      "cmd": "du -h --max-depth=1"
    },
    {
      "category": "",
      "name": "du2",
      "cmd": "du -sh --max-depth=2"
    },
    {
      "category": "",
      "name": "dux",
      "cmd": "du -sh * | sort -h"
    },
    {
      "category": "",
      "name": "duk",
      "cmd": "du -sh * | sort -h"
    },
    {
      "category": "",
      "name": "duf",
      "cmd": "du -sh * | sort -h"
    },
    {
      "category": "",
      "name": "duls",
      "cmd": "du -sm * | sort -n"
    },
    {
      "category": "",
      "name": "dus",
      "cmd": "du -sh .[!.]* * 2>/dev/null | sort -h"
    },
    {
      "category": "",
      "name": "usage",
      "cmd": "du -sh * 2>/dev/null | sort -h"
    },
    {
      "category": "",
      "name": "dfT",
      "cmd": "df -hT"
    },
    {
      "category": "",
      "name": "df",
      "cmd": "df -h"
    },
    {
      "category": "",
      "name": "diskspace",
      "cmd": "df -h"
    },
    {
      "category": "",
      "name": "blk",
      "cmd": "lsblk -f"
    },
    {
      "category": "",
      "name": "disks",
      "cmd": "lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT"
    },
    {
      "category": "",
      "name": "fdisk",
      "cmd": "fdisk -l"
    },
    {
      "category": "",
      "name": "smart",
      "cmd": "sudo smartctl -a"
    },
    {
      "category": "",
      "name": "cpuinfo",
      "cmd": "lscpu 2>/dev/null || sysctl -n machdep.cpu.brand_string"
    },
    {
      "category": "",
      "name": "meminfo",
      "cmd": "free -h"
    },
    {
      "category": "",
      "name": "dmesg",
      "cmd": "dmesg -T"
    },
    {
      "category": "",
      "name": "uname",
      "cmd": "uname -a"
    },
    {
      "category": "",
      "name": "dateutc",
      "cmd": "date -u"
    },
    {
      "category": "",
      "name": "caldate",
      "cmd": "cal"
    },
    {
      "category": "",
      "name": "nproc",
      "cmd": "nproc 2>/dev/null || sysctl -n hw.ncpu"
    },
    {
      "category": "",
      "name": "release",
      "cmd": "cat /etc/os-release 2>/dev/null || cat /usr/lib/os-release"
    },
    {
      "category": "",
      "name": "arch",
      "cmd": "uname -m"
    },
    {
      "category": "",
      "name": "findsuid",
      "cmd": "find / -perm -4000 -type f"
    },
    {
      "category": "",
      "name": "timestamp",
      "cmd": "date +%s"
    },
    {
      "category": "",
      "name": "today",
      "cmd": "date +%F"
    },
    {
      "category": "",
      "name": "week",
      "cmd": "date +%V"
    },
    {
      "category": "",
      "name": "count",
      "cmd": "wc -l"
    },
    {
      "category": "",
      "name": "lines",
      "cmd": "cat -n"
    },
    {
      "category": "",
      "name": "cht",
      "cmd": "curl -fsSL \"https://cht.sh/$1\""
    },
    {
      "category": "",
      "name": "learn",
      "cmd": "curl -fsSL \"https://learnxinyminutes.com/docs/$1\""
    },
    {
      "category": "",
      "name": "cheat",
      "cmd": "curl -fsSL \"https://cheat.sh/$1\""
    },
    {
      "category": "",
      "name": "try",
      "cmd": "curl -fsSL https://cht.sh"
    },
    {
      "category": "",
      "name": "tldrl",
      "cmd": "curl -fsSL https://cheat.sh"
    },
    {
      "category": "",
      "name": "what",
      "cmd": "type"
    },
    {
      "category": "",
      "name": "ali",
      "cmd": "alias"
    },
    {
      "category": "",
      "name": "envg",
      "cmd": "env | grep"
    },
    {
      "category": "",
      "name": "fn",
      "cmd": "declare -f 2>/dev/null || typeset -f"
    },
    {
      "category": "",
      "name": "path",
      "cmd": "echo \\$PATH | tr ':' '\\\\n' | sort -u"
    },
    {
      "category": "",
      "name": "nohist",
      "cmd": "unset HISTFILE"
    },
    {
      "category": "",
      "name": "clhist",
      "cmd": "HISTSIZE=0; HISTSIZE=5000"
    },
    {
      "category": "",
      "name": "histgrep",
      "cmd": "history | grep -i"
    },
    {
      "category": "",
      "name": "cleanshell",
      "cmd": "env - bash --norc --noprofile"
    },
    {
      "category": "",
      "name": "topcmds",
      "cmd": "topcommands"
    },
    {
      "category": "",
      "name": "port",
      "cmd": "_x ss -tlnp 2>/dev/null || _x netstat -tlnp 2>/dev/null || echo \"no port tool\""
    },
    {
      "category": "",
      "name": "ports",
      "cmd": "_x ss -tulpn 2>/dev/null || _x netstat -tulpn 2>/dev/null || _x lsof -i -n -P 2>/dev/null"
    },
    {
      "category": "",
      "name": "listen",
      "cmd": "_x ss -tlnp 2>/dev/null || _x netstat -tlnp 2>/dev/null"
    },
    {
      "category": "",
      "name": "connections",
      "cmd": "_x ss -tunp 2>/dev/null || _x netstat -tunp 2>/dev/null"
    },
    {
      "category": "",
      "name": "dsstore",
      "cmd": "find . -name \".DS_Store\" -type f -delete -print 2>/dev/null"
    },
    {
      "category": "",
      "name": "mirrorsite",
      "cmd": "_x wget -m -k -K -E -e robots=off 2>/dev/null || echo \"wget needed\""
    },
    {
      "category": "",
      "name": "sep",
      "cmd": "printf \"=%.0s\" $(seq 1 $(tput cols))"
    },
    {
      "category": "",
      "name": "countfiles",
      "cmd": "for t in files links directories; do echo $(find . -type ${t:0:1} 2>/dev/null | wc -l) $t; done 2>/dev/null"
    },
    {
      "category": "",
      "name": "tstamp",
      "cmd": "stamp"
    },
    {
      "category": "",
      "name": "idg",
      "cmd": "id -g"
    },
    {
      "category": "",
      "name": "idu",
      "cmd": "id -u"
    },
    {
      "category": "",
      "name": "shuffle",
      "cmd": "shuf"
    },
    {
      "category": "",
      "name": "rsample",
      "cmd": "shuf -n"
    },
    {
      "category": "",
      "name": "man",
      "cmd": "_x tldr 2>/dev/null || command man"
    },
    {
      "category": "",
      "name": "tad",
      "cmd": "_x tmux attach -d"
    },
    {
      "category": "",
      "name": "tl",
      "cmd": "_x tmux list-sessions"
    },
    {
      "category": "",
      "name": "tn",
      "cmd": "_x tmux new-session -s"
    },
    {
      "category": "",
      "name": "tk",
      "cmd": "_x tmux kill-session -t"
    },
    {
      "category": "",
      "name": "tks",
      "cmd": "_x tmux kill-server"
    },
    {
      "category": "",
      "name": "tsw",
      "cmd": "_x tmux switch-client"
    },
    {
      "category": "",
      "name": "trn",
      "cmd": "_x tmux rename-session"
    },
    {
      "category": "",
      "name": "tlp",
      "cmd": "_x tmux list-panes"
    },
    {
      "category": "",
      "name": "tsplit",
      "cmd": "_x tmux split-window -h"
    },
    {
      "category": "",
      "name": "tsplitv",
      "cmd": "_x tmux split-window"
    },
    {
      "category": "",
      "name": "tprev",
      "cmd": "_x tmux previous-window"
    },
    {
      "category": "",
      "name": "tnext",
      "cmd": "_x tmux next-window"
    },
    {
      "category": "",
      "name": "tswap",
      "cmd": "_x tmux swap-window"
    },
    {
      "category": "",
      "name": "vim",
      "cmd": "nvim 2>/dev/null || command vim"
    },
    {
      "category": "",
      "name": "sv",
      "cmd": "nvim 2>/dev/null || command vim"
    },
    {
      "category": "",
      "name": "nv",
      "cmd": "nvim"
    },
    {
      "category": "",
      "name": "codel",
      "cmd": "code ."
    },
    {
      "category": "",
      "name": "svi",
      "cmd": "sudo nvim"
    },
    {
      "category": "",
      "name": "vis",
      "cmd": "nvim \"+set si\""
    },
    {
      "category": "",
      "name": "svi",
      "cmd": "sudo vim"
    },
    {
      "category": "",
      "name": "vis",
      "cmd": "vim \"+set si\""
    },
    {
      "category": "",
      "name": "lg",
      "cmd": "lazygit"
    },
    {
      "category": "",
      "name": "yz",
      "cmd": "yazi"
    },
    {
      "category": "",
      "name": "zj",
      "cmd": "zellij"
    },
    {
      "category": "",
      "name": "zja",
      "cmd": "zellij attach"
    },
    {
      "category": "",
      "name": "zjl",
      "cmd": "zellij list-sessions"
    },
    {
      "category": "",
      "name": "justl",
      "cmd": "just --list"
    },
    {
      "category": "",
      "name": "mk",
      "cmd": "make"
    },
    {
      "category": "",
      "name": "mkc",
      "cmd": "make clean"
    },
    {
      "category": "",
      "name": "mki",
      "cmd": "make install"
    },
    {
      "category": "",
      "name": "mkt",
      "cmd": "make test"
    },
    {
      "category": "",
      "name": "atu",
      "cmd": "atuin"
    },
    {
      "category": "",
      "name": "atus",
      "cmd": "atuin search"
    },
    {
      "category": "",
      "name": "atul",
      "cmd": "atuin login"
    },
    {
      "category": "",
      "name": "atur",
      "cmd": "atuin register"
    },
    {
      "category": "",
      "name": "atusync",
      "cmd": "atuin sync"
    },
    {
      "category": "",
      "name": "atust",
      "cmd": "atuin status"
    },
    {
      "category": "",
      "name": "atuh",
      "cmd": "atuin history"
    },
    {
      "category": "",
      "name": "atuhl",
      "cmd": "atuin history list"
    },
    {
      "category": "",
      "name": "atustats",
      "cmd": "atuin stats"
    },
    {
      "category": "",
      "name": "dir",
      "cmd": "direnv"
    },
    {
      "category": "",
      "name": "dira",
      "cmd": "direnv allow"
    },
    {
      "category": "",
      "name": "dird",
      "cmd": "direnv deny"
    },
    {
      "category": "",
      "name": "dirr",
      "cmd": "direnv reload"
    },
    {
      "category": "",
      "name": "dire",
      "cmd": "direnv edit"
    },
    {
      "category": "",
      "name": "dirv",
      "cmd": "direnv view"
    },
    {
      "category": "",
      "name": "dirh",
      "cmd": "direnv hook"
    },
    {
      "category": "",
      "name": "fz",
      "cmd": "fzf"
    },
    {
      "category": "",
      "name": "fzp",
      "cmd": "fzf --preview"
    },
    {
      "category": "",
      "name": "jqc",
      "cmd": "jq -c"
    },
    {
      "category": "",
      "name": "jqr",
      "cmd": "jq -r"
    },
    {
      "category": "",
      "name": "jqs",
      "cmd": "jq -S"
    },
    {
      "category": "",
      "name": "yqe",
      "cmd": "yq eval"
    },
    {
      "category": "",
      "name": "yqp",
      "cmd": "yq eval -P"
    },
    {
      "category": "",
      "name": "glows",
      "cmd": "glow -s"
    },
    {
      "category": "",
      "name": "doga",
      "cmd": "dog A"
    },
    {
      "category": "",
      "name": "dogmx",
      "cmd": "dog MX"
    },
    {
      "category": "",
      "name": "dogns",
      "cmd": "dog NS"
    },
    {
      "category": "",
      "name": "dogtxt",
      "cmd": "dog TXT"
    },
    {
      "category": "",
      "name": "band",
      "cmd": "bandwhich"
    },
    {
      "category": "",
      "name": "bandl",
      "cmd": "bandwhich -r"
    },
    {
      "category": "",
      "name": "naviq",
      "cmd": "navi --query"
    },
    {
      "category": "",
      "name": "tldr",
      "cmd": "command tldr 2>/dev/null || tealdeer"
    },
    {
      "category": "",
      "name": "vividg",
      "cmd": "vivid generate"
    },
    {
      "category": "",
      "name": "vividt",
      "cmd": "vivid themes"
    },
    {
      "category": "",
      "name": "chez",
      "cmd": "chezmoi"
    },
    {
      "category": "",
      "name": "cheza",
      "cmd": "chezmoi apply"
    },
    {
      "category": "",
      "name": "chezd",
      "cmd": "chezmoi diff"
    },
    {
      "category": "",
      "name": "cheze",
      "cmd": "chezmoi edit"
    },
    {
      "category": "",
      "name": "chezad",
      "cmd": "chezmoi add"
    },
    {
      "category": "",
      "name": "chezup",
      "cmd": "chezmoi update"
    },
    {
      "category": "",
      "name": "chezcd",
      "cmd": "chezmoi cd"
    },
    {
      "category": "",
      "name": "chezi",
      "cmd": "chezmoi init"
    },
    {
      "category": "",
      "name": "chezs",
      "cmd": "chezmoi status"
    },
    {
      "category": "",
      "name": "chezr",
      "cmd": "chezmoi re-add"
    },
    {
      "category": "",
      "name": "actl",
      "cmd": "act -l"
    },
    {
      "category": "",
      "name": "actp",
      "cmd": "act -p"
    },
    {
      "category": "",
      "name": "actpush",
      "cmd": "act push"
    },
    {
      "category": "",
      "name": "actpr",
      "cmd": "act pull_request"
    },
    {
      "category": "",
      "name": "actw",
      "cmd": "act -W"
    },
    {
      "category": "",
      "name": "vg",
      "cmd": "vagrant"
    },
    {
      "category": "",
      "name": "vgu",
      "cmd": "vagrant up"
    },
    {
      "category": "",
      "name": "vgh",
      "cmd": "vagrant halt"
    },
    {
      "category": "",
      "name": "vgd",
      "cmd": "vagrant destroy"
    },
    {
      "category": "",
      "name": "vgs",
      "cmd": "vagrant status"
    },
    {
      "category": "",
      "name": "vgssh",
      "cmd": "vagrant ssh"
    },
    {
      "category": "",
      "name": "vgp",
      "cmd": "vagrant provision"
    },
    {
      "category": "",
      "name": "vgreload",
      "cmd": "vagrant reload"
    },
    {
      "category": "",
      "name": "vgbox",
      "cmd": "vagrant box list"
    },
    {
      "category": "",
      "name": "pk",
      "cmd": "packer"
    },
    {
      "category": "",
      "name": "pkb",
      "cmd": "packer build"
    },
    {
      "category": "",
      "name": "pkv",
      "cmd": "packer validate"
    },
    {
      "category": "",
      "name": "pkf",
      "cmd": "packer fmt"
    },
    {
      "category": "",
      "name": "pkinit",
      "cmd": "packer init"
    },
    {
      "category": "",
      "name": "tfv",
      "cmd": "_x terraform validate"
    },
    {
      "category": "",
      "name": "tff",
      "cmd": "_x terraform fmt"
    },
    {
      "category": "",
      "name": "tfw",
      "cmd": "_x terraform workspace"
    },
    {
      "category": "",
      "name": "tfwl",
      "cmd": "_x terraform workspace list"
    },
    {
      "category": "",
      "name": "tfws",
      "cmd": "_x terraform workspace select"
    },
    {
      "category": "",
      "name": "tfs",
      "cmd": "_x terraform show"
    },
    {
      "category": "",
      "name": "tfo",
      "cmd": "_x terraform output"
    },
    {
      "category": "",
      "name": "tfst",
      "cmd": "_x terraform state"
    },
    {
      "category": "",
      "name": "tfstl",
      "cmd": "_x terraform state list"
    },
    {
      "category": "",
      "name": "tfimp",
      "cmd": "_x terraform import"
    },
    {
      "category": "",
      "name": "tfprov",
      "cmd": "_x terraform providers"
    },
    {
      "category": "",
      "name": "tfgraph",
      "cmd": "_x terraform graph"
    },
    {
      "category": "",
      "name": "tfconsole",
      "cmd": "_x terraform console"
    },
    {
      "category": "",
      "name": "an",
      "cmd": "_x ansible"
    },
    {
      "category": "",
      "name": "anp",
      "cmd": "_x ansible-playbook"
    },
    {
      "category": "",
      "name": "ang",
      "cmd": "_x ansible-galaxy"
    },
    {
      "category": "",
      "name": "anv",
      "cmd": "_x ansible-vault"
    },
    {
      "category": "",
      "name": "and",
      "cmd": "_x ansible-doc"
    },
    {
      "category": "",
      "name": "ancon",
      "cmd": "_x ansible-config"
    },
    {
      "category": "",
      "name": "aninv",
      "cmd": "_x ansible-inventory"
    },
    {
      "category": "",
      "name": "agee",
      "cmd": "age -e"
    },
    {
      "category": "",
      "name": "aged",
      "cmd": "age -d"
    },
    {
      "category": "",
      "name": "agegen",
      "cmd": "age-keygen"
    },
    {
      "category": "",
      "name": "sopse",
      "cmd": "sops -e"
    },
    {
      "category": "",
      "name": "sopsd",
      "cmd": "sops -d"
    },
    {
      "category": "",
      "name": "sopsi",
      "cmd": "sops -i"
    },
    {
      "category": "",
      "name": "vaults",
      "cmd": "vault status"
    },
    {
      "category": "",
      "name": "vaultl",
      "cmd": "vault login"
    },
    {
      "category": "",
      "name": "vaultkv",
      "cmd": "vault kv"
    },
    {
      "category": "",
      "name": "vaultkvg",
      "cmd": "vault kv get"
    },
    {
      "category": "",
      "name": "vaultkvp",
      "cmd": "vault kv put"
    },
    {
      "category": "",
      "name": "vaultkvd",
      "cmd": "vault kv delete"
    },
    {
      "category": "",
      "name": "vaultr",
      "cmd": "vault read"
    },
    {
      "category": "",
      "name": "vaultw",
      "cmd": "vault write"
    },
    {
      "category": "",
      "name": "ossl",
      "cmd": "openssl"
    },
    {
      "category": "",
      "name": "osslcsr",
      "cmd": "openssl req -new -newkey rsa:2048 -nodes"
    },
    {
      "category": "",
      "name": "osslchk",
      "cmd": "openssl s_client -connect"
    },
    {
      "category": "",
      "name": "osslx",
      "cmd": "openssl x509 -in"
    },
    {
      "category": "",
      "name": "osslr",
      "cmd": "openssl rand -hex"
    },
    {
      "category": "",
      "name": "osslgen",
      "cmd": "openssl genrsa"
    },
    {
      "category": "",
      "name": "rcl",
      "cmd": "rclone"
    },
    {
      "category": "",
      "name": "rclls",
      "cmd": "rclone ls"
    },
    {
      "category": "",
      "name": "rclsync",
      "cmd": "rclone sync"
    },
    {
      "category": "",
      "name": "rclc",
      "cmd": "rclone copy"
    },
    {
      "category": "",
      "name": "rclmv",
      "cmd": "rclone move"
    },
    {
      "category": "",
      "name": "rest",
      "cmd": "restic"
    },
    {
      "category": "",
      "name": "restb",
      "cmd": "restic backup"
    },
    {
      "category": "",
      "name": "restr",
      "cmd": "restic restore"
    },
    {
      "category": "",
      "name": "rests",
      "cmd": "restic snapshots"
    },
    {
      "category": "",
      "name": "restc",
      "cmd": "restic check"
    },
    {
      "category": "",
      "name": "borgc",
      "cmd": "borg create"
    },
    {
      "category": "",
      "name": "borge",
      "cmd": "borg extract"
    },
    {
      "category": "",
      "name": "borgl",
      "cmd": "borg list"
    },
    {
      "category": "",
      "name": "borgi",
      "cmd": "borg info"
    },
    {
      "category": "",
      "name": "borgd",
      "cmd": "borg delete"
    },
    {
      "category": "",
      "name": "borgpr",
      "cmd": "borg prune"
    },
    {
      "category": "",
      "name": "kop",
      "cmd": "kopia"
    },
    {
      "category": "",
      "name": "kops",
      "cmd": "kopia snapshot create"
    },
    {
      "category": "",
      "name": "kopl",
      "cmd": "kopia snapshot list"
    },
    {
      "category": "",
      "name": "kopm",
      "cmd": "kopia mount"
    },
    {
      "category": "",
      "name": "kopc",
      "cmd": "kopia cache clear"
    },
    {
      "category": "",
      "name": "hf",
      "cmd": "hyperfine"
    },
    {
      "category": "",
      "name": "hfw",
      "cmd": "hyperfine --warmup"
    },
    {
      "category": "",
      "name": "ffet",
      "cmd": "_x fastfetch"
    },
    {
      "category": "",
      "name": "ffetl",
      "cmd": "_x fastfetch -l"
    },
    {
      "category": "",
      "name": "pur",
      "cmd": "_x curl -fsSL \"https://cht.sh/$1\" 2>/dev/null"
    },
    {
      "category": "",
      "name": "pod",
      "cmd": "_x podman"
    },
    {
      "category": "",
      "name": "podps",
      "cmd": "_x podman ps"
    },
    {
      "category": "",
      "name": "podrun",
      "cmd": "_x podman run -it --rm"
    },
    {
      "category": "",
      "name": "podimg",
      "cmd": "_x podman images"
    },
    {
      "category": "",
      "name": "dstats",
      "cmd": "_x docker stats --no-stream"
    },
    {
      "category": "",
      "name": "kns",
      "cmd": "_x kubectl config set-context --namespace"
    },
    {
      "category": "",
      "name": "py",
      "cmd": "_x python3"
    },
    {
      "category": "",
      "name": "clickpaste",
      "cmd": "sleep 3; xdotool type \"$(xclip -o -selection clipboard)\""
    },
    {
      "category": "",
      "name": "nuke-opencode",
      "cmd": "rm -rf ~/.local/share/opencode ~/.cache/opencode"
    }
  ],
  "functions": [
    {
      "category": "General",
      "name": "mkcd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "take",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "up",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "back",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cdup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cdhome",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cdroot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "recent_dirs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "recent_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mkdt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "quick_cd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dotfiles_cd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "extract",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_tar_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_tar_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_tar_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_zip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress_7z",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_tar_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_tar_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_tar_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_zip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_7z",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decompress_rar",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "list_archive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "timer",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "jsonfmt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yamlfmt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pathuniq",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "distribution",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "distro_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kernel_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "shell_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "uptime_pretty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sysinfo_summary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cpu_temp",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "memory_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "swap_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_summary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "load_average",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sysinfo_quick",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "confirm",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "trash_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "trash_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "trash_empty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "trash_restore",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "scan_secrets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_agent_ensure",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_agent_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "safe_dl",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "clipclear",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sudotime",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sudocheck",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "env_secrets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "shred_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_encrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_decrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_keygen_ed25519",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_keygen_rsa",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "check_breach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_current",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_delete_merged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_rename",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_list_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_today",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_author",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_graph",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_oneline",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_date_range",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_since",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_until",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_stat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_word",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_summary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_verbose",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_signed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_pull_rebase_auto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_push_force_lease",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_push_upstream",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_save",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_apply",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_drop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_pop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_push",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_push_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_add_upstream",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clean_branches",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_squash_last",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_continue",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_abort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_skip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_soft",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_hard",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_mixed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reflog_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reflog_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_foreach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_blame_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_grep_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_ignore_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_archive_branch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_set_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_list_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_contributors",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_contributors_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_files_changed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_stats",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_age",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_amend_noedit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_amend_message",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_empty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_checkout_new_branch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_ff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_noff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_squash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_abort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_continue",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_pick",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_pick_nocommit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_pick_continue",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_pick_abort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_revert_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_shallow",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_fetch_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_fetch_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_push_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_push_tags",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_pull_ff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_pull_rebase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_pull_autostash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_status_short",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_cached",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_stat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_verify_tags",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_log",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_running",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_stopped",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_stop_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_stop_latest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_rm_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_rm_exited",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_rm_stopped",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_rmi_dangling",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_rmi_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_images",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_containers",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_volumes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_networks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_clean_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_exec_sh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_exec_bash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_logs_tail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_logs_since",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_detach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_port",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_volume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_build_tag",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_build_nocache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_push_tag",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_pull_latest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_stats_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_stats_live",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_top_container",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_inspect_ip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_save_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_load_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_login_registry",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_tag_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_export_container",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_import_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_df",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_events",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_up_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_down_volumes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_restart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_stop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_pull",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_logs_tail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_ps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_exec",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_up_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_stop_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_restart_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_build_nocache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_down_remove_orphans",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_ps_services",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_exec_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_run_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pods_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pods_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pods_wide",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pods_watch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_svc_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_deployments_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_nodes_detail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_namespaces_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_describe_pod_detail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_tail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_previous",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_since",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_all_containers",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_exec_bash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_exec_sh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_port_forward_svc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_port_forward_pod",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_apply_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_apply_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_delete_pod_force",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_history",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_undo",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_restart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_scale_deployment",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_scale_statefulset",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cordon_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_uncordon_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_drain_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_current",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_set_namespace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_get_contexts",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_context_switch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_top_pods_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_top_nodes_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_api_resources_short",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_explain_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_auth_cani",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_namespace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_configmap",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_secret",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_events",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_events_warn",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_run_pod",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_run_deployment",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_ingress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_configmap",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_secret",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_pvc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_storageclass",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_label_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_taint_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cp_to_pod",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cp_from_pod",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_events_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_pv",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_top_pod_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_pod_container",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_exec_bash_pod_container",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_port_forward_deployment",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_apply_kustomize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_delete_all_deployments",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_pause",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollout_resume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_scale_to_zero",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_pods",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_svc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_deploy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_exec",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_exec_bash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k8s_port_fw",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_status_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_failed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_enabled",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_start_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_stop_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_restart_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_enable_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_disable_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_mask_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_unmask_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_daemon_reload",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_edit_override",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_cat_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_is_active",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_is_enabled",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_analyze_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_analyze_blame",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_timers",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_sockets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_follow",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_unit_today",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_unit_yesterday",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_boot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_errors",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_warnings",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_vacuum_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_vacuum_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_install_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_remove_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_search_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_list_installed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_list_outdated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_clean_cache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_show_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pacman_clean_orphans",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pacman_list_orphans",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pacman_list_explicit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pacman_verify_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_broken_fix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_search_installed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_list_upgradable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_list_installed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_add_ppa",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apt_remove_ppa",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dnf_list_groups",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dnf_history_rollback",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_find_leaves",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_list_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_clean_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_services_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_services_stop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_services_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "brew_outdated_formula",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_list_apps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_list_apps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_reqs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_freeze_reqs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_list_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_list_outdated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_show_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_activate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_deactivate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "python_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "python_find",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyright_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_coverage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mypy_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flake8_lint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "black_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_uv",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_cache_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_download_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_hash_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_list_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_list_outdated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_audit_fix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_cache_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_docs_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_why_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_ci_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_dedupe",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_version_bump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_store_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_dedupe",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_lint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_upgrade_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_outdated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_why",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_run_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_use",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_tree_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_build_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_bench_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_test_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_clippy_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_fmt_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_doc_open",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_expand_macro",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_bloat_crate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_clean_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_audit_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_outdated_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_check_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_publish_crate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_test_nocapture",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_env_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_deps_graph",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_cover",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_build_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_install_latest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_mod_tidy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_mod_vendor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_vet_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_clean_cache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_generate_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_fmt_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_lint_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_run_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_race",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "whatismyip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "whatismyip_external",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "whatismyip_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "check_port_open",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "check_port_listen",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "check_port_pid",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kill_port_process",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_lookup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_reverse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_mx_lookup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_ns_lookup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_txt_lookup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dns_any",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ping_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "speedtest_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssl_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "http_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "http_headers",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "download_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "download_extract",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ip_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mac_lookup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "whois_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "traceroute_path",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bandwidth_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "netstat_connections",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "netstat_listening",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "backup_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "backup_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "backup_with_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_dirs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_lines_total",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_largest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_largest_dirs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_newest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_oldest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_empty_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_empty_dirs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_duplicates",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "copy_with_progress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "copy_and_cd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "move_and_cd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rename_extension",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "symlink_force",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "touch_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_permissions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_owner",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_extension",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "checksum_sha256",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "checksum_md5",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "verify_checksum",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_words",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "count_chars",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_invert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_word",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sed_replace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sed_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "awk_column",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "awk_calc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sort_by_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sort_by_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sort_by_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "unique_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "unique_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "diff_summary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_view",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "json_validate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yaml_validate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "hex_dump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xml_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "make_distclean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "just_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "just_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "just_edit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_docs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_health",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_bench",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_fix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_sync",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dot_ver",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "generate_password",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "generate_uuid",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "generate_token",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "encode_base64",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "decode_base64",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "url_encode",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "url_decode",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "hash_string",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "hash_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "hash_md5",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_convert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_gif",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_screenshot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_extract_audio",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_merge_video",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_resize_video",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_crop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_speed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_metadata",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_png_sequence",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_stream",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_resize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_convert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_crop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_rotate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "image_trim",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "exif_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "exif_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_volume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffmpeg_concat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gif_optimize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_whoami",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_s3",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_ec2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_lambda",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_ecs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_eks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_iam",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_vpc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_list_route53",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_browse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_sync_up",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_sync_down",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_list_instances",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_list_clusters",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_get_creds",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_ssh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_list_projects",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_list_images",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_list_disks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "az_list_vms",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "az_list_aks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "az_list_groups",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_init_re",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_plan_out",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_apply_auto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_destroy_auto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_workspace_new",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_workspace_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_workspace_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_pull",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_push",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_fmt_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_validate_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_refresh_state",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_console_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_repo_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_repo_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_repo_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_search_repo",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_upgrade_install_full",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_get_values_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_list_releases_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_uninstall_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_rollback_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_history_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_dry_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_test_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_template_render",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mysql_dump_db",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mysql_import_db",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mysql_run_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mysql_list_dbs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pg_dump_db",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pg_import_db",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pg_list_dbs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pg_run_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sqlite_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sqlite_tables",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sqlite_schema",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sqlite_dump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_ping",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_flush",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "redis_set",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mongosh_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mongosh_list_dbs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_list_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_list_secret_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_export_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_export_secret_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_import_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_encrypt_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_decrypt_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_sign_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_verify_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_recv_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_refresh_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_encrypt_symmetric",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_key_id",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_key_fingerprint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_set_trust",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_gen_rsa",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_gen_csr",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_self_sign",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_check_cert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_check_expiry",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_check_conn",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_rand_hex",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_rand_base64",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_check_modulus",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "openssl_check_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_path",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_env",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_aliases",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_functions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_banner",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_calendar",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_weather",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_date_utc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_datetime",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "date_iso_8601",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "date_unix_ts",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "date_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "random_number",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "random_string",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "repeat_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "run_with_timeout",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "watch_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "retry_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "quiet_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dry_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "confirm_action",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_ip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_date_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_timezone",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_uptime",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_ram_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_cpu_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_kernel",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_os",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_host",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_users",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_last",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_ssh_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_docker_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_kubectl_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_git_config",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "show_battery_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "calc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "calc_float",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "calc_int",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "calc_sci",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "hex_to_dec",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dec_to_hex",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bin_to_dec",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dec_to_bin",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "byte_convert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_convert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_sum",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_avg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_max",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_min",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_head",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_tail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "csv_cols",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_ps_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_images",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_config",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_top_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_inspect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_ip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_history",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_inspect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_inspect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_inspect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_build_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_pull_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_create_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_start_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_kill_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_pause_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_unpause_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_prune_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pod_yaml",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_svc_yaml",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_deploy_yaml",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_all_yaml",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_describe_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_describe_svc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_describe_deploy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_logs_multiple",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_exec_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_scale_to_replicas",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_label_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_label_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_annotate_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_rollback",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_watch_pods",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_watch_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_proxy_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_port_forward_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_cpu_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_memory_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_disk_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_network_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_system_load",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_running_processes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_listening_ports",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_logged_in_users",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_last_reboot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_uptime_pretty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_installed_packages",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_battery_percent",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_battery_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_temperature_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_gpu_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_disk_usage_root",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_swap_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_shell_process",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "get_display_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_compress_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_compress_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_decompress_bz2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tar_decompress_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gzip_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gzip_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gzip_level",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bzip2_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bzip2_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bzip2_level",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xz_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xz_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xz_level",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zip_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zip_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zip_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zip_encrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "7z_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "7z_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "7z_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "7z_encrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rar_decompress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rar_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "uncompress_auto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_encrypt_asymmetric",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_decrypt_asymmetric",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_encrypt_sym",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_decrypt_sym",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_sign_detached",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_verify_detached",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_export_key_armor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_export_secret_key_armor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_import_key_armor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_recv_keyserver",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_refresh_keyserver",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_key_details",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_key_fpr",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_list_keys_with_id",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_list_keys_with_email",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_delete_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gpg_delete_secret_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_shell",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_run_bash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_exec_root",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_exec_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_logs_tail_n",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_logs_timestamps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_logs_until",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_stats_no_stream",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_by_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_volume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_ps_network",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_dangling",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_by_repo",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_prune_build_cache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_down_rmi",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_down_timeout",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_events",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_pause",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_unpause",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_kill",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_scale",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_save_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_load_gz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_port",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_top",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_rename",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_pause",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_unpause",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_wait",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_cp_to",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_container_cp_from",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_build_from",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_tag_latest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_image_squash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_create_bridge",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_create_overlay",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_connect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_disconnect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_network_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_create_named",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_backup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_volume_restore",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_up_recreate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_up_scale",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_build_prune_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_build_prune_cache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_events_since",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_events_until",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_system_info_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_leave",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_join",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_node_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_service_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_service_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_stack_deploy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_stack_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_stack_rm",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_stack_services",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_swarm_stack_ps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_secret_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_secret_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_config_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_config_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_plugin_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_plugin_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_plugin_disable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_plugin_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pods_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_svc_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_deploy_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_configmap_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_secret_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_ingress_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_pvc_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_hpa_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_cronjob",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_job",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_deployment",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_service_nodeport",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_service_clusterip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_create_ingress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_set_image",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_set_env",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_set_resources",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_autoscale_deployment",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_get_events_warn_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cordon_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_uncordon_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_node_ready",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_node_details",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_top_node_sort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_view",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_rename_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_delete_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_config_use_namespace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_auth_reconcil",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_api_versions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_completion_bash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_completion_zsh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_completion_fish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_plugin_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cp_pod_to_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_cp_local_to_pod",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_wait_pod_ready",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_wait_deploy_ready",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "kubectl_wait_node_ready",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_search_hub",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_search_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_pull_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_pull_chart_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_install_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_upgrade_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_upgrade_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_rollback_revision",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_list_releases",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_list_releases_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_get_manifest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_get_notes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_get_hooks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_status_release",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_test_ns",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_create_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_package_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_lint_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_dep_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_dep_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_show_chart",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_show_values",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "helm_show_readme",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_plan_destroy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_apply_target",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_taint_resource",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_untaint_resource",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_import_resource",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_output_raw",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_rm",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_mv",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_state_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_workspace_select",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_workspace_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_version_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_providers_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_lock_hcl",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_graph_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_console_expr",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_get_modules",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "terraform_validate_quiet",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_auth_login",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_auth_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_auth_application",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_config_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_config_set",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_config_set_project",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_config_set_region",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_config_set_zone",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_storage_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_storage_cp",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_storage_rsync",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_storage_buckets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_firewall_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_firewall_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_dns_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_dns_records",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_iam_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_iam_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_iam_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_build_submit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_build_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_run_deploy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_run_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_sql_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_sql_connect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_kms_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_kms_encrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gcloud_kms_decrypt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_stop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_reboot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_terminate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_instances",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_instances_running",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_instances_stopped",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_keypairs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_security_groups",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_volumes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_snapshots",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ec2_subnets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_buckets",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_presign",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_s3_website",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_lambda_invoke",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_lambda_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_lambda_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_iam_users",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_iam_roles",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_iam_policies",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_iam_groups",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_logs_groups",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_logs_tail",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_logs_filter",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_route53_zones",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_route53_records",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cf_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cf_invalidate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_sqs_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_sqs_send",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_sns_topics",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_sns_publish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_dynamo_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_dynamo_scan",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_dynamo_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_dynamo_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_dynamo_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cw_alarms",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cw_metrics",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cw_logs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecr_repos",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecr_images",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecr_login",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecs_clusters",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecs_services",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecs_tasks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_ecs_describe",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_eks_clusters",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_eks_update_kubeconfig",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_elasticache_clusters",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_rds_instances",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_rds_snapshots",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_stepfunctions_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_apigateway_apis",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "aws_cognito_pools",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_editable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_reqs_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_uninstall_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_upgrade_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_upgrade_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pip_install_pipx",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pipx_list_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pipx_run_bin",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pipx_upgrade_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_create_python",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_create_system",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_list_packages",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "venv_export_reqs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run_verbose",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run_failfast",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run_parallel",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run_coverage_html",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pytest_run_last_failed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ruff_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ruff_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ruff_fix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_add_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_publish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_update_lock",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_export_reqs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_shell",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "poetry_run_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_versions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_install_python",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_uninstall_python",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_virtualenv_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_virtualenv_activate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pyenv_virtualenv_deactivate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "conda_env_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "conda_env_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "conda_env_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "conda_install_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "conda_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_init_project",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_init_ts",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_install_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_install_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_install_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_install_optional",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_uninstall_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_update_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_update_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_lint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_typecheck",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_run_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_publish_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_publish_dryrun",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_unpublish_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_link_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_unlink_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_link_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_whoami",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_token_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_token_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_token_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_team_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_access_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_view_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_search_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_pack_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_rebuild_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_cache_ls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_cache_verify",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_ls_top",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_ls_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_fund_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_org_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "npm_stars_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_add_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_add_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_run_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_run_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_run_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_run_lint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_ls_depth",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_outdated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_audit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_audit_fix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_rebuild",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_store_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_store_path",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_fetch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_pack",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pnpm_publish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_add_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_add_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_remove_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_install_frozen",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_install_immutable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_run_dev",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_run_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_run_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_run_lint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_run_typecheck",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_workspace_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_workspace_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_why_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_link_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_unlink_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_publish_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_info_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "yarn_cache_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_list_remote",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_list_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_install_lts",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_use_default",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_alias_default",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_current_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_which_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvm_uninstall_node",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_eval",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_inspect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_check_syntax",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_print_v8",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "node_print_versions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsc_compile",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsc_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsc_watch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsc_noemit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsc_build",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ts_node_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_new_project",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_init_project",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_add_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_add_dev_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_add_build_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_rm_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_upgrade_dep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_upgrade_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_workspace_member",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_run_example",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_run_bin",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_test_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_test_doc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_test_ignored",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_bench",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_build_debug",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_build_release_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_check_warnings",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_fix_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_metadata_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_vendor_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_publish_dryrun",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_owner_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_owner_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_owner_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_yank_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_unyank_version",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_workspace_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_licenses",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_lint_clippy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cargo_fmt_rust",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_short",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_bench",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_cover_html",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_test_cover_func",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_build_linux",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_build_darwin",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_build_windows",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_build_cross",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_get_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_install_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_doc_view",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_doc_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_clean_modcache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_mod_download",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_mod_verify",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_mod_why",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_work_use",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_work_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_work_sync",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_tool_pprof",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_tool_trace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_tool_objdump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "go_tool_covdata",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_github",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_gh_ssh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_gitlab",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_bitbucket",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_bare",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clone_mirror",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_switch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_switch_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_rename_remote",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_purge",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_merged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_not_merged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_tracking",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_branch_sort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_stats",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_patch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_short",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_between",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_graph_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_author_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_log_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_staged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_unstaged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_branches",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_commits",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_summary_only",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_word_highlight",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_diff_patch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_sign",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_fixup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_squash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_allow_empty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_commit_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_save_msg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_apply_drop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_branch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_clear_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_show_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stash_list_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_add_origin",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_set_url",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_rename",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_get_url",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_remote_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_squash_branch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_merge_ff_only",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_root",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_onto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rebase_editor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_keep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reset_to_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_pick_range",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_revert_no_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_revert_abort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_revert_continue",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_amend_author",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_amend_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_amend_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_lock",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_unlock",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_sync",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_submodule_update_remote",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_good",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_bad",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_reset",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_log",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bisect_run",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_blame_email",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_blame_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_grep_string",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_grep_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_grep_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_ignore_global",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_ignore_template",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_attributes_text",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_global_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_diff_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_merge_tool",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_signing",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_autocorrect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_pull_rebase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_push_default",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_replace_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_archive_zip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_archive_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_describe_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_verify_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_verify_tag",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_check_ignore",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_check_attr",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_show_refs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_ls_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_ls_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_count_objects",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_fsck_repair",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_gc_aggressive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_repack_optimize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clean_ignored",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_clean_dry",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_archive_export",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_reload_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_reenable_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_preset_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_add_wants",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_show_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_units_by_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_list_machines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_poweroff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_reboot",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_hibernate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_suspend",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "systemctl_hybrid_sleep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_user_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_priority",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_since_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_until_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_output_json",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_catalog",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_merge",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_no_pager",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_reverse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_follow_unit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_kernel",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "journalctl_list_boots",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_regex",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_perm",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_inode",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_depth",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_group",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_newer",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_accessed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_modified",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_by_changed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_broken_symlinks",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_suid_binaries",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_sgid_binaries",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_world_writable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_large_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_recent_changed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_recent_accessed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_hidden_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_exec_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "find_delete_by_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_scan_ports",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_scan_subnet",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_traceroute_path",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_ping_flood",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_ping_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_mtr_report",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_dig_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_dig_short",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_dns_test",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_post",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_head",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_options",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_download",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_download_as",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_resume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_rate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_cookie",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_http_header",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_ssl_cert",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_ssl_chain",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_whois_domain",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_tcpdump_interface",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_tcpdump_port",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "network_tcpdump_host",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_as_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_as_root",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_command_each",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_parallel",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_in_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_with_log",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_retry",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_timeout",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_background",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_if_available",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_chroot_cmd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_shell_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_bash_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_python_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_node_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "execute_deno_script",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_math",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_condition",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_command_time",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_memory_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_shell_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_shfmt",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_bash_nounset",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_bash_xtrace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_zsh_nounset",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_python_syntax",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eval_node_syntax",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_human",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_total",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_sort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_depth",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage_by_ext",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_free_summary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_free_inodes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_free_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_free_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_mount_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_mount_by_device",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_fs_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_fs_repair",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_blkid",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_lsblk_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_lsblk_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_lsblk_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_smart_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_smart_health",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_iostat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_iotop",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_list_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_tree_pid",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_by_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_by_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_kill_by_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_kill_by_pid",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_kill_force",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_kill_all_user",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_nice_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_renice",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_threads",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_fds",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_env_vars",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_priority",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_dump_stack",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_cputime",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_children",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_zombies",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "process_hung",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_keygen_ecdsa",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_keygen_ed25519_sk",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_copy_id_port",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_config_host",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_config_edit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_test_conn",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_tunnel_local",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_tunnel_remote",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_tunnel_dynamic",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_tunnel_jump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_add_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_remove_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_remove_key",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_agent_load_default",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_fingerprint",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_fingerprint_sha256",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_fingerprint_md5",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_visual",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_change_pass",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_key_from_remote",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_known_hosts_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_known_hosts_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_sftp_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_sftp_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_scp_copy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_scp_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_mosh_connect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_proxy_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_config_validate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ssh_escape_sequences",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_json_post",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_json_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_json_patch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_form_post",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_upload_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_download_resume",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_auth_basic",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_auth_bearer",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_proxy_use",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_limit_rate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_timeout_conn",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_timeout_max",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_retry_conn",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_follow_redirect",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_verbose_dump",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_cert_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_cert_client",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_cookie_jar",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_insecure_ssl",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_range_request",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_if_modified",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_http2_use",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_http2_push",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_speed_limit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_interface_bind",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_dns_server",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_write_output",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_silent_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "curl_parallel_fetch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_http_proxy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_no_proxy",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_ssh_command",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_credential_helper",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_excludes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_autocrlf",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_safecrlf",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_symlink",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_editor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_merge_ff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_push_followtags",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_rebase_autostash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_rebase_autosquash",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_color_ui",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_init_default",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_fetch_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_diff_algorithm",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_diff_renames",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_pull_ff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_config_tag_sort",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_alias_set",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_alias_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_alias_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_hook_precommit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_hook_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_feature_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_feature_finish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_release_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_release_finish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_hotfix_start",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_flow_hotfix_finish",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_svn_clone",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_svn_rebase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_svn_dcommit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_install",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_track",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_pull",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_push",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_lfs_migrate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cherry_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_patch_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_patch_apply",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_patch_apply_stat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_patch_apply_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_range_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bundle_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bundle_verify",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_bundle_unbundle",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_interactive_rebase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reword_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_split_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_undo_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_undo_commit_keep",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_undo_last_commit_msg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stage_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_stage_partial",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_unstage_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_unstage_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_discard_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_discard_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_files_untracked",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_files_modified",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_files_staged",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_files_conflict",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_status_porcelain",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_status_ignored",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reflog_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reflog_expire",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_reflog_delete_old",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_blob_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_obj_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_show_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_show_commit_body",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_show_files_in_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_compare_branches",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_squash_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_contributors_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_contributors_top",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_contributors_by_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_first_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_last_commit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_annotated",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_sign",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_verify_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_date",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_contains",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_tag_latest",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_subtree_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_subtree_pull",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_subtree_push",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_subtree_merge",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_subtree_split",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_worktree_list_paths",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_append",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_remove",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_notes_prune",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_replace_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_replace_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rerere_enable",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rerere_status",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_rerere_gc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_cache_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_download_only",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_list_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_show_deps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_what_provides",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "pkg_download_source",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_add_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_remove_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_search_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_list_installed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_list_updates",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_info_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_cache_clean",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "apk_upgrade_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rpm_list_pkgs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rpm_info_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rpm_verify_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rpm_list_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_list_pkgs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_info_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_verify_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_configure_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_reconfigure_pkg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dpkg_list_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_install_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_remove_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_run_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_search_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_info_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_update_apps",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "flatpak_list_runtime",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_install_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_remove_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_search_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_info_app",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_list_services",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_start_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_stop_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_restart_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_enable_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_disable_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "snap_logs_service",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_now",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_utc",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_epoch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_iso",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_from_epoch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_from_string",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_next",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_last",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_sub",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_date_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_stopwatch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_countdown",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_sleep_random",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_timer_set",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_timer_check",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_timer_clear",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_wait_port",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_wait_url",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_wait_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "time_wait_process",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_touch_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_remove_force",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_remove_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_remove_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_copy_backup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_copy_preserve",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_copy_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_copy_verbose",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_move_force",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_move_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_move_verbose",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_move_backup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_symlink_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_symlink_hard",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_symlink_edit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_chmod_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_chmod_dirs",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_chown_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_chgrp_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compare",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compare_quiet",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compare_side",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_patch_dry",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_patch_apply",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_patch_reverse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_merge_interactive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_join_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_split_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_head_bytes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_tail_bytes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_tail_follow",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_tail_follow_name",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_head_first",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_head_last",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_middle_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_random_line",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_shuffle_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_reverse_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_number_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_trim_trailing",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_trim_leading",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_trim_both",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_dos_to_unix",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_unix_to_dos",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_remove_blank",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_remove_duplicates",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_replace_string",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_insert_line",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_append_line",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_prepend_line",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_encrypt_aes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_decrypt_aes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_encrypt_gpg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_decrypt_gpg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_gzip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_bzip2",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_xz",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_zip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_tar",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_compress_7z",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_extract_auto",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_watch_changes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "file_watch_clear",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_recursive",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_word",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_case",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_inverse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_regex",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_fixed",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_only_match",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_binary",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_recursive_full",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_exclude",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_exclude_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_search_file_types",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_replace_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_replace_line",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_replace_first",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_replace_regex",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_delete_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_delete_empty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_delete_matching",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_between",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_column",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_field",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_urls",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_emails",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_extract_ips",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_count_words",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_count_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_count_chars",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_count_freq",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_sort_alpha",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_sort_numeric",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_sort_reverse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_sort_unique",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_merge_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_split_on_delim",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_join_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_wrap_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_indent_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_unindent_lines",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_uppercase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_lowercase",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_capitalize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_reverse_chars",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_rot13",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_xml_pretty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_xml_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_xml_validate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_json_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_json_minify",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_json_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_json_flatten",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_yaml_format",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_yaml_to_json",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_yaml_validate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_csv_to_json",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_html_to_text",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_html_extract",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_markdown_render",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_diff_chars",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_diff_words",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_diff_side",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "text_patch_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_attach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_detach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_kill",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "screen_session_reattach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_new_session",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_attach_session",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_list_sessions",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_kill_session",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_split_horizontal",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_split_vertical",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_new_window",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_next_window",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_prev_window",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_rename_session",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_rename_window",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_kill_window",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_detach_client",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_swap_pane",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_rotate_panes",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_send_keys",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_capture_pane",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_save_buffer",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_set_option",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_show_options",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_resize_pane",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_choose_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_list_clients",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tmux_list_buffers",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_session_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_session_attach",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_session_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_session_kill",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_action_rename",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_action_move",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "zellij_action_resize",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "lazygit_open",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "lazydocker_open",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "k9s_open",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "htop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "btop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nvtop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "glances_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "iftop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "nethogs_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "iotop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ctop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ytop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bashtop_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "procs_process_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bandwhich_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dog_dns_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "doggo_dns_query",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "duf_disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dust_disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bottom_monitor",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gping_ping",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grex_regex_gen",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gron_json_flatten",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gron_json_unflatten",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xh_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xh_post",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xh_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "xh_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "httpie_get",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "httpie_post",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "httpie_put",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "httpie_delete",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bat_cat",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bat_lang",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bat_theme_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bat_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eza_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eza_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eza_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "lsd_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "lsd_tree",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fd_find",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fd_find_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fd_find_exec",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rg_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rg_search_files",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rg_search_context",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "rg_search_word",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sd_replace",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_dir",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_kill",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_ssh",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_git_branch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_git_log",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_git_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_history",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_process",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_man",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_browse",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_cd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "fzf_rg",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_show",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_level",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_dirs_only",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_with_hidden",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_size",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_xml",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_json",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tree_html",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "todo_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "todo_count",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "todo_by_type",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "todo_add",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "todo_show_file",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "license_mit",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "license_apache",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "license_gpl",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "license_bsd",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "license_unlicense",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gitignore_fetch",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gitignore_append",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "gitignore_list",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "dockerignore_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "editorconfig_create",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "prettier_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "eslint_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "tsconfig_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "package_json_init",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "bak",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "unbak",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "orig",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "unorig",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "topcommands",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "puniq",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "findup",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "cdup",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "pg",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "stamp",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "stampcmd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "clip",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "path_remove",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "path_append",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "path_prepend",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "here",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "there",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "mkcd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "gcd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "gbs",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "extract",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "colors",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "wanip",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "pwdtail",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "distribution",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_os",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_is_mac",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_is_linux",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_is_bsd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_mac_only",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "_linux_only",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "ip_show",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "disk_usage",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "mem_info",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "cpu_info",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "pkg_list",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "service_list",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "ssh_keys",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "open_file",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "copy_cmd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "paste_cmd",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "cdf",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "swap",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "backup_dotfiles",
      "desc": "_x defined in core/aliases.sh"
    },
    {
      "category": "General",
      "name": "dotfiles_diff",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "workon",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mkproject",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "ffind",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "grep_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sys_update",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "disk_usage",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "mem_top",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "cpu_top",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_cleanup",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_search",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "git_find",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "net_listen",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "local_ip",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_clean_all",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "docker_compose_rebuild",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "compress",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "backup_rotate",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "sys_info",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "json_pretty",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "weather_report",
      "desc": "No description available."
    },
    {
      "category": "General",
      "name": "markdown_preview",
      "desc": "No description available."
    }
  ],
  "generatedAt": "2026-05-19T06:20:35.666Z"
};