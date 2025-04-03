#!/bin/bash

# Basic snapshot-style rsync backup script

# Config
OPT="-aPhR --exclude='*cache*' --exclude='pihole-FTL.db'"
SRC="/etc /root /home /var /usr/local/bin/backup.sh"
SNAP="raspi-backup:"
LAST="last"
LINK="--link-dest=../$LAST"
date=`date "+%Y-%m-%dT%T"`

# Run rsync to create snapshot
rsync $OPT $LINK $SRC ${SNAP}$date

# Remove symlink to previous snapshot
ssh raspi-backup "rm -f $LAST"

# Create new symlink to latest snapshot for the next backup to hardlink
ssh raspi-backup "ln -s $date $LAST"