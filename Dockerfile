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

# Base system is the LTS version of Ubuntu.
FROM   ubuntu:15.10

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN    apt-get --yes update; apt-get --yes upgrade
RUN    apt-get --yes install curl

# Download and install TeamSpeak 3
RUN    curl "http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz" -o teamspeak3-server_linux-amd64-3.0.11.4.tar.gz
RUN    tar zxf teamspeak3-server_linux-amd64-3.0.11.4.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-3.0.11.4.tar.gz

#Add user
RUN useradd -s /bin/bash teamspeak
RUN chown teamspeak /opt/teamspeak -R

# Load in all of our config files.
ADD    ./scripts/start /start

# Fix all permissions
RUN    chmod +x /start

# /start runs it.
EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

VOLUME ["/data"]
USER	teamspeak
CMD    ["/start"]
