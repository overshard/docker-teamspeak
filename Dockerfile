# -----------------------------------------------------------------------------
# docker-teamspeak
#
# Builds a basic docker image that can run TeamSpeak
# (http://teamspeak.com/).
#
# Authors: Isaac Bythewood
# Updated: Jan 25th, 2014
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------


# Base system is the LTS version of Ubuntu.
from   ubuntu:12.04


# Make sure we don't get notifications we can't answer during building.
env    DEBIAN_FRONTEND noninteractive


# An annoying error message keeps appearing unless you do this.
run    dpkg-divert --local --rename --add /sbin/initctl
run    ln -s /bin/true /sbin/initctl


# Download and install everything from the repos.
add    ./apt/sources.list /etc/apt/sources.list
run    apt-get --yes update; apt-get --yes upgrade
run	   apt-get --yes install wget


# Download and install TeamSpeak 3
run    wget http://ftp.4players.de/pub/hosted/ts3/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
run    tar zxf teamspeak3-server_linux-amd64-3.0.10.3.tar.gz; mv teamspeak3-server_linux-amd64 /opt/teamspeak; rm teamspeak3-server_linux-amd64-3.0.10.3.tar.gz


# Load in all of our config files.
add    ./scripts/start /start


# Fix all permissions
run    chmod +x /start


# /start runs it.
expose 9987/udp
expose 10011
expose 30033
volume ["/data"]
cmd    ["/start"]

