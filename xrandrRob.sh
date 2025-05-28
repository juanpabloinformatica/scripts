#! /usr/bin/bash
function switch_monitors_position(){
	# if [[]]
	xrandr --output eDP-1 --off
	xrandr --output DP-2-2 --off
	xrandr --output DP-2-2 --right-of DP-2-3 --auto
}
switch_monitors_position
