# blerc -- ble.sh configuration
# optimized for dark terminal, maximum productivity

# --- General Options ---
bleopt char_width_mode=auto
bleopt input_encoding=UTF-8
bleopt edit_bell=vbell:abell
bleopt vbell_default_message=' BEL '
bleopt vbell_duration=2000
bleopt vbell_align=right
bleopt prompt_command_changes_layout=
bleopt exec_restore_pipestatus=1
bleopt history_share=1
bleopt history_share_erase_duplicate_line=1

# --- Syntax Highlighting ---
# enable all highlight types
bleopt highlight_syntax=1
bleopt highlight_filename=1
bleopt highlight_variable=1

ble-face -s syntax_default            none
ble-face -s syntax_command            fg=208
ble-face -s syntax_quoted             fg=113
ble-face -s syntax_quotation          fg=113,bold
ble-face -s syntax_escape             fg=212
ble-face -s syntax_expr               fg=81
ble-face -s syntax_error              bg=196,fg=231
ble-face -s syntax_varname            fg=215
ble-face -s syntax_delimiter          bold
ble-face -s syntax_param_expansion    fg=147
ble-face -s syntax_history_expansion  bg=94,fg=231
ble-face -s syntax_function_name      fg=213,bold
ble-face -s syntax_comment            fg=242
ble-face -s syntax_glob               fg=206,bold
ble-face -s syntax_brace              fg=81,bold
ble-face -s syntax_tilde              fg=75,bold
ble-face -s syntax_document           fg=142
ble-face -s syntax_document_begin     fg=142,bold

# command type highlighting
ble-face -s command_builtin_dot       fg=196,bold
ble-face -s command_builtin           fg=196
ble-face -s command_alias             fg=37
ble-face -s command_function          fg=213
ble-face -s command_file              fg=113
ble-face -s command_keyword           fg=69
ble-face -s command_jobs              fg=196
ble-face -s command_directory         fg=81,underline
ble-face -s command_suffix            fg=231,bg=28
ble-face -s command_suffix_new        fg=231,bg=124

# filename highlighting
ble-face -s filename_directory        underline,fg=81
ble-face -s filename_directory_sticky underline,fg=231,bg=26
ble-face -s filename_link             underline,fg=37
ble-face -s filename_orphan           underline,fg=16,bg=224
ble-face -s filename_executable       underline,fg=113
ble-face -s filename_setuid           underline,fg=black,bg=220
ble-face -s filename_setgid           underline,fg=black,bg=191
ble-face -s filename_other            underline
ble-face -s filename_socket           underline,fg=51,bg=black
ble-face -s filename_pipe             underline,fg=154,bg=black
ble-face -s filename_character        underline,fg=231,bg=black
ble-face -s filename_block            underline,fg=226,bg=black
ble-face -s filename_warning          underline,fg=196
ble-face -s filename_url              underline,fg=33
ble-face -s varname_array             fg=214,bold
ble-face -s varname_empty             fg=67
ble-face -s varname_export            fg=212,bold
ble-face -s varname_expr              fg=213,bold
ble-face -s varname_hash              fg=113,bold
ble-face -s varname_new               fg=77
ble-face -s varname_number            fg=107
ble-face -s varname_readonly          fg=212
ble-face -s varname_transform         fg=72,bold
ble-face -s varname_unset             fg=245

# argument highlighting
ble-face -s argument_option           fg=37
ble-face -s argument_error            fg=black,bg=225

# --- Completion ---
bleopt complete_auto_complete=1
bleopt complete_auto_delay=300
bleopt complete_auto_history=1
bleopt complete_ambiguous=1
bleopt complete_menu_complete=1
bleopt complete_menu_filter=1
bleopt complete_auto_history=1

# dabbrev completion (like vim's Ctrl-P completion from buffer)
bleopt complete_dabbrev=1
bleopt complete_dabbrev_scope=global
bleopt complete_dabbrev_width=80

# sabbrev (static abbreviations, like zsh abbreviations)
ble-sabbrev -f lg="lazygit"
ble-sabbrev -f ld="lazydocker"
ble-sabbrev -f gc="git commit"
ble-sabbrev -f gca="git commit --amend"
ble-sabbrev -f gp="git push"
ble-sabbrev -f gpl="git pull"
ble-sabbrev -f gst="git status"
ble-sabbrev -f gd="git diff"
ble-sabbrev -f gco="git checkout"
ble-sabbrev -f gb="git branch"
ble-sabbrev -f gl="git log"
ble-sabbrev -f ga="git add"
ble-sabbrev -f gr="git remote"
ble-sabbrev -f ns="npm start"
ble-sabbrev -f nr="npm run"
ble-sabbrev -f ni="npm install"
ble-sabbrev -f nrb="npm run build"
ble-sabbrev -f nrd="npm run dev"
ble-sabbrev -f nrt="npm run test"
ble-sabbrev -f ys="yarn start"
ble-sabbrev -f yr="yarn run"
ble-sabbrev -f yi="yarn install"
ble-sabbrev -f ps="pnpm start"
ble-sabbrev -f pr="pnpm run"
ble-sabbrev -f pi="pnpm install"
ble-sabbrev -f k="kubectl"
ble-sabbrev -f kg="kubectl get"
ble-sabbrev -f kgp="kubectl get pods"
ble-sabbrev -f kgs="kubectl get services"
ble-sabbrev -f kgd="kubectl get deployments"
ble-sabbrev -f kl="kubectl logs"
ble-sabbrev -f kx="kubectl exec -it"
ble-sabbrev -f tf="terraform"
ble-sabbrev -f tfi="terraform init"
ble-sabbrev -f tfa="terraform apply"
ble-sabbrev -f tfd="terraform destroy"
ble-sabbrev -f dc="docker compose"
ble-sabbrev -f dcu="docker compose up -d"
ble-sabbrev -f dcd="docker compose down"
ble-sabbrev -f dcl="docker compose logs"
ble-sabbrev -f dcr="docker compose restart"
ble-sabbrev -f sys="systemctl"
ble-sabbrev -f syss="systemctl status"
ble-sabbrev -f sysr="systemctl restart"
ble-sabbrev -f sysst="systemctl start"
ble-sabbrev -f syssp="systemctl stop"

# completion colors
ble-face -s auto_complete             fg=241,bg=236
ble-face -s menu_complete_match       bold
ble-face -s menu_complete_selected    reverse
ble-face -s menu_filter_fixed         bold
ble-face -s menu_filter_input         fg=16,bg=229

# --- Prompt ---
bleopt prompt_ps1_transient=1
bleopt prompt_rps1='\u@\h \w'
bleopt prompt_rps1_transient=1
bleopt prompt_status_line='\q{style=fg=231,bg=240}\e[1m ble.sh \q{style=reset} \u@\h \w \q{style=fg=242,bg=240}[\#]\q{style=reset}'
bleopt prompt_xterm_title='\u@\h:\w'
bleopt prompt_eol_mark='⏎'
bleopt exec_errexit_mark=$'\e[91m[error %d]\e[m'
bleopt exec_elapsed_mark=$'\e[94m[%ss]\e[m'
bleopt exec_elapsed_enabled='usr>=1000'
bleopt exec_exit_mark=
bleopt edit_marker=
bleopt edit_marker_error=

# --- Key Bindings ---
# fzf integration
if command -v fzf >/dev/null 2>&1; then
  function ble/widget/fzf-complete {
    local cmd=$READLINE_LINE
    local result
    result=$(fzf --height 40% --reverse --query "$cmd" < /dev/null 2>&1) || return
    READLINE_LINE=$result
    READLINE_POINT=${#result}
  }
  ble-bind -f 'C-x f' fzf-complete

  function ble/widget/fzf-cd {
    local dir
    dir=$(find . -type d 2>/dev/null | fzf --height 40% --reverse) || return
    READLINE_LINE="cd ${dir@Q}"
    READLINE_POINT=${#READLINE_LINE}
  }
  ble-bind -f 'C-x C-d' fzf-cd

  function ble/widget/fzf-kill {
    local pid
    pid=$(ps aux | fzf --height 40% --reverse | awk '{print $2}') || return
    READLINE_LINE="kill ${pid}"
    READLINE_POINT=${#READLINE_LINE}
  }
  ble-bind -f 'C-x k' fzf-kill
fi

# history navigation with up/down (like zsh)
ble-bind -f 'up' 'history-search-backward'
ble-bind -f 'down' 'history-search-forward'

# Ctrl+arrows for word navigation
ble-bind -f 'C-right' 'forward-cword'
ble-bind -f 'C-left' 'backward-cword'

# Home/End
ble-bind -f 'home' 'beginning-of-line'
ble-bind -f 'end' 'end-of-line'

# Delete key
ble-bind -f 'delete' 'delete-char'

# Ctrl+Backspace/Delete for word delete
ble-bind -f 'C-delete' 'kill-forward-cword'
ble-bind -f 'C-backspace' 'kill-backward-cword'

# clipboard integration
ble-bind -f 'C-S-v' 'paste'
ble-bind -f 'S-insert' 'paste'

# undo/redo
ble-bind -f 'C-z' 'undo'
ble-bind -f 'C-S-z' 'redo'

# open current line in editor (Ctrl-x Ctrl-e equivalent)
ble-bind -f 'C-x C-e' 'edit-and-execute-command'

# --- Vim Mode (disabled by default; uncomment to enable) ---
# set -o vi
# bleopt vim_map=1

# --- Editor ---
bleopt edit_vi=1

# Tab completion style: cycle through menu on successive tabs
bleopt complete_menu_complete=1

# --- Region/Mark (like transient-mark-mode) ---
bleopt edit_region_highlight=1

# --- Terminal ---
bleopt term_strip_tab=1
bleopt term_strip_cr=1
