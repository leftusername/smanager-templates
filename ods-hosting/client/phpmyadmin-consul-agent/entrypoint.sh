#!/usr/bin/env bash

export CONSUL_SERVER=${CONSUL_SERVER:-consul}
export CONSUL=$CONSUL_SERVER
#BIND_ADDR=`ip addr show eth0 | grep inet | awk '{print $2}' | awk -F '/' '{print $1}'`

if [ -z ${ODS_SM_COMPOSE_NAME+x} ]
then
  ODS_SM_COMPOSE_NAME=`cat /proc/sys/kernel/random/uuid`
  echo -e "\e[1;33mWarning\e[0m": "ODS_SM_COMPOSE_NAME is unset use random uuid $ODS_SM_COMPOSE_NAME";
  else
  echo "ODS_SM_COMPOSE_NAME is $ODS_SM_COMPOSE_NAME"
fi

echo {\"service\": {\"name\": \"phpmyadmin-`hostname`\", \"tags\": [\"phpmyadmin\"], \"port\": 80, \"meta\": {\"compose_name\": \"$ODS_SM_COMPOSE_NAME\"}}} > /consul/config/phpmyadmin.json


TARGET_IP=`getent hosts $CONSUL | awk '{print $1}'`
IP_ADDR=`ip route get $TARGET_IP| grep $TARGET_IP | awk '{print $5}'`
echo -e "\e[1;34mInfo\e[0m":" [phpmyadmin] connect to CONSUL: $CONSUL via $IP_ADDR"
consul agent -bind=$IP_ADDR -node=`hostname` -join=$CONSUL -data-dir=/consul/data -config-dir /consul/config/ &


echo -e "\e[1;34mInfo\e[0m":" [phpmyadmin] starting phpmyadmin ..."

/docker-entrypoint.sh "$@"


