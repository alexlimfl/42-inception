#!/bin/bash

# Start MariaDB service
service mariadb start
sleep 5

# Create database and user
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

# Restart MariaDB in safe mode (or directly run mysqld)
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Initialize server to listen incoming connections from 3306
mysqld --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
