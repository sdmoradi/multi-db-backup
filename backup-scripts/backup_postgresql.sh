#!/bin/sh

# PostgreSQL backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/postgresql"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER
export PGPASSWORD=$DATABASE_PASS
# Run pg_dump command to backup the database
pg_dump -h $DATABASE_ADDRESS -p $DATABASE_PORT -U $DATABASE_USER -d $DATABASE_NAME  -v --compress=5 -f $BACKUP_FOLDER/$DATABASE_NAME_$(date +%Y%m%d%H).gz