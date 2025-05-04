#!/bin/bash

SERVER=${1:-"cnew"}
DISK=${2:-"/Volumes/Server"}
BWLIMIT=${3:-"0"}
ONLY_RASPI=${4:-"N"}
DATE=${5:-`date "+%Y-%m-%d"`}

echo "Backing up server $SERVER to disk $DISK/$DATE."

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

# Run rsync to create snapshot
# exclude backups on the remote to prevent filling with hardlinks
if [[ "$ONLY_RASPI" != "Y" ]]; then
    rsync -aPhRz \
        --numeric-ids \
        --rsh="ssh -F $HOME/.ssh/config_root" \
        --delete \
        --delete-excluded \
        --bwlimit=$BWLIMIT \
        --exclude "*-backup*/*" \
        --exclude="*cache*" \
        --include="/var/lib/docker/" \
        --include="/var/lib/docker/volumes" \
        --include="/var/lib/docker/volumes/**" \
        --exclude="/var/lib/docker/*" \
        --rsync-path "sudo rsync" \
        --link-dest=$DISK/last $SERVER:/etc :/home :/var :/root :/opt :/sbin :/shared :/srv :/usr $DISK/$DATE

    # Remove symlink to previous snapshot
    rm -f $DISK/last

    # Create new symlink to latest snapshot for the next backup to hardlink
    ln -s $DISK/$DATE $DISK/last
else
    echo "Skipped main backup"
fi

# copy lastest backups by following symlinks
# need to explicitly include each level of directories before adding a global
# */last pattern
rsync -aPhRzLK \
    --numeric-ids \
    --rsh="ssh -F $HOME/.ssh/config_root" \
    --delete \
    --delete-excluded \
    --bwlimit=$BWLIMIT \
    --include "var/" \
    --include "*-backups/" \
    --exclude ".npm/*" \
    --exclude "*cache*/*" \
    --include "home/" \
    --include "home/raspi-backup/" \
    --include "*-backup*/last" \
    --include "*-backup*/last/**" \
    --exclude="*" \
    --rsync-path "sudo rsync" \
    --link-dest=$DISK/raspi-backup/last $SERVER:/home/raspi-backup $DISK/raspi-backup/$DATE

# Remove symlink to previous snapshot
rm -f $DISK/raspi-backup/last

# Create new symlink to latest snapshot for the next backup to hardlink
ln -s $DISK/raspi-backup/$DATE $DISK/raspi-backup/last
