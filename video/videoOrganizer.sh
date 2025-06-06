#! /usr/bin/bash
# set -x
#Variables
videoPath="$(find "$HOME" -maxdepth 1 -type d -name "*Videos" | grep -Pi ".*Videos$")"
function _organize_videos() {
	echo "Organizing videos"
	nand2tetris="$videoPath/nand2tetris"
	scripts="$videoPath/scripts"
	others="$videoPath/others"
	mapfile -t files < <((find "$videoPath" -maxdepth 1 '!' -name "organize.sh" -type f -printf "%f\n"))
	for file in "${files[@]}"; do
		if grep -Piq ".*nand2tetris.*" <<< "$file"; then
			mv "$videoPath/$file" "$nand2tetris/$file"
		elif grep -Piq ".*script.*" <<< "$file"; then
			mv "$videoPath/$file" "$scripts/$file"
		else
			mv "$videoPath/$file" "$others/$file"
		fi
	done
}
function main() {
	_organize_videos
}
main
