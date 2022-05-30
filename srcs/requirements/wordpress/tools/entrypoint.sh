#!/bin/bash

if [ ! -f /var/www/html/wordpress/wp-config.php  ]; then
	echo "Installing Wordpress"
    cd /var/www/html/wordpress \
	&& sudo -u www-data wp core download \
    && sudo -u www-data wp config create --dbname=$DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASSWORD --dbhost=$WP_DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" \
    && sudo -u www-data wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --skip-email \
    && sudo -u www-data wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD \
    && sudo -u www-data wp theme install $WP_THEME --activate  
else
    echo "Wordpress already exist"
fi

echo "Launch php . . ."
exec php-fpm7.3 -F -R