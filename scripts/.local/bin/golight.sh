#!/usr/bin/env sh
gsed -i --follow-symlinks '/^colors:/s/_dark\(.*\)$/_light_hard_contrast/' ~/.config/alacritty/alacritty.yml
gsed -i --follow-symlinks '/set\s\+background=/s/dark/light/' ~/.vim/config/appearance.vim
