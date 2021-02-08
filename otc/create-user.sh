#!/bin/bash
########################
# create a bunch of users for testing after startup
# and admin user from   values.yaml

#DOMAIN=jitsi.otcdemo.gardener.t-systems.net
DOMAIN=jitsi.meet


ADMINDOMAINS="\
$DOMAIN \
"

#PODNAME=$(kubectl -n jitsi get pods -o name | grep jitsi-meet-web | grep -v jwt)
# prosody contains the user accounts
PODNAME=jitsi-meet-prosody-0

ADMINUSER=focus
USERBASE=user
PASSWORD=123456

CMD_FILE=commands
rm -f $CMD_FILE
for domain in $ADMINDOMAINS
do
	echo $domain
	echo "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER $domain $PASSWORD"
	eval "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER $domain $PASSWORD"

	echo "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER auth.$domain $PASSWORD"
	eval "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER auth.$domain $PASSWORD"

	echo "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER focus.$domain $PASSWORD"
	eval "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $ADMINUSER focus.$domain $PASSWORD"
done

for i in {0..6}
do
	echo $USERBASE$i
	echo "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $USERBASE$i $domain $PASSWORD"
	eval "kubectl -n jitsi exec -ti $PODNAME -c jitsi-meet-prosody -- /usr/bin/prosodyctl --config /config/prosody.cfg.lua register $USERBASE$i $domain $PASSWORD"
done	
