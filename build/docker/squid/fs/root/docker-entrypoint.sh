#!/bin/sh

set -e;
set -x;

# configure SSL
cd /etc/squid/ssl
openssl genrsa -out squid.key 4096
openssl req -new -key squid.key -out squid.csr -subj "/C=XX/ST=XX/L=squid/O=squid/CN=squid"
openssl x509 -req -days 3650 -in squid.csr -signkey squid.key -out squid.crt
cat squid.key squid.crt >> squid.pem

/usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB

/squid-configurer

/usr/sbin/squid -k parse -f /etc/squid/squid.conf

# Start Squid
/usr/sbin/squid -Nd 1 -f /etc/squid/squid.conf
