#!/bin/bash
#roll 3 dice and see outcome of added 9's and 10's
C9=0
C10=0

function Rand {
R=$[ 1 + $[ RANDOM % 6 ]]
}

for i in `seq 1 100000`; do
   #First Die
   Rand
   F=$R
   #Second Die
   Rand
   S=$R
   #Third Die
   Rand
   T=$R

   SUM=$[ $F+$S+$T ]

      if [ $SUM -eq 9 ]
      then 
      C9=$[C9+1]
      elif [ $SUM -eq 10 ]
      then
      C10=$[C10+1]
      fi
done

echo 10,000 tries
echo Number of Nines $C9
echo Number of Tens $C10


