#!/bin/bash

#Intializing the constanats
STAKE=100
BET=1

#initializinf variables
currentStake=$STAKE
percent=$(awk "BEGIN { p=100*50/${STAKE}; i=int(p); print (p-i<0.5)?i:i+1 }")
maxLimit=`expr $STAKE + $percent`
minLimit=`expr $STAKE - $percent`

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
