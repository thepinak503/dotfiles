#!/usr/bin/env bash
# =============================================================================
# 08-DEVELOPMENT.SH - Development Environment Aliases
# Modes: advanced, ultra-nerd
# =============================================================================

[[ "$DOTFILES_MODE" == "basic" ]] && return

# =============================================================================
# PYTHON DEVELOPMENT
# =============================================================================

# Python shortcuts
alias py='python3'
alias py2='python2'
alias py3='python3'
alias ipy='ipython'
alias ipynb='jupyter notebook'

# Pip shortcuts
alias pip='pip3'
alias pipi='pip install'
alias pipu='pip install --upgrade'
alias pipun='pip uninstall'
alias pipl='pip list'
alias pipf='pip freeze'
alias pipo='pip list --outdated'
alias pipc='pip check'

# Virtual environments
alias venv='python3 -m venv'
alias venva='source venv/bin/activate'
alias venvd='deactivate'

# Poetry
if command -v poetry &>/dev/null; then
    alias po='poetry'
    alias poa='poetry add'
    alias pou='poetry update'
    alias poi='poetry install'
    alias por='poetry run'
    alias pos='poetry shell'
    alias pob='poetry build'
    alias pop='poetry publish'
    alias pock='poetry check'
    alias poshow='poetry show'
    alias pol='poetry lock'
fi

# Conda
if command -v conda &>/dev/null; then
    alias ca='conda activate'
    alias cd='conda deactivate'
    alias ci='conda install'
    alias cu='conda update'
    alias cr='conda remove'
    alias cl='conda list'
    alias ce='conda env'
    alias cel='conda env list'
fi

# Pyenv
if command -v pyenv &>/dev/null; then
    alias pyv='pyenv versions'
    alias pyi='pyenv install'
    alias pyu='pyenv uninstall'
    alias pyl='pyenv local'
    alias pyg='pyenv global'
    alias pys='pyenv shell'
fi

# =============================================================================
# NODE.JS DEVELOPMENT
# =============================================================================

# npm shortcuts
alias nr='npm run'
alias ns='npm start'
alias nb='npm run build'
alias nt='npm test'
alias nd='npm run dev'
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nu='npm uninstall'
alias nup='npm update'
alias nls='npm list --depth=0'
alias nout='npm outdated'
alias nci='npm ci'
alias ncache='npm cache clean --force'
alias ninfo='npm info'
alias npr='npm prune'

# yarn shortcuts
if command -v yarn &>/dev/null; then
    alias yr='yarn run'
    alias ys='yarn start'
    alias yb='yarn build'
    alias yt='yarn test'
    alias ya='yarn add'
    alias yad='yarn add --dev'
    alias yag='yarn global add'
    alias yrm='yarn remove'
    alias yu='yarn upgrade'
    alias yl='yarn list'
    alias yout='yarn outdated'
    alias yci='yarn install --frozen-lockfile'
fi

# pnpm shortcuts
if command -v pnpm &>/dev/null; then
    alias pn='pnpm'
    alias pnr='pnpm run'
    alias pns='pnpm start'
    alias pnb='pnpm build'
    alias pni='pnpm install'
    alias pnid='pnpm install --save-dev'
    alias pnig='pnpm install -g'
    alias pnu='pnpm uninstall'
    alias pnu='pnpm update'
    alias pnl='pnpm list'
fi

# nvm shortcuts
if [[ -d "$NVM_DIR" ]]; then
    alias nvmu='nvm use'
    alias nvml='nvm list'
    alias nvmi='nvm install'
    alias nvmr='nvm reinstall-packages'
fi

# =============================================================================
# RUST DEVELOPMENT
# =============================================================================

# Install Cargo/Rust on Amazon Linux if not present
install_cargo_amazon_linux() {
    if [[ "$DISTRO_ID" == "amzn" ]] && ! command -v cargo &>/dev/null; then
        echo "Installing Rust/Cargo on Amazon Linux..."
        
        # Method 1: Use yum to install rust (Amazon Linux 2022+)
        if command -v yum &>/dev/null; then
            sudo yum install -y rust cargo 2>/dev/null && return 0
        fi
        
        # Method 2: Use dnf to install rust (Amazon Linux 2023+)
        if command -v dnf &>/dev/null; then
            sudo dnf install -y rust cargo 2>/dev/null && return 0
        fi
        
        # Method 3: Install via rustup (recommended)
        echo "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env" 2>/dev/null || true
        
        # Add to PATH for current session
        export PATH="$HOME/.cargo/bin:$PATH"
        
        if command -v cargo &>/dev/null; then
            echo "✓ Rust/Cargo installed successfully!"
            return 0
        else
            echo "✗ Failed to install Rust/Cargo"
            return 1
        fi
    fi
    return 0
}

# Universal Cargo installation function
install_cargo() {
    if command -v cargo &>/dev/null; then
        echo "Cargo is already installed!"
        cargo --version
        return 0
    fi
    
    echo "Installing Rust/Cargo..."
    
    case "$DISTRO_FAMILY" in
        "rhel")
            # Amazon Linux, RHEL, CentOS, Fedora
            if command -v dnf &>/dev/null; then
                sudo dnf install -y rust cargo
            elif command -v yum &>/dev/null; then
                sudo yum install -y rust cargo
            fi
            ;;
        "debian")
            # Debian, Ubuntu
            sudo apt update
            sudo apt install -y rustc cargo
            ;;
        "arch")
            # Arch Linux
            sudo pacman -S rust
            ;;
        "suse")
            # openSUSE
            sudo zypper install -y rust cargo
            ;;
        "alpine")
            # Alpine Linux
            sudo apk add rust cargo
            ;;
        *)
            # Fallback to rustup for any other distro
            echo "Installing via rustup (recommended method)..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source "$HOME/.cargo/env" 2>/dev/null || true
            export PATH="$HOME/.cargo/bin:$PATH"
            ;;
    esac
    
    # Verify installation
    if command -v cargo &>/dev/null; then
        echo "✓ Rust/Cargo installed successfully!"
        cargo --version
    else
        echo "✗ Failed to install Rust/Cargo. You may need to install it manually."
        return 1
    fi
}

# Auto-install Cargo on Amazon Linux if needed
if [[ "$DISTRO_ID" == "amzn" ]] && [[ -n "$BASH_VERSION" ]]; then
    install_cargo_amazon_linux
fi

if command -v cargo &>/dev/null; then
    alias c='cargo'
    alias cb='cargo build'
    alias cbr='cargo build --release'
    alias cr='cargo run'
    alias ct='cargo test'
    alias cc='cargo check'
    alias cf='cargo fmt'
    alias cl='cargo clippy'
    alias cu='cargo update'
    alias ca='cargo add'
    alias cdoc='cargo doc --open'
    alias cnew='cargo new'
    alias cinit='cargo init'
    alias cpub='cargo publish'
    alias csearch='cargo search'
    alias ctree='cargo tree'
    alias cinstall='cargo install'
    alias cuninstall='cargo uninstall'
    alias cwatch='cargo watch -x run'
    alias cbench='cargo bench'
    alias cfix='cargo fix'
    alias cupdate='cargo update'
    alias cgenerate='cargo generate'
fi

# rustup
if command -v rustup &>/dev/null; then
    alias rup='rustup update'
    alias rul='rustup toolchain list'
    alias rui='rustup toolchain install'
    alias ruu='rustup self update'
fi

# =============================================================================
# GO DEVELOPMENT
# =============================================================================

if command -v go &>/dev/null; then
    alias gob='go build'
    alias gor='go run'
    alias got='go test'
    alias goi='go install'
    alias gog='go get'
    alias gom='go mod'
    alias gomt='go mod tidy'
    alias gomv='go mod vendor'
    alias gof='go fmt'
    alias gov='go vet'
    alias goc='go clean'
    alias gobld='go build -ldflags="-s -w"'
fi

# =============================================================================
# JAVA DEVELOPMENT
# =============================================================================

if command -v mvn &>/dev/null; then
    alias mvnc='mvn clean'
    alias mvnci='mvn clean install'
    alias mvni='mvn install'
    alias mvnp='mvn package'
    alias mvnt='mvn test'
    alias mvnq='mvn dependency:tree'
    alias mvnapi='mvn dependency:analyze'
fi

if command -v gradle &>/dev/null; then
    alias gr='gradle'
    alias grb='gradle build'
    alias grt='gradle test'
    alias grc='gradle clean'
    alias grcb='gradle clean build'
    alias grr='gradle run'
fi

# =============================================================================
# RUBY DEVELOPMENT
# =============================================================================

if command -v ruby &>/dev/null; then
    alias rb='ruby'
    alias rbi='bundle install'
    alias rbe='bundle exec'
    alias rbu='bundle update'
    alias rbg='gem'
    alias rbginstall='gem install'
    alias rbguninstall='gem uninstall'
    alias rbglist='gem list'
fi

# =============================================================================
# DOCKER DEVELOPMENT
# =============================================================================

# Basic Docker
alias d='docker'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias di='docker images'
alias dls='docker images'
alias dr='docker run -it --rm'
alias dri='docker run -it'
alias dex='docker exec -it'
alias dl='docker logs -f'
alias dlf='docker logs -f'
alias dinspect='docker inspect'
alias dip='docker inspect --format="{{.NetworkSettings.IPAddress}}"'

# Docker build
alias db='docker build'
alias dbt='docker build -t'
alias dprune='docker system prune -af'
alias dprunev='docker volume prune -f'
alias dprunei='docker image prune -af'
alias dstats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
alias dtop='docker top'
alias dpause='docker pause'
alias dunpause='docker unpause'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'
alias dtag='docker tag'
alias dpush='docker push'
alias dpull='docker pull'

# Docker compose
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcdv='docker-compose down -v'
alias dcr='docker-compose restart'
alias dcb='docker-compose build'
alias dcl='docker-compose logs -f'
alias dclf='docker-compose logs -f'
alias dce='docker-compose exec'
alias dcs='docker-compose stop'
alias dcstart='docker-compose start'
alias dcrm='docker-compose rm'
alias dcpull='docker-compose pull'
alias dcps='docker-compose ps'
alias dctop='docker-compose top'

# Docker volume & network
alias dvol='docker volume'
alias dvolrm='docker volume rm'
alias dvolprune='docker volume prune'
alias dnet='docker network'
alias dnetls='docker network ls'
alias dnetrm='docker network rm'

# =============================================================================
# KUBERNETES (K8s)
# =============================================================================

if command -v kubectl &>/dev/null; then
    # Basic kubectl
    alias k='kubectl'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kc='kubectl create'
    alias ka='kubectl apply'
    alias kdel='kubectl delete'
    alias kedit='kubectl edit'
    alias kex='kubectl exec -it'
    alias klogs='kubectl logs'
    alias kl='kubectl logs -f'
    alias klf='kubectl logs -f'
    alias kp='kubectl proxy'
    alias kpf='kubectl port-forward'
    alias ktop='kubectl top'
    alias kexplain='kubectl explain'
    alias kapi='kubectl api-resources'
    
    # Get resources
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgd='kubectl get deployment'
    alias kgn='kubectl get nodes'
    alias kgrs='kubectl get replicaset'
    alias kgsa='kubectl get sa'
    alias kgcm='kubectl get configmap'
    alias kgsec='kubectl get secret'
    alias kgns='kubectl get namespace'
    alias kg ing='kubectl get ingress'
    alias kgpv='kubectl get pv'
    alias kgpvc='kubectl get pvc'
    alias kgjob='kubectl get job'
    alias kgcj='kubectl get cronjob'
    alias kgr='kubectl get role'
    alias kgrb='kubectl get rolebinding'
    
    # Describe resources
    alias kdp='kubectl describe pod'
    alias kds='kubectl describe svc'
    alias kdd='kubectl describe deployment'
    alias kdn='kubectl describe node'
    
    # Config
    alias kcgc='kubectl config get-contexts'
    alias kcuc='kubectl config use-context'
    alias kccc='kubectl config current-context'
    alias kcsc='kubectl config set-context'
    alias kcdc='kubectl config delete-context'
    alias kcn='kubectl config set-context --current --namespace'
    
    # All namespaces
    alias kga='kubectl get all'
    alias kgaa='kubectl get all --all-namespaces'
    alias kgpa='kubectl get pods --all-namespaces'
    alias kgsa='kubectl get svc --all-namespaces'
    
    # Watch
    alias kgpw='kubectl get pods --watch'
    alias kgdw='kubectl get deployment --watch'
    
    # YAML output
    alias kgpy='kubectl get pod -o yaml'
    alias kgsy='kubectl get svc -o yaml'
    alias kgdy='kubectl get deployment -o yaml'
    alias kgjy='kubectl get job -o yaml'
    
    # Shortcuts
    alias krun='kubectl run'
    alias kscale='kubectl scale'
    alias kroll='kubectl rollout'
    alias krsd='kubectl rollout status deployment'
    alias kru='kubectl rollout undo'
    alias krh='kubectl rollout history'
    
    # Helm
    if command -v helm &>/dev/null; then
        alias h='helm'
        alias hin='helm install'
        alias hup='helm upgrade'
        alias hdel='helm delete'
        alias hls='helm list'
        alias hsearch='helm search hub'
        alias hrepo='helm repo'
        alias hrepoadd='helm repo add'
        alias hrepoup='helm repo update'
        alias hstatus='helm status'
        alias hget='helm get'
        alias hhist='helm history'
        alias hrollback='helm rollback'
    fi
fi

# =============================================================================
# TERRAFORM / INFRASTRUCTURE
# =============================================================================

if command -v terraform &>/dev/null; then
    alias tf='terraform'
    alias tfa='terraform apply'
    alias tfauto='terraform apply -auto-approve'
    alias tfc='terraform console'
    alias tfd='terraform destroy'
    alias tff='terraform fmt'
    alias tfi='terraform init'
    alias tfiu='terraform init -upgrade'
    alias tfo='terraform output'
    alias tfp='terraform plan'
    alias tfrefresh='terraform refresh'
    alias tfs='terraform show'
    alias tfstate='terraform state'
    alias tfst='terraform state list'
    alias tfsv='terraform state mv'
    alias tfrm='terraform state rm'
    alias tfimp='terraform import'
    alias tfv='terraform validate'
    alias tfver='terraform version'
    alias tfw='terraform workspace'
    alias tfwl='terraform workspace list'
    alias tfws='terraform workspace select'
    alias tfwn='terraform workspace new'
    alias tfwd='terraform workspace delete'
    alias tfget='terraform get'
    alias tfgraph='terraform graph'
    alias tfpull='terraform state pull'
    alias tfpush='terraform state push'
fi

# =============================================================================
# ANSIBLE
# =============================================================================

if command -v ansible &>/dev/null; then
    alias an='ansible'
    alias anp='ansible-playbook'
    alias ang='ansible-galaxy'
    alias anv='ansible-vault'
    alias andoc='ansible-doc'
    alias aninv='ansible-inventory'
    alias anconsole='ansible-console'
    alias anpull='ansible-pull'
fi

# =============================================================================
# AWS CLI
# =============================================================================

if command -v aws &>/dev/null; then
    alias awsls='aws s3 ls'
    alias awscp='aws s3 cp'
    alias awssync='aws s3 sync'
    alias awsmv='aws s3 mv'
    alias awsrn='aws s3 mv'
    alias awsrmb='aws s3 rm'
    alias awsrb='aws s3 rb'
    alias awsmbs='aws s3 mb'
    alias awswho='aws sts get-caller-identity'
    alias awsconf='aws configure'
    alias awslist='aws configure list'
    alias awsec2='aws ec2'
    alias awsrds='aws rds'
    alias awsiam='aws iam'
    alias awslambda='aws lambda'
    alias awscf='aws cloudformation'
    alias awsecs='aws ecs'
    alias awseks='aws eks'
fi

# =============================================================================
# VERSION CONTROL (Beyond Git)
# =============================================================================

# Mercurial
if command -v hg &>/dev/null; then
    alias hga='hg add'
    alias hgc='hg commit'
    alias hgp='hg push'
    alias hgpull='hg pull'
    alias hgl='hg log'
    alias hgs='hg status'
    alias hgd='hg diff'
    alias hgu='hg update'
fi

# SVN
if command -v svn &>/dev/null; then
    alias svna='svn add'
    alias svnc='svn commit'
    alias svns='svn status'
    alias svnu='svn update'
    alias svnl='svn log'
    alias svnd='svn diff'
    alias svnco='svn checkout'
fi
