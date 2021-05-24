FROM alpine:3.12

ARG MINIKUBE_IP
ENV MINIKUBE_IP=${MINIKUBE_IP:-localhost}
ENV WPPORT=5050
ENV PMAPORT=5000

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf

RUN apk update && \
	apk add nginx openssl vim && \
	mkdir -p /run/nginx && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

COPY ./default.conf /etc/nginx/conf.d/
COPY ./index.html /var/www/
COPY ./telegraf.conf /etc/telegraf/

RUN sed -i "s/__MINIKUBE_IP__/$MINIKUBE_IP/" /etc/nginx/conf.d/default.conf && \
	sed -i "s/__WPPORT__/$WPPORT/" /etc/nginx/conf.d/default.conf && \
	sed -i "s/__PMAPORT__/$PMAPORT/" /etc/nginx/conf.d/default.conf && \
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
		-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Test/CN=ftserver" \
		-keyout /etc/nginx/common.key \
		-out /etc/nginx/common.crt

EXPOSE 80 443

CMD telegraf & nginx -g "daemon off;"
