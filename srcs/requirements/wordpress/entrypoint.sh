#!/bin/bash

set -e

if [ ! -f wp-config.php ]; then
  echo "wp-config introuvable. Generation automatique ..."
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${MYSQL_NAME}/" wp-config.php
  sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
  sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
fi

chown -R nobody:nobody /var/www/html

exec "$@"
