# Use Debian 11 as the base image
FROM debian:11

# Update the package list and upgrade installed packages
# Install necessary packages: nginx, openssl, gettext-base
# Create the SSL directory and set permissions
# Set permissions for the web root directory
# Change ownership of the web root directory to the www-data user
RUN apt update -y && apt upgrade -y && \
    apt install nginx openssl gettext-base -y && \
    mkdir -p /etc/nginx/ssl/ && chmod 755 /etc/nginx/ssl && \
    chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Copy the custom nginx configuration file to the container
COPY ./conf/nginx.conf /

# Define the command to run when the container starts
# Generate a self-signed SSL certificate
# Start nginx in the foreground
CMD bash -c 'envsubst < /nginx.conf > /etc/nginx/conf.d/nginx.conf \ 
    && openssl req -x509 -nodes -out \
    "/etc/nginx/ssl/self.cert" -keyout "/etc/nginx/ssl/self.key" -subj "/"\
    && nginx -g "daemon off;"'
