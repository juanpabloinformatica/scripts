#!/usr/bin/bash

video_names_options=$(
	cat << EOF
nand2tetris.mkv
dsa_algorithms.mkv
linux.mkv

EOF
)

function fzf_tweak() {
	title="$1"
	echo $(fzf --header-first --header ${title} --layout=reverse --border)
}
function set_audio() {
	card="$(arecord -l | sed -n '/card/p' | fzf_tweak "Select the card audio to get video sound" | awk '{print $2}' | sed 's/://g')"
	echo "${card}"
}
function get_date() {
	local date_result="$(date +%4Y)_$(date +%m)_$(date +%d)"
	echo ${date_result}
}
function set_video_name() {
	video_name="${1}"
	video_name="$(awk 'BEGIN{FS="."}{print $1}' <<< ${1})"
	video_ext="$(awk 'BEGIN{FS="."}{print $2}' <<< ${1})"
	video_date="$(get_date)"
	#Notice the dot
	echo "${video_name}_${video_date}.${video_ext}"
}
function get_monitor_resolution() {
	resolution=$(xrandr | grep -Pi "\bconnected\b" | awk '{print $4}' | sed 's/\+.*//g')
	echo "${resolution}"
}
function mute_video() {

	option=$(
		cat << EOF
yes
no
EOF
	)
	echo $(fzf_tweak "mute_video" <<< ${option})
}
function set_video() {
	video_name="${1}"
	resolution=$(get_monitor_resolution)
	if [[ "$(mute_video)" =~ "yes" ]]; then
		ffmpeg -video_size ${resolution} -framerate 25 -f x11grab -i :0.0 ${video_name}
	else
		audio_card=$(set_audio)
		ffmpeg -video_size ${resolution} -framerate 25 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:${audio_card} ${video_name}
	fi
}
function main() {
	while (($# > 0)); do
		case "$1" in
			-vn | --video-name)
				video_name=$(set_video_name "$2")
				shift 2
				;;

			*)
				echo "Name video not provided"
				break
				;;
		esac
	done
	if [[ -z ${video_name} ]]; then
		video_name=$(fzf_tweak "Default_options" <<< ${video_names_options})
	fi
	set_video ${video_name}
}
main "$@"
