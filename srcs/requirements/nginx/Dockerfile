
  
# setting the OS
FROM	debian:buster

# setting the author

# update apt-get
RUN	apt-get -y update

# installing nginx
RUN	apt-get -y install nginx openssl

# set up nginx
#COPY ./tools/nginx.conf /etc/nginx/nginx.conf

#create SSL certificate
RUN openssl req -newkey rsa:4096 -x509 -sha3-256 -days 365 -nodes			\
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Student Projects/CN=inception"	\
	-out /etc/ssl/certs/server.crt -keyout /etc/ssl/private/server.key

# display the logs on stdout
RUN     ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

# launch daemon nginx
CMD	[ "nginx", "-g", "daemon off;" ]
