# Use Debian 11 as the base image
FROM debian:11

# Set the working directory inside the container
WORKDIR /var/www/html/

# Copy the auto configuration script to the container
COPY conf/auto_conf.sh /home/

# Update package lists and upgrade installed packages
# Install PHP, wget, PHP-FPM, and PHP-MySQL
# Download WP-CLI
# Make WP-CLI executable
# Move WP-CLI to a directory in the PATH
# Make the auto configuration script executable
RUN apt update -y && apt upgrade -y && \
    apt install -y php wget \
    php-fpm \
    php-mysql && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /bin/ && \
    chmod +x /home/auto_conf.sh

# Copy the PHP-FPM pool configuration file to the container
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set the command to run when the container starts
CMD [ "bash", "/home/auto_conf.sh" ]
