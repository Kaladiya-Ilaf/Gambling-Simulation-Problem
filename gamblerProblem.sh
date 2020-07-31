#!/bin/bash

#Intializing the constanats
STAKE=100
BET=1
TOTAL_DAYS=20

#initializinf variables

percent=$(awk "BEGIN { p=100*50/${STAKE}; i=int(p); print (p-i<0.5)?i:i+1 }")
maxLimit=`expr $STAKE + $percent`
minLimit=`expr $STAKE - $percent`
currentBalance=0
day=1

while [ $day -le $TOTAL_DAYS ]
do
   currentStake=$STAKE
	#condition to continue gambling until 50% of stake is won or lose
	while [ $currentStake -gt $minLimit ] && [ $currentStake -lt $maxLimit ]
	do
   	currentBet=$((RANDOM % 2))
		if [ $currentBet -eq 1 ]
		then
			echo "You have won this round!"
			currentStake=$(( $currentStake + $BET ))
			echo "Current Balance :" $currentStake
		else
			echo "You have lost this round!"
			currentStake=$(( $currentStake - $BET ))
			echo "Current Balance :" $currentStake
		fi
	done
	currentBalance=$(( $currentBalance + $currentStake))
   day=`expr $day + 1`
done

echo "Your current balance after gambling for $TOTAL_DAYS days is:"
echo $currentBalance

totalStake=$(( $STAKE * $(( $day - 1)) ))

if [ $totalStake -lt $currentBalance ]
then
   echo "You have won $(( $currentBalance - $totalStake )) within $TOTAL_DAYS days"
elif [ $totalStake -eq $currentBalance ]
then
      echo "You niether won nor lose whithin  $TOTAL_DAYS days."
else
      echo "You have lost $(( $totalStake - $currentBalance )) within $TOTAL_DAYS days."
fi


