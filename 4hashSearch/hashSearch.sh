#!/usr/bin/bash
#Author: Aditya Goindi
#Program: To find file and its path with the same hash as given
#Usage: hashSearch.sh <hash> <directory>

if [[ $1 == "-1" ]]
	then
		MATCHFLAG=true
                shift
fi

GIVENHASH=$1
DIR=${2:-.}

# function for absolute path
function makeAbsPath(){
	if [[ $1 == /* ]]
	then 
		ABS=$DIR
	else
		ABS="$PWD/$DIR"
	fi
}

find $DIR -type f | while read FILE
do
	RES=$(sha1sum "$FILE")
        HASH=${RES%% *}
	echo $HASH
	if [[ $HASH == $GIVENHASH ]]
	then 
		makeAbsPath "$FILE"
		echo $FILE
		if [[ MATCHFLAG ]]
		then
                	break		
		fi
	fi
done


























