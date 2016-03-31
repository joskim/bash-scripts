#!/bin/bash
cd /home/cst334/HW6/
burst[5]=0
waiit[4]=0
total=0
counter=0

for jobs in Job[1-9]
do
        ##get time then start job then get time again
        S=$(date +%s)
        ./$jobs &>/dev/null
        F=$(date +%s)
        #subtract two times to get difference
        burst[$counter]=$((F-S))
        echo  $jobs burst-time = $((burst[$counter]))
                if [ $jobs != Job1 ];
                then
                let total=$total+$((${burst[$counter-1]}))
                waiit[counter]=$total
                echo  $jobs waiit-time" " = $total
                else [ $jobs == Job1 ]
                #waiit[counter]=$((burst[$counter]))
                echo  $jobs waiit-time" " = $total
                fi
        ((counter++))
done


#add all wait times together and divide by 5
sums=0
for nums in {1..5}
do
sum=$(($sum +  ${waiit[$nums]}))
done

echo Average waiit-time $((sum/5)) seconds
echo Shortest Job First

#sorts burst times
function mysort { for i in ${burst[@]}; do echo "$i"; done | sort -n; }

#create another array
aBurst[5]=0

#create another array 
for nums in {0..4}
do
aBurst[$nums]=${burst[$nums]}
echo $((aBurst[$nums])) 
done

burst=( $(mysort) )

for asdf in {1..5}
do
burst[asdf]=${burst[$asdf]}
echo $((burst[$asdf])) 
done

unset S
unset F
unset jobs

for nums in {0..4}
do
for otherNums in {0..4}
do
if [ ${burst[$nums-1]} == ${aBurst[$otherNums]} ];
then
S=$(date +%s)
./Job"$aBurst[$jobs]"
F=$(date +%s)
fi
done
done


cd
