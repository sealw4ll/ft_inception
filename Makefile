WP_DATA = /home/seal/data/wordpress #define the path to the wordpress data
DB_DATA = /home/seal/data/mariadb #define the path to the mariadb data

# default target
all: up

# start the biulding process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d

# stop the containers
down:
	docker compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker compose -f ./srcs/docker-compose.yml stop

# start the containers
start:
	docker compose -f ./srcs/docker-compose.yml start

# build the containers
build:
	docker compose -f ./srcs/docker-compose.yml build

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

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: clean
	@docker system prune -a --volumes -f

# test for db
# docker exec -ti mariadb /bin/bash
# mysql -u wting -p
# SHOW DATABASES;
# use inception_db
# SHOW TABLES
#  INSERT INTO wp_users (ID, user_login, user_pass, user_nicename, user_email, user_url, user_registered, user_activation_key, user_status, display_name) VALUES (NULL, 'test', '', 'test', 'test@gmail.com', '', '2024-10-04 10:00:00', '', 0, 'test');
# SELECT * FROM wp_users