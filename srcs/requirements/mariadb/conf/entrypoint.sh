#!/bin/bash

# If MariaDB is already running (mysqld.pid exists), skip everything.
# If not:
#     Update MariaDB configuration (50-server.cnf).
#     Check if the database exists.
#     Start MariaDB.
#     Create the database and users.
#     Set passwords and privileges.
#     Stop MariaDB (to ensure changes apply).
# Finally, start MariaDB in safe mode for normal operation.

export DATABASE_ROOT_PASSWORD=hello

sed -i 's/= 127.0.0.1/= 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/basedir/port\t\t\t\t\t= 3306\nbasedir/' /etc/mysql/mariadb.conf.d/50-server.cnf
echo "Inception : 50-server.cnf updated."

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ];
then
	echo "Inception : ${DATABASE_NAME} database is being created."
	mysqld_safe &
	sleep 2
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"
	mysql -e "CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';"
	mysqladmin -u root -p$DATABASE_ROOT_PASSWORD shutdown
fi

exec "mysqld_safe"