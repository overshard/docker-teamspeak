# docker-teamspeak

A nice and easy way to get a TeamSpeak server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on TeamSpeak and check out it's [website][1].


## Building docker-teamspeak

Running this will build you a docker image with the latest version of both
docker-teamspeak and TeamSpeak itself.

    git clone https://github.com/overshard/docker-teamspeak
    cd docker-teamspeak
    docker build -t overshard/teamspeak .


## Running docker-teamspeak

Running the first time will set your port to a static port of your choice so
that you can easily map a proxy to. If this is the only thing running on your
system you can map the ports to 9987, 10011, 30033 and no proxy is needed. i.e.
`-p=9987:9987/udp  -p=10011:10011 -p=30033:30033` Also be sure your mounted
directory on your host machine is already created before running
`mkdir -p /mnt/teamspeak`.

    sudo docker run -d=true -p=9987:9987/udp -p=10011:10011 -p=30033:30033 -v=/mnt/teamspeak:/data overshard/teamspeak /start

From now on when you start/stop docker-teamspeak you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `overshard/teamspeak:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>


## Server Admin Token

You can find the server admin token in /mnt/teamspeak/logs/, search the log
files for ServerAdmin privilege key created and use that token on first connect.


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
