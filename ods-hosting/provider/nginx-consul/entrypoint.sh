#!/bin/bash

set -eo pipefail

export CONSUL_PORT=${CONSUL_PORT:-8500}
export HOST_IP=${HOST_IP:-consul}
export CONSUL=$HOST_IP:$CONSUL_PORT

echo "[nginx] booting container. CONSUL: $CONSUL."

# Try to make initial configuration every 5 seconds until successful
consul-template -once -retry 5s -consul $CONSUL -template "/etc/consul-template/templates/nginx.ctmpl:/etc/nginx/conf.d/consul-template.conf"

# Put a continual polling `confd` process into the background to watch
# for changes every 10 seconds
consul-template  -consul $CONSUL -template "/etc/consul-template/templates/nginx.ctmpl:/etc/nginx/conf.d/consul-template.conf:service nginx reload" &
echo "[nginx] consul-template is now monitoring consul for changes..."

# Start the Nginx service using the generated config
echo "[nginx] starting nginx ..."
nginx