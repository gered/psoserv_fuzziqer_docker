FROM ubuntu:20.04 as builder

MAINTAINER Gered King <gered@blarg.ca>

RUN \
	apt-get update && \
	apt-get install -y build-essential git && \
	apt-get install -y libevent-dev && \
	apt-get install -y python python3

WORKDIR /tmp

# build and install phosg, a dependency of newserv
RUN \
	git clone https://github.com/fuzziqersoftware/phosg.git && \
	cd phosg && \
	make && \
	make install && \
	cd ..

# build newserv itself
RUN \
	git clone https://github.com/fuzziqersoftware/newserv.git && \
	cd newserv && \
	make && \
	cd ..


FROM ubuntu:20.04

ENV HOME /newserv
ENV SUDO_USER root

WORKDIR /newserv

RUN \
	apt-get update && \
	apt-get install -y libevent-dev

COPY --from=builder /tmp/newserv/newserv .
COPY --from=builder /tmp/newserv/system ./system

ADD config.json /newserv/system/config.json

VOLUME /newserv/system/config.json
VOLUME /newserv/system/licenses.nsi

# built in DNS for gamecube
EXPOSE 53/udp

# gc-jp10   | GC    | LoginServer
EXPOSE 9000/tcp
# gc-jp11   | GC    | LoginServer
EXPOSE 9001/tcp
# gc-jp3    | GC    | LoginServer
EXPOSE 9003/tcp
# gc-us10   | PC    | SplitReconnect
EXPOSE 9100/tcp
# gc-us3    | GC    | LoginServer
EXPOSE 9103/tcp
# gc-eu10   | GC    | LoginServer
EXPOSE 9200/tcp
# gc-eu11   | GC    | LoginServer
EXPOSE 9201/tcp
# gc-eu3    | GC    | LoginServer
EXPOSE 9203/tcp
# pc-login  | PC    | LoginServer
EXPOSE 9300/tcp
# pc-patch  | Patch | PatchServer
EXPOSE 10000/tcp
# bb-patch  | Patch | PatchServer
EXPOSE 11000/tcp
# bb-data   | BB    | DataServerBB
EXPOSE 12000/tcp

# bb-data1  | BB    | DataServerBB
EXPOSE 12004/tcp
# bb-data2  | BB    | DataServerBB
EXPOSE 12005/tcp
# bb-login  | BB    | LoginServer
EXPOSE 12008/tcp
# pc-lobby  | PC    | LobbyServer
EXPOSE 9420/tcp
# gc-lobby  | GC    | LobbyServer
EXPOSE 9421/tcp
# bb-lobby  | GC    | LobbyServer
EXPOSE 9422

CMD ["./newserv"] 
