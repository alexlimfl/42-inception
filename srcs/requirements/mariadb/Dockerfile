FROM debian:12

# use default values or bypass configurations during the installation to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server apt-utils

COPY ./conf/mdb_conf.sh /mdb_conf.sh
RUN chmod +x /mdb_conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./mdb_conf.sh"]