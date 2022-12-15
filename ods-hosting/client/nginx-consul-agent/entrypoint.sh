#!/bin/bash

export SITE_DOMAIN=${SITE_DOMAIN:-example.com}
#export CONSUL_PORT=${CONSUL_PORT:-8500}
export CONSUL_SERVER=${CONSUL_SERVER:-consul}
export CONSUL=$CONSUL_SERVER

if [ -z ${ODS_SM_COMPOSE_NAME+x} ]
then
  ODS_SM_COMPOSE_NAME=`cat /proc/sys/kernel/random/uuid`
  echo -e "\e[1;33mWarning\e[0m": "ODS_SM_COMPOSE_NAME is unset use random uuid $ODS_SM_COMPOSE_NAME";
  else
  echo "ODS_SM_COMPOSE_NAME is $ODS_SM_COMPOSE_NAME"
fi

#ENCRYPTED_PASSWD=`php -r " echo(password_hash('$FM_PASSWORD', PASSWORD_DEFAULT)); "`
#echo {\"service\": {\"name\": \"$SITE_DOMAIN\", \"tags\": [\"php7\"], \"Address\": \"`hostname`\", \"port\": 9000}} >> /consul/config/php.json
#echo {\"service\": {\"name\": \"nginx-`hostname`\", \"tags\": [\"nginx\"], \"port\": 80, \"meta\": {\"site_domain\": \"$SITE_DOMAIN\", \"fm_user\": \"$FM_USER\", \"fm_password\": \"$ENCRYPTED_PASSWD\"}}} > /consul/config/nginx.json
echo {\"service\": {\"name\": \"nginx-`hostname`\", \"tags\": [\"nginx\"], \"port\": 80, \"meta\": {\"site_domain\": \"$SITE_DOMAIN\", \"compose_name\": \"$ODS_SM_COMPOSE_NAME\"}}} > /consul/config/nginx.json

TARGET_IP=`getent hosts $CONSUL | awk '{print $1}'`
IP_ADDR=`ip route get $TARGET_IP| grep $TARGET_IP | awk '{print $5}'`
echo -e "\e[1;34mInfo\e[0m":" [nginx] connect to CONSUL: $CONSUL via $IP_ADDR"
consul agent -bind=$IP_ADDR -node=`hostname` -join=$CONSUL -data-dir=/consul/data -config-dir /consul/config/ &

echo -e "\e[1;34mInfo\e[0m":" [nginx] starting nginx ..."
nginx -g "daemon off;"
