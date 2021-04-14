#!/bin/sh
export TOPIC=Skinfiles
export MIBPATH=/eso/hmi/lsd/images
export DESCRIPTION="This script will install $TOPIC"
export TYPE="folder"

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
export SDPATH=/$TOPIC/$BRAND

. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

# Checkup for brands and if this is the correct script for the brand
if [[ $BRAND == "Volkswagen" || $BRAND == "Skoda" || $BRAND == "Seat" ]]; then
	echo "Wrong brand for this script detected: $BRAND. Aborting"
	exit 0
	
elif [[ $BRAND == "Audi" || $BRAND == "Porsche"  || $BRAND == "Bentley" || $BRAND == "Lamborghini" ]]; then
	echo "Correct brand for this script detected: $BRAND. Moving on..."
	
else
	echo "No brand detected. Aborting"
	exit 0
fi

#Make backup folder
export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/$BRAND

#include script to make backup
. /eso/hmi/engdefs/scripts/mqb/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
. /eso/hmi/engdefs/scripts/mqb/util_copy.sh

echo "Done. Now restart the unit."
exit 0