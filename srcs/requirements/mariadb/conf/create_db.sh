#!/bin/bash

# Start the MariaDB service
service mariadb start;

# Create the database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;";

# Create the database user if it doesn't exist and set the password
mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PASSWD}';";

# Grant all privileges on the database to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWD}';";

# Change the root user password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWD}';";

# Flush privileges to ensure all changes take effect
mysql -u root -p$DB_ROOT_PASSWD -e "FLUSH PRIVILEGES;";

# Shutdown MariaDB safely
mysql -u root -p$DB_ROOT_PASSWD -e "shutdown";

# Wait for 1 second to ensure MariaDB has shut down
sleep 1;

# Start MariaDB in safe mode
exec mysqld_safe;
