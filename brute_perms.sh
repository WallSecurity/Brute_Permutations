#!/bin/bash
subs=$1
depth=$2
domain=$3
if [ "$#" -eq 0 ]; then
	printf "not enough arguments supplied.\r\nusage: walle_brute_perms <input_file> <depth> <domain>\r\n"
fi
if [ "$#" -eq 1 ]; then
	printf "not enough arguments supplied.\r\nusage: walle_brute_perms <input_file> <depth> <domain>\r\n"
fi
if [ "$#" -eq 2 ]; then
	printf "not enough arguments supplied.\r\nusage: walle_brute_perms <input_file> <depth> <domain>\r\n"
fi
if [ "$#" -eq 3 ]; then
	sub_name=$(echo $domain | unfurl format %S.%r)
	input="${sub_name}_perms.txt"
	perms="/opt/wordlists/alterations/permutations_list.txt"
	resolvers="/opt/wordlists/resolvers/resolvers.txt"
	output="${sub_name}_output.txt"
	ip=`ping $domain -c 1 | head -n 1 | awk -F '(' '{print $2}' | awk -F ')' '{print $1}'`
	printf "[+] Generating perms to ${input}\n"
	gotator -silent -sub ${subs} -perm ${perms} -depth ${depth} -numbers 10 -mindup | uniq > "${input}"
	printf "[+] Enumerating perms to ${output}, resolving wildcards against ${domain} : ${ip}\n"
	shuffledns -silent -d ${domain} -l ${input} -r ${resolvers} -o ${output}
	printf "[+] Done.\n"
fi
