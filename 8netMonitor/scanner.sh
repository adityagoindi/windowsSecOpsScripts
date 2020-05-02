#!/bin/bash
#Author: Aditya Goindi
#Purpose: network monitor tool 
#Usage: bash scanner.sh <output_file>


function scan(){
host=$1
printf '%s' $host
for (( port=0;port<1023;port++ ))
do
	echo > /dev/null 2>&1 < /dev/tcp/$host/$port
	if (( $? == 0 )) ; then printf '%d  ' $port ; fi
done
echo  

}


printf -v TODAY 'scan_%(%F)T' -1
OUTPUT=${1:-$TODAY}

while read HOST
do
	scan $HOST
done > $OUTPUT

