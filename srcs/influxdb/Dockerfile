FROM alpine:3.12

RUN apk update && \
	apk add influxdb vim

EXPOSE 8086

CMD influxd

#influx -database telegraf
#SELECT usage_idle FROM cpu WHERE cpu = 'cpu-total'
