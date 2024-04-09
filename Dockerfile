# Use a minimal base image
FROM alpine:latest

# Install necessary packages for database backups
RUN apk update \
    && apk --no-cache add mysql-client mariadb-connector-c mongodb-tools postgresql-client tzdata

# Set the time zone to Asia/Tehran
ENV TZ=Asia/Tehran
# Install MinIO client (mc)

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/local/bin/mc

# Add backup scripts
COPY backup-scripts /backup-scripts
RUN  chmod -R +x /backup-scripts/

# Configure entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables
ENV JOBNAME=""
ENV DATABASE_TYPE=""
ENV DATABASE_ADDRESS=""
ENV DATABASE_PORT=""
ENV DATABASE_USER=""
ENV DATABASE_PASS=""
ENV DATABASE_NAME=""
ENV S3_ADDRESS=""
ENV S3_PORT=""
ENV S3_SECRET=""
ENV S3_ACCESS=""
ENV S3_BUCKET=""
ENV S3_PATH=""
ENV S3_LIFECYCLE=""

# Run the entrypoint script
CMD /entrypoint.sh
