#!/bin/bash
#Author: Aditya Goindi
#Purpose: to automate the scanning and mailing difference ti the user
#Usage: bash automateScan.sh


./scanner.sh < hostlist

FILES=$(ls scan_* | tail -2)
filesToComp=( $FILES )
TMPFILE=$( tempfile )
./diff.sh ${filesToComp[0]} ${filesToComp[1]} > $TMPFILE

if [[ -s $TMPFILE ]]
then
	echo mailing the results to the $USER
	mail -s "today's difference: " $USER < $TMPFILE
fi

rm -f $TMPFILE 

