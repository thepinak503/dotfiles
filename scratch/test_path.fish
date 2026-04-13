echo "status filename: " (status filename)
echo "realpath: " (realpath (status filename))
echo "DOTFILES_DIR attempt: " (dirname (dirname (dirname (status filename))))
echo "DOTFILES_DIR realpath attempt: " (dirname (dirname (dirname (realpath (status filename)))))
