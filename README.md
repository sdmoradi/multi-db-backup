# Database Backup and S3 Storage with Docker

This repository contains a Dockerfile and associated scripts to automate the backup process of MySQL, MongoDB, and PostgreSQL databases and copy the backups to an S3 storage bucket using MinIO client (mc).

## Prerequisites

Before you begin, ensure that you have the following set up:

- Docker installed on your machine

## Usage

1. Clone this repository to your local machine:

    ```
    git clone https://github.com/sdmoradi/multi-db-backup.git
    ```

2. Navigate to the cloned repository:

    ```
    cd multi-db-backup
    ```

3. Open the `entrypoint.sh` file and update the environment variables with your database connection information and S3 bucket details:

    ```shell
    # Database configuration
    DATABASE_TYPE=   # Type of database (e.g., mysql, mongodb, postgresql)
    DATABASE_ADDRESS=   # Database server address
    DATABASE_PORT=   # Database server port
    DATABASE_USER=   # Database username
    DATABASE_PASS=   # Database password
    DATABASE_NAME=   # Database name

    # S3 storage configuration
    S3_ADDRESS=   # S3 server address
    S3_PORT=   # S3 server port
    S3_SECRET=   # S3 access secret key
    S3_ACCESS=   # S3 access key
    S3_BUCKET=   # S3 bucket name
    S3_PATH=   # S3 bucket path
    ```

4. Customize the backup scripts located in the `backup-scripts` directory to suit your database backup requirements.

5. Build the Docker image:

    ```shell
    docker build -t database-backup-s3 .
    ```

6. Run the Docker container:

    ```shell
    docker run -d --name database-backup-s3-container database-backup-s3
    ```

7. The backup process will run automatically based on the configurations provided in the `entrypoint.sh` script.

8. The backups will be stored in the specified S3 bucket and path.

## Customization

- If you want to backup additional databases or modify the backup scripts, you can update the `backup-scripts` directory accordingly.

- Adjust the `entrypoint.sh` script to include any additional backup or customization logic you may require.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
