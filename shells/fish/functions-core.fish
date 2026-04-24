function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end
function take
    mkdir -p $argv[1]; and cd $argv[1]
end
function extract
    switch $argv[1]; case '*.tar.bz2'; tar xjf $argv[1]; case '*.tar.gz'; tar xzf $argv[1]; case '*.zip'; unzip $argv[1]; case '*.7z'; 7z x $argv[1]; case '*'; printf 'unknown archive: %s\n' $argv[1] >&2; return 1; end
end
function pathuniq
    string split : $PATH | awk '!seen[$0]++' | string join :
end
function dothealth
    bash "$DOTFILES_DIR/bin/health_check.sh"
end
function dotbench
    bash "$DOTFILES_DIR/bin/benchmark_shell.sh"
end
function dotfix
    sh "$DOTFILES_DIR/install/install.sh"
end
function recent
    find (test -n "$argv[1]"; and echo $argv[1]; or echo .) -type f -mtime -1 -print 2>/dev/null | head -100
end
function jsonfmt
    python3 -m json.tool $argv
end
function timer
    set start (date +%s); $argv; set code $status; set end (date +%s); math $end - $start; return $code
end
function dotloadfull
    source "$DOTFILES_DIR/shells/fish/functions.fish"
    source "$DOTFILES_DIR/shells/fish/aliases.fish"
end
