#!/bin/bash


PLATFORM_KEY=${PLATFORM_KEY:-DFEQDVSC}

FASTCGI_PASS=${FASTCGI_PASS:-unix:/var/run/php5-fpm.sock}
WORKER_PROCESSES=${WORKER_PROCESSES:-auto}
WORKER_CONNECTIONS=${WORKER_CONNECTIONS:-2048}
KEEPALIVE_TIMEOUT=${KEEPALIVE_TIMEOUT:-65}
CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-500k}


###################  change config ########################
if [ ! -f /tmp/configured ]
then

  if [ ! "${FASTCGI_PASS}" = "unix:/var/run/php5-fpm.sock" ]
  then
    echo "Setting 'fastcgi_pass' to '${FASTCGI_PASS}'"
    sed -i "s#fastcgi_pass unix:/var/run/php5-fpm.sock#fastcgi_pass ${FASTCGI_PASS}#g" /etc/nginx/conf.d/default.conf
  else
    echo "Using default value '${FASTCGI_PASS}' for 'fastcgi_pass'"
  fi
  

  if [ ! "${PLATFORM_KEY}" = "DFEQDVSC" ]
  then
    echo "Setting 'platform.key' to '${PLATFORM_KEY}'"
    sed -i "s/add_header K-PlatForm \"DFEQDVSC\"/add_header K-PlatForm \"${PLATFORM_KEY}\"/g" /etc/nginx/conf.d/default.conf
  else
    echo "Using default value '${PLATFORM_KEY}' for 'platform.key'"
  fi

  if [ ! "${WORKER_PROCESSES}" = "auto" ]
  then
    echo "Setting 'worker_processes' to '${WORKER_PROCESSES}'"
    sed -i "s/worker_processes  auto/worker_processes  ${WORKER_PROCESSES}/g" /etc/nginx/nginx.conf
  else
    echo "Using default value '${WORKER_PROCESSES}' for 'worker_processes'"
  fi

  if [ ! "${WORKER_CONNECTIONS}" = "2048" ]
  then
    echo "Setting 'worker_connections' to '${WORKER_CONNECTIONS}'"
    sed -i "s/worker_connections  2048/worker_connections  ${WORKER_CONNECTIONS}/g" /etc/nginx/nginx.conf
  else
    echo "Using default value '${WORKER_CONNECTIONS}' for 'worker_connections'"
  fi

  if [ ! "${KEEPALIVE_TIMEOUT}" = "65" ]
  then
    echo "Setting 'keepalive_timeout' to '${KEEPALIVE_TIMEOUT}'"
    sed -i "s/keepalive_timeout  65/keepalive_timeout  ${KEEPALIVE_TIMEOUT}/g" /etc/nginx/nginx.conf
  else
    echo "Using default value '${KEEPALIVE_TIMEOUT}' for 'keepalive_timeout'"
  fi

  if [ ! "${CLIENT_MAX_BODY_SIZE}" = "500k" ]
  then
    echo "Setting 'client_max_body_size' to '${CLIENT_MAX_BODY_SIZE}'"
    sed -i "s/client_max_body_size 500k/client_max_body_size ${CLIENT_MAX_BODY_SIZE}/g" /etc/nginx/nginx.conf
  else
    echo "Using default value '${CLIENT_MAX_BODY_SIZE}' for 'client_max_body_size'"
  fi

  touch /tmp/configured
  echo "Configuration complete."
fi

nginx -g 'daemon off;'

