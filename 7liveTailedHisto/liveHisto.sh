#!/bin/bash
#Author: Aditya Goindi
#Purpose: to count no of lines being tailed and representing using histogram (live) -> 3.liveHisto.sh
#Usage: bash watch.sh | bash liveHisto.sh


function display(){
	local i raw rawmax scaled 
	raw=$1
	rawmax=$2
	((scaled=(raw*maxBar)/rawmax))
	((scaled==0)) && scaled=1
	for((i=0;i<scaled;i++))
	do 
		printf '#'
	done
	printf '\n'
}

maxBar=100
MAX=100

#while getopts 'i:f:' opt:
#	case $opt in


if [[ ${1,0,2} == '-i' ]]
then
	shift
	interval=$1
	shift
fi

bash watch.sh $interval | while read dateip timeip quant
do 
	if ((quant>MAX))
	then
		MAX=$quant+$quant/4
		echo "        *****rescaling: MAX=$MAX"
	fi
	printf '%8.8s %8.8s %4d' $dateip $timeip $quant
	printf '\t'
	display $quant $MAX
done

