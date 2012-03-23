#!/bin/sh

if [ -z $1 ]; then
	echo "usage: $0 <tex-document-1> [...]"
	exit
fi

MYPATH=`dirname $0`
HE='<< \033[0m';
HB='\033[94m >> TEST:';

echo -e "[LATEX English Paper Check (c) Erik Rodner 2011]\n"

echo -e "$HB equation reference check $HE"
egrep -n --color '\\ref{eq:' $*

echo -e "$HB finding duplicates $HE"
$MYPATH/duplicates.pl $*

echo -e "$HB gerund check $HE"
$MYPATH/gerund_or_infinitive.sh $*

echo -e "$HB hyphen check $HE"
$MYPATH/hyphen.pl $*

echo -e "$HB articles check $HE"
$MYPATH/indefinite_articles.sh $*

echo -e "$HB check comma after introductory words $HE"
INTROWORDS="(However|For this reason|For example|For instance|In fact|Generally|Moreover|Furthermore|Hence|Thereby|Additionally|After all|Likewise|Otherwise|Presently|Therefore|Thus|Of course|On the contrary|Nevertheless|Finally|At first glance|At a first glance|First of all|In general|Unfortunately|On the other hand|On one hand|Afterwards?)" 
egrep -n --color "$INTROWORDS " $*
egrep -n --color "In contrast[^,][^t][^o]" $*
# no comma after although
egrep -n --color "Although," $*
egrep -n --color "In the remaining \w+ of this \w+ " $*
egrep -n --color "For *[^,]+ *we " $*
egrep -n --color "Equivalently *[^,]+ *we " $*
egrep -n --color ", that" $*
egrep -n --color "In case of [^,]+$" $*
egrep -n --color "In contrast [^,]+$" $*
egrep -n --color 'In the remainder[^,]+ we' $* 
egrep -n --color 'As can be seen (by|in)[^,]+$' $* 
egrep -n --color 'As (described|explained) [^,]+$' $*
egrep -n --color "Using [^,]+ (it can be|we)" $*
egrep -n --color "After [^,]+$" $*
egrep -n --color '[^,;] \\eg' $*
egrep -n --color 'In [^,.]+ we ' $*
egrep -n --color 'From [^,.] (it|we) ' $*
egrep -n --color "To [^,]+$" $*
echo
echo "hint: The usage of the comma before \"respectively\" at the end of a sentence is context specific. If the sentence is long and has many parameters, then use the comma for clarity. If not, the comma may be omitted."
echo
egrep -n --color "[a-z][^,]+respectively" $*

echo -e "$HB check carefully the comma after In the following $HE"
egrep -n --color 'In the following[^\,]' $* | egrep -v 'In the following (section|chapter|presentation|paragraph|thesis|paper|book|report)'

echo -e "$HB do not use exemplary (http://www.merriam-webster.com/word-of-the-day/2010/12/20/) $HE"
egrep -n --color exemplary $*


echo -e "$HB informal words $HE"
egrep -n --color "[^\\\{](?nowadays|quote|anybody|everybody|big|for sure|have got|has got|kind of|sort of)" $*

echo -e "$HB misc $HE"
egrep -n -i --color "randomized *trees" $*
egrep -n -i --color "randomized *forest" $*
egrep -n -i --color "random decision tree" $*

echo -e "$HB undefined references and double definitions $HE"
grep "multiply defined" *.log
grep "undefined" *.log

echo -e "$HB overfull boxes $HE"
egrep '(?Overfull|\./.+?tex$)' *.log

echo -e "$HB check for a correct dot or comma after an align environment $HE"
egrep -n -B1 'end{align}' $* | grep -v '^--$' | grep -v align | grep -v '\. *$' | grep -v '\, *$'


