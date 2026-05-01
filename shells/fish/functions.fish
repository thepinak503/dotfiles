# =============================================================================
# Universal Fish Functions - Linux & macOS Compatible
# =============================================================================

# ---------- DETECT OS ----------
function detect_os --description "Detect operating system"
    if test (uname -s) = "Darwin"
        echo "macos"
    else if test -f /etc/os-release
        source /etc/os-release
        echo "$ID"
    else if test -f /etc/arch-release
        echo "arch"
    else if test -f /etc/debian_version
        echo "debian"
    else if test -f /etc/fedora-release
        echo "fedora"
    else
        echo "linux"
    end
end

function detect_pm --description "Detect package manager"
    if type -q brew
        echo "brew"
    else if type -q pacman
        echo "pacman"
    else if type -q apt
        echo "apt"
    else if type -q dnf
        echo "dnf"
    else if type -q yum
        echo "yum"
    else if type -q apk
        echo "apk"
    else
        echo "none"
    end
end

# ---------- NAVIGATION ----------
function cd --description "Change directory with ls"
   builtin cd $argv; and ls -A
end

function back --description "Go to previous directory"
    cd -
end

function cdup --description "Go up one directory"
    cd ..
end

function cdup2 --description "Go up two directories"
    cd ../..
end

function cdhome --description "Go home"
    cd ~
end

function cdroot --description "Go to root"
    cd /
end

function mkcd --description "Make and cd into directory"
    mkdir -p $argv[1]; and cd $argv[1]
end

function take --description "Make and cd into directory"
    mkdir -p $argv[1]; and cd $argv[1]
end

function pushd --description "Push directory"
    pushd $argv[1] >/dev/null; and ls
end

function popd --description "Pop directory"
    popd >/dev/null
end

function cdd --description "Go to Downloads"
    cd ~/Downloads
end

function cddoc --description "Go to Documents"
    cd ~/Documents
end

function cdpic --description "Go to Pictures"
    cd ~/Pictures
end

function cdmus --description "Go to Music"
    cd ~/Music
end

function cdvid --description "Go to Videos"
    cd ~/Videos
end

function cdproj --description "Go to projects"
    cd ~/projects
end

function cdt --description "Go to dotfiles"
    cd ~/.local/share/dotfiles
end

# ---------- SYSTEM ----------
function p --description "List processes"
    ps aux | head -20
end

function psg --description "Grep processes"
    ps aux | grep $argv[1]
end

function psa --description "All processes"
    ps aux
end

function pf --description "Find process"
    pgrep -f $argv[1]
end

function top --description "Top processes"
    command top -o $argv[1]
end

function topc --description "Top by CPU"
    command top -o cpu
end

function topm --description "Top by memory"
    command top -o mem
end

function cores --description "Number of CPU cores"
    if type -q sysctl
        sysctl -n hw.ncpu
    else
        nproc
    end
end

function ram --description "Memory usage"
    if type -q vm_stat
        vm_stat
    else
        free -h
    end
end

function mem --description "Memory usage"
    free -h
end

function load --description "System load"
    uptime
end

function myip --description "Public IP"
    curl -s https://api.ipify.org
end

function localip --description "Local IP"
    if type -q ipconfig
        ipconfig getifaddr en0
    else
        ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1
    end
end

function pubip --description "Public IP"
    curl -s https://api.ipify.org
end

function ports --description "List open ports"
    if type -q lsof
        lsof -i -n -P
    else
        netstat -tulanp
    end
end

function port --description "Check port"
    if type -q lsof
        lsof -i :$argv[1]
    else
        netstat -tulpn | grep ":$argv[1] "
    end
end

# ---------- FILES ----------
function la --description "List all files"
    ls -AGa $argv
end

function ll --description "List with details"
    ls -AGl $argv
end

function l --description "List one per line"
    ls -1 $argv
end

function lsla --description "List with details all"
    ls -lA $argv
end

function lt --description "List recent files"
    ls -A | head -30
end

function lsz --description "List by size"
    ls -lS | head -10
end

function lsnew --description "List newest files"
    ls -t | head -10
end

function lsold --description "List oldest files"
    ls -tr | head -10
end

function ff --description "Find file"
    find . -name "*$argv[1]*"
end

function ffd --description "Find directory"
    find . -name "*$argv[1]*" -type d
end

function fff --description "Find file type"
    find . -name "*$argv[1]*" -type f
end

function frep --description "Find and grep"
    grep -r "$argv[1]" . --include="*$argv[2]*"
end

function du1 --description "Disk usage one level"
    du -h --max-depth=1
end

function dus --description "Disk usage sum"
    du -sh $argv
end

function df --description "Disk free"
    df -h
end

# ---------- ARCHIVE ----------
function extract --description "Extract archive"
    for f in $argv
        if test -f $f
            switch (string match -r '\.([^.]+)$' $f)
                case tar.gz tgz
                    tar -xzf $f
                case tar.bz2 tbz2
                    tar -xjf $f
                case tar.xz txz
                    tar -xJf $f
                case tar
                    tar -xf $f
                case gz
                    gunzip -k $f
                case zip
                    unzip $f
                case rar
                    unrar x $f
                case 7z
                    7z x $f
                case '*'
                    echo "Unknown: $f"
            end
        end
    end
end

function tarx --description "Extract tar"
    tar -xf $argv[1]
end

function tarc --description "Create tar.gz"
    tar -czf "$argv[2].tar.gz" $argv[1]
end

function tarz --description "Create tar.gz"
    tar -czf "$argv[1].tar.gz" $argv[1]
end

function zipf --description "Zip folder"
    zip -r "$argv[1].zip" $argv[1]
end

function unzipf --description "Unzip"
    unzip $argv[1]
end

function gz --description "Gzip file"
    gzip -k $argv[1]
end

function ungz --description "Gunzip file"
    gunzip -k $argv[1]
end

# ---------- TEXT ----------
function catn --description "Cat with line numbers"
    cat -n $argv[1]
end

function tal --description "Tail lines"
    tail -30 $argv[1]
end

function headn --description "Head lines"
    head -30 $argv[1]
end

function tailf --description "Tail follow"
    tail -f $argv[1]
end

function wcl --description "Count lines"
    wc -l $argv[1]
end

function wcc --description "Count characters"
    wc -c $argv[1]
end

function sortu --description "Sort unique"
    sort -u $argv[1]
end

function grepn --description "Grep with line numbers"
    grep -n $argv[1] $argv[2]
end

function grepi --description "Grep case insensitive"
    grep -ri $argv[1] $argv[2]
end

function grepv --description "Grep invert"
    grep -v $argv[1] $argv[2]
end

# ---------- ENCODING ----------
function b64e --description "Base64 encode"
    echo -n $argv[1] | base64
end

function b64d --description "Base64 decode"
    echo -n $argv[1] | base64 -d
end

function url_enc --description "URL encode"
    python3 -c "import urllib.parse; print(urllib.parse.quote('$argv[1]'))"
end

function url_dec --description "URL decode"
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$argv[1]'))"
end

function json_fmt --description "Format JSON"
    python3 -m json.tool $argv[1]
end

function md5 --description "MD5 hash"
    if type -q md5
        md5 -q $argv[1]
    else
        md5sum $argv[1] | cut -d' ' -f1
    end
end

function sha256 --description "SHA256 hash"
    if type -q shasum
        shasum -a 256 $argv[1] | cut -d' ' -f1
    else
        sha256sum $argv[1] | cut -d' ' -f1
    end
end

# ---------- EDITORS ----------
function v --description "Vim"
    nvim $argv
end

function vi --description "Vim"
    nvim $argv
end

function nvim --description "Neovim"
    nvim $argv
end

function nano --description "Nano"
    nano $argv
end

function code --description "VS Code"
    code $argv
end

function edit --description "Edit"
    $EDITOR $argv
end

# ---------- GIT ----------
function g --description "Git"
    git $argv
end

function gs --description "Git status"
    git status
end

function ga --description "Git add"
    git add $argv
end

function gaa --description "Git add all"
    git add -A
end

function gc --description "Git commit"
    git commit -m "$argv[1]"
end

function gca --description "Git commit all"
    git commit -am "$argv[1]"
end

function gp --description "Git push"
    git push
end

function gpf --description "Git push force"
    git push -f
end

function gpu --description "Git push set upstream"
    git push -u origin $argv[1]
end

function gl --description "Git pull"
    git pull
end

function glr --description "Git pull rebase"
    git pull --rebase
end

function gf --description "Git fetch"
    git fetch
end

function gb --description "Git branch"
    git branch
end

function gba --description "Git branch all"
    git branch -a
end

function gbd --description "Git branch delete"
    git branch -d $argv[1]
end

function gco --description "Git checkout"
    git checkout $argv[1]
end

function gcb --description "Git checkout branch"
    git checkout -b $argv[1]
end

function gd --description "Git diff"
    git diff
end

function gds --description "Git diff staged"
    git diff --staged
end

function glog --description "Git log"
    git log --oneline -20
end

function glog1 --description "Git log 10"
    git log --oneline -10
end

function glogf --description "Git log graph"
    git log --oneline --graph --all -20
end

function gst --description "Git stash"
    git stash
end

function gsp --description "Git stash pop"
    git stash pop
end

function gss --description "Git stash show"
    git stash show
end

function gsl --description "Git stash list"
    git stash list
end

function gclean --description "Git clean"
    git clean -fd
end

function greset --description "Git reset soft"
    git reset HEAD~1 --soft
end

function greseth --description "Git reset hard"
    git reset --hard HEAD~1
end

function gtag --description "Git tag"
    git tag $argv[1]
end

function gtagd --description "Git tag delete"
    git tag -d $argv[1]
end

# ---------- DOCKER ----------
function d --description "Docker"
    docker $argv
end

function dps --description "Docker ps"
    docker ps
end

function dpsa --description "Docker ps all"
    docker ps -a
end

function di --description "Docker images"
    docker images
end

function de --description "Docker exec"
    docker exec -it $argv[1] /bin/sh
end

function deb --description "Docker exec bash"
    docker exec -it $argv[1] /bin/bash
end

function dl --description "Docker logs"
    docker logs -f $argv[1]
end

function dstop --description "Docker stop"
    docker stop $argv[1]
end

function dstart --description "Docker start"
    docker start $argv[1]
end

function dres --description "Docker restart"
    docker restart $argv[1]
end

function drm --description "Docker rm"
    docker rm $argv[1]
end

function drmi --description "Docker rmi"
    docker rmi $argv[1]
end

function dprune --description "Docker prune"
    docker system prune -af
end

function dbuild --description "Docker build"
    docker build -t $argv[1] .
end

function drun --description "Docker run"
    docker run -it --rm $argv[1] $argv[2]
end

# ---------- KUBERNETES ----------
function k --description "Kubectl"
    kubectl $argv
end

function kga --description "Get all"
    kubectl get all --all-namespaces
end

function kgp --description "Get pods"
    kubectl get pods
end

function kgpa --description "Get pods all ns"
    kubectl get pods --all-namespaces
end

function kgs --description "Get services"
    kubectl get svc
end

function kgd --description "Get deployments"
    kubectl get deployments
end

function kgn --description "Get nodes"
    kubectl get nodes
end

function kex --description "Kubectl exec"
    kubectl exec -it $argv[1] -- /bin/sh
end

function kexb --description "Kubectl exec bash"
    kubectl exec -it $argv[1] -- /bin/bash
end

function klogs --description "Kubectl logs"
    kubectl logs -f $argv[1]
end

function kpfo --description "Port forward"
    kubectl port-forward $argv[1] "$argv[2]:$argv[3]"
end

function kapply --description "Apply"
    kubectl apply -f $argv[1]
end

function kdel --description "Delete"
    kubectl delete -f $argv[1]
end

function kscale --description "Scale"
    kubectl scale deployment $argv[1] --replicas=$argv[2]
end

function kver --description "Kubectl version"
    kubectl version --client
end

function kctx --description "List contexts"
    kubectl config get-contexts
end

function kcur --description "Current context"
    kubectl config current-context
end

# ---------- PACKAGE MANAGERS ----------
function upd --description "Update packages"
    switch (detect_pm)
        case brew
            brew update; and brew upgrade
        case apt
            sudo apt update; and sudo apt upgrade
        case dnf
            sudo dnf upgrade
        case pacman
            sudo pacman -Syu
    end
end

function pin --description "Install package"
    switch (detect_pm)
        case brew
            brew install $argv
        case apt
            sudo apt install $argv
        case dnf
            sudo dnf install $argv
        case pacman
            sudo pacman -S $argv
    end
end

function pun --description "Uninstall package"
    switch (detect_pm)
        case brew
            brew uninstall $argv
        case apt
            sudo apt remove $argv
        case dnf
            sudo dnf remove $argv
        case pacman
            sudo pacman -R $argv
    end
end

function q --description "Search package"
    switch (detect_pm)
        case brew
            brew search $argv
        case apt
            apt search $argv
        case dnf
            sudo dnf search $argv
        case pacman
            pacman -Ss $argv
    end
end

function ql --description "List packages"
    switch (detect_pm)
        case brew
            brew list
        case apt
            dpkg -l
        case dnf
            dnf list installed
        case pacman
            pacman -Q
    end
end

# Brew specific
function bi --description "Brew install"
    brew install $argv
end

function br --description "Brew uninstall"
    brew uninstall $argv
end

function bu --description "Brew update"
    brew update; and brew upgrade
end

function bl --description "Brew list"
    brew list
end

function bout --description "Brew outdated"
    brew outdated
end

function bclean --description "Brew cleanup"
    brew cleanup
end

# ---------- TMUX ----------
function t --description "Tmux"
    tmux $argv
end

function ta --description "Tmux attach"
    tmux attach
end

function tat --description "Tmux attach"
    tmux attach -t $argv[1]
end

function tls --description "Tmux list"
    tmux ls
end

function tnew --description "Tmux new"
    tmux new -s $argv[1]
end

function tkill --description "Tmux kill"
    tmux kill-session -t $argv[1]
end

# ---------- NETWORK ----------
function ping --description "Ping host"
    ping -c 4 $argv[1]
end

function curli --description "Curl headers"
    curl -I $argv[1]
end

function curls --description "Curl GET"
    curl -s $argv[1]
end

function curlj --description "Curl JSON"
    curl -s $argv[1] | jq .
end

function wget --description "Wget"
    wget -c $argv[1]
end

function nc --description "Netcat"
    nc -zv $argv[1] $argv[2]
end

function dig --description "DNS lookup"
    dig +short $argv[1]
end

function ns --description "Nslookup"
    nslookup $argv[1]
end

function host --description "Host lookup"
    host $argv[1]
end

function whois --description "Whois lookup"
    whois $argv[1]
end

function mtr --description "Mtr trace"
    mtr -c 5 $argv[1]
end

function nmap --description "Nmap scan"
    nmap $argv[1]
end

# ---------- NODE ----------
function ni --description "NPM install"
    npm install $argv
end

function nis --description "NPM install save"
    npm install -S $argv
end

function nid --description "NPM install dev"
    npm install -D $argv
end

function nig --description "NPM global install"
    npm install -g $argv
end

function nu --description "NPM update"
    npm update
end

function nun --description "NPM uninstall"
    npm uninstall $argv
end

function nr --description "NPM run"
    npm run $argv
end

function ntest --description "NPM test"
    npm test
end

function ndev --description "NPM dev"
    npm run dev
end

function nbuild --description "NPM build"
    npm run build
end

function nd --description "NPM init"
    npm init -y
end

# Yarn
function yi --description "Yarn add"
    yarn add $argv
end

function yrem --description "Yarn remove"
    yarn remove $argv
end

function yup --description "Yarn upgrade"
    yarn upgrade
end

function yrun --description "Yarn run"
    yarn $argv
end

# ---------- PYTHON ----------
function pip_in --description "Pip install"
    pip install $argv
end

function pip_un --description "Pip uninstall"
    pip uninstall $argv
end

function pip_up --description "Pip upgrade"
    pip install --upgrade pip
end

function piplist --description "Pip list"
    pip list
end

function pipfreeze --description "Pip freeze"
    pip freeze
end

function pyvenv --description "Python venv"
    python3 -m venv $argv[1]
end

function pyact --description "Activate venv"
    source $argv[1]/bin/activate.fish
end

function pyhttp --description "HTTP server"
    python3 -m http.server $argv[1]
end

function pyjson --description "JSON format"
    python3 -m json.tool $argv[1]
end

# ---------- GO ----------
function go_run --description "Go run"
    go run .
end

function go_build --description "Go build"
    go build -o $argv[1] .
end

function go_test --description "Go test"
    go test -v ./...
end

function go_get --description "Go get"
    go get $argv
end

# ---------- RUST ----------
function cbuild --description "Cargo build"
    cargo build
end

function crel --description "Cargo release"
    cargo build --release
end

function crun --description "Cargo run"
    cargo run
end

function ctest --description "Cargo test"
    cargo test
end

function ccheck --description "Cargo check"
    cargo check
end

function cfmt --description "Cargo fmt"
    cargo fmt
end

# ---------- DATABASE ----------
function my --description "MySQL"
    mysql -u root -p$argv[1]
end

function pg --description "PostgreSQL"
    psql -U postgres
end

function pgdb --description "PostgreSQL db"
    psql -U postgres -d $argv[1]
end

function mongo --description "MongoDB"
    mongosh
end

function mongodump --description "Mongo dump"
    mongodump --out=$argv[1]
end

function mongorestore --description "Mongo restore"
    mongorestore --dir=$argv[1]
end

function redis --description "Redis CLI"
    redis-cli
end

# ---------- CLOUD ----------
function tf --description "Terraform"
    terraform $argv
end

function tfp --description "Terraform plan"
    terraform plan
end

function tfa --description "Terraform apply"
    terraform apply
end

function tfi --description "Terraform init"
    terraform init
end

function tfd --description "Terraform destroy"
    terraform destroy
end

# Helm
function helm_l --description "Helm list"
    helm list
end

function helm_in --description "Helm install"
    helm install $argv[1] $argv[2]
end

function helm_un --description "Helm uninstall"
    helm uninstall $argv[1]
end

function helm_up --description "Helm upgrade"
    helm upgrade $argv[1] $argv[2]
end

# ---------- MONITORING ----------
function htop --description "Htop"
    htop
end

function atop --description "Atop"
    atop 1 1
end

function btop --description "Btop"
    btop
end

function glances --description "Glances"
    glances
end

# ---------- SERVICES ----------
function sc --description "Systemctl"
    systemctl $argv
end

function scs --description "Systemctl status"
    systemctl status $argv[1]
end

function scst --description "Systemctl start"
    systemctl start $argv[1]
end

function scsp --description "Systemctl stop"
    systemctl stop $argv[1]
end

function scres --description "Systemctl restart"
    systemctl restart $argv[1]
end

# macOS
function launc --description "Launchctl load"
    launchctl load $argv[1]
end

function lunlaunc --description "Launchctl unload"
    launchctl unload $argv[1]
end

function llist --description "Launchctl list"
    launchctl list
end

# ---------- LOGS ----------
function tailf --description "Tail follow"
    tail -f -n 100 $argv[1]
end

function tal --description "Tail lines"
    tail -100 $argv[1]
end

function journal --description "Journalctl follow"
    journalctl -f -u $argv[1]
end

function journal1 --description "Journalctl"
    journalctl -n 100 -u $argv[1]
end

# ---------- TIME ----------
function now --description "Current time"
    date "+%Y-%m-%d %H:%M:%S"
end

function ts --description "Timestamp"
    date +%s
end

function fromts --description "From timestamp"
    date -r $argv[1]
end

function cal --description "Calendar"
    cal
end

# ---------- CALCULATOR ----------
function calc --description "Calculate"
    echo $argv[1] | bc -l
end

function factor --description "Factor"
    factor $argv[1]
end

# ---------- RANDOM ----------
function rand --description "Random number"
    shuf -i 1-$argv[1] -n 1
end

function uuid --description "UUID"
    if type -q uuidgen
        uuidgen
    else
        cat /proc/sys/kernel/random/uuid
    end
end

# ---------- SYSTEM INFO ----------
function neofetch --description "Neofetch"
    neofetch
end

function neofetch1 --description "Neofetch"
    neofetch
end

function ffetch --description "Fastfetch"
    fastfetch
end

function sysinfo --description "System info"
    uname -a
end

function osv --description "OS version"
    if type -q sw_vers
        sw_vers
    else
        cat /etc/os-release
    end
end

function hostn --description "Hostname"
    hostname
end

function kernel --description "Kernel version"
    uname -r
end

function up --description "Uptime"
    uptime
end

function whoami --description "Who am I"
    whoami
end

# ---------- PERMISSIONS ----------
function chmodx --description "Chmod +x"
    chmod +x $argv[1]
end

function chown_u --description "Chown user:group"
    sudo chown $argv[1]:$argv[2] $argv[3]
end

# ---------- PROCESSES ----------
function killp --description "Kill process by name"
    pkill -f $argv[1]
end

function kill9p --description "Kill -9 process"
    pkill -9 -f $argv[1]
end

function pstop --description "Stop process"
    kill -STOP $argv[1]
end

function pcont --description "Continue process"
    kill -CONT $argv[1]
end

# ---------- HARDWARE ----------
function lscpu --description "CPU info"
    lscpu
end

function lsmod --description "Kernel modules"
    lsmod
end

function lspci --description "PCI devices"
    lspci -v
end

function lsusb --description "USB devices"
    lsusb
end

function lsblk --description "Block devices"
    lsblk
end

function sensors --description "Sensors"
    sensors
end

# ---------- ENV ----------
function env --description "List env"
    printenv | sort
end

function env_g --description "Get env"
    printenv $argv[1]
end

function path --description "List PATH"
    echo $PATH | tr ':' '\n'
end

function pathadd --description "Add to PATH"
    set -gx PATH $argv[1] $PATH
end

# ---------- HELPERS ----------
function which --description "Which command"
    which $argv[1]
end

function type_cmd --description "Type command"
    type $argv[1]
end

# ---------- BACKUP ----------
function bak --description "Backup file"
    cp -r $argv[1] $argv[1].bak-(date +%Y%m%d)
end

function rsync_cp --description "Rsync copy"
    rsync -avz --progress $argv[1]/ $argv[2]/
end

# ---------- HTTP ----------
function http --description "HTTP server"
    python3 -m http.server $argv[1]
end

function serve --description "HTTP server"
    python3 -m http.server $argv[1]
end

# ---------- FUN ----------
function coin --description "Flip coin"
    if test (random 0 1) = "0"
        echo "🪙 Heads"
    else
        echo "🪙 Tails"
    end
end

function roll --description "Roll dice"
    shuf -i 1-6 -n 1
end

# ---------- QUICK ----------
function cls --description "Clear screen"
    clear
end

function q --description "Exit"
    exit 0
end

function reload --description "Reload config"
    source ~/.config/fish/config.fish
end

# ---------- FIND ----------
function f_type --description "Find by type"
    find . -type $argv[1]
end

function f_name --description "Find by name"
    find . -name "*$argv[1]*"
end

# ---------- GIT QUICK ----------
function gstat --description "Git status short"
    git status -s
end

function gch --description "Git changed files"
    git diff --name-only
end

# ---------- DOCKER QUICK ----------
function dlogs --description "Docker logs"
    docker logs --tail 100 $argv[1]
end

# ---------- NPM ----------
function nsp --description "NPM show"
    npm show $argv
end

# ---------- MAVEN ----------
function mvn_ci --description "Maven clean install"
    mvn clean install
end

function mvn_c --description "Maven clean"
    mvn clean
end

function mvn_p --description "Maven package"
    mvn package
end

function mvnt --description "Maven test"
    mvn test
end

# ---------- COMPOSE ----------
function dcu --description "Docker compose up"
    docker-compose up -d
end

function dcd --description "Docker compose down"
    docker-compose down
end

function dcr --description "Docker compose restart"
    docker-compose restart
end

function dcps --description "Docker compose ps"
    docker-compose ps
end

function dcb --description "Docker compose build"
    docker-compose build
end

# ---------- COPY ----------
function copy --description "Copy to clipboard"
    if type -q pbcopy
        pbcopy < $argv[1]
    else if type -q xclip
        xclip -selection clipboard < $argv[1]
    end
end

function paste --description "Paste from clipboard"
    if type -q pbpaste
        pbpaste
    else if type -q xclip
        xclip -selection clipboard -o
    end
end

# ---------- KEYCHAIN ----------
function ssh_add --description "SSH add key"
    ssh-add $argv
end

function ssh_ls --description "SSH list keys"
    ssh-add -l
end

function ssh_copy --description "SSH copy id"
    ssh-copy-id $argv[1]
end

# ---------- SCREEN ----------
function slist --description "Screen list"
    screen -ls
end

function sattach --description "Screen attach"
    screen -x $argv[1]
end

function snew --description "Screen new"
    screen -S $argv[1]
end

# ---------- NOTES ----------
function note --description "Add note"
    echo $argv[1] >> NOTES.md
end

function notes --description "Show notes"
    if test -f NOTES.md
        cat NOTES.md
    end
end

function todo --description "Add todo"
    echo "- [ ] $argv[1]" >> TODO.md
end

function todos --description "Show todos"
    if test -f TODO.md
        cat TODO.md
    end
end

# ---------- PROJECT ----------
function pinit --description "Init project"
    mkdir -p $argv[1]; and cd $argv[1]; and git init
end

function p_py --description "Create Python script"
    echo "#!/usr/bin/env python3" > $argv[1].py; and chmod +x $argv[1].py
end

function p_sh --description "Create shell script"
    echo "#!/usr/bin/env bash" > $argv[1].sh; and chmod +x $argv[1].sh
end

# ---------- DOTFILES ----------
function dot --description "Go to dotfiles"
    cd ~/.local/share/dotfiles
end

function dotsync --description "Sync dotfiles"
    cd ~/.local/share/dotfiles; and git pull
end

function dotedit --description "Edit dotfiles"
    cd ~/.local/share/dotfiles; and $EDITOR .
end

# ---------- SSH KEYS ----------
function ssh_key --description "Generate SSH key"
    ssh-keygen -t ed25519 -C $argv[1]
end

function ssh_keyr --description "Generate RSA SSH key"
    ssh-keygen -t rsa -b 4096 -C $argv[1]
end

# ---------- MACOS SPECIFIC ----------
function mac_afk --description "Display sleep"
    pmset displaysleepnow
end

function mac_sleep --description "Sleep"
    pmset sleepnow
end

function mac_restart --description "Restart"
    sudo shutdown -r now
end

function mac_shutdown --description "Shutdown"
    sudo shutdown -h now
end

function showfiles --description "Show hidden files"
    defaults write com.apple.finder AppleShowAllFiles -bool TRUE; and killall Finder
end

function hidefiles --description "Hide hidden files"
    defaults write com.apple.finder AppleShowAllFiles -bool FALSE; and killall Finder
end

function safari --description "Open Safari"
    open -a Safari $argv
end

function chrome --description "Open Chrome"
    open -a "Google Chrome" $argv
end

function finder --description "Open Finder"
    open .
end

function ql --description "Quick Look"
    qlmanage -p $argv[1]
end

function spotlight --description "Spotlight search"
    mdfind $argv[1]
end

# ---------- LINUX SPECIFIC ----------
function linux_iotop --description "Iotop"
    sudo iotop -b -o
end

function linux_lsof --description "Lsof"
    sudo lsof -i -n -P
end

echo "Loaded universal fish functions (Linux + macOS)"