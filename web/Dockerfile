ARG JITSI_REPO=jitsi
FROM ubuntu:xenial

ARG JITSI_RELEASE=stable

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
ADD https://download.jitsi.org/jitsi-key.gpg.key /tmp/jitsi.key
ADD https://github.com/subchen/frep/releases/download/v1.3.5/frep-1.3.5-linux-amd64 /usr/bin/frep

COPY rootfs /

RUN \
	tar xfz /tmp/s6-overlay.tar.gz -C / && \
	rm -f /tmp/*.tar.gz && \
	apt-get update && \
	apt-get install -y apt-transport-https apt-utils ca-certificates gnupg && \
	apt-key add /tmp/jitsi.key && \
	rm -f /tmp/jitsi.key && \
	echo "deb https://download.jitsi.org $JITSI_RELEASE/" > /etc/apt/sources.list.d/jitsi.list && \
	# echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list && \
	apt-get update && \
	apt-get dist-upgrade -y && \
	chmod +x /usr/bin/frep

RUN apt-get install -y jq procps curl vim iputils-ping net-tools

ENTRYPOINT [ "/init" ]
ADD https://dl.eff.org/certbot-auto /usr/local/bin/

COPY rootfs/ /

RUN \
	apt-get update && \
	apt-get install -y cron nginx-extras jitsi-meet-web && \
	apt-get -d install -y jitsi-meet-web-config && \
    dpkg -x /var/cache/apt/archives/jitsi-meet-web-config*.deb /tmp/pkg && \
    mv /tmp/pkg/usr/share/jitsi-meet-web-config/config.js /defaults && \
	mv /usr/share/jitsi-meet/interface_config.js /defaults && \
	rm -f /etc/nginx/conf.d/default.conf && \
	rm -rf /tmp/pkg /var/cache/apt

RUN \
	chmod a+x /usr/local/bin/certbot-auto && \
	certbot-auto --noninteractive --install-only


RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:nginx/stable -y
RUN apt-get update && apt-get install nginx libnginx-mod-rtmp -y

RUN apt-get install stunnel4 -y

EXPOSE 80 443

VOLUME ["/config", "/etc/letsencrypt", "/usr/share/jitsi-meet/transcripts"]
