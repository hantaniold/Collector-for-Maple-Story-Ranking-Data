#!/bin/bash
#Sean Hogan
#maplegetdeme.sh
#This should be run with three arguments from the command line - start rank and end rank...you should not run this outputting to the same file concurrently, hence the third argument for the output filename
#It produces "ranks.data" suitable for input to tokens.

i=$1
j=$2
while [ $j -ge $i ]
do
    lynx --dump "http://maplestory.nexon.net/Rankings/WorldRanking.aspx?type=world&world=9&pageIndex=$i" | head --lines=92 | tail -31 >> $3 #Get semi-formatted data (faster way?)
    echo $i
    let "i += 5"
done

let "lines = $(cat $3 | wc -l)" #Count lines in our file
echo $lines #check lines...

