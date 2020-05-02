#!/bin/bash
#Author: Aditya Goindi
#Program: To print and save basic host info in XML format

# parse input file
function parseInputFile(){

	lCmd=${ALINE%%|*}
	rest=${ALINE#*|}
	wcmd=${rest%%|*}
	rest=${rest#*|}
	tag=${ALINE%%|*}

	if [[ $OS == 'MSWin' ]]
	then 
		cmd=$wcmd
	elif [[ $OS == 'Linux' ]]
	then 
		cmd=$lcmd
	else
		cmd='N/A'
	fi
}


# to find OS
function osDetect(){
if type -t wevtutil &> /dev/null
then
	echo MSWin
elif type -t scutil &> /dev/null
then 
	echo MacOS
else
	echo Linux
fi

}


# to print info
function dumpInfo(){
	printf '<systeminfo  host="%s" type="%s"' "$HOSTNAME" "$OSTYPE"
	printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
        readarray cmds
	for ALINE in "${cmds[@]}"
	do
		# to ignore comments
		if [[ ${ALINE,0,1} == "#" ]]
		then 
			continue 
		fi

		parseInputFile

		# if any sys other than Win or Linux
		if [[ ${cmd,0,3} == N/A ]]
		then 
			continue
		else
			printf '<"%s">\n' "$tag"
			$cmd
			printf '</"%s">\n' "$tag"
		fi
	done
	printf '</systeminfo>'
}


# main function
OS=`osDetect`
TMPFILE=${HOSTNAME}.info
dumpInfo > $TMPFILE 2>&1
scp $TMPFILE ubuntu@192.168.1.209:/











