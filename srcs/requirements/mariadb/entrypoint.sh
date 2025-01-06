#!/bin/sh

set -e 

echo "LANCEMENT DU SCRIPT DE CONFIGURATION MARIA DB"

mysqld_safe --datadir=/var/lib/mysql &

echo "Attente du démarrage de MariaDB..."
sleep 5

if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_NAME" ]; then
  echo "Erreur : Toutes les variables d'environnement (MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD, MYSQL_NAME) doivent être définies."
  exit 1
fi

echo "FLUSH PRIVILEGES;" | mysql -u root

# check user
echo "Vérification et suppression de l'utilisateur $MYSQL_USER s'il existe..."
echo "DROP USER IF EXISTS '$MYSQL_USER'@'%';" | mysql -u root

#create user
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

#give privilege to user
echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -u root

# Configurer les privilèges pour l'utilisateur root
echo "Configuration des privilèges pour root..."
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -u root

# Créer la base de données si elle n'existe pas
echo "Vérification et création de la base de données $MYSQL_NAME si elle n'existe pas..."
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME;" | mysql -u root

# Appliquer les privilèges
echo "Application des privilèges..."
echo "FLUSH PRIVILEGES;" | mysql -u root
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
