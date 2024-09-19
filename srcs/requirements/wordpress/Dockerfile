# Description: WordPress Dockerfile

# pull the base image
FROM debian:bullseye

# update, upgrade and install required packages in one RUN command
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl php php7.4-fpm php-mysql mariadb-client iputils-ping apt-utils && \
    rm -rf /var/lib/apt/lists/*

# copy the wordpress configuration script to the container
COPY /conf/wp_conf.sh /

# change the permission of the script to make it executable
RUN chmod +x /wp_conf.sh

# expose port 9000 for php-fpm
EXPOSE 9000

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wp_conf.sh"]