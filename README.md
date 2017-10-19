# Teamspeak3 (Alpine Linux) Docker Image [![Docker Automated Build](https://img.shields.io/docker/automated/nshtg/ts3-alpine.svg)](https://hub.docker.com/r/rodaine/teamspeak3-alpine/)

_A Teamspeak 3 Server built on Alpine Linux (using glibc)_

* Lightweight image (<25MB)
* SQLite only
* Easy, optional voluming of logs, db, and query_ip_*list.txt files
* Pass any TS3 startup flags with `docker run`

## docker-compose.yml (Example)
```
version: '3'
services:
  web:
    image: nshtg/ts3-alpine
    container_name: ts3
    ports:
      - "9987:9987/udp"
    restart: always
    volumes:
      - "./data:/data"
```


## Credits
Based on [rodaine/teamspeak3-allpine](https://github.com/rodaine/teamspeak3-alpine)!
