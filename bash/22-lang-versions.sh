#!/bin/bash
# Language Version Managers Configuration - OPTIMIZED VERSION
# nvm, pyenv, rbenv, go, rust, java, and more
# Features: Lazy loading for faster shell startup
# =============================================================================

# -----------------------------------------------------------------------------
# LAZY LOADING HELPER
# -----------------------------------------------------------------------------
# This function creates a lazy-loading wrapper for slow initialization scripts
# Usage: _lazy_load <command_name> <init_command> [extra_init]
_lazy_load() {
    local cmd="$1"
    local init="$2"
    local extra_init="${3:-}"
    
    eval "${cmd}() {
        unset -f ${cmd}
        ${init}
        ${extra_init}
        ${cmd} \"\$@\"
    }"
}

# -----------------------------------------------------------------------------
# NODE.JS (NVM - Node Version Manager) - LAZY LOADED
# -----------------------------------------------------------------------------
# Only load NVM when actually needed, saving 200-500ms on shell startup

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Setup lazy loading for nvm, node, npm, and related commands
if [[ -d "$NVM_DIR" ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # Wrapper function that loads nvm on first use
    nvm() {
        unset -f nvm node npm npx nvmi nvml nvmu nvmd nvmr
        export NVM_DIR="$NVM_DIR"
        [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
        [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
        nvm "$@"
    }
    
    # Lazy load node
    node() {
        unset -f nvm node npm npx nvmi nvml nvmu nvmd nvmr
        export NVM_DIR="$NVM_DIR"
        [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
        node "$@"
    }
    
    # Lazy load npm
    npm() {
        unset -f nvm node npm npx nvmi nvml nvmu nvmd nvmr
        export NVM_DIR="$NVM_DIR"
        [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
        npm "$@"
    }
    
    # Lazy load npx
    npx() {
        unset -f nvm node npm npx nvmi nvml nvmu nvmd nvmr
        export NVM_DIR="$NVM_DIR"
        [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
        npx "$@"
    }
    
    # NVM aliases (lazy loaded)
    nvmi() { nvm install "$@"; }
    nvml() { nvm list "$@"; }
    nvmu() { nvm use "$@"; }
    nvmd() { nvm alias default "$@"; }
    nvmr() { nvm reinstall-packages "$@"; }
fi

# -----------------------------------------------------------------------------
# PYTHON (PYENV) - LAZY LOADED
# -----------------------------------------------------------------------------
# Only initialize pyenv when python command is used

export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

if [[ -d "$PYENV_ROOT" ]]; then
    # Add pyenv to PATH for initial detection
    _path_prepend "$PYENV_ROOT/bin"
    
    # Lazy load python commands
    python() {
        unset -f python python3 pip pip3 pyi pyl pyu pylocal pyg pyv pyva pyvd
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
        python "$@"
    }
    
    python3() {
        unset -f python python3 pip pip3 pyi pyl pyu pylocal pyg pyv pyva pyvd
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
        python3 "$@"
    }
    
    pip() {
        unset -f python python3 pip pip3 pyi pyl pyu pylocal pyg pyv pyva pyvd
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
        pip "$@"
    }
    
    pip3() {
        unset -f python python3 pip pip3 pyi pyl pyu pylocal pyg pyv pyva pyvd
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
        pip3 "$@"
    }
    
    pyenv() {
        unset -f python python3 pip pip3 pyi pyl pyu pylocal pyg pyv pyva pyvd pyenv
        _path_prepend "$PYENV_ROOT/bin"
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)" 2>/dev/null || true
        pyenv "$@"
    }
    
    # Pyenv aliases
    pyi() { pyenv install "$@"; }
    pyl() { pyenv versions "$@"; }
    pyu() { pyenv global "$@"; }
    pylocal() { pyenv local "$@"; }
    pyg() { pyenv global "$@"; }
    pyv() { pyenv virtualenv "$@"; }
    pyva() { pyenv virtualenvs "$@"; }
    pyvd() { pyenv virtualenv-delete "$@"; }
fi

# Python virtual environment shortcuts (always available)
alias pyvenv='python3 -m venv .venv'
alias pyact='source .venv/bin/activate'
alias pydeact='deactivate'

# -----------------------------------------------------------------------------
# RUBY (RBENV) - LAZY LOADED
# -----------------------------------------------------------------------------

export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"

if [[ -d "$RBENV_ROOT" ]]; then
    _path_prepend "$RBENV_ROOT/bin"
    
    rbenv() {
        unset -f rbenv ruby gem bundle rbi rbl rbu rblocal
        eval "$(command rbenv init -)"
        rbenv "$@"
    }
    
    ruby() {
        unset -f rbenv ruby gem bundle rbi rbl rbu rblocal
        eval "$(rbenv init -)"
        ruby "$@"
    }
    
    gem() {
        unset -f rbenv ruby gem bundle rbi rbl rbu rblocal
        eval "$(rbenv init -)"
        gem "$@"
    }
    
    bundle() {
        unset -f rbenv ruby gem bundle rbi rbl rbu rblocal
        eval "$(rbenv init -)"
        bundle "$@"
    }
    
    # Rbenv aliases
    rbi() { rbenv install "$@"; }
    rbl() { rbenv versions "$@"; }
    rbu() { rbenv global "$@"; }
    rblocal() { rbenv local "$@"; }
fi

# -----------------------------------------------------------------------------
# GO - STANDARD LOADING (Fast enough)
# -----------------------------------------------------------------------------

if command -v go &>/dev/null || [[ -d "$HOME/go" ]]; then
    export GOPATH="${GOPATH:-$HOME/go}"
    _path_append "$GOPATH/bin"
    [[ -d "/usr/local/go/bin" ]] && _path_prepend "/usr/local/go/bin"
    
    # Go aliases
    alias gocd='cd "$GOPATH"'
    alias gosrc='cd "$GOPATH/src"'
    alias gob='go build'
    alias gor='go run'
    alias got='go test'
    alias goi='go install'
    alias gof='go fmt'
    alias gomt='go mod tidy'
fi

# -----------------------------------------------------------------------------
# RUST (RUSTUP/CARGO) - LAZY LOADED
# -----------------------------------------------------------------------------

if [[ -d "$HOME/.cargo" ]]; then
    # Lazy load cargo
    cargo() {
        unset -f cargo rustc rustup ci cb cr ct cc cf ccl cu
        source "$HOME/.cargo/env" 2>/dev/null || true
        _path_prepend "$HOME/.cargo/bin"
        cargo "$@"
    }
    
    rustc() {
        unset -f cargo rustc rustup ci cb cr ct cc cf ccl cu
        source "$HOME/.cargo/env" 2>/dev/null || true
        _path_prepend "$HOME/.cargo/bin"
        rustc "$@"
    }
    
    rustup() {
        unset -f cargo rustc rustup ci cb cr ct cc cf ccl cu
        source "$HOME/.cargo/env" 2>/dev/null || true
        _path_prepend "$HOME/.cargo/bin"
        rustup "$@"
    }
    
    # Rust aliases
    ci() { cargo install "$@"; }
    cb() { cargo build "$@"; }
    cr() { cargo run "$@"; }
    ct() { cargo test "$@"; }
    cc() { cargo check "$@"; }
    cf() { cargo fmt "$@"; }
    ccl() { cargo clippy "$@"; }
    cu() { cargo update "$@"; }
fi

# -----------------------------------------------------------------------------
# JAVA (JENV) - LAZY LOADED
# -----------------------------------------------------------------------------

export JENV_ROOT="${JENV_ROOT:-$HOME/.jenv}"

if [[ -d "$JENV_ROOT" ]]; then
    _path_prepend "$JENV_ROOT/bin"
    
    jenv() {
        unset -f jenv java javac ji jl ju
        eval "$(command jenv init -)"
        jenv "$@"
    }
    
    java() {
        unset -f jenv java javac ji jl ju
        eval "$(jenv init -)"
        java "$@"
    }
    
    javac() {
        unset -f jenv java javac ji jl ju
        eval "$(jenv init -)"
        javac "$@"
    }
    
    # Jenv aliases
    ji() { jenv add "$@"; }
    jl() { jenv versions "$@"; }
    ju() { jenv global "$@"; }
fi

# -----------------------------------------------------------------------------
# DENO - STANDARD
# -----------------------------------------------------------------------------

if [[ -d "$HOME/.deno" ]]; then
    export DENO_INSTALL="$HOME/.deno"
    _path_append "$DENO_INSTALL/bin"
    
    # Deno aliases
    alias dr='deno run'
    alias db='deno bundle'
    alias dc='deno compile'
    alias df='deno fmt'
    alias dt='deno test'
fi

# -----------------------------------------------------------------------------
# BUN - STANDARD
# -----------------------------------------------------------------------------

if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    _path_append "$BUN_INSTALL/bin"
fi

# -----------------------------------------------------------------------------
# FLUTTER - STANDARD
# -----------------------------------------------------------------------------

if [[ -d "$HOME/flutter" ]]; then
    _path_append "$HOME/flutter/bin"
    export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
    if [[ -d "$ANDROID_HOME" ]]; then
        _path_prepend "$ANDROID_HOME/cmdline-tools/latest/bin"
        _path_append "$ANDROID_HOME/platform-tools"
    fi
fi

# -----------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------

# Install all version managers
install-version-managers() {
    echo "Installing language version managers..."
    
    # NVM
    if [[ ! -d "$HOME/.nvm" ]]; then
        echo "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi
    
    # Pyenv
    if ! command -v pyenv &>/dev/null; then
        echo "Installing Pyenv..."
        curl https://pyenv.run | bash
    fi
    
    # Rbenv
    if ! command -v rbenv &>/dev/null; then
        echo "Installing Rbenv..."
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    fi
    
    # Rust
    if ! command -v rustc &>/dev/null; then
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
    
    # Go (if not present)
    if ! command -v go &>/dev/null; then
        echo "Note: Install Go from https://golang.org/dl/"
    fi
    
    echo "Version managers installation complete!"
    echo "Please restart your shell or source your profile."
}

# List all language versions
lang-versions() {
    echo "=== Language Version Managers ==="
    echo ""
    
    if command -v nvm &>/dev/null; then
        echo "Node (NVM):"
        nvm list 2>/dev/null || echo "  nvm not loaded"
        echo ""
    fi
    
    if command -v pyenv &>/dev/null; then
        echo "Python (Pyenv):"
        pyenv versions
        echo ""
    fi
    
    if command -v rbenv &>/dev/null; then
        echo "Ruby (Rbenv):"
        rbenv versions
        echo ""
    fi
    
    if command -v rustc &>/dev/null; then
        echo "Rust:"
        rustc --version
        cargo --version
        echo ""
    fi
    
    if command -v go &>/dev/null; then
        echo "Go:"
        go version
        echo ""
    fi
    
    if command -v jenv &>/dev/null; then
        echo "Java (Jenv):"
        jenv versions
        echo ""
    fi
}

# Check if lazy loading is active
check-lazy-loading() {
    echo "=== Lazy Loading Status ==="
    echo ""
    
    if declare -f node &>/dev/null && [[ "$(declare -f node)" == *"unset -f"* ]]; then
        echo "✓ NVM: Lazy loaded (node command is wrapped)"
    else
        echo "✗ NVM: Not lazy loaded or already initialized"
    fi
    
    if declare -f python &>/dev/null && [[ "$(declare -f python)" == *"unset -f"* ]]; then
        echo "✓ Pyenv: Lazy loaded (python command is wrapped)"
    else
        echo "✗ Pyenv: Not lazy loaded or already initialized"
    fi
    
    if declare -f cargo &>/dev/null && [[ "$(declare -f cargo)" == *"unset -f"* ]]; then
        echo "✓ Rust: Lazy loaded (cargo command is wrapped)"
    else
        echo "✗ Rust: Not lazy loaded or already initialized"
    fi
    
    if declare -f rbenv &>/dev/null && [[ "$(declare -f rbenv)" == *"unset -f"* ]]; then
        echo "✓ Rbenv: Lazy loaded"
    else
        echo "✗ Rbenv: Not lazy loaded or already initialized"
    fi
    
    echo ""
    echo "Note: Commands will be fully initialized on first use"
}
