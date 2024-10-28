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
	"\U0f04b2\tsuspend"
	"\U0f0709\treboot"
	"\U0f0343\tlogout"
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
selected=`pkill wofi || print_options | wofi -c $wofi_config -S dmenu`

case "$selected" in
	`raw ${options[0]}`)
		echo "[shutdown] systemctl poweroff"
		systemctl poweroff
		;;
	`raw ${options[1]}`)
		echo "[suspend] systemctl suspend"
		hyprlock &
		systemctl suspend
		;;
	`raw ${options[2]}`)
		echo "[reboot] systemctl reboot"
		systemctl reboot
		;;
	`raw ${options[3]}`)
		echo "[logout] hyprctl dispatch exit"
		hyprctl dispatch exit
		;;
	*)
		echo "WARNING: unimplemented: $selected"
		;;
esac
