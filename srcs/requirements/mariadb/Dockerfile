FROM debian:buster

LABEL maintainer="dkoriaki"

ENV REFRESHED_AT 2022-05-20

RUN apt-get -y update && \
      apt-get -y install mariadb-server

ENTRYPOINT ["/bin/bash"]
