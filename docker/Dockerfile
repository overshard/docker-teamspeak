FROM phusion/baseimage:latest

ENV \
  HOME /root \
  DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && \
    apt-get dist-upgrade -y && \
    apt-get -y install curl && \
    curl "http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz" -o teamspeak3-server_linux-amd64-3.0.11.4.tar.gz && \
    tar zxf teamspeak3-server_linux-amd64-3.0.11.4.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-3.0.11.4.tar.gz && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD my_init.d /etc/my_init.d

VOLUME ["/data"]

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

CMD ["/sbin/my_init"]
