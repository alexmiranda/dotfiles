#!/usr/bin/env bash
if ! { [ -n "$TMUX" ]; } then
  exit 1
fi

session_names=(
  OptimusPrime
  Bumblebee
  Jazz
  Ratchet
  Ironhide
  Sidewipe
  Jolt
  Skids
  Midflap
  Arcee
  Chromia
  Elita-One
  Jetfire
  Wheelie
  Brains
  Mirage
  Wheeljack
  Topspin
  Roadbuster
  Leadfoot
  Hound
  Drift
  Crosshairs
  Grimlock
  Strafe
  Slug
  Scorn
  Sqweeks
)

build_session_name(){
  echo "${1:-${USER}}/$(tmux -V 2>/dev/null | cut -c 6- | tr '.' '_')"
}

# gets current tmux session name
curr_session_name="$(tmux display-message -p '#S' 2>/dev/null)"
if [ "X$curr_session_name" = "X" ]; then
  exit 1
fi

# session has a boring name (0..n), change it!
if echo "$curr_session_name" | grep -q "^\\d\+$"; then
  default_session_name="$(build_session_name "$@")"
  session_name="$default_session_name"
  while tmux has-session -t "$session_name" >/dev/null 2>&1; do
    session_name="${session_names[$RANDOM % ${#session_names[@]}]}"
  done
  tmux rename-session -t "$curr_session_name" "$session_name" >/dev/null 2>&1
fi
