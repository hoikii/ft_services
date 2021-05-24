FROM alpine:3.12

ARG MINIKUBE_IP
ENV MINIKUBE_IP=${MINIKUBE_IP:-localhost}
ENV WPPORT=5050
ENV PMAPORT=5000

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf

RUN apk update && apk add vim && \
	apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

WORKDIR /usr/share/grafana

COPY provisioning conf/provisioning/
COPY ./telegraf.conf /etc/telegraf/

EXPOSE 3000

CMD telegraf & grafana-server
