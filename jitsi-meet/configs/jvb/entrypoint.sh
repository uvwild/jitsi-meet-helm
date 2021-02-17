#!/bin/bash
set -euo pipefail
# mark
echo "ENTRYPOINT $(date)" >>  /var/log/startup.log
# both jq and curl are needed for shutdown hook
apt-dpkg-wrap apt-get update && \
apt-dpkg-wrap apt-get -y install curl jq tcpdump net-tools inetutils-traceroute inetutils-ping

# # JVB baseport can be passed to this script - entrypoint parm can be iterated in deployment spec
# if [[ "$1" =~ ^[0-9]+$ ]]; then
#     export JVB_PORT=$1
#     shift 
# 	if [[ "$1" =~ ^[0-9]+$ ]]; then
#     	export JVB_TCP_PORT=$1
#     	shift
#     else
#     	export JVB_TCP_PORT=$(( $JVB_PORT + 1000 ))
#     fi
# else
# 	# ${HOSTNAME##*-} not working with k8s naming
# 	HOST_TAIL=${HOSTNAME##*-jvb-}
# 	HOST_INDEX=${HOST_TAIL%%-*}
# 	[ -z "$BASE_PORT" ] && BASE_PORT=30300
# 	# add jvb ID (suffix after - in hostname) to the base port (e.g. 30300 + 1 = 30301)
# 	export JVB_PORT=$(($BASE_PORT+$HOST_INDEX))
# 	export JVB_TCP_PORT=$(($BASE_PORT+1000+$HOST_INDEX))
# fi

echo $(env | sort) >> /var/log/startup.log
echo -e "\n\n" >> /var/log/startup.log

exec "$@"
