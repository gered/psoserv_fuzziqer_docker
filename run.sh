#!/bin/bash
cd "$(dirname "$0")"

container_name=psoserv_fuzziqer

if [ "$(docker inspect -f '{{.State.Running}}' ${container_name} 2>/dev/null)" == "true" ]; then
        echo "${container_name} is already running!"
        exit 1
fi

docker run \
	--rm \
	-d -it \
	--name psoserv_fuzziqer \
	-p 9000:9000 \
	-p 9001:9001 \
	-p 9003:9003 \
	-p 9100:9100 \
	-p 9103:9103 \
	-p 9200:9200 \
	-p 9201:9201 \
	-p 9300:9300 \
	-p 10000:10000 \
	-p 11000:11000 \
	-p 12000:12000 \
	-p 12004:12004 \
	-p 12005:12005 \
	-p 12008:12008 \
	-p 9420:9420 \
	-p 9421:9421 \
	-p 9422:9422 \
	-p 53:53/udp \
	-v ${PWD}/myconfig.json:/newserv/system/config.json \
	gered/psoserv_fuzziqer:latest
