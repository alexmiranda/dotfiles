#!/usr/bin/env nix-shell
#!nix-shell -i bash -p ffmpeg
# shellcheck shell=bash disable=SC1008

set -ueo pipefail

function usage {
  echo "Usage: $(basename "$0") path/to/file.aifc"
}

if test "$#" -ne 1; then
  usage
  exit 1
fi

if test "$1" = '-h' || test "$1" = '--help'; then
  usage
  exit 1
fi

inputfile="$1"
ffmpeg                  \
  -i "$inputfile"       \
  -f mp3                \
  -acodec libmp3lame    \
  -ab 192000            \
  -ar 44100             \
  "${inputfile%.*}.mp3"
