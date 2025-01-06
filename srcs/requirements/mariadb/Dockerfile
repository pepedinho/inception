FROM debian:bullseye

RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client \
    bash \
    openrc \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && apt clean && rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

COPY ./entrypoint.sh /start-mariadb.sh

RUN chmod +x /start-mariadb.sh && chmod 775 /var/lib/mysql

ENTRYPOINT ["/start-mariadb.sh"]



# FROM alpine:3.20
#
# RUN apk add --no-cache mariadb \
#    && apk add mariadb-client \
#    && apk add bash \
#    && apk add openrc \
#    && mkdir -p /run/mysqld \
#    && chown -R mysql:mysql /run/mysqld
#
# COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
#
# # EXPOSE 3306
#
# COPY ./entrypoint.sh /
#
# RUN chmod +x /entrypoint.sh && chmod 775 /var/lib/mysql
#
# # ENTRYPOINT [ "tail", "-f" ]
#
# ENTRYPOINT ["/start-mariadb.sh"]
