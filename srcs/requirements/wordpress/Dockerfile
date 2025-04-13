FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-xml \
    php-curl \
    php-gd \
    php-zip \
    php-intl \
    curl \
    unzip && \
    apt-get clean

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm8.2", "-F"]