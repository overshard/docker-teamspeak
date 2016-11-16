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

# files

if [ ! -d /opt/teamspeak/files ] && [ -d /data/files ]
then
    ln -s /data/files /opt/teamspeak/files
fi

if [ -d /opt/teamspeak/files ] && [ ! -d /data/files ]
then
    mv /opt/teamspeak/files /data/files
    ln -s /data/files /opt/teamspeak/files
fi

if [ -d /opt/teamspeak/files ] && [ -d /data/files ]
then
    rm /opt/teamspeak/files
    ln -s /data/files /opt/teamspeak/files
fi

# licensekey

if [ ! -f /opt/teamspeak/serverkey.dat ] && [ -f /data/license/serverkey.dat ]
then
    ln -s /data/license/serverkey.dat /opt/teamspeak/serverkey.dat
fi

if [ ! -f /opt/teamspeak/licensekey.dat ] && [ -f /data/license/licensekey.dat ]
then
    ln -s /data/license/licensekey.dat /opt/teamspeak/licensekey.dat
fi

# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak
cd /opt/teamspeak
./ts3server logpath=/data/logs
