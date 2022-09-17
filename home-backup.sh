#!/bin/bash

TIME=`date +%b-%d-%y`
USER=`whoami` # Using current user's Home directory
echo "The user is "$USER
LOGFILE=/home/$USER/bu_log_$TIME

HOME_DIR="/home/$USER"
HOME_BU_DIR=$1
DIRECTORY=("Documents" "Pictures" "Videos")

for i in ${DIRECTORY[@]}; do

	DIR="$HOME_DIR/$i"
	DIR_STAT=$HOME_DIR"/."$i"_stat"
	echo $DIR_STAT

	if [[ -e $DIR_STAT ]] # Is there a stat file for the directory?
	then
		DIR_STAT=`cat $DIR_STAT`
	else
		touch $DIR_STAT
	fi

	NEW_DIR_STAT=`stat -t $DIR`
	if [ "$DIR_STAT" != "$NEW_DIR_STAT" ]
	then
		echo "Changes have been detected. Backing up $i!" >> $LOGFILE
		HOME_BU_FILENAME=$USER"_"$i"_bu_"$TIME.tar.gz
		tar -cvpzf $HOME_BU_DIR/$HOME_BU_FILENAME $DIR 2>> $LOGFILE
        echo $NEW_DIR_STAT > $DIR_STAT
	else
		echo "No changes have been detected. Not Backing up $i directory." >> $LOGFILE
	fi
done
