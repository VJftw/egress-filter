#!/bin/sh

set -e;
set -x;

# Add domain whitelisting from environment variables.
# read space separated list of dstdomains from DOMAIN_WHITELIST

/squid-configurer

/usr/sbin/squid -k parse -f /etc/squid/squid.conf

# Start Squid
/usr/sbin/squid -Nd 1 -f /etc/squid/squid.conf
