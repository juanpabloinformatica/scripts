#!/usr/bin/bash
set -x

function reset_distractions() {
	iptables -S | grep DROP | awk '{$1="";print $0}' | xargs -L1 iptables -D
}
function is_there_distractions() {
	dis=$(iptables -S | grep -c DROP)
	printf "%d" "${dis}"
	((dis > 0)) \
		&& return 0 \
		|| return 1
}
function check_root() {
	[[ "$(whoami)" =~ "root" ]] \
		&& return 0 \
		|| return 1
}
function main() {
	check_root \
		&& is_there_distractions \
		&& reset_distractions \
		|| echo "Run it as sudo && verify there are distractions"
}
main "$@"
