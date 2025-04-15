FROM debian:11

RUN apt-get update \
	&& apt-get install mariadb-server -y  \
	&& mkdir /run/mysqld  && chmod 777 /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 3306

RUN chmod 777 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD [ "mariadbd --user=mysql" ]