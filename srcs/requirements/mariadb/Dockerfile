# Description: MariaDB Dockerfile

# pull base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y mariadb-server

# copy file from host to container
COPY ./tools/mariadb.sh /mariadb.sh

# set permissions to the file
RUN chmod +x /mariadb.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mariadb.sh"]