#!/bin/sh

# Démarrer MariaDB en arrière-plan
mysqld_safe --datadir=/var/lib/mysql &

# Attendre que le service MariaDB soit prêt
sleep 10

# Configurer les utilisateurs et mots de passe
mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE USER 'user'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL

# Arrêter MariaDB proprement avant de le redémarrer en mode foreground
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Lancer MariaDB au premier plan
exec mysqld --user=mysql --datadir=/var/lib/mysql
