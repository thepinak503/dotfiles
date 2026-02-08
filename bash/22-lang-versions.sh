#!/bin/bash
# Language Version Managers Configuration
# nvm, pyenv, rbenv, go, rust, java, and more

# =============================================================================
# NODE.JS (NVM - Node Version Manager)
# =============================================================================

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Load nvm bash completion
if command -v nvm &>/dev/null; then
    # NVM aliases
    alias nvmi='nvm install'
    alias nvml='nvm list'
    alias nvmu='nvm use'
    alias nvmd='nvm alias default'
    alias nvmr='nvm reinstall-packages'
fi

# =============================================================================
# PYTHON (PYENV)
# =============================================================================

if command -v pyenv &>/dev/null || [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)" 2>/dev/null || true
    
    # Pyenv aliases
    alias pyi='pyenv install'
    alias pyl='pyenv versions'
    alias pyu='pyenv global'
    alias pylocal='pyenv local'
    alias pyg='pyenv global'
    alias pyv='pyenv virtualenv'
    alias pyva='pyenv virtualenvs'
    alias pyvd='pyenv virtualenv-delete'
fi

# Python virtual environment shortcuts
alias pyvenv='python3 -m venv .venv'
alias pyact='source .venv/bin/activate'
alias pydeact='deactivate'

# =============================================================================
# RUBY (RBENV)
# =============================================================================

if command -v rbenv &>/dev/null || [ -d "$HOME/.rbenv" ]; then
    export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"
    
    # Rbenv aliases
    alias rbi='rbenv install'
    alias rbl='rbenv versions'
    alias rbu='rbenv global'
    alias rblocal='rbenv local'
fi

# =============================================================================
# GO
# =============================================================================

if command -v go &>/dev/null || [ -d "$HOME/go" ]; then
    export GOPATH="${GOPATH:-$HOME/go}"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="/usr/local/go/bin:$PATH"
    
    # Go aliases
    alias gocd='cd $GOPATH'
    alias gosrc='cd $GOPATH/src'
    alias gob='go build'
    alias gor='go run'
    alias got='go test'
    alias goi='go install'
    alias gof='go fmt'
    alias gomt='go mod tidy'
fi

# =============================================================================
# RUST (RUSTUP/CARGO)
# =============================================================================

if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env" 2>/dev/null || true
    export PATH="$HOME/.cargo/bin:$PATH"
    
    # Rust aliases
    alias ci='cargo install'
    alias cb='cargo build'
    alias cr='cargo run'
    alias ct='cargo test'
    alias cc='cargo check'
    alias cf='cargo fmt'
    alias ccl='cargo clippy'
    alias cu='cargo update'
fi

# =============================================================================
# JAVA (JENV)
# =============================================================================

if command -v jenv &>/dev/null || [ -d "$HOME/.jenv" ]; then
    export JENV_ROOT="${JENV_ROOT:-$HOME/.jenv}"
    export PATH="$JENV_ROOT/bin:$PATH"
    eval "$(jenv init -)"
    
    # Jenv aliases
    alias ji='jenv add'
    alias jl='jenv versions'
    alias ju='jenv global'
fi

# =============================================================================
# DENO
# =============================================================================

if [ -d "$HOME/.deno" ]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
    
    # Deno aliases
    alias dr='deno run'
    alias db='deno bundle'
    alias dc='deno compile'
    alias df='deno fmt'
    alias dt='deno test'
fi

# =============================================================================
# BUN
# =============================================================================

if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# =============================================================================
# FLUTTER
# =============================================================================

if [ -d "$HOME/flutter" ]; then
    export PATH="$HOME/flutter/bin:$PATH"
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
fi

# =============================================================================
# FUNCTIONS
# =============================================================================

# Install all version managers
install-version-managers() {
    echo "Installing language version managers..."
    
    # NVM
    if [ ! -d "$HOME/.nvm" ]; then
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