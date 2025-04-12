#!/bin/bash
set -e

# export DATABASE_NAME="wordpress"
# export DATABASE_USER="wordpress_user"
# export DATABASE_PASSWORD="superrandompassword"
# export DATABASE_HOST="database"
# export DOMAIN_NAME="yel-moun.42.fr"
# export WORDPRESS_TITLE="El-Mountahi Website"
# export ADMIN_USER="ElMountahi"
# export ADMIN_PASSWORD="wp-pass11"
# export ADMIN_EMAIL="yel-moun@student.1337.ma"
# export USER_NAME="testuser"
# export USER_EMAIL="testuser@example.com"
# export USER_PASSWORD="userpass123"

service mariadb start
mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;
CREATE USER IF NOT EXISTS \`${DATABASE_USER}\`@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO \`${DATABASE_USER}\`@'%';
FLUSH PRIVILEGES;
EOF
mariadb  -e "SHOW DATABASES;"
service mariadb stop

exec mariadbd-safe