#!/bin/sh

CCBLUE="\033[34m"
CCBLUE_BOLD="\033[1;34m"
CCEND="\033[0m"

#export MINIKUBE_HOME=~/goinfre
## To reset minikube ip back to 192.168.99.100, reset virtualbox DHCP leases.
#minikube delete
#rm ~/Library/VirtualBox/HostInterfaceNetworking-vboxnet0-Dhcpd.leases

echo "$CCBLUE_BOLD >>> starting minikube <<< $CCEND"
minikube start --driver=virtualbox
MINIKUBE_IP=`minikube ip`
echo "minikube IP = $MINIKUBE_IP"
if [ "`uname`" = "Darwin" ];
then
	sed -i '' "s/___MINIKUBE_IP___/$MINIKUBE_IP/" srcs/metallb-configmap.yml
else
	sed '' "s/___MINIKUBE_IP___/$MINIKUBE_IP/" srcs/metallb-configmap.yml
fi

eval $(minikube docker-env)
echo "$CCBLUE_BOLD >>> build nginx container <<< $CCEND"
docker build -t nginx_image --build-arg MINIKUBE_IP=$MINIKUBE_IP srcs/nginx
docker build -t mysql_image srcs/mysql
docker build -t wordpress_image --build-arg MINIKUBE_IP=$MINIKUBE_IP srcs/wordpress
docker build -t phpmyadmin_image srcs/phpmyadmin
docker build -t ftps_image --build-arg MINIKUBE_IP=$MINIKUBE_IP srcs/ftps
docker build -t influxdb_image srcs/influxdb
docker build -t telegraf_image srcs/telegraf
docker build -t grafana_image srcs/grafana


echo "$CCBLUE_BOLD >>> enable minikube dashboard <<< $CCEND"
minikube addons enable dashboard
echo "$CCBLUE_BOLD >>> apply kube pods <<< $CCEND"
minikube addons enable metallb
kubectl apply -f srcs/metallb-configmap.yml
kubectl apply -f srcs/nginx.yml
kubectl apply -f srcs/mysql.yml
kubectl apply -f srcs/wordpress.yml
kubectl apply -f srcs/phpmyadmin.yml
kubectl apply -f srcs/ftps.yml
kubectl apply -f srcs/influxdb.yml
kubectl apply -f srcs/telegraf.yml
kubectl apply -f srcs/grafana.yml

echo "run '$CCBLUE minikube dashboard$CCEND ' to open dashboard."
echo "minikube IP =$CCBLUE `minikube ip` $CCEND"
