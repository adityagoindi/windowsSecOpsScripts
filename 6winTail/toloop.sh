#!/bin/bash
#Author: Aditya Goindi
#Purpose: count the no of lines in a file being tailed -f and Report count interval on every signal
#Usage bash toLoop.sh <logfile>


function interval(){
	echo $(date '+%y%m%d %H%M%S') $cnt
	cnt=0
}


declare -i cnt=0
trap interval SIGUSR1 

shopt -s lastpipe

tail -f --pid=$$ ${1:-logs} | while read line
do
	let cnt++
done
