#!/bin/bash
#Author: Aditya Goindi
#Program: To search for a type of file and copy it in given directory
#Usage: fileTypeSearch.sh [-c dir] [-i] [-R|r] <pattern> <path>


DEPTH="-maxdepth 1"
while getopts 'c:iRr' opt
do
	case "$opt" in
		c) 
			COPYFLAG=TRUE
			DESTDIR="$OPTARG"
			;;
                i)
			CASESEN='-i'
			;;
		[rR])
			unset DEPTH
			;;
		*)
			exit 2
			;;
	esac
done

shift $((OPTIND - 1))

PATTERN=${1:-PDF document}
PATH=${2:-.}

find $PATH $DEPTH -type f | while read FILE
do
	file FILE | egrep -q $CASESEN "$PATTERN"
	if (( $? == 0 ))
	then
		echo $FILE
		if [[ COPYFLAG ]]
		then
			cp -p $FILE $DESTDIR
		fi
	fi
done


















