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

## File Permissions

Docker has no way to change file permissions at runtime without being root. Because of that you have to make sure every file you want the container to use (database or previous logs) is owned by uid and gid 1000.   
Run `chown 1000:1000 <filename(s)>` on every file or Run `chown -R 1000:1000 /mnt/teamspeak` to fix all permissions recursively.   

## docker-compose

You can use docker-compose to simplify the process of building and running.   
If you do not wish to import an existing database or logfiles just run:

    sudo docker-compose up
This will build and run the container.   
If you want to import existing logs or a database read `File Permissions` first.

## Server Admin Token

You can find the server admin token in /mnt/teamspeak/logs/, search the log
files for ServerAdmin privilege key created and use that token on first connect.

Alternatively you can run `docker logs <container_id>` which will display    
the logfile.


## Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `overshard/teamspeak` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`

## Major Contributors

 + [overshard][3]
 + [giant3gg][4]

## Mumble Server Alternative

Benjamin Denhartog has created an alternative [MurMur/Mumble server][2] if you're looking for an alternative to Teamspeak.

[0]: http://www.docker.io/gettingstarted/
[1]: http://teamspeak.com/
[2]: https://github.com/bddenhartog/docker-murmur
[3]: https://github.com/overshard
[4]: https://github.com/giant3gg

