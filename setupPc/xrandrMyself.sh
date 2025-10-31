#!/usr/bin/bash

function is_there_monitor() {
	n_monitors=$(xrandr --listmonitors | awk 'NR==1{print $2}')
	if (("$n_monitors" >= 2)); then
		return 0
	else
		return 1
	fi
}

function shutdown_pc_screen() {

	if is_there_monitor; then
		printf "\n%s\n" "switching off pc_screen"
		pc_screen=$(xrandr --listmonitors | awk '/eDP1/{print $NF}')
		 xrandr --output "${pc_screen}" --off
	else
		printf "\n%s\n" "Letting pc_screen on"
	fi

}

function myself_init() {
	shutdown_pc_screen
}
