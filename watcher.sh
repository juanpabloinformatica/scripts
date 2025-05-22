function _video_changes() {
	source ./video/videoOrganizer.sh
	inotifywait --monitor --format "%e %w%f" \
		--event modify,move,create,delete "$videoPath" \
		| while read changed; do
			echo "$changed"
			_organize_videos
		done
}
function _download_changes() {
	source ./downloads/dowloadOrganizer.sh
	inotifywait --monitor --format "%e %w%f" \
		--event modify,move,create,delete "$downloadPath" \
		| while read changed; do
			echo "$changed"
			_organize_downloads
		done
}
function _detect_changes() {
	if [[ -z "$(which inotifywait)" ]]; then
		echo -e "Not installed\nInstall inotify-tools\nsudo pacman -Syu inotify-tools"
		exit 1
	fi
	_video_changes &
	_download_changes &
}

function main() {
	_detect_changes
}
main
