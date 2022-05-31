# setting the OS
FROM 	debian:buster

# setting the author and the refresh date
LABEL	maintainer="dkoriaki"

ENV	REFRESHED_AT 2022-05-31

# installation
RUN 	apt-get update -y; \
	apt-get install -y mariadb-server mariadb-client; \
#necessary permissions and directories
	mkdir -p /run/mysqld ; \
	mkdir -p /var/run/mysqld; \
	chown -R mysql:mysql /run/mysqld ; \
	chown -R mysql:mysql /var/run/mysqld; \
 	chown -R mysql:mysql /var/lib/mysql; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
 	chmod 777 /var/run/mysqld;

# # Allow Remote Connections to MySQL Database Server
RUN   sed -i "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

# copy the script to launch mariadb, create users and DB
COPY 	tools/entrypoint.sh ./

# Launch the script
ENTRYPOINT ["bash", "entrypoint.sh"]


