#! /usr/bin/bash
set -x
# variables=$(find $HOME/Documents -type f -name "variables.sh" | grep -Pi "\/scripts\/variables.sh$")
# source ${variables}

function _switch_monitors_position() {
	echo "Setting pc for bros settup"
	  if [[ "$(iwgetid -r)" =~ "$WIFI_ROB" ]] \
		&& [[ "$(xrandr --listmonitors | awk 'NR==1 {print $2}')" -eq 3 ]]; then
		pcScreen="$(xrandr --listmonitors | awk 'NR>1 && $1 ~ /0:/ {print $NF}')"
		firstMonitor="$(xrandr --listmonitors | awk 'NR>1 && $1 ~ /1:/ {print $NF}')"
		secondMonitor="$(xrandr --listmonitors | awk 'NR>1 && $1 ~ /2:/ {print $NF}')"
		xrandr --output "$pcScreen" --off
		xrandr --output "$firstMonitor" --off
		xrandr --output "$firstMonitor" --right-of "$secondMonitor" --auto
	else
		echo "Not enough monitors"
	fi

}
