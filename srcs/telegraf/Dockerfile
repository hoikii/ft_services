FROM alpine:3.12

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf
ENV __INFLUXDB_USER__=user
ENV __INFLUXDB_PASSWORD__=password

RUN apk update && apk add vim && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
	mkdir /etc/telegraf

COPY ./telegraf.conf /etc/telegraf/

CMD telegraf --config /etc/telegraf/telegraf.conf
#check lower version if malfunction
#wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.5-static_linux_amd64.tar.gz
