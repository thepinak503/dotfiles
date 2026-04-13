status is-interactive; or exit
#!/usr/bin/env bash
function __dotfiles_error_handler --on-event fish_postexec
    set -l code $status
    if test $code -ne 0
        if not string match -qr '^(grep|test|\[|ls|type)' -- $argv[1]
            set -l ts (date '+%Y-%m-%d %H:%M:%S')
            printf "[%s] EXIT=%s CMD=%s\n" "$ts" "$code" "$argv[1]" >> "$DOTFILES_STATE_DIR/errors.log"
        end
    end
end
function __abbr_tips_postexec --on-event fish_postexec
    set -l cmd (string trim -- $argv[1])
    if test (string length -- $cmd) -lt 3; return; end
    for abbr_name in (abbr -l)
        set -l abbr_body (abbr -s $abbr_name | string replace -r '^abbr -a (?:--\s+)?(\S+)\s+' '')
        set abbr_body (string replace -r "^['\"]" "" -- $abbr_body | string replace -r "['\"]\$" "" --)
        if test "$cmd" = "$abbr_body"
            echo -e "\033[0;90m💡 $abbr_name => $abbr_body\033[0m"
            break
        end
    end
end
function chmode
    set -l mode "$argv[1]"
    switch $mode
        case 'basic' 'minimal' 'standard' 'supreme' 'ultra-nerd'
            echo "Switching to $mode mode..."
            ; set -gx DOTFILES_MODE "$mode"
            test -d "$DOTFILES_STATE_DIR"; or mkdir -p "$DOTFILES_STATE_DIR"
            echo "$mode" > "$DOTFILES_STATE_DIR/mode"
            echo -e "\033[1;32m✓ Mode updated. Restart shell or run 'exec $SHELL' to apply.\033[0m"
        case '*'
            echo "Usage: chmode [basic | minimal | standard | supreme | ultra-nerd]"
            echo "Current Mode: $DOTFILES_MODE"
    end
end
abbr -a cm 'chmode'
abbr -a dotmode 'chmode'
function dotfix
    echo "Fixing and re-linking dotfiles..."
    if test -f "$DOTFILES_DIR/install/install.sh"
        sh "$DOTFILES_DIR/install/install.sh"
    else
        echo "Error: Could not find installer at $DOTFILES_DIR"
    end
end
function cd --wraps 'cd'
    builtin cd "$argv"; and ls
end
function mkcd
    mkdir -p "$argv[1]"; and cd "$argv[1]"
end
function groot
    cd (git rev-parse --show-toplevel 2>/dev/null); or begin echo "Not a git repo"
    return 1
    end
end
function dot
    cd "$DOTFILES_DIR"
end
function excd
    extract "$argv[1]"
    set -l d "$argv[1]%.*"
    test -d "$d"; and cd "$d"
end
function mktar
    tar -czvf "$argv[1].tar.gz" "$argv[2]"
end
function mktarbz
    tar -cjvf "$argv[1].tar.bz2" "$argv[2]"
end
function mktarxz
    tar -cJvf "$argv[1].tar.xz" "$argv[2]"
end
function mkzst
    tar --zstd -cvf "$argv[1].tar.zst" "$argv[2]"
end
function bak
    test -f "$argv[1]"; or begin echo "File not found: $argv[1]"; return 1; end
    set -l dst; set dst "$argv[1].bak.(date +%Y%m%d_%H%M%S)"
    cp -a "$argv[1]" "$dst"; and echo "Backed up → $dst"
end
function unbak
    set -l latest; set latest (find . -maxdepth 1 -name "$argv[1].bak.*" -type f -printf "%T@ %p\n" 2>/dev/null | sort -nr | head -1 | cut -d' ' -f2)
    test -z "$latest"; and begin echo "No backup found for: $argv[1]"; return 1; end
    cp -a "$latest" "$argv[1]"; and echo "Restored from: $latest"
end
function touchp
    mkdir -p (dirname "$argv[1]"); and touch "$argv[1]"
end
function swap
    test (count $argv) -ne 2; and begin echo "Usage: swap <file1> <file2>"; return 1; end
    set -l tmp (mktemp)
    mv "$argv[1]" "$tmp"; and mv "$argv[2]" "$argv[1]"; and mv "$tmp" "$argv[2]"
    echo "Swapped: $argv[1] ↔ $argv[2]"
end
function cpv
    rsync -ah --info=progress2 "$argv"
end
function ff
    if type -q fd >/dev/null 2>&1
    fd "$argv[1]" "$argv[2]"
    else find "$argv[2]" -type f -iname "*$argv[1]*" 2>/dev/null
    end
end
function ffd
    if type -q fd >/dev/null 2>&1
    fd --type d "$argv[1]" "$argv[2]"
    else find "$argv[2]" -type d -iname "*$argv[1]*" 2>/dev/null
    end
end
function largest
    find "$argv[1]" -type f -exec du -h {} + 2>/dev/null | sort -rh | head "$argv[2]"
end
function largestdirs
    du -h --max-depth=1 "$argv[1]" 2>/dev/null | sort -rh | head "$argv[2]"
end
function diskusage
    echo "=== Disk Partitions ==="
    df -hT | grep -v tmpfs | grep -v devtmpfs
    echo ""
    echo "=== Top 10 dirs in $HOME ==="
    du -h --max-depth=1 "$HOME" 2>/dev/null | sort -rh | head 10
end
function countfiles
    for t in files links directories
        echo "(find . -type "$t:0:1" 2>/dev/null | wc -l) $t"
    end
end
function fs
    set -l arg "-sbh"
    du -b /dev/null >/dev/null 2>&1; or set arg "-sh"
    if test -n "$argv"; du $arg -- "$argv"; else du $arg .[^.]* ./*; end
end
function xopen
    if test "$DOTFILES_OS" = "Darwin"
        command open "$argv"
    else
        xdg-open "$argv" >/dev/null 2>&1 &
    end
end
function note
    set -l f "$HOME/.notes"
    if test -z "$argv[1]"
        test -f "$f"; and less "$f"; or echo "No notes yet."
    else
        echo (date '+%Y-%m-%d %H:%M') "— $argv" >> "$f"
        echo "Note saved."
    end
end
function notes-clear
    true > "$HOME/.notes"; and echo "Notes cleared."
end
function notes-search
    grep -i "$argv[1]" "$HOME/.notes" 2>/dev/null
end
function sosgit
    set -l branch msg
    set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null); or begin echo "Not a git repo"; return 1; end
    set msg "$argv"
    echo -e "\033[1;31m⚡ EMERGENCY MODE\033[0m"
    echo "  Branch : $branch"
    echo "  Message: $msg"
    git add -A
    git stash pop 2>/dev/null  # recover any stashed work too
    git commit -m "$msg" --no-verify
    git push --force-with-lease origin "$branch"; or git push origin "$branch"; or begin
        git push --set-upstream origin "$branch"
    end
    set -l status $status
    if test $status -eq 0
        echo -e "\033[1;32m✓ Emergency push complete.\033[0m"
    else
        echo -e "\033[1;31m✗ Push failed! Try manual push.\033[0m"
    end
    return $status
end
function gcall
    test -z "$argv[1]"; and begin echo "Usage: gcall <message>"; return 1; end
    git add -A; and git commit -m "$argv"
end
function gcmsign
    test -z "$argv[1]"; and begin echo "Usage: gcmsign <message>"; return 1; end
    git add -A; and git commit -S -m "$argv"
end
function grib
    test -z "$argv[1]"; and begin echo "Usage: grib <N>"; return 1; end
    git rebase -i "HEAD~$argv[1]"
end
function git-clean
    git fetch -p
    git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -r git branch -d
    echo "Cleaned merged branches."
end
function gsquash
    test -z "$argv[1]"; and begin echo "Usage: gsquash <N>"; return 1; end
    git reset --soft "HEAD~$argv[1]"
    echo "Squashed $argv[1] commits. Now commit:"
    echo "  git commit -m \"<message>\""
end
function ginfo
    printf "Branch  : %s\n" (git branch --show-current 2>/dev/null; or echo N/A)
    printf "Remote  : %s\n" (git remote get-url origin 2>/dev/null; or echo N/A)
    printf "Commit  : %s\n" (git log -1 --pretty='%h – %s (%ar)' 2>/dev/null; or echo N/A)
    printf "Staged  : %s files\n" (git diff --cached --name-only 2>/dev/null | wc -l)
    printf "Modified: %s files\n" (git diff --name-only 2>/dev/null | wc -l)
    echo ""
    git status -sb 2>/dev/null
end
function gstats
    echo "Commits   : "(git rev-list --count HEAD 2>/dev/null)
    echo "Branches  : "(git branch | wc -l)
    echo "Stashes   : "(git stash list | wc -l)
    echo "Tags      : "(git tag | wc -l)
    echo "Top authors:"
    git shortlog -sn --all --no-merges | head -5
end
function glog
    git log --oneline --graph --decorate "-$argv[1]"
end
function gdiffs
    git diff --stat "$argv[1]"
end
function gnewbranch
    test -z "$argv[1]"; and begin echo "Usage: gnewbranch <name>"; return 1; end
    git switch -c "$argv[1]"; and git push -u origin "$argv[1]"
end
function gdelb
    test -z "$argv[1]"; and begin echo "Usage: gdelb <branch>"; return 1; end
    git branch -d "$argv[1]"
    git push origin --delete "$argv[1]"
end
function gchanged
    git diff --name-only "HEAD~$argv[1]" HEAD
end
function fgco
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l branch; set branch (git branch -a | sed 's/remotes\/origin\///' | sort -u | fzf --prompt='branch> ')
    test -n "$branch"; and git checkout (echo "$branch" | xargs)
end
function fgstash
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l stash; set stash (git stash list | fzf | cut -d: -f1)
    test -n "$stash"; and git stash show -p "$stash"
end
function gsync
    git fetch --all --prune
    git pull --rebase --autostash
    git-clean
end
function dsync
    set -l root "$DOTFILES_DIR"
    test -d "$root/.git"; or begin echo "Dotfiles repo not found at $root"; return 1; end
    echo "Syncing $root..."
    git -C "$root" fetch --all --prune
    git -C "$root" pull --rebase --autostash
    test -f "$root/.gitmodules"; and git -C "$root" submodule update --init --recursive
    echo "Sync complete."
end
function dpush
    set -l root "$DOTFILES_DIR"
    set -l msg "$argv[1]"
    git -C "$root" add -A
    git -C "$root" commit -m "$msg"
    git -C "$root" push
end
function docker-clean
    echo "Pruning Docker system..."
    docker system prune -af --volumes; and echo "Done."
end
function docker-stop-all
    docker ps -q | xargs -r docker stop; and echo "All containers stopped."
end
function docker-rm-all
    docker ps -aq | xargs -r docker rm -f; and echo "All containers removed."
end
function docker-rmi-all
    docker images -q | xargs -r docker rmi -f; and echo "All images removed."
end
function docker-du
    docker system df -v
end
function dexec
    type -q fzf >/dev/null 2>&1; or begin echo "Install fzf for interactive mode"; return 1; end
    set -l c; set c (docker ps --format '{{.Names}}' | fzf --prompt='container> ')
    test -n "$c"; and docker exec -it "$c" /bin/bash
end
function dlf
    type -q fzf >/dev/null 2>&1; or begin echo "Install fzf for interactive mode"; return 1; end
    set -l c; set c (docker ps --format '{{.Names}}' | fzf --prompt='logs> ')
    test -n "$c"; and docker logs -f "$c"
end
function dip
    set -l c "$argv[1]}' | head -1)}"
    docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$c"
end
function kwatch
    watch -n 2 kubectl get pods "$argv"
end
function klf
    type -q fzf >/dev/null 2>&1; or begin echo "Install fzf"; return 1; end
    set -l pod; set pod (kubectl get pods --no-headers | fzf --prompt='pod> ' | awk '{print $argv[1]}')
    test -n "$pod"; and kubectl logs -f "$pod" "$argv"
end
function kexf
    type -q fzf >/dev/null 2>&1; or begin echo "Install fzf"; return 1; end
    set -l pod; set pod (kubectl get pods --no-headers | fzf --prompt='exec> ' | awk '{print $argv[1]}')
    test -n "$pod"; and kubectl exec -it "$pod" -- "$argv[1]"
end
function ksecret
    test -z "$argv[1]"; and begin echo "Usage: ksecret <secret-name> [key]"; return 1; end
    if test -n "$argv[2]"
        kubectl get secret "$argv[1]" -o; set jsonpath "{.data.$argv[2]}" | base64 -d; and echo
    else
        if kubectl get secret "$argv[1]" -o json | type -q jq >/dev/null 2>&1
            kubectl get secret "$argv[1]" -o json | jq '.data | map_values(@base64d)'
        else
            kubectl get secret "$argv[1]" -o yaml
        end
    end
end
function kns
    if type -q fzf >/dev/null 2>&1; and test -z "$argv[1]"
        ; set -l ns; set ns (kubectl get ns --no-headers | fzf --prompt='namespace> ' | awk '{print $argv[1]}')
        test -n "$ns"; and kubectl config set-context --current --namespace="$ns"
    else
        kubectl config set-context --current --namespace="$argv[1]"
    end
end
function kctxf
    type -q fzf >/dev/null 2>&1; or begin kubectl config use-context "$argv[1]"; return; end
    set -l ctx; set ctx (kubectl config get-contexts --no-headers | fzf --prompt='context> ' | awk '{print $argv[2]}')
    test -n "$ctx"; and kubectl config use-context "$ctx"
end
function sysupdate
    echo "Updating system ($DOTFILES_PKG)..."
    switch $DOTFILES_PKG
        case pacman
            sudo pacman -Syu
        case apt
            sudo apt-get update; and sudo apt-get upgrade -y
        case dnf
            sudo dnf upgrade -y
        case yum
            sudo yum update -y
        case zypper
            sudo zypper update -y
        case xbps
            sudo xbps-install -Su
        case apk
            sudo apk upgrade
        case emerge
            sudo emerge --update --deep --newuse @world
        case brew
            brew update; and brew upgrade
        case '*'
            if type -q pacman >/dev/null 2>&1;      ; sudo pacman -Syu
            else if type -q apt-get >/dev/null 2>&1;   ; sudo apt-get update; and sudo apt-get upgrade -y
            else if type -q dnf >/dev/null 2>&1;       ; sudo dnf upgrade -y
            else if type -q brew >/dev/null 2>&1;      ; brew update; and brew upgrade
            else echo "No supported package manager found"; return 1
            end
    end
end
function myip
    printf "Internal: "
    if type -q ip >/dev/null 2>&1
        ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1 | head -1
    else if type -q ifconfig >/dev/null 2>&1
        ifconfig 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | awk '{print $argv[2]}' | head -1
    end
    printf "External: "
    curl -4s --max-time 5 https://ifconfig.me 2>/dev/null; or curl -4s --max-time 5 https://icanhazip.com 2>/dev/null; or echo "N/A"
    echo
end
abbr -a whatismyip 'myip'
function portopen
    set -l host "$argv[1]"; set port "$argv[2]"
    test -z "$host"; or -z "$port"; and begin echo "Usage: portopen <host> <port>"; return 1; end
    timeout 3 bash -c ">/dev/tcp/$host/$port" 2>/dev/null \
        ; and echo "Port $port on $host is OPEN" \
        ; or echo "Port $port on $host is CLOSED / filtered"
end
function killport
    test -z "$argv[1]"; and begin echo "Usage: killport <port>"; return 1; end
    set -l pids; set pids (lsof -ti:"$argv[1]" 2>/dev/null)
    test -z "$pids"; and begin echo "Nothing on port $argv[1]"; return 0; end
    echo "$pids" | xargs kill -9; and echo "Killed process(es) on :$argv[1]"
end
function portused
    test -z "$argv[1]"; and begin echo "Usage: portused <port>"; return 1; end
    lsof -i:"$argv[1]" 2>/dev/null; or ss -tulnp | grep ":$argv[1]"
end
function reachable
    ping -c 1 -W 2 "$argv[1]" >/dev/null 2>&1; and echo "$argv[1] is reachable"; or echo "$argv[1] is NOT reachable"
end
function weather
    curl -s "wttr.in/$argv[1]?lang=en"
end
function serve
    set -l port "$argv[1]"
    echo "Serving on http://localhost:$port"
    python3 -m http.server "$port"
end
function digga
    dig +nocmd "$argv[1]" any +multiline +noall +answer
end
function sslcheck
    test -z "$argv[1]"; and begin echo "Usage: sslcheck <domain>"; return 1; end
    echo | openssl s_client -servername "$argv[1]" -connect "$argv[1]:443" 2>/dev/null \
        | openssl x509 -noout -subject -issuer -dates
end
function certnames
    test -z "$argv[1]"; and begin echo "Usage: certnames <domain>"; return 1; end
    set -l tmp; set tmp (echo -e "GET / HTTP/1.0\nEOT" | openssl s_client -connect "$argv[1]:443" -servername "$argv[1]" 2>&1)
    echo "$tmp" | grep -A1 "Subject Alternative Name:" | tail -1 \
        | sed -e 's/DNS://g' -e 's/ //g' | tr ',' '\n'
end
function psg
        ps aux | grep -v grep | grep -i "$argv[1]"; end
function fkill
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l pids; set pids (ps aux | sed 1d | fzf --multi --header='Select process(es) to kill' | awk '{print $argv[2]}')
    test -n "$pids"; and echo "$pids" | xargs kill -9; and echo "Killed."
end
function ww
    who -a
    w
end
function genpass
    set -l len (test -n "$argv[1]"; and echo "$argv[1]"; or echo 20)
    if type -q openssl
        openssl rand -base64 48 | cut -c1-$len
    else
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $len | head -n 1
    end
end
function genphrase
    set -l words (test -n "$argv[1]"; and echo "$argv[1]"; or echo 4)
    if test -f /usr/share/dict/words
        shuf -n "$words" /usr/share/dict/words | tr '\n' '-' | sed 's/-$//'
    else
        genpass (math "$words * 8")
    end
end
function hashfile
    test -z "$argv[1]"; and begin echo "Usage: hashfile <file>"; return 1; end
    echo "SHA256 : (sha256sum "$argv[1]" | cut -d' ' -f1)"
    echo "SHA512 : (sha512sum "$argv[1]" | cut -d' ' -f1)"
    echo "MD5    : (md5sum    "$argv[1]" | cut -d' ' -f1)"
end
function securerm
    test -z "$argv[1]"; and begin echo "Usage: securerm <file>"; return 1; end
    shred -u -z -n 3 "$argv[1]"; and echo "Securely deleted: $argv[1]"
end
function encrypt
    test -z "$argv[2]"; and begin echo "Usage: encrypt <recipient-email> <file>"; return 1; end
    gpg --encrypt --armor -r "$argv[1]" "$argv[2]"; and echo "Encrypted: $argv[2].asc"
end
function decrypt
    test -z "$argv[1]"; and begin echo "Usage: decrypt <file.gpg|file.asc>"; return 1; end
    gpg --decrypt "$argv[1]"
end
function gpgsign
    test -z "$argv[1]"; and begin echo "Usage: gpgsign <file>"; return 1; end
    gpg --clearsign "$argv[1]"; and echo "Signed: $argv[1].asc"
end
function gpgverify
    test -z "$argv[1]"; and begin echo "Usage: gpgverify <file.sig> [file]"; return 1; end
    gpg --verify "$argv[1]" "$argv[2]"
end
function b64e
    echo -n "$argv[1]" | base64
end
function b64d
    echo -n "$argv[1]" | base64 -d
    echo
end
function urlencode
    python3 -c "import sys,urllib.parse
    print(urllib.parse.quote(sys.argv[1]))" "$argv[1]"
end
function urldecode
    python3 -c "import sys,urllib.parse
    print(urllib.parse.unquote(sys.argv[1]))" "$argv[1]"
end
function jwtdecode
    test -z "$argv[1]"; and begin echo "Usage: jwtdecode <jwt-token>"; return 1; end
    set -l payload; set payload (echo "$argv[1]" | cut -d. -f2)
    set -l padded; set padded "$payload(printf '%0.s=' $(seq 1 (math  4 - (count $argv)payload % 4 )))"
    echo "$padded" | base64 -d 2>/dev/null | python3 -m json.tool 2>/dev/null; or echo "Failed to decode JWT"
end
function is_root
    test $EUID -eq 0
end
function require_root
    is_root; or begin echo "This command requires root privileges."; return 1; end
end
function audit_suid
    echo "=== SUID Binaries ==="
    find / -perm /4000 -type f 2>/dev/null | sort
    echo ""
    echo "=== SGID Binaries ==="
    find / -perm /2000 -type f 2>/dev/null | sort
end
function audit_worldwrite
    echo "=== World-writable files ==="
    find / -perm /o+w -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null | sort
end
function audit_ssh
    set -l f "/etc/ssh/sshd_config"
    test -f "$f"; or begin echo "sshd_config not found"; return 1; end
    echo "=== SSH Security Audit ==="
    grep -E "^(PermitRootLogin|PasswordAuthentication|ChallengeResponseAuthentication|X11Forwarding|AllowTcpForwarding|UsePAM|Protocol)" "$f" 2>/dev/null
end
function dataurl
    set -l mime; set mime (file -b --mime-type "$argv[1]")
    test $mime = text/*; and set mime "$mime;charset=utf-8"
    echo "data:$mime;base64,(openssl base64 -in "$argv[1]" | tr -d '\n')"
end
function hb
    test -f "$argv[1]"; or begin echo "Usage: hb <file>"; return 1; end
    set -l key; set key (curl -s -X POST -d @"$argv[1]" http://bin.christitus.com/documents | grep -o '"key":"[^"]*"' | cut -d'"' -f4)
    echo "http://bin.christitus.com/$key"
end
function timer
    set -l s; set s (date +%s%N)
    "$argv"
    set -l e; set e (date +%s%N)
    printf "Duration: %.3fs\n" (echo "scale=3; ($e - $s) / 1000000000" | bc)
end
function calc
    test -z "$argv"; and begin echo "Usage: calc <expression>"; return 1; end
    echo "$argv" | bc -l 2>/dev/null; or python3 -c "from math import *; print($argv)"
end
function qr
    test -z "$argv[1]"; and begin echo "Usage: qr <text>"; return 1; end
    curl -s "qrenco.de/$argv[1]"
end
function cheat
    test -z "$argv[1]"; and begin echo "Usage: cheat <command>"; return 1; end
    curl -s "cheat.sh/$argv[1]" | less -R
end
function tman
    if type -q tldr >/dev/null 2>&1
        tldr "$argv[1]"
    else if type -q tealdeer >/dev/null 2>&1
        tldr "$argv[1]"
    else
        man "$argv[1]"
    end
end
function json
    if type -q jq >/dev/null 2>&1
        echo "$argv[1]" |         jq --color-output . 2>/dev/null; or echo "$argv[1]" | jq --color-output . 2>/dev/null
    else
        echo "$argv[1]" |         python3 -m json.tool
    end
end
function yamlfmt
    if type -q yq >/dev/null 2>&1
        yq eval '.' "$argv[1]"
    else if type -q python3 >/dev/null 2>&1
        python3 -c "import sys,yaml; yaml.dump(yaml.safe_load(open('$1')),sys.stdout,default_flow_style=False)"
    end
end
function json2yaml
    python3 -c "import sys,json,yaml; yaml.dump(json.load(open('$1')),sys.stdout,default_flow_style=False)"
end
function yaml2json
    python3 -c "import sys,json,yaml; json.dump(yaml.safe_load(open('$1')),sys.stdout,indent=2)"
end
function colorize
    sed \
        -e "s/\(ERROR\)/\033[0;31m\1\033[0m/g" \
        -e "s/\(WARN\)/\033[0;33m\1\033[0m/g"  \
        -e "s/\(INFO\)/\033[0;32m\1\033[0m/g"  \
        -e "s/\(DEBUG\)/\033[0;36m\1\033[0m/g"
end
function logtail
    tail -f "$argv[1]" | colorize
end
function httping
    test -z "$argv[1]"; and begin echo "Usage: httping <url>"; return 1; end
    curl -o /dev/null -s -w "%{http_code} %{time_total}s %{url_effective}\n" "$argv[1]"
end
function jsoncheck
    if type -q jq >/dev/null 2>&1
        jq . "$argv[1]" >/dev/null; and echo "✓ Valid JSON"; or echo "✗ Invalid JSON"
    else
        python3 -m json.tool "$argv[1]" >/dev/null; and echo "✓ Valid JSON"; or echo "✗ Invalid JSON"
    end
end
function yamlcheck
    python3 -c "import yaml; yaml.safe_load(open('$1'))" 2>/dev/null \
        ; and echo "✓ Valid YAML"; or echo "✗ Invalid YAML"
end
function tomlcheck
    python3 -c "
try:
    import tomllib
except ImportError:
    import tomli as tomllib
with open('$1','rb') as f: tomllib.load(f)
print('✓ Valid TOML')
" 2>/dev/null; or echo "✗ Invalid TOML"
end
function diffcmds
    diff <(eval "$argv[1]") <(eval "$argv[2]")
end
function watchc
    watch --color -n "$argv[1]" "$argv:2"
end
function repeatn
    set -l n "$argv[1]"; shift
    for i in (seq 0 (math $n - 1)); "$argv"; end
end
function bg_run
    nohup "$argv" >/dev/null 2>&1 &; echo "PID: $last_pid"
end
function wait_for
    set -l host "$argv[1]"; set port "$argv[2]"; set timeout "$argv[3]"
    echo "Waiting for $host:$port (timeout: $timeout)..."
    for i in (seq 0 (math $timeout - 1))
        timeout 1 bash -c ">/dev/tcp/$host/$port" 2>/dev/null; and begin echo "Online!"; return 0; end
        sleep 1
    end
    echo "Timed out waiting for $host:$port"
    return 1
end
function fo
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l f; set f "$(find . -type f -name "*$argv[1]*" 2>/dev/null | fzf \
        --preview 'bat --style=numbers --color=always {} 2>/dev/null; or cat {}')"
    test -n "$f"; and "$EDITOR" "$f"
end
function fcd
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l d; set d "$(find . -type d -not -path '*/.git/*' 2>/dev/null | fzf \
        --preview 'tree -C {} | head -20 2>/dev/null; or ls {}')"
    test -n "$d"; and cd "$d"
end
function fh
    type -q fzf >/dev/null 2>&1; or begin echo "fzf not installed"; return 1; end
    set -l cmd; set cmd (history | awk '{$1=""; print substr($argv[0],2)}' | sort -u | fzf --tac --prompt='history> ')
    test -n "$cmd"; and eval "$cmd"
end
function falias
    type -q fzf >/dev/null 2>&1; or begin alias | less; return; end
        abbr -a | fzf --prompt 'alias> '
end
function fenv
    type -q fzf >/dev/null 2>&1; or begin env | sort | less; return; end
    env | sort | fzf --prompt='env> '
end
if type -q yazi >/dev/null 2>&1
    function y
        ; set -l tmp; set tmp (mktemp -t yazi-cwd.XXXXXX)
        yazi "$argv" --cwd-file="$tmp"
        ; set -l cwd; set cwd (cat -- "$tmp")
        test -n "$cwd"; and "$cwd" != "$PWD"; and cd -- "$cwd"
        rm -f -- "$tmp"
    end
end
if type -q ranger >/dev/null 2>&1
    function ranger-cd
        ; set -l tmp; set tmp (mktemp -t ranger-cwd.XXXXXX)
        ranger --choosedir="$tmp" "$argv"
        ; set -l dir; set dir "(cat "$tmp" 2>/dev/null)"
        rm -f "$tmp"
        test -d "$dir"; and "$dir" != "$PWD"; and cd "$dir"
    end
        abbr -a r 'ranger-cd'
end
set BOOKMARKS_FILE "$HOME/.directory_bookmarks"
function bm
    pwd >> "$BOOKMARKS_FILE"; and sort -u "$BOOKMARKS_FILE" -o "$BOOKMARKS_FILE"; and echo "Bookmarked: (pwd)"
end
function bml
    cat "$BOOKMARKS_FILE" 2>/dev/null; or echo "No bookmarks."
end
function bmrm
    grep -v "^(pwd)\$" "$BOOKMARKS_FILE" > /tmp/bm.tmp; and mv /tmp/bm.tmp "$BOOKMARKS_FILE"; and echo "Removed: (pwd)"
end
function bmclear
    true > "$BOOKMARKS_FILE"; and echo "Bookmarks cleared."
end
function bmgo
    type -q fzf >/dev/null 2>&1; or begin cat "$BOOKMARKS_FILE"; return; end
    set -l d; set d (fzf --prompt='bookmark> ' < "$BOOKMARKS_FILE" 2>/dev/null --prompt='bookmark> ')
    test -n "$d"; and cd "$d"
end
function watchcmd
    while true
    clear
    "$argv"
    sleep 2
    end
end
function title
    printf '\033]0
    %s\007' "$argv"
end
function termsize
    echo "Columns: $COLUMNS  Lines: $LINES"
end
function bench
    set -l n "$argv[1]"; shift
    echo "Running $n iterations of: $argv"
    set -l s; set s (date +%s%N)
    for i in (seq 0 (math $n - 1)); "$argv" >/dev/null 2>&1; end
    set -l e; set e (date +%s%N)
    printf "Total: %.3fs  Avg: %.3fs\n" \
        (echo "scale=3; ($e-$s)/1000000000" | bc) \
        (echo "scale=3; ($e-$s)/1000000000/$n" | bc)
end
function gz
    set -l orig gzip ratio
    set orig (wc -c < "$argv[1]")
    set gzip (gzip -c "$argv[1]" | wc -c)
    set ratio (echo "scale=2; $gzip*100/$orig" | bc)
    printf "orig: %d bytes\ngzip: %d bytes (%.2f%%)\n" "$orig" "$gzip" "$ratio"
end
function doh
    test -z "$argv[1]"; and begin echo "Usage: doh <domain> [type]"; return 1; end
    curl -sH "accept: application/dns-json" \
        "https://cloudflare-dns.com/dns-query?name=$argv[1]&; set type $argv[2]" | python3 -m json.tool 2>/dev/null
end
function httpheaders
    test -z "$argv[1]"; and begin echo "Usage: httpheaders <url>"; return 1; end
    curl -sI --max-time 10 "$argv[1]"
end
function redirects
    test -z "$argv[1]"; and begin echo "Usage: redirects <url>"; return 1; end
    curl -sIL --max-time 15 "$argv[1]" | grep -E "^(HTTP|Location)"
end
function mergepdf
    test (count $argv) -lt 2; and begin echo "Usage: mergepdf <out.pdf> <in1.pdf> <in2.pdf> ..."; return 1; end
    set -l out "$argv[1]"; shift
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$out" "$argv"; and echo "Merged → $out"
end
function splitpdf
    test -z "$argv[1]"; and begin echo "Usage: splitpdf <file.pdf>"; return 1; end
    type -q pdftk >/dev/null 2>&1; or begin echo "Install pdftk"; return 1; end
    pdftk "$argv[1]" burst output "$argv[1]%.pdf_%04d.pdf"
end
function dotlog
    dotlog_show 2>/dev/null; or cat "$DOTFILES_STATE_DIR/errors.log" 2>/dev/null; or echo "No logs."
end
if test "$DOTFILES_OS" = "Darwin"
    function ql
        qlmanage -p "$argv" >/dev/null 2>&1
    end
end
function cleanup
    sudo rm -rf /tmp/* 2>/dev/null; and echo "Cleaned /tmp"
end
function Usage
    du -sh ./* 2>/dev/null | sort -rh | head 10
end
function cloc
    if type -q tokei >/dev/null 2>&1; tokei "$argv[1]"
    else if type -q cloc >/dev/null 2>&1; cloc "$argv[1]"
    else find "$argv[1]" -name "*.$argv[2]" -exec wc -l {} + 2>/dev/null | tail -1
    end
end
function extract
	for archive in "$argv"
		if test -f "$archive"
			switch $archive
			case *.tar.bz2
			    tar xvjf "$archive"
			case *.tar.gz
			    tar xvzf "$archive"
			case *.bz2
			    bunzip2 "$archive"
			case *.rar
			    rar x "$archive"
			case *.gz
			    gunzip "$archive"
			case *.tar
			    tar xvf "$archive"
			case *.tbz2
			    tar xvjf "$archive"
			case *.tgz
			    tar xvzf "$archive"
			case *.zip
			    unzip "$archive"
			case *.Z
			    uncompress "$archive"
			case *.7z
			    7z x "$archive"
			case '*'
			    echo "don't know how to extract '$archive'..."
			end
		else
			echo "'$archive' is not a valid file!"
		end
	end
end
function ftext
	grep -iIHrn --color=always "$argv[1]" . | less -r
end
function cpp
    set -e
    strace -q -ewrite cp -- "$argv[1]" "$argv[2]" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 = 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++) printf "="
            printf ">"
            for (i=percent;i<100;i++) printf " "
            printf "]\r"
        end
    end
    END { print "" }'; set total_size (stat -c '%s' "$argv[1]"); set count 0
end
function cpg
	if test -d "$argv[2]"
		cp "$argv[1]" "$argv[2]"; and cd "$argv[2]"
	else
		cp "$argv[1]" "$argv[2]"
	end
end
function mvg
	if test -d "$argv[2]"
		mv "$argv[1]" "$argv[2]"; and cd "$argv[2]"
	else
		mv "$argv[1]" "$argv[2]"
	end
end
function mkdirg
	mkdir -p "$argv[1]"
	cd "$argv[1]"
end
function up
	; set -l d ""
	; set limit $argv[1]
	for i in (seq 1 $limit)
		; set d $d/..
	end
	; set d (echo $d | sed 's/^\///')
	if test -z "$d"
		; set d ..
	end
	cd "$d"
end
function pwdtail
	pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
end
function distribution
    set -l dtype "unknown"
    if test -r /etc/os-release
        source /etc/os-release
        switch $ID
            case 'fedora' 'rhel' 'centos'
                set dtype "redhat"
            case 'sles' 'opensuse*'
                set dtype "suse"
            case 'ubuntu' 'debian'
                set dtype "debian"
            case gentoo
                set dtype "gentoo"
            case 'arch' 'manjaro'
                set dtype "arch"
            case slackware
                set dtype "slackware"
            case '*'
                if test -n "$ID_LIKE"
                    switch $ID_LIKE
                        case '*fedora*' '*rhel*' '*centos*'
                            set dtype "redhat"
                        case '*sles*' '*opensuse*'
                            set dtype "suse"
                        case '*ubuntu*' '*debian*'
                            set dtype "debian"
                        case *gentoo*
                            set dtype "gentoo"
                        case *arch*
                            set dtype "arch"
                        case *slackware*
                            set dtype "slackware"
                    end
                end
        end
    end
    echo $dtype
end
function ver
    set -l dtype
    set dtype (distribution)
    switch $dtype
        case redhat
            if test -s /etc/redhat-release; cat /etc/redhat-release; else cat /etc/issue; end; uname -a
        case suse
            cat /etc/SuSE-release
        case debian
            lsb_release -a
        case gentoo
            cat /etc/gentoo-release
        case arch
            cat /etc/os-release
        case slackware
            cat /etc/slackware-version
        case '*'
            if test -s /etc/issue; cat /etc/issue; else echo "Error: Unknown distribution"; exit 1; end
    end
end
function install_bashrc_support
	; set -l dtype; set dtype (distribution)
	switch $dtype
		case redhat
		    sudo yum install multitail tree zoxide trash-cli fzf bash-completion fastfetch
		case suse
		    sudo zypper install multitail tree zoxide trash-cli fzf bash-completion fastfetch
		case debian
			sudo apt-get install multitail tree zoxide trash-cli fzf bash-completion
			case 'FASTFETCH_URL=$curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest ' ' grep browser_download_url.*linux-amd64.deb ' ' cut -d '' -f 4'
			curl -sL "$FASTFETCH_URL" -o /tmp/fastfetch_latest_amd64.deb
			sudo apt-get install /tmp/fastfetch_latest_amd64.deb
		case arch
		    sudo paru multitail tree zoxide trash-cli fzf bash-completion fastfetch
		case slackware
		    echo "No install support for Slackware"
		case '*'
		    echo "Unknown distribution"
	end
end
function whatsmyip
    set -l iface
    set iface (ip route show default | awk '/default/ {print $argv[5]}' | head -n1)
    if test -z "$iface"
        ; set iface (ip -o link show | awk -F': ' '$2 != "lo" {print $argv[2]}' | head -n1)
    end
    if test -n "$iface"
        echo -n "Internal IP ($iface): "
        ip addr show "$iface" | grep "inet " | awk '{print $argv[2]}' | cut -d/ -f1
    else
        echo "Internal IP: No interface found"
    end
    echo -n "External IP: "
    curl -4s --max-time 5 ifconfig.me; or echo "Timeout/Offline"
end
function apachelog
	if test -f /etc/httpd/conf/httpd.conf
		cd /var/log/httpd; and ls -xAh; and multitail --no-repeat -c -s 2 /var/log/httpd/*_log
	else
		cd /var/log/apache2; and ls -xAh; and multitail --no-repeat -c -s 2 /var/log/apache2/*.log
	end
end
function apacheconfig
	if test -f /etc/httpd/conf/httpd.conf; sedit /etc/httpd/conf/httpd.conf
	else if test -f /etc/apache2/apache2.conf; sedit /etc/apache2/apache2.conf
	else
		echo "Error: Apache config file could not be found."
		sudo updatedb; and locate httpd.conf; and locate apache2.conf
	end
end
function phpconfig
	if test -f /etc/php.ini; sedit /etc/php.ini
	else if test -f /etc/php/php.ini; sedit /etc/php/php.ini
	else if test -f /etc/php5/php.ini; sedit /etc/php5/php.ini
	else if test -f /usr/bin/php5/bin/php.ini; sedit /usr/bin/php5/bin/php.ini
	else if test -f /etc/php5/apache2/php.ini; sedit /etc/php5/apache2/php.ini
	else
		echo "Error: php.ini file could not be found."
		sudo updatedb; and locate php.ini
	end
end
function mysqlconfig
	if test -f /etc/my.cnf; sedit /etc/my.cnf
	else if test -f /etc/mysql/my.cnf; sedit /etc/mysql/my.cnf
	else if test -f /usr/local/etc/my.cnf; sedit /usr/local/etc/my.cnf
	else if test -f /usr/bin/mysql/my.cnf; sedit /usr/bin/mysql/my.cnf
	else if test -f ~/my.cnf; sedit ~/my.cnf
	else if test -f ~/.my.cnf; sedit ~/.my.cnf
	else
		echo "Error: my.cnf file could not be found."
		sudo updatedb; and locate my.cnf
	end
end
function gcom
	git add .
	git commit -m "$argv[1]"
end
function lazyg
	git add .
	git commit -m "$argv[1]"
	git push
end
function hb
    if test (count $argv) -eq 0
        echo "No file path specified."
        return
    else if test ! -f "$argv[1]"
        echo "File path does not exist."
        return
    end
    set uri "http://bin.christitus.com/documents"
    if set response (curl -s -X POST -d @"$argv[1]" "$uri")
        ; set hasteKey (echo "$response" | jq -r '.key')
        echo "http://bin.christitus.com/$hasteKey"
    else
        echo "Failed to upload the document."
    end
end
function fshow
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$argv" |
  fzf --ansi --no-sort --reverse --multi --header 'Git Log (Enter to show, Tab to multi-select)' \
    --preview "git show --color=always \(echo {} | grep -o '[a-f0-9]\{7,40\}' | head -n 1)" \
    --bind "enter:execute(git show --color=always \(echo {} | grep -o '[a-f0-9]\{7,40\}' | head -n 1) | less -R)"
end
function ipinfo
    curl -s "https://ipapi.co/$argv[1]/json/" | jq . 2>/dev/null; or curl -s "https://ipapi.co/$argv[1]/json/"
end
function transfer
    if test (count $argv) -eq 0
        echo "No arguments specified."
        return 1
    end
    set -l file $argv[1]
    set -l filename; set filename (basename "$file")
    curl --progress-bar --upload-file "$file" "https://transfer.sh/$filename"
end
function speedtest
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
end
function tmpdir
    set -l dir; set dir (mktemp -d)
    cd "$dir"
    echo "Temporary directory: $dir"
end
function fnr
    if test (count $argv) -lt 2
        echo "Usage: fnr <search_string> <replace_string>"
        return 1
    end
    grep -rl "$argv[1]" . | xargs sed -i "s/$argv[1]/$argv[2]/g"
end