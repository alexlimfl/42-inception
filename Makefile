# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: folim <folim@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/14 00:35:57 by folim             #+#    #+#              #
#    Updated: 2024/09/14 00:36:09 by folim            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

WP_DATA = /home/data/wordpress #define the path to the wordpress data
DB_DATA = /home/data/mariadb #define the path to the mariadb data

# default target
all: up

# start the biulding process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./docker-compose.yml up -d

# build the containers
build:
	docker-compose -f ./docker-compose.yml build

# start the containers
start:
	docker-compose -f ./docker-compose.yml start

# stop and remove containers
down:
	docker-compose -f ./docker-compose.yml down

# stop the containers
stop:
	docker-compose -f ./docker-compose.yml stop


# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.
clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_DATA) || true
	@rm -rf $(DB_DATA) || true

# clean and start the containers
re: clean up
