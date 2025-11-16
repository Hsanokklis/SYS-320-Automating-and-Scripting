#!/bin/bash

#List all the ips in the given network prefix
# /24 only

#usage: Bash IPList.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0  <Prefix>" &&  exit 1

#prefix is the first input taken

prefix=$1

#  Verify input length
[ ${#prefix} -lt 5 ] && printf "Prefix length is too short\nPrefix example: 10.0.17\n" && exit 1


#Iterates through ips on given prefix, pings them, and shows them as output if they are reachable
for i in {1..254}; do
	if ping -c 1 "$prefix.$i" | grep -q "bytes from"; then
		 echo  "$prefix.$i host is reachable"
	fi
done
