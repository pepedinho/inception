FROM alpine:3.20

RUN apk add --no-cache \
    bash \
    curl \
    php \
    php-fpm \
    php-phar \
    php-mysqli \
    php-iconv \
    php-tokenizer \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/html \
    && chown nobody:nobody /var/www/html \
    && chmod 755 /var/www/html \
    && chown -R nobody:nobody /var/www/html \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html
EXPOSE 9000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]