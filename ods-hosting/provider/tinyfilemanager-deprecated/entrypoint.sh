#!/usr/bin/env bash
#PASSWORD=${PASSWORD:-password}
#MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-5000}
## Possible rules are 'OFF', 'AND' or 'OR'
## OFF => Don't check connection IP, defaults to OFF
## AND => Connection must be on the whitelist, and not on the blacklist
## OR => Connection must be on the whitelist, or not on the blacklist
#IP_RULESET_ON=${IP_RULESET_ON:-OFF}
#IP_RULESET_IP=${IP_RULESET_IP:-127.0.0.1}
#sed -i "s/'123qweASD'/'$PASSWORD'/" config.php
#sed -i 's/$max_upload_size_bytes = 5000;/$max_upload_size_bytes = $MAX_UPLOAD_SIZE;/' config.php
#sed -i "s/$ip_ruleset = 'OFF';/$ip_ruleset = '$IP_RULESET_ON';/" config.php
#sed -i "s/'127.0.0.1',    \/\/ local ipv4/'$IP_RULESET_IP',    \/\/ local ipv4/" config.php
#


set -eo pipefail

export CONSUL_PORT=${CONSUL_PORT:-8500}
export CONSUL_SERVER=${CONSUL_SERVER:-consul}
export CONSUL=$CONSUL_SERVER:$CONSUL_PORT


echo -e "\e[1;34mInfo\e[0m":" [nginx] connect to CONSUL: " $CONSUL

consul-template  -consul-addr $CONSUL -template "/etc/consul-template/templates/filemanager.ctmpl:/var/www/html/config.php:echo 'config changed'" >>/tmp/log_template.log &
sleep 2
tail -q -fn 100 /tmp/log_* &

php -S 0.0.0.0:80 >>/tmp/log_template.log &

while [ `ps -ef | grep 'php' | grep -v grep -c` -gt 0 ]
do
#echo test sleep
sleep 3
done