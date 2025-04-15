#!/bin/bash
set -e

# Create wordpress directory and set initial permissions
mkdir -p /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# Install wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html/wordpress

# Download and configure WordPress
wp core download --path=/var/www/html/wordpress --allow-root
wp config create --path=/var/www/html/wordpress --dbname="$DATABASE_NAME" --dbuser="$DATABASE_USER" --dbpass="$DATABASE_PASSWORD" --dbhost=mariadb:3306 --allow-root
wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --path=/var/www/html/wordpress --allow-root
wp user create "$USER_NAME" "$USER_EMAIL" --role=author --user_pass="$USER_PASSWORD" --path=/var/www/html/wordpress --allow-root
wp config set WP_CACHE true --raw --type=constant --allow-root

# Set proper permissions after WordPress installation
find /var/www/html/wordpress -type d -exec chmod 755 {} \;
find /var/www/html/wordpress -type f -exec chmod 644 {} \;
chown -R www-data:www-data /var/www/html/wordpress
chmod 775 /var/www/html/wordpress/wp-content
chmod -R 775 /var/www/html/wordpress/wp-content/uploads

exec "$@"