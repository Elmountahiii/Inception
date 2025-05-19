#!/bin/bash
set -e


chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp core download --path=/var/www/html/wordpress --allow-root
    cd /var/www/html/wordpress
    echo "WordPress downloaded successfully."
    wp config create \
        --dbname=$DATABASE_NAME \
        --dbuser=$DATABASE_USER \
        --dbpass=$DATABASE_PASSWORD \
        --dbhost=mariadb:3306  \
        --path=/var/www/html/wordpress \
        --allow-root
    echo "wp-config.php created successfully."
    echo "installing wordpress"
    wp core install \
        --url=$DOMAIN_NAME \
        --title="Inception WordPress" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --path=/var/www/html/wordpress \
        --allow-root
    echo "WordPress installed successfully."
    echo "Creating user $USER_NAME"
    wp user create $USER_NAME $USER_EMAIL \
            --role=author \
            --user_pass=$USER_PASSWORD \
            --path=/var/www/html/wordpress \
            --allow-root
    echo "User $USER_NAME created successfully."
    echo "Configuring WordPress themes"
    wp theme install twentytwentythree  --allow-root
	wp theme activate twentytwentythree  --allow-root
    echo "fishing theme installed and activated successfully."
    wp config set WP_REDIS_HOST 'redis' --allow-root
    wp config set WP_CACHE 1  --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

echo "Starting php-fpm"
exec "$@"