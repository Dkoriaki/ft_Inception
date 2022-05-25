# setting the OS
FROM 	debian:buster

# setting the author and the refresh date
LABEL	maintainer="dkoriaki"

ENV	REFRESHED_AT 2022-05-20

  
# installation
RUN 	apt-get update -y; \
	apt-get install -y mariadb-server; \
# purge and re-create /var/lib/mysql with appropriate ownership
	rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 777 /var/run/mysqld; \
# Allow Remote Connections to MySQL Database Server
	sed -i "s|.*bind-address\s*=.*|bind-adress=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# copy the script to launch mariadb, create users and DB
COPY 	tools/entrypoint.sh /scripts/entrypoint.sh

# redirect output with symbolic links for logs
RUN 	ln -sf /dev/stdout /var/log/mysql/mariadb.log && \
	ln -sf /dev/stderr /var/log/mysql/error.log

#ENTRYPOINT ["/bin/bash"]
# Launch the script
ENTRYPOINT ["/scripts/entrypoint.sh"]


