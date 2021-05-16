FROM alpine:3.12

ENV WP_DB_NAME=wordpress
ENV WP_DB_USERNAME=user
ENV WP_DB_PASSWORD=password

RUN apk add mysql mysql-client && \
	mkdir -p /run/mysqld && \
	chown mysql:mysql /run/mysqld

COPY ./mariadb-server.cnf /etc/my.cnf.d/
COPY ./startup.sh /usr/sbin/

EXPOSE 3306

CMD startup.sh
