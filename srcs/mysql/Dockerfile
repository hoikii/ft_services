FROM alpine:3.12

ENV WP_DB_NAME=wordpress
ENV WP_DB_USERNAME=user
ENV WP_DB_PASSWORD=password

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf

RUN apk update && \
	apk add mysql mysql-client && \
	mkdir -p /run/mysqld && \
	chown mysql:mysql /run/mysqld && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

COPY ./mariadb-server.cnf /etc/my.cnf.d/
COPY ./startup.sh /usr/sbin/
COPY ./telegraf.conf /etc/telegraf/

EXPOSE 3306

CMD startup.sh
