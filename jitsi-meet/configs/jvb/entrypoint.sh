#!/bin/bash
set -euo pipefail

# both jq and curl are needed for shutdown hook
apt-dpkg-wrap apt-get update && apt-dpkg-wrap apt-get -y install curl jq

# JVB baseport can be passed to this script - entrypoint parm can be iterated in deployment spec
if [[ "$1" =~ ^[0-9]+$ ]]; then
    export JVB_PORT=$1
    export JVB_TCP_PORT=$2
    shift
else
    BASE_PORT=udpstream
	# add jvb ID (suffix after - in hostname) to the base port (e.g. 30300 + 1 = 30301)
	export JVB_PORT=$(($BASE_PORT+${HOSTNAME##*-}))
	export JVB_TCP_PORT=$(($BASE_PORT+{{ .Values.jvb.tcpoffset }}+${HOSTNAME##*-}))
fi

echo "JVB_PORT=$JVB_PORT on server ${HOSTNAME}"
echo "JVB_TCP_PORT=$JVB_TCP_PORT"

echo "Allowing shutdown of JVB via Rest from localhost..."
echo "org.jitsi.videobridge.ENABLE_REST_SHUTDOWN=true" >> /defaults/sip-communicator.properties
echo "org.jitsi.videobridge.shutdown.ALLOWED_SOURCE_REGEXP=127.0.0.1" >> /defaults/sip-communicator.properties

echo "org.ice4j.ice.harvest.DISABLE_AWS_HARVESTER=true" >> /defaults/sip-communicator.properties

exec "$@"
