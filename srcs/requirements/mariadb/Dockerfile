FROM debian:12

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

COPY ./conf/mdb_conf.sh /mdb_conf.sh
RUN chmod +x /mdb_conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./mdb_conf.sh"]