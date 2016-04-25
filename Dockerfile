# -----------------------------------------------------------------------------
# docker-teamspeak
#
# Builds a basic docker image that can run TeamSpeak
# (http://teamspeak.com/).
#
# Authors: Isaac Bythewood
# Updated: May 18th, 2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

# Base system is Ubuntu 16.04
FROM   ubuntu:16.04

# Set the Teamspeak version to download
ENV TSV=3.0.12.3

# Download and install everything from the repos.
RUN    DEBIAN_FRONTEND=noninteractive \
        apt-get -y update && \
        apt-get -y install bzip2

# Download and install TeamSpeak 3
ADD    http://dl.4players.de/ts/releases/${TSV}/teamspeak3-server_linux_amd64-${TSV}.tar.bz2 ./
RUN    tar jxf teamspeak3-server_linux_amd64-$TSV.tar.bz2 && \
       mv teamspeak3-server_linux_amd64 /opt/teamspeak && \
       rm teamspeak3-server_linux_amd64-$TSV.tar.bz2

#Add user
RUN useradd -s /bin/bash teamspeak
RUN chown teamspeak /opt/teamspeak -R

# Load in all of our config files.
ADD    ./scripts/start /start

# Fix all permissions
RUN    chmod +x /start

# /start runs it.
EXPOSE 9987/udp
EXPOSE 30033
EXPOSE 10011

RUN     mkdir /data && chown teamspeak:teamspeak /data
VOLUME ["/data"]

USER   teamspeak
CMD    ["/start"]
