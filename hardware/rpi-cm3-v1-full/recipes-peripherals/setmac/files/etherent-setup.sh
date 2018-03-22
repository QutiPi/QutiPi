#!/bin/sh

# Set mac address to static one as enc28j60 does not have one
# ifconfig eth0 down
macchanger -m 32:23:eb:76:e1:45 eth0
ifup eth0

