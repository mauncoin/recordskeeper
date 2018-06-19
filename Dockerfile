FROM ubuntu:16.04

# Mainnet
ENV SEEDNODE=recordskeeper@35.172.1.247:7895

# Version of recordskeeper
ARG xrkversion=1.0.0
ARG xrkdir=recordskeeper-$xrkversion
ARG tarxrk=recordskeeper-$xrkversion.tar.gz
ARG xrkurl=https://github.com/RecordsKeeper/recordskeeper-core/releases/download/v$xrkversion/$tarxrk

RUN set -ex; \
	apt-get update; \
	apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-all-dev; \
	apt-get -y install python-software-properties software-properties-common; \
	add-apt-repository ppa:bitcoin/bitcoin; \
	apt-get update; \
	apt-get -y install libdb4.8-dev libdb4.8++-dev wget; \
	rm -rf /var/lib/apt/lists/*
RUN groupadd xrkuser; \
	useradd -s /bin/bash -g xrkuser -m xrkuser
WORKDIR /home/xrkuser
RUN wget $xrkurl; \
	tar xvf $tarxrk; \
	cd $xrkdir; \
	mv rkd rk-cli rk-util /usr/local/bin; \
	cd ..; \
	rm -rf *
USER xrkuser
CMD rkd $SEEDNODE

