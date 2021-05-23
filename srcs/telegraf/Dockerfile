FROM alpine:3.12

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf
ENV __INFLUXDB_USER__=user
ENV __INFLUXDB_PASSWORD__=password

RUN apk update && apk add vim && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community && \
	mkdir /etc/telegraf

COPY ./telegraf.conf /etc/telegraf/

CMD telegraf --config /etc/telegraf/telegraf.conf
