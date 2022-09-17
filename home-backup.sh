#!/bin/bash

TIME=`date +%b-%d-%y`
USER=`whoami` # Using current user's Home directory
LOGFILE=/home/$USER/bu_log_$TIME

HOME_DIR='/home/$USER'
HOME_BU_DIR=$1
DIRECTORY=("Documents" "Pictures" "Videos")

for i in $DIRECTORY; do
	
	DIR_STAT="/home/$USER/.$i_stat"
	
	if [ -e $DIR_STAT ] # Is there a stat file for the directory?
	then
		DIR_STAT=`cat $DIR_STAT`
	else
		DIR_STAT=''
	fi

	NEW_DIR_STAT=`stat -t $HOME_DIR/$i`

	if [ "$DIR_STAT" != "$NEW_DIR_STAT" ]
	then
		echo "Changes have been detected. Backing up $i!" >> $LOGFILE
		HOME_BU_FILENAME=$USER_$i_bu_$TIME.tar.gz
		tar -cvpzf $HOME_BU_DIR/$HOME_BU_FILENAME $HOME_DIR 2>> $LOGFILE
		echo $NEW_HOME_STAT > $HOME_STAT
	else
		echo "No changes have been detected. Not Backing up $i directory." >> $LOGFILE
	fi
done
