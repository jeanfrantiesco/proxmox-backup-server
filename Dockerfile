FROM debian:bullseye

# Install dependencies
RUN	apt update \
	&& apt install -y \
	wget \
	ca-certificates \
	nano \
	apt-utils \
	ifupdown2	

#add repository
RUN	echo "deb http://download.proxmox.com/debian/pbs bullseye pbs-no-subscription" > /etc/apt/sources.list.d/pbs-no-subscription.list \
	&& wget http://download.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
  	&& apt update \
	&& apt install -y proxmox-backup-server \
	&& apt upgrade -y \
	&& echo "#deb https://enterprise.proxmox.com/debian/pbs bullseye pbs-enterprise" > /etc/apt/sources.list.d/pbs-enterprise.list 

#Active backup user
RUN chsh -s /bin/bash backup

EXPOSE 8007

#Start...
COPY entrypoint.sh /
COPY shadow /etc
RUN chmod a+x /entrypoint.sh
STOPSIGNAL SIGINT
ENTRYPOINT ["/entrypoint.sh"]
