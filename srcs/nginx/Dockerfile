FROM alpine:3.12

EXPOSE 80 443

RUN apk update && \
	apk add nginx && \
	apk add openssl && \
	apk add vim && \
	mkdir -p /run/nginx

COPY ./default.conf /etc/nginx/conf.d/
COPY ./index.html /var/www/

RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Test/CN=ftserver" -keyout /etc/nginx/common.key -out /etc/nginx/common.crt

CMD nginx -g "daemon off;"
