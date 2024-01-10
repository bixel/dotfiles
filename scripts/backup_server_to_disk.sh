#!/bin/bash

DISK=/Volumes/Server
SERVER=cnew

# Basic snapshot-style rsync backup script
date=`date "+%Y-%m"`

# Run rsync to create snapshot
# exclude backups on the remote to prevent filling with hardlinks
rsync -aPhRz \
    --exclude "*-backup*/*" --exclude="*cache*" --rsync-path "sudo rsync" \
    --link-dest=$DISK/last $SERVER:/etc :/home :/var :/root $DISK/$date

# copy lastest backups by following symlinks
# need to explicitly include each level of directories before adding a global
# */last pattern
rsync -aPhRzLK \
    --include "var/" --include "*-backups/" --include "home/raspi-backup/" \
    --include "*-backup*/last" --include "*-backup*/last/**" --exclude="*" --rsync-path "sudo rsync" \
    --link-dest=$DISK/last $SERVER:/home/raspi-backup :/var $DISK/$date

# Remove symlink to previous snapshot
rm -f $DISK/last

# Create new symlink to latest snapshot for the next backup to hardlink
ln -s $DISK/$date $DISK/last
