# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: folim <folim@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/20 16:34:28 by folim             #+#    #+#              #
#    Updated: 2024/09/20 16:34:30 by folim            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

WP_DATA = /home/folim/data/wordpress
DB_DATA = /home/folim/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

start:
	docker compose -f ./srcs/docker-compose.yml start

build:
	clear
	docker compose -f ./srcs/docker-compose.yml build

ngx:
	@docker exec -it nginx bash

mdb:
	@docker exec -it mariadb bash

wp:
	@docker exec -it wordpress bash

clean:
	@docker stop nginx mariadb wordpress || true
	@docker rm nginx mariadb wordpress || true
	@docker rmi -f nginx wordpress mariadb || true
	@docker volume rm $$(docker volume ls -qf name=wordpress) || true
	@docker volume rm $$(docker volume ls -qf name=mariadb) || true
	@docker network rm $$(docker network ls -qf name=inception) || true
	@sudo rm -rf $(WP_DATA) || true
	@sudo rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f

.PHONY: all up down stop start build ng mdb wp clean re prune
