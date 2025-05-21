#! /usr/bin/bash
set -x
#Variables
current_path="$(realpath "$(dirname "$0")")"
mapfile -t services < <((find "$current_path" -type f -name "*.service"))

function setup() {
	if [[ "$(whoami)" != "root" ]]; then
		echo -e "You must be root"
		exit 1
	fi
	for service in "${services[@]}"; do
		basename_service="$(basename "$service")"
		cp "$service" "/etc/systemd/system/${basename_service}"
		read -rp "$(echo -e 'Do you want to start service\n1 ->> Start\n0 ->> Ignore\nSelection: ')" start
		if ((start == 1)); then
			systemctl start "$basename_service"
			systemctl daemon-reload
		fi
	done

}
setup
