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
FROM   ubuntu:14.04

# Set the Teamspeak version to download
ENV    tsv=3.0.11.4

# Download and install everything from the repos.
RUN    DEBIAN_FRONTEND=noninteractive \
        apt-get -y update && \
        apt-get -y upgrade

# Download TeamSpeak 3
ADD    http://dl.4players.de/ts/releases/${tsv}/teamspeak3-server_linux-amd64-${tsv}.tar.gz ./

# Unzip with root permissions and move to correct location
RUN    tar --no-same-owner -zxf teamspeak3-server_linux-amd64-${tsv}.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-${tsv}.tar.gz

# Add TeamSpeak user
RUN    useradd -s /usr/sbin/nologin teamspeak

# Make volume directories so permissions can be set
RUN    mkdir -p /data/logs
RUN    chown -R teamspeak:teamspeak /data

EXPOSE 9987/udp
EXPOSE 30033
EXPOSE 10011

VOLUME  ["/data"]
USER    teamspeak
WORKDIR /data
ENV     LD_LIBRARY_PATH="/opt/teamspeak:${LD_LIBRARY_PATH}"
CMD     ["/opt/teamspeak/ts3server_linux_amd64", "logpath=/data/logs", "dbsqlpath=/opt/teamspeak/sql/"]
