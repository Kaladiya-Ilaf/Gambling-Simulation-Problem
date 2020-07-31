#!/bin/bash

#Intializing the constanats
STAKE=100
BET=1

currentStake=$STAKE
currentBet=$(( RANDOM % 2 ))

if [ $currentBet -eq 1 ]
then
	echo "You have won this round!"
	currentStake=$(( $currentStake + $BET ))
else
	echo "You have lost this round!"
	currentStake=$(( $currentStake - $BET ))
fi

echo "Current Balance :" $currentStake
