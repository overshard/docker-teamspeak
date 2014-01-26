#!/bin/bash
# -----------------------------------------------------------------------------
# docker-teamspeak /start script
#
# Authors: Isaac Bythewood
# Updated: Jan 25th, 2014
# -----------------------------------------------------------------------------


# Checking if files exist to make sure we're backing up the database to data
if [ ! -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]
then
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] && [ ! -f /data/ts3server.sqlitedb ]
then
    mv /opt/teamspeak/ts3server.sqlitedb /data/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]
then
    rm /opt/teamspeak/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi


# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak
cd /opt/teamspeak
./ts3server_linux_amd64 logpath=/data/logs/

