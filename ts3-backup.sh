#!/bin/sh
today=$(date +%Y%m%d-%H%M%S)
docker run -it --rm --volumes-from teamspeak-data --volume "$(pwd):/backup" teamspeak tar -acvf /backup/backup_${today}.tar.bz2 /data

