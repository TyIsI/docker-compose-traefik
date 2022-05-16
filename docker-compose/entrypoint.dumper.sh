#!/bin/sh

if [ "$1" = "daemon" ] ; then
	echo -n "Waiting for files to be available..."
	while [ ! -e /data/acme.json ] || [ "$(jq '."lets-encrypt".Certificates | length' /data/acme.json)" = "0" ] ; do
		echo -n "."
		sleep 1
	done && echo "done!" && echo "" && echo "Starting..." && traefik-certs-dumper file --version v2 --watch --source /data/acme.json --dest /data/certs
else
	exec "$@"
fi
