#!/bin/bash
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

export LD_LIBRARY_PATH=/opt/teamspeak
cd /opt/teamspeak
./ts3server_linux_amd64 logpath=/data/logs/
