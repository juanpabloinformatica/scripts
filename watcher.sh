#!/usr/bin/bash
function _video_changes() {
	# not working yet as expected
	# source ./video/videoOrganizer.sh
	# inotifywait --monitor --format "%e %w%f" \
	# 	--event modify,move,create,delete "$videoPath" \
	# 	| while read changed; do
	# 		echo "$changed"
	# 		_organize_videos
	# 	done
	source "${SCRIPTS_PATH}/video/videoOrganizer.sh"
	_organize_videos
}
function _download_changes() {
	# not working yet as expected
	# source ./downloads/dowloadOrganizer.sh
	# inotifywait --monitor --format "%e %w%f" \
	# 	--event modify,move,create,delete "$downloadPath" \
	# 	| while read changed; do
	# 		echo "$changed"
	# 		_organize_downloads
	# 	done
	source "${SCRIPTS_PATH}/downloads/dowloadOrganizer.sh"
	_organize_downloads
}
function _bro_setup() {
	source "${SCRIPTS_PATH}/setupPc/xrandrRob.sh"
	_switch_monitors_position
}
function _work_setup() {
	source "${SCRIPTS_PATH}/setupPc/xrandrWork.sh"
	_work_init
}
function _upload_videos() {
	dunstify "Youtube videos" "Don't forget to upload videos"
}
function _detect_changes() {
	# if [[ -z "$(which inotifywait)" ]]; then
	# 	echo -e "Not installed\nInstall inotify-tools\nsudo pacman -Syu inotify-tools"
	# 	exit 1
	# fi
	# _video_changes &
	# _download_changes &
	source "${SCRIPTS_PATH}/variables.sh"
	_video_changes
	_download_changes
	_bro_setup
	_work_setup
	_upload_videos
}

function main() {
	if [[ $# -ge 1 ]]; then
		while getopts ":s:" opt; do
			case $opt in
				s)
					SCRIPTS_PATH="$OPTARG"
					;;
				*) ;;
			esac
		done
		if [[ -n $SCRIPTS_PATH ]]; then
			_detect_changes
		fi
	fi
}
main "$@"
