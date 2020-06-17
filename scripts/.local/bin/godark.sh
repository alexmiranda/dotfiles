#!/usr/bin/env sh
gsed -i --follow-symlinks '/^colors:/s/_light\(.*\)$/_dark/' ~/.config/alacritty/alacritty.yml
gsed -i --follow-symlinks '/set\s\+background=/s/light/dark/' ~/.vim/config/appearance.vim
