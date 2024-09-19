# Use Debian 11 as the base image
FROM debian:11

# Copy the database creation script to the container
COPY ./conf/create_db.sh /

# Update package lists and upgrade installed packages
# Install MariaDB server
# Make the database creation script executable
RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y && \
    chmod +x /create_db.sh

# Copy the MariaDB server configuration file to the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Set the entrypoint to the database creation script
ENTRYPOINT [ "bash", "create_db.sh" ]
