## Docker image for Proxmox Backup Server (https://pbs.proxmox.com).  

Base on  
1. [Container Debian](https://hub.docker.com/_/debian)  
2. [supsy repo](https://gitlab.com/supsy/docker/proxmoxbackupserver)  

## First, create the directories and set the permissions.  

The backup directory  
``` 
mkdir -p /path/to/backup
chown 34:65534 /path/to/backup

``` 
The config directory  
``` 
mkdir -p /path/to/config
mkdir -p /path/to/log #(optional)
chown 34:34 /path/to/config
chmod 700 /path/to/config

``` 

## Run with:  
``` 
docker run -it \
-p 8007:8007 \
--tmpfs /run \
-v /path/to/backup:/backup \
-v /path/to/config:/etc/proxmox-backup \
-v /path/to/log:/var/log/proxmox-backup \ #(optional)
-e ADMIN_PASSWORD=*ADMIN_USER_PASSWORD* \
-e TZ=Europe/Rome \
jeanfrantiesco/proxmox-backup-server

```

## Or with docker-compose:  

``` 
  pbs:
    image: jeanfrantiesco/proxmox-backup-server
    restart: always
    ports:
      - 8007:8007
    tmpfs:
      - /run
    environment:
      TZ: Europe/Rome
      ADMIN_PASSWORD: *ADMIN_USER_PASSWORD*
    volumes:
      - /path/to/backup:/backup
      - /path/to/config:/etc/proxmox-backup
      - /path/to/log:/var/log/proxmox-backup #(optional)

``` 
After start the webinterface is available under https://docker:8007  

Username: admin.  
Realm: **Proxmox Backup authentication server** (Must be explicitly changed on first login).  
Password: asDefinedViaEnvironment  

Hint The user admin permissions are limited to reflect docker limitations.  
The ADMIN_PASSWORD is only needed for first time initialization  

## Add Datastore  
Click on `Add Datastore`  
On Name: `<You-Datastore-name>`  
On Backing Path: `/backup`  
Place the rest according to your needs.  