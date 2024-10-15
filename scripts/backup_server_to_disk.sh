#!/bin/bash

SERVER=${1:-"cnew"}
DISK=${2:-"/Volumes/Server"}
BWLIMIT=${3:-"0"}
ONLY_RASPI=${4:-"N"}

echo "Backing up server $SERVER to disk $DISK."

if [[ "$BWLIMIT" != "0" ]]; then
    echo "I/O bandwidth limit (rsync --bwlimit) is $BWLIMIT"
fi

if [[ "$ONLY_RASPI" == "Y" ]]; then
    echo "Skipping main backup. Only backing up raspi"
fi

read -n 1 -p "Press Y to continue: " userinput
echo
if [[ "$userinput" != "Y" ]]; then
    echo "Abort."
    exit
else
    echo "Backing up."
fi



# Basic snapshot-style rsync backup script
date=`date "+%Y-%m"`

# Run rsync to create snapshot
# exclude backups on the remote to prevent filling with hardlinks
if [[ "$ONLY_RASPI" != "Y" ]]; then
    rsync -aPhRz \
        --bwlimit=$BWLIMIT \
        --exclude "*-backup*/*" --exclude="*cache*" --rsync-path "sudo rsync" \
        --link-dest=$DISK/last $SERVER:/etc :/home :/var :/root $DISK/$date
else
    echo "Skipped main backup"
fi

# copy lastest backups by following symlinks
# need to explicitly include each level of directories before adding a global
# */last pattern
rsync -aPhRzLK \
    --bwlimit=$BWLIMIT \
    --include "var/" --include "*-backups/" \
    --exclude ".npm/*" --exclude "*cache*/*" \
    --include "home/" --include "home/raspi-backup/" \
    --include "*-backup*/last" --include "*-backup*/last/**" --exclude="*" --rsync-path "sudo rsync" \
    --link-dest=$DISK/last $SERVER:/home/raspi-backup :/var $DISK/$date

# Remove symlink to previous snapshot
rm -f $DISK/last

# Create new symlink to latest snapshot for the next backup to hardlink
ln -s $DISK/$date $DISK/last
