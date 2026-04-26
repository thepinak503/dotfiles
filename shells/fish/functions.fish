# =============================================================================
# All Functions - Manually merged from all sources
# =============================================================================

# Directory & Files
function mkcd --description "Create directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end

function take --description "Create directory and cd into it"
    mkdir -p $argv[1]; and cd $argv[1]
end

function extract --description "Extract archive"
    switch (string match -r '\.([^.]+)$' $argv[1])
        case tar.bz2; tar xjf $argv[1]
        case tar.gz; tar xzf $argv[1]
        case bz2; bunzip2 $argv[1]
        case rar; unrar x $argv[1]
        case gz; gunzip $argv[1]
        case tar; tar xf $argv[1]
        case tbz2; tar xjf $argv[1]
        case tgz; tar xzf $argv[1]
        case zip; unzip $argv[1]
        case Z; uncompress $argv[1]
        case 7z; 7z x $argv[1]
        case '*'
            echo "unknown archive: "(string join '' $argv[1])
            return 1
    end
end

function dothealth --description "Run dotfiles health check"
    if test -n "$DOTFILES_DIR"
        bash "$DOTFILES_DIR/bin/health_check.sh"
    end
end

function dotbench --description "Run shell benchmark"
    if test -n "$DOTFILES_DIR"
        bash "$DOTFILES_DIR/bin/benchmark_shell.sh"
    end
end

function dotfix --description "Fix/reinstall dotfiles"
    if test -n "$DOTFILES_DIR"
        sh "$DOTFILES_DIR/install/install.sh"
    end
end

function recent --description "Find recent files"
    find . -type f -mtime -1 -print 2>/dev/null | head -100
end

function jsonfmt --description "Format JSON"
    python3 -m json.tool $argv
end

function timer --description "Time a command"
    set -l start (date +%s)
    eval $argv
    set -l code $status
    set -l end (date +%s)
    echo "elapsed: "(math $end - $start)"s"
    return $code
end

function dotloadfull --description "Load all functions and aliases"
    if test -n "$DOTFILES_DIR"
        source "$DOTFILES_DIR/shells/fish/functions_all.fish"
        source "$DOTFILES_DIR/shells/fish/aliases_all.fish"
    end
end

function dot_sync --description "Sync dotfiles"
    set -l repo_root "$DOTFILES_DIR"
    if test -z "$repo_root" -o ! -d "$repo_root/.git"
        echo "Dotfiles repo not found."
        return 1
    end
    echo "Syncing dotfiles in $repo_root..."
    git -C "$repo_root" fetch --all --prune
    git -C "$repo_root" pull --rebase --autostash || git -C "$repo_root" pull --ff-only
end

function detect_pkg_manager --description "Detect package manager"
    if type -q yay
        echo "yay"
    else if type -q pacman
        echo "pacman"
    else if type -q apt
        echo "apt"
    else if type -q dnf
        echo "dnf"
    else if type -q brew
        echo "brew"
    else
        echo "none"
    end
end

function search --description "Search packages"
    switch (detect_pkg_manager)
        case yay pacman
            pacman -Ss $argv
        case apt
            apt search $argv
        case dnf
            dnf search $argv
        case brew
            brew search $argv
        case '*'
            echo "No supported package manager"
    end
end

# Network
function myip --description "Get public IP"
    curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null
end

function weather --description "Get weather"
    curl -fsSL wttr.in
end

function portcheck --description "Check port usage"
    netstat -tulanp 2>/dev/null | grep $argv[1] || ss -tulanp | grep $argv[1]
end

function pkillf --description "Kill process by name"
    pkill -f $argv[1] 2>/dev/null || killall $argv[1] 2>/dev/null
end

# Docker
function dexec --description "Docker exec into container"
    docker exec -it $argv[1] /bin/bash
end

function dlogs --description "Docker logs follow"
    docker logs -f $argv[1]
end

function dclean --description "Docker system prune"
    docker system prune -af --volumes
end

# K8s
function kexec --description "Kubectl exec into pod"
    kubectl exec -it $argv[1] -- /bin/bash
end

function klogs --description "Kubectl logs follow"
    kubectl logs -f $argv[1]
end

# Git
function glog --description "Git log graph"
    git log --oneline --graph --all -20
end

function gdiff --description "Git diff"
    git diff $argv
end

function gcontrib --description "Git contributors"
    git shortlog -sne
end

# Process
function topcpu --description "Top processes by CPU"
    ps aux --sort=-%cpu | head -20
end

function topmem --description "Top processes by memory"
    ps aux --sort=-%mem | head -20
end

function psgrep --description "Grep processes"
    ps aux | grep -i $argv[1]
end

# Archive
function targz --description "Create tar.gz"
    tar -czf "$argv[1].tar.gz" $argv[1]
end

function tarxz --description "Extract tar.gz"
    tar -xzf $argv[1]
end

# Web
function serve --description "HTTP server"
    python3 -m http.server $argv[1]
end

# Tmux
function ta --description "Tmux attach"
    tmux attach -t $argv[1]
end

function tn --description "Tmux new session"
    tmux new-session -s $argv[1]
end

function tl --description "Tmux list sessions"
    tmux list-sessions
end

# Python
function venv --description "Create Python venv"
    python3 -m venv $argv[1]
end

function pyactivate --description "Activate Python venv"
    source $argv[1]/bin/activate.fish
end

function pipup --description "Upgrade pip"
    python3 -m pip install --upgrade pip
end

# Rust
function ccheck --description "Cargo check"
    cargo check
end

function cbuild --description "Cargo build"
    cargo build --release
end

function crt --description "Cargo run"
    cargo run --release
end

function ctest --description "Cargo test"
    cargo test
end

function cfmt --description "Cargo fmt"
    cargo fmt
end

# Go
function gobuild --description "Go build"
    CGO_ENABLED=0 go build -ldflags="-s -w" -o $argv[1] main.go
end

# System update (cross-distro)
function update --description "Update system packages"
    switch (detect_pkg_manager)
        case yay pacman
            sudo pacman -Syu
        case apt
            sudo apt update; and sudo apt upgrade
        case dnf
            sudo dnf upgrade
        case brew
            brew update; and brew upgrade
        case apk
            apk update; and apk upgrade
        case '*'
            echo "No supported package manager"
    end
end

# Install packages (cross-distro)
function install --description "Install package"
    switch (detect_pkg_manager)
        case yay pacman
            sudo pacman -S $argv
        case apt
            sudo apt install $argv
        case dnf
            sudo dnf install $argv
        case brew
            brew install $argv
        case apk
            apk add $argv
        case '*'
            echo "No supported package manager"
    end
end

function ff --description "Find file by name"
    find . -type f -name "*$argv[1]*"
end

function ffd --description "Find directory by name"
    find . -type d -name "*$argv[1]*"
end

function ft --description "Find file by name"
    find . -type f -name "*$argv[1]*"
end

function frep --description "Grep in files"
    grep -r "$argv[1]" . --include="*.$argv[2]*"
end

function fgrep --description "Grep in files"
    grep -r "$argv[1]" . --include="*.$argv[2]*"
end

function rgrep --description "Recursive grep"
    grep -r "$argv[1]" .
end

function fperm --description "Find by permission"
    find . -perm -$argv[1]
end

function ftype --description "Find by file type"
    find . -type f -name "*.$argv[1]"
end

function fuser --description "Find by user"
    find . -user $argv[1]
end

function fnewer --description "Find newer than file"
    find . -newer $argv[1]
end

function fsize --description "Find by size"
    find . -size +$argv[1]
end

function du1 --description "Disk usage 1 level"
    du -h --max-depth=1
end

function dus --description "Disk usage apparent"
    du -h --apparent-size
end

function dul --description "Disk usage 2 levels"
    du -lh --max-depth=2
end

function dut --description "Disk usage total"
    du -sh $argv
end

function dusort --description "Sort by size"
    du -h $argv | sort -h
end

function dusum --description "Sum disk usage"
    du -ch $argv | tail -1
end

function psa --description "All processes"
    ps aux
end

function psg --description "Grep processes"
    ps aux | grep $argv[1]
end

function pse --description "Process extended"
    ps -eo pid,ppid,%cpu,%mem,etime,time,cmd
end

function pss --description "Search processes"
    ps -ef | head -1; and ps -ef | grep $argv[1]
end

function kill9 --description "Kill process"
    kill -9 $argv[1]
end

function pkill --description "Pkill process"
    pkill -9 $argv[1]
end

function pstop --description "Stop process"
    kill -STOP $argv[1]
end

function pcont --description "Continue process"
    kill -CONT $argv[1]
end

function pf --description "Find process"
    pgrep -f $argv[1]
end

function topcpu --description "Top CPU processes"
    ps -eo pcpu,pid,user,comm --sort=-pcpu | head -n $argv[1]
end

function topmem --description "Top memory processes"
    ps -eo pmem,pid,user,comm --sort=-pmem | head -n $argv[1]
end

function myip --description "Get public IP"
    curl -s https://api.ipify.org
end

function localip --description "Get local IP"
    ip addr show | grep -oP 'inet \K[\d.]+'
end

function ips --description "Get all IPs"
    ip addr show | grep -oP 'inet \K[\d.]+'
end

function netstat --description "Network connections"
    netstat -tulpn
end

function ns --description "Netstat short"
    netstat -tulpn
end

function route --description "Show route"
    route -n
end

function dig --description "DNS lookup"
    dig +short $argv[1]
end

function host --description "Host lookup"
    host $argv[1]
end

function whois --description "Whois lookup"
    whois $argv[1]
end

function curl --description "Curl download"
    curl -Ls $argv[1]
end

function wget --description "Wget download"
    wget -qc $argv[1]
end

function curlI --description "Curl headers"
    curl -I $argv[1]
end

function port --description "Check port"
    lsof -i :$argv[1]
end

function ports --description "All ports"
    lsof -i -P -n
end

function portkill --description "Kill port"
    lsof -ti :$argv[1] | xargs kill -9
end

function free --description "Free memory"
    free -h
end

function free1 --description "Free in MB"
    free -m
end

function swapon --description "Show swap"
    swapon --show
end

function cpu --description "CPU info"
    lscpu
end

function nproc --description "CPU cores"
    nproc
end

function uptime1 --description "Uptime"
    uptime
end

function htop --description "HTop"
    htop
end

function df1 --description "Disk free"
    df -h
end

function dfh --description "Disk free human"
    df -h
end

function mount1 --description "Mount list"
    mount | column -t
end

function block --description "Block devices"
    lsblk
end

function lsusb --description "USB devices"
    lsusb
end

function lspci --description "PCI devices"
    lspci -v
end

function unamea --description "Uname all"
    uname -a
end

function unamer --description "Uname release"
    uname -r
end

function unamev --description "Uname version"
    uname -v
end

function kver --description "Kernel version"
    uname -r
end

function karch --description "Kernel arch"
    uname -m
end

function lsmod --description "List modules"
    lsmod
end

function modinfo --description "Module info"
    modinfo $argv[1]
end

function svc --description "Systemctl"
    systemctl $argv[1] $argv[2]
end

function svcenable --description "Enable service"
    systemctl enable $argv[1]
end

function svcstart --description "Start service"
    systemctl start $argv[1]
end

function svcstop --description "Stop service"
    systemctl stop $argv[1]
end

function svcrestart --description "Restart service"
    systemctl restart $argv[1]
end

function svcstatus --description "Service status"
    systemctl status $argv[1]
end

function svclog --description "Journal service"
    journalctl -u $argv[1]
end

function svclogf --description "Journal follow"
    journalctl -f -u $argv[1]
end

function tar_t --description "Tar list"
    tar -tf $argv[1]
end

function tar_x --description "Tar extract"
    tar -xf $argv[1]
end

function tar_c --description "Tar create"
    tar -czf $argv[1].tar.gz $argv[1]
end

function tar_xv --description "Tar extract verbose"
    tar -xvf $argv[1]
end

function tar_xzv --description "Tar extract gz"
    tar -xvzf $argv[1]
end

function zipf --description "Zip folder"
    zip -r $argv[1].zip $argv[1]
end

function unzipf --description "Unzip"
    unzip $argv[1]
end

function gzip --description "Gzip"
    gzip $argv[1]
end

function bunzip2 --description "Bunzip2"
    bunzip2 $argv[1]
end

function tac1 --description "Tac reverse"
    tac $argv[1]
end

function rev1 --description "Reverse"
    rev $argv[1]
end

function sortn --description "Sort numeric"
    sort -n $argv[1]
end

function sortr --description "Sort reverse"
    sort -r $argv[1]
end

function uniq1 --description "Unique"
    uniq $argv[1]
end

function wc1 --description "Count lines"
    wc -l $argv[1]
end

function head1 --description "Head lines"
    head -n $argv[1]
end

function tail1 --description "Tail lines"
    tail -n $argv[1]
end

function tailf --description "Tail follow"
    tail -f $argv[1]
end

function cat1 --description "Cat file"
    cat $argv[1]
end

function nl1 --description "Number lines"
    nl -ba $argv[1]
end

function jq1 --description "JQ parse"
    jq '.' $argv[1]
end

function date1 --description "Date"
    date
end

function dateu --description "Date UTC"
    date -u
end

function datef --description "Date format"
    date +"%Y-%m-%d"
end

function dated --description "Date time"
    date +"%Y-%m-%d %H:%M:%S"
end

function gcl --description "Git clone"
    git clone $argv[1]
end

function gst --description "Git status"
    git status
end

function gco --description "Git checkout"
    git checkout $argv[1]
end

function gcb --description "Git checkout -b"
    git checkout -b $argv[1]
end

function gadd --description "Git add"
    git add $argv[1]
end

function gcommit --description "Git commit"
    git commit -m $argv[1]
end

function gpush --description "Git push"
    git push
end

function gpull --description "Git pull"
    git pull
end

function gfetch --description "Git fetch"
    git fetch
end

function gmerge --description "Git merge"
    git merge $argv[1]
end

function grebase --description "Git rebase"
    git rebase $argv[1]
end

function greset --description "Git reset"
    git reset $argv[1]
end

function grevert --description "Git revert"
    git revert $argv[1]
end

function glog --description "Git log"
    git log --oneline
end

function gdiff --description "Git diff"
    git diff
end

function gshow --description "Git show"
    git show $argv[1]
end

function gstash --description "Git stash"
    git stash
end

function gstashp --description "Git stash pop"
    git stash pop
end

function gbranch --description "Git branch"
    git branch
end

function gtag --description "Git tag"
    git tag $argv[1]
end

function gblame --description "Git blame"
    git blame $argv[1]
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

function dexec --description "Docker exec"
    docker exec -it $argv[1] /bin/sh
end

function dexecb --description "Docker exec bash"
    docker exec -it $argv[1] /bin/bash
end

function dlogs --description "Docker logs"
    docker logs $argv[1]
end

function dbuild --description "Docker build"
    docker build -t $argv[1] .
end

function drun --description "Docker run"
    docker run -it --rm $argv[1]
end

function dstart --description "Docker start"
    docker start $argv[1]
end

function dstop --description "Docker stop"
    docker stop $argv[1]
end

function drm --description "Docker rm"
    docker rm $argv[1]
end

function drmi --description "Docker rmi"
    docker rmi $argv[1]
end

function dc --description "Docker compose"
    docker-compose $argv
end

function dcup --description "Docker compose up"
    docker-compose up -d
end

function dcdown --description "Docker compose down"
    docker-compose down
end

function kgp --description "Kubectl pods"
    kubectl get pods
end

function kgd --description "Kubectl deployments"
    kubectl get deployments
end

function kgs --description "Kubectl services"
    kubectl get services
end

function kex --description "Kubectl exec"
    kubectl exec -it $argv[1] -- /bin/sh
end

function kexb --description "Kubectl exec bash"
    kubectl exec -it $argv[1] -- /bin/bash
end

function klogs --description "Kubectl logs"
    kubectl logs $argv[1]
end

function kdesc --description "Kubectl describe"
    kubectl describe $argv[1]
end

function tf --description "Terraform"
    terraform $argv
end

function tfi --description "Terraform init"
    terraform init
end

function tfp --description "Terraform plan"
    terraform plan
end

function tfap --description "Terraform apply"
    terraform apply
end

function tfd --description "Terraform destroy"
    terraform destroy
end

function helmv --description "Helm version"
    helm version
end

function helmi --description "Helm install"
    helm install $argv[1] $argv[2]
end

function helml --description "Helm list"
    helm list
end

function helmu --description "Helm upgrade"
    helm upgrade $argv[1] $argv[2]
end

function ansible_version --description "Ansible version"
    ansible --version
end

function vagrant_up --description "Vagrant up"
    vagrant up
end

function vagrant_halt --description "Vagrant halt"
    vagrant halt
end

function vagrant_ssh --description "Vagrant ssh"
    vagrant ssh
end

function vagrant_status --description "Vagrant status"
    vagrant status
end

function vagrant_destroy --description "Vagrant destroy"
    vagrant destroy
end

function pvenv --description "Python venv"
    python3 -m venv $argv[1]
end

function pac --description "Install pip"
    python3 -m pip install $argv
end

function pacup --description "Upgrade pip"
    python3 -m pip install --upgrade $argv
end

function pip_install --description "Pip install"
    pip install $argv
end

function pip_list --description "Pip list"
    pip list
end

function pip_freeze --description "Pip freeze"
    pip freeze
end

function nnpm --description "NPM"
    npm $argv
end

function nnode --description "Node"
    node $argv
end

function npx --description "NPX"
    npx $argv
end

function ninit --description "NPM init"
    npm init -y
end

function ni --description "NPM install"
    npm install $argv
end

function nup --description "NPM update"
    npm update $argv
end

function ntest --description "NPM test"
    npm test
end

function nrun --description "NPM run"
    npm run $argv
end

function nbuild --description "NPM build"
    npm run build
end

function ndev --description "NPM dev"
    npm run dev
end

function cargo --description "Cargo"
    cargo $argv
end

function cbuild --description "Cargo build"
    cargo build
end

function crun --description "Cargo run"
    cargo run
end

function ctest --description "Cargo test"
    cargo test
end

function gogo --description "Go"
    go $argv
end

function gobuild --description "Go build"
    go build $argv
end

function gorun --description "Go run"
    go run $argv
end

function gotest --description "Go test"
    go test $argv
end

function gofmt --description "Go fmt"
    gofmt -w $argv[1]
end

function si --description "System info"
    neofetch
end

function sysinfo --description "System info full"
    inxi -Fxxx
end

function hostinfo --description "Host info"
    hostnamectl
end

function osinfo --description "OS info"
    cat /etc/os-release
end

function gpg_encrypt --description "GPG encrypt"
    gpg -c $argv[1]
end

function gpg_decrypt --description "GPG decrypt"
    gpg -d $argv[1]
end

function gpg_list --description "GPG list keys"
    gpg --list-keys
end

function ssh_keygen --description "SSH keygen"
    ssh-keygen -t rsa -b 4096 -f $argv[1]
end

function sha256 --description "SHA256"
    sha256sum $argv[1]
end

function md5 --description "MD5"
    md5sum $argv[1]
end

function lshw --description "LSHW"
    lshw -short
end

function lscpu --description "LS CPU"
    lscpu
end

function sensors --description "Sensors"
    sensors
end

function dmesg0 --description "Dmesg tail"
    dmesg | tail -n $argv[1]
end

function dmesg1 --description "Dmesg head"
    dmesg | head -n $argv[1]
end

function journald --description "Journal boot"
    journalctl -b
end

function journaldm --description "Journal unit"
    journalctl -b -u $argv[1]
end

function useradd --description "User add"
    sudo useradd -m $argv[1]
end

function userdel --description "User delete"
    sudo userdel -r $argv[1]
end

function passwd --description "Passwd"
    sudo passwd $argv[1]
end

function whoami1 --description "Who am I"
    whoami
end

function who1 --description "Who"
    who
end

function w1 --description "W"
    w
end

function last1 --description "Last"
    last
end

function lastlog --description "Last log"
    lastlog
end

function id1 --description "ID"
    id $argv[1]
end

function groupadd --description "Group add"
    sudo groupadd $argv[1]
end

function chmod1 --description "Chmod"
    chmod $argv[1] $argv[2]
end

function chmodx --description "Chmod +x"
    chmod +x $argv[1]
end

function chown1 --description "Chown"
    sudo chown $argv[1] $argv[2]
end

function ff --description "Find file"
    find . -name "*$argv[1]*"
end

function findtype --description "Find type"
    find . -type $argv[1]
end

function findsize --description "Find size"
    find . -size +$argv[1]
end

function finduser --description "Find user"
    find . -user $argv[1]
end

function grep1 --description "Grep"
    grep -n $argv[1] $argv[2]
end

function grepi --description "Grep ignore"
    grep -i $argv[1] $argv[2]
end

function grepv --description "Grep invert"
    grep -v $argv[1] $argv[2]
end

function ripgrep --description "Ripgrep"
    rg $argv
end

function upper --description "Upper case"
    echo $argv[1] | tr '[:lower:]' '[:upper:]'
end

function lower --description "Lower case"
    echo $argv[1] | tr '[:upper:]' '[:lower:]'
end

function rev --description "Reverse"
    echo $argv[1] | rev
end

function trim --description "Trim"
    echo $argv[1] | xargs
end

function copy --description "Copy to clipboard"
    xclip -selection clipboard $argv[1]
end

function paste --description "Paste clipboard"
    xclip -selection clipboard -o
end

function compress --description "Compress tar"
    tar -czf $argv[1].tar.gz $argv[1]
end

function decompress --description "Decompress tar"
    tar -xzf $argv[1]
end

function zip1 --description "Zip"
    zip -r $argv[1].zip $argv[1]
end

function unzip1 --description "Unzip"
    unzip $argv[1].zip
end

function monitor --description "Monitor"
    vmstat 1
end

function iostat1 --description "IO stat"
    iostat -xz 1
end

function iotop1 --description "IO top"
    sudo iotop
end

function nethogs1 --description "Net.hogs"
    sudo nethogs $argv[1]
end

function logs --description "Tail log"
    tail -f /var/log/$argv[1].log
end

function logerr --description "Log errors"
    grep -i error /var/log/$argv[1].log
end

function pacman_i --description "Pacman install"
    sudo pacman -S $argv
end

function pacman_s --description "Pacman search"
    pacman -Ss $argv
end

function pacman_u --description "Pacman update"
    sudo pacman -Syu
end

function yay_i --description "Yay install"
    yay -S $argv
end

function apt_i --description "Apt install"
    sudo apt install $argv
end

function apt_u --description "Apt update"
    sudo apt update; and sudo apt upgrade
end

function apt_s --description "Apt search"
    apt search $argv
end

function dnf_i --description "DNF install"
    sudo dnf install $argv
end

function dnf_u --description "DNF update"
    sudo dnf update
end

function dnf_s --description "DNF search"
    sudo dnf search $argv
end

function brew_i --description "Brew install"
    brew install $argv
end

function brew_u --description "Brew update"
    brew update; and brew upgrade
end

function brew_s --description "Brew search"
    brew search $argv
end

function shell --description "Shell"
    echo $SHELL
end

function shellv --description "Shell version"
    $SHELL --version
end

function bashv --description "Bash version"
    bash --version
end

function zshv --description "Zsh version"
    zsh --version
end

function fishv --description "Fish version"
    fish --version
end

function history --description "History"
    history $argv
end

function h --description "History search"
    history | grep $argv[1]
end

function cd --description "CD"
    if test -n "$argv[1]"
        builtin cd $argv && ls
    else
        builtin cd ~ && ls
    end
end

function cd- --description "CD previous"
    cd -
end

function cd.. --description "CD parent"
    cd ..
end

function cd... --description "CD grandparent"
    cd ../..
end

function cdd --description "CD Desktop"
    cd ~/Desktop/$argv[1]
end

function cdp --description "CD Projects"
    cd ~/Projects/$argv[1]
end

function cdm --description "CD Music"
    cd ~/Music/$argv[1]
end

function cdv --description "CD Videos"
    cd ~/Videos/$argv[1]
end

function alias1 --description "Create alias"
    alias $argv[1]=$argv[2]
end

function unalias1 --description "Remove alias"
    unalias $argv[1]
end

function functions1 --description "List function"
    declare -f $argv[1]
end

function envs --description "Env list"
    env | sort
end

function envset --description "Env set"
    export $argv[1]=$argv[2]
end

function envpath --description "PATH list"
    echo $PATH | tr ':' '\n'
end

function pushd1 --description "Pushd"
    pushd $argv[1]
end

function popd1 --description "Popd"
    popd
end

function dirs1 --description "Dirs"
    dirs -v
end

function jobs1 --description "Jobs"
    jobs -l
end

function fg1 --description "FG"
    fg $argv[1]
end

function bg1 --description "BG"
    bg $argv[1]
end

function time1 --description "Time"
    time $argv
end

function setx --description "Debug on"
    set -x
end

function unsetx --description "Debug off"
    set +x
end

function err --description "Error"
    printf '%s\n' $argv[1] >&2
end

function die --description "Die"
    err $argv[1]; exit 1
end

function rand --description "Random number"
    shuf -i 1-$argv[1] -n 1
end

function uuid --description "UUID"
    cat /proc/sys/kernel/random/uuid
end

function pyhttp --description "Python HTTP server"
    python3 -m http.server $argv[1]
end

function mysql --description "MySQL"
    mysql -u root -p$argv[1]
end

function psql1 --description "PostgreSQL"
    psql -U $argv[1]
end

function sqlite --description "SQLite"
    sqlite3 $argv[1]
end

function redis --description "Redis CLI"
    redis-cli
end

function mongosh --description "Mongo shell"
    mongosh
end

function es --description "Elasticsearch"
    curl -s http://localhost:9200
end

function nmap1 --description "Nmap"
    nmap $argv[1]
end

function netcat --description "Netcat"
    nc -zv $argv[1] $argv[2]
end

function speedtest --description "Speedtest"
    speedtest-cli
end

function vim --description "Vim"
    vim $argv
end

function nvim --description "Neovim"
    nvim $argv
end

function emacs --description "Emacs"
    emacs $argv
end

function nano --description "Nano"
    nano $argv
end

function code --description "VS Code"
    code $argv
end

function subl --description "Sublime"
    subl $argv
end

function tmux_new --description "Tmux new"
    tmux new -s $argv[1]
end

function tmux_attach --description "Tmux attach"
    tmux attach -t $argv[1]
end

function tmux_list --description "Tmux list"
    tmux list-sessions
end

function screen_new --description "Screen new"
    screen -S $argv[1]
end

function screen_list --description "Screen list"
    screen -ls
end

function ssh_copy --description "SSH copy ID"
    ssh-copy-id $argv[1]
end

function ssh_key --description "SSH keygen"
    ssh-keygen -t ed25519 -C $argv[1]
end

function ufw_status --description "UFW status"
    sudo ufw status
end

function ufw_enable --description "UFW enable"
    sudo ufw enable
end

function ufw_disable --description "UFW disable"
    sudo ufw disable
end

function ufw_allow --description "UFW allow"
    sudo ufw allow $argv[1]
end

function ipt --description "IPtables"
    sudo iptables -L -n
end

function ping1 --description "Ping"
    ping -c 4 $argv[1]
end

function ping6 --description "Ping6"
    ping6 -c 4 $argv[1]
end

function cal --description "Calendar"
    cal $argv
end

function bc1 --description "BC calc"
    echo $argv[1] | bc -l
end

function factor1 --description "Factor"
    factor $argv[1]
end

function calc --description "Calc"
    echo $argv[1] | bc -l
end

function hash --description "Hash"
    echo -n $argv[1] | $argv[2]sum
end

function edit --description "Edit"
    $EDITOR $argv[1]
end

function sor --description "Source"
    source $DOTFILES_DIR/shells/fish/aliases.fish
end

function source_all --description "Source all"
    source $DOTFILES_DIR/shells/fish/aliases.fish
end

function reload --description "Reload"
    source ~/.config/fish/config.fish
end

function bak --description "Backup"
    cp $argv[1] $argv[1].bak-(date +%Y%m%d%H%M%S)
end

function backup --description "Backup dir"
    cp -r $argv[1] $argv[1].backup-(date +%Y%m%d)
end

function clean --description "Clean"
    rm -rf $argv[1]
end

function clean_all --description "Clean all"
    rm -rf *
end

function clean_cache --description "Clean cache"
    rm -rf ~/.cache/*
end

function list_files --description "List files"
    find . -type f | sort
end

function list_dirs --description "List dirs"
    find . -type d | sort
end

function list_recents --description "Recent files"
    find . -type f -mmin -60
end

function list_large --description "Large files"
    find . -type f -size +$argv[1]M
end

function replace_all --description "Replace all"
    find . -type f -name "*.$argv[1]" -exec sed -i 's/$argv[2]/$argv[3]/g' {} \;
end

function check_syntax --description "Check syntax"
    fish -n $argv[1]
end

function server --description "HTTP server"
    python3 -m http.server $argv[1] -d $argv[2]
end

function rsync_push --description "Rsync push"
    rsync -avz $argv[1]/ $argv[2]@$argv[3]/$argv[4]/
end

function rsync_pull --description "Rsync pull"
    rsync -avz $argv[1]@$argv[2]/$argv[3]/ $argv[4]/
end

function ssh_exec --description "SSH exec"
    ssh $argv[1] $argv[2]
end

function scp1 --description "SCP"
    scp $argv[1] $argv[2]:$argv[3]
end

function template_script --description "Create template"
    printf '#!/usr/bin/env sh\nset -e\n' > $argv[2]; chmod +x $argv[2]
end

function grepall --description "Grep all"
    grep -rn $argv[1] .
end

function grep_file --description "Grep files"
    grep -l $argv[1]
end

function tailn --description "Tail N"
    tail -n $argv[1] $argv[2]
end

function headn --description "Head N"
    head -n $argv[1] $argv[2]
end

function read_file --description "Read file"
    cat $argv[1]
end

function write_file --description "Write file"
    printf '%s' $argv[1] > $argv[2]
end

function append_file --description "Append file"
    printf '%s' $argv[1] >> $argv[2]
end

function create_file --description "Create file"
    touch $argv[1]
end

function create_dir --description "Create dir"
    mkdir -p $argv[1]
end

function create_link --description "Create link"
    ln -s $argv[1] $argv[2]
end

function delete_file --description "Delete file"
    rm $argv[1]
end

function delete_dir --description "Delete dir"
    rm -rf $argv[1]
end

function move_file --description "Move file"
    mv $argv[1] $argv[2]
end

function copy_file --description "Copy file"
    cp $argv[1] $argv[2]
end

function copy_dir --description "Copy dir"
    cp -r $argv[1] $argv[2]
end

function count_lines --description "Count lines"
    wc -l $argv[1]
end

function count_files --description "Count files"
    find . -type f | wc -l
end

function stat_file --description "Stat file"
    stat $argv[1]
end

function loop --description "Loop"
    while true; $argv; sleep $argv[1]; end
end

function loop_n --description "Loop N"
    for i in (seq $argv[1]); $argv; end
end

function if_file --description "If file exists"
    if test -f $argv[1]; echo $argv[2]; else; echo $argv[3]; end
end

function if_dir --description "If dir exists"
    if test -d $argv[1]; echo $argv[2]; else; echo $argv[3]; end
end

function if_cmd --description "If command exists"
    if command -v $argv[1] > /dev/null; echo $argv[2]; else; echo $argv[3]; end
end

function url_encode --description "URL encode"
    python3 -c "import urllib.parse; print(urllib.parse.quote('$argv[1]'))"
end

function url_decode --description "URL decode"
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$argv[1]'))"
end

function base_encode --description "Base64 encode"
    echo -n $argv[1] | base64
end

function base_decode --description "Base64 decode"
    echo -n $argv[1] | base64 -d
end

function is_file --description "Is file"
    test -f $argv[1]
end

function is_dir --description "Is dir"
    test -d $argv[1]
end

function is_link --description "Is link"
    test -L $argv[1]
end

function is_cmd --description "Is command"
    command -v $argv[1] > /dev/null
end

function is_root --description "Is root"
    test "$EUID" -eq 0
end

function file_type --description "File type"
    file $argv[1]
end

function file_md5 --description "MD5 file"
    md5sum $argv[1]
end

function hash_sha256 --description "SHA256 file"
    shasum -a 256 $argv[1]
end

function path --description "PATH"
    echo $PATH | tr ':' '\n'
end

function path_add --description "PATH add"
    set -gx PATH $argv[1] $PATH
end

function env_get --description "Env get"
    printenv $argv[1]
end

function env_set --description "Env set"
    set -gx $argv[1] $argv[2]
end

function env_list --description "Env list"
    printenv | sort
end

function bang_bash --description "Shebang bash"
    printf '#!/usr/bin/env bash\n' > $argv[1]; chmod +x $argv[1]
end

function bang_sh --description "Shebang sh"
    printf '#!/usr/bin/env sh\n' > $argv[1]; chmod +x $argv[1]
end

function bang_python --description "Shebang python"
    printf '#!/usr/bin/env python3\n' > $argv[1]; chmod +x $argv[1]
end

function bang_node --description "Shebang node"
    printf '#!/usr/bin/env node\n' > $argv[1]; chmod +x $argv[1]
end

function run_file --description "Run file"
    $argv
end

function run_bg --description "Run background"
    $argv &
end

function run_nohup --description "Run nohup"
    nohup $argv &
end

function wait_file --description "Wait file"
    inotifywait -e close_write $argv[1]
end

function wait_dir --description "Wait dir"
    inotifywait -e create $argv[1]
end

function lock_file --description "Lock file"
    flock -n $argv[1] -c $argv[2]
end

function parallel --description "Parallel"
    parallel $argv
end

function iterate --description "Iterate"
    for i in $argv; echo $i; end
end

function iterate_dir --description "Iterate dir"
    for i in $argv[1]/*; echo $i; end
end

function recurse --description "Recurse"
    find $argv[1] -type f -exec $argv[2] {} \;
end

function batch --description "Batch"
    xargs -P 4 -I{} $argv[1] {} < $argv[2]
end

function teefile --description "Tee file"
    tee $argv[1]
end

function output_cmd --description "Output cmd"
    $argv > $argv[1]
end

function try --description "Try"
    $argv; or echo "Error: $status"
end

function throw --description "Throw"
    printf '%s\n' $argv[1] >&2; and exit 1
end

function ret --description "Return"
    return $argv[1]
end

function ret0 --description "Return 0"
    return 0
end

function ret1 --description "Return 1"
    return 1
end

function fn --description "Function"
    $argv
end

function ll --description "LL"
    ls -l $argv
end

function la --description "LA"
    ls -a $argv
end

function lt --description "LT"
    ls -lt $argv
end

function lh --description "LH"
    ls -lh $argv
end

function ld --description "LD"
    ls -ld $argv
end

function l1 --description "L1"
    ls -1 $argv
end

function ls_new --description "New files"
    ls -t | head -n 10
end

function ls_old --description "Old files"
    ls -t | tail -n 10
end

function ls_big --description "Big files"
    ls -lS | head -n 10
end

function pushd_new --description "Pushd new"
    pushd $argv[1] > /dev/null; and $argv[2]
end

function pushd_back --description "Pushd back"
    popd > /dev/null
end

function prompt --description "Prompt"
    set -g PS1 $argv[1]
end

function set_var --description "Set var"
    set $argv[1] $argv[2]
end

function set_env --description "Set env"
    set -gx $argv[1] $argv[2]
end

function set_alias --description "Set alias"
    alias $argv[1] $argv[2]
end

function unset_var --description "Unset var"
    set -e $argv[1]
end

function unset_env --description "Unset env"
    set -ge $argv[1]
end

function export_path --description "Export PATH"
    set -gx PATH $argv[1] $PATH
end

function export_lib --description "Export LIB"
    set -gx LD_LIBRARY_PATH $argv[1] $LD_LIBRARY_PATH
end

function export_pkg --description "Export PKG"
    set -gx PKG_CONFIG_PATH $argv[1] $PKG_CONFIG_PATH
end

function script --description "Script"
    chmod +x $argv[1]; and ./$argv[1]
end

function script_bash --description "Script bash"
    bash $argv[1]
end

function script_sh --description "Script sh"
    sh $argv[1]
end

function eval1 --description "Eval"
    eval $argv
end

function eval_file --description "Eval file"
    source $argv[1]
end

function cmd_sub --description "Command sub"
    echo ($argv)
end

function dots --description "CD dotfiles"
    cd $DOTFILES_DIR
end

function dotsedit --description "Edit dotfiles"
    cd $DOTFILES_DIR; and $EDITOR .
end

function dotsupdate --description "Update dotfiles"
    cd $DOTFILES_DIR; and git pull; and ./install.sh
end

function dotstatus --description "Dotfiles status"
    cd $DOTFILES_DIR; and git status
end

function dotdiff --description "Dotfiles diff"
    cd $DOTFILES_DIR; and git diff
end