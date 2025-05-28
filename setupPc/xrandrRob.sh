#! /usr/bin/bash
source ../variables.sh

function _switch_monitors_position() {
	echo "Setting pc for bros settup"
	if echo "$(iwgetid -r)" ~= "$WIFI_ROB" \
		&& [[ "$(xrandr --listmonitors \
			| awk 'NR==1 {print $2}')" -eq 2 ]]; then
		xrandr --output eDP-1 --off
		xrandr --output DP-2-2 --off
		xrandr --output DP-2-2 --right-of DP-2-3 --auto
	else
		echo "Not enough monitors"
	fi

}
