#!/bin/bash
# create DNS entry for jitsi web
# this is obsoletet because of Istio gateway services

BASE_ZONE=otcdemo.gardener.t-systems.net.
JITSI_RECORD=jitsi.$BASE_ZONE
JITSI_IP=$(openstack dns recordset list $BASE_ZONE -f json | jq -r --arg jitsi $JITSI_RECORD '.[] | select (.name==$jitsi).records[0]')


echo DOMAIN:$JITSI_RECORD-  OLDIP:$JITSI_IP-

PENDING="<pending>"
JITSI_NEWIP=$PENDING

while [[ "80.158" != "${JITSI_NEWIP:0:6}" ]]
do
	JITSI_NEWIP=$(kubectl -n jitsi get svc | grep jitsi-otc-web\  | awk '{print $4}')
	echo -n .
	sleep 2
done
echo new loadBalancer IP  $JITSI_NEWIP
echo -n "Change entry for DOMAIN:${JITSI_RECORD}- "
echo  "OLDIP:${JITSI_IP}- ==>  -NEWIP:${JITSI_NEWIP}-"

if [ "$JITSI_IP" == "$JITSI_NEWIP" ];then
		echo -e "\e[32m NO CHANGE DONE\e[0m"
else		
	if [ -n "$JITSI_IP" ] ; then	
		echo -e "\e[31mRemove previous Entry with  $JITSI_NEWIP\e[0m"
		echo openstack dns recordset delete $BASE_ZONE $JITSI_RECORD
		openstack dns recordset delete $BASE_ZONE $JITSI_RECORD
	fi
	echo -e "\e[32mCreate new entry \e[0m"
	echo openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
	openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
fi

ping -c 1 $JITSI_IP


ping -c 1 ${JITSI_RECORD%%.}
