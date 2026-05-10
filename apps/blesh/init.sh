# blerc -- ble.sh configuration
# optimized for dark terminal, maximum productivity

# --- General Options ---
bleopt char_width_mode=auto
bleopt input_encoding=UTF-8
bleopt vbell_default_message=' BEL '
bleopt vbell_duration=2000
bleopt vbell_align=right

# --- Completion ---
bleopt complete_auto_complete=1
bleopt complete_auto_delay=300
bleopt complete_auto_history=1
bleopt complete_ambiguous=1
bleopt complete_menu_complete=1
bleopt complete_menu_filter=1

# sabbrev (static abbreviations, like zsh abbreviations)
ble-sabbrev lg="lazygit"
ble-sabbrev ld="lazydocker"
ble-sabbrev gc="git commit"
ble-sabbrev gca="git commit --amend"
ble-sabbrev gp="git push"
ble-sabbrev gpl="git pull"
ble-sabbrev gst="git status"
ble-sabbrev gd="git diff"
ble-sabbrev gco="git checkout"
ble-sabbrev gb="git branch"
ble-sabbrev gl="git log"
ble-sabbrev ga="git add"
ble-sabbrev gr="git remote"
ble-sabbrev ns="npm start"
ble-sabbrev nr="npm run"
ble-sabbrev ni="npm install"
ble-sabbrev nrb="npm run build"
ble-sabbrev nrd="npm run dev"
ble-sabbrev nrt="npm run test"
ble-sabbrev ys="yarn start"
ble-sabbrev yr="yarn run"
ble-sabbrev yi="yarn install"
ble-sabbrev ps="pnpm start"
ble-sabbrev pr="pnpm run"
ble-sabbrev pi="pnpm install"
ble-sabbrev k="kubectl"
ble-sabbrev kg="kubectl get"
ble-sabbrev kgp="kubectl get pods"
ble-sabbrev kgs="kubectl get services"
ble-sabbrev kgd="kubectl get deployments"
ble-sabbrev kl="kubectl logs"
ble-sabbrev kx="kubectl exec -it"
ble-sabbrev tf="terraform"
ble-sabbrev tfi="terraform init"
ble-sabbrev tfa="terraform apply"
ble-sabbrev tfd="terraform destroy"
ble-sabbrev dc="docker compose"
ble-sabbrev dcu="docker compose up -d"
ble-sabbrev dcd="docker compose down"
ble-sabbrev dcl="docker compose logs"
ble-sabbrev dcr="docker compose restart"
ble-sabbrev sys="systemctl"
ble-sabbrev syss="systemctl status"
ble-sabbrev sysr="systemctl restart"
ble-sabbrev sysst="systemctl start"
ble-sabbrev syssp="systemctl stop"

# --- Prompt ---
bleopt rps1='\u@\h \w'
bleopt rps1_transient=1

# --- Editor ---
bleopt indent_offset=2
bleopt indent_tabs=0

# --- Key Bindings ---
# history navigation with up/down
ble-bind -f 'up' history-search-backward
ble-bind -f 'down' history-search-forward

# Ctrl+arrows for word navigation
ble-bind -f 'C-right' forward-cword
ble-bind -f 'C-left' backward-cword

# Home/End
ble-bind -f 'home' beginning-of-line
ble-bind -f 'end' end-of-line

# Delete key
ble-bind -f 'delete' delete-forward-char

# Ctrl+Backspace/Delete for word delete
ble-bind -f 'C-delete' kill-forward-cword
ble-bind -f 'C-backspace' kill-backward-cword
