#!/bin/sh

CCBLUE="\033[34m"
CCBLUE_BOLD="\033[1;34m"
CCEND="\033[0m"

#export MINIKUBE_HOME=~/goinfre

echo "$CCBLUE_BOLD >>> starting minikube <<< $CCEND"
minikube start --driver=virtualbox
MINIKUBE_IP=`minikube ip`
echo "minikube IP = $MINIKUBE_IP"
sed -i '' "s/___MINIKUBE_IP___/$MINIKUBE_IP/" srcs/metallb-configmap.yml

eval $(minikube docker-env)
echo "$CCBLUE_BOLD >>> build nginx container <<< $CCEND"
docker build -t nginx_image --build-arg MINIKUBE_IP=$MINIKUBE_IP srcs/nginx
docker build -t wordpress_image srcs/wordpress
docker build -t mysql_image srcs/mysql
docker build -t phpmyadmin_image srcs/phpmyadmin
docker build -t ftps_image --build-arg MINIKUBE_IP=$MINIKUBE_IP srcs/ftps


echo "$CCBLUE_BOLD >>> enable minikube dashboard <<< $CCEND"
minikube addons enable dashboard
echo "$CCBLUE_BOLD >>> apply kube pods <<< $CCEND"
minikube addons enable metallb
kubectl apply -f srcs/metallb-configmap.yml
kubectl apply -f srcs/nginx.yml
kubectl apply -f srcs/wordpress.yml
kubectl apply -f srcs/mysql.yml
kubectl apply -f srcs/phpmyadmin.yml
kubectl apply -f srcs/ftps.yml

echo "run '$CCBLUE minikube dashboard$CCEND ' to open dashboard."
echo "minikube IP =$CCBLUE `minikube ip` $CCEND"
