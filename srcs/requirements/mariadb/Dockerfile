FROM debian:bullseye

# Installer les dépendances nécessaires
RUN apt update && apt install -y \
    mariadb-server \
    mariadb-client \
    bash \
    openrc \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Copier le fichier de configuration personnalisé
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

# Définir le port exposé (optionnel, décommenter si nécessaire)
# EXPOSE 3306

# Copier le script d'entrée
COPY ./entrypoint.sh /start-mariadb.sh

# Donner les permissions nécessaires
RUN chmod +x /start-mariadb.sh && chmod 775 /var/lib/mysql

# Définir l'entrée du conteneur
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
