#!/bin/bash

# TODO

CONTAINER=$1
FILE_NAME=$CONTAINER_$(date +%Y%m%d)

BACKUP_ROOT=/docker/backup
BACKUP_PATH=$BACKUP_ROOT/$1

KEEP_COUNT=100

# make directory
mkdir -p $BACKUP_PATH

# backup
docker container run --rm -v /tmp:/backup --volumes-from $CONTAINER busybox tar -cvf $BACKUP_PATH/$FILE_NAME.tar /backup

# remove old backups
ls -1trd $BACKUP_DIR/* | head -n -$KEEP_COUNT | xargs rm -f