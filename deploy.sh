#!/bin/bash
MODE=$1
DOMAIN=$2

if [ "$MODE" == "docker" ]; then
  echo "[+] Deploying via Docker Compose for $DOMAIN"
  cd docker
  export NEXTCLOUD_DOMAIN=$DOMAIN
  docker compose -p "$DOMAIN" up -d
elif [ "$MODE" == "k8s" ]; then
  echo "[+] Deploying to Kubernetes with Helm for $DOMAIN"
  helm repo add nextcloud https://nextcloud.github.io/helm/
  helm repo update
  helm upgrade --install $DOMAIN nextcloud/nextcloud \
    --namespace nextcloud-$DOMAIN --create-namespace \
    --set ingress.enabled=true \
    --set ingress.hosts[0].host=$DOMAIN \
    --set ingress.tls[0].hosts[0]=$DOMAIN \
    --set ingress.tls[0].secretName=$DOMAIN-tls \
    --set nextcloud.host=$DOMAIN \
    -f k8s/values.yaml
else
  echo "Invalid mode. Use docker or k8s."
fi
