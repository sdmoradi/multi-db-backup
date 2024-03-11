#!/bin/sh

# MongoDB backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/mongodb"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER

# Run mongodump command to backup the database
mongodump --uri mongodb://$DATABASE_USER:$DATABASE_PASS@$DATABASE_ADDRESS:$DATABASE_PORT/$DATABASE_NAME  --archive=$BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).gz --gzip --authenticationDatabase=admin