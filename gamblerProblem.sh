#!/bin/bash 

#Initialing dictionaries to be used
declare -A winningDays
declare -A losingDays

#Intializing the constanats
STAKE=100
BET=1
TOTAL_DAYS=30

function gambling(){
#Initializing variables
percent=$(awk "BEGIN { p=100*50/${STAKE}; i=int(p); print (p-i<0.5)?i:i+1 }")
maxLimit=`expr $STAKE + $percent`
minLimit=`expr $STAKE - $percent`
currentBalance=0
day=1

while [ $day -le $TOTAL_DAYS ]
do
   currentStake=$STAKE
   betsWon=0
   betsLost=0
   totalBet=0

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
      losingDays[$day]=$betsLost
   elif [ $currentStake -eq $maxLimit ]
   then
      echo "Day $day : won by $betsWon bets."
      winningDays[$day]=$betsWon
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


maxWin=${winningDays[1]}
maxLost=${losingDays[1]}
luckyDay=0
unluckyDay=0

for i in ${!winningDays[@]}
do
   
   temp=${winningDays[$i]}
   if [[ $temp -gt $maxWin ]]
   then
       maxWin=$temp
       luckyDay=$i
   fi
done
echo "Luckiest Day :" $luckyDay
echo "No. of bets won :" $maxWin

for i in ${!losingDays[@]}
do
   temp=${losingDays[$i]}
   if [[ $temp -gt $maxLost ]]
   then
       maxLost=$temp
       unluckyDay=$i
   fi
done

echo "Unluckiest Day :" $unluckyDay
echo "No. of bets lost :" $maxLost

printf "$currentBalance"
}
gambling
balance=$1
flag=1
totalAmount=$(( $STAKE * $(( $day - 1)) ))
while [ $flag -eq 1 ]
do
if [  $balance <=  $totalAmount ]
then
	echo "Sorry you cannot continue"
	flag=0
else
	echo "Do you wish to continue?"
	echo "Enter 1 to continue."
	read userWish
	case $userWish in
		1) gambling
		   flag=1;;
		*)echo "Thank you!"	
        flag=0;;
	esac
fi
done
