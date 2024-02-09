#!/bin/bash

scheme="$1"

if [[ -z "$scheme" ]]; then
   echo "Scheme is required."
   exit 0
fi

files=(
   ~/.Xdefaults
   ~/.vim/base16.vim
   ~/.config/alacritty/alacritty.yml.jinja
   ~/.config/rofi/base16.rasi
   )

# inject colorscheme into every file we care about.
for file in ${files[*]}; do
   pybase16 inject -s "$scheme" -f $file
done

# Regen alacritty's config.
pushd ~/.config/alacritty
./generate.py > alacritty.toml
popd

# Tell all termites to reload their configs.
killall -USR1 termite

# Reload Xdefaults
xrdb -merge ~/.Xdefaults

# Restart xmonad, and thus polybar
pushd ~/.xmonad
./generate.py > xmonad.hs
popd
xmonad --restart 2>&1

# Tell the remote vim named "preview" to reload its config.
vim --servername preview --remote-send ':source ~/.vim/vimrc<CR>'

# Print a preview of the colorscheme in 24bit to terminal.
./base16.py

# Write to save file.
echo "$scheme" > theme
