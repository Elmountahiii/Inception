#!/bin/bash
set -e

# Create SSL directory if it doesn't exist
mkdir -p /etc/nginx/ssl

# Generate SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=Morocco/L=Rabat/O=42/OU=42/CN=yel-moun.42.fr"

# Set proper permissions
chmod 600 /etc/nginx/ssl/nginx.key
chmod 644 /etc/nginx/ssl/nginx.crt

exec "$@"