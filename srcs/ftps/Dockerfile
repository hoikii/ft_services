FROM alpine:3.12

ARG MINIKUBE_IP
ENV MINIKUBE_IP=${MINIKUBE_IP:-localhost}
ENV FTP_PASV_MIN_PORT=30020
ENV FTP_PASV_MAX_PORT=30020
ENV FTP_USERNAME=user
ENV FTP_PASSWORD=password

ENV __INFLUXDB_URL__=http://influxdb-service:8086
ENV __INFLUXDB_NAME__=telegraf

RUN apk update && \
	apk add vim vsftpd openssl && \
	adduser -D $FTP_USERNAME && \
	echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd && \
	echo "this is sample text file" > /home/$FTP_USERNAME/smpl.txt && \
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
		-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Test/CN=ftserver" \
		-keyout /etc/ssl/private/vsftpd.key \
		-out /etc/ssl/certs/vsftpd.crt && \
	apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/v3.13/community

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./startup.sh /usr/sbin/
COPY ./telegraf.conf /etc/telegraf/

RUN sed -i "s/__MINIKUBE_IP__/$MINIKUBE_IP/" /etc/vsftpd/vsftpd.conf && \
	sed -i "s/__FTP_PASV_MIN_PORT__/$FTP_PASV_MIN_PORT/" /etc/vsftpd/vsftpd.conf && \
	sed -i "s/__FTP_PASV_MAX_PORT__/$FTP_PASV_MAX_PORT/" /etc/vsftpd/vsftpd.conf

WORKDIR /home/user

EXPOSE 21 30020

CMD startup.sh
