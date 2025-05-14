#!/bin/bash

useradd -d /var/www/html/wordpress -s /bin/bash ${FTP_USER}
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

echo "${FTP_USER}" > /etc/vsftpd.userlist

chown -R ${FTP_USER}:${FTP_USER} /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

exec "$@"