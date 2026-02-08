# Dotfiles Cheat Sheet

## Quick Navigation

```bash
..          # cd ..
...         # cd ../..
....        # cd ../../..
.....       # cd ../../../..
-           # cd -
home        # cd ~
desk        # cd ~/Desktop
docs        # cd ~/Documents
dl          # cd ~/Downloads
```

## Listing Files

```bash
ls          # List files (with eza if available)
l           # ls -la
la          # ls -A
ll          # ls -lh
lt          # Tree view
lsize       # Sort by size
ltime       # Sort by time
```

## Git Commands

```bash
g           # git
ga          # git add
gaa         # git add --all
gc          # git commit
gcm "msg"   # git commit -m "msg"
gco         # git checkout
gcb         # git checkout -b
gd          # git diff
gds         # git diff --staged
gf          # git fetch
gfa         # git fetch --all
gl          # git log --oneline --graph --decorate
gp          # git push
gpl         # git pull
gs          # git status -sb
lazyg "msg" # git add . && commit && push
```

## Docker Commands

```bash
d           # docker
dc          # docker-compose
dps         # docker ps (formatted)
dpa         # docker ps -a
di          # docker images
dex         # docker exec -it
dr          # docker run -it --rm
dprune      # Clean up Docker
```

## Kubernetes Commands

```bash
k           # kubectl
kg          # kubectl get
kd          # kubectl describe
kl          # kubectl logs -f
kgp         # kubectl get pods
kgd         # kubectl get deployment
h           # helm
```

## Package Managers (Auto-detected)

### Arch (pacman)
```bash
pacs        # sudo pacman -S
pacr        # sudo pacman -Rs
pacu        # sudo pacman -Syu
```

### Debian/Ubuntu (apt)
```bash
apti        # sudo apt install
aptr        # sudo apt remove
aptu        # sudo apt update && upgrade
```

### Fedora (dnf)
```bash
dnfi        # sudo dnf install
dnfr        # sudo dnf remove
dnfu        # sudo dnf upgrade
```

## Development

### Python
```bash
py          # python3
pipi        # pip install
venv        # python3 -m venv
venva       # source venv/bin/activate
```

### Node.js
```bash
nr          # npm run
ns          # npm start
ni          # npm install
nid         # npm install --save-dev
```

### Rust
```bash
c           # cargo
cb          # cargo build
cbr         # cargo build --release
cr          # cargo run
ct          # cargo test
```

## System Commands

```bash
myip        # Show internal/external IPs
serve       # Start HTTP server
extract     # Extract any archive
mkcd        # mkdir && cd
bak         # Backup file with timestamp
passgen     # Generate password
weather     # Show weather
sysinfo     # System information
```

## Tmux Commands

```bash
tmux new    # New session
tmux attach # Attach to session
Ctrl+a |    # Split vertical
Ctrl+a -    # Split horizontal
Ctrl+a r    # Reload config
```

## Neovim Commands

```bash
<leader>ff  # Find files
<leader>fg  # Live grep
<leader>fb  # Buffers
<leader>e   # File explorer
<leader>t   # Terminal
```

## Makefile Commands

```bash
make install      # Install dotfiles
make update       # Pull and reload
make backup       # Create backup
make clean        # Uninstall
make test         # Test syntax
make lint         # Run shellcheck
make docker       # Test in Docker
```
