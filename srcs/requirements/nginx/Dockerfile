# Description: Nginx Dockerfile

# pull the base image
FROM debian:bullseye

# update, upgrade and install required packages in one RUN command
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl iputils-ping apt-utils gettext-base && \
    rm -rf /var/lib/apt/lists/*

# create the ssl directory and generate the ssl certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
     -keyout /etc/nginx/ssl/inception.key -subj \
    "/C=MY/ST=Selangor/L=PetalingJaya/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${WP_ADMIN_N}"

# copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# create the wordpress directory and set correct ownership
RUN mkdir -p /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress


# expose port 443 for HTTPS
EXPOSE 443

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]
