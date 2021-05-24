#!/bin/sh

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mysqld_safe & sleep 3

mysql -e "CREATE USER '$WP_DB_USERNAME'@'localhost' identified by '$WP_DB_PASSWORD';" 
mysql -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;"
mysql -e "GRANT ALL on $WP_DB_NAME.* to '$WP_DB_USERNAME'@'localhost' identified by '$WP_DB_PASSWORD';"
mysql -e "GRANT ALL on $WP_DB_NAME.* to '$WP_DB_USERNAME'@'%' identified by '$WP_DB_PASSWORD';"

mysqladmin shutdown

telegraf &

mysqld_safe --user=mysql --datadir=/var/lib/mysql
