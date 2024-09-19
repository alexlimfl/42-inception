# Create necessary directories and build and start all services
all: 
	mkdir -p /home/choyrc/data/mariadb
	mkdir -p /home/choyrc/data/wordpress
	docker-compose -f srcs/docker-compose.yml up -d --build

# Build services without starting them
build:
	docker-compose -f srcs/docker-compose.yml build

# Stop all running services
stop:
	docker-compose -f srcs/docker-compose.yml stop

# Show logs for all services
logs:
	docker-compose -f srcs/docker-compose.yml logs

# Clean up stopped containers
clean:
	docker stop $$(docker ps -aq) || true 2> /dev/null
	docker rm -f $$(docker ps -aq) || true 2> /dev/null

# Fully clean up the environment, including volumes and images
fclean: clean
	sudo rm -rf /home/choyrc/data/wordpress
	sudo rm -rf /home/choyrc/data/mariadb
	docker rmi -f $$(docker images -aq) || true 2> /dev/null
	docker volume rm $$(docker volume ls -q) || true 2> /dev/null

# Bring up all services in attached mode
up:
	docker-compose -f srcs/docker-compose.yml up -d

# Bring down all services
down:
	docker-compose -f srcs/docker-compose.yml down

# Rebuild and restart all services
re: fclean all
