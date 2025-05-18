FROM debian:11

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    libapache2-mod-php \
    wget \
    && rm -rf /var/lib/apt/lists/*


RUN wget -O /var/www/html/adminer.php https://www.adminer.org/latest.php

COPY ./config/000-default.conf /etc/apache2/sites-available/
COPY ./config/ports.conf /etc/apache2/


RUN chown -R www-data:www-data /var/www/html

EXPOSE 8080

CMD ["apache2ctl", "-D", "FOREGROUND"]