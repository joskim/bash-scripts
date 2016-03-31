#!/bin/bash
h[0]=k[0]={}
echo "How many things in set 1"
read i
j=0;
while [ $j -lt $i ]; do
read h[$j]
j=$[$j+1]
done
echo "How many things in set 2"
read l
m=0;
while [ $m -lt $l ];do
read k[$m]
m=$[$m+1]
done
IFS=,
eval echo -n "{" "\("{"${h[*]}"},{"${k[*]}"}"\)" "}""total Cost"
