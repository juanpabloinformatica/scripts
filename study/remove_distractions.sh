#! /usr/bin/bash
domains=("www.youtube.com" "www.monkeytype.com")

function get_ips() {
	counter=$((0))
	for domain in "${domains[@]}"; do
		((counter++))
		while IFS= read -r -d $'\n' ipt; do
			ipsv4+=("${ipt}")
		done < <(nslookup "${domain}" | awk '/Address.*1.*\./{print $2}')

		while IFS= read -r -d $'\n' ipt; do
			ipsv6+=("${ipt}")
		done < <(nslookup "${domain}" | awk '/Address:.*:/{print $2}')
	done
}
function block_ips() {
	i=$((0))
	for ipt in "${ipsv4[@]}"; do
		if [[ ! -z ${ipt} ]]; then
			((i++))
			printf "BLOCKING:\t%s\n" "${ipt}"
			sudo iptables -A OUTPUT -d "$ipt" -j DROP
			sudo iptables -A FORWARD -d "$ipt" -j DROP
		fi
	done
	for ipt in "${ipsv6[@]}"; do
		if [[ ! -z ${ipt} ]]; then
			((i++))
			printf "BLOCKING:\t%s\n" "${ipt}"
			sudo ip6tables -A OUTPUT -d "$ipt" -j DROP
			sudo ip6tables -A FORWARD -d "$ipt" -j DROP
		fi
	done
	printf "\nips removed:%d\n" "$i"
}

function main() {
	ipsv4=()
	ipsv6=()
	get_ips
	block_ips
}

main "$@"
