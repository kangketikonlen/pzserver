FROM ubuntu:lunar

WORKDIR /home/steam

ENV SERVERNAME="servertest"

# Proceed to Install steamcmd.
RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
	echo steam steam/license note '' | debconf-set-selections && \
	dpkg --add-architecture i386 && \
	apt-get -q -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
	ca-certificates gosu steamcmd && \
	ln -sf /usr/games/steamcmd /usr/bin/steamcmd && \
	DEBIAN_FRONTEND=noninteractive apt-get autoremove -q -y && \
	rm -rf /var/lib/apt/lists/*

# Create 'steam' group and user
RUN groupadd steam
RUN useradd --system --home-dir /home/steam --shell /bin/bash --gid steam steam && \
	usermod -a -G tty steam && \
	mkdir -m 755 /data && \
	chown steam:steam /data /home/steam && \
	chmod 755 /home/steam

ADD ./scripts/entrypoint.sh /entrypoint.sh
ADD ./scripts/steamcmd-* /usr/local/bin/

RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/local/bin/steamcmd-*

ENV STEAMCMD_LOGIN=anonymous

ENTRYPOINT ["/entrypoint.sh"]

CMD ["steamcmd-wrapper", "true"]