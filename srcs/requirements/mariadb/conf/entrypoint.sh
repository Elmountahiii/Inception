#!/bin/bash
set -e

service mariadb start
mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;
CREATE USER IF NOT EXISTS \`${DATABASE_USER}\`@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO \`${DATABASE_USER}\`@'%';
FLUSH PRIVILEGES;
EOF
mariadb  -e "SHOW DATABASES;"
service mariadb stop

exec "$@"