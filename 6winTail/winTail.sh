#!/bin/bash
#Author: Aditya Goindi
#Purpose: tail -f command implementation in Windows
#Usage: bash winTail.sh

LOGTYPE="Application"
LASTLOG=$( wevtutil qe "$LOGTYPE" //c:1 //rd:true //f:text )
#qe: to querry logs
#LOGTYPE: type of logs to querry
#c:1 returns only one log entry
#rd: read most recent log
#f: format(simple text)

while true 
do
	CURRLOG=$( wevtutil qe  "$LOGTYPE" //c:1 //rd:true //f:text ) 
	matched=$( $CURRLOG | egrep -i -o -f regex.txt )
	(( matched )) && echo Intrusion Dectected!!!!
	if [[ $CURRLOG != $LASTLOG ]]
	then
		echo $CURRLOG
		echo ------------------------------------------------
		sleep 2
		LASTLOG=$CURRLOG
	fi

done




