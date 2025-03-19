#!/bin/bash

# Usage: ./obs_ws.sh <action>
# Available actions:
# - toggle_rec: toggle recording

action="$1"
if [ -z "$action" ]; then
  echo "error: missing argument: <action>"
  exit
fi

port=4455

if [ ! -f ~/.config/hypr/.secrets/obs_ws ]; then
  echo "warning: obs secret not set: No such file: ~/.config/hypr/.secrets/obs_ws"
else
  password=`cat ~/.config/hypr/.secrets/obs_ws`
fi

obs_url="obsws://localhost:$port/$password"

case "$action" in
  "toggle_rec")
    obs-cmd -w $obs_url recording toggle
    exit_code=$?
    if [ $exit_code != 0 ]; then
      echo "error: obs-cmd finished with exit-code: $exit_code"
      notify-send -u critical "obs-cmd finished with exit-code: $exit_code"
    fi
    ;;

  *)
    echo "error: not implemented: $action"
    exit
esac
