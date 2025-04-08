#!/bin/bash

set -e

sleep 10

if [ ! -f wp-config.php ]; then
  echo "wp-config introuvable. Generation automatique ..."
  find "./" -mindepth 1 -delete
  # cp wp-config-sample.php wp-config.php
  # sed -i "s/database_name_here/${MYSQL_NAME}/" wp-config.php
  # sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
  # sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
  # sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
  echo "memory_limit=512M" > /etc/php83/conf.d/memory-limit.ini
  wp core download --allow-root

  wp core config --dbname=${MYSQL_NAME} \
                   --dbuser=${MYSQL_USER} \
                   --dbpass=${MYSQL_PASSWORD} \
                   --dbhost=${WORDPRESS_DB_HOST}  \
                   --allow-root

  wp core install --url="itahri.42.fr" \
                  --title="oui je la" \
                  --admin_user="${WP_ADMIN_USER}" \
                  --admin_password="${WP_ADMIN_PASSWORD}" \
                  --admin_email="${WP_ADMIN_EMAIL}" \
                  --allow-root

  wp config set WP_REDIS_HOST $WP_REDIS_HOST --allow-root
  wp config set WP_REDIS_PORT $WP_REDIS_PORT --allow-root
  wp config set WP_CACHE true --add --allow-root
  wp plugin install redis-cache --activate
  wp redis enable --allow-root

	chmod -R 777 . && chown -R nobody:nobody .
fi

chown -R nobody:nobody /var/www/html

sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

sleep 5 

mkdir -p /run/php

exec php-fpm83 -F
