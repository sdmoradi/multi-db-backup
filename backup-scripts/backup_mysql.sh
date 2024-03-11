#!/bin/sh

# MySQL backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/mysql"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER

# Run mysqldump command to backup the database
mysqldump -h $DATABASE_ADDRESS -P $DATABASE_PORT -u $DATABASE_USER -p$DATABASE_PASS $DATABASE_NAME > $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).sql