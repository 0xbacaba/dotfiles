#!/bin/bash

source utils.sh

require hyprctl
require wofi
require jq
require systemctl
# require loginctl


wofi_config=~/.config/hypr/scripts/power_wofi_config

options=(
	"\U0f0425\tshutdown"
	"\U0f0709\treboot"
	"\U0f0343\tlogout"
	# "\U0f033e\tlock"
)

function raw() {
	echo -e "$1"
}
function print_options() {
	for value in "${options[@]}"; do
		raw $value
	done
}
print_options
selected=`print_options | wofi -c $wofi_config -S dmenu`

# function current_session() {
# 	loginctl list-sessions -j | jq -r ".[] | select(.seat != null) | select(.user == \"$USER\") | .session"
# }

case "$selected" in
	`raw ${options[0]}`)
		echo "[shutdown] systemctl poweroff"
		systemctl poweroff
		;;
	`raw ${options[1]}`)
		echo "[reboot] systemctl reboot"
		systemctl reboot
		;;
	`raw ${options[2]}`)
		echo "[logout] hyprctl dispatch exit"
		hyprctl dispatch exit
		;;
	# `raw ${options[3]}`)
	# 	session=`current_session`
	# 	echo "[lock] loginctl lock-session $session"
	# 	loginctl lock-session $session
	# 	;;
	*)
		echo "WARNING: unimplemented: $selected"
		;;
esac
