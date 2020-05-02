#!/bin/bash
#collecting & zipping windows logs

toZip=0

if [[ $# > 0 ]]
then
	if [[ ${1:0:2} == '-z' ]]
	then
		toZip=1
		shift
	fi
fi

sysName=${HOSTNAME}
logDir=/tmp/${sysName}_logs

mkdir -p $logDir
cd $logDir || exit -2

wevtutil el | while read log
do
	log=${log%$'\r'}
	printf '$log: \r'
	parName=${log// //_}
	parName=${parName//\//-}
       wevtutil epl "$log" "${parName}.evtx"
done

if (( toZip == 1))
then
	tar -czvf ${parName}_logs.tar.gz *.evtx
,mfi
