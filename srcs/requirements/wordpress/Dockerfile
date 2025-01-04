FROM alpine:3.20

# Installer les dépendances de base
RUN apk add --no-cache \
    bash \
    curl \
    php82 \
    php82-fpm \
    php82-gd \
    php82-mysqli \
    php82-pdo \
    php82-pdo_mysql \
    php82-opcache \
    php82-session \
    php82-xml \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/html \
    && chown nobody:nobody /var/www/html \
    && chmod 755 /var/www/html \
    && curl -f -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && ls -lh wordpress.tar.gz \
    && tar -tzf wordpress.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz \
    && chown -R nobody:nobody /var/www/html

    
# Configurer PHP
# RUN mkdir -p /var/www/html \
#     && chown -R nobody:nobody /var/www/html

RUN sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf

WORKDIR /var/www/html
EXPOSE 9000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Démarrage avec PHP-FPM
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm82", "-F"]
