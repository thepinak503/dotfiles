# Direnv Configuration
# Directory-specific environment variables
# https://direnv.net/

# Automatically load .envrc files when entering directories
# Install: curl -sfL https://direnv.net/install.sh | bash

# Enable direnv hook for bash
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# =============================================================================
# DIRENV ALIASES
# =============================================================================

# Allow current directory's .envrc
alias dva='direnv allow'

# Deny current directory's .envrc
alias dvd='direnv deny'

# Revoke current directory's .envrc
alias dvr='direnv revoke'

# Reload current directory's environment
alias dvrl='direnv reload'

# Show current direnv status
alias dvst='direnv status'

# Edit current directory's .envrc
alias dve='$EDITOR .envrc'

# =============================================================================
# DIRENV FUNCTIONS
# =============================================================================

# Create a new .envrc with common patterns
direnv-init() {
    local template="${1:-default}"
    
    if [ -f ".envrc" ]; then
        echo "Warning: .envrc already exists!"
        read -p "Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 1
        fi
    fi
    
    case "$template" in
        python|py)
            cat > .envrc << 'ENVEOF'
# Python project environment
layout_python
export PYTHONPATH="${PWD}:${PYTHONPATH}"
export PYTHONDONTWRITEBYTECODE=1
ENVEOF
            ;;
        node|js)
            cat > .envrc << 'ENVEOF'
# Node.js project environment
layout_node
export PATH="${PWD}/node_modules/.bin:${PATH}"
ENVEOF
            ;;
        ruby|rb)
            cat > .envrc << 'ENVEOF'
# Ruby project environment
layout_ruby
ENVEOF
            ;;
        go)
            cat > .envrc << 'ENVEOF'
# Go project environment
export GOPATH="${PWD}/.gopath"
export PATH="${GOPATH}/bin:${PATH}"
ENVEOF
            ;;
        rust|rs)
            cat > .envrc << 'ENVEOF'
# Rust project environment
export RUST_BACKTRACE=1
ENVEOF
            ;;
        *)
            cat > .envrc << 'ENVEOF'
# Project environment
# Add your environment variables here
# export VAR=value
ENVEOF
            ;;
    esac
    
    echo "Created .envrc for $template project"
    direnv allow
}

# Create .envrc for Python virtualenv
direnv-python() {
    local venv_name="${1:-.venv}"
    
    cat > .envrc << EOF
# Python virtual environment
layout_python ${venv_name}
export PYTHONPATH="\${PWD}:\${PYTHONPATH}"
export PYTHONDONTWRITEBYTECODE=1
EOF
    
    direnv allow
    echo "Created .envrc for Python with venv: $venv_name"
}

# Create .envrc for Node.js project
direnv-node() {
    cat > .envrc << 'ENVEOF'
# Node.js project
layout_node
export PATH="${PWD}/node_modules/.bin:${PATH}"
ENVEOF
    
    direnv allow
    echo "Created .envrc for Node.js"
}

# =============================================================================
# DIRENV STDLIB EXTENSIONS
# =============================================================================

# These functions can be used in .envrc files

# layout_python() - Activate Python virtualenv
# Usage in .envrc: layout_python
# Or: layout_python /path/to/venv
layout_python() {
    local venv_path="${1:-.venv}"
    
    if [ -d "$venv_path" ]; then
        source "$venv_path/bin/activate"
    elif [ -d "venv" ]; then
        source "venv/bin/activate"
    elif [ -d ".venv" ]; then
        source ".venv/bin/activate"
    fi
}

# layout_node() - Add node_modules/.bin to PATH
# Usage in .envrc: layout_node
layout_node() {
    PATH_add node_modules/.bin
}

# layout_ruby() - Use rbenv or rvm
# Usage in .envrc: layout_ruby
layout_ruby() {
    if [ -f ".ruby-version" ]; then
        if command -v rbenv &>/dev/null; then
            eval "$(rbenv init -)"
        elif command -v rvm &>/dev/null; then
            source "$HOME/.rvm/scripts/rvm"
        fi
    fi
}

# use_nvm() - Use specific Node.js version with nvm
# Usage in .envrc: use nvm 18
use_nvm() {
    if [ -n "$1" ]; then
        export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm use "$1" 2>/dev/null || nvm install "$1"
    fi
}

# use_java() - Use specific Java version with jenv
# Usage in .envrc: use java 11
use_java() {
    if command -v jenv &>/dev/null; then
        export PATH="$HOME/.jenv/shims:${PATH}"
        jenv local "$1" 2>/dev/null || echo "Java version $1 not installed"
    fi
}