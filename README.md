# Proxmox Backup Server - Version 2.1-5

Base on
1. [Container Debian](https://hub.docker.com/_/debian)

## Access

- User: root
- Pass: pbspbs

##To run

**Docker Compose**

``` 
version: '3'
services:
  proxmox-backup:
    container_name: proxmox-backup-server
    image: jeanfrantiesco/proxmox-backup-server
    hostname: Proxmox-Backup
    restart: always
    ports:
      - 8007:8007
    tmpfs:
      - /run
    volumes:
      - /path/to/proxmoxbackup/config:/etc/proxmox-backup
      - /path/to/proxmoxbackup/datastore:/datastore
```

**docker cli**

``` 
docker run -d \
--name proxmox-backup-server \
-p 8007:8007 \
--tmpfs /run \
-h Proxmox-Backup \
-v /path/to/config:/etc/proxmox-backup \
-v /path/to/datastore:/datastore \ 
jeanfrantiesco/proxmox-backup-server

``` 
