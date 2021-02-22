#!/bin/bash
set -euo pipefail
# both jq and curl are needed for shutdown hook
DBG_TOOLS="curl vim tcpdump net-tools inetutils-traceroute inetutils-ping iproute2 procps netcat telnet"
apt-dpkg-wrap apt-get update && \
apt-dpkg-wrap apt-get -y install curl jq $DBG_TOOLS

# can't do without
echo 'alias ll="ls -alh"'  >> /etc/bash.bashrc

# logging no longer needed
# echo "ENTRYPOINT $(date)" >>  /var/log/env.log
# echo $(env | sort) >> /var/log/startup.log
# echo -e "\n\n" >> /var/log/startup.log

exec "$@"
