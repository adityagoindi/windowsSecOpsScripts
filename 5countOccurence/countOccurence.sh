#!/bin/bash
#Aurthor: Aditya Goindi
#Purpose: to count occurence of item in a file 
#Usage: countOccurence.sh < file.txt

#Associative array/ hash table/ dictionary
declare -A arr

#building dictionary
while read id xtra
do
	let arr[$id]++
done

#printing occurences
for id in "${!arr[@]}"
do
	printf '%s %d\n' "$id" "${arr[$id]}" 
done


#awk functionality
#awk '{cnt[$1]++}
#END { for (id in cnt){
#	printf "%d %s\n", cnt[id], id
#    }
#}'
