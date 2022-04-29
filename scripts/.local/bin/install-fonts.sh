#! /usr/bin/env nix-shell
#! nix-shell -i bash -p nerd-font-patcher curl unzip jq gnugrep
# shellcheck shell=bash disable=SC1008

set -ueo pipefail

TMPIN="$(mktemp -d)" && trap 'rm -rf $TMPIN' EXIT
TMPOUT="$(mktemp -d)" && trap 'rm -rf $TMPOUT' EXIT

function download-fonts {
  cd "$TMPIN" && trap 'cd -' RETURN
  curl -L -O "https://dtinth.github.io/comic-mono-font/ComicMono.ttf"
  curl -L -O "https://dtinth.github.io/comic-mono-font/ComicMono-Bold.ttf"
  # download-latest-firacode
}

function download-latest-firacode {
  local latest
  latest="$( \
    curl -L -s \
    -H 'Accept: application/json' \
    https://github.com/tonsky/FiraCode/releases/latest | jq -r '.tag_name')"
  curl -L -o firacode.zip \
    "https://github.com/tonsky/FiraCode/releases/download/$latest/Fira_Code_v$latest.zip"
  trap 'rm -f firacode.zip' RETURN
  zipinfo -1 firacode.zip | grep 'woff2/[^\.]\+\.woff2' | while read -r fontfile; do
    unzip -j firacode.zip "$fontfile"
  done
}

function patch-fonts {
  for fontfile in "$TMPIN"/*; do
    nerd-font-patcher --complete --mono --careful -out "$TMPOUT" "$fontfile"
  done
}

function install-fonts {
  ls -la "$TMPOUT"/*
  cp "$TMPOUT"/* ~/Library/Fonts
}

download-fonts
patch-fonts
install-fonts

