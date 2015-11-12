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

# Base system is the LTS version of Ubuntu
FROM   ubuntu:14.04

# Set the Teamspeak version to download
ENV tsv=3.0.11.4

# Download and install everything from the repos.
RUN    DEBIAN_FRONTEND=noninteractive \
        apt-get -y update && \
        apt-get -y upgrade

# Download and install TeamSpeak 3
ADD    http://dl.4players.de/ts/releases/${tsv}/teamspeak3-server_linux-amd64-${tsv}.tar.gz ./
RUN    tar zxf teamspeak3-server_linux-amd64-${tsv}.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-${tsv}.tar.gz

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

VOLUME ["/data"]
USER	teamspeak
CMD    ["/start"]
