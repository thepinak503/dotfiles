status is-interactive; or exit
set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme
set -q BROWSER; or set -gx BROWSER (command -v xdg-open || command -v open || command -v firefox || command -v google-chrome || echo xdg-open)
set -gx HISTFILESIZE 10000
set -gx HISTSIZE 500
set -gx HISTTIMEFORMAT "%F %T "
set -gx HISTCONTROL erasedups:ignoredups:ignorespace
set -gx LINUXTOOLBOXDIR "$HOME/linuxtoolbox"
set -gx CLICOLOR 1
set -gx LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
set -gx LESS_TERMCAP_mb (printf '\033[01;31m')
set -gx LESS_TERMCAP_md (printf '\033[01;31m')
set -gx LESS_TERMCAP_me (printf '\033[0m')
set -gx LESS_TERMCAP_se (printf '\033[0m')
set -gx LESS_TERMCAP_so (printf '\033[01;44;33m')
set -gx LESS_TERMCAP_ue (printf '\033[0m')
set -gx LESS_TERMCAP_us (printf '\033[01;32m')
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border --border-label='fzf' --color='fg:#bbbbbb,bg:#121212,hl:#ffaf5f,fg+:#eeeeee,bg+:#262626,hl+:#ffaf5f,info:#afaf87,prompt:#d7005f,pointer:#af5fff,marker:#87ff00,spinner:#af5fff,header:#87afaf'"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"
if test "$DOTFILES_MODE" = "supreme"; or test "$DOTFILES_MODE" = "ultra-nerd"
    if test ! -S ~/.ssh/ssh_auth_sock
        ssh-agent -c | source >/dev/null
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    end
    set -gx SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
end
if type -q vivid >/dev/null 2>&1
    set -gx LS_COLORS (vivid generate nord)
end
if type -q atuin >/dev/null 2>&1
    atuin init fish --disable-up-arrow | source
end
if type -q direnv >/dev/null 2>&1
    direnv hook fish | source
end
if type -q mise >/dev/null 2>&1
    mise activate fish | source
end