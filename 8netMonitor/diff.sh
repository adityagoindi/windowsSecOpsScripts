#!/bin/bash
#Author: Aditya Goindi
#Purpose: to find difference between two scanner files  
#Usage: bash diff.sh <file2> <file1>
#Assumption: both the files have same no of lines and hosts in the same order

function lookUp(){

	for port in $@
	do
		if [[ $port == $lookFor ]]
		then
			return 1
		fi
	done
	return 0

}


while true
do 
	read lineA <&4 || break
	read lineB <&5 || break

	[[ $lineA == $lineB ]] && continue

	hostA=${lineA%% *}
	portA=( ${lineA#* } )

	hostB=${lineB%% *}
	portB=( ${lineB#* } )

	echo $hostA
	
	for aport in ${portA[@]}
	do
		lookFor=$aport lookUp ${portB[@]} && echo '     closed: ' $aport 
	done
	for bport in ${portB[@]}
	do
		lookFor=$bport lookUp ${portA[@]} && echo '     open: ' $bport
	done

done 4< ${1:-day1.data} 5< ${2:-day2.data}

