#!/bin/sh

set -e # Arrêter le script en cas d'erreur

echo "LANCEMENT DU SCRIPT DE CONFIGURATION MARIA DB"

# Démarrer MariaDB directement en arrière-plan
mysqld_safe --datadir=/var/lib/mysql &

# Attendre que MariaDB soit prêt
echo "Attente du démarrage de MariaDB..."
sleep 5

# Vérifier si les variables d'environnement nécessaires sont définies
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_NAME" ]; then
  echo "Erreur : Toutes les variables d'environnement (MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, MYSQL_NAME) doivent être définies."
  exit 1
fi

# Configuration initiale
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE DATABASE $MYSQL_NAME;" | mysql -u root

# Arrêter proprement MariaDB
echo "Arrêt propre de MariaDB après configuration..."
mysqladmin -u root shutdown

# Lancer MariaDB comme processus principal
echo "Démarrage de MariaDB..."
exec mysqld_safe --datadir=/var/lib/mysql

# Démarrer MariaDB en arrière-plan
# mysqld_safe --datadir=/var/lib/mysql &
#
# # Attendre que le service MariaDB soit prêt
# sleep 10
#
# # Configurer les utilisateurs et mots de passe
# mysql -u root <<-EOSQL
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
#     CREATE USER 'user'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
#     GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' WITH GRANT OPTION;
#     FLUSH PRIVILEGES;
# EOSQL
#
# # Arrêter MariaDB proprement avant de le redémarrer en mode foreground
# mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
#
# # Lancer MariaDB au premier plan
# exec mysqld --user=mysql --datadir=/var/lib/mysql
