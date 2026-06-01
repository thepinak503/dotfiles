#!/usr/bin/env bash
cd ~/.local/share/dotfiles/themes

# Define replacements
declare -A colors=(
  ["2e3440"]="1e1e2e"
  ["3b4252"]="181825"
  ["434c5e"]="313244"
  ["4c566a"]="45475a"
  ["d8dee9"]="cdd6f4"
  ["eceff4"]="f5e0dc"
  ["81a1c1"]="bac2de"
  ["88c0d0"]="89b4fa"
  ["8fbcbb"]="94e2d5"
  ["5e81ac"]="89dceb"
  ["bf616a"]="f38ba8"
  ["d08770"]="fab387"
  ["ebcb8b"]="f9e2af"
  ["a3be8c"]="a6e3a1"
  ["b48ead"]="cba6f7"
  # RGB comma-separated replacements
  ["46,52,64"]="30,30,46"
  ["59,66,82"]="24,24,37"
  ["67,76,94"]="49,50,68"
  ["76,86,106"]="69,71,90"
  ["216,222,233"]="205,214,244"
  ["236,239,244"]="245,224,220"
  ["129,161,193"]="186,194,222"
  ["136,192,208"]="137,180,250"
  ["143,188,187"]="148,226,213"
  ["94,129,172"]="137,220,235"
  ["191,97,106"]="243,139,168"
  ["208,135,112"]="250,179,135"
  ["235,203,139"]="249,226,175"
  ["163,190,140"]="166,227,161"
  ["180,142,173"]="203,166,247"
)

# Loop over dark files
for dark_file in *dark*; do
  mocha_file="${dark_file/dark/mocha}"
  cp "$dark_file" "$mocha_file"
  for nord in "${!colors[@]}"; do
    mocha="${colors[$nord]}"
    sed -i "s/$nord/$mocha/gi" "$mocha_file"
  done
done

# Create mocha.lua manually
cp dark.lua mocha.lua
for nord in "${!colors[@]}"; do
  mocha="${colors[$nord]}"
  sed -i "s/$nord/$mocha/gi" mocha.lua
done
