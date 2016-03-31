#!/bin/bash
#Birthday same day probability
printf "Enter a number of people:\n"
read numOfPeople
top=365
res=1

function first(){
for i in `seq 1 $numOfPeople`;do
   prob=$( printf "%s\n" "scale = 10; $top/365" | bc)
   res=$(printf "%s\n" "scale = 10; $prob*$res" | bc)
   let top-=1
	if [[ (( $res < .5 )) ]]; then
           favor=$i
	fi;
done
}
first
echo Probability of match 
echo 1-$res | bc


if [ $favor -ne 1 ] 
then
   echo Favorable
else 
   echo Not favorable.
fi
