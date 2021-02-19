#!/usr/bin/python

from websocket import create_connection

#host = "echo.websocket.org"
proto = "wss"
#host = "jitsid.otcdemo.gardener.t-systems.net"
host = "www.jitsi.otcdemo.gardener.t-systems.net"

url =  "/xmpp-websocket"
ws = create_connection("%s://%s%s" %  (proto, host, url))
print("Sending 'Hello, World'...")
ws.send("Hello, World")
print("Sent")
print("Receiving...")
result =  ws.recv()
print("Received '%s'" % result)
ws.close()