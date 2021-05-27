FROM alpine:3.12

ENV __INFLUXDB_URL__=http://localhost:8086
ENV __INFLUXDB_NAME__=telegraf

RUN apk update && \
	apk add influxdb vim && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

COPY ./telegraf.conf /etc/telegraf/

EXPOSE 8086

CMD telegraf & influxd run -config /etc/influxdb.conf

#influx -database telegraf
#SELECT usage_idle FROM cpu WHERE cpu = 'cpu-total'
