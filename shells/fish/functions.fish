# =============================================================================

# =============================================================================


function detect_os --description "Detect operating system"
    if test (uname -s) = "Darwin"
        echo "macos"
    else if test -f /etc/os-release
        set -l os_id (grep '^ID=' /etc/os-release | cut -d= -f2)
        echo "$os_id"
    else if test -f /etc/arch-release
        echo "arch"
    else if test -f /etc/debian_version
        echo "Debian"
    else if test -f /etc/fedora-release
        echo "fedora"
    else
        echo "Linux"
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


function cd --description "Change directory"
    if status is-interactive
        builtin cd $argv; and ls -A
    else
        builtin cd $argv
    end
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
    if status is-interactive
        command pushd $argv[1] >/dev/null; and ls
    else
        command pushd $argv[1] >/dev/null
    end
end

function popd --description "Pop directory"
    command popd >/dev/null
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
    command df -h
end


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


function v --description "Vim"
    nvim $argv
end

function vi --description "Vim"
    nvim $argv
end

function nvim --description "Neovim"
    command nvim $argv
end

function nano --description "Nano"
    nano $argv
end

function code --description "VS Code"
    command code $argv
end

function edit --description "Edit"
    $EDITOR $argv
end


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


function ping --description "Ping host"
    command ping -c 4 $argv[1]
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
    command wget -c $argv[1]
end

function nc --description "Netcat"
    nc -zv $argv[1] $argv[2]
end

function dig --description "DNS lookup"
    command dig +short $argv[1]
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


function launc --description "Launchctl load"
    launchctl load $argv[1]
end

function lunlaunc --description "Launchctl unload"
    launchctl unload $argv[1]
end

function llist --description "Launchctl list"
    launchctl list
end


function journal --description "Journalctl follow"
    journalctl -f -u $argv[1]
end

function journal1 --description "Journalctl"
    journalctl -n 100 -u $argv[1]
end


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


function calc --description "Calculate"
    echo $argv[1] | bc -l
end

function factor --description "Factor"
    factor $argv[1]
end


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


function chmodx --description "Chmod +x"
    chmod +x $argv[1]
end

function chown_u --description "Chown user:group"
    sudo chown $argv[1]:$argv[2] $argv[3]
end


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


function which --description "Which command"
    command which $argv[1]
end

function type_cmd --description "Type command"
    type $argv[1]
end


function bak --description "Backup file"
    cp -r $argv[1] $argv[1].bak-(date +%Y%m%d)
end

function rsync_cp --description "Rsync copy"
    rsync -avz --progress $argv[1]/ $argv[2]/
end


function http --description "HTTP server"
    python3 -m http.server $argv[1]
end

function serve --description "HTTP server"
    python3 -m http.server $argv[1]
end


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


function reload --description "Reload config"
    source ~/.config/fish/config.fish
end


function f_type --description "Find by type"
    find . -type $argv[1]
end

function f_name --description "Find by name"
    find . -name "*$argv[1]*"
end


function gstat --description "Git status short"
    git status -s
end

function gch --description "Git changed files"
    git diff --name-only
end


function dlogs --description "Docker logs"
    docker logs --tail 100 $argv[1]
end


function nsp --description "NPM show"
    npm show $argv
end


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


function ssh_add --description "SSH add key"
    ssh-add $argv
end

function ssh_ls --description "SSH list keys"
    ssh-add -l
end

function ssh_copy --description "SSH copy id"
    ssh-copy-id $argv[1]
end


function slist --description "Screen list"
    screen -ls
end

function sattach --description "Screen attach"
    screen -x $argv[1]
end

function snew --description "Screen new"
    screen -S $argv[1]
end


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


function pinit --description "Init project"
    mkdir -p $argv[1]; and cd $argv[1]; and git init
end

function p_py --description "Create Python script"
    echo "#!/usr/bin/env python3" > $argv[1].py; and chmod +x $argv[1].py
end

function p_sh --description "Create shell script"
    echo "#!/usr/bin/env bash" > $argv[1].sh; and chmod +x $argv[1].sh
end


function dot --description "Go to dotfiles"
    cd ~/.local/share/dotfiles
end

function dotsync --description "Sync dotfiles"
    cd ~/.local/share/dotfiles; and git pull
end

function dotedit --description "Edit dotfiles"
    cd ~/.local/share/dotfiles; and $EDITOR .
end


function ssh_key --description "Generate SSH key"
    ssh-keygen -t ed25519 -C $argv[1]
end

function ssh_keyr --description "Generate RSA SSH key"
    ssh-keygen -t rsa -b 4096 -C $argv[1]
end


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

function qlook --description "Quick Look"
    qlmanage -p $argv[1]
end

function spotlight --description "Spotlight search"
    mdfind $argv[1]
end


function linux_iotop --description "Iotop"
    sudo iotop -b -o
end

function linux_lsof --description "Lsof"
    sudo lsof -i -n -P
end


function 7z_compress; 7z a "$argv[1].7z" "$argv[1]"; end

function 7z_decompress; 7z x "$argv[1]"; end

function 7z_encrypt; 7z a -p "$argv[1].7z" "$argv[1]"; end

function 7z_list; 7z l "$argv[1]"; end

function apk_add_pkg; apk add $argv; end

function apk_cache_clean; apk cache clean; end

function apk_info_pkg; apk info $argv; end

function apk_list_installed; apk list -I; end

function apk_list_updates; apk list -u; end

function apk_remove_pkg; apk del $argv; end

function apk_search_pkg; apk search $argv; end

function apk_upgrade_all; apk upgrade; end

function apt_add_ppa; sudo apt-add-repository ppa:"$argv[1]" 2>/dev/null; end

function apt_broken_fix; sudo apt --fix-broken install 2>/dev/null; end

function apt_list_installed; apt list --installed 2>/dev/null; end

function apt_list_upgradable; apt list --upgradable 2>/dev/null; end

function apt_remove_ppa; sudo apt-add-repository --remove ppa:"$argv[1]" 2>/dev/null; end

function apt_search_installed; dpkg -l | grep -i "$argv[1]" 2>/dev/null; end

function awk_calc; awk "BEGIN{print $argv}"; end

function awk_column; awk "{print \$$1}" "$argv[2]"; end

function aws_apigateway_apis; aws apigatewayv2 get-apis --query 'Items[*].[Name,ProtocolType,ApiId]' --output table; end

function aws_cf_invalidate; aws cloudfront create-invalidation --distribution-id "$argv[1]" --paths "$argv[2]"; end

function aws_cf_list; aws cloudfront list-distributions --query 'DistributionList.Items[*].[Id,DomainName,Status]' --output table; end

function aws_cognito_pools; aws cognito-idp list-user-pools --max-results 20 --query 'UserPools[*].[Name,Id]' --output table; end

function aws_cw_alarms; aws cloudwatch describe-alarms --query 'MetricAlarms[*].[AlarmName,StateValue]' --output table; end

function aws_cw_logs; aws logs describe-log-groups --query 'logGroups[*].[logGroupName]' --output table; end

function aws_cw_metrics; aws cloudwatch list-metrics --namespace "$argv[1]" --limit "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)" --output table; end

function aws_dynamo_delete; aws dynamodb delete-item --table-name "$argv[1]" --key "$argv[2]"; end

function aws_dynamo_get; aws dynamodb get-item --table-name "$argv[1]" --key "$argv[2]" --output table; end

function aws_dynamo_list; aws dynamodb list-tables --query 'TableNames[*]' --output table; end

function aws_dynamo_put; aws dynamodb put-item --table-name "$argv[1]" --item "$argv[2]"; end

function aws_dynamo_scan; aws dynamodb scan --table-name "$argv[1]" --limit "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)" --output table; end

function aws_ec2_instances; aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,LaunchTime]' --output table; end

function aws_ec2_instances_running; aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,LaunchTime]' --output table; end

function aws_ec2_instances_stopped; aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,LaunchTime]' --output table; end

function aws_ec2_keypairs; aws ec2 describe-key-pairs --query 'KeyPairs[*].[KeyName,KeyType]' --output table; end

function aws_ec2_reboot; aws ec2 reboot-instances --instance-ids "$argv[1]"; end

function aws_ec2_security_groups; aws ec2 describe-security-groups --query 'SecurityGroups[*].[GroupName,GroupId,VpcId]' --output table; end

function aws_ec2_snapshots; aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[*].[SnapshotId,VolumeSize,StartTime]' --output table; end

function aws_ec2_start; aws ec2 start-instances --instance-ids "$argv[1]"; end

function aws_ec2_stop; aws ec2 stop-instances --instance-ids "$argv[1]"; end

function aws_ec2_subnets; aws ec2 describe-subnets --query 'Subnets[*].[SubnetId,CidrBlock,AvailabilityZone]' --output table; end

function aws_ec2_terminate; aws ec2 terminate-instances --instance-ids "$argv[1]"; end

function aws_ec2_volumes; aws ec2 describe-volumes --query 'Volumes[*].[VolumeId,Size,State,AvailabilityZone]' --output table; end

function aws_ecr_images; aws ecr list-images --repository-name "$argv[1]" --query 'imageIds[*].[imageTag]' --output table; end

function aws_ecr_login; aws ecr get-login-password --region "$argv[1]" | docker login --username AWS --password-stdin "$argv[2]"; end

function aws_ecr_repos; aws ecr describe-repositories --query 'repositories[*].[repositoryName,repositoryUri]' --output table; end

function aws_ecs_clusters; aws ecs list-clusters --query 'clusterArns[*]' --output table; end

function aws_ecs_describe; aws ecs describe-services --cluster "$argv[1]" --services "$argv[2]" --output table; end

function aws_ecs_services; aws ecs list-services --cluster "$argv[1]" --query 'serviceArns[*]' --output table; end

function aws_ecs_tasks; aws ecs list-tasks --cluster "$argv[1]" --query 'taskArns[*]' --output table; end

function aws_eks_clusters; aws eks list-clusters --query 'clusters[*]' --output table; end

function aws_eks_update_kubeconfig; aws eks update-kubeconfig --name "$argv[1]"; end

function aws_elasticache_clusters; aws elasticache describe-cache-clusters --query 'CacheClusters[*].[CacheClusterId,Engine,CacheNodeType]' --output table; end

function aws_iam_groups; aws iam list-groups --query 'Groups[*].[GroupName,CreateDate]' --output table; end

function aws_iam_policies; aws iam list-policies --scope Local --query 'Policies[*].[PolicyName,CreateDate]' --output table; end

function aws_iam_roles; aws iam list-roles --query 'Roles[*].[RoleName,CreateDate]' --output table; end

function aws_iam_users; aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table; end

function aws_lambda_invoke; aws lambda invoke --function-name "$argv[1]" response.json; and cat response.json; and rm -f response.json; end

function aws_lambda_list; aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime]' --output table; end

function aws_lambda_logs; aws logs filter-log-events --log-group-name "/aws/lambda/$argv[1]" --limit "(if set -q argv[2]; echo $argv[2]; else; echo 50; end)" --query 'events[*].[timestamp,message]' --output text; end

function aws_list_ec2; aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key==`Name`].Value|[0]]' --output table 2>/dev/null; or true; end

function aws_list_ecs; aws ecs list-clusters 2>/dev/null; or true; end

function aws_list_eks; aws eks list-clusters 2>/dev/null; or true; end

function aws_list_iam; aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table 2>/dev/null; or true; end

function aws_list_lambda; aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime,MemorySize]' --output table 2>/dev/null; or true; end

function aws_list_logs; aws logs describe-log-groups --query 'logGroups[*].[logGroupName,storedBytes]' --output table 2>/dev/null; or true; end

function aws_list_route53; aws route53 list-hosted-zones --query 'HostedZones[*].[Name,Id]' --output table 2>/dev/null; or true; end

function aws_list_s3; aws s3 ls 2>/dev/null; or true; end

function aws_list_vpc; aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,Tags[?Key==`Name`].Value|[0],CidrBlock]' --output table 2>/dev/null; or true; end

function aws_logs_filter; aws logs filter-log-events --log-group-name "$argv[1]" --filter-pattern "$argv[2]" --limit "(if set -q argv[3]; echo $argv[3]; else; echo 50; end)" --output text; end

function aws_logs_groups; aws logs describe-log-groups --query 'logGroups[*].[logGroupName,storedBytes]' --output table; end

function aws_logs_tail; aws logs tail "$argv[1]" --follow; end

function aws_rds_instances; aws rds describe-db-instances --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceClass,Engine,DBInstanceStatus]' --output table; end

function aws_rds_snapshots; aws rds describe-db-snapshots --query 'DBSnapshots[*].[DBSnapshotIdentifier,DBInstanceIdentifier,SnapshotCreateTime]' --output table; end

function aws_route53_records; aws route53 list-resource-record-sets --hosted-zone-id "$argv[1]" --query 'ResourceRecordSets[*].[Name,Type]' --output table; end

function aws_route53_zones; aws route53 list-hosted-zones --query 'HostedZones[*].[Name,Id]' --output table; end

function aws_s3_browse; aws s3 ls "s3://$argv[1]"; end

function aws_s3_buckets; aws s3api list-buckets --query 'Buckets[*].Name' --output table; end

function aws_s3_presign; aws s3 presign "s3://$argv[1]/$argv[2]" --expires-in "(if set -q argv[3]; echo $argv[3]; else; echo 3600; end)"; end

function aws_s3_size; aws s3api list-objects --bucket "$argv[1]" --output json --query "[sum(Contents[].Size)]" 2>/dev/null; or echo "empty or no access"; end

function aws_s3_sync_down; aws s3 sync "s3://$argv[1]" .; end

function aws_s3_sync_up; aws s3 sync . "s3://$argv[1]" --exclude '.git/*'; end

function aws_s3_website; aws s3 website "s3://$argv[1]" --index-document index.html --error-document error.html; end

function aws_sns_publish; aws sns publish --topic-arn "$argv[1]" --message "$argv[2]"; end

function aws_sns_topics; aws sns list-topics --query 'Topics[*].TopicArn' --output table; end

function aws_sqs_list; aws sqs list-queues --query 'QueueUrls[*]' --output table; end

function aws_sqs_send; aws sqs send-message --queue-url "$argv[1]" --message-body "$argv[2]"; end

function aws_stepfunctions_list; aws stepfunctions list-state-machines --query 'stateMachines[*].[name,creationDate]' --output table; end

function aws_whoami; aws sts get-caller-identity 2>/dev/null; or echo "aws not configured"; end

function az_list_aks; az aks list --output table 2>/dev/null; or true; end

function az_list_groups; az group list --output table 2>/dev/null; or true; end

function az_list_vms; az vm list --output table 2>/dev/null; or true; end

function backup_dir; tar -czf (string trim -r -c / -- $argv[1])".tar.gz" $argv[1]; and echo "backup: "(string trim -r -c / -- $argv[1])".tar.gz"; end

function backup_file; cp -r "$argv[1]" "$argv[1].bak-"(date +%Y%m%d-%H%M%S); and echo "backup: $argv[1].bak-"(date +%Y%m%d-%H%M%S); end

function backup_with_date; tar -czf (string trim -r -c / -- $argv[1])"-(date +%Y%m%d).tar.gz" $argv[1]; end

function bandwhich_monitor; sudo bandwhich 2>/dev/null; or echo "bandwhich needed"; end

function bandwidth_test; curl -fsSL https://speedtest.net 2>/dev/null; or echo "speedtest-cli needed"; end

function bashtop_monitor; bashtop 2>/dev/null; or bpytop 2>/dev/null; or echo "bashtop/bpytop needed"; end

function bat_cat; bat $argv 2>/dev/null; or cat $argv; end

function bat_diff; bat --diff "$argv[1]" "$argv[2]" 2>/dev/null; or diff -u "$argv[1]" "$argv[2]"; end

function bat_lang; bat -l "$argv[1]" "$argv[2]" 2>/dev/null; or cat "$argv[2]"; end

function bat_theme_list; bat --list-themes 2>/dev/null; or echo "bat not installed"; end

function bin_to_dec; echo "(math "2#$argv[1]")" 2>/dev/null; end

function black_format; python3 -m black $argv 2>/dev/null; end

function bottom_monitor; btm 2>/dev/null; or echo "btm needed"; end

function brew_clean_all; brew cleanup --prune=all 2>/dev/null; end

function brew_find_leaves; brew leaves 2>/dev/null; end

function brew_list_deps; brew deps --tree $argv 2>/dev/null; end

function brew_outdated_formula; brew outdated 2>/dev/null; end

function brew_services_list; brew services list 2>/dev/null; end

function brew_services_start; brew services start "$argv[1]" 2>/dev/null; end

function brew_services_stop; brew services stop "$argv[1]" 2>/dev/null; end

function brew_update_all; brew update; and brew upgrade; and brew cleanup 2>/dev/null; end

function btop_monitor; btop 2>/dev/null; or htop; end

function byte_convert; python3 -c "size=$argv[1]; units=['B','KB','MB','GB','TB']; i=0; while size>1024 and i<4: size/=1024; i+=1; print(f'{size:.2f} {units[i]}')" 2>/dev/null; end

function bzip2_compress; bzip2 "$argv[1]"; end

function bzip2_decompress; bunzip2 "$argv[1]"; end

function bzip2_level; bzip2 -"(if set -q argv[2]; echo $argv[2]; else; echo 9; end)" "$argv[1]"; end

function calc_float; echo $argv | bc -l; end

function calc_int; printf "%.0f\n" (echo $argv | bc -l 2>/dev/null) 2>/dev/null; end

function calc_sci; echo $argv | bc -l; end

function cargo_add_build_dep; cargo add --build "$argv[1]"; end

function cargo_add_dep; cargo add "$argv[1]"; end

function cargo_add_dev_dep; cargo add --dev "$argv[1]"; end

function cargo_audit_check; cargo audit 2>/dev/null; end

function cargo_bench; cargo bench; end

function cargo_bench_all; cargo bench --all; end

function cargo_bloat_crate; cargo bloat --crates 2>/dev/null; end

function cargo_build_debug; cargo build; end

function cargo_build_release; cargo build --release; end

function cargo_build_release_clean; cargo build --release; and cargo clean; end

function cargo_check_all; cargo check --all; end

function cargo_check_warnings; cargo check -- -W warnings; end

function cargo_clean_all; cargo clean; end

function cargo_clippy_all; cargo clippy --all-targets -- -D warnings 2>/dev/null; end

function cargo_doc_open; cargo doc --open; end

function cargo_expand_macro; cargo expand $argv; end

function cargo_fix_all; cargo fix --all-targets --all-features; end

function cargo_fmt_check; cargo fmt --check; end

function cargo_fmt_rust; cargo fmt; end

function cargo_init_project; cargo init; end

function cargo_licenses; cargo license 2>/dev/null; or echo "cargo-license not installed"; end

function cargo_lint_clippy; cargo clippy; end

function cargo_metadata_deps; cargo metadata --format-version 1 | python3 -m json.tool; end

function cargo_new_project; cargo new "$argv[1]"; end

function cargo_outdated_all; cargo outdated 2>/dev/null; end

function cargo_owner_add; cargo owner --add "$argv[1]" "$argv[2]"; end

function cargo_owner_list; cargo owner --list "$argv[1]"; end

function cargo_owner_remove; cargo owner --remove "$argv[1]" "$argv[2]"; end

function cargo_publish_crate; cargo publish; end

function cargo_publish_dryrun; cargo publish --dry-run; end

function cargo_rm_dep; cargo rm "$argv[1]"; end

function cargo_run_bin; cargo run --bin "$argv[1]"; end

function cargo_run_example; cargo run --example "$argv[1]"; end

function cargo_test_all; cargo test --all; end

function cargo_test_doc; cargo test --doc; end

function cargo_test_ignored; cargo test -- --ignored; end

function cargo_test_name; cargo test "$argv[1]"; end

function cargo_test_nocapture; cargo test -- --nocapture; end

function cargo_tree_deps; cargo tree $argv; end

function cargo_unyank_version; cargo yank --vers "$argv[1]" "$argv[2]" --undo; end

function cargo_update_all; cargo install-update -a 2>/dev/null; or cargo update; end

function cargo_upgrade_all; cargo upgrade; end

function cargo_upgrade_dep; cargo upgrade "$argv[1]"; end

function cargo_vendor_deps; cargo vendor; end

function cargo_workspace_list; cargo metadata --format-version 1 | python3 -c "import sys,json; ws=json.load(sys.stdin)['workspace_members']; print('\n'.join(ws))" 2>/dev/null; end

function cargo_workspace_member; cargo new "$argv[1]" --lib; end

function cargo_yank_version; cargo yank --vers "$argv[1]" "$argv[2]"; end

function check_breach; curl -fsSL "https://haveibeenpwned.com/account/$argv[1]" 2>/dev/null; or echo "check online: haveibeenpwned.com"; end

function check_port_listen; ss -tlnp 2>/dev/null | grep ":$argv[1] "; or netstat -tlnp 2>/dev/null | grep ":$argv[1] "; end

function check_port_open

end

function check_port_pid; lsof -i :"$argv[1]" 2>/dev/null; or ss -tlnp 2>/dev/null | grep ":$argv[1] " | awk '{print $NF}'; end

function checksum_md5; md5sum "$argv[1]" 2>/dev/null; or md5 "$argv[1]"; end

function checksum_sha256; sha256sum "$argv[1]" 2>/dev/null; or shasum -a 256 "$argv[1]"; end

function clipclear

end

function compress_7z; 7z a "$argv[1].7z" "$argv[1]"; end

function compress_bz2; bzip2 "$argv[1]"; end

function compress_gz; gzip "$argv[1]"; end

function compress_tar_bz2; tar -cjf "$argv[1].tar.bz2" "$argv[1]"; end

function compress_tar_gz; tar -czf "$argv[1].tar.gz" "$argv[1]"; end

function compress_tar_xz; tar -cJf "$argv[1].tar.xz" "$argv[1]"; end

function compress_xz; xz "$argv[1]"; end

function compress_zip; zip -r "$1.zip" "$argv[1]"; end

function conda_env_create; conda create -n "$argv[1]" python="$argv[2]"; end

function conda_env_list; conda env list; end

function conda_env_remove; conda env remove -n "$argv[1]"; end

function conda_install_pkg; conda install "$argv[1]"; end

function conda_update_all; conda update --all; end

function confirm

end

function confirm_action

end

function copy_and_cd; cp -r "$argv[1]" "$argv[2]"; and cd "$argv[2]"; end

function copy_with_progress; rsync -ah --progress "$argv[1]" "$argv[2]"; end

function count_chars; wc -m $argv; end

function count_dirs; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d 2>/dev/null | wc -l; end

function count_files; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f 2>/dev/null | wc -l; end

function count_lines; wc -l $argv; end

function count_lines_total; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -exec cat {} + 2>/dev/null | wc -l; end

function count_words; wc -w $argv; end

function cpu_temp

end

function csv_avg; awk -F, "{sum+=\$$1; count++} END {print sum/count}" "$argv[2]"; end

function csv_cols; head -1 "$argv[1]" | tr ',' '\n' | nl; end

function csv_head; head -n "(if set -q argv[2]; echo $argv[2]; else; echo 10; end)" "$argv[1]" | column -t -s,; end

function csv_max; awk -F, "NR==1||\$$1>max{max=\$$1} END {print max}" "$argv[2]"; end

function csv_min; awk -F, "NR==1||\$$1<min{min=\$$1} END {print min}" "$argv[2]"; end

function csv_sum; awk -F, "{sum+=\$$1} END {print sum}" "$argv[2]"; end

function csv_tail; tail -n "(if set -q argv[2]; echo $argv[2]; else; echo 10; end)" "$argv[1]" | column -t -s,; end

function csv_view; column -t -s, $argv | less -S; end

function ctop_monitor; ctop 2>/dev/null; or echo "ctop needed"; end

function curl_auth_basic; curl -sS -u "$argv[1]:$argv[2]" "$argv[3]"; end

function curl_auth_bearer; curl -sS -H "Authorization: Bearer $argv[1]" "$argv[2]"; end

function curl_cert_check; curl --cacert "$argv[1]" -sS "$argv[2]"; end

function curl_cert_client; curl --cert "$argv[1]" --key "$argv[2]" -sS "$argv[3]"; end

function curl_cookie_jar; curl -c "$argv[1]" -b "$argv[2]" -sS "$argv[3]"; end

function curl_dns_server; curl --dns-servers "$argv[1]" -sS "$argv[2]"; end

function curl_download_resume; curl -C - -O "$argv[1]"; end

function curl_follow_redirect; curl -L -sS "$argv[1]"; end

function curl_form_post; curl -sS -F "$argv[1]" "$argv[2]"; end

function curl_http2_push; curl --http2-prior-knowledge -sS "$argv[1]"; end

function curl_http2_use; curl --http2 -sS "$argv[1]"; end

function curl_if_modified; curl -z "$argv[1]" -O "$argv[2]"; end

function curl_insecure_ssl; curl -k -sS "$argv[1]"; end

function curl_interface_bind; curl --interface "$argv[1]" -sS "$argv[2]"; end

function curl_json_patch; curl -sS -H "Content-Type: application/json" -X PATCH -d "$argv[1]" "$argv[2]"; end

function curl_json_post; curl -sS -H "Content-Type: application/json" -X POST -d "$argv[1]" "$argv[2]"; end

function curl_json_put; curl -sS -H "Content-Type: application/json" -X PUT -d "$argv[1]" "$argv[2]"; end

function curl_limit_rate; curl --limit-rate "$argv[1]" -O "$argv[2]"; end

function curl_parallel_fetch

end

function curl_proxy_use; curl -sS -x "$argv[1]" "$argv[2]"; end

function curl_range_request; curl -r "$argv[1]" -O "$argv[2]"; end

function curl_retry_conn; curl --retry "(if set -q argv[2]; echo $argv[2]; else; echo 3; end)" -sS "$argv[1]"; end

function curl_silent_check; curl -sS -o /dev/null -w "%{http_code}" "$argv[1]"; end

function curl_speed_limit; curl --speed-limit "$argv[1]" --speed-time "(if set -q argv[2]; echo $argv[2]; else; echo 30; end)" -O "$argv[3]"; end

function curl_timeout_conn; curl --connect-timeout "$argv[1]" -sS "$argv[2]"; end

function curl_timeout_max; curl --max-time "$argv[1]" -sS "$argv[2]"; end

function curl_upload_file; curl -sS -F "file=@$argv[1]" "$argv[2]"; end

function curl_verbose_dump; curl -v "$argv[1]" 2>&1; end

function curl_write_output; curl -w "\n%{http_code} %{time_total}s\n" -sS "$argv[1]"; end

function date_format; date "+(if set -q argv[1]; echo $argv[1]; else; echo %F %T; end)"; end

function date_iso_8601; date -u +%Y-%m-%dT%H:%M:%SZ; end

function date_unix_ts; date +%s; end

function dec_to_bin; python3 -c "print(bin($argv[1])[2:])" 2>/dev/null; end

function dec_to_hex; printf "%x\n" "$argv[1]" 2>/dev/null; end

function decode_base64; printf "%s" "$argv[1]" | base64 -d 2>/dev/null; or printf "%s" "$argv[1]" | base64 -D; end

function decompress_7z; 7z x "$argv[1]"; end

function decompress_bz2; bunzip2 "$argv[1]"; end

function decompress_gz; gunzip "$argv[1]"; end

function decompress_rar; unrar x "$argv[1]"; end

function decompress_tar_bz2; tar -xjf "$argv[1]"; end

function decompress_tar_gz; tar -xzf "$argv[1]"; end

function decompress_tar_xz; tar -xJf "$argv[1]"; end

function decompress_xz; unxz "$argv[1]"; end

function decompress_zip; unzip "$argv[1]"; end

function dev_build_esbuild; npx esbuild "(if set -q argv[1]; echo $argv[1]; else; echo src/index.js; end)" --outfile="(if set -q argv[2]; echo $argv[2]; else; echo dist/bundle.js; end)" --bundle --minify 2>/dev/null; or echo "esbuild needed"; end

function dev_build_parcel; npx parcel build "(if set -q argv[1]; echo $argv[1]; else; echo src/index.html; end)" 2>/dev/null; or echo "parcel needed"; end

function dev_build_vite; npx vite build 2>/dev/null; or echo "vite needed"; end

function dev_build_webpack; npx webpack --mode production 2>/dev/null; or echo "webpack needed"; end

function dev_format_prettier; npx prettier --write "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or echo "prettier needed"; end

function dev_lint_eslint; npx eslint "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or echo "eslint needed"; end

function dev_lint_stylelint; npx stylelint "(if set -q argv[1]; echo $argv[1]; else; echo **/*.css; end)" 2>/dev/null; or echo "stylelint needed"; end

function dev_server_browser; python3 -m http.server "(if set -q argv[1]; echo $argv[1]; else; echo 8000; end)"; and xdg-open "http://localhost:(if set -q argv[1]; echo $argv[1]; else; echo 8000; end)" 2>/dev/null; or open "http://localhost:(if set -q argv[1]; echo $argv[1]; else; echo 8000; end)" 2>/dev/null; end

function dev_server_browsersync; npx browser-sync start --server --files "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or echo "browsersync needed"; end

function dev_server_cloudflared; cloudflared tunnel --url "$argv[1]" 2>/dev/null; or echo "cloudflared needed"; end

function dev_server_ngrok; ngrok http "(if set -q argv[1]; echo $argv[1]; else; echo 8080; end)" 2>/dev/null; or echo "ngrok needed"; end

function dev_server_node_http; npx http-server -p "(if set -q argv[1]; echo $argv[1]; else; echo 8080; end)"; end

function dev_server_node_live; npx live-server --port="(if set -q argv[1]; echo $argv[1]; else; echo 8080; end)"; end

function dev_server_php; php -S "localhost:(if set -q argv[1]; echo $argv[1]; else; echo 8000; end)"; end

function dev_server_python; python3 -m http.server "(if set -q argv[1]; echo $argv[1]; else; echo 8000; end)"; end

function dev_server_serve; serve -l "(if set -q argv[1]; echo $argv[1]; else; echo 3000; end)" 2>/dev/null; or npx serve -l "(if set -q argv[1]; echo $argv[1]; else; echo 3000; end)"; end

function dev_watch_esbuild; npx esbuild "(if set -q argv[1]; echo $argv[1]; else; echo src/index.js; end)" --outfile="(if set -q argv[2]; echo $argv[2]; else; echo dist/bundle.js; end)" --watch 2>/dev/null; or echo "esbuild needed"; end

function dev_watch_parcel; npx parcel watch "(if set -q argv[1]; echo $argv[1]; else; echo src/index.html; end)" 2>/dev/null; or echo "parcel needed"; end

function dev_watch_sass; sass --watch "(if set -q argv[1]; echo $argv[1]; else; echo src/style.scss; end):(if set -q argv[2]; echo $argv[2]; else; echo dist/style.css; end)" 2>/dev/null; or echo "sass needed"; end

function dev_watch_vite; npx vite 2>/dev/null; or echo "vite needed"; end

function dev_watch_webpack; npx webpack --watch 2>/dev/null; or echo "webpack needed"; end

function diff_summary; diff -q $argv; end

function disk_blkid; sudo blkid "$argv[1]" 2>/dev/null; end

function disk_free_all; df -h; end

function disk_free_inodes; df -ih "(if set -q argv[1]; echo $argv[1]; else; echo /; end)"; end

function disk_free_summary; df -h "(if set -q argv[1]; echo $argv[1]; else; echo /; end)"; end

function disk_free_type; df -hT "(if set -q argv[1]; echo $argv[1]; else; echo /; end)"; end

function disk_fs_check; sudo fsck -n "$argv[1]" 2>/dev/null; or echo "fsck needed"; end

function disk_fs_repair; sudo fsck -y "$argv[1]" 2>/dev/null; or echo "fsck needed"; end

function disk_iostat; iostat -x 1 "(if set -q argv[1]; echo $argv[1]; else; echo 5; end)" 2>/dev/null; or echo "iostat needed"; end

function disk_iotop; sudo iotop -o 2>/dev/null; or echo "iotop needed"; end

function disk_lsblk_all; lsblk -a; end

function disk_lsblk_size; lsblk -o NAME,SIZE,TYPE,MOUNTPOINT; end

function disk_lsblk_tree; lsblk -f $argv; end

function disk_mount_by_device; mount | grep "$argv[1]"; end

function disk_mount_list; mount | column -t; end

function disk_smart_health; sudo smartctl -H "$argv[1]" 2>/dev/null; or echo "smartctl needed"; end

function disk_smart_info; sudo smartctl -a "$argv[1]" 2>/dev/null; or echo "smartctl needed"; end

function disk_usage_by_ext; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -name "*$argv[2]" -exec du -ch {} + 2>/dev/null | tail -1; end

function disk_usage_depth; du -h --max-depth="(if set -q argv[1]; echo $argv[1]; else; echo 1; end)" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function disk_usage_human; du -sh $argv; end

function disk_usage_sort; du -sh "(if set -q argv[1]; echo $argv[1]; else; echo .; end)"/* | sort -rh; end

function disk_usage_summary; df -h / 2>/dev/null | awk 'NR==2 {print "Disk: " $argv[3] " / " $argv[2] " (" $argv[5] ")";}'; end

function disk_usage_total; du -shc $argv; end

function distribution

end

function distro_version

end

function dnf_history_rollback; sudo dnf history rollback "$argv[1]" 2>/dev/null; end

function dnf_list_groups; dnf group list 2>/dev/null; end

function dns_any; dig ANY +short "$argv[1]" 2>/dev/null; or host -a "$argv[1]" 2>/dev/null; end

function dns_lookup; dig +short "$argv[1]" 2>/dev/null; or host "$argv[1]" 2>/dev/null; or nslookup "$argv[1]" 2>/dev/null; end

function dns_mx_lookup; dig MX +short "$argv[1]" 2>/dev/null; or nslookup -type=MX "$argv[1]" 2>/dev/null; end

function dns_ns_lookup; dig NS +short "$argv[1]" 2>/dev/null; or nslookup -type=NS "$argv[1]" 2>/dev/null; end

function dns_reverse; dig +short -x "$argv[1]" 2>/dev/null; or host "$argv[1]" 2>/dev/null; end

function dns_txt_lookup; dig TXT +short "$argv[1]" 2>/dev/null; or nslookup -type=TXT "$argv[1]" 2>/dev/null; end

function docker_build_nocache; docker build --no-cache -t "$argv[1]" .; end

function docker_build_prune_all; docker buildx prune -af; end

function docker_build_prune_cache; docker builder prune -f; end

function docker_build_tag; docker build -t "$argv[1]" .; end

function docker_clean_all; docker system prune -af --volumes; and docker rmi (docker images -q) 2>/dev/null; or true; end

function docker_compose_build; docker compose build; end

function docker_compose_build_all; docker compose build 2>/dev/null; end

function docker_compose_build_nocache; docker compose build --no-cache; end

function docker_compose_build_service; docker compose build "$argv[1]"; end

function docker_compose_config; docker compose config 2>/dev/null; end

function docker_compose_create_all; docker compose create 2>/dev/null; end

function docker_compose_down_remove_orphans; docker compose down --remove-orphans; end

function docker_compose_down_rmi; docker compose down --rmi all; end

function docker_compose_down_timeout; docker compose down -t "$argv[1]"; end

function docker_compose_down_volumes; docker compose down -v; end

function docker_compose_events; docker compose events; end

function docker_compose_exec; docker compose exec $argv; end

function docker_compose_exec_no_tty; docker compose exec -T "$argv[1]" "$argv[2]"; end

function docker_compose_exec_service; docker compose exec "$argv[1]" "$argv[2]"; end

function docker_compose_images; docker compose images 2>/dev/null; end

function docker_compose_kill; docker compose kill; end

function docker_compose_kill_all; docker compose kill 2>/dev/null; end

function docker_compose_kill_service; docker compose kill "$argv[1]"; end

function docker_compose_logs; docker compose logs -f; end

function docker_compose_logs_tail; docker compose logs --tail="$argv[1]" -f; end

function docker_compose_pause; docker compose pause; end

function docker_compose_pause_all; docker compose pause 2>/dev/null; end

function docker_compose_pause_service; docker compose pause "$argv[1]"; end

function docker_compose_ps; docker compose ps; end

function docker_compose_ps_all; docker compose ps -a 2>/dev/null; end

function docker_compose_ps_format; docker compose ps --format "table {{.Name}}\t{{.State}}\t{{.Ports}}"; end

function docker_compose_ps_services; docker compose ps --services; end

function docker_compose_pull; docker compose pull; end

function docker_compose_pull_all; docker compose pull 2>/dev/null; end

function docker_compose_pull_service; docker compose pull "$argv[1]"; end

function docker_compose_push_service; docker compose push "$argv[1]"; end

function docker_compose_restart; docker compose restart; end

function docker_compose_restart_service; docker compose restart "$argv[1]"; end

function docker_compose_run; docker compose run --rm $argv; end

function docker_compose_run_no_tty; docker compose run --rm -T "$argv[1]" "$argv[2]"; end

function docker_compose_run_service; docker compose run --rm "$argv[1]" "$argv[2]"; end

function docker_compose_scale; docker compose scale $argv; end

function docker_compose_start_all; docker compose start 2>/dev/null; end

function docker_compose_start_service; docker compose start "$argv[1]"; end

function docker_compose_stop; docker compose stop; end

function docker_compose_stop_service; docker compose stop "$argv[1]"; end

function docker_compose_top_all; docker compose top 2>/dev/null; end

function docker_compose_unpause; docker compose unpause; end

function docker_compose_unpause_all; docker compose unpause 2>/dev/null; end

function docker_compose_unpause_service; docker compose unpause "$argv[1]"; end

function docker_compose_up_build; docker compose up -d --build; end

function docker_compose_up_recreate; docker compose up --force-recreate -d; end

function docker_compose_up_scale; docker compose up -d --scale "$argv[1]=$argv[2]"; end

function docker_compose_up_service; docker compose up -d "$argv[1]"; end

function docker_compose_version; docker compose version; end

function docker_config_create; docker config create "$argv[1]" "$argv[2]"; end

function docker_config_ls; docker config ls; end

function docker_container_commit; docker commit "$argv[1]" "$argv[2]"; end

function docker_container_cp_from; docker cp "$argv[1]:$argv[2]" "$argv[3]"; end

function docker_container_cp_to; docker cp "$argv[1]" "$argv[2]:$argv[3]"; end

function docker_container_diff; docker diff "$argv[1]"; end

function docker_container_inspect; docker inspect "$argv[1]"; end

function docker_container_ip; docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$argv[1]"; end

function docker_container_pause; docker pause "$argv[1]"; end

function docker_container_port; docker port "$argv[1]"; end

function docker_container_rename; docker rename "$argv[1]" "$argv[2]"; end

function docker_container_top; docker top "$argv[1]"; end

function docker_container_unpause; docker unpause "$argv[1]"; end

function docker_container_wait; docker wait "$argv[1]"; end

function docker_exec_bash; docker exec -it "$argv[1]" /bin/bash; end

function docker_exec_root; docker exec -it -u 0 "$argv[1]" /bin/sh; end

function docker_exec_sh; docker exec -it "$argv[1]" /bin/sh; end

function docker_exec_user; docker exec -it -u "$argv[2]" "$argv[1]" /bin/sh; end

function docker_export_container; docker export "$argv[1]" -o "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1].tar; end)"; end

function docker_image_build_from; docker build -f "$argv[1]" -t "$argv[2]" .; end

function docker_image_by_repo; docker images "$argv[1]"; end

function docker_image_dangling; docker images -f dangling=true; end

function docker_image_history; docker history "$argv[1]"; end

function docker_image_inspect; docker inspect "$argv[1]"; end

function docker_image_squash; docker build --squash -t "$argv[1]" .; end

function docker_image_tag_latest; docker tag "$argv[1]:latest" "$argv[1]:$(date +%Y%m%d)"; end

function docker_import_image; docker import "$argv[1]" "$argv[2]"; end

function docker_inspect_ip; docker inspect -f "{{.NetworkSettings.IPAddress}}" "$argv[1]"; end

function docker_load_gz; gunzip -c "$argv[1]" | docker load; end

function docker_load_image; docker load -i "$argv[1]"; end

function docker_login_registry; docker login $argv; end

function docker_logs_since; docker logs --since "(if set -q argv[2]; echo $argv[2]; else; echo 5m; end)" "$argv[1]"; end

function docker_logs_tail; docker logs --tail "(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -f "$argv[1]"; end

function docker_logs_tail_n; docker logs --tail="(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" "$argv[1]"; end

function docker_logs_timestamps; docker logs -t "$argv[1]"; end

function docker_logs_until; docker logs --until="$argv[2]" "$argv[1]"; end

function docker_network_connect; docker network connect "$argv[1]" "$argv[2]"; end

function docker_network_create; docker network create "$argv[1]"; end

function docker_network_create_bridge; docker network create -d bridge "$argv[1]"; end

function docker_network_create_overlay; docker network create -d overlay "$argv[1]"; end

function docker_network_disconnect; docker network disconnect "$argv[1]" "$argv[2]"; end

function docker_network_inspect; docker network inspect "$argv[1]"; end

function docker_network_ls; docker network ls; end

function docker_network_prune; docker network prune -f; end

function docker_plugin_disable; docker plugin disable "$argv[1]"; end

function docker_plugin_install; docker plugin install "$argv[1]"; end

function docker_plugin_ls; docker plugin ls; end

function docker_plugin_remove; docker plugin rm "$argv[1]"; end

function docker_prune_all; docker system prune -af --volumes; end

function docker_prune_build_cache; docker builder prune -f; end

function docker_prune_containers; docker container prune -f; end

function docker_prune_images; docker image prune -af; end

function docker_prune_networks; docker network prune -f; end

function docker_prune_volumes; docker volume prune -f; end

function docker_ps_all; docker ps -a; end

function docker_ps_by_image; docker ps -a --filter ancestor="$argv[1]"; end

function docker_ps_format; docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"; end

function docker_ps_network; docker ps -a --filter network="$argv[1]"; end

function docker_ps_running; docker ps; end

function docker_ps_stopped; docker ps -a --filter status=exited; end

function docker_ps_volume; docker ps -a --filter volume="$argv[1]"; end

function docker_pull_latest; docker pull "$argv[1]"; end

function docker_push_tag; docker push "$argv[1]"; end

function docker_rm_all; docker rm (docker ps -aq) 2>/dev/null; or true; end

function docker_rm_exited; docker rm (docker ps -a -q -f status=exited) 2>/dev/null; or true; end

function docker_rm_stopped; docker container prune -f; end

function docker_rmi_all; docker rmi (docker images -q) 2>/dev/null; or true; end

function docker_rmi_dangling; docker rmi (docker images -f dangling=true -q) 2>/dev/null; or true; end

function docker_run_bash; docker run -it --rm "$argv[1]" /bin/bash; end

function docker_run_detach; docker run -d $argv; end

function docker_run_interactive; docker run -it --rm $argv; end

function docker_run_name; docker run --name "$argv[1]" $argv[2..-1]; end

function docker_run_port; docker run -it --rm -p "$argv[1]" "$argv[2]"; end

function docker_run_shell; docker run -it --rm "$argv[1]" /bin/sh; end

function docker_run_volume; docker run -it --rm -v "$argv[1]" "$argv[2]"; end

function docker_save_gz; docker save "$argv[1]" | gzip > "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1]; end).tar.gz"; end

function docker_save_image; docker save "$argv[1]" -o "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1].tar; end)"; end

function docker_secret_create; printf "%s" "$argv[2]" | docker secret create "$argv[1]" -; end

function docker_secret_ls; docker secret ls; end

function docker_stats_all; docker stats --no-stream; end

function docker_stats_live; docker stats; end

function docker_stats_no_stream; docker stats --no-stream; end

function docker_stop_all; docker stop (docker ps -q) 2>/dev/null; or true; end

function docker_stop_latest; docker ps -ql | xargs -r docker stop; end

function docker_swarm_init; docker swarm init --advertise-addr "$argv[1]"; end

function docker_swarm_join; docker swarm join-token "$argv[1]"; end

function docker_swarm_leave; docker swarm leave --force; end

function docker_swarm_node_ls; docker node ls; end

function docker_swarm_service_create; docker service create --name "$argv[1]" "$argv[2]"; end

function docker_swarm_service_ls; docker service ls; end

function docker_swarm_stack_deploy; docker stack deploy -c "$argv[1]" "$argv[2]"; end

function docker_swarm_stack_ls; docker stack ls; end

function docker_swarm_stack_ps; docker stack ps "$argv[1]"; end

function docker_swarm_stack_rm; docker stack rm "$argv[1]"; end

function docker_swarm_stack_services; docker stack services "$argv[1]"; end

function docker_system_df; docker system df; end

function docker_system_disk_usage; docker system df -v; end

function docker_system_events; docker system events; end

function docker_system_events_since; docker system events --since "$argv[1]"; end

function docker_system_events_until; docker system events --until "$argv[1]"; end

function docker_system_info; docker info; end

function docker_system_info_format; docker info --format "$argv[1]"; end

function docker_system_prune_all; docker system prune -af --volumes 2>/dev/null; end

function docker_tag_image; docker tag "$argv[1]" "$argv[2]"; end

function docker_top_container; docker top "$argv[1]"; end

function docker_volume_backup; docker run --rm -v "$argv[1]":/data -v "$(pwd)":/backup alpine tar czf /backup/"$argv[1]-$(date +%Y%m%d).tar.gz" -C /data .; end

function docker_volume_create; docker volume create "$argv[1]"; end

function docker_volume_create_named; docker volume create "$argv[1]"; end

function docker_volume_inspect; docker volume inspect "$argv[1]"; end

function docker_volume_ls; docker volume ls; end

function docker_volume_prune; docker volume prune -f; end

function docker_volume_restore; docker run --rm -v "$argv[1]":/data -v "$(pwd)":/backup alpine tar xzf /backup/"$argv[2]" -C /data; end

function dockerignore_create; echo -e ".git\n*.md\nDockerfile\ndocker-compose.yml\n.gitignore" > .dockerignore; end

function dog_dns_query; dog "$argv[1]" 2>/dev/null; or dig "$argv[1]"; end

function doggo_dns_query; doggo "$argv[1]" 2>/dev/null; or dig "$argv[1]"; end

function dot_bench; bash "$DOTFILES_DIR/bin/benchmark_shell.sh" 2>/dev/null; or echo "benchmark not found"; end

function dot_docs; xdg-open "$DOTFILES_DIR/docs/index.html" 2>/dev/null; or open "$DOTFILES_DIR/docs/index.html" 2>/dev/null; or echo "docs at $DOTFILES_DIR/docs/index.html"; end

function dot_fix; sh "$DOTFILES_DIR/install/install.sh" 2>/dev/null; or echo "installer not found"; end

function dot_health; bash "$DOTFILES_DIR/bin/health_check.sh" 2>/dev/null; or echo "health check not found"; end

function dot_status; git -C "$DOTFILES_DIR" status --short --branch 2>/dev/null; or true; end

function dot_sync; git -C "$DOTFILES_DIR" fetch --all --prune 2>/dev/null; and git -C "$DOTFILES_DIR" pull --rebase --autostash 2>/dev/null; end

function dot_update; bash "$DOTFILES_DIR/bin/dotupdate.sh" 2>/dev/null; or echo "dotupdate not found"; end

function dot_ver; echo "$DOTFILES_VERSION"; end

function dotfiles_cd; cd "$DOTFILES_DIR" 2>/dev/null; or cd; end

function download_extract; set -l _f (basename $argv[1]); download_file $argv[1]; and extract $_f; end

function download_file

end

function dpkg_configure_all; sudo dpkg --configure -a; end

function dpkg_info_pkg; dpkg -p $argv; end

function dpkg_list_files; dpkg -L $argv; end

function dpkg_list_pkgs; dpkg -l; end

function dpkg_reconfigure_pkg; sudo dpkg-reconfigure $argv; end

function dpkg_verify_pkg; dpkg --verify $argv; end

function dry_run; printf "DRY-RUN: %s\n" $argv; end

function duf_disk_usage; duf 2>/dev/null; or df -h; end

function dust_disk_usage; dust 2>/dev/null; or du -sh .; end

function editorconfig_create; echo -e "root = true\n\n[*]\nend_of_line = lf\ninsert_final_newline = true\ncharset = utf-8\nindent_style = space\nindent_size = 2" > .editorconfig; end

function encode_base64; printf "%s" "$argv[1]" | base64; end

function env_secrets

end

function eslint_init; echo -e "{\n  \"env\": {\"node\": true,\"es2021\": true},\n  \"extends\": \"eslint:recommended\",\n  \"parserOptions\": {\"ecmaVersion\": \"latest\"}\n}" > .eslintrc.json; end

function eval_bash_nounset; bash -u "$argv[1]"; end

function eval_bash_xtrace; bash -x "$argv[1]"; end

function eval_command_time; time $argv; end

function eval_condition

end

function eval_math; echo $argv | bc -l; end

function eval_memory_usage; /usr/bin/time -v $argv 2>&1 | grep -E 'Maximum resident|Elapsed'; end

function eval_node_syntax; node --check "$argv[1]"; end

function eval_python_syntax; python3 -m py_compile "$argv[1]"; end

function eval_shell_check; shellcheck "$argv[1]"; end

function eval_shfmt; shfmt -i 2 "$argv[1]"; end

function eval_zsh_nounset; zsh -u "$argv[1]"; end

function execute_as_root; sudo $argv; end

function execute_as_user; sudo -u "$argv[1]" $argv; end

function execute_background; nohup $argv >/dev/null 2>&1 &; end

function execute_bash_script; bash "$argv[1]" $argv; end

function execute_chroot_cmd; sudo chroot "$argv[1]" "$argv[2]"; end

function execute_command_each

end

function execute_deno_script; deno run "$argv[1]" $argv; end

function execute_if_available; type -q "$argv[1]"; and $argv; end

function execute_in_dir; cd $argv[1]; and $argv[2..-1]; cd -; end

function execute_node_script; node "$argv[1]" $argv; end

function execute_parallel

end

function execute_python_script; python3 "$argv[1]" $argv; end

function execute_retry

end

function execute_shell_script; sh "$argv[1]" $argv; end

function execute_timeout; timeout "(if set -q argv[1]; echo $argv[1]; else; echo 10; end)" $argv[2..-1]; end

function execute_with_log; $argv 2>&1 | tee "(if set -q argv[2]; echo $argv[2]; else; echo output.log; end)"; end

function exif_remove; exiftool -all= "$argv[1]" 2>/dev/null; end

function exif_show; exiftool "$argv[1]" 2>/dev/null; end

function eza_all; eza -laa --icons=auto $argv 2>/dev/null; or ls -la $argv; end

function eza_list; eza -la --icons=auto $argv 2>/dev/null; or ls -la $argv; end

function eza_tree; eza --tree --level="(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" 2>/dev/null; or tree -L "(if set -q argv[1]; echo $argv[1]; else; echo 2; end)"; end

function fd_find; fd "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -name "$argv[1]"; end

function fd_find_exec; fd "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" --exec $argv[3..-1] 2>/dev/null; or find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -name "$argv[1]" -exec $argv[3..-1] {} \; ; end

function fd_find_type; fd --type "$argv[1]" "$argv[2]" "(if set -q argv[3]; echo $argv[3]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[3]; echo $argv[3]; else; echo .; end)" -type "$argv[1]" -name "$argv[2]"; end

function ffmpeg_compress; ffmpeg -i "$argv[1]" -vcodec libx265 -crf "(if set -q argv[2]; echo $argv[2]; else; echo 28; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-compressed.mp4"; end

function ffmpeg_concat; ffmpeg -f concat -safe 0 -i "$argv[1]" -c copy "(if set -q argv[2]; echo $argv[2]; else; echo output.mp4; end)"; end

function ffmpeg_convert; ffmpeg -i "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo output.mp4; end)"; end

function ffmpeg_crop; ffmpeg -i "$argv[1]" -filter:v "crop=(if set -q argv[2]; echo $argv[2]; else; echo 640; end):(if set -q argv[3]; echo $argv[3]; else; echo 480; end):(if set -q argv[4]; echo $argv[4]; else; echo 0; end):(if set -q argv[5]; echo $argv[5]; else; echo 0; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-cropped.mp4"; end

function ffmpeg_extract_audio; ffmpeg -i "$argv[1]" -q:a 0 -map a "(string replace -r '\.[^.]+\$' '' -- $argv[1]).mp3"; end

function ffmpeg_gif; ffmpeg -i "$argv[1]" -vf "fps=(if set -q argv[2]; echo $argv[2]; else; echo 10; end),scale=(if set -q argv[3]; echo $argv[3]; else; echo 320; end):-1" "(string replace -r '\.[^.]+\$' '' -- $argv[1]).gif"; end

function ffmpeg_merge_video; ffmpeg -i "$argv[1]" -i "$argv[2]" -c copy -map 0:v:0 -map 1:a:0 "(if set -q argv[3]; echo $argv[3]; else; echo output.mp4; end)"; end

function ffmpeg_metadata; ffprobe "$argv[1]" 2>/dev/null; end

function ffmpeg_png_sequence; ffmpeg -i "$argv[1]" -vf "fps=(if set -q argv[2]; echo $argv[2]; else; echo 1; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-%04d.png"; end

function ffmpeg_resize_video; ffmpeg -i "$argv[1]" -vf "scale=(if set -q argv[2]; echo $argv[2]; else; echo 1280; end):(if set -q argv[3]; echo $argv[3]; else; echo 720; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-resized.mp4"; end

function ffmpeg_screenshot; ffmpeg -i "$argv[1]" -ss "(if set -q argv[2]; echo $argv[2]; else; echo 00:00:01; end)" -vframes 1 "(if set -q argv[3]; echo $argv[3]; else; echo screenshot.png; end)"; end

function ffmpeg_speed; ffmpeg -i "$argv[1]" -filter:v "setpts=(if set -q argv[2]; echo $argv[2]; else; echo 0.5; end)*PTS" -filter:a "atempo=(if set -q argv[3]; echo $argv[3]; else; echo 2.0; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-sped.mp4"; end

function ffmpeg_stream; ffmpeg -i "$argv[1]" -c copy -f mp4 pipe:; end

function ffmpeg_volume; ffmpeg -i "$argv[1]" -filter:a "volume=(if set -q argv[2]; echo $argv[2]; else; echo 2.0; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-louder.mp3"; end

function file_append_line; echo "$argv[1]" >> "$argv[2]"; end

function file_chgrp_recursive; sudo chgrp -R "$argv[1]" "$argv[2]"; end

function file_chmod_dirs; find "$argv[1]" -type d -exec chmod "$argv[2]" {} \; 2>/dev/null; end

function file_chmod_recursive; find "$argv[1]" -type f -exec chmod "$argv[2]" {} \; 2>/dev/null; end

function file_chown_recursive; sudo chown -R "$argv[1]:$argv[2]" "$argv[3]"; end

function file_compare; diff -u "$argv[1]" "$argv[2]"; end

function file_compare_quiet; diff -q "$argv[1]" "$argv[2]"; and echo "same"; or echo "different"; end

function file_compare_side; diff -y "$argv[1]" "$argv[2]" | less; end

function file_compress_7z; 7z a "$argv[1].7z" "$argv[1]"; end

function file_compress_bzip2; bzip2 -k "$argv[1]"; end

function file_compress_gzip; gzip -k "$argv[1]"; end

function file_compress_tar; tar -czf "$argv[1].tar.gz" "$argv[1]"; end

function file_compress_xz; xz -k "$argv[1]"; end

function file_compress_zip; zip -r "$argv[1].zip" "$argv[1]"; end

function file_copy_backup; cp -b "$argv[1]" "$argv[2]"; end

function file_copy_preserve; cp -p "$argv[1]" "$argv[2]"; end

function file_copy_recursive; cp -r "$argv[1]" "$argv[2]"; end

function file_copy_verbose; cp -v "$argv[1]" "$argv[2]"; end

function file_decrypt

end

function file_decrypt_aes; openssl enc -d -aes-256-cbc -in $argv[1] -out (string replace -r '\.enc$' '' -- $argv[1]); end

function file_decrypt_gpg; gpg -d $argv[1] > (string replace -r '\.gpg$' '' -- $argv[1]); end

function file_dos_to_unix; dos2unix "$argv[1]" 2>/dev/null; or sed -i 's/\r$//' "$argv[1]"; end

function file_encrypt

end

function file_encrypt_aes; openssl enc -aes-256-cbc -salt -in "$argv[1]" -out "$1.enc"; end

function file_encrypt_gpg; gpg -c "$argv[1]"; end

function file_extension; echo "(string split -r -m1 '.' -- $argv[1])[-1]"; end

function file_extract_auto; extract "$argv[1]"; end

function file_head_bytes; head -c "$argv[1]" "$argv[2]"; end

function file_head_first; head -n "(if set -q argv[1]; echo $argv[1]; else; echo 10; end)" "$argv[2]"; end

function file_head_last; tail -n "(if set -q argv[1]; echo $argv[1]; else; echo 10; end)" "$argv[2]"; end

function file_insert_line; sed -i "$argv[1]i\\$argv[2]" "$argv[3]"; end

function file_join_lines; paste -sd "$argv[1]" "$argv[2]"; end

function file_merge_interactive; sdiff -o "(if set -q argv[3]; echo $argv[3]; else; echo merged; end)" "$argv[1]" "$argv[2]"; end

function file_middle_lines; sed -n "$1,$2p" "$argv[3]"; end

function file_move_backup; mv -b "$argv[1]" "$argv[2]"; end

function file_move_force; mv -f "$argv[1]" "$argv[2]"; end

function file_move_interactive; mv -i "$argv[1]" "$argv[2]"; end

function file_move_verbose; mv -v "$argv[1]" "$argv[2]"; end

function file_number_lines; nl "$argv[1]"; end

function file_patch_apply; patch -i "$argv[1]"; end

function file_patch_dry; patch --dry-run -i "$argv[1]"; end

function file_patch_reverse; patch -R -i "$argv[1]"; end

function file_prepend_line; sed -i "1i\\$argv[1]" "$argv[2]"; end

function file_random_line; shuf -n 1 "$argv[1]"; end

function file_remove_blank; sed -i '/^$/d' "$argv[1]"; end

function file_remove_duplicates; sort -u -o "$argv[1]" "$argv[1]"; end

function file_remove_force; rm -f $argv; end

function file_remove_interactive; rm -i $argv; end

function file_remove_recursive; rm -rf $argv; end

function file_replace_string; sed -i "s/$argv[1]/$argv[2]/g" "$argv[3]"; end

function file_reverse_lines; tac "$argv[1]"; end

function file_shuffle_lines; shuf "$argv[1]" -o "$argv[1]"; end

function file_size; ls -lh "$argv[1]" | awk '{print $argv[5]}'; end

function file_split_lines; split -l "(if set -q argv[1]; echo $argv[1]; else; echo 1000; end)" "$argv[2]" "(if set -q argv[3]; echo $argv[3]; else; echo split; end)"; end

function file_symlink_create; ln -s "$argv[1]" "$argv[2]"; end

function file_symlink_edit; ln -sf "$argv[1]" "$argv[2]"; end

function file_symlink_hard; ln "$argv[1]" "$argv[2]"; end

function file_tail_bytes; tail -c "$argv[1]" "$argv[2]"; end

function file_tail_follow; tail -f "$argv[1]"; end

function file_tail_follow_name; tail -F "$argv[1]"; end

function file_touch_create; touch "$argv[1]"; end

function file_trim_both; sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "$argv[1]"; end

function file_trim_leading; sed -i 's/^[[:space:]]*//' "$argv[1]"; end

function file_trim_trailing; sed -i 's/[[:space:]]*$//' "$argv[1]"; end

function file_unix_to_dos; unix2dos "$argv[1]" 2>/dev/null; or sed -i 's/$/\r/' "$argv[1]"; end

function file_watch_changes

end

function file_watch_clear

end

function find_broken_symlinks; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type l ! -exec test -e {} \; -print 2>/dev/null; end

function find_by_accessed; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -atime "$argv[1]" 2>/dev/null; end

function find_by_changed; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -ctime "$argv[1]" 2>/dev/null; end

function find_by_depth; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -maxdepth "$argv[1]" -name "$argv[3]" 2>/dev/null; end

function find_by_group; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -group "$argv[1]" 2>/dev/null; end

function find_by_inode; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -inum "$argv[1]" 2>/dev/null; end

function find_by_modified; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -mtime "$argv[1]" 2>/dev/null; end

function find_by_name; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -name "$argv[1]" -type f 2>/dev/null; end

function find_by_newer; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -newer "$argv[1]" 2>/dev/null; end

function find_by_perm; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -perm "$argv[1]" 2>/dev/null; end

function find_by_regex; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -regex "$argv[1]" -type f 2>/dev/null; end

function find_by_size; find "(if set -q argv[3]; echo $argv[3]; else; echo .; end)" -type f -size "$argv[1]" -size "$argv[2]" 2>/dev/null; end

function find_by_type; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -type "$argv[1]" 2>/dev/null; end

function find_by_user; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -user "$argv[1]" 2>/dev/null; end

function find_delete_by_name; find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -name "$argv[1]" -delete 2>/dev/null; end

function find_duplicates; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -exec md5sum {} + 2>/dev/null | sort | uniq -w32 -dD; end

function find_empty_dirs; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d -empty 2>/dev/null; end

function find_empty_files; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -empty 2>/dev/null; end

function find_exec_command; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -name "$argv[2]" -exec $argv[3..-1] {} \; 2>/dev/null; end

function find_hidden_files; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -name '.*' -type f 2>/dev/null; end

function find_large_files; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -size +"(if set -q argv[2]; echo $argv[2]; else; echo 100M; end)" 2>/dev/null; end

function find_largest; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -exec ls -s {} + 2>/dev/null | sort -rn | head "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)"; end

function find_largest_dirs; du -sh "(if set -q argv[1]; echo $argv[1]; else; echo .; end)"/*/ 2>/dev/null | sort -rh | head "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)"; end

function find_newest; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -print0 2>/dev/null | xargs -0 ls -lt | head "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)"; end

function find_oldest; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -print0 2>/dev/null | xargs -0 ls -ltr | head "(if set -q argv[2]; echo $argv[2]; else; echo 20; end)"; end

function find_recent_accessed; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -amin -"(if set -q argv[2]; echo $argv[2]; else; echo 60; end)" 2>/dev/null; end

function find_recent_changed; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -cmin -"(if set -q argv[2]; echo $argv[2]; else; echo 60; end)" 2>/dev/null; end

function find_sgid_binaries; find "(if set -q argv[1]; echo $argv[1]; else; echo /; end)" -type f -perm -2000 2>/dev/null; end

function find_suid_binaries; find "(if set -q argv[1]; echo $argv[1]; else; echo /; end)" -type f -perm -4000 2>/dev/null; end

function find_world_writable; find "(if set -q argv[1]; echo $argv[1]; else; echo /; end)" -type f -perm -o+w 2>/dev/null; end

function flake8_lint; python3 -m flake8 $argv 2>/dev/null; end

function flatpak_info_app; flatpak info "$argv[1]"; end

function flatpak_install_app; flatpak install "$argv[1]"; end

function flatpak_list_apps; flatpak list --app 2>/dev/null; end

function flatpak_list_runtime; flatpak list --runtime; end

function flatpak_remove_app; flatpak uninstall "$argv[1]"; end

function flatpak_run_app; flatpak run "$argv[1]"; end

function flatpak_search_app; flatpak search "$argv[1]"; end

function flatpak_update_all; flatpak update -y 2>/dev/null; end

function flatpak_update_apps; flatpak update; end

function fzf_browse; fzf --preview 'bat {}' --bind 'enter:become(nvim {})' 2>/dev/null; end

function fzf_cd; cd "$(find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d | fzf)" 2>/dev/null; end

function fzf_dir; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d | fzf 2>/dev/null; end

function fzf_file; fzf --preview 'bat {}' 2>/dev/null; end

function fzf_git_branch; git branch -a | fzf | tr -d ' *' | xargs -r git checkout; end

function fzf_git_diff; git status --short | fzf | awk '{print $argv[2]}' | xargs -r git diff; end

function fzf_git_log; git log --oneline --graph --all | fzf | awk '{print $argv[1]}' | xargs -r git show; end

function fzf_history; history | fzf; end

function fzf_kill; ps aux | fzf | awk '{print $argv[2]}' | xargs -r kill; end

function fzf_man; man -k . | fzf | awk '{print $argv[1]}' | xargs -r man; end

function fzf_process; ps aux | fzf | awk '{print $argv[2]}' | xargs -r kill; end

function fzf_rg; rg --line-number --null "$argv[1]" | fzf --delimiter : --preview 'bat --color=always {1} --highlight-line {2}' --preview-window +{2}-5; end

function fzf_search; fzf -q "$argv[1]" --preview 'bat {}' 2>/dev/null; end

function fzf_ssh; grep -i "host " ~/.ssh/config 2>/dev/null | awk '{print $argv[2]}' | fzf | xargs -r ssh; end

function gcloud_auth_application; gcloud auth application-default login; end

function gcloud_auth_list; gcloud auth list; end

function gcloud_auth_login; gcloud auth login; end

function gcloud_build_list; gcloud builds list; end

function gcloud_build_submit; gcloud builds submit --tag "$argv[1]"; end

function gcloud_config_list; gcloud config list; end

function gcloud_config_set; gcloud config set "$argv[1]" "$argv[2]"; end

function gcloud_config_set_project; gcloud config set project "$argv[1]"; end

function gcloud_config_set_region; gcloud config set compute/region "$argv[1]"; end

function gcloud_config_set_zone; gcloud config set compute/zone "$argv[1]"; end

function gcloud_dns_list; gcloud dns managed-zones list; end

function gcloud_dns_records; gcloud dns record-sets list --zone="$argv[1]"; end

function gcloud_firewall_create; gcloud compute firewall-rules create "$argv[1]" --allow "$argv[2]"; end

function gcloud_firewall_list; gcloud compute firewall-rules list; end

function gcloud_get_creds; gcloud container clusters get-credentials "$argv[1]" $argv; end

function gcloud_iam_create; gcloud iam service-accounts create "$argv[1]"; end

function gcloud_iam_keys; gcloud iam service-accounts keys list --iam-account="$argv[1]"; end

function gcloud_iam_list; gcloud iam service-accounts list; end

function gcloud_kms_decrypt; gcloud kms decrypt --location="$argv[1]" --keyring="$argv[2]" --key="$argv[3]" --ciphertext-file="$argv[4]" --plaintext-file="$argv[5]"; end

function gcloud_kms_encrypt; gcloud kms encrypt --location="$argv[1]" --keyring="$argv[2]" --key="$argv[3]" --plaintext-file="$argv[4]" --ciphertext-file="$argv[5]"; end

function gcloud_kms_list; gcloud kms keyrings list --location="$argv[1]"; end

function gcloud_list_clusters; gcloud container clusters list 2>/dev/null; or true; end

function gcloud_list_disks; gcloud compute disks list 2>/dev/null; or true; end

function gcloud_list_images; gcloud compute images list 2>/dev/null; or true; end

function gcloud_list_instances; gcloud compute instances list 2>/dev/null; or true; end

function gcloud_list_projects; gcloud projects list 2>/dev/null; or true; end

function gcloud_run_deploy; gcloud run deploy "$argv[1]" --image "$argv[2]" --platform managed; end

function gcloud_run_list; gcloud run services list; end

function gcloud_sql_connect; gcloud sql connect "$argv[1]" --user="$argv[2]"; end

function gcloud_sql_list; gcloud sql instances list; end

function gcloud_ssh; gcloud compute ssh $argv; end

function gcloud_storage_buckets; gcloud storage buckets list; end

function gcloud_storage_cp; gcloud storage cp "$argv[1]" "$argv[2]"; end

function gcloud_storage_list; gcloud storage ls; end

function gcloud_storage_rsync; gcloud storage rsync "$argv[1]" "$argv[2]"; end

function generate_password; openssl rand -base64 "(if set -q argv[1]; echo $argv[1]; else; echo 16; end)" 2>/dev/null; or python3 -c "import secrets; print(secrets.token_urlsafe((if set -q argv[1]; echo $argv[1]; else; echo 16; end)))"; end

function generate_token; openssl rand -hex "(if set -q argv[1]; echo $argv[1]; else; echo 32; end)" 2>/dev/null; or python3 -c "import secrets; print(secrets.token_hex((if set -q argv[1]; echo $argv[1]; else; echo 32; end)))"; end

function generate_uuid; uuidgen 2>/dev/null; or python3 -c "import uuid; print(uuid.uuid4())"; end

function get_battery_percent

end

function get_battery_status

end

function get_cpu_info; lscpu 2>/dev/null | head -20; or sysctl -n machdep.cpu.brand_string; end

function get_disk_info; df -h 2>/dev/null; end

function get_disk_usage_root; df -h /; end

function get_display_info; echo (if set -q DISPLAY; echo $DISPLAY; else; echo :0; end); end

function get_gpu_info; lspci | grep -i vga 2>/dev/null; or true; end

function get_installed_packages; pacman -Q 2>/dev/null | wc -l; or dpkg -l 2>/dev/null | wc -l; or brew list 2>/dev/null | wc -l; end

function get_last_reboot; who -b; end

function get_listening_ports; ss -tlnp 2>/dev/null; or netstat -tlnp; end

function get_logged_in_users; who; end

function get_memory_info; free -h 2>/dev/null; or vm_stat; end

function get_network_info; ip -br addr 2>/dev/null; or ifconfig; end

function get_running_processes; ps aux | head -20; end

function get_shell_process; ps -p $fish_pid -o comm=; end

function get_swap_usage; free -h | awk '/Swap/ {print $argv[3] "/" $argv[2]}'; end

function get_system_load; uptime; end

function get_temperature_info

end

function get_uptime_pretty; uptime | sed 's/.*up //; s/,//g'; end

function gif_optimize; convert "$argv[1]" -fuzz 2% -layers Optimize "(string replace -r '\.[^.]+\$' '' -- $argv[1])-optimized.gif"; end

function git_alias_list; git config --global --get-regexp alias; end

function git_alias_remove; git config --global --unset alias."$argv[1]"; end

function git_alias_set; git config --global alias."$argv[1]" "$argv[2]"; end

function git_amend_all; git add -A; and git commit --amend --no-edit; end

function git_amend_author; git commit --amend --author="$argv[1]"; end

function git_amend_date; git commit --amend --date="$argv[1]"; end

function git_amend_message; git commit --amend -m "$argv[1]"; end

function git_amend_noedit; git commit --amend --no-edit; end

function git_archive_branch; git archive -o "(if set -q argv[1]; echo $argv[1]; else; echo archive; end).tar.gz" HEAD; end

function git_archive_export; git archive HEAD | tar -xC "(if set -q argv[1]; echo $argv[1]; else; echo export; end)"; end

function git_archive_format; git archive --format="$argv[1]" -o "(if set -q argv[2]; echo $argv[2]; else; echo archive; end).$argv[1]" HEAD; end

function git_archive_zip; git archive -o "(if set -q argv[1]; echo $argv[1]; else; echo archive; end).zip" HEAD; end

function git_attributes_text; echo "* text=auto" >> .gitattributes; end

function git_bisect_bad; git bisect bad; end

function git_bisect_good; git bisect good; end

function git_bisect_log; git bisect log; end

function git_bisect_reset; git bisect reset; end

function git_bisect_run; git bisect run "$argv[1]"; end

function git_bisect_start; git bisect start "$argv[1]" "$argv[2]"; end

function git_blame_date; git blame --date=short "$argv[1]"; end

function git_blame_email; git blame -e "$argv[1]"; end

function git_blame_file; git blame -w $argv; end

function git_blob_size; git cat-file -s "$argv[1]" 2>/dev/null; end

function git_branch_age; git for-each-ref --sort=committerdate refs/heads/ --format="%(refname:short) %(committerdate:relative)"; end

function git_branch_create; git checkout -b "$argv[1]"; end

function git_branch_current; git rev-parse --abbrev-ref HEAD 2>/dev/null; end

function git_branch_delete; git branch -d "$argv[1]" 2>/dev/null; or echo "branch not found or unmerged"; end

function git_branch_delete_merged; git branch --merged | grep -v "^*\|main\|master\|develop" | xargs -r git branch -d; end

function git_branch_diff; git diff "main...$(git_branch_current)" --stat; end

function git_branch_list_all; git branch -a; end

function git_branch_log; git log "main...$(git_branch_current)" --oneline; end

function git_branch_merged; git branch --merged; end

function git_branch_not_merged; git branch --no-merged; end

function git_branch_purge; git branch -D "$argv[1]"; end

function git_branch_rename; git branch -m "$argv[1]" "$argv[2]"; end

function git_branch_rename_remote; git push origin --delete "$argv[1]"; and git branch -m "$argv[1]" "$argv[2]"; and git push origin -u "$argv[2]"; end

function git_branch_sort; git branch --sort=-committerdate; end

function git_branch_switch; git checkout "$argv[1]"; end

function git_branch_switch_create; git checkout -b "$argv[1]"; end

function git_branch_tracking; git branch -vv; end

function git_bundle_create; git bundle create "(if set -q argv[1]; echo $argv[1]; else; echo repo.bundle; end)" --all; end

function git_bundle_unbundle; git clone "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo repo; end)"; end

function git_bundle_verify; git bundle verify "$argv[1]"; end

function git_check_attr; git check-attr "$argv[1]" "$argv[2]"; end

function git_check_ignore; git check-ignore "$argv[1]"; end

function git_checkout_new_branch; git checkout -b "$argv[1]"; end

function git_cherry_commit; git cherry -v "$argv[1]" "$argv[2]"; end

function git_cherry_pick; git cherry-pick $argv; end

function git_cherry_pick_abort; git cherry-pick --abort; end

function git_cherry_pick_continue; git cherry-pick --continue; end

function git_cherry_pick_nocommit; git cherry-pick -n $argv; end

function git_cherry_pick_range; git cherry-pick "$argv[1]".."$argv[2]"; end

function git_clean_branches; git branch --merged | grep -v "^*\|main\|master\|develop" | xargs -r git branch -d; and git remote prune origin; end

function git_clean_dry; git clean -nfd; end

function git_clean_ignored; git clean -fX; end

function git_clone_bare; git clone --bare "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]").git; end)"; end

function git_clone_bitbucket; git clone "https://bitbucket.org/$argv[1].git" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]"); end)"; end

function git_clone_gh_ssh; git clone "git@github.com:$argv[1].git" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]"); end)"; end

function git_clone_github; git clone "https://github.com/$argv[1].git" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]"); end)"; end

function git_clone_gitlab; git clone "https://gitlab.com/$argv[1].git" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]"); end)"; end

function git_clone_mirror; git clone --mirror "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]").git; end)"; end

function git_clone_recursive; git clone --recursive $argv; end

function git_clone_shallow; git clone --depth=1 $argv; end

function git_commit_allow_empty; git commit --allow-empty -m "$argv[1]"; end

function git_commit_date; GIT_AUTHOR_DATE="$argv[1]" GIT_COMMITTER_DATE="$argv[1]" git commit -m "$argv[2]"; end

function git_commit_empty; git commit --allow-empty -m "$argv[1]"; end

function git_commit_fixup; git commit --fixup "$argv[1]"; end

function git_commit_sign; git commit -S $argv; end

function git_commit_signed; git commit -S $argv; end

function git_commit_squash; git commit --squash "$argv[1]"; end

function git_commit_stats; git diff --stat $argv; end

function git_commit_verbose; git commit -v $argv; end

function git_compare_branches; git log --oneline --left-right "$argv[1]...$argv[2]"; end

function git_config_autocorrect; git config --global help.autocorrect 10; end

function git_config_autocrlf; git config --global core.autocrlf "$argv[1]"; end

function git_config_color_ui; git config --global color.ui auto; end

function git_config_credential_helper; git config --global credential.helper "$argv[1]"; end

function git_config_diff_algorithm; git config --global diff.algorithm patience; end

function git_config_diff_renames; git config --global diff.renames copies; end

function git_config_diff_tool; git config --global diff.tool "$argv[1]"; end

function git_config_editor; git config --global core.editor "$argv[1]"; end

function git_config_excludes; git config --global core.excludesFile "$argv[1]"; end

function git_config_fetch_prune; git config --global fetch.prune true; end

function git_config_global_user; git config --global user.name "$argv[1]"; and git config --global user.email "$argv[2]"; end

function git_config_http_proxy; git config --global http.proxy "$argv[1]"; end

function git_config_init_default; git config --global init.defaultBranch main; end

function git_config_list; git config --list; end

function git_config_list_global; git config --global --list; end

function git_config_merge_ff; git config --global merge.ff false; end

function git_config_merge_tool; git config --global merge.tool "$argv[1]"; end

function git_config_no_proxy; git config --global --unset http.proxy; end

function git_config_pull_ff; git config --global pull.ff only; end

function git_config_pull_rebase; git config --global pull.rebase true; end

function git_config_push_default; git config --global push.default current; end

function git_config_push_followtags; git config --global push.followTags true; end

function git_config_rebase_autosquash; git config --global rebase.autosquash true; end

function git_config_rebase_autostash; git config --global rebase.autoStash true; end

function git_config_safecrlf; git config --global core.safecrlf "$argv[1]"; end

function git_config_set_global; git config --global "$argv[1]" "$argv[2]"; end

function git_config_signing; git config --global commit.gpgsign true; and git config --global user.signingkey "$argv[1]"; end

function git_config_ssh_command; git config --global core.sshCommand "$argv[1]"; end

function git_config_symlink; git config --global core.symlinks true; end

function git_config_tag_sort; git config --global tag.sort version:refname; end

function git_config_user; git config user.name "$argv[1]"; and git config user.email "$argv[2]"; end

function git_contributors; git shortlog -sn; end

function git_contributors_all; git shortlog -sn --all; end

function git_contributors_by_date; git log --format='%an' | sort | uniq -c | sort -rn; end

function git_contributors_count; git shortlog -sn | wc -l; end

function git_contributors_top; git shortlog -sn -20; end

function git_count_objects; git count-objects -v; end

function git_describe_commit; git describe --tags "$argv[1]"; end

function git_diff_branches; git diff "$argv[1]"..."$argv[2]"; end

function git_diff_cached; git diff --cached; end

function git_diff_commits; git diff "$argv[1]" "$argv[2]"; end

function git_diff_name; git diff --name-only; end

function git_diff_patch; git diff --patch $argv; end

function git_diff_staged; git diff --cached; end

function git_diff_stat; git diff --stat $argv 2>/dev/null; end

function git_diff_summary; git diff --shortstat $argv 2>/dev/null; end

function git_diff_summary_only; git diff --name-status $argv; end

function git_diff_unstaged; git diff; end

function git_diff_word; git diff --word-diff $argv 2>/dev/null; end

function git_diff_word_highlight; git diff --word-diff=color $argv; end

function git_discard_all; git checkout -- .; end

function git_discard_file; git checkout -- "$argv[1]"; end

function git_fetch_all; git fetch --all; end

function git_fetch_prune; git fetch --all --prune; end

function git_files_changed; git diff --name-only $argv; end

function git_files_conflict; git diff --name-only --diff-filter=U; end

function git_files_modified; git ls-files -m; end

function git_files_staged; git diff --cached --name-only; end

function git_files_untracked; git ls-files --others --exclude-standard; end

function git_first_commit; git log --reverse --oneline | head -1; end

function git_flow_feature_finish; git flow feature finish "$argv[1]"; end

function git_flow_feature_start; git flow feature start "$argv[1]"; end

function git_flow_hotfix_finish; git flow hotfix finish "$argv[1]"; end

function git_flow_hotfix_start; git flow hotfix start "$argv[1]"; end

function git_flow_init; git flow init -d; end

function git_flow_release_finish; git flow release finish "$argv[1]"; end

function git_flow_release_start; git flow release start "$argv[1]"; end

function git_fsck_repair; git fsck --full; end

function git_gc_aggressive; git gc --aggressive --prune=now; end

function git_grep_context; git grep -C "(if set -q argv[3]; echo $argv[3]; else; echo 2; end)" "$argv[1]" "$argv[2]"; end

function git_grep_files; git grep -l "$argv[1]"; end

function git_grep_search; git grep $argv; end

function git_grep_string; git grep -n "$argv[1]"; end

function git_hook_install; curl -fsSL "$argv[1]" > .git/hooks/"$argv[2]" 2>/dev/null; and chmod +x .git/hooks/"$argv[2]"; end

function git_hook_precommit; cat .git/hooks/pre-commit 2>/dev/null; or echo "no pre-commit hook"; end

function git_ignore_global; git config --global core.excludesfile "$argv[1]"; end

function git_ignore_local; echo "$argv[1]" >> .gitignore; end

function git_ignore_template; curl -fsSL "https://www.gitignore.io/api/$argv[1]" >> .gitignore 2>/dev/null; or echo "add gitignore template manually"; end

function git_interactive_rebase; git rebase -i HEAD~"(if set -q argv[1]; echo $argv[1]; else; echo 10; end)"; end

function git_last_commit; git log -1 --oneline; end

function git_lfs_install; git lfs install; end

function git_lfs_list; git lfs ls-files; end

function git_lfs_migrate; git lfs migrate import --include="$argv[1]" --everything; end

function git_lfs_pull; git lfs pull; end

function git_lfs_push; git lfs push origin "$argv[1]"; end

function git_lfs_track; git lfs track "$argv[1]"; end

function git_log_author; git log --oneline --author="$argv[1]" -20 2>/dev/null; end

function git_log_author_date; git log --author="$argv[1]" --format='%h %ad %s' --date=short; end

function git_log_between; git log --oneline "$argv[1]..$argv[2]"; end

function git_log_date_range; git log --oneline --after="$argv[1]" --before="$argv[2]" 2>/dev/null; end

function git_log_diff; git whatchanged -p "$argv[1]"; end

function git_log_format; git log --format='%h %an %s' -20; end

function git_log_graph; git log --oneline --graph --all -30 2>/dev/null; end

function git_log_graph_all; git log --oneline --graph --all --decorate; end

function git_log_oneline; git log --oneline -20 2>/dev/null; end

function git_log_patch; git log -p $argv; end

function git_log_search; git log --oneline --grep="$argv[1]" -20 2>/dev/null; end

function git_log_short; git log --oneline --decorate -10; end

function git_log_since; git log --oneline --since="$argv[1]" 2>/dev/null; end

function git_log_stat; git log --stat -10; end

function git_log_stats; git log --stat --summary $argv; end

function git_log_today; git log --oneline --since="midnight" --author="$(git config user.email)" 2>/dev/null; end

function git_log_until; git log --oneline --until="$argv[1]" 2>/dev/null; end

function git_ls_files; git ls-files; end

function git_ls_tree; git ls-tree -r "$argv[1]"; end

function git_merge_abort; git merge --abort; end

function git_merge_continue; git merge --continue; end

function git_merge_ff; git merge --ff-only "$argv[1]"; end

function git_merge_ff_only; git merge --ff-only "$argv[1]"; end

function git_merge_noff; git merge --no-ff "$argv[1]" -m "(if set -q argv[2]; echo $argv[2]; else; echo merge; end)"; end

function git_merge_squash; git merge --squash "$argv[1]"; and git commit -m "(if set -q argv[2]; echo $argv[2]; else; echo squash merge; end)"; end

function git_merge_squash_branch; git merge --squash "$argv[1]"; and git commit -m "(if set -q argv[2]; echo $argv[2]; else; echo squash: $argv[1]; end)"; end

function git_notes_add; git notes add -m "$argv[1]" "$argv[2]"; end

function git_notes_append; git notes append -m "$argv[1]" "$argv[2]"; end

function git_notes_list; git notes list; end

function git_notes_prune; git notes prune; end

function git_notes_remove; git notes remove "$argv[2]" 2>/dev/null; end

function git_notes_show; git notes show "$argv[1]"; end

function git_obj_type; git cat-file -t "$argv[1]" 2>/dev/null; end

function git_patch_apply; git am "$argv[1]"; end

function git_patch_apply_check; git apply --check "$argv[1]"; end

function git_patch_apply_stat; git apply --stat "$argv[1]"; end

function git_patch_create; git format-patch "$argv[1]" -o "(if set -q argv[2]; echo $argv[2]; else; echo patches; end)"; end

function git_pull_autostash; git pull --rebase --autostash; end

function git_pull_ff; git pull --ff-only; end

function git_pull_rebase; git pull --rebase $argv; end

function git_pull_rebase_auto; git pull --rebase --autostash $argv; end

function git_push_all; git push --all; end

function git_push_force_lease; git push --force-with-lease $argv; end

function git_push_tags; git push --tags; end

function git_push_upstream; git push -u origin "$(git_branch_current)"; end

function git_range_diff; git range-diff "$argv[1]" "$argv[2]" "$argv[3]"; end

function git_rebase_abort; git rebase --abort; end

function git_rebase_continue; git rebase --continue; end

function git_rebase_editor; GIT_SEQUENCE_EDITOR=true git rebase -i $argv; end

function git_rebase_interactive; git rebase -i HEAD~"(if set -q argv[1]; echo $argv[1]; else; echo 10; end)"; end

function git_rebase_onto; git rebase --onto "$argv[1]" "$argv[2]" "$argv[3]"; end

function git_rebase_root; git rebase -i --root; end

function git_rebase_skip; git rebase --skip; end

function git_reflog_all; git reflog --all; end

function git_reflog_date; git reflog --date=iso; end

function git_reflog_delete_old; git reflog expire --expire-unreachable="(if set -q argv[1]; echo $argv[1]; else; echo 30.days; end)" --all; end

function git_reflog_expire; git reflog expire --expire="(if set -q argv[1]; echo $argv[1]; else; echo 90.days; end)" --all; end

function git_reflog_show; git reflog -20; end

function git_remote_add_origin; git remote add origin "$argv[1]"; end

function git_remote_add_upstream; git remote add upstream "$argv[1]"; end

function git_remote_get_url; git remote get-url origin; end

function git_remote_list; git remote -v; end

function git_remote_prune; git remote prune origin; end

function git_remote_remove; git remote remove "$argv[1]"; end

function git_remote_rename; git remote rename "$argv[1]" "$argv[2]"; end

function git_remote_set_url; git remote set-url origin "$argv[1]"; end

function git_remote_update; git remote update; end

function git_repack_optimize; git repack -a -d --depth=250 --window=250; end

function git_replace_commit; git replace "$argv[1]" "$argv[2]"; end

function git_replace_delete; git replace -d "$argv[1]"; end

function git_replace_list; git replace -l; end

function git_rerere_enable; git config --global rerere.enabled true; end

function git_rerere_gc; git rerere gc; end

function git_rerere_status; git rerere status; end

function git_reset_all; git reset --hard HEAD; and git clean -fd; end

function git_reset_file; git checkout -- "$argv[1]"; end

function git_reset_hard; git reset --hard HEAD~"$argv[1]"; end

function git_reset_keep; git reset --keep HEAD~"$argv[1]"; end

function git_reset_mixed; git reset --mixed HEAD~"$argv[1]"; end

function git_reset_soft; git reset --soft HEAD~"$argv[1]"; end

function git_reset_to_commit; git reset --hard "$argv[1]"; end

function git_revert_abort; git revert --abort; end

function git_revert_commit; git revert --no-edit "$argv[1]"; end

function git_revert_continue; git revert --continue; end

function git_revert_no_commit; git revert --no-commit "$argv[1]"; end

function git_reword_commit; git commit --amend --only -m "$argv[1]"; end

function git_show_commit_body; git show -s --format=%B "$argv[1]"; end

function git_show_files_in_commit; git show --name-only "$argv[1]"; end

function git_show_refs; git show-ref; end

function git_show_tree; git ls-tree -r --name-only "$argv[1]"; end

function git_split_commit; git reset HEAD~1; and git add -p; and git commit -m "$argv[1]"; and git commit -m "$argv[2]"; end

function git_squash_all; git reset --soft "$(git rev-list --max-parents=0 HEAD)"; and git commit --amend -m "(if set -q argv[1]; echo $argv[1]; else; echo squashed; end)"; end

function git_squash_last; git reset --soft HEAD~"(if set -q argv[1]; echo $argv[1]; else; echo 2; end)"; and git commit -m "(if set -q argv[2]; echo $argv[2]; else; echo squash; end)"; end

function git_stage_interactive; git add -p; end

function git_stage_partial; git add -p "$argv[1]"; end

function git_stash_apply; git stash apply $argv; end

function git_stash_apply_drop; git stash apply; and git stash drop; end

function git_stash_branch; git stash branch "$argv[1]"; end

function git_stash_clear_all; git stash clear; end

function git_stash_drop; git stash drop $argv; end

function git_stash_list; git stash list; end

function git_stash_list_all; git stash list --stat; end

function git_stash_pop; git stash pop; end

function git_stash_save; git stash push -u $argv; end

function git_stash_save_msg; git stash push -m "$argv[1]"; end

function git_stash_show; git stash show -p $argv; end

function git_stash_show_files; git stash show --stat; end

function git_status_ignored; git status --ignored --short; end

function git_status_porcelain; git status --porcelain; end

function git_status_short; git status --short --branch; end

function git_submodule_add; git submodule add "$argv[1]" "$argv[2]"; end

function git_submodule_foreach; git submodule foreach $argv; end

function git_submodule_init; git submodule init; end

function git_submodule_remove; git submodule deinit -f "$argv[1]"; and git rm -f "$argv[1]"; and rm -rf ".git/modules/$argv[1]"; end

function git_submodule_status; git submodule status; end

function git_submodule_sync; git submodule sync; end

function git_submodule_update; git submodule update --init --recursive; end

function git_submodule_update_remote; git submodule update --recursive --remote; end

function git_subtree_add; git subtree add --prefix="$argv[1]" "$argv[2]" "$argv[3]" --squash; end

function git_subtree_merge; git subtree merge --prefix="$argv[1]" "$argv[2]"; end

function git_subtree_pull; git subtree pull --prefix="$argv[1]" "$argv[2]" "$argv[3]" --squash; end

function git_subtree_push; git subtree push --prefix="$argv[1]" "$argv[2]" "$argv[3]"; end

function git_subtree_split; git subtree split --prefix="$argv[1]" -b "$argv[2]"; end

function git_svn_clone; git svn clone "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo $(basename "$argv[1]"); end)"; end

function git_svn_dcommit; git svn dcommit; end

function git_svn_rebase; git svn rebase; end

function git_tag_annotated; git tag -a "$argv[1]" -m "$argv[2]"; end

function git_tag_contains; git tag --contains "$argv[1]"; end

function git_tag_create; git tag "$argv[1]"; and echo "tagged: $argv[1]"; end

function git_tag_date; git log --tags --simplify-by-decoration --format="%ai %d"; end

function git_tag_delete; git tag -d "$argv[1]"; and echo "deleted: $argv[1]"; end

function git_tag_latest; git describe --tags "$(git rev-list --tags --max-count=1)" 2>/dev/null; end

function git_tag_list; git tag -l $argv; end

function git_tag_push; git push origin "$argv[1]"; end

function git_tag_push_all; git push --tags; end

function git_tag_sign; git tag -s "$argv[1]" -m "$argv[2]"; end

function git_tag_verify_all; git tag -v (git tag) 2>&1 | grep -B1 "Good\|Bad"; or true; end

function git_undo_commit; git reset --soft HEAD~1; end

function git_undo_commit_keep; git reset --mixed HEAD~1; end

function git_undo_last_commit_msg; git commit --amend -m "$argv[1]"; end

function git_unstage_all; git reset HEAD .; end

function git_unstage_file; git reset HEAD "$argv[1]"; end

function git_verify_commit; git verify-commit "$argv[1]"; end

function git_verify_tag; git verify-tag "$argv[1]"; end

function git_verify_tags; git tag -v $argv; end

function git_worktree_add; git worktree add "$argv[1]" "$argv[2]"; end

function git_worktree_list; git worktree list; end

function git_worktree_list_paths; git worktree list --porcelain; end

function git_worktree_lock; git worktree lock "$argv[1]"; end

function git_worktree_prune; git worktree prune; end

function git_worktree_remove; git worktree remove "$argv[1]"; end

function git_worktree_unlock; git worktree unlock "$argv[1]"; end

function gitignore_append; curl -fsSL "https://www.toptal.com/developers/gitignore/api/$argv[1]" >> .gitignore 2>/dev/null; or echo "unable to fetch"; end

function gitignore_fetch; curl -fsSL "https://www.toptal.com/developers/gitignore/api/$argv[1]" > .gitignore 2>/dev/null; or echo "unable to fetch"; end

function gitignore_list; curl -fsSL "https://www.toptal.com/developers/gitignore/api/list" 2>/dev/null | tr ',' '\n'; end

function glances_monitor; glances 2>/dev/null; or echo "glances needed"; end

function go_build_all; go build ./...; end

function go_build_cross; go build -o "(if set -q argv[1]; echo $argv[1]; else; echo app; end)-linux" .; and GOOS=darwin GOARCH=arm64 go build -o "(if set -q argv[1]; echo $argv[1]; else; echo app; end)-mac" .; end

function go_build_darwin; GOOS=darwin GOARCH=arm64 go build -o "(if set -q argv[1]; echo $argv[1]; else; echo app; end)-darwin-arm64" .; end

function go_build_linux; GOOS=linux GOARCH=amd64 go build -o "(if set -q argv[1]; echo $argv[1]; else; echo app; end)-linux-amd64" .; end

function go_build_windows; GOOS=windows GOARCH=amd64 go build -o "(if set -q argv[1]; echo $argv[1]; else; echo app; end)-windows-amd64.exe" .; end

function go_clean_cache; go clean -cache; end

function go_clean_modcache; go clean -modcache; end

function go_deps_graph; go mod graph; end

function go_doc_start; godoc -http=:6060 2>/dev/null; or echo "godoc not installed"; end

function go_doc_view; go doc "$argv[1]"; end

function go_env_list; go env; end

function go_fmt_all; go fmt ./...; end

function go_generate_all; go generate ./...; end

function go_get_pkg; go get "$argv[1]"; end

function go_install_latest; go install "$argv[1]@latest"; end

function go_install_tool; go install "$argv[1]@latest"; end

function go_lint_all; golint ./... 2>/dev/null; end

function go_mod_download; go mod download; end

function go_mod_tidy; go mod tidy; end

function go_mod_vendor; go mod vendor; end

function go_mod_verify; go mod verify; end

function go_mod_why; go mod why "$argv[1]"; end

function go_run_dir; go run .; end

function go_test_bench; go test -bench=. ./...; end

function go_test_cover; go test -cover ./...; end

function go_test_cover_func; go test -coverprofile=coverage.out ./...; and go tool cover -func=coverage.out; end

function go_test_cover_html; go test -coverprofile=coverage.out ./...; and go tool cover -html=coverage.out; end

function go_test_race; go test -race ./...; end

function go_test_short; go test -short ./...; end

function go_tool_covdata; go tool covdata $argv; end

function go_tool_objdump; go tool objdump "$argv[1]"; end

function go_tool_pprof; go tool pprof $argv; end

function go_tool_trace; go tool trace $argv; end

function go_version; go version; end

function go_vet_all; go vet ./...; end

function go_work_init; go work init $argv; end

function go_work_sync; go work sync; end

function go_work_use; go work use "$argv[1]"; end

function gpg_agent_add; gpg_agent_ensure; ssh-add $argv 2>/dev/null; or ssh-add; end

function gpg_agent_ensure

end

function gpg_decrypt_asymmetric; gpg -d "$argv[1]"; end

function gpg_decrypt_file; gpg -d $argv[1] > (string replace -r '\.gpg$' '' -- $argv[1]); end

function gpg_decrypt_sym; gpg -d "$argv[1]"; end

function gpg_delete_key; gpg --delete-key "$argv[1]"; end

function gpg_delete_secret_key; gpg --delete-secret-key "$argv[1]"; end

function gpg_encrypt_asymmetric; gpg -e -r "$argv[1]" "$argv[2]"; end

function gpg_encrypt_file; gpg -e -r "$argv[1]" "$argv[2]"; end

function gpg_encrypt_sym; gpg -c "$argv[1]"; end

function gpg_encrypt_symmetric; gpg -c "$argv[1]"; end

function gpg_export_key; gpg --export -a "$argv[1]" > "$1.asc"; end

function gpg_export_key_armor; gpg --export -a "$argv[1]"; end

function gpg_export_secret_key; gpg --export-secret-keys -a "$argv[1]" > "$1.private.asc"; end

function gpg_export_secret_key_armor; gpg --export-secret-keys -a "$argv[1]"; end

function gpg_import_key; gpg --import "$argv[1]"; end

function gpg_import_key_armor; gpg --import "$argv[1]"; end

function gpg_key_details; gpg --list-keys --keyid-format LONG "$argv[1]"; end

function gpg_key_fingerprint; gpg --fingerprint "$argv[1]" | grep fingerprint | tr -d ' ' | cut -d= -f2; end

function gpg_key_fpr; gpg --fingerprint "$argv[1]" | grep -i fingerprint | tr -d ' ' | cut -d= -f2; end

function gpg_key_id; gpg --list-keys --keyid-format LONG "$argv[1]" | grep "^pub" | awk '{print $argv[2]}'; end

function gpg_list_keys; gpg --list-keys 2>/dev/null; or true; end

function gpg_list_keys_with_email; gpg --list-keys --keyid-format LONG | grep -A1 "^pub" | grep -v "^--"; end

function gpg_list_keys_with_id; gpg --list-keys --keyid-format LONG | grep "^pub\|^sub"; end

function gpg_list_secret_keys; gpg --list-secret-keys 2>/dev/null; or true; end

function gpg_recv_keys; gpg --recv-keys $argv; end

function gpg_recv_keyserver; gpg --keyserver "(if set -q argv[2]; echo $argv[2]; else; echo keyserver.ubuntu.com; end)" --recv-keys "$argv[1]"; end

function gpg_refresh_keys; gpg --refresh-keys; end

function gpg_refresh_keyserver; gpg --keyserver "(if set -q argv[1]; echo $argv[1]; else; echo keyserver.ubuntu.com; end)" --refresh-keys; end

function gpg_set_trust; gpg --edit-key "$argv[1]" trust; end

function gpg_sign_detached; gpg --detach-sign "$argv[1]"; end

function gpg_sign_file; gpg -s "$argv[1]"; end

function gpg_verify_detached; gpg --verify "$argv[1]"{,.sig} 2>/dev/null; or gpg --verify "$argv[1]"{,.asc}; end

function gpg_verify_file; gpg --verify "$argv[1]"; end

function gping_ping; gping "$argv[1]" 2>/dev/null; or ping "$argv[1]"; end

function grep_context; grep -C "(if set -q argv[3]; echo $argv[3]; else; echo 2; end)" "$argv[1]" "$argv[2]"; end

function grep_count; grep -c $argv; end

function grep_invert; grep -v $argv; end

function grep_recursive; grep -r $argv; end

function grep_search; grep $argv; end

function grep_word; grep -w $argv; end

function grex_regex_gen; grex "$argv[1]" 2>/dev/null; or echo "grex needed"; end

function gron_json_flatten; gron "$argv[1]" 2>/dev/null; or cat "$argv[1]"; end

function gron_json_unflatten; gron -u "$argv[1]" 2>/dev/null; or cat "$argv[1]"; end

function gzip_compress; gzip "$argv[1]"; end

function gzip_decompress; gunzip "$argv[1]"; end

function gzip_level; gzip -"(if set -q argv[2]; echo $argv[2]; else; echo 6; end)" "$argv[1]"; end

function hash_file; sha256sum "$argv[1]" 2>/dev/null | cut -d' ' -f1; end

function hash_md5; printf "%s" "$argv[1]" | md5sum | cut -d' ' -f1; end

function hash_string; printf "%s" "$argv[1]" | sha256sum | cut -d' ' -f1; end

function helm_create_chart; helm create "$argv[1]"; end

function helm_dep_build; helm dependency build "$argv[1]"; end

function helm_dep_update; helm dependency update "$argv[1]"; end

function helm_dry_run; helm install "$argv[1]" "$argv[2]" --dry-run --debug; end

function helm_get_hooks; helm get hooks "$argv[1]"; end

function helm_get_manifest; helm get manifest "$argv[1]"; end

function helm_get_notes; helm get notes "$argv[1]"; end

function helm_get_values_all; helm get values "$argv[1]" --all; end

function helm_history_show; helm history "$argv[1]"; end

function helm_install_chart; helm install "$argv[1]" "$argv[2]" -n "$argv[3]" --create-namespace; end

function helm_lint_chart; helm lint "$argv[1]"; end

function helm_list_releases; helm list; end

function helm_list_releases_all; helm list --all-namespaces; end

function helm_list_releases_ns; helm list -n "$argv[1]"; end

function helm_package_chart; helm package "$argv[1]"; end

function helm_pull_chart; helm pull "$argv[1]" --untar; end

function helm_pull_chart_version; helm pull "$argv[1]" --version "$argv[2]" --untar; end

function helm_repo_add; helm repo add "$argv[1]" "$argv[2]"; end

function helm_repo_list; helm repo list; end

function helm_repo_update; helm repo update; end

function helm_rollback_release; helm rollback "$argv[1]" "$argv[2]"; end

function helm_rollback_revision; helm rollback "$argv[1]" "$argv[2]"; end

function helm_search_all; helm search repo "$argv[1]" --versions; end

function helm_search_hub; helm search hub "$argv[1]"; end

function helm_search_repo; helm search repo "$argv[1]"; end

function helm_show_chart; helm show chart "$argv[1]"; end

function helm_show_readme; helm show readme "$argv[1]"; end

function helm_show_values; helm show values "$argv[1]"; end

function helm_status_release; helm status "$argv[1]"; end

function helm_template_render; helm template "$argv[1]" "$argv[2]"; end

function helm_test_ns; helm test "$argv[1]" -n "$argv[2]"; end

function helm_test_release; helm test "$argv[1]"; end

function helm_uninstall_release; helm uninstall "$argv[1]"; end

function helm_upgrade_install; helm upgrade --install "$argv[1]" "$argv[2]"; end

function helm_upgrade_install_full; helm upgrade --install "$argv[1]" "$argv[2]" --namespace "(if set -q argv[3]; echo $argv[3]; else; echo default; end)" --create-namespace; end

function helm_upgrade_release; helm upgrade "$argv[1]" "$argv[2]"; end

function hex_dump; xxd $argv | head -50; end

function hex_to_dec; printf "%d\n" "0x$argv[1]" 2>/dev/null; end

function htop_monitor; htop; end

function http_headers; curl -I "$argv[1]"; end

function http_status; curl -sI "$argv[1]" | head -1; end

function httpie_delete; http DELETE "$argv[1]" 2>/dev/null; or curl -sS -X DELETE "$argv[1]"; end

function httpie_get; http "$argv[1]" 2>/dev/null; or curl -sS "$argv[1]"; end

function httpie_post; http POST "$argv[1]" "$argv[2]" 2>/dev/null; or curl -sS -X POST -d "$argv[2]" "$argv[1]"; end

function httpie_put; http PUT "$argv[1]" "$argv[2]" 2>/dev/null; or curl -sS -X PUT -d "$argv[2]" "$argv[1]"; end

function iftop_monitor; sudo iftop 2>/dev/null; or echo "iftop needed"; end

function image_compress; convert "$argv[1]" -quality "(if set -q argv[2]; echo $argv[2]; else; echo 85; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-compressed.(string split -r -m1 '.' -- $argv[1])[-1]"; end

function image_convert; convert "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo output.png; end)"; end

function image_crop; convert "$argv[1]" -crop "(if set -q argv[2]; echo $argv[2]; else; echo 640x480; end)+(if set -q argv[3]; echo $argv[3]; else; echo 0; end)+(if set -q argv[4]; echo $argv[4]; else; echo 0; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-cropped.(string split -r -m1 '.' -- $argv[1])[-1]"; end

function image_info; identify "$argv[1]" 2>/dev/null; end

function image_resize; convert "$argv[1]" -resize "(if set -q argv[2]; echo $argv[2]; else; echo 50%; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-resized.(string split -r -m1 '.' -- $argv[1])[-1]"; end

function image_rotate; convert "$argv[1]" -rotate "(if set -q argv[2]; echo $argv[2]; else; echo 90; end)" "(string replace -r '\.[^.]+\$' '' -- $argv[1])-rotated.(string split -r -m1 '.' -- $argv[1])[-1]"; end

function image_trim; convert "$argv[1]" -trim "(string replace -r '\.[^.]+\$' '' -- $argv[1])-trimmed.(string split -r -m1 '.' -- $argv[1])[-1]"; end

function iotop_monitor; sudo iotop -o 2>/dev/null; or echo "iotop needed"; end

function ip_info; curl -fsSL https://ipinfo.io/json 2>/dev/null; end

function journalctl_boot; journalctl -b $argv 2>/dev/null; or return 0; end

function journalctl_catalog; journalctl -x "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_disk_usage; journalctl --disk-usage 2>/dev/null; or return 0; end

function journalctl_errors; journalctl -p err -b 2>/dev/null; or return 0; end

function journalctl_follow; journalctl -f 2>/dev/null; or return 0; end

function journalctl_follow_unit; journalctl -fu "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_kernel; journalctl -k 2>/dev/null; or return 0; end

function journalctl_list_boots; journalctl --list-boots 2>/dev/null; or return 0; end

function journalctl_logs; journalctl -xe 2>/dev/null; or return 0; end

function journalctl_merge; journalctl --merge 2>/dev/null; or return 0; end

function journalctl_no_pager; journalctl --no-pager 2>/dev/null; or return 0; end

function journalctl_output_json; journalctl -o json 2>/dev/null; or return 0; end

function journalctl_priority; journalctl -p "$argv[1]" -b 2>/dev/null; or return 0; end

function journalctl_reverse; journalctl -r 2>/dev/null; or return 0; end

function journalctl_since_time; journalctl --since "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_unit; journalctl -u "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_unit_today; journalctl -u "$argv[1]" --since="today" 2>/dev/null; or return 0; end

function journalctl_unit_yesterday; journalctl -u "$argv[1]" --since="yesterday" --until="today" 2>/dev/null; or return 0; end

function journalctl_until_time; journalctl --until "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_user_unit; journalctl --user -u "$argv[1]" 2>/dev/null; or return 0; end

function journalctl_vacuum_size; sudo journalctl --vacuum-size="(if set -q argv[1]; echo $argv[1]; else; echo 500M; end)" 2>/dev/null; or return 0; end

function journalctl_vacuum_time; sudo journalctl --vacuum-time="(if set -q argv[1]; echo $argv[1]; else; echo 2weeks; end)" 2>/dev/null; or return 0; end

function journalctl_warnings; journalctl -p warning -b 2>/dev/null; or return 0; end

function json_validate; python3 -m json.tool $argv >/dev/null 2>&1; and echo "valid json"; or echo "invalid json"; end

function jsonfmt; python3 -m json.tool $argv 2>/dev/null; or python3 -c "import sys,json; print(json.dumps(json.load(sys.stdin),indent=2))"; end

function just_edit; just --edit 2>/dev/null; end

function just_list; just --list 2>/dev/null; end

function just_run; just $argv 2>/dev/null; end

function k8s_deploy; kubectl get deployments; end

function k8s_exec; kubectl exec -it "$argv[1]" -- /bin/sh; end

function k8s_exec_bash; kubectl exec -it "$argv[1]" -- /bin/bash; end

function k8s_logs; kubectl logs -f "$argv[1]"; end

function k8s_pods; kubectl get pods; end

function k8s_port_fw; kubectl port-forward "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo 8888; end):(if set -q argv[3]; echo $argv[3]; else; echo 80; end)"; end

function k8s_svc; kubectl get svc; end

function k9s_open; k9s; end

function kernel_version; uname -r; end

function kill_port_process; set -l _pid (check_port_pid $argv[1]); if test -n "$_pid"; kill -9 $_pid 2>/dev/null; and echo "killed $_pid"; else; echo "no process found on port $argv[1]"; end; end

function kubectl_annotate_add; kubectl annotate "$argv[1]" "$argv[2]" "$argv[3]"; end

function kubectl_api_resources_short; kubectl api-resources -o wide; end

function kubectl_api_versions; kubectl api-versions; end

function kubectl_apply_dir; kubectl apply -f "$argv[1]" --recursive; end

function kubectl_apply_kustomize; kubectl apply -k "$argv[1]"; end

function kubectl_apply_prune; kubectl apply --prune -f "$argv[1]"; end

function kubectl_auth_cani; kubectl auth can-i $argv; end

function kubectl_auth_reconcil; kubectl auth reconcile -f "$argv[1]"; end

function kubectl_autoscale_deployment; kubectl autoscale deployment "$argv[1]" --min="$argv[2]" --max="$argv[3]" --cpu-percent="$argv[4]"; end

function kubectl_completion_bash; kubectl completion bash; end

function kubectl_completion_fish; kubectl completion fish; end

function kubectl_completion_zsh; kubectl completion zsh; end

function kubectl_config_current; kubectl config current-context; end

function kubectl_config_delete_context; kubectl config delete-context "$argv[1]"; end

function kubectl_config_get_contexts; kubectl config get-contexts; end

function kubectl_config_rename_context; kubectl config rename-context "$argv[1]" "$argv[2]"; end

function kubectl_config_set_namespace; kubectl config set-context --namespace="$argv[1]"; end

function kubectl_config_use_namespace; kubectl config set-context --namespace="$argv[1]"; end

function kubectl_config_view; kubectl config view; end

function kubectl_context_switch; kubectl config use-context "$argv[1]"; end

function kubectl_cordon_all; kubectl get nodes -o name | xargs -r kubectl cordon; end

function kubectl_cordon_node; kubectl cordon "$argv[1]"; end

function kubectl_cp_from_pod; kubectl cp "$argv[1]:$argv[2]" "$argv[3]"; end

function kubectl_cp_local_to_pod; kubectl cp "$argv[1]" "$argv[2]:$argv[3]"; end

function kubectl_cp_pod_to_local; kubectl cp "$argv[1]:$argv[2]" "$argv[3]"; end

function kubectl_cp_to_pod; kubectl cp "$argv[1]" "$argv[2]:$argv[3]"; end

function kubectl_create_configmap; kubectl create configmap "$argv[1]" --from-file="$argv[2]"; end

function kubectl_create_cronjob; kubectl create cronjob "$argv[1]" --image="$argv[2]" --schedule="$argv[3]" -- "$argv[4]"; end

function kubectl_create_deployment; kubectl create deployment "$argv[1]" --image="$argv[2]"; end

function kubectl_create_ingress; kubectl create ingress "$argv[1]" --rule="$argv[2]/$argv[3]=$argv[4]:$argv[5]"; end

function kubectl_create_job; kubectl create job "$argv[1]" --image="$argv[2]" -- "$argv[3]"; end

function kubectl_create_namespace; kubectl create namespace "$argv[1]"; end

function kubectl_create_secret; kubectl create secret generic "$argv[1]" --from-file="$argv[2]"; end

function kubectl_create_service_clusterip; kubectl create service clusterip "$argv[1]" --tcp="$argv[2]:$argv[3]"; end

function kubectl_create_service_nodeport; kubectl create service nodeport "$argv[1]" --tcp="$argv[2]:$argv[3]"; end

function kubectl_delete_all_deployments; kubectl delete deployments --all -n "$argv[1]"; end

function kubectl_delete_pod_force; kubectl delete pod "$argv[1]" --force --grace-period=0; end

function kubectl_describe_deploy; kubectl describe deployment "$argv[1]"; end

function kubectl_describe_node; kubectl describe node "$argv[1]"; end

function kubectl_describe_pod_detail; kubectl describe pod "$argv[1]"; end

function kubectl_describe_svc; kubectl describe svc "$argv[1]"; end

function kubectl_drain_node; kubectl drain "$argv[1]" --ignore-daemonsets --delete-emptydir-data; end

function kubectl_exec_bash; kubectl exec -it "$argv[1]" -- /bin/bash; end

function kubectl_exec_bash_pod_container; kubectl exec -it "$argv[1]" -c "$argv[2]" -- /bin/bash; end

function kubectl_exec_command; kubectl exec -it "$argv[1]" -- $argv; end

function kubectl_exec_sh; kubectl exec -it "$argv[1]" -- /bin/sh; end

function kubectl_explain_recursive; kubectl explain "$argv[1]" --recursive; end

function kubectl_get_all_configmap; kubectl get configmap --all-namespaces; end

function kubectl_get_all_ingress; kubectl get ingress --all-namespaces; end

function kubectl_get_all_pv; kubectl get pv; end

function kubectl_get_all_pvc; kubectl get pvc --all-namespaces; end

function kubectl_get_all_secret; kubectl get secret --all-namespaces; end

function kubectl_get_all_storageclass; kubectl get sc; end

function kubectl_get_all_yaml; kubectl get all -o yaml; end

function kubectl_get_configmap_ns; kubectl get configmap -n "$argv[1]"; end

function kubectl_get_deploy_ns; kubectl get deployments -n "$argv[1]"; end

function kubectl_get_deploy_yaml; kubectl get deployment "$argv[1]" -o yaml; end

function kubectl_get_deployments_all; kubectl get deployments --all-namespaces; end

function kubectl_get_events; kubectl get events --sort-by=.lastTimestamp; end

function kubectl_get_events_ns; kubectl get events -n "$argv[1]" --sort-by=.lastTimestamp; end

function kubectl_get_events_warn; kubectl get events --field-selector type=Warning --sort-by=.lastTimestamp; end

function kubectl_get_events_warn_ns; kubectl get events -n "$argv[1]" --field-selector type=Warning --sort-by=.lastTimestamp; end

function kubectl_get_hpa_ns; kubectl get hpa -n "$argv[1]"; end

function kubectl_get_ingress_ns; kubectl get ingress -n "$argv[1]"; end

function kubectl_get_namespaces_all; kubectl get namespaces; end

function kubectl_get_nodes_detail; kubectl get nodes -o wide; end

function kubectl_get_pod_yaml; kubectl get pod "$argv[1]" -o yaml; end

function kubectl_get_pods_all; kubectl get pods --all-namespaces; end

function kubectl_get_pods_node; kubectl get pods -o wide --all-namespaces $argv; end

function kubectl_get_pods_ns; kubectl get pods -n "$argv[1]"; end

function kubectl_get_pods_watch; kubectl get pods -w; end

function kubectl_get_pods_wide; kubectl get pods -o wide; end

function kubectl_get_pvc_ns; kubectl get pvc -n "$argv[1]"; end

function kubectl_get_secret_ns; kubectl get secret -n "$argv[1]"; end

function kubectl_get_svc_all; kubectl get svc --all-namespaces; end

function kubectl_get_svc_ns; kubectl get svc -n "$argv[1]"; end

function kubectl_get_svc_yaml; kubectl get svc "$argv[1]" -o yaml; end

function kubectl_label_add; kubectl label "$argv[1]" "$argv[2]" "$argv[3]"; end

function kubectl_label_node; kubectl label node $argv; end

function kubectl_label_remove; kubectl label "$argv[1]" "$argv[2]" "$argv[3]"-; end

function kubectl_logs_all_containers; kubectl logs "$argv[1]" --all-containers; end

function kubectl_logs_multiple; kubectl logs "$argv[1]" --tail="(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" $argv[3..-1]; end

function kubectl_logs_pod_container; kubectl logs -c "$argv[2]" "$argv[1]"; end

function kubectl_logs_previous; kubectl logs --previous "$argv[1]"; end

function kubectl_logs_since; kubectl logs --since="(if set -q argv[2]; echo $argv[2]; else; echo 5m; end)" "$argv[1]"; end

function kubectl_logs_tail; kubectl logs --tail="(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -f "$argv[1]"; end

function kubectl_node_details; kubectl describe node "$argv[1]"; end

function kubectl_node_ready; kubectl get nodes | grep -c Ready; or true; end

function kubectl_plugin_list; kubectl plugin list; end

function kubectl_port_forward_all; kubectl port-forward "$argv[1]" "$argv[2]":"$argv[3]"; end

function kubectl_port_forward_deployment; kubectl port-forward deployment/"$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo 8080; end):(if set -q argv[3]; echo $argv[3]; else; echo 80; end)"; end

function kubectl_port_forward_pod; kubectl port-forward pod/"$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo 8080; end):(if set -q argv[3]; echo $argv[3]; else; echo 80; end)"; end

function kubectl_port_forward_svc; kubectl port-forward svc/"$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo 8080; end):(if set -q argv[3]; echo $argv[3]; else; echo 80; end)"; end

function kubectl_proxy_start; kubectl proxy; end

function kubectl_rollback; kubectl rollout undo "$argv[1]"; end

function kubectl_rollout_history; kubectl rollout history deployment/"$argv[1]"; end

function kubectl_rollout_pause; kubectl rollout pause deployment/"$argv[1]"; end

function kubectl_rollout_restart; kubectl rollout restart deployment/"$argv[1]"; end

function kubectl_rollout_resume; kubectl rollout resume deployment/"$argv[1]"; end

function kubectl_rollout_status; kubectl rollout status deployment/"$argv[1]"; end

function kubectl_rollout_undo; kubectl rollout undo deployment/"$argv[1]"; end

function kubectl_run_deployment; kubectl create deployment "$argv[1]" --image="$argv[2]"; end

function kubectl_run_pod; kubectl run "$argv[1]" --image="$argv[2]" -- $argv; end

function kubectl_scale_deployment; kubectl scale deployment "$argv[1]" --replicas="(if set -q argv[2]; echo $argv[2]; else; echo 1; end)"; end

function kubectl_scale_statefulset; kubectl scale statefulset "$argv[1]" --replicas="(if set -q argv[2]; echo $argv[2]; else; echo 1; end)"; end

function kubectl_scale_to_replicas; kubectl scale "$argv[1]" "$argv[2]" --replicas="$argv[3]"; end

function kubectl_scale_to_zero; kubectl scale deployment "$argv[1]" --replicas=0; end

function kubectl_set_env; kubectl set env deployment/"$argv[1]" "$argv[2]=$argv[3]"; end

function kubectl_set_image; kubectl set image deployment/"$argv[1]" "$argv[2]=$argv[3]"; end

function kubectl_set_resources; kubectl set resources deployment/"$argv[1]" --limits="$argv[2]" --requests="$argv[3]"; end

function kubectl_taint_node; kubectl taint node $argv; end

function kubectl_top_node_sort; kubectl top node --sort-by="$argv[1]"; end

function kubectl_top_nodes_all; kubectl top nodes; end

function kubectl_top_pod_ns; kubectl top pod -n "$argv[1]"; end

function kubectl_top_pods_all; kubectl top pods --all-namespaces; end

function kubectl_uncordon_all; kubectl get nodes -o name | xargs -r kubectl uncordon; end

function kubectl_uncordon_node; kubectl uncordon "$argv[1]"; end

function kubectl_wait_deploy_ready; kubectl wait --for=condition=Available deployment/"$argv[1]" --timeout="(if set -q argv[2]; echo $argv[2]; else; echo 300; end)s"; end

function kubectl_wait_node_ready; kubectl wait --for=condition=Ready node "$argv[1]" --timeout="(if set -q argv[2]; echo $argv[2]; else; echo 300; end)s"; end

function kubectl_wait_pod_ready; kubectl wait --for=condition=Ready pod "$argv[1]" --timeout="(if set -q argv[2]; echo $argv[2]; else; echo 300; end)s"; end

function kubectl_watch_all; kubectl get all -w; end

function kubectl_watch_pods; kubectl get pods -w; end

function lazydocker_open; lazydocker; end

function lazygit_open; lazygit; end

function license_apache; curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/apache2.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$argv[1]/" > LICENSE 2>/dev/null; or echo "unable to fetch"; end

function license_bsd; curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/bsd2.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$argv[1]/" > LICENSE 2>/dev/null; or echo "unable to fetch"; end

function license_gpl; curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/gpl3.txt" > LICENSE 2>/dev/null; or echo "unable to fetch"; end

function license_mit; curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/mit.txt" | sed "s/\[year\]/$(date +%Y)/;s/\[fullname\]/$argv[1]/" > LICENSE 2>/dev/null; or echo "unable to fetch"; end

function license_unlicense; curl -fsSL "https://raw.githubusercontent.com/licenses/license-templates/master/templates/unlicense.txt" > LICENSE 2>/dev/null; or echo "unable to fetch"; end

function list_archive; tar -tvf "$argv[1]" 2>/dev/null; or unzip -l "$argv[1]" 2>/dev/null; or 7z l "$argv[1]" 2>/dev/null; end

function load_average; uptime | awk -F'load average:' '{print "Load:" $argv[2]}'; end

function lsd_list; lsd -la $argv 2>/dev/null; or ls -la $argv; end

function lsd_tree; lsd --tree --depth="(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" "$argv[2]" 2>/dev/null; or tree -L "(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" "$argv[2]"; end

function mac_lookup; curl -fsSL "https://api.macvendors.com/$argv[1]" 2>/dev/null; end

function make_all; make 2>/dev/null; end

function make_build; make build 2>/dev/null; end

function make_clean; make clean 2>/dev/null; end

function make_distclean; make distclean 2>/dev/null; end

function make_install; make install 2>/dev/null; end

function make_test; make test 2>/dev/null; end

function memory_usage; free -h | awk '/^Mem/ {print "Memory: " $argv[3] " / " $argv[2]}'; end

function mkdt; mkdir -p "$argv[1]"; and cd "$argv[1]"; and pwd; end

function mongosh_list_dbs; mongosh --quiet --eval "db.adminCommand('listDatabases')" 2>/dev/null; or true; end

function mongosh_run; mongosh $argv 2>/dev/null; or true; end

function move_and_cd; mv "$argv[1]" "$argv[2]"; and cd "$argv[2]"; end

function mypy_check; python3 -m mypy $argv 2>/dev/null; end

function mysql_dump_db; mysqldump -u root -p "$argv[1]" > "$1.sql"; end

function mysql_import_db; mysql -u root -p "$argv[1]" < "$argv[2]"; end

function mysql_list_dbs; mysql -u root -p -e "SHOW DATABASES;" 2>/dev/null; or mysql -u root -e "SHOW DATABASES;"; end

function mysql_run_query; mysql -u root -p -e "$argv[1]"; end

function nethogs_monitor; sudo nethogs 2>/dev/null; or echo "nethogs needed"; end

function netstat_connections; ss -tupan 2>/dev/null; or netstat -tupan; end

function netstat_listening; ss -tlnp 2>/dev/null; or netstat -tlnp; end

function network_dig_all; dig ANY +noall +answer "$argv[1]" 2>/dev/null; end

function network_dig_short; dig +short "$argv[1]" 2>/dev/null; end

function network_dns_test

end

function network_http_compress; curl --compressed -sS "$argv[1]"; end

function network_http_cookie; curl -b "$argv[1]" -c "$argv[2]" -sS "$argv[3]"; end

function network_http_delete; curl -sS -X DELETE "$argv[1]"; end

function network_http_download; curl -fsSL -O "$argv[1]"; end

function network_http_download_as; curl -fsSL -o "$argv[2]" "$argv[1]"; end

function network_http_get; curl -sS "$argv[1]"; end

function network_http_head; curl -sI "$argv[1]"; end

function network_http_header; curl -H "$argv[1]" -sS "$argv[2]"; end

function network_http_options; curl -sX OPTIONS "$argv[1]"; end

function network_http_post; curl -sS -X POST -d "$argv[2]" "$argv[1]"; end

function network_http_put; curl -sS -X PUT -d "$argv[2]" "$argv[1]"; end

function network_http_rate; curl -s -w 'Speed: %{speed_download} Time: %{time_total}\n' -o /dev/null "$argv[1]"; end

function network_http_resume; curl -C - -O "$argv[1]"; end

function network_mtr_report; mtr -r -c "(if set -q argv[2]; echo $argv[2]; else; echo 10; end)" "$argv[1]" 2>/dev/null; or echo "mtr needed"; end

function network_ping_count; ping -c "(if set -q argv[2]; echo $argv[2]; else; echo 4; end)" "$argv[1]" 2>/dev/null; end

function network_ping_flood; ping -f -c "(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" "$argv[1]" 2>/dev/null; end

function network_scan_ports; nmap -p "(if set -q argv[2]; echo $argv[2]; else; echo 1-1000; end)" "$argv[1]" 2>/dev/null; or nc -zv "$argv[1]" "$argv[2]" 2>&1; end

function network_scan_subnet; nmap -sn "$argv[1]"/"(if set -q argv[2]; echo $argv[2]; else; echo 24; end)" 2>/dev/null; or echo "nmap needed"; end

function network_ssl_cert; echo | openssl s_client -connect "$argv[1]:(if set -q argv[2]; echo $argv[2]; else; echo 443; end)" -servername "$argv[1]" 2>/dev/null | openssl x509 -text -noout; end

function network_ssl_chain; openssl s_client -showcerts -connect "$argv[1]:(if set -q argv[2]; echo $argv[2]; else; echo 443; end)" -servername "$argv[1]" </dev/null 2>/dev/null; end

function network_tcpdump_host; sudo tcpdump -i any host "$argv[1]" -c "(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -nn; end

function network_tcpdump_interface; sudo tcpdump -i "$argv[1]" -c "(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -nn; end

function network_tcpdump_port; sudo tcpdump -i any port "$argv[1]" -c "(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -nn; end

function network_traceroute_path; traceroute -n "$argv[1]" 2>/dev/null; end

function network_whois_domain; whois "$argv[1]" 2>/dev/null; end

function node_check_syntax; node --check "$argv[1]"; end

function node_eval; node -e "$argv[1]"; end

function node_inspect; node inspect $argv; end

function node_print_v8; node -e "console.log(process.versions.v8)"; end

function node_print_versions; node -e "console.log(process.versions)"; end

function node_run_script; node $argv; end

function node_version; node --version; end

function npm_access_list; npm access list packages "$argv[1]"; end

function npm_audit_fix; npm audit fix 2>/dev/null; end

function npm_cache_clean; npm cache clean --force 2>/dev/null; end

function npm_cache_ls; npm cache ls; end

function npm_cache_verify; npm cache verify; end

function npm_ci_clean; npm ci 2>/dev/null; end

function npm_dedupe; npm dedupe 2>/dev/null; end

function npm_docs_pkg; npm docs "$argv[1]" 2>/dev/null; end

function npm_fund_pkg; npm fund "$argv[1]"; end

function npm_init_project; npm init -y; end

function npm_init_ts; npm init -y; and npm install typescript @types/node --save-dev; end

function npm_install_dev; npm install --save-dev "$argv[1]"; end

function npm_install_global; npm install -g "$argv[1]"; end

function npm_install_optional; npm install --save-optional "$argv[1]"; end

function npm_install_pkg; npm install "$argv[1]"; end

function npm_link_global; npm link; end

function npm_link_pkg; npm link "$argv[1]"; end

function npm_list_global; npm list -g --depth=0 2>/dev/null; end

function npm_list_outdated; npm outdated 2>/dev/null; end

function npm_ls_global; npm ls -g --depth=0; end

function npm_ls_top; npm ls --depth=0; end

function npm_org_list; npm org ls "$argv[1]"; end

function npm_pack_pkg; npm pack; end

function npm_prune; npm prune 2>/dev/null; end

function npm_publish_dryrun; npm publish --dry-run; end

function npm_publish_pkg; npm publish; end

function npm_rebuild_all; npm rebuild; end

function npm_run_build; npm run build; end

function npm_run_dev; npm run dev; end

function npm_run_lint; npm run lint; end

function npm_run_start; npm run start; end

function npm_run_test; npm run test; end

function npm_run_typecheck; npm run typecheck; end

function npm_search_pkg; npm search "$argv[1]"; end

function npm_stars_pkg; npm stars "$argv[1]"; end

function npm_team_list; npm team list "$argv[1]"; end

function npm_token_create; npm token create; end

function npm_token_delete; npm token delete "$argv[1]"; end

function npm_token_list; npm token list; end

function npm_uninstall_pkg; npm uninstall "$argv[1]"; end

function npm_unlink_global; npm unlink; end

function npm_unpublish_pkg; npm unpublish "$argv[1]"; end

function npm_update_all; npm update; end

function npm_update_pkg; npm update "$argv[1]"; end

function npm_version_bump; npm version "(if set -q argv[1]; echo $argv[1]; else; echo patch; end)" 2>/dev/null; end

function npm_view_pkg; npm view "$argv[1]"; end

function npm_whoami; npm whoami; end

function npm_why_dep; npm why "$argv[1]" 2>/dev/null; end

function nvm_alias_default; nvm alias default "$argv[1]"; end

function nvm_current_version; nvm current; end

function nvm_install; [ -f "$NVM_DIR/nvm.sh" ]; and . "$NVM_DIR/nvm.sh"; and nvm install "$argv[1]"; end

function nvm_install_lts; nvm install --lts; end

function nvm_list; [ -f "$NVM_DIR/nvm.sh" ]; and . "$NVM_DIR/nvm.sh"; and nvm ls; end

function nvm_list_local; nvm ls; end

function nvm_list_remote; nvm ls-remote; end

function nvm_uninstall_node; nvm uninstall "$argv[1]"; end

function nvm_use; [ -f "$NVM_DIR/nvm.sh" ]; and . "$NVM_DIR/nvm.sh"; and nvm use "$argv[1]"; end

function nvm_use_default; nvm use default; end

function nvm_which_node; nvm which "$argv[1]"; end

function nvtop_monitor; nvtop 2>/dev/null; or echo "nvtop needed"; end

function openssl_check_cert; openssl x509 -in "$argv[1]" -text -noout 2>/dev/null; end

function openssl_check_conn; echo | openssl s_client -connect "$argv[1]:(if set -q argv[2]; echo $argv[2]; else; echo 443; end)" -servername "$argv[1]" 2>/dev/null | openssl x509 -noout -dates; end

function openssl_check_expiry; openssl x509 -in "$argv[1]" -noout -dates 2>/dev/null; end

function openssl_check_key; openssl rsa -in "$argv[1]" -check 2>/dev/null; or openssl ec -in "$argv[1]" -check 2>/dev/null; end

function openssl_check_modulus; openssl rsa -modulus -in "$argv[1]" -noout | openssl md5; end

function openssl_gen_csr; openssl req -new -key "$argv[1]" -out "(if set -q argv[2]; echo $argv[2]; else; echo request.csr; end)"; end

function openssl_gen_rsa; openssl genrsa -out "(if set -q argv[1]; echo $argv[1]; else; echo private.pem; end)" "(if set -q argv[2]; echo $argv[2]; else; echo 2048; end)"; end

function openssl_rand_base64; openssl rand -base64 "(if set -q argv[1]; echo $argv[1]; else; echo 32; end)"; end

function openssl_rand_hex; openssl rand -hex "(if set -q argv[1]; echo $argv[1]; else; echo 32; end)"; end

function openssl_self_sign; openssl req -x509 -newkey rsa:4096 -keyout "(if set -q argv[1]; echo $argv[1]; else; echo key.pem; end)" -out "(if set -q argv[2]; echo $argv[2]; else; echo cert.pem; end)" -days "(if set -q argv[3]; echo $argv[3]; else; echo 365; end)" -nodes; end

function package_json_init; echo -e "{\n  \"name\": \"$argv[1]\",\n  \"version\": \"1.0.0\",\n  \"main\": \"index.js\",\n  \"scripts\": {},\n  \"license\": \"MIT\"\n}" > package.json; end

function pacman_clean_orphans; sudo pacman -Rns (pacman -Qtdq) 2>/dev/null; or echo "no orphans"; end

function pacman_list_explicit; pacman -Qe 2>/dev/null; end

function pacman_list_orphans; pacman -Qtd 2>/dev/null; or echo "no orphans"; end

function pacman_verify_pkg; pacman -Qk $argv 2>/dev/null; end

function pathuniq
$PATH
EOF
end

function pg_dump_db; pg_dump -U postgres "$argv[1]" > "$1.sql"; end

function pg_import_db; psql -U postgres -d "$argv[1]" -f "$argv[2]"; end

function pg_list_dbs; psql -U postgres -l 2>/dev/null; or true; end

function pg_run_query; psql -U postgres -c "$argv[1]"; end

function ping_test; ping -c "(if set -q argv[2]; echo $argv[2]; else; echo 4; end)" "$argv[1]"; end

function pip_cache_clean; pip cache purge 2>/dev/null; or true; end

function pip_check; pip check 2>/dev/null; or pip3 check; end

function pip_download_pkg; pip download $argv 2>/dev/null; or pip3 download $argv; end

function pip_freeze_reqs; pip freeze > requirements.txt 2>/dev/null; or pip3 freeze > requirements.txt; end

function pip_hash_pkg; pip hash "$argv[1]" 2>/dev/null; or pip3 hash "$argv[1]"; end

function pip_install_editable; pip install -e "$argv[1]" 2>/dev/null; or pip3 install -e "$argv[1]"; end

function pip_install_global; pip install $argv 2>/dev/null; or pip3 install $argv; end

function pip_install_pipx; pipx install "$argv[1]"; end

function pip_install_reqs; pip install -r requirements.txt 2>/dev/null; or pip3 install -r requirements.txt; end

function pip_install_reqs_dev; pip install -r requirements-dev.txt 2>/dev/null; or pip3 install -r requirements-dev.txt; end

function pip_install_user; pip install --user $argv 2>/dev/null; or pip3 install --user $argv; end

function pip_install_uv; pip install uv 2>/dev/null; or pip3 install uv; end

function pip_list_all; pip list 2>/dev/null; or pip3 list; end

function pip_list_outdated; pip list --outdated 2>/dev/null; or pip3 list --outdated; end

function pip_show_pkg; pip show "$argv[1]" 2>/dev/null; or pip3 show "$argv[1]"; end

function pip_uninstall_pkg; pip uninstall -y "$argv[1]" 2>/dev/null; or pip3 uninstall -y "$argv[1]"; end

function pip_upgrade_all; pip list --outdated --format=freeze 2>/dev/null | cut -d= -f1 | xargs -r pip install --upgrade; end

function pip_upgrade_pkg; pip install --upgrade "$argv[1]" 2>/dev/null; or pip3 install --upgrade "$argv[1]"; end

function pipx_list_all; pipx list; end

function pipx_run_bin; pipx run "$argv[1]"; end

function pipx_upgrade_all; pipx upgrade-all; end

function pkg_cache_clean

end

function pkg_clean_cache

end

function pkg_download_only

end

function pkg_download_source

end

function pkg_install_tool

end

function pkg_list_files

end

function pkg_list_installed

end

function pkg_list_outdated

end

function pkg_remove_tool

end

function pkg_search_query

end

function pkg_show_deps

end

function pkg_show_info

end

function pkg_update_all

end

function pkg_what_provides

end

function pnpm_add; pnpm add "$argv[1]"; end

function pnpm_add_dev; pnpm add -D "$argv[1]"; end

function pnpm_add_global; pnpm add -g "$argv[1]"; end

function pnpm_audit; pnpm audit; end

function pnpm_audit_fix; pnpm audit --fix; end

function pnpm_dedupe; pnpm dedupe 2>/dev/null; end

function pnpm_fetch; pnpm fetch; end

function pnpm_install; pnpm install; end

function pnpm_lint; pnpm run lint 2>/dev/null; end

function pnpm_ls_depth; pnpm ls --depth="$argv[1]"; end

function pnpm_outdated; pnpm outdated; end

function pnpm_pack; pnpm pack; end

function pnpm_publish; pnpm publish; end

function pnpm_rebuild; pnpm rebuild; end

function pnpm_remove; pnpm remove "$argv[1]"; end

function pnpm_run_build; pnpm build; end

function pnpm_run_dev; pnpm dev; end

function pnpm_run_lint; pnpm lint; end

function pnpm_run_test; pnpm test; end

function pnpm_store_path; pnpm store path; end

function pnpm_store_prune; pnpm store prune 2>/dev/null; end

function pnpm_store_status; pnpm store status; end

function pnpm_update; pnpm update; end

function poetry_add; poetry add "$argv[1]"; end

function poetry_add_dev; poetry add --dev "$argv[1]"; end

function poetry_build; poetry build; end

function poetry_export_reqs; poetry export -f requirements.txt -o requirements.txt; end

function poetry_install; poetry install; end

function poetry_publish; poetry publish; end

function poetry_run_dev; poetry run python $argv; end

function poetry_shell; poetry shell; end

function poetry_update_lock; poetry update; end

function prettier_init; echo -e "{\n  \"semi\": true,\n  \"singleQuote\": true,\n  \"tabWidth\": 2,\n  \"trailingComma\": \"all\"\n}" > .prettierrc; end

function process_by_name; pgrep -af "$argv[1]" 2>/dev/null; or ps aux | grep "$argv[1]"; end

function process_by_user; ps aux | grep "^$argv[1]" 2>/dev/null; end

function process_children; ps --ppid "$argv[1]" -o pid,comm --no-headers 2>/dev/null; end

function process_cputime; ps -p "$argv[1]" -o pid,%cpu,%mem,etime,comm --no-headers 2>/dev/null; end

function process_dump_stack; cat "/proc/$argv[1]/stack" 2>/dev/null; or echo "no stack"; end

function process_env_vars; cat "/proc/$argv[1]/environ" 2>/dev/null | tr '\0' '\n'; or echo "no access"; end

function process_fds; lsof -p "$argv[1]" 2>/dev/null; or echo "lsof needed"; end

function process_hung; ps aux | awk '$argv[8] ~ /D/ {print}'; end

function process_kill_all_user; sudo killall -u "$argv[1]" 2>/dev/null; or echo "cannot kill all"; end

function process_kill_by_name; pkill -f "$argv[1]" 2>/dev/null; or killall "$argv[1]" 2>/dev/null; end

function process_kill_by_pid; kill -15 "$argv[1]" 2>/dev/null; and echo "SIGTERM sent to $argv[1]"; or echo "failed"; end

function process_kill_force; kill -9 "$argv[1]" 2>/dev/null; end

function process_list_all; ps aux; end

function process_nice_start; nice -n "(if set -q argv[1]; echo $argv[1]; else; echo 10; end)" $argv[2..-1]; end

function process_priority; chrt -p "$argv[1]" 2>/dev/null; or echo "chrt needed"; end

function process_renice; sudo renice -n "$argv[1]" -p "$argv[2]"; end

function process_threads; ps -eLf | grep "$argv[1]"; end

function process_tree; ps auxf; end

function process_tree_pid; ps -p "$argv[1]" --forest; end

function process_zombies; ps aux | awk '$argv[8] ~ /Z/ {print}'; end

function procs_process_list; procs 2>/dev/null; or ps aux; end

function pyenv_global; pyenv global "$argv[1]"; end

function pyenv_install_python; pyenv install "$argv[1]"; end

function pyenv_local; pyenv local "$argv[1]"; end

function pyenv_uninstall_python; pyenv uninstall "$argv[1]"; end

function pyenv_versions; pyenv versions; end

function pyenv_virtualenv_activate; pyenv activate "$argv[1]"; end

function pyenv_virtualenv_create; pyenv virtualenv "$argv[1]" "$argv[2]"; end

function pyenv_virtualenv_deactivate; pyenv deactivate; end

function pyright_check; python3 -m pyright $argv 2>/dev/null; or npx pyright $argv; end

function pytest_coverage; python3 -m pytest --cov $argv 2>/dev/null; end

function pytest_run; python3 -m pytest $argv 2>/dev/null; end

function pytest_run_coverage_html; python3 -m pytest --cov --cov-report=html $argv; end

function pytest_run_failfast; python3 -m pytest -x $argv; end

function pytest_run_last_failed; python3 -m pytest --lf $argv; end

function pytest_run_parallel; python3 -m pytest -n auto $argv; end

function pytest_run_verbose; python3 -m pytest -v $argv; end

function python_find; which python3; or which python; end

function python_version; python3 --version; end

function quick_cd; cd $argv; and ls; end

function quiet_run; $argv >/dev/null 2>&1; end

function random_number; shuf -i "(if set -q argv[1]; echo $argv[1]; else; echo 1; end)"-"(if set -q argv[2]; echo $argv[2]; else; echo 100; end)" -n 1 2>/dev/null; or echo (math "RANDOM % (if set -q argv[2]; echo $argv[2]; else; echo 100; end) + (if set -q argv[1]; echo $argv[1]; else; echo 1; end)"); end

function random_string; openssl rand -base64 "(if set -q argv[1]; echo $argv[1]; else; echo 16; end)" 2>/dev/null; end

function rar_decompress; unrar x "$argv[1]"; end

function rar_list; unrar l "$argv[1]"; end

function recent; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type f -mtime -1 -print 2>/dev/null | head -100; end

function recent_all; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -ctime -1 -print 2>/dev/null | head -100; end

function recent_dirs; find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d -mtime -1 -print 2>/dev/null | head -50; end

function redis_flush; redis-cli FLUSHALL; end

function redis_get; redis-cli GET "$argv[1]"; end

function redis_info; redis-cli INFO "$argv[1]"; end

function redis_keys; redis-cli KEYS "$argv[1]"; end

function redis_monitor; redis-cli MONITOR; end

function redis_ping; redis-cli ping; end

function redis_set; redis-cli SET "$argv[1]" "$argv[2]"; end

function rename_extension

end

function repeat_command

end

function retry_command

end

function rg_search; rg "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function rg_search_context; rg -C "(if set -q argv[3]; echo $argv[3]; else; echo 2; end)" "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or grep -rn -C "(if set -q argv[3]; echo $argv[3]; else; echo 2; end)" "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function rg_search_files; rg -l "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or grep -rl "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function rg_search_word; rg -w "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or grep -rnw "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function rpm_info_pkg; rpm -qi $argv; end

function rpm_list_files; rpm -ql $argv; end

function rpm_list_pkgs; rpm -qa; end

function rpm_verify_pkg; rpm -V $argv; end

function ruff_check; python3 -m ruff check $argv; end

function ruff_fix; python3 -m ruff check --fix $argv; end

function ruff_format; python3 -m ruff format $argv; end

function run_with_timeout; timeout "(if set -q argv[1]; echo $argv[1]; else; echo 5; end)" $argv[2..-1]; end

function safe_dl

end

function scan_secrets; git -C (if set -q argv[1]; echo $argv[1]; else; echo .; end) grep -In -e 'BEGIN.*PRIVATE KEY' -e 'BEGIN CERTIFICATE' -e 'ghp_[0-9a-zA-Z]\{36\}' -e 'gho_[0-9a-zA-Z]\{36\}' -e 'AKIA[0-9A-Z]\{16\}' -e 'sk-[0-9a-zA-Z]\{32,\}' 2>/dev/null; or echo "no secrets detected in "(pwd); end

function screen_session_attach; screen -r "$argv[1]"; end

function screen_session_create; screen -S "$argv[1]"; end

function screen_session_detach; screen -d "$argv[1]"; end

function screen_session_kill; screen -X -S "$argv[1]" kill; end

function screen_session_list; screen -ls; end

function screen_session_reattach; screen -dr "$argv[1]"; end

function sd_replace; sd "$argv[1]" "$argv[2]" "$argv[3]" 2>/dev/null; or sed -i "s/$argv[1]/$argv[2]/g" "$argv[3]"; end

function sed_delete; sed -i "$argv[1]d" "$argv[2]"; end

function sed_replace; sed -i "s/$argv[1]/$argv[2]/g" "$argv[3]"; end

function shell_version

end

function show_aliases; alias | sort; end

function show_banner; printf "%s\n" "dotfiles: $DOTFILES_DIR mode: $DOTFILES_MODE shell: $SHELL"; end

function show_battery_status

end

function show_calendar; cal $argv[1]; end

function show_cpu_info; lscpu 2>/dev/null; or sysctl -n machdep.cpu.brand_string; end

function show_date; date '+%F %T %Z'; end

function show_date_time; date '+%A, %B %d, %Y %T %Z'; end

function show_date_utc; date -u '+%F %T UTC'; end

function show_datetime; date '+%F %T'; end

function show_disk_usage; df -h; end

function show_docker_status; docker info --format '{{.ServerVersion}}' 2>/dev/null; or echo "docker not running"; end

function show_env; env | sort; end

function show_functions; declare -f | grep -E '^[a-z_][a-z0-9_]* \(\)' | cut -d' ' -f1 | sort 2>/dev/null; or typeset -f | grep -E '^[a-z_]' | cut -d' ' -f1 | sort; end

function show_git_config; git config --list --global 2>/dev/null | sort; end

function show_host; hostname; end

function show_ip; ip -br addr show 2>/dev/null; or ifconfig; end

function show_kernel; uname -r; end

function show_kubectl_version; kubectl version --client --short 2>/dev/null; or echo "kubectl not found"; end

function show_last; last -10; end

function show_os; uname -a; end

function show_owner; ls -la "$argv[1]" | awk '{print $argv[3], $argv[4], $NF}'; end

function show_path; printf "%s\n" "$PATH" | tr ':' '\n'; end

function show_permissions; ls -la "$argv[1]" | awk '{print $argv[1], $NF}'; end

function show_ram_usage; free -h; end

function show_ssh_keys; ssh-add -l 2>/dev/null; or echo "no keys loaded"; end

function show_timezone; cat /etc/timezone 2>/dev/null; or echo "$TZ"; end

function show_uptime; uptime; end

function show_users; who; end

function show_weather; curl -fsSL wttr.in/$argv[1] 2>/dev/null; end

function shred_file

end

function snap_disable_service; sudo snap disable "$argv[1]"; end

function snap_enable_service; sudo snap enable "$argv[1]"; end

function snap_info_app; snap info "$argv[1]"; end

function snap_install_app; sudo snap install "$argv[1]"; end

function snap_list_apps; snap list 2>/dev/null; end

function snap_list_services; snap services; end

function snap_logs_service; snap logs "$argv[1]"; end

function snap_remove_app; sudo snap remove "$argv[1]"; end

function snap_restart_service; sudo snap restart "$argv[1]"; end

function snap_search_app; snap find "$argv[1]"; end

function snap_start_service; sudo snap start "$argv[1]"; end

function snap_stop_service; sudo snap stop "$argv[1]"; end

function snap_update_all; sudo snap refresh 2>/dev/null; end

function sort_by_name; ls -l $argv; end

function sort_by_size; ls -lS $argv; end

function sort_by_time; ls -lt $argv; end

function speedtest_run; curl -fsSL https://speedtest.net 2>/dev/null; or echo "use: speedtest-cli"; end

function sqlite_dump; sqlite3 "$argv[1]" ".dump"; end

function sqlite_query; sqlite3 "$argv[1]" "$argv[2]"; end

function sqlite_schema; sqlite3 "$argv[1]" ".schema"; end

function sqlite_tables; sqlite3 "$argv[1]" ".tables"; end

function ssh_agent_add_key; ssh-add "$argv[1]"; end

function ssh_agent_list; ssh-add -l; end

function ssh_agent_load_default; ssh-add 2>/dev/null; or true; end

function ssh_agent_remove_all; ssh-add -D; end

function ssh_agent_remove_key; ssh-add -d "$argv[1]"; end

function ssh_agent_status; ssh-add -l 2>/dev/null; or echo "ssh agent has no keys or not running"; end

function ssh_config_edit; $EDITOR ~/.ssh/config; end

function ssh_config_host; cat ~/.ssh/config 2>/dev/null | grep -i "host " | awk '{print $argv[2]}'; end

function ssh_config_validate; ssh -G "$argv[1]" 2>/dev/null | grep -i "^hostname\|^user\|^port\|^identityfile"; end

function ssh_copy_id_port; ssh-copy-id -p "$argv[2]" "$argv[1]" 2>/dev/null; end

function ssh_escape_sequences; echo "~. - terminate; ~^Z - suspend; ~# - list fwd; ~& - bg; ~? - help"; end

function ssh_key_add; eval "$(ssh-agent -s)" >/dev/null 2>&1; and ssh-add $argv; end

function ssh_key_change_pass; ssh-keygen -p -f "$argv[1]"; end

function ssh_key_fingerprint; ssh-keygen -lf "$argv[1]"; end

function ssh_key_fingerprint_md5; ssh-keygen -lf "$argv[1]" -E md5; end

function ssh_key_fingerprint_sha256; ssh-keygen -lf "$argv[1]" -E sha256; end

function ssh_key_from_remote; ssh-keyscan -H "$argv[1]" >> ~/.ssh/known_hosts 2>/dev/null; end

function ssh_key_visual; ssh-keygen -lvf "$argv[1]"; end

function ssh_keygen_ecdsa; ssh-keygen -t ecdsa -b 521 $argv; end

function ssh_keygen_ed25519; ssh-keygen -t ed25519 -a 100 $argv; end

function ssh_keygen_ed25519_sk; ssh-keygen -t ed25519-sk $argv; end

function ssh_keygen_rsa; ssh-keygen -t rsa -b 4096 $argv; end

function ssh_known_hosts_list; cat ~/.ssh/known_hosts | cut -d' ' -f1 | sort -u; end

function ssh_known_hosts_remove; ssh-keygen -R "$argv[1]"; end

function ssh_mosh_connect; mosh "$argv[1]" 2>/dev/null; or echo "mosh needed"; end

function ssh_proxy_command; ssh -o ProxyCommand="ssh -W %h:%p $argv[1]" "$argv[2]"; end

function ssh_scp_copy; scp "$argv[1]" "$argv[2]"; end

function ssh_scp_recursive; scp -r "$argv[1]" "$argv[2]"; end

function ssh_sftp_get; sftp "$argv[1]:$argv[2]" "$argv[3]"; end

function ssh_sftp_put; echo "put $argv[2]" | sftp "$argv[1]" 2>/dev/null; end

function ssh_test_conn; ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no "$argv[1]" exit 2>/dev/null; and echo "ok"; or echo "failed"; end

function ssh_tunnel_dynamic; ssh -D "$argv[1]" "$argv[2]"; end

function ssh_tunnel_jump; ssh -J "$argv[1]" "$argv[2]"; end

function ssh_tunnel_local; ssh -L "$argv[1]:localhost:$argv[2]" "$argv[3]"; end

function ssh_tunnel_remote; ssh -R "$argv[1]:localhost:$argv[2]" "$argv[3]"; end

function ssl_check; echo | openssl s_client -connect "$argv[1]:(if set -q argv[2]; echo $argv[2]; else; echo 443; end)" -servername "$argv[1]" 2>/dev/null | openssl x509 -noout -dates; end

function sudocheck; sudo -n true 2>/dev/null; and echo "sudo active"; or echo "sudo expired"; end

function sudotime; sudo -v; end

function swap_usage; free -h | awk '/^Swap/ {if ($argv[2] != "0") print "Swap: " $argv[3] " / " $argv[2]; else print "Swap: none";}'; end

function symlink_force; ln -sf "$argv[1]" "$argv[2]"; end

function sysinfo_quick; echo "$(distribution) $(kernel_version) $(memory_usage) $(disk_usage_summary)"; end

function sysinfo_summary; echo "OS: $(distribution) $(distro_version) | Kernel: $(kernel_version) | Shell: $(shell_version) | Uptime: $(uptime_pretty)"; end

function systemctl_add_wants; sudo systemctl add-wants "$argv[1]" "$argv[2]" 2>/dev/null; or return 0; end

function systemctl_analyze_blame; systemd-analyze blame 2>/dev/null; or return 0; end

function systemctl_analyze_time; systemd-analyze time 2>/dev/null; or return 0; end

function systemctl_cat_unit; systemctl cat "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_daemon_reload; sudo systemctl daemon-reload 2>/dev/null; or return 0; end

function systemctl_disable_service; sudo systemctl disable "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_edit_override; sudo systemctl edit "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_enable_service; sudo systemctl enable "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_hibernate; sudo systemctl hibernate 2>/dev/null; or return 0; end

function systemctl_hybrid_sleep; sudo systemctl hybrid-sleep 2>/dev/null; or return 0; end

function systemctl_is_active; systemctl is-active "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_is_enabled; systemctl is-enabled "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_list_deps; systemctl list-dependencies "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_list_enabled; systemctl list-unit-files --state=enabled 2>/dev/null; or return 0; end

function systemctl_list_failed; systemctl list-units --failed 2>/dev/null; or return 0; end

function systemctl_list_machines; systemctl list-machines 2>/dev/null; or return 0; end

function systemctl_list_sockets; systemctl list-sockets 2>/dev/null; or return 0; end

function systemctl_list_timers; systemctl list-timers --all 2>/dev/null; or return 0; end

function systemctl_list_units_by_type; systemctl list-units --type="$argv[1]" --all 2>/dev/null; or return 0; end

function systemctl_mask_unit; sudo systemctl mask "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_poweroff; sudo systemctl poweroff 2>/dev/null; or return 0; end

function systemctl_preset_service; sudo systemctl preset "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_reboot; sudo systemctl reboot 2>/dev/null; or return 0; end

function systemctl_reenable_service; sudo systemctl reenable "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_reload_service; sudo systemctl reload "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_restart_service; sudo systemctl restart "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_show_unit; systemctl show "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_start_service; sudo systemctl start "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_status_all; systemctl list-units 2>/dev/null; or return 0; end

function systemctl_stop_service; sudo systemctl stop "$argv[1]" 2>/dev/null; or return 0; end

function systemctl_suspend; sudo systemctl suspend 2>/dev/null; or return 0; end

function systemctl_unmask_unit; sudo systemctl unmask "$argv[1]" 2>/dev/null; or return 0; end

function tar_compress; tar -czf "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1].tar.gz; end)" "$argv[1]"; end

function tar_compress_bz2; tar -cjf "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1].tar.bz2; end)" "$argv[1]"; end

function tar_compress_xz; tar -cJf "(if set -q argv[2]; echo $argv[2]; else; echo $argv[1].tar.xz; end)" "$argv[1]"; end

function tar_decompress; tar -xzf "$argv[1]"; end

function tar_decompress_bz2; tar -xjf "$argv[1]"; end

function tar_decompress_xz; tar -xJf "$argv[1]"; end

function tar_list; tar -tzf "$argv[1]"; end

function terraform_apply_auto; terraform apply -auto-approve; end

function terraform_apply_target; terraform apply -target="$argv[1]"; end

function terraform_console_expr; echo $argv[1] | terraform console; end

function terraform_console_tool; terraform console; end

function terraform_destroy_auto; terraform destroy -auto-approve; end

function terraform_fmt_recursive; terraform fmt -recursive; end

function terraform_get_modules; terraform get -update; end

function terraform_graph_deps; terraform graph | dot -Tpng > graph.png; end

function terraform_import_resource; terraform import "$argv[1]" "$argv[2]"; end

function terraform_init_re; terraform init -reconfigure; end

function terraform_lock_hcl; terraform providers lock; end

function terraform_output_raw; terraform output -json; end

function terraform_plan_destroy; terraform plan -destroy -out=tfplan; end

function terraform_plan_out; terraform plan -out=tfplan; end

function terraform_providers_list; terraform providers; end

function terraform_refresh_state; terraform refresh; end

function terraform_state_list; terraform state list; end

function terraform_state_mv; terraform state mv "$argv[1]" "$argv[2]"; end

function terraform_state_pull; terraform state pull; end

function terraform_state_push; terraform state push "$argv[1]"; end

function terraform_state_rm; terraform state rm "$argv[1]"; end

function terraform_state_show; terraform state show "$argv[1]"; end

function terraform_taint_resource; terraform taint "$argv[1]"; end

function terraform_untaint_resource; terraform untaint "$argv[1]"; end

function terraform_validate_all; terraform validate; and echo "valid"; end

function terraform_validate_quiet; terraform validate -no-color >/dev/null 2>&1; and echo "valid"; or echo "invalid"; end

function terraform_version_check; terraform version; end

function terraform_workspace_delete; terraform workspace delete "$argv[1]"; end

function terraform_workspace_list; terraform workspace list; end

function terraform_workspace_new; terraform workspace new "$argv[1]"; end

function terraform_workspace_select; terraform workspace select "$argv[1]"; end

function terraform_workspace_show; terraform workspace show; end

function text_capitalize; sed 's/\b\(.\)/\u\1/g' "$argv[1]"; end

function text_count_chars; wc -m < "$argv[1]"; end

function text_count_freq; tr ' ' '\n' < "$argv[1]" | sort | uniq -c | sort -rn | head -"(if set -q argv[2]; echo $argv[2]; else; echo 20; end)"; end

function text_count_lines; wc -l < "$argv[1]"; end

function text_count_words; wc -w < "$argv[1]"; end

function text_csv_to_json; python3 -c "import sys,csv,json; print(json.dumps(list(csv.DictReader(open(sys.argv[1]))),indent=2))" "$argv[1]"; end

function text_delete_empty; sed -i '/^$/d' "$argv[1]"; end

function text_delete_lines; sed -i "$2,$3d" "$argv[1]"; end

function text_delete_matching; sed -i "/$argv[1]/d" "$argv[2]"; end

function text_diff_chars; diff -u "$argv[1]" "$argv[2]" | colordiff 2>/dev/null; or diff -u "$argv[1]" "$argv[2]"; end

function text_diff_side; sdiff -w"(if set -q argv[3]; echo $argv[3]; else; echo 120; end)" "$argv[1]" "$argv[2]"; end

function text_diff_words; git diff --word-diff --no-index "$argv[1]" "$argv[2]" 2>/dev/null; end

function text_extract_between; sed -n "/$argv[1]/,/$argv[2]/p" "$argv[3]"; end

function text_extract_column; awk "{print \$$1}" "$argv[2]"; end

function text_extract_emails; grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$argv[1]"; end

function text_extract_field; cut -d"(if set -q argv[3]; echo $argv[3]; else; echo  ; end)" -f"$argv[1]" "$argv[2]"; end

function text_extract_ips; grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' "$argv[1]"; end

function text_extract_urls; grep -oP 'https?://[^\s<>"'\'']+' "$argv[1]"; end

function text_html_extract; python3 -c "import sys; from html.parser import HTMLParser; p=HTMLParser(); p.feed(open(sys.argv[1]).read())" 2>/dev/null; or echo "python needed"; end

function text_html_to_text; lynx -dump "$argv[1]" 2>/dev/null; or w3m -dump "$argv[1]" 2>/dev/null; or echo "lynx or w3m needed"; end

function text_indent_lines; sed "s/^/$argv[1]/" "$argv[2]"; end

function text_join_lines; paste -sd"$argv[1]" "$argv[2]"; end

function text_json_flatten; python3 -c "import sys,json; print(json.dumps(json.load(open(sys.argv[1])),indent=None,separators=(',',':')))" "$argv[1]"; end

function text_json_format; python3 -m json.tool "$argv[1]"; end

function text_json_minify; python3 -c "import sys,json; print(json.dumps(json.load(open(sys.argv[1])),separators=(',',':')))" "$argv[1]"; end

function text_json_query
    python3 -c "
import sys,json
def get(d,p):
 for k in p.strip('/').split('/'):
  if not k: continue
  try: d=d[int(k)]
  except ValueError: d=d[k]
 return d
d=json.load(open(sys.argv[1]))
print(json.dumps(get(d,sys.argv[2])))
" $argv 2>/dev/null; or python3 -c "
import sys,json
def get(d,p):
 for k in p.strip('/').split('/'):
  if not k: continue
  try: d=d[int(k)]
  except ValueError: d=d[k]
 return d
d=json.load(sys.stdin)
print(json.dumps(get(d,'$argv[1]')))
" $argv[1] 2>/dev/null
end

function text_lowercase; tr '[:upper:]' '[:lower:]' < "$argv[1]"; end

function text_markdown_render; python3 -c "import sys,markdown,html; print(html.escape(markdown.markdown(open(sys.argv[1]).read())))" "$argv[1]" 2>/dev/null; or echo "markdown module needed"; end

function text_merge_files; cat $argv > $argv[-1]; end

function text_patch_create; diff -u "$argv[1]" "$argv[2]" > "(if set -q argv[3]; echo $argv[3]; else; echo patch.diff; end)"; end

function text_replace_all; sed -i "s/$argv[1]/$argv[2]/g" "(if set -q argv[3]; echo $argv[3]; else; echo *; end)"; end

function text_replace_first; sed -i "s/$argv[1]/$argv[2]/" "$argv[3]"; end

function text_replace_line; sed -i "$4s/$argv[1]/$argv[2]/$argv[3]" "$argv[5]"; end

function text_replace_regex; sed -i -E "s/$argv[1]/$argv[2]/g" "$argv[3]"; end

function text_reverse_chars; rev "$argv[1]"; end

function text_rot13; tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$argv[1]"; end

function text_search; grep -n "$argv[1]" "$argv[2]"; end

function text_search_binary; grep -a "$argv[1]" "$argv[2]"; end

function text_search_case; grep -in "$argv[1]" "$argv[2]"; end

function text_search_context; grep -C "(if set -q argv[3]; echo $argv[3]; else; echo 2; end)" "$argv[1]" "$argv[2]"; end

function text_search_count; grep -c "$argv[1]" "$argv[2]"; end

function text_search_exclude; grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" --exclude="$argv[3]" 2>/dev/null; end

function text_search_exclude_dir; grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" --exclude-dir="$argv[3]" 2>/dev/null; end

function text_search_file_types; grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" --include="*.$argv[3]" 2>/dev/null; end

function text_search_files; grep -rl "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function text_search_fixed; grep -F "$argv[1]" "$argv[2]"; end

function text_search_inverse; grep -v "$argv[1]" "$argv[2]"; end

function text_search_only_match; grep -o "$argv[1]" "$argv[2]"; end

function text_search_recursive; grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)"; end

function text_search_recursive_full; grep -rn "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" --include="*.$argv[3]" 2>/dev/null; end

function text_search_regex; grep -E "$argv[1]" "$argv[2]"; end

function text_search_word; grep -wn "$argv[1]" "$argv[2]"; end

function text_sort_alpha; sort "$argv[1]"; end

function text_sort_numeric; sort -n "$argv[1]"; end

function text_sort_reverse; sort -r "$argv[1]"; end

function text_sort_unique; sort -u "$argv[1]"; end

function text_split_on_delim; awk -F"$argv[1]" '{for(i=1;i<=NF;i++) print $i}' "$argv[2]"; end

function text_unindent_lines; sed "s/^$argv[1]//" "$argv[2]"; end

function text_uppercase; tr '[:lower:]' '[:upper:]' < "$argv[1]"; end

function text_wrap_lines; fold -w "(if set -q argv[1]; echo $argv[1]; else; echo 80; end)" "$argv[2]"; end

function text_xml_pretty; xmllint --format "$argv[1]" 2>/dev/null; or echo "xmllint needed"; end

function text_xml_query; xmllint --xpath "$argv[1]" "$argv[2]" 2>/dev/null; or echo "xmllint needed"; end

function text_xml_validate; xmllint --valid "$argv[1]" 2>/dev/null; and echo "valid"; or echo "invalid or xmllint needed"; end

function text_yaml_format; python3 -c "import sys,yaml; print(yaml.dump(yaml.safe_load(open(sys.argv[1]))))" "$argv[1]" 2>/dev/null; end

function text_yaml_to_json; python3 -c "import sys,yaml,json; print(json.dumps(yaml.safe_load(open(sys.argv[1])),indent=2))" "$argv[1]" 2>/dev/null; end

function text_yaml_validate; python3 -c "import sys,yaml; yaml.safe_load(open(sys.argv[1])); print('valid')" "$argv[1]" 2>/dev/null; or echo "invalid"; end

function time_convert; python3 -c "s=$argv[1]; h=s//3600; m=(s%3600)//60; s=s%60; print(f'{h}h {m}m {s}s')" 2>/dev/null; end

function time_countdown

end

function time_date_add; date -d "+$argv[1] $argv[2]" '+%F %T'; end

function time_date_diff; set -l _s1 (date -d $argv[1] +%s 2>/dev/null); set -l _s2 (date -d $argv[2] +%s 2>/dev/null); echo (math "($_s2 - $_s1) / 86400")" days"; end

function time_date_epoch; date +%s; end

function time_date_from_epoch; date -d "@$argv[1]" '+%F %T'; end

function time_date_from_string; date -d "$argv[1]" '+%F %T'; end

function time_date_iso; date -u +%Y-%m-%dT%H:%M:%SZ; end

function time_date_last; date -d "-1 $argv[1]" '+%F %T'; end

function time_date_next; date -d "$argv[1]" '+%F %T'; end

function time_date_now; date '+%F %T %Z'; end

function time_date_sub; date -d "-$argv[1] $argv[2]" '+%F %T'; end

function time_date_utc; date -u '+%F %T UTC'; end

function time_sleep_random; sleep (shuf -i (if set -q argv[1]; echo $argv[1]; else; echo 1; end)-(if set -q argv[2]; echo $argv[2]; else; echo 10; end) -n 1); end

function time_stopwatch; set -l _s (date +%s); echo "started"; $argv; echo "elapsed: "(math (date +%s) - $_s)"s"; end

function time_timer_check; if test -f /tmp/timer_start; echo "elapsed: "(math (date +%s) - (cat /tmp/timer_start))"s"; else; echo "no timer"; end; end

function time_timer_clear; rm -f /tmp/timer_start; end

function time_timer_set; echo "$(date +%s)" > /tmp/timer_start; end

function time_wait_file

end

function time_wait_port

end

function time_wait_process

end

function time_wait_url

end

function timer; set -l start (date +%s); $argv; set -l code $status; set -l end (date +%s); echo "elapsed: "(math "$end - $start")"s"; return $code; end

function tmux_attach_session; tmux attach -t "$argv[1]"; end

function tmux_capture_pane; tmux capture-pane -t "$argv[1]" -p; end

function tmux_choose_tree; tmux choose-tree; end

function tmux_detach_client; tmux detach; end

function tmux_kill_session; tmux kill-session -t "$argv[1]"; end

function tmux_kill_window; tmux kill-window; end

function tmux_list_buffers; tmux list-buffers; end

function tmux_list_clients; tmux list-clients; end

function tmux_list_sessions; tmux ls; end

function tmux_new_session; tmux new -s "$argv[1]"; end

function tmux_new_window; tmux new-window -n "$argv[1]"; end

function tmux_next_window; tmux next-window; end

function tmux_prev_window; tmux previous-window; end

function tmux_rename_session; tmux rename-session "$argv[1]"; end

function tmux_rename_window; tmux rename-window "$argv[1]"; end

function tmux_resize_pane; tmux resize-pane -D "$argv[1]"; end

function tmux_rotate_panes; tmux rotate-window; end

function tmux_save_buffer; tmux save-buffer -b "$argv[1]" "(if set -q argv[2]; echo $argv[2]; else; echo /tmp/tmux-buffer; end)"; end

function tmux_send_keys; tmux send-keys -t "$argv[1]" "$argv[2]" Enter; end

function tmux_set_option; tmux set-option -g "$argv[1]" "$argv[2]"; end

function tmux_show_options; tmux show-options -g; end

function tmux_split_horizontal; tmux split-window -h; end

function tmux_split_vertical; tmux split-window -v; end

function tmux_swap_pane; tmux swap-pane -D; end

function todo_add; echo "TODO: $argv[1]" >> "(if set -q argv[2]; echo $argv[2]; else; echo TODO.md; end)"; end

function todo_by_type

end

function todo_count; grep -rn "TODO\|FIXME\|HACK\|XXX" "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" --include="*.(if set -q argv[2]; echo $argv[2]; else; echo *; end)" 2>/dev/null | wc -l; end

function todo_list; grep -rn "TODO\|FIXME\|HACK\|XXX" "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" --include="*.(if set -q argv[2]; echo $argv[2]; else; echo *; end)" 2>/dev/null; end

function todo_show_file; cat "(if set -q argv[1]; echo $argv[1]; else; echo TODO.md; end)" 2>/dev/null; or echo "no TODO.md"; end

function touch_all

end

function traceroute_path; traceroute "$argv[1]" 2>/dev/null; end

function trash_empty; rm -rf "$HOME/.local/share/Trash/files"/* "$HOME/.local/share/Trash/info"/* 2>/dev/null; echo "trash cleared"; end

function trash_list; ls -la "$HOME/.local/share/Trash/files" 2>/dev/null; or echo "trash is empty"; end

function trash_put

end

function trash_restore; set -l _f "$argv[1]"; [ -z "$_f" ]; and { echo "usage: trash_restore <file>"; return 1; }; set -l _src "$HOME/.local/share/Trash/files/$_f"; [ -f "$_src" ]; and mv "$_src" "./$_f"; and echo "restored: $_f"; or echo "not found in trash"; end

function tree_dirs_only; tree -d -C "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -type d -print | sed 's|[^/]*/||---|g'; end

function tree_html; tree -H "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null > /tmp/tree.html; and echo "written: /tmp/tree.html"; end

function tree_json; tree -J "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or echo "tree not installed"; end

function tree_level; tree -L "(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" -C "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[2]; echo $argv[2]; else; echo .; end)" -maxdepth "(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" -print | sed 's|[^/]*/||---|g'; end

function tree_show; tree -C "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -print | sed 's|[^/]*/||---|g'; end

function tree_size; tree --du -h -C "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or du -sh "(if set -q argv[1]; echo $argv[1]; else; echo .; end)"/*; end

function tree_with_hidden; tree -a -C "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or find "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" -print | sed 's|[^/]*/||---|g'; end

function tree_xml; tree -X "(if set -q argv[1]; echo $argv[1]; else; echo .; end)" 2>/dev/null; or echo "tree not installed"; end

function ts_node_run; npx ts-node $argv; end

function tsc_build; npx tsc --build; end

function tsc_compile; npx tsc $argv; end

function tsc_init; npx tsc --init; end

function tsc_noemit; npx tsc --noEmit; end

function tsc_watch; npx tsc --watch; end

function tsconfig_init; echo -e "{\n  \"compilerOptions\": {\n    \"target\": \"ES2022\",\n    \"module\": \"ESNext\",\n    \"strict\": true,\n    \"outDir\": \"./dist\"\n  },\n  \"include\": [\"src\"]\n}" > tsconfig.json; end

function uncompress_auto

end

function unique_count; sort "$argv[1]" | uniq -c | sort -rn; end

function unique_lines; sort -u $argv; end

function uptime_pretty; uptime | sed 's/.*up //; s/,//g; s/ *$//'; end

function url_decode; python3 -c "import urllib.parse,sys; print(urllib.parse.unquote(sys.argv[1]))" "$argv[1]" 2>/dev/null; end

function url_encode; python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$argv[1]" 2>/dev/null; end

function venv_activate; . "(if set -q argv[1]; echo $argv[1]; else; echo .venv; end)/bin/activate"; end

function venv_create; python3 -m venv "(if set -q argv[1]; echo $argv[1]; else; echo .venv; end)"; end

function venv_create_python; python3 -m venv "$argv[1]"; end

function venv_create_system; virtualenv -p "$(which python3)" "$argv[1]"; end

function venv_deactivate; deactivate 2>/dev/null; or true; end

function venv_export_reqs; pip freeze > "(if set -q argv[1]; echo $argv[1]; else; echo requirements.txt; end)"; end

function venv_list_packages; pip list --format=columns 2>/dev/null; end

function verify_checksum; sha256sum -c "$argv[1]" 2>/dev/null; end

function watch_command; watch -n "(if set -q argv[1]; echo $argv[1]; else; echo 2; end)" $argv[2..-1]; end

function whatismyip; curl -fsSL https://ifconfig.me 2>/dev/null; or curl -fsSL https://ipinfo.io/ip 2>/dev/null; end

function whatismyip_external; curl -fsSL https://ipinfo.io/json 2>/dev/null; end

function whatismyip_local; ip addr show | grep "inet " | awk '{print $argv[2]}' | cut -d/ -f1 | head -1; end

function whois_query; whois "$argv[1]" 2>/dev/null; end

function xh_delete; xh DELETE "$argv[1]" 2>/dev/null; or curl -sS -X DELETE "$argv[1]"; end

function xh_get; xh "$argv[1]" 2>/dev/null; or curl -sS "$argv[1]"; end

function xh_post; xh POST "$argv[1]" "$argv[2]" 2>/dev/null; or curl -sS -X POST -d "$argv[2]" "$argv[1]"; end

function xh_put; xh PUT "$argv[1]" "$argv[2]" 2>/dev/null; or curl -sS -X PUT -d "$argv[2]" "$argv[1]"; end

function xml_format; xmllint --format $argv 2>/dev/null; end

function xz_compress; xz "$argv[1]"; end

function xz_decompress; unxz "$argv[1]"; end

function xz_level; xz -"(if set -q argv[2]; echo $argv[2]; else; echo 6; end)" "$argv[1]"; end

function yaml_validate; python3 -c "import sys,yaml; yaml.safe_load(open(sys.argv[1]))" $argv 2>/dev/null; and echo "valid yaml"; or echo "invalid yaml"; end

function yamlfmt; python3 -c "import sys,yaml,json; print(yaml.dump(json.load(sys.stdin)))" 2>/dev/null; end

function yarn_add_dev; yarn add --dev "$argv[1]"; end

function yarn_add_pkg; yarn add "$argv[1]"; end

function yarn_cache_clean; yarn cache clean; end

function yarn_info_pkg; yarn info "$argv[1]"; end

function yarn_install_frozen; yarn install --frozen-lockfile; end

function yarn_install_immutable; yarn install --immutable; end

function yarn_link_pkg; yarn link "$argv[1]"; end

function yarn_outdated; yarn outdated 2>/dev/null; end

function yarn_publish_pkg; yarn publish; end

function yarn_remove_pkg; yarn remove "$argv[1]"; end

function yarn_run_build; yarn build; end

function yarn_run_dev; yarn dev; end

function yarn_run_lint; yarn lint; end

function yarn_run_test; yarn test; end

function yarn_run_typecheck; yarn typecheck; end

function yarn_unlink_pkg; yarn unlink "$argv[1]"; end

function yarn_upgrade_interactive; yarn upgrade-interactive 2>/dev/null; end

function yarn_why; yarn why "$argv[1]" 2>/dev/null; end

function yarn_why_pkg; yarn why "$argv[1]"; end

function yarn_workspace_info; yarn workspaces info; end

function yarn_workspace_run; yarn workspace "$argv[1]" run "$argv[2]"; end

function ytop_monitor; ytop 2>/dev/null; or echo "ytop needed"; end

function zellij_action_move; zellij action move-focus "$argv[1]"; end

function zellij_action_rename; zellij action rename-session "$argv[1]"; end

function zellij_action_resize; zellij action resize "$argv[1]" "$argv[2]"; end

function zellij_session_attach; zellij attach "$argv[1]"; end

function zellij_session_create; zellij -s "$argv[1]"; end

function zellij_session_kill; zellij kill-session "$argv[1]"; end

function zellij_session_list; zellij list-sessions; end

function zip_compress; zip -r "$argv[1].zip" "$argv[1]"; end

function zip_decompress; unzip "$argv[1]"; end

function zip_encrypt; zip -er "$argv[1].zip" "$argv[1]"; end

function zip_list; unzip -l "$argv[1]"; end

# =============================================================================

# FBI-APPROVED LEVEL OF CONFIDENCE

# =============================================================================

# =============================================================================

# =============================================================================

function distro_family --description "Get normalized distro family (redhat/debian/arch/gentoo/suse/void/alpine/slackware/nix/macos)"
    set -l dtype "unknown"
    
    if test -r /etc/os-release
        set -l id ""
        set -l id_like ""
        
        for line in (cat /etc/os-release)
            if string match -r '^ID=' $line >/dev/null
                set id (string split -m1 = $line)[2]
                set id (string replace -a '"' '' $id)
            end
            if string match -r '^ID_LIKE=' $line >/dev/null
                set id_like (string split -m1 = $line)[2]
                set id_like (string replace -a '"' '' $id_like)
            end
        end
        
        switch "$id"
            case 'fedora' 'centos' 'stream' 'rhel' 'rocky' 'alma' 'nobara'
                set dtype "redhat"
            case 'sles' 'opensuse' 'leap' 'tumbleweed' 'gecko'
                set dtype "suse"
            case 'ubuntu' 'debian' 'linuxmint' 'pop' 'elementary' 'zorin' 'neon' 'mx'
                set dtype "debian"
            case 'gentoo' 'funtoo' 'calculate'
                set dtype "gentoo"
            case 'arch' 'artix' 'manjaro' 'endeavouros' 'garuda' 'archlabs'
                set dtype "arch"
            case 'slackware' 'slint' 'salix' 'vector'
                set dtype "slackware"
            case 'void'
                set dtype "void"
            case 'alpine'
                set dtype "alpine"
            case 'nixos'
                set dtype "nix"
            case '*'
                if test -n "$id_like"
                    if string match -r '*arch*' "$id_like" >/dev/null
                        set dtype "arch"
                    else if string match -r '*debian*|*ubuntu*' "$id_like" >/dev/null
                        set dtype "debian"
                    else if string match -r '*fedora*|*rhel*|*centos*' "$id_like" >/dev/null
                        set dtype "redhat"
                    else if string match -r '*suse*|*opensuse*' "$id_like" >/dev/null
                        set dtype "suse"
                    else if string match -r '*gentoo*' "$id_like" >/dev/null
                        set dtype "gentoo"
                    else if string match -r '*slackware*' "$id_like" >/dev/null
                        set dtype "slackware"
                    else
                        set dtype "$id"
                    end
                else
                    set dtype "$id"
                end
        end
    else if test "$DOTFILES_OS" = "Darwin"
        set dtype "macos"
    end
    
    echo "$dtype"
end

# =============================================================================

# =============================================================================

function install_shell_support --description "Installs shell tools: tree zoxide fzf fastfetch eza bat ripgrep atuin etc."
    echo "Installing shell support tools for your distro..."
    
    set -l dtype (distro_family)
    set -l pm "$DOTFILES_PKG_MANAGER"
    
    echo "Detected distro family: $dtype"
    echo "Detected package manager: $pm"
    echo ""
    
    switch "$dtype"
        case 'redhat'
            switch "$pm"
                case 'dnf'
                    sudo dnf install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case 'yum'
                    sudo yum install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case '*'
                    if type -q dnf >/dev/null
                        sudo dnf install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else if type -q yum >/dev/null
                        sudo yum install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else
                        echo "No known package manager for RHEL/CentOS/Fedora family."
                        return 1
                    end
            end
        
        case 'suse'
            sudo zypper install -y multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
        
        case 'debian'
            switch "$pm"
                case 'apt' 'apt-get'
                    sudo apt update
                    sudo apt install -y multitail tree zoxide fzf bash-completion eza bat ripgrep atuin
                    
                    if not type -q fastfetch >/dev/null
                        echo "Installing fastfetch via GitHub (may not be in Debian repo)..."
                        if type -q curl >/dev/null
                            set -l ff_url (curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep 'browser_download_url.*linux-amd64.deb' | string split '"')[4]
                            if test -n "$ff_url"
                                curl -sL "$ff_url" -o /tmp/fastfetch_latest_amd64.deb
                                sudo apt install -y /tmp/fastfetch_latest_amd64.deb
                                rm -f /tmp/fastfetch_latest_amd64.deb
                            end
                        end
                    end
                case '*'
                    if type -q apt >/dev/null
                        sudo apt update
                        sudo apt install -y multitail tree zoxide fzf bash-completion eza bat ripgrep atuin
                    else
                        echo "No known package manager for Debian/Ubuntu family."
                        return 1
                    end
            end
        
        case 'gentoo'
            if type -q emerge >/dev/null
                sudo emerge app-text/tree app-shells/zoxide app-shells/fzf app-shells/bash-completion sys-apps/fastfetch sys-apps/eza sys-apps/bat sys-apps/ripgrep app-shells/atuin
            else
                echo "No emerge found for Gentoo."
                return 1
            end
        
        case 'arch'
            switch "$pm"
                case 'paru'
                    paru -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case 'yay'
                    yay -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case 'pacman'
                    sudo pacman -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case '*'
                    if type -q paru >/dev/null
                        paru -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else if type -q yay >/dev/null
                        yay -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else if type -q pacman >/dev/null
                        sudo pacman -S --noconfirm multitail tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                    else
                        echo "No known package manager for Arch family."
                        return 1
                    end
            end
        
        case 'slackware'
            if type -q slackpkg >/dev/null
                sudo slackpkg update
                echo "Note: Some packages may not be in main Slackware repos."
                sudo slackpkg install tree fzf bash-completion
            else
                echo "No slackpkg. Manual install needed for Slackware."
                return 1
            end
        
        case 'void'
            sudo xbps-install -Sy tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
        
        case 'alpine'
            sudo apk add tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
        
        case 'nix'
            nix-env -iA nixpkgs.tree nixpkgs.zoxide nixpkgs.fzf nixpkgs.bash-completion nixpkgs.fastfetch nixpkgs.eza nixpkgs.bat nixpkgs.ripgrep nixpkgs.atuin
        
        case 'macos'
            switch "$pm"
                case 'brew'
                    brew install tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case 'port'
                    sudo port install tree zoxide fzf bash-completion fastfetch eza bat ripgrep atuin
                case '*'
                    echo "On macOS, need Homebrew or MacPorts."
                    echo "To install Homebrew:"
                    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
                    return 1
            end
        
        case '*'
            echo "Unknown distro family: $dtype"
            echo "Try installing these manually:"
            echo "  multitail, tree, zoxide, fzf, bash-completion"
            echo "  fastfetch, eza, bat, ripgrep, atuin"
            return 1
    end
    
    echo ""
    echo "Install complete! Run 'exec fish' to reload."
end

alias dotinstall='install_shell_support'
alias install_deps='install_shell_support'

# =============================================================================
# SECURITY FUNCTIONS - FBI-APPROVED
# =============================================================================


function secstatus --description "Quick security status"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    SECURITY STATUS - v1.0                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    
    echo "Current umask: "(umask)
    echo "Current user:  "$USER
    echo "Current EUID:  "$EUID
    echo "Current shell: "$SHELL
    echo ""
    
    if test "$EUID" -eq 0
        echo "⚠️  WARNING: Running as ROOT (EUID = 0)"
        echo "    Be extra careful!"
    else
        echo "✓ Running as non-root user (safer)"
    end
    echo ""
    echo "Protective aliases:"
    echo "  cp='cp -i'   mv='mv -i'   rm='rm -i'"
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               FBI-APPROVED SECURITY ACTIVE                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
end

alias sec='secstatus'
alias hardening='secstatus'


function del --description "Securely delete files with shred (overwrite)"
    if test (count $argv) -eq 0
        echo "Usage: del <file1> [file2] ..."
        echo "Securely deletes by overwriting before removal"
        return 1
    end
    
    for file in $argv
        if test -f "$file"
            if type -q shred >/dev/null
                echo "Shredding: $file"
                shred -u "$file"
            else
                echo "shred not found, using rm -i: $file"
                rm -i "$file"
            end
        else if test -d "$file"
            echo "Directories require: rm -ri '$file'"
        else
            echo "Not found: $file"
        end
    end
end


function check_path_security --description "Check PATH for world-writable dirs and . in PATH"
    set -l risk 0
    echo "Checking PATH security..."
    echo ""
    
    for part in (string split ':' $PATH)
        if test -z "$part" -o "$part" = "."
            echo "⚠️  DANGER: PATH contains current directory (.)"
            echo "    MAJOR security risk - remove it!"
            set risk 1
        else if not test -d "$part"
            echo "Note: PATH element doesn't exist: $part"
        else

            if type -q stat >/dev/null
                set -l perms (stat -c "%a" "$part" 2>/dev/null; or stat -f "%Lp" "$part" 2>/dev/null)
                if test -n "$perms"
                    set -l last_digit (string sub -s (string length "$perms") "$perms")
                    switch "$last_digit"
                        case '2' '3' '6' '7'
                            echo "⚠️  WARNING: Path is world-writable: $part (perms: $perms)"
                            echo "    Possible malicious code injection"
                            set risk 1
                    end
                end
            end
        end
    end
    
    echo ""
    if test $risk -eq 0
        echo "✓ PATH looks secure"
    else
        echo "⚠️  Security risks found!"
    end
end

alias pathsec='check_path_security'


function listening --description "Show listening network connections"
    echo "Listening network connections:"
    echo ""
    
    if type -q ss >/dev/null
        ss -tuln 2>/dev/null; or ss -tul
    else if type -q netstat >/dev/null
        netstat -tuln 2>/dev/null; or netstat -tul
    else
        echo "Neither ss nor netstat found."
        echo "Try: sudo lsof -i -P -n | grep LISTEN"
    end
end

alias ports='listening'


function sudoers_check --description "Check sudoers configuration for current user"
    if test -f /etc/sudoers
        echo "Checking sudo configuration:"
        echo ""
        echo "Sudoers entries for $USER:"
        if type -q sudo >/dev/null
            sudo -l 2>/dev/null; or echo "Unable to read sudo privileges (password may be needed)"
        end
        echo ""
        if groups 2>/dev/null | grep -q wheel >/dev/null
            echo "✓ User is in wheel group"
        end
        if groups 2>/dev/null | grep -q sudo >/dev/null
            echo "✓ User is in sudo group"
        end
    else
        echo "No /etc/sudoers file found on this system"
    end
end


function secaudit --description "Full security audit"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               FULL SECURITY AUDIT - v1.0                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SYSTEM INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Hostname:      "(hostname 2>/dev/null; or echo "unknown")
    echo "Kernel:        "(uname -s)" "(uname -r)
    echo "Architecture:  "(uname -m)
    echo "Uptime:        "(uptime 2>/dev/null | sed 's/.*up *//'; or echo "unknown")
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "USER INFO"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "User:          "$USER
    echo "UID:           "$UID
    echo "EUID:          "$EUID
    echo "Groups:        "(groups 2>/dev/null; or echo "unknown")
    echo "Home:          "$HOME
    echo "Shell:         "$SHELL
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "FILE SYSTEM SECURITY"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Umask:         "(umask)
    echo ""
    check_path_security
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SSH SECURITY"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if test -d "$HOME/.ssh"
        echo ".ssh directory exists"
        if type -q stat >/dev/null
            set -l ssh_perms (stat -c "%a" "$HOME/.ssh" 2>/dev/null)
            echo ".ssh dir perms:  $ssh_perms"
            if test "$ssh_perms" = "700"
                echo "✓ .ssh has correct permissions (700)"
            else
                echo "⚠️  .ssh should be 700, is $ssh_perms"
            end
        end
        
        if ls -la "$HOME/.ssh/" 2>/dev/null | grep -q "id_" >/dev/null
            echo ""
            echo "SSH keys found:"
            for keyfile in $HOME/.ssh/id_*
                if test -f "$keyfile" -a ! (string match -r '*.pub$' "$keyfile" >/dev/null)
                    if type -q stat >/dev/null
                        set -l key_perms (stat -c "%a" "$keyfile" 2>/dev/null)
                        if test "$key_perms" = "600"
                            echo "✓ "(basename "$keyfile")": $key_perms (correct)"
                        else
                            echo "⚠️  "(basename "$keyfile")": $key_perms (should be 600!)"
                        end
                    else
                        echo "  "(basename "$keyfile")
                    end
                end
            end
        end
    else
        echo "No ~/.ssh directory found"
    end
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "GPG/GNUPG"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if type -q gpg >/dev/null
        echo "GPG installed. Listing public keys:"
        gpg --list-keys --keyid-format=short 2>/dev/null; or echo "(no keys or error)"
    else
        echo "GPG not installed or not in PATH"
    end
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "NETWORK - LISTENING PORTS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    listening
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SHELL HARDENING STATUS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✓ umask 022 (from exports.fish)"
    echo "✓ cp/mv/rm -i (interactive by default)"
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║        FBI-LEVEL SECURITY AUDIT COMPLETE                      ║"
    echo "║     Pinak's Dotfiles v1.0 - Hardened & Secure                 ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
end

alias audit='secaudit'
alias security='secaudit'


function sectips --description "Security best practices"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              SECURITY BEST PRACTICES                           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "1. USE SUDO, NOT SU"
    echo "   sudo keeps logs and allows fine-grained control"
    echo ""
    echo "2. SPACE BEFORE SENSITIVE COMMANDS"
    echo "   fish ignores duplicate commands. For bash/zsh: HISTCONTROL=ignorespace"
    echo "   add a space before commands with passwords"
    echo ""
    echo "3. CHECK LISTENING PORTS"
    echo "   Use 'listening' or 'ports' alias to see what's exposed"
    echo ""
    echo "4. SSH KEY PERMISSIONS"
    echo "   chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_*"
    echo ""
    echo "5. REGULAR UPDATES"
    echo "   Use 'update' alias to keep system patched"
    echo ""
    echo "6. FULL SECURITY AUDIT"
    echo "   Run 'secaudit' or 'audit' for comprehensive check"
    echo ""
    echo "7. ENCRYPTION"
    echo "   Use LUKS for full disk, GPG for files/email"
    echo ""
    echo "8. 2FA / TWO-FACTOR AUTHENTICATION"
    echo "   Enable everywhere: SSH, sudo, online accounts"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Available security commands:"
    echo "  secstatus / sec     - Quick security overview"
    echo "  secaudit / audit    - Full security audit"
    echo "  check_path_security - Check PATH for world-writable dirs"
    echo "  listening / ports   - Show network listeners"
    echo "  del                 - Secure file deletion (shred)"
    echo "  sectips             - Show these tips"
    echo "  sudoers_check       - Check sudo configuration"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
end

alias tips='sectips'
alias securitytips='sectips'

function bak --description "Backup file with timestamp"
    for f in $argv
        if not test -f "$f"; echo "usage: bak file"; return 1; end
        set -l b "$f.bak."(date '+%F_%T' | sed 's/:/-/g')
        while test -f "$b"; sleep 1; set b "$f.bak."(date '+%F_%T' | sed 's/:/-/g'); end
        cp -av "$f" "$b"
    end
end

function unbak --description "Restore newest backup"
    for f in $argv
        set -l d (dirname "$f"); set -l b (basename "$f")
        set -l bf (find "$d" -name "$b.bak.*" -o -name "$b.*.bak" 2>/dev/null | sort | tail -1)
        test -n "$bf"; and cp -av "$bf" "$d/$b"; or echo "no backup for $b"
    end
end

function orig --description "Create .orig backup"
    for f in $argv
        if not test -f "$f"; echo "missing: $f"; return 1; end
        if test -f "$f.org"; echo "$f.org exists"; return 1; end
    end
    for f in $argv; cp -av "$f" "$f.org"; end
end

function unorig --description "Restore from .orig"
    for f in $argv
        if not test -f "$f"; echo "missing: $f"; return 1; end
        cp -av "$f" (string replace -r '\.org$' '' "$f")
    end
end

function topcommands --description "Most used commands"
    set -l c 10; test (count $argv) -gt 0; and set c $argv[1]
    history | awk '{print $4}' | awk 'BEGIN{FS="|"}{print $1}' | sort | uniq -c | sort -n | tail -n (math "max(1,$c)") | sort -nr
end

function findup --description "Find file in parent dirs"
    set -l a $argv[1]; set -l d (pwd)
    while test -n "$d"
        if test -e "$d/$a"; echo "$d/$a"; return 0; end
        set d (string replace -r '/[^/]+$' '' "$d")
    end
    echo "not found: $a" >&2; return 1
end

function cdup --description "Cd to dir containing file"
    set -l f (findup $argv[1])
    test -n "$f"; and cd (dirname "$f"); or echo "not found: $argv[1]"
end

function pg --description "ps+grep"
    ps -ef | grep -i --color=yes $argv | grep -v grep
end

function stamp --description "Timestamp prefix"
    echo -n (date '+%F %T')"  $argv"
    test (count $argv) -gt 0; and echo
end

function stampcmd --description "Run command with timestamp"
    set -l o ("$argv" 2>&1); stamp "$o"
end

function clip --description "Copy to clipboard"
    if test (count $argv) -gt 0
        _x xclip -selection clipboard <"$argv[1]" 2>/dev/null
        or _x wl-copy <"$argv[1]" 2>/dev/null
        or _x pbcopy <"$argv[1]" 2>/dev/null
    else
        _x xclip -selection clipboard 2>/dev/null
        or _x wl-copy 2>/dev/null
        or _x pbcopy 2>/dev/null
    end
end

function path_remove --description "Remove from PATH"
    set -l p; for d in $PATH; test "$d" != "$argv[1]"; and set p $p $d; end; set -gx PATH $p
end

function path_append --description "Append to PATH"
    path_remove $argv[1]; set -gx PATH $PATH $argv[1]
end

function path_prepend --description "Prepend to PATH"
    path_remove $argv[1]; set -gx PATH $argv[1] $PATH
end

function here --description "Bookmark directory"
    ln -sfn (realpath $argv[1]) "$HOME/.shell.here" 2>/dev/null
    or ln -sfn $argv[1] "$HOME/.shell.here"
    echo "here -> "(readlink "$HOME/.shell.here")
end

function there --description "Jump to bookmark"; cd (readlink "$HOME/.shell.here"); end

function mkcd --description "mkdir + cd"; mkdir -p $argv[1]; and cd $argv[1]; end

function gcd --description "Go to git root"
    set -l r (git rev-parse --show-toplevel 2>/dev/null)
    test -n "$r"; and cd "$r"; or echo "not in git repo"
end

function extract --description "Extract archives"
    if test (count $argv) -eq 0; echo "usage: extract <file>"; return 1; end
    for f in $argv
        if not test -f "$f"; echo "missing: $f"; continue; end
        switch "$f"
            case '*.tar.bz2' '*.tbz2'; _x tar xjf "$f"
            case '*.tar.gz' '*.tgz';   _x tar xzf "$f"
            case '*.tar.xz';           _x tar xJf "$f"
            case '*.tar.zst';          _x tar --zstd -xf "$f"
            case '*.tar';              _x tar xf "$f"
            case '*.bz2';              _x bunzip2 "$f"
            case '*.gz';               _x gunzip "$f"
            case '*.xz';               _x unxz "$f"
            case '*.zst';              _x zstd -d "$f"
            case '*.zip';              _x unzip "$f"
            case '*.rar';              _x unrar x "$f"
            case '*.7z';               _x 7z x "$f"
            case '*.Z';                _x uncompress "$f"
            case '*';                  echo "unknown: $f"
        end
    end
end

function colors --description "Display 256 colors"
    for i in (seq 0 15); printf "\e[48;5;"$i"m  \e[0m"; end; echo
    for i in (seq 16 231); printf "\e[48;5;"$i"m \e[0m"; if test (math $i - 16) % 36 -eq 35; echo; end; end; echo
    for i in (seq 232 255); printf "\e[48;5;"$i"m  \e[0m"; end; echo
end

function wanip --description "Show public IP"
    _x dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null
    or _x curl -s ifconfig.me 2>/dev/null
    or _x curl -s icanhazip.com 2>/dev/null
end

function flush --description "Flush DNS cache"
    switch (uname)
        case Darwin; _x dscacheutil -flushcache; and _x sudo killall -HUP mDNSResponder
        case Linux; _x sudo resolvectl flush-caches 2>/dev/null; or _x sudo systemd-resolve --flush-caches 2>/dev/null; or true
    end
end

function countfiles --description "Count files/dirs/links"
    for t in files links directories
        set -l c (find . -type (string sub -l1 $t) 2>/dev/null | wc -l | string trim)
        echo "$c $t"
    end
end

function pwdtail --description "Last 2 path components"
    pwd | awk -F/ '{nlast=NF-1; print $nlast"/"$NF}'
end

function distribution --description "Distro family"
    if test -r /etc/os-release
        set -l id (grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')
        switch "$id"
            case fedora rhel centos; echo redhat
            case 'sles*' 'opensuse*'; echo suse
            case ubuntu debian; echo debian
            case gentoo; echo gentoo
            case arch manjaro; echo arch
            case slackware; echo slackware
            case '*'
                set -l il (grep ^ID_LIKE= /etc/os-release | cut -d= -f2 | tr -d '"')
                switch "$il"
                    case '*fedora*' '*rhel*' '*centos*'; echo redhat
                    case '*sles*' '*opensuse*'; echo suse
                    case '*ubuntu*' '*debian*'; echo debian
                    case '*gentoo*'; echo gentoo
                    case '*arch*'; echo arch
                    case '*slackware*'; echo slackware
                    case '*'; echo unknown
                end
        end
    else; echo unknown
    end
end

function ip_show --description "Show IP addresses"
    if test (uname) = Linux; _x ip addr show $argv; else; _x ifconfig $argv; end
end

function mem_info --description "Memory info"
    if test (uname) = Linux; _x free -h; else; _x vm_stat 2>/dev/null; or _x free -h; end
end

function cpu_info --description "CPU info"
    if test (uname) = Linux; _x lscpu; else; _x sysctl -n machdep.cpu.brand_string; end
end

function open_file --description "Open file with system handler"
    _x xdg-open $argv 2>/dev/null; or _x open $argv 2>/dev/null; or echo "no opener"
end

function copy_cmd --description "Copy to clipboard"
    _x xclip -selection clipboard $argv 2>/dev/null
    or _x wl-copy $argv 2>/dev/null
    or _x pbcopy $argv 2>/dev/null
    or echo "no clipboard tool"
end

function epoch --description "Current epoch seconds"; date +%s; end

function hrline --description "Horizontal line"
    printf '%*s\n' (math "max(1,"(string sub -l1 "$argv[1]")")") '' | tr ' ' (string sub -l1 "$argv[2]") 2>/dev/null
end

function have --description "Check command exists"
    type -q $argv[1]
end

function myip4 --description "IPv4 address"
    _x dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com 2>/dev/null | tr -d '"'
    or _x curl -sf4 ifconfig.me 2>/dev/null
    or _x curl -sf4 icanhazip.com 2>/dev/null
    or echo "N/A"
end

function myip6 --description "IPv6 address"
    _x dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com 2>/dev/null | tr -d '"'
    or _x curl -sf6 ifconfig.me 2>/dev/null
    or _x curl -sf6 icanhazip.com 2>/dev/null
    or echo "N/A"
end

function dns_lookup --description "DNS lookup"
    _x dig +short $argv[1] 2>/dev/null
    or _x host $argv[1] 2>/dev/null | awk '/has address/{print $NF}'
end

function http_status --description "HTTP status code"
    _x curl -sI -o /dev/null -w "%{http_code}" $argv[1] 2>/dev/null
end

function http_headers --description "HTTP response headers"
    _x curl -sI $argv[1] 2>/dev/null
end

function download --description "Download file"
    _x curl -fSL $argv[1] -o $argv[2] 2>/dev/null
    or _x wget -q $argv[1] -O $argv[2] 2>/dev/null
    or echo "no download tool"
end

function ps_cpu --description "Top CPU processes"
    set -l n 10; test (count $argv) -gt 0; and set n $argv[1]
    _x ps aux --sort=-%cpu 2>/dev/null | head -n $n
    or _x ps aux 2>/dev/null | sort -k3rn | head -n $n
end

function ps_mem --description "Top memory processes"
    set -l n 10; test (count $argv) -gt 0; and set n $argv[1]
    _x ps aux --sort=-%mem 2>/dev/null | head -n $n
    or _x ps aux 2>/dev/null | sort -k4rn | head -n $n
end

function file_largest --description "Largest files"
    find $argv[1] -type f -exec ls -lhS {} + 2>/dev/null | head -n $argv[2]
end

function file_newest --description "Newest files"
    find $argv[1] -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -n $argv[2] | cut -d' ' -f2-
end

function file_dupes --description "Find duplicate files"
    find $argv[1] -type f -exec md5sum {} + 2>/dev/null | sort | uniq -w32 -dD
end

function file_rename_bulk --description "Bulk rename"
    for f in *$argv[1]*
        mv "$f" (string replace -a "$argv[1]" "$argv[2]" "$f") 2>/dev/null
    end
end

function text_lower --description "Lowercase stdin"; tr '[:upper:]' '[:lower:]'; end
function text_upper --description "Uppercase stdin"; tr '[:lower:]' '[:upper:]'; end
function text_reverse --description "Reverse stdin"; rev; end
function text_count_words --description "Word count"; wc -w; end
function text_count_lines --description "Line count"; wc -l; end
function text_count_chars --description "Character count"; wc -c; end
function text_uniq_lines --description "Unique sorted lines"; sort | uniq; end
function text_columns --description "Columnate stdin"; column -t -s (string sub -l1 "$argv[1]"); end
function text_json --description "Format JSON stdin"; python3 -m json.tool 2>/dev/null; or echo "python3 needed"; end

function hash_md5 --description "MD5 hash"
    _x md5sum $argv[1] 2>/dev/null; or _x md5 -r $argv[1] 2>/dev/null; or echo "no md5 tool"
end

function hash_sha1 --description "SHA1 hash"
    _x sha1sum $argv[1] 2>/dev/null; or _x shasum -a1 $argv[1] 2>/dev/null; or echo "no sha1"
end

function hash_sha256 --description "SHA256 hash"
    _x sha256sum $argv[1] 2>/dev/null; or _x shasum -a256 $argv[1] 2>/dev/null; or echo "no sha256"
end

function git_log_short --description "Short git log"
    _x git log --oneline -n (math "max(1,"$argv[1]")") 2>/dev/null
end

function git_branch_delete_merged --description "Delete merged branches"
    git branch --merged | grep -v '\*\|master\|main' | xargs -r git branch -d 2>/dev/null
end

function encrypt_aes --description "AES encrypt file"
    _x openssl enc -aes-256-cbc -salt -in $argv[1] -out $argv[1].enc 2>/dev/null; or echo "openssl needed"
end

function decrypt_aes --description "AES decrypt file"
    _x openssl enc -aes-256-cbc -d -in $argv[1] -out (string replace -r '\.enc$' '' $argv[1]) 2>/dev/null; or echo "openssl needed"
end

function disk_usage --description "Disk usage"
    _x df -h $argv[1] 2>/dev/null
end

function disk_io --description "Disk IO stats"
    _x iostat 2>/dev/null; or echo "iostat needed"
end

function archive_list --description "List archive contents"
    switch $argv[1]
        case '*.tar.gz' '*.tgz'; _x tar tzf $argv[1]
        case '*.tar.bz2' '*.tbz2'; _x tar tjf $argv[1]
        case '*.tar.xz'; _x tar tJf $argv[1]
        case '*.tar'; _x tar tf $argv[1]
        case '*.zip'; _x unzip -l $argv[1]
        case '*.7z'; _x 7z l $argv[1]
        case '*.rar'; _x unrar l $argv[1]
    end 2>/dev/null
end

