#! /usr/bin/bash
# set -x
#Variables
videoPath="$(find "$HOME" -maxdepth 1 -type d -name "*Videos" | grep -Pi ".*Videos$")"
function _organize() {
	nand2tetris=$(find "$HOME" -type d -name "*nand2tetris*" | grep -Pi "${videoPath}")
	scripts=$(find "$HOME" -type d -name "*scripts*" | grep -Pi "${videoPath}")
	other=$(find "$HOME" -type d -name "*other*" | grep -Pi "${videoPath}")
	mapfile -t files < <((find "$videoPath" -maxdepth 1 '!' -name "organize.sh" -type f -printf "%f\n"))
	for file in "${files[@]}"; do
		if grep -Piq ".*nand2tetris.*" <<< "$file"; then
			mv "$videoPath/$file" "$nand2tetris/$file"
		elif grep -Piq ".*script.*" <<< "$file"; then
			mv "$videoPath/$file" "$scripts/$file"
		else
			mv "$videoPath/$file" "$other/$file"
		fi
	done
}
function main() {
	_organize
}
main
