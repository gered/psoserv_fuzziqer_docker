#!/bin/bash

container_name=psoserv_fuzziqer

if [ "$(docker inspect -f '{{.State.Running}}' ${container_name} 2>/dev/null)" != "true" ]; then 
	echo "${container_name} is not running!"
	exit 1
fi

docker logs -f $container_name
