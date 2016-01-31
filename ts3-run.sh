#!/bin/sh
# Remove any running instance
docker rm -f teamspeak > /dev/null 2>&1

# Data-only volume -- only create if it doesn't exist so as to not lose data
docker inspect teamspeak-data > /dev/null 2>&1 || docker run --name teamspeak-data teamspeak /bin/echo "Data-only container for TeamSpeak"

# Server
docker run --name teamspeak --detach --publish 9987:9987/udp --publish 10011:10011 --publish 30033:30033 --volumes-from teamspeak-data teamspeak
