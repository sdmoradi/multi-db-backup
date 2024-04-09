#!/bin/sh

# MySQL backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/mysql"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER

# Run mysqldump command to backup the database
mysqldump -h $DATABASE_ADDRESS -P $DATABASE_PORT -u $DATABASE_USER -p$DATABASE_PASS $DATABASE_NAME > $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).sql

# Copy backups to S3-compatible storage using MinIO client (mc)
mc alias set s3 https://$S3_ADDRESS:$S3_PORT $S3_ACCESS $S3_SECRET
mc cp $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).sql s3/$S3_BUCKET/$S3_PATH

# Set lifecycle for object
mc ilm rule add s3/$S3_BUCKET/$S3_PATH/$DATABASE_NAME-$(date +%Y%m%d%H).sql --expire-days $S3_LIFECYCLE

# Output success message
echo "Backup completed and copied to S3 storage!"