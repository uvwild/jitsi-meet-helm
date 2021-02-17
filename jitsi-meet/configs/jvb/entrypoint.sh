#!/bin/bash
set -euo pipefail
# both jq and curl are needed for shutdown hook
apt-dpkg-wrap apt-get update && \
apt-dpkg-wrap apt-get -y install curl jq tcpdump net-tools inetutils-traceroute inetutils-ping

# logging no longer needed
# echo "ENTRYPOINT $(date)" >>  /var/log/env.log
# echo $(env | sort) >> /var/log/startup.log
# echo -e "\n\n" >> /var/log/startup.log

exec "$@"
