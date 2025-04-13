FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get install  -y nginx openssl 


COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /etc/nginx/ssl

RUN chmod 777 /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD [ "nginx","-g","daemon off;"]