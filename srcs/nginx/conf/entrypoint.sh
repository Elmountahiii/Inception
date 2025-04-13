#!/bin/bash
set -e

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=FR/ST=France/L=Paris/O=42/OU=42/CN=localhost"

chmod 600 /etc/nginx/ssl/nginx.key
chmod 644 /etc/nginx/ssl/nginx.crt

echo $

exec nginx -g "daemon off;"