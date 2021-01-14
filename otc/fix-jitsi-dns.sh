#!/bin/bash
# create DNS entry for jitsi web

BASE_ZONE=otcdemo.gardener.t-systems.net.
JITSI_RECORD=jitsi.$BASE_ZONE
JITSI_IP=$(openstack dns recordset list $BASE_ZONE -f json | jq -r --arg jitsi $JITSI_RECORD '.[] | select (.name==$jitsi).records[0]')


echo -$JITSI_RECORD-  -$JITSI_IP-

PENDING="<pending>"
JITSI_NEWIP=$PENDING

while [[ "80.158" != "${JITSI_NEWIP:0:6}" ]]
do
	JITSI_NEWIP=$(kubectl -n jitsi get svc | grep jitsi-meet-web\  | awk '{print $4}')
	echo $JITSI_NEWIP
	sleep 2
done

echo -$JITSI_RECORD-  -$JITSI_IP-  -$JITSI_NEWIP-

if [ "$JITSI_IP" == "$JITSI_NEWIP" ];then
		echo DONE
else		
	if [ -n "$JITSI_IP" ] ; then	
		echo remnove previous Entry with  $JITSI_NEWIP
		echo openstack dns recordset delete $BASE_ZONE $JITSI_RECORD
		openstack dns recordset delete $BASE_ZONE $JITSI_RECORD
	fi
	echo create new entry 
	echo openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
	openstack dns recordset create --type A --name $JITSI_RECORD --record "$JITSI_NEWIP"  $BASE_ZONE
fi

ping -c 1 $JITSI_IP


ping   ${JITSI_RECORD%%.}
