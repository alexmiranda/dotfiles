#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash
#shellcheck shell=bash

set -uexo pipefail
RETENTION_PERIOD=30

( \
  nix-channel --update && \
  nix-env -u --always && \
  home-manager switch || true; \
  nix-collect-garbage --delete-older-than "${RETENTION_PERIOD}d"; \
  nix-store --optimize; \
) &
PID1="$!"

( \
  brew update && \
  brew upgrade; \
  HOMEBREW_CLEANUP_MAX_AGE_DAYS="${RETENTION_PERIOD}" brew cleanup --prune=all; \
) &
PID2="$!"

wait "$PID1"
wait "$PID2"

echo "DONE"
