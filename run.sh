#!/bin/bash

ADMIN_URL=${ADMIN_URL:-ahoho}
APP_DEBUG=${APP_DEBUG:-true}
APP_TRACE=${APP_TRACE:-true}

PLATFORM_KEY=${PLATFORM_KEY:-DFEQDVSC}

TEMPLATE=${TEMPLATE:-1}

MYSQL_HOST=${MYSQL_HOST:-172.17.0.1}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_DB=${MYSQL_DB:-lottery_portal}
MYSQL_USER=${MYSQL_USER:-root}
MYSQL_PASSWD=${MYSQL_PASSWD:-123456}

WORKER_PROCESSES=${WORKER_PROCESSES:-auto}
WORKER_CONNECTIONS=${WORKER_CONNECTIONS:-2048}
KEEPALIVE_TIMEOUT=${KEEPALIVE_TIMEOUT:-65}
CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-500k}

OPCACHE_MEM_CONSUMPTION=${OPCACHE_MEM_CONSUMPTION:-128}
PM_MAX_CHILDREN=${PM_MAX_CHILDREN:-100}
PM_MIN_SPARE_SERVERS=${PM_MIN_SPARE_SERVERS:-10}
PM_MAX_SPARE_SERVERS=${PM_MAX_SPARE_SERVERS:-15}
PM_START_SERVERS=${PM_START_SERVERS:-10}

if [ ! -f /tmp/configured ]
then

  if [ ! "${PLATFORM_KEY}" = "DFEQDVSC" ]
  then
    echo "Setting 'platform.key' to '${PLATFORM_KEY}'"
    sed -i "s#add_header K-PlatForm \"DFEQDVSC\"#add_header K-PlatForm \"${PLATFORM_KEY}\"#g" /etc/nginx/conf.d/default.conf
  else
    echo "Using default value '${PLATFORM_KEY}' for 'platform.key'"
  fi

  if [ ! "${ADMIN_URL}" = "ahoho" ]
  then
    echo "Setting 'config.admin_url' to '${ADMIN_URL}'"
    sed -i "s/ahoho/${ADMIN_URL}/g" /var/www/app/application/config.php
  else
    echo "Using default value '${ADMIN_URL}' for 'config.admin_url'"
  fi

  if [ ! "${TEMPLATE}" = "1" ]
  then
    echo "Setting 'config.TEMPLATE' to '${TEMPLATE}'"
    sed -i "s/'template' => ''/'template' => '${TEMPLATE}'/g" /var/www/app/application/config.php
  else
    echo "Using default value '${TEMPLATE}' for 'config.TEMPLATE'"
  fi

  if [ ! "${APP_DEBUG}" = "true" ]
  then
    echo "Setting 'config.app_debug' to '${APP_DEBUG}'"
    sed -i "s/'app_debug' => true/'app_debug' => ${APP_DEBUG}/g" /var/www/app/application/config.php
  else
    echo "Using default value '${APP_DEBUG}' for 'config.app_debug'"
  fi

  if [ ! "${APP_TRACE}" = "true" ]
  then
    echo "Setting 'config.app_trace' to '${APP_TRACE}'"
    sed -i "s/'app_trace' => true/'app_trace' => ${APP_TRACE}/g" /var/www/app/application/config.php
  else
    echo "Using default value '${APP_TRACE}' for 'config.app_trace'"
  fi

  if [ ! "${MYSQL_HOST}" = "172.17.0.1" ]
  then
    echo "Setting 'mysql.hostname' to '${MYSQL_HOST}'"
    sed -i "s/'hostname' => '172.17.0.1'/'hostname' => '${MYSQL_HOST}'/g" /var/www/app/application/database.php
  else
    echo "Using default value '${MYSQL_HOST}' for 'mysql.hostname'"
  fi

  if [ ! "${MYSQL_PORT}" = "3306" ]
  then
    echo "Setting 'mysql.port' to '${MYSQL_PORT}'"
    sed -i "s/'hostport' => '3306'/'hostport' => '${MYSQL_PORT}'/g" /var/www/app/application/database.php
  else
    echo "Using default value '${MYSQL_PORT}' for 'mysql.port'"
  fi

  if [ ! "${MYSQL_DB}" = "lottery_portal" ]
  then
    echo "Setting 'mysql.database' to '${MYSQL_DB}'"
    sed -i "s/'database' => 'lottery_portal'/'database' => '${MYSQL_DB}'/g" /var/www/app/application/database.php
  else
    echo "Using default value '${MYSQL_DB}' for 'mysql.database'"
  fi

  if [ ! "${MYSQL_USER}" = "root" ]
  then
    echo "Setting 'mysql.username' to '${MYSQL_USER}'"
    sed -i "s/'username' => 'root'/'username' => '${MYSQL_USER}'/g" /var/www/app/application/database.php
  else
    echo "Using default value '${MYSQL_USER}' for 'mysql.username'"
  fi

  if [ ! "${MYSQL_PASSWD}" = "123456" ]
  then
    echo "Setting 'mysql.password' to '${MYSQL_PASSWD}'"
    sed -i "s/'password' => '123456'/'password' => '${MYSQL_PASSWD}'/g" /var/www/app/application/database.php
  else
    echo "Using default value '${MYSQL_PASSWD}' for 'mysql.password'"
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

  if [ ! "${OPCACHE_MEM_CONSUMPTION}" = "128" ]
  then
    echo "Setting 'opcache.memory_consumption' to '${OPCACHE_MEM_CONSUMPTION}'"
    sed -i "s/opcache.memory_consumption=128/opcache.memory_consumption=${OPCACHE_MEM_CONSUMPTION}/g" /etc/php5/fpm/php.ini
  else
    echo "Using default value '${OPCACHE_MEM_CONSUMPTION}' for 'opcache.memory_consumption'"
  fi

  if [ ! "${PM_MAX_CHILDREN}" = "100" ]
  then
    echo "Setting 'pm.max_children' to '${PM_MAX_CHILDREN}'"
    sed -i "s/pm.max_children = 100/pm.max_children = ${PM_MAX_CHILDREN}/g" /etc/php5/fpm/pool.d/www.conf
  else
    echo "Using default value '${PM_MAX_CHILDREN}' for 'pm.max_children'"
  fi

  if [ ! "${PM_MIN_SPARE_SERVERS}" = "10" ]
  then
    echo "Setting 'pm.min_spare_servers' to '${PM_MIN_SPARE_SERVERS}'"
    sed -i "s/pm.min_spare_servers = 10/pm.min_spare_servers = ${PM_MIN_SPARE_SERVERS}/g" /etc/php5/fpm/pool.d/www.conf
  else
    echo "Using default value '${PM_MIN_SPARE_SERVERS}' for 'pm.min_spare_servers'"
  fi

  if [ ! "${PM_MAX_SPARE_SERVERS}" = "15" ]
  then
    echo "Setting 'pm.max_spare_servers' to '${PM_MAX_SPARE_SERVERS}'"
    sed -i "s/pm.max_spare_servers = 15/pm.max_spare_servers = ${PM_MAX_SPARE_SERVERS}/g" /etc/php5/fpm/pool.d/www.conf
  else
    echo "Using default value '${PM_MAX_SPARE_SERVERS}' for 'pm.max_spare_servers'"
  fi

  if [ ! "${PM_START_SERVERS}" = "10" ]
  then
    echo "Setting 'pm.start_servers' to '${PM_START_SERVERS}'"
    sed -i "s/pm.start_servers = 10/pm.start_servers = ${PM_START_SERVERS}/g" /etc/php5/fpm/pool.d/www.conf
  else
    echo "Using default value '${PM_START_SERVERS}' for 'pm.start_servers'"
  fi

  touch /tmp/configured
  echo "Configuration complete."
fi

exec "$@"
