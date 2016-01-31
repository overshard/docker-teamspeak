# docker-teamspeak

A nice and easy way to get a TeamSpeak server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on TeamSpeak and check out it's [website][1].


## Building docker-teamspeak

Running this will build you a docker image with the latest version of both
docker-teamspeak and TeamSpeak itself.

    git clone https://github.com/overshard/docker-teamspeak
    cd docker-teamspeak
    ./ts3-build.sh

## Running docker-teamspeak

If nothing else is running on ports 9987, 10011 or 30033, launching TeamSpeak is a
simple case of running:

    ./ts3-run.sh

Note: If you get an error about being unable to gain access to docker, you may
need to add yourself to the `docker` group or prepend `sudo` to the `ts3-*` scripts
and all `docker` commands.

If the ports are in use, you can remap them by changing the ports in the teamspeak
container's `docker run` command.  Look for `-p=9987:9987/udp -p=10011:10011
-p=30033:30033` etc.

You can start and stop TeamSpeak by running:

    docker start teamspeak
    docker stop teamspeak

## Managing TeamSpeak's data

The TeamSpeak server's data is stored in a data-only container called `teamspeak-data`.

A backup with the current date and time can be created by running:

    ./ts3-backup.sh

That backup can be restored with:

    ./ts3-restore.sh <archiveName>

All data can be erased by deleting the data-only container and then re-creating it:

    docker rm teamspeak-data
    ./ts3-run.sh

## Server Admin Token

You can find the server admin token by running `docker logs teamspeak` upon first run of the server.
Search for "ServerAdmin privilege key created" and use that token on first connect.

### Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `overshard/teamspeak` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`

## Mumble Server Alternative

Benjamin Denhartog has created an alternative [MurMur/Mumble server][2] if you're looking for an alternative to Teamspeak.

[0]: http://www.docker.io/gettingstarted/
[1]: http://teamspeak.com/
[2]: https://github.com/bddenhartog/docker-murmur
