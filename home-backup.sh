#!/bin/bash

TIME=`date +%b-%d-%y`
USER=`whoami` # Using current user's Home directory
LOGFILE=/home/$USER/bu_log_$TIME

HONE_DIR='/home/$USER'
HOME_STAT='/home/$USER/.home_stat'
HOME_BU_DIR='$BACKUP'

if [ -e $HOME_STAT ] # Is there a stat file for home?
then
	HOME_STAT=`cat $HOME_STAT`
else
	HOME_STAT='nothing'
fi

NEW_HOME_STAT=`stat -t $HOME_DIR`

if [ "$HOME_STAT" != "$NEW_HOME_STAT" ]
then
	echo 'Changes have been detected. Backing up Home!' >> $LOGFILE
	HOME_BU_FILENAME=$USER_bu_$TIME.tar.gz
	tar -cvpzf $HOME_BU_DIR/$HOME_BU_FILENAME $HOME_DIR 2>> $LOGFILE
	echo $NEW_HOME_STAT > $HOME_STAT
else
	echo "No changes have been detected. Not Backing up $USER's Home directory." >> $LOGFILE
fi
