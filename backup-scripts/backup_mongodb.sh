#!/bin/sh

# MongoDB backup script

# Set the backup folder
BACKUP_FOLDER="/backup-scripts/backups/mongodb"

# Create the backup folder if it doesn't exist
mkdir -p $BACKUP_FOLDER

# Run mongodump command to backup the database
mongodump --uri mongodb://$DATABASE_USER:$DATABASE_PASS@$DATABASE_ADDRESS:$DATABASE_PORT/$DATABASE_NAME  --archive=$BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).gz --gzip --authenticationDatabase=admin

# Copy backups to S3-compatible storage using MinIO client (mc)
mc alias set s3 https://$S3_ADDRESS:$S3_PORT $S3_ACCESS $S3_SECRET
mc cp $BACKUP_FOLDER/$DATABASE_NAME-$(date +%Y%m%d%H).gz s3/$S3_BUCKET/$S3_PATH/$JOBNAME/$DATABASE_TYPE/

# Set lifecycle for object
mc ilm rule add s3/$S3_BUCKET/$S3_PATH/$JOBNAME/$DATABASE_TYPE/$DATABASE_NAME-$(date +%Y%m%d%H).gz --expire-days $S3_LIFECYCLE

# Output success message
echo "Backup completed and copied to S3 storage!"