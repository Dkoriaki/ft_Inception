# setting the OS
FROM	debian:buster

# setting the author and the refresh date
LABEL	maintainer="dkoriaki"

ENV		REFRESHED_AT 2022-02-27


# installation

RUN		apt-get update -y; \
# install php
		apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common;

#install mariacb-client & curl & sudo
RUN		apt-get install -y mariadb-client curl sudo

# install wordpress cli
RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
		chmod +x wp-cli.phar; \
		mv wp-cli.phar /usr/local/bin/wp

# create php directory & wordpress site directory
RUN		mkdir -p /run/php; \
		mkdir -p /var/www/html/wordpress; \
# change the ownership of the wordpress directory
		chown -R www-data:www-data /var/www/html/wordpress; \
# create .wp-cli directory and assign it to www-data because without this we can't do "sudo -u www-data wp core download"
		mkdir -p /var/www/.wp-cli; \
		chown www-data:www-data /var/www/.wp-cli

# copy configuration file for php
COPY	./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# copy the script to set up wordpress
COPY	./tools/entrypoint.sh ./

ENTRYPOINT ["bash", "entrypoint.sh"]
