# Description: MariaDB Dockerfile

# pull base image
FROM debian:bullseye

# update, upgrade and install required packages in one RUN command
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server iputils-ping apt-utils && \
    rm -rf /var/lib/apt/lists/*

# copy configuration script from host to container
COPY ./conf/mdb_conf.sh /mdb_conf.sh

# set permissions to the file
RUN chmod +x /mdb_conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mdb_conf.sh"]
