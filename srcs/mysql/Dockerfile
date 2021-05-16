FROM alpine:3.12

ENV WP_DB_NAME=wordpress
ENV WP_DB_USERNAME=user
ENV WP_DB_PASSWORD=password

RUN apk add mysql mysql-client && \
	mkdir -p /run/mysqld && \
	chown mysql:mysql /run/mysqld && \
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./mariadb-server.cnf /etc/my.cnf.d/
RUN mysqld_safe & sleep 3 && \
	mysql -e "CREATE USER '$WP_DB_USERNAME'@'localhost' identified by '$WP_DB_PASSWORD';" && \
	mysql -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;" && \
	mysql -e "GRANT ALL on $WP_DB_NAME.* to '$WP_DB_USERNAME'@'localhost' identified by '$WP_DB_PASSWORD';" && \
	mysql -e "GRANT ALL on $WP_DB_NAME.* to '$WP_DB_USERNAME'@'%' identified by '$WP_DB_PASSWORD';" && \
	sed -i "s/skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

CMD mysqld_safe --user=mysql
