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

# je verifi si le user existe deja (je le supprime si il existe)
echo "Vérification et suppression de l'utilisateur $MYSQL_USER s'il existe..."
echo "DROP USER IF EXISTS '$MYSQL_USER'@'%';" | mysql -u root

#je creer le user
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

#je lui donne les privilege
echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -u root

# pareil pour root
echo "Configuration des privilèges pour root..."
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -u root

# je créer la base de données si elle n'existe pas
echo "Vérification et création de la base de données $MYSQL_NAME si elle n'existe pas..."
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME;" | mysql -u root

# j'applique les privilèges
echo "Application des privilèges..."
echo "FLUSH PRIVILEGES;" | mysql -u root
# on arrête proprement MariaDB
echo "Arrêt propre de MariaDB après configuration..."

mysqladmin -u root shutdown

echo "Démarrage de MariaDB..."
exec mysqld

