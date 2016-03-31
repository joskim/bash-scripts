#!/bin/bash
function rand(){
RAND=`shuf -i 0-99 -n 1`
}

declare -A MATRIX
TD=10
TR=10
NOHIT=0
COUNTER=0
echo -n "Enter number of trials:"
read TRIALS
echo -n "Enter X:"
read X 
echo -n "Enter Y:" 
read Y  

function DOSTUFF(){
#initialize 10x10 array
for ((i=0;i<TD;i++)) do
    for ((j=0;j<TR;j++)) do
        MATRIX[$i,$j]=0
done
done	  
#Pick RAND number 400x  
for ((i=0;i<400;i++)) do
	rand
	SEC=$(($RAND%10))
	FST=$(($RAND/10))
	let MATRIX[${FST},${SEC}]+=1
done	  
#Print array
for ((i=0;i<TD;i++)) do
	for ((j=0;j<TR;j++)) do
		if [[ $X -eq $i && $Y -eq $j ]]
			then
			echo -ne "\x1B[01;92m${MATRIX[${i},${j}]} \x1B[0m"
		else
			echo -n "${MATRIX[${i},${j}]} "
		fi
	done
	echo
done	  
}

for ((k=0;k<TRIALS;k++)) do
DOSTUFF
echo
	if [ ${MATRIX[${X},${Y}]} -gt 0 ]
		then
		let COUNTER+=1
	fi
done
	  
echo "HITS to ($X,$Y) = $COUNTER / $TRIALS" 
