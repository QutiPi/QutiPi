#!/bin/sh

# Flush rules
iptables -F 

# Accept all inputs
iptables -P INPUT ACCEPT 

iptables -P FORWARD DROP
