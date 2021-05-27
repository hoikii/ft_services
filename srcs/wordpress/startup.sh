#!/bin/sh

#wait until mysql is ready
while ! mysql -h $WP_DB_HOST -u $WP_DB_USERNAME -p$WP_DB_PASSWORD -e "USE $WP_DB_NAME" 2> /dev/null; do
	echo waiting for mysql-service..
	sleep 1
done

mysql -h $WP_DB_HOST -u $WP_DB_USERNAME -p$WP_DB_PASSWORD --database=$WP_DB_NAME < /tmp/wp_dump.sql

telegraf & php-fpm7 -F & nginx -g "daemon off;"
