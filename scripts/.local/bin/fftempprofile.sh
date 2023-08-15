#!/usr/bin/env sh

PROFDIR="$(mktemp -d)"
trap 'rm -rf -- "$PROFDIR"' EXIT
open -n -W -a Firefox --args -profile "$PROFDIR" -no-remote -new-instance
