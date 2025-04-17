FROM debian:11

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    libapache2-mod-php \
    wget \
    && rm -rf /var/lib/apt/lists/*


# Download Adminer
RUN wget -O /var/www/html/adminer.php https://www.adminer.org/latest.php

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 8080

CMD ["apache2ctl", "-D", "FOREGROUND"]