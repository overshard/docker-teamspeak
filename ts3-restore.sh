#!/bin/sh
docker run -it --rm --volumes-from teamspeak-data --volume "$(pwd):/backup" teamspeak bash -c "find /data -mindepth 1 -depth -delete && tar -xvf \"/backup/${1}\" -C /"

