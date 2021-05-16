#!/bin/sh

CCBLUE="\033[34m"
CCBLUE_BOLD="\033[1;34m"
CCEND="\033[0m"

echo "$CCBLUE_BOLD >>> starting minikube <<< $CCEND"
minikube start --driver=virtualbox
IP=`minikube ip`
echo "minikube IP = $IP"
sed -i '' "s/___MINIKUBE_IP___/$IP/" srcs/metallb-configmap.yml

eval $(minikube docker-env)
echo "$CCBLUE_BOLD >>> build nginx container <<< $CCEND"
docker build -t nginx_image srcs/nginx
docker build -t wordpress_image srcs/wordpress


echo "$CCBLUE_BOLD >>> apply kube pods <<< $CCEND"
minikube addons enable metallb
kubectl apply -f srcs/metallb-configmap.yml
kubectl apply -f srcs/nginx.yml
kubectl apply -f srcs/wordpress.yml
