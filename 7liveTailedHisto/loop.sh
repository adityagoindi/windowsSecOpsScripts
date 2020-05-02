#!/bin/bash
#Author: Aditya Goindi
#Purpose: to count no of lines being tailed and representing using histogram (live) -> 1. loop.sh
#Usage: bash loop.sh <log_file>

function display(){
	echo $(date "+%d/%m/%y %H:%M:%S") $cnt
	cnt=0
}


declare -i cnt=0
trap display SIGUSR1

shopt -s lastpipe

tail -f --pid=$$ ${1:-logs} | while read line
do 
	let cnt++
done

