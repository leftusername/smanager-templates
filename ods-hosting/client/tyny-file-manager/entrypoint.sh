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
export CONSUL_SERVER=${CONSUL_SERVER:-consul}
export CONSUL=$CONSUL_SERVER


if [ -z ${FM_USER+x} ]
then
  FM_USER=`cat /proc/sys/kernel/random/uuid`
  echo -e "\e[1;33mWarning\e[0m": "FM_USER is unset use random uuid $FM_USER";
  else
  echo "FM_USER is $FM_USER"
fi

if [ -z ${FM_PASSWORD+x} ]
then
  FM_PASSWORD=`cat /proc/sys/kernel/random/uuid`
  echo -e "\e[1;33mWarning\e[0m": "FM_PASSWORD is unset use random uuid $FM_PASSWORD";
  else
  echo "FM_PASSWORD is set"
fi

if [ -z ${ODS_SM_COMPOSE_NAME+x} ]
then
  ODS_SM_COMPOSE_NAME=`cat /proc/sys/kernel/random/uuid`
  echo -e "\e[1;33mWarning\e[0m": "ODS_SM_COMPOSE_NAME is unset use random uuid $ODS_SM_COMPOSE_NAME";
  else
  echo "ODS_SM_COMPOSE_NAME is $ODS_SM_COMPOSE_NAME"
fi

#echo -e "\e[1;34mInfo\e[0m":" [filebrowser] Encrypt FM_PASSWORD..."
#ENCRYPTED_PASSWD=`php -r " echo(password_hash('$FM_PASSWORD', PASSWORD_DEFAULT)); "`
sed -i "s/'admin'/'$FM_USER'/" config.php
sed -i "s/'123qweASD'/'$FM_PASSWORD'/" config.php
sed -i "s/'\/filebrowser'/'\/filebrowser_$ODS_SM_COMPOSE_NAME'/" config.php


echo {\"service\": {\"name\": \"filebrowser-`hostname`\", \"tags\": [\"filebrowser\"], \"port\": 8080, \"meta\": {\"compose_name\": \"$ODS_SM_COMPOSE_NAME\"}}} > /consul/config/filebrowser.json


echo -e "\e[1;34mInfo\e[0m":" [filebrowser] connect to CONSUL: " $CONSUL

consul agent -node=`hostname` -join=$CONSUL -data-dir=/consul/data -config-dir /consul/config/ &

echo -e "\e[1;34mInfo\e[0m":" [filebrowser] creating simlinks ..."
old_dir=`pwd`
mkdir data/data
cd data/data
# remove broken simlinks
find . -type l ! -exec test -e {} \; -exec rm {} \;
for i in `find ../ -type d -name "www"`
do
# TODO: костыль. этот юзер имеет id 33 как в php-fpm.
chown -R xfs:php $i
ln -v -s `echo $i` `echo $i | awk -F '/' '{print $2}'`
done
cd $old_dir


echo -e "\e[1;34mInfo\e[0m":" [filebrowser] starting filebrowser ..."
# костыль. этот юзер имеет id 33 как в php-fpm.
# TODO: переделать образ на php-fpm
sudo -u xfs php -S 0.0.0.0:8080


