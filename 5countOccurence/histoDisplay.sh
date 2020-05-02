#!/bin/bash
#Author: Aditya Goindi
#Purpose: to display results of countOccurence.sh and getTotalBytes.sh using histogram
#Usage: 


function histDisplay(){
	local -i raw rawmax scaled i MAX
	if [[ $MAXGIVEN == 'true' ]] 
	then 
		MAX=$CUSTOMMAX
	else
		MAX=50
	fi
	raw=$1
	rawmax=$2
	((scaled=(MAX*raw)/rawmax))
	((scaled == 0 && raw > 0)) && scaled=1
	for ((i=0; i<scaled; i++))
	do
		printf '#'
	done
	printf '\t%d' "${raw}"
	printf '\n'
}


# main
declare -A arr
declare -i max
declare MAXGIVEN CUSTOMMAX
if [[ ${1,0,2} == '-s' ]]
then
	MAXGIVEN=true
	shift
        CUSTOMMAX=$1
	shift
fi

while read label val
do
	let arr[$label]+=$val
	((val > max)) && max=$val
done

for label in "${!arr[@]}"
do
	printf '%s\t' "$label"
	histDisplay "${arr[$label]}" "$max"
	
done



