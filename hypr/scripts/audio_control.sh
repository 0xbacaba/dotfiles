#!/bin/bash

action=$1
args=$2
opt=""

if [ "$action" == "mute" ]; then
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  
  mute_state=`pactl get-source-mute @DEFAULT_SOURCE@ | grep -Eo 'yes|no'`
  if [ "$mute_state" == "yes" ]; then
    icon="/status/16/mic-off.svg"
    text="Microphone"
  else
    icon="/applets/22/microphone.svg"
    text="Microphone"
  fi
fi

if [ "$action" == "deafen" ]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle

  deaf_state=`pactl get-sink-mute @DEFAULT_SINK@ | grep -Eo 'yes|no'`
  if [ "$deaf_state" == "yes" ]; then
    icon="/actions/16/player-volume-muted.svg"
    text="Volume: "
    opt="-h int:value:0"
  else
    action="volume"
    args="+0"
  fi
fi

if [ "$action" == "volume" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ "$args"
  icon="/actions/16/player-volume.svg"
  text="Volume: "
  opt="-h int:value:`pactl get-sink-volume @DEFAULT_SINK@ | grep -Eo '[0-9]+%' | head -n 1 | sed 's/%//'`"
fi

notify-send -i "/usr/share/icons/breeze-dark/$icon" "$text" $opt
