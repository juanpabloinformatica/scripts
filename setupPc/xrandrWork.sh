#!/usr/bin/bash
set -x
function _at_work() {
	[[ "$(iwgetid -r)" =~ "$WIFI_WORK" ]] \
		&& return 0 \
		|| return 1
}
function _turn_off_edp() {

	_at_work \
		&& pcScreen="$(xrandr --listmonitors | awk 'NR>1 && $1 ~ /0:/ {print $NF}')" \
		&& xrandr --output "$pcScreen" --off \
		&& return 0 \
		|| echo "Not at work"
}
function _work_init() {
	echo "Setting up work, if there" \
		&& _turn_off_edp
}
