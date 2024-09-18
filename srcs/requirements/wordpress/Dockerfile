FROM debian:12

# use default values or bypass configurations during the installation to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl php php8.2-fpm php-mysql mariadb-client netcat-openbsd apt-utils sendmail net-tools

COPY /conf/wp_conf.sh /
RUN  chmod +x wp_conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wp_conf.sh"]