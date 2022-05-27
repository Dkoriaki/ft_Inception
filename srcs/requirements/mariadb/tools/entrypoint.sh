#!/bin/bash

echo "1 = ${MYSQL_ROOT_PASSWORD}"

if [ "${MYSQL_ROOT_PASSWORD}" = "" ] || [ "${MYSQL_ROOT}" = "" ] || [ "${DB_NAME}" = "" ]; then
	echo "Error: some environment variables are not set for mariadb installation"
	exit 1
fi

if [ ! -d /var/lib/mysql/$DB_NAME ] ; then

	echo "Creating the $DB_NAME database..."
	#service mysql start
	mysqld&
	sleep 3
	mysql -u root -e "CREATE DATABASE ${DB_NAME};"
    	mysql -u root -e "SET GLOBAL general_log_file='mariadb.log';"
   	mysql -u root -e "CREATE USER '${MYSQL_ROOT}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    	mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_ROOT}'@'%';"
	mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
   	mysql -u root -e "GRANT ALL ON ${DB_NAME}.* TO '${MYSQL_USER}'@'%';"
   	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -e "DELETE FROM mysql.user WHERE user=''"
	mysql -e "DELETE FROM mysql.user WHERE user='root'"
	mysql -e "FLUSH PRIVILEGES"
	killall mysqld
	echo "$DB_NAME database has been created"
else
	echo "$DB_NAME database already created"
fi

echo "J'ai envie de tout nqiuer"

mysqld
