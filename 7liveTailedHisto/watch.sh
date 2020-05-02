#!/bin/bash
#Author: Aditya Goindi
#Purpose: to count no of lines being tailed and representing using histogram (live) -> 2.watch.sh 
#Usage: bash watch.sh <log_file>


function clean(){
	[[ -n $LOPID ]] && kill $LOPID
}

trap clean EXIT
bash loop.sh logs &
LOPID=$!
sleep 3
if [ $1 -ge 0 ] 2> /dev/null
then
	interval=$1
else
	interval=5
fi

while true
do
	kill -SIGUSR1 $LOPID
	sleep $interval
done >&2
