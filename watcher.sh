function _video_changes() {
	# not working yet as expected
	# source ./video/videoOrganizer.sh
	# inotifywait --monitor --format "%e %w%f" \
	# 	--event modify,move,create,delete "$videoPath" \
	# 	| while read changed; do
	# 		echo "$changed"
	# 		_organize_videos
	# 	done
	source ./video/videoOrganizer.sh
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
	source ./downloads/dowloadOrganizer.sh
	_organize_downloads
}
function _bro_setup(){
	source ./setupPc/xrandrRob.sh
	_switch_monitors_position
}
function _detect_changes() {
	# if [[ -z "$(which inotifywait)" ]]; then
	# 	echo -e "Not installed\nInstall inotify-tools\nsudo pacman -Syu inotify-tools"
	# 	exit 1
	# fi
	# _video_changes &
	# _download_changes &
	_video_changes
	_download_changes
	_bro_setup
}

function main() {
	_detect_changes
}
main
