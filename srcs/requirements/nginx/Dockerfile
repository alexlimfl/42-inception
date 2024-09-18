FROM	debian:12

# use default values or bypass configurations during the installation to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN		apt-get update && apt-get upgrade -y
RUN		apt-get install -y nginx openssl apt-utils
RUN		mkdir -p /etc/nginx/ssl && chmod 777 /etc/nginx/ssl

#	Generate ssl certificate.
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt\
		-keyout /etc/nginx/ssl/inception.key -subj "/"

COPY	conf/nginx.conf /etc/nginx/nginx.conf

RUN		mkdir -p var/www/wordpress && chmod 777 var/www/wordpress

#	Change owner of wordpress directory to www-data.
RUN		chown -R www-data:www-data /var/www/wordpress

#	Define command to run when the container starts.
CMD		["nginx", "-g", "daemon off;"]
