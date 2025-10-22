#!/bin/bash

# Increments/Decrements the workspace number by the number of monitors.
# This ensures each monitor is assigned its own workspaces

source `dirname $0`/utils.sh

require hyprctl
require jq

current_workspace=`hyprctl activeworkspace -j | jq '.id'`
active_monitors=`hyprctl monitors -j | jq '. | length'`

if [ "$1" == "l" ]; then
	new_workspace=$((current_workspace - active_monitors))
elif [ "$1" == "r" ]; then
	new_workspace=$((current_workspace + active_monitors))
elif [ "$1" == "o" ]; then
	active_monitor=`hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .description'`
	new_workspace=`hyprctl workspacerules -j | jq -r --arg mon_desc "$active_monitor" '.[] | select(.monitor == "desc:" + $mon_desc) | .workspaceString'`
	echo "moving to workspace $new_workspace"
else
	echo "usage: $0 l|r|o [true|false]"
	echo "examples: "
	echo "  $0 r true -> move active window to next workspace"
	echo "  $0 o -> switch to the current monitors origin workspace without moving a window"
	exit
fi

if [ "$new_workspace" -le "0" ]; then
	echo "move skipped"
	exit
fi

move=$2
move=${move:-'false'}
if [ "$move" == "true" ]; then
	hyprctl dispatch movetoworkspace $new_workspace
else
	hyprctl dispatch workspace $new_workspace
fi
