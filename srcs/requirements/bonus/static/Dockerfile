FROM debian:11

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/index.html /var/www/html/

RUN rm -f /var/www/html/index.nginx-debian.html

EXPOSE 80

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD ["nginx"]