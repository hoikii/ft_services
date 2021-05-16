FROM alpine:3.12

ENV WP_DB_NAME=wordpress
ENV WP_DB_USERNAME=user
ENV WP_DB_PASSWORD=password
ENV PMA_DB_HOST=mysql-service
ENV PMA_DB_PORT=3306

COPY ./phpMyAdmin-5.1.0-english.tar.gz /tmp/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN apk update && \
	apk add vim nginx php-fpm && \
	apk add php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-mbstring && \
	mkdir -p /run/nginx && \
	mkdir /var/www/phpmyadmin && \
	tar -xvf /tmp/phpMyAdmin-5.1.0-english.tar.gz --strip-components=1 -C /var/www/phpmyadmin

WORKDIR /var/www/phpmyadmin

RUN cp config.sample.inc.php config.inc.php && \
	sed -i "s/localhost/$PMA_DB_HOST:$PMA_DB_PORT/" config.inc.php

EXPOSE 5000

CMD php-fpm7 -F & nginx -g "daemon off;"
