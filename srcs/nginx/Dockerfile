FROM alpine:3.12

ARG MINIKUBE_IP
ENV MINIKUBE_IP=${MINIKUBE_IP:-localhost}
ENV WPPORT=5050
ENV PMAPORT=5000

RUN apk update && \
	apk add nginx && \
	apk add openssl && \
	apk add vim && \
	mkdir -p /run/nginx

COPY ./default.conf /etc/nginx/conf.d/
COPY ./index.html /var/www/

RUN sed -i "s/__MINIKUBE_IP__/$MINIKUBE_IP/" /etc/nginx/conf.d/default.conf && \
	sed -i "s/__WPPORT__/$WPPORT/" /etc/nginx/conf.d/default.conf && \
	sed -i "s/__PMAPORT__/$PMAPORT/" /etc/nginx/conf.d/default.conf && \
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Test/CN=ftserver" -keyout /etc/nginx/common.key -out /etc/nginx/common.crt

EXPOSE 80 443

CMD nginx -g "daemon off;"
