#!/bin/sh
set -e
echo "Initializing database..."
if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
echo "Creating ${DATABASE_NAME} database and ${DATABASE_USER} user..."
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;
CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${DATABASE_USER}'@'%';
FLUSH PRIVILEGES;
EOF
if mariadbd --user=mysql --bootstrap < /tmp/create_db.sql; then
echo "Database and user created successfully."
else
echo "Error: Failed to initialize database." >&2
exit 1
fi
rm -f /tmp/create_db.sql
else
    echo "Database '${DATABASE_NAME}' already exists, skipping initialization."
fi

exec $@