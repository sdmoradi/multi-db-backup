#!/bin/sh

# Check if required environment variables are set
if [[ -z "$JOBNAME" || -z "$S3_LIFECYCLE" || -z "$DATABASE_TYPE" || -z "$DATABASE_ADDRESS" || -z "$DATABASE_PORT" || -z "$DATABASE_USER" || -z "$DATABASE_PASS" || -z "$DATABASE_NAME" || -z "$S3_ADDRESS" || -z "$S3_PORT" || -z "$S3_SECRET" || -z "$S3_ACCESS" || -z "$S3_BUCKET" || -z "$S3_PATH" ]]; then
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

# Exit the script
exit 0
