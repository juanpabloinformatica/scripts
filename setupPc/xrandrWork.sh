#!/usr/bin/bash
function _at_work() {
	if echo "$(iwgetid -r)" ~= "$WIFI_WORK"; then
		echo "true"
	fi
}
function _turn_off_edp() {
	at_work=$(_at_work)
	if [[ $at_work =~ "true" ]]; then
		pcScreen="$(xrandr --listmonitors | awk 'NR>1 && $1 ~ /0:/ {print $NF}')"
		xrandr --output "$pcScreen" --off
	else
		echo "Not at work"
	fi
}
function _work_init() {
	echo "Setting up work, if there"
	_turn_off_edp
}
