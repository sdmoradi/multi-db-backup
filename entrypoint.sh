#!/bin/sh

# Check if required environment variables are set
if [[ -z "$DATABASE_TYPE" || -z "$DATABASE_ADDRESS" || -z "$DATABASE_PORT" || -z "$DATABASE_USER" || -z "$DATABASE_PASS" || -z "$DATABASE_NAME" || -z "$S3_ADDRESS" || -z "$S3_PORT" || -z "$S3_SECRET" || -z "$S3_ACCESS" || -z "$S3_BUCKET" || -z "$S3_PATH" ]]; then
  echo "Error: One or more required environment variables are missing!"
  exit 1
fi

# Backup process based on the database type
case "$DATABASE_TYPE" in
  mysql)
    /backup-scripts/backup_mysql.sh
    ;;
  mongodb)
    /backup-scripts/backup_mongodb.sh
    ;;
  postgresql)
    /backup-scripts/backup_postgresql.sh
    ;;
  *)
    echo "Error: Invalid database type specified!"
    exit 1
    ;;
esac

# Copy backups to S3-compatible storage using MinIO client (mc)
mc alias set s3 https://$S3_ADDRESS:$S3_PORT $S3_ACCESS $S3_SECRET
mc cp --recursive /backup-scripts/backups/ s3/$S3_BUCKET/$S3_PATH

# Output success message
echo "Backup completed and copied to S3 storage!"

# Exit the script
exit 0
