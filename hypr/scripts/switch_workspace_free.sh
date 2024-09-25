#!/bin/bash

# moves to the next/previous workspace that is not used by another monitor

source utils.sh

require hyprctl
require jq

active_workspaces=`hyprctl workspaces -j | jq -r '.[].id'`
current_workspace=`hyprctl activeworkspace -j | jq '.id'`

direction=$1
move=$2

function is_free() {
	local workspace=$1

	active_monitor=`hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .id'`
	workspace_monitor=`hyprctl workspaces -j | jq -r ".[] | select(.id == $workspace) | .monitorID"`

	if [ "$active_monitor" == "$workspace_monitor" ]; then
		echo same monitors
		return 0
	fi

	if echo "$active_workspaces" | grep -q "$workspace"; then
		return 1
	else
		return 0
	fi
}

if [ "$direction" == "l" ]; then
	free_workspace=$((current_workspace - 1))

	while ! is_free $free_workspace; do
		free_workspace=$((free_workspace - 1))
	done
elif [ "$direction" == "r" ]; then
	free_workspace=$((current_workspace + 1))

	while ! is_free $free_workspace; do
		free_workspace=$((free_workspace + 1))
	done
else
	echo "usage: $0 l|r [true|false]"
	echo "example: $0 r true -> move active window to next free workspace"
	exit
fi

move=$2
move=${move:-false}

if [ $free_workspace == 0 ]; then
	echo "no more free workspaces to the left"
	exit
else
	echo switching to workspace $free_workspace
fi

if [ "$move" == "true" ]; then
	hyprctl dispatch movetoworkspace $free_workspace
else
	hyprctl dispatch workspace $free_workspace
fi
