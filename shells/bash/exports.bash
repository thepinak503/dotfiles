# =============================================================================
# DOTFILES MODE (minimal | standard | supreme | ultra-nerd)
# =============================================================================
[[ "$TERM" == "dumb" ]] && export TERM=xterm-256color
export BROWSER="${BROWSER:-$(command -v xdg-open || command -v open || command -v firefox || command -v google-chrome || echo xdg-open)}"
export DOTFILES_MODE="${DOTFILES_MODE:-supreme}"
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=erasedups:ignoredups:ignorespace
export LINUXTOOLBOXDIR="$HOME/linuxtoolbox"
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --border-label='fzf' --color='fg:#bbbbbb,bg:#121212,hl:#ffaf5f,fg+:#eeeeee,bg+:#262626,hl+:#ffaf5f,info:#afaf87,prompt:#d7005f,pointer:#af5fff,marker:#87ff00,spinner:#af5fff,header:#87afaf'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
if [[ "$DOTFILES_MODE" == "supreme" ]] || [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    if [[ ! -S ~/.ssh/ssh_auth_sock ]]; then
        eval "$(ssh-agent -s)" >/dev/null
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi
if command -v vivid &>/dev/null; then
    export LS_COLORS="$(vivid generate nord)"
fi
if command -v atuin &>/dev/null; then
    eval "$(atuin init bash --disable-up-arrow)"
fi
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi
