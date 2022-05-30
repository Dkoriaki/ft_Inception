# setting the OS
FROM	debian:buster

# setting the author and the refresh date
LABEL	maintainer="dkoriaki"

ENV		REFRESHED_AT 2022-05-27

# installation

RUN		apt-get -y update; \
# installing nginx and openssl
	apt-get install -y nginx openssl

# set up nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# creation of SSL certificate
RUN openssl req -newkey rsa:4096 -x509 -sha3-256 -days 365 -nodes \
	-subj "/C=FR/ST=Ile-de_France/L=Paris/O=42/OU=IT/CN=dkoriaki.42.fr"	\
	-out /etc/ssl/certs/server.crt -keyout /etc/ssl/private/server.key

# display logs
RUN     ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

# launch daemon nginx
CMD	[ "nginx", "-g", "daemon off;" ]
