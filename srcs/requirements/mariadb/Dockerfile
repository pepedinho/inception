FROM alpine:3.20

WORKDIR /var/lib/mysql

COPY . /var/lib/mysql

RUN apk update \
    && apk add --no-cache mariadb mariadb-client openrc \
    && apk cache clean

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
