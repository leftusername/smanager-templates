#!/bin/bash

set -eo pipefail

export CONSUL_PORT=${CONSUL_PORT:-8500}
export CONSUL_SERVER=${CONSUL_SERVER:-consul}
export CONSUL=$CONSUL_SERVER:$CONSUL_PORT


echo -e "\e[1;34mInfo\e[0m":" [nginx] starting nginx ..."
nginx -g "daemon off;" >>/tmp/log_nginx.log &
sleep 2
echo -e "\e[1;34mInfo\e[0m":" [nginx] connect to CONSUL: " $CONSUL

consul-template  -consul-addr $CONSUL -template "/etc/consul-template/templates/nginx.ctmpl:/etc/nginx/conf.d/consul-template.conf:kill -s HUP $(cat /var/run/nginx.pid)" >>/tmp/log_template.log &
sleep 2
tail -q -fn 100 /tmp/log_* &

while [ `ps -ef | grep 'nginx' | grep -v grep -c` -gt 0 ]
do
#echo test sleep
sleep 3
done