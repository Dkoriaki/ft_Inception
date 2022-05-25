#!/bin/bash

chmod o+w /dev/stdout
chmod o+w /dev/stderr

if [ "$MYSQL_ROOT_PASSWORD" = "" ] || [ "$MYSQL_USER" = "" ] || [ "$MYSQL_DATABASE" = "" ]; then
	echo "Error: some environment variables are not set"
	exit 1
fi

if [ ! -d /var/lib/mysql/$DB_NAME ] ; then

	echo "Creating the $DB_NAME database..."
	mysqld&
	until mysqladmin ping;
	do
		sleep 2
	done
	mysql -u root -e "CREATE DATABASE $DB_NAME;"
    	mysql -u root -e "SET GLOBAL general_log_file='mariadb.log';"
   	mysql -u root -e "CREATE USER '$MYSQL_ROOT'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    	mysql -u root -e "GRANT ALL ON *.* TO '$DB_ROOT'@'%';"
    	mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    	mysql -u root -e "GRANT ALL ON db_wordpress.* TO '$MYSQL_USER'@'%';"
   	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -e "DELETE FROM mysql.user WHERE user=''"
	mysql -e "DELETE FROM mysql.user WHERE user='root'"
	mysql -e "FLUSH PRIVILEGES"
	killall mysqld
	echo "End first run"
	else
		echo "database already created"
fi

