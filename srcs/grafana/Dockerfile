FROM alpine:3.12

ARG MINIKUBE_IP
ENV MINIKUBE_IP=${MINIKUBE_IP:-localhost}
ENV WPPORT=5050
ENV PMAPORT=5000

RUN apk update && apk add vim && \
	apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community && \
	mkdir /etc/telegraf

WORKDIR /usr/share/grafana

COPY ./provisioning_datasources_influxdb.yaml conf/provisioning/datasources/influxdb.yaml

EXPOSE 3000
CMD tail -f
#CMD grafana-server
