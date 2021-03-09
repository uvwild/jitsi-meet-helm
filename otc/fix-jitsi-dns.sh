#!/bin/bash
# create DNS entry for jitsi web
# this is obsoletet because of Istio gateway services

HOSTNAME=$(yq e '.webHost' otc/values.yaml)
BASE_ZONE=otcdemo.gardener.t-systems.net.
JITSI_RECORD="${HOSTNAME}."
JITSI_OLDIP=$(openstack dns recordset list $BASE_ZONE -f json | jq -r --arg jitsi $JITSI_RECORD '.[] | select (.name==$jitsi).records[0]')


echo DOMAIN:$JITSI_RECORD-  OLDIP:$JITSI_OLDIP-

PENDING="<pending>"
JITSI_NEWIP=$PENDING

INGRESS=jitsi-meet-ingress-nginx-controller

while [[ "80.158" != "${JITSI_NEWIP:0:6}" ]]
do
	JITSI_NEWIP=$(kubectl -n jitsi get svc | grep $INGRESS | grep LoadBalancer | awk '{print $4}')
	echo -n .
	sleep 2
done
echo new loadBalancer IP  $JITSI_NEWIP
echo -n "Change entry for DOMAIN:${JITSI_RECORD}- "
echo  "OLDIP:${JITSI_OLDIP}- ==>  -NEWIP:${JITSI_NEWIP}-"

if [ "$JITSI_OLDIP" == "$JITSI_NEWIP" ];then
		echo -e "\e[32m NO CHANGE DONE\e[0m"
else
	if [ -n "$JITSI_OLDIP" ] ; then
		echo -e "\e[31mUpdate previous Entry with  $JITSI_NEWIP\e[0m"
		echo openstack dns recordset set $BASE_ZONE $JITSI_RECORD
		openstack dns recordset set --record "$JITSI_NEWIP" $BASE_ZONE $JITSI_RECORD
	else
		echo -e "\e[32mCreate new entry \e[0m"
		echo openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
		openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
	fi
fi

echo -n OLDIP\ ;ping -c 1 $JITSI_OLDIP
echo -n NEWIP\ ;ping -c 1 $JITSI_NEWIP
echo -n HOSTNAME\ ;ping -c 1 ${JITSI_RECORD%%.}
