#! /usr/bin/bash
# set -x
#Variables
downloadPath="$(find "$HOME" -maxdepth 1 -type d -name "*Downloads" | grep -Pi ".*Downloads$")"
echo "$downloadPath"
function _organize_downloads() {
	echo "Organizing downloads"
	images="$downloadPath/images"
	isos="$downloadPath/isos"
	other="$downloadPath/other"
	pdfs="$downloadPath/pdfs"
	software="$downloadPath/software"
	compressed="$downloadPath/compressed"
	mapfile -t files < <((find "$downloadPath" -maxdepth 1 '!' -name "organize.sh" -type f -printf "%f\n"))
	for file in "${files[@]}"; do
		if [[ -d $file ]]; then
			if find "$file" -executable; then
				mv "$downloadPath/$file" "$software/$file"
			else
				mv "$downloadPath/$file" "$other/$file"
			fi
		else
			if grep -Piq ".*jpeg|.*jpg|.*png" <<< "$file"; then
				mv "$downloadPath/$file" "$images/$file"
			elif grep -Piq ".*iso.*" <<< "$file"; then
				mv "$downloadPath/$file" "$isos/$file"
			elif grep -Piq ".*pdf.*" <<< "$file"; then
				mv "$downloadPath/$file" "$pdfs/$file"
			elif grep -Piq ".*zip.*|.*tar.*" <<< "$file"; then
				mv "$downloadPath/$file" "$compressed/$file"
			else
				if [[ -x $file ]]; then
					mv "$downloadPath/$file" "$software/$file"
				else
					mv "$downloadPath/$file" "$other/$file"
				fi
			fi
		fi
	done
}
function main() {
	_organize_downloads
}
main
