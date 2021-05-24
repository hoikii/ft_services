FROM alpine:3.12

ENV WP_DB_NAME=wordpress
ENV WP_DB_USERNAME=user
ENV WP_DB_PASSWORD=password
ENV WP_DB_HOST=mysql-service
ENV WP_DB_PORT=3306

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf

COPY ./wordpress-5.7.2.tar.gz /tmp/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# several php dependencies are necessary for wordpress to work properly
RUN apk update && \
	apk add vim nginx php-fpm php7-mysqli && \
	apk add php7-json php7-zlib php7-xml php7-xmlwriter php7-simplexml php7-pdo \
	php7-phar php7-openssl php7-pdo_mysql php7-mysqli php7-session php7-gd \
	php7-iconv php7-mcrypt php7-gmp php7-zip php7-curl php7-opcache php7-ctype \
	php7-apcu php7-intl php7-bcmath php7-dom php7-mbstring php7-xmlreader && \
	mkdir -p /run/nginx && \
	tar -xvf /tmp/wordpress-5.7.2.tar.gz -C /var/www/ && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

WORKDIR /var/www/wordpress

RUN cp ./wp-config-sample.php ./wp-config.php && \
	sed -i "s/database_name_here/$WP_DB_NAME/" wp-config.php && \
	sed -i "s/username_here/$WP_DB_USERNAME/" wp-config.php && \
	sed -i "s/password_here/$WP_DB_PASSWORD/" wp-config.php && \
	sed -i "s/localhost/$WP_DB_HOST:$WP_DB_PORT/" wp-config.php

COPY ./telegraf.conf /etc/telegraf/

EXPOSE 5050

CMD telegraf & php-fpm7 -F & nginx -g "daemon off;"
