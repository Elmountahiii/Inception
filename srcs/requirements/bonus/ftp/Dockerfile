FROM debian:11

RUN apt-get update && \
	apt-get install -y vsftpd && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/wordpress

COPY ./config/vsftpd.conf /etc/vsftpd.conf
COPY ./config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod 777 /usr/local/bin/entrypoint.sh
RUN mkdir -p /var/run/vsftpd/empty && chmod a-w /var/run/vsftpd/empty

EXPOSE 20-21 21100-21110

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "vsftpd","/etc/vsftpd.conf" ]
