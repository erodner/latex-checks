#!/bin/bash

# (c) Erik Rodner 2011
# check for gerund mistakes (especially for German speakers) :)

wrongusage="allows? to|recommends? to|advises? to|encourages? to|permits? to|encourages? to|requires? to|urges? to|admit ?to|avoids? to|carry on to|considers? to|delays? to|deny to|denies to|dislikes? to|enjoys? to|finishs? to|give up to|gives up to|imagines? to|includes? to|involves? to|justify to|justifies to|keeps? to|mentions? to|minds? to|miss to|practise to?|regrets? to|risks? to|suggests? to"
 
wordfile=""
 
if [ "$1" = "" ]; then
 echo "usage: `basename $0` <file> ..."
 exit
fi
 
egrep -i -n --color "\\b($wrongusage)\\b" $*
 
exit $?
