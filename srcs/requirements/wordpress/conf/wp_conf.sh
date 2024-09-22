#!/bin/bash

# WP-CLI installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Ensure the wordpress directory exists
mkdir -p /var/www/wordpress
cd /var/www/wordpress

# Set permissions
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress

# Ping MariaDB container until it's up
start_time=$(date +%s)
end_time=$((start_time + 20))

while [ $(date +%s) -lt $end_time ]; do
    if ping -c 1 mariadb > /dev/null; then
        echo "[======== MARIADB IS UP AND RUNNING ========]"
        break
    else
        echo "[======== WAITING FOR MARIADB TO START... ========]"
        sleep 1
    fi
done

if [ $(date +%s) -ge $end_time ]; then
    echo "[======== MARIADB IS NOT RESPONDING ========]"
    exit 1
fi

# Setup WordPress
wp core download --allow-root
wp core config --dbhost="mariadb:3306" --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root

# Configure PHP-FPM to listen on port 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

# Start PHP-FPM in foreground
/usr/sbin/php-fpm7.4 -F
