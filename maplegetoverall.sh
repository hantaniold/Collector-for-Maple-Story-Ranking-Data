#!/bin/bash
#Sean Hogan
#maplegetoverall.sh
#This should be run with two arguments from the command line - start rank and end rank.
#It produces "overallranks.data" suitable for input to tokens.

i=$1
j=$2
while [ $j -ge $i ]
do
    lynx --dump "http://maplestory.nexon.net/Rankings/OverallRanking.aspx?type=overall&s=w&world=0&job=0&pageIndex=$i" | head --lines=92 | tail -30 >> overallranks.data #Get semi-formatted data (faster way?)
    echo $i
    let "i += 5"
done

let "lines = $(cat overallranks.data | wc -l)" #Count lines in our file
echo $lines #check lines...

