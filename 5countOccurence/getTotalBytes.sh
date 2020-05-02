#!/bin/bash
#Author: Aditya Goindi
#Purpose: get total bytes downloaded in sample logs 
#Usage: cut -d " " -f<ip>,<bytes> | bash getTotalBytes.sh | sort <asc|desc>

declare -A arr

while read id total
do
	let arr[$id]+=$total
done

for id in "${!arr[@]}"
do 
	printf ' %-15s %8d\n' "$id" "${arr[$id]}"
done



