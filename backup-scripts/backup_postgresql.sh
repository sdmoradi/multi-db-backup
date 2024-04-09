#!/bin/sh

# PostgreSQL backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/postgresql"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER
export PGPASSWORD=$DATABASE_PASS
# Run pg_dump command to backup the database
pg_dump -h $DATABASE_ADDRESS -p $DATABASE_PORT -U $DATABASE_USER -d $DATABASE_NAME  -v --compress=5 -f $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).gz

# Copy backups to S3-compatible storage using MinIO client (mc)
mc alias set s3 https://$S3_ADDRESS:$S3_PORT $S3_ACCESS $S3_SECRET
mc cp $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).gz s3/$S3_BUCKET/$S3_PATH/$JOBNAME/$DATABASE_TYPE/

# Set lifecycle for object
mc ilm rule add s3/$S3_BUCKET/$S3_PATH/$JOBNAME/$DATABASE_TYPE/$DATABASE_NAME-$(date +%Y%m%d%H).gz --expire-days $S3_LIFECYCLE

# Output success message
echo "Backup completed and copied to S3 storage!"