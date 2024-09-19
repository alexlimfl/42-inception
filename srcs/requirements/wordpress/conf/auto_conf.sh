#!/bin/bash

# Wait for 2 seconds to ensure all services are up and running
sleep 2;

# Download the latest version of WordPress core files
wp-cli.phar core download --allow-root

# Create the WordPress configuration file with the provided database details
wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=mariadb --allow-root

# Install WordPress with the given site details and admin credentials
wp-cli.phar core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$DB_ROOT --admin_password=$DB_ROOT_PASSWD --admin_email=$ADMIN_MAIL --allow-root

# Create a new WordPress user with subscriber role
wp-cli.phar user create $USER1_LOGIN $USER1_MAIL --role=subscriber --user_pass=$USER1_PASS --allow-root

# Set permissions for WordPress content directories to ensure proper access
chmod -R 777 /var/www/html/wp-content/plugins
chmod -R 777 /var/www/html/wp-content/themes
chmod -R 777 /var/www/html/wp-content/uploads

# Install and activate the Redis cache plugin !!!
wp-cli.phar plugin install redis-cache --activate --allow-root

# Change ownership of the WordPress files to www-data user
chown -R www-data:www-data /var/www/html/

# Enable WordPress caching and configure Redis cache settings !!!
wp-cli.phar config set WP_CACHE true --raw --type=constant --allow-root
wp-cli.phar config set WP_REDIS_HOST redis --allow-root
wp-cli.phar redis enable --allow-root

# Create the necessary directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM in the foreground
php-fpm7.4 -F -R
