# =============================================================================
# Dynamic App Detection for Fish
# Detects installed apps and provides their aliases
# =============================================================================

# Check if app exists
function _has --description "Check if command exists"
    type -q $argv[1]
end

# =============================================================================
# Development Tools
# =============================================================================

if _has git
    abbr -a g git
    abbr -a gs git\ status\ --short\ --branch
    abbr -a ga git\ add
    abbr -a gaa git\ add\ -A
    abbr -a gc git\ commit
    abbr -a gcm git\ commit\ -m
    abbr -a gp git\ push
    abbr -a gl git\ log\ --oneline\ --decorate\ --graph\ --all\ -20
    abbr -a gd git\ diff
    abbr -a gco git\ checkout
    abbr -a gsw git\ switch
    abbr -a gst git\ stash\ push\ -u
end

if _has docker
    abbr -a d docker
    abbr -a dps docker\ ps
    abbr -a dpsa docker\ ps\ -a
    abbr -a di docker\ images
    abbr -a dc docker\ compose
    abbr -a dex docker\ exec\ -it
    abbr -a dlogs docker\ logs\ -f
    abbr -a dstop docker\ stop\ $(docker\ ps\ -q)
    abbr -a drm docker\ rm\ $(docker\ ps\ -aq)
end

if _has kubectl
    abbr -a k kubectl
    abbr -a kgp kubectl\ get\ pods
    abbr -a kgs kubectl\ get\ svc
    abbr -a kgd kubectl\ get\ deployments
    abbr -a kga kubectl\ get\ all
    abbr -a kctx kubectl\ config\ current-context
    abbr -a kd kubectl\ describe
    abbr -a kl kubectl\ logs
    abbr -a ka kubectl\ apply\ -f
    abbr -a kdel kubectl\ delete
end

if _has terraform
    abbr -a tf terraform
    abbr -a tfi terraform\ init
    abbr -a tfp terraform\ plan
    abbr -a tfa terraform\ apply
    abbr -a tfd terraform\ destroy
end

if _has ansible
    abbr -a a ansible
    abbr -a ap ansible-playbook
end

# =============================================================================
# Programming Languages
# =============================================================================

if _has python3
    abbr -a py python3
    abbr -a pipup python3\ -m\ pip\ install\ --upgrade\ pip
    abbr -a venv python3\ -m\ venv
end

if _has npm
    abbr -a nr npm\ run
    abbr -a ni npm\ install
    abbr -a nt npm\ test
    abbr -a nd npm\ run\ dev
end

if _has pnpm
    abbr -a pn pnpm
    abbr -a pni pnpm\ install
    abbr -a pnr pnpm\ run
end

if _has yarn
    abbr -a y yarn
    abbr -a yi yarn\ add
    abbr -a yr yarn\ run
end

if _has go
    abbr -a go go
    abbr -a gor go\ run
    abbr -a gob go\ build
end

if _has cargo
    abbr -a c cargo
    abbr -a cb cargo\ build
    abbr -a cr cargo\ run
    abbr -a ct cargo\ test
end

# =============================================================================
# CLI Enhancements
# =============================================================================

if _has eza
    abbr -a ls eza\ --icons=auto\ --group-directories-first
    abbr -a ll eza\ -lah\ --icons=auto\ --group-directories-first
    abbr -a la eza\ -a\ --icons=auto
    abbr -a lt eza\ --tree\ --level=2\ --icons=auto
end

if _has lsd
    abbr -a ls lsd\ --icon\ always\ --group-dirs-first
    abbr -a ll lsd\ -l\ --icon\ always\ --group-dirs-first
end

if _has bat
    abbr -a cat bat\ --paging=never
end

if _has rg
    abbr -a rg rg\ --hidden\ --glob\ \"!.git\"
end

if _has fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

if _has zoxide
    zoxide init fish | source
end

if _has starship
    starship init fish --print-full-init | source
end

if _has fastfetch
    abbr -a fetch fastfetch
end

if _has neofetch
    abbr -a neo neofetch
end

# =============================================================================
# Tmux
# =============================================================================

if _has tmux
    abbr -a t tmux
    abbr -a ta tmux\ attach
    abbr -a tl tmux\ list-sessions
    abbr -a tn tmux\ new-session\ -s
end

# =============================================================================
# System Tools
# =============================================================================

if _has systemctl
    abbr -a sc systemctl
    abbr -a scs systemctl\ status
    abbr -a scst systemctl\ start
    abbr -a scsp systemctl\ stop
    abbr -a scsr systemctl\ restart
    abbr -a scse systemctl\ enable
    abbr -a scsd systemctl\ disable
end

if _has journalctl
    abbr -a jc journalctl
    abbr -a jce journalctl\ -e
    abbr -a jcf journalctl\ -f
    abbr -a jcu journalctl\ -u
end

if _has nvidia-smi
    abbr -a gpu nvidia-smi
end

# =============================================================================
# Package Managers (if present)
# =============================================================================

if _has yay
    abbr -a yayi yay\ -S
    abbr -a yayup yay\ -Syu
end

if _has pacman
    abbr -a pacup sudo\ pacman\ -Syu
    abbr -a pacin sudo\ pacman\ -S
end

if _has apt
    abbr -a aptup sudo\ apt\ update\ &&\ sudo\ apt\ upgrade\ -y
    abbr -a aptin sudo\ apt\ install
end

if _has dnf
    abbr -a dnfup sudo\ dnf\ upgrade
    abbr -a dnfi sudo\ dnf\ install
end

if _has brew
    abbr -a brewup brew\ update\ &&\ brew\ upgrade
    abbr -a brewin brew\ install
end

# =============================================================================
# Editors
# =============================================================================

if _has nvim
    abbr -a v nvim
    abbr -a vi nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if _has vim
    abbr -a v vim
    abbr -a vi vim
    set -gx EDITOR vim
    set -gx VISUAL vim
end

if _has micro
    abbr -a m micro
end

if _has code
    abbr -a codel code\ .
end

# =============================================================================
# Utils
# =============================================================================

if _has tldr
    abbr -a tldr tldr
end

if _has curl
    abbr -a cur curl\ -fsSL
end

# Cleanup helper
functions -e _has