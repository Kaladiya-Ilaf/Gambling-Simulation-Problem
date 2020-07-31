#!/bin/bash

#Intializing the constanats
STAKE=100
BET=1
TOTAL_DAYS=30

#initializing variables

percent=$(awk "BEGIN { p=100*50/${STAKE}; i=int(p); print (p-i<0.5)?i:i+1 }")
maxLimit=`expr $STAKE + $percent`
minLimit=`expr $STAKE - $percent`
currentBalance=0
day=1
totalBet=0

while [ $day -le $TOTAL_DAYS ]
do
   currentStake=$STAKE
	betsWon=0
	betsLost=0

	#condition to continue gambling until 50% of stake is won or lose
	while [ $currentStake -gt $minLimit ] && [ $currentStake -lt $maxLimit ]
	do
   	currentBet=$((RANDOM % 2))
		if [ $currentBet -eq 1 ]
		then
			currentStake=$(( $currentStake + $BET ))
			betsWon=`expr $betsWon + 1`
		else
			currentStake=$(( $currentStake - $BET ))
			betsLost=`expr $betsLost + 1`
		fi
	done
	totalBet=$(( $betsWon + $betsLost ))
	echo "Number of bet placed : $totalBet"
	if [ $currentStake -eq $minLimit ]
   then
      echo "Day $day :  lost by $betsLost bets."
      echo "Balance : $currentStake"
   elif [ $currentStake -eq $maxLimit ]
   then
      echo "Day $day : won by $betsWon bets."
      echo "Balance : $currentStake"
   fi
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


