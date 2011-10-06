#!/bin/bash

# written by Erik Rodner 2011
vowels=" a [aeiuo]"
correctusage="a uni|a one\-"
wrong_a_and_an="a rbf|a hour|an uni|an one-"
 
if [ "$1" = "" ]; then
 echo "usage: `basename $0` <file> ..."
 exit
fi
 
egrep -i -n --color "($vowels)" $* | egrep --color -v "($correctusage)"
egrep -i -n --color "($wrong_a_and_an)" $*
 
exit $?
