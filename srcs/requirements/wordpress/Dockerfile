FROM debian:12

RUN         apt-get update && apt-get upgrade -y
RUN         apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat

COPY        ./wp_conf.sh /

RUN         chmod +x wp_conf.sh

# Define the entrypoint command to run when the container starts
ENTRYPOINT  ["./wp_conf.sh"]