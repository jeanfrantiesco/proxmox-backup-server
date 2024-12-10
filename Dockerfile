FROM debian:bookworm

# Install dependencies
RUN apt update \
	&& apt install -y \
    wget \
    ca-certificates \
    nano \
    apt-utils \
	dstat \
    ifupdown2 \
	--no-install-recommends

#add repository and install modules
RUN echo "deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription" > /etc/apt/sources.list.d/pbs-no-subscription.list \
    && wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg \
	&& apt update \
	&& apt install -y  \
	proxmox-backup-server \
	proxmox-backup-client \
	proxmox-backup-docs \
	proxmox-mail-forward \
	proxmox-offline-mirror-helper \
	proxmox-widget-toolkit \
	pve-xtermjs \
	zfsutils-linux \
	&& echo "#deb https://enterprise.proxmox.com/debian/pbs bookworm pbs-enterprise" > /etc/apt/sources.list.d/pbs-enterprise.list \
	&& apt upgrade -y

# grab gosu for easy step-down from root
# https://github.com/tianon/gosu/releases
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
	gosu nobody true

#Cleanup
RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $BUILD_DEPS \
    && rm -r /var/lib/apt/lists/*

VOLUME /backup
EXPOSE 8007

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD [""]