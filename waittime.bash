#!/bin/bash

#Calculate the burst time by subtracting the start time from 
#the end time.
#date command takes the current time
function calculateBurst(){
  A=$(date -d $1 '+%s')
  B=$(date -d $2 '+%s')
  echo $(( A - B ))
}

#Calculate average
function averageWait(){
  #Collector for sum
  sum=0
  numJobs=0
  for vals in ${@}
  do
    if [ $vals -eq -1 ]; then
      continue
    else
     sum=$(($sum + $vals))
     ((numJobs++))
    fi
  done
  printf "\nAverage wait time: %3.2d seconds\n" $(($sum/$numJobs)) 
}

#Calculates the wait time for each job
function calcWaitTime(){
  sum=0
  for vals in ${@}
  do
    sum=$(($sum + $vals))
  done
  echo $sum
}

#Runs the jobs of the file names passed in the array
function runJobs(){
  #Set the loop counter for the array variable
  counter=0
  #Create an array for the burst times
  burst[0]=0
  #Create wait time array variable
  wait[0]=0
  #Loop through the jobs and calculate the burst time
  for jobs in ${@}
  do
    #Get the start time for job
    start=`date +%T`
 
    #Run the job
    ./$jobs &>/dev/null
 
    #Calc burst time and stor it
    burst[$counter]=$(calculateBurst $(date +%T) $start)
 
    #Calc wait time
    wait[$(($counter + 1))]=$(calcWaitTime ${burst[@]})
 
    #Print job information.
    printf "Running: %s  Burst: %2d sec   Wait: %2d sec\n" "$jobs" ${burst[$counter]} ${wait[$counter]}
    
    #Log the job performance for analysis later
    jobPerf "$jobs" ${burst[$counter]}
 
    #Increment the counter
    ((counter++))
 
    #Clear the variable
    unset start
  done
  
  #Set the last index to -1 for the loop to catch
  #in averageWait().
  wait[$counter]=-1

  #Calculate and print the average wait time
  averageWait ${wait[@]}
  
  #Reset the counter
  unset counter
  unset wait
  unset burst
  
  printLine
}

#Prints a simple line on screen
function printLine(){
  echo
  echo "==============================================="
  echo
}

#Log the job performance for later analysis
function jobPerf(){
  pjob=$1
  pburst=$2
  #Write to job performance table
  echo "$pburst:$pjob" >> $perfTable

}

#Get the jobs from file in shortest job first order
function getJobsSjfOrder(){
  #Cat the file and pipe to sort with a general number sort then
  #pipe to cut with field two and the colon set as delimiter
 echo $(cat $perfTable | sort -g | cut -s -f 2 --delimiter=:)
}

#Removes the performance table
function removePerfTabe(){
  if [ -e $perfTable ]
  then
    rm $perfTable
  fi
}

#==================================================
#           Main section of script 
#==================================================
#Remove old performance table if it exist
removePerfTabe


#Setup the performance table for read write
perfTable="$(pwd)/perfTable.txt"

#Clear the console window
clear
#change directory
cd /home/cst334/HW6/

echo "Homework #6: R. Ciampa & A. Aria"
printLine

#Get all the jobs in the directory
jobFiles=$(ls | grep -w  'Job[0-9]*')

#Run the jobs
runJobs ${jobFiles[@]}

#Reset the counter
unset jobFiles

#Sort function here
jobFiles=$(getJobsSjfOrder)

#Indicate the we are runnning with sortest job first
printf "Running Shortest Job First (SJF) type algorithm\n\n"

#Delete the performance table now that we are done
#with original order
removePerfTabe

#Run the jobs
runJobs ${jobFiles[@]}

#Delete the performance table for next runJobs
removePerfTabe

#End of script
