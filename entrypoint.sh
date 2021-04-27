#!/bin/sh
acme.sh --issue --standalone -d $DOMAIN --httpport $PORT --tlsport $PORT
for f in $(ls -1 /var/www/*.json); do envsubst < $f > $f; done
envsubst < /etc/xray/config.json > /etc/xray/config.json
nginx
/usr/bin/xray -c /etc/xray/config.json
