#! /usr/bin/bash
domains=("www.youtube.com")

function get_ips() {
	counter=$((0))
	for domain in "${domains[@]}"; do
		((counter++))
		while IFS= read -r -d $'\n' ipt; do
			ips+=("${ipt}")
		done < <(nslookup "${domain}" | awk '/Address.*1.*\./{print $2}')
	done
}
function block_ips() {
	i=$((0))
	for ipt in "${ips[@]}"; do
		if [[ ! -z ${ipt} ]]; then
			((i++))
			printf "BLOCKING:\t%s\n" "${ipt}"
			sudo iptables -A OUTPUT -d "$ipt" -j DROP
			sudo iptables -A FORWARD -d "$ipt" -j DROP
		fi
	done
	printf "\nips removed:%d\n" "$i"
}

function main() {
	ips=()
	get_ips "${ips[@]}"
	block_ips "${ips[@]}"
}

main "$@"
