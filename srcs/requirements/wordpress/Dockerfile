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

# Configurer PHP
RUN mkdir -p /var/www/html \
    && chown -R nobody:nobody /var/www/html

WORKDIR /var/www/html
EXPOSE 9000

# Démarrage avec PHP-FPM
CMD ["php-fpm82", "-F"]
