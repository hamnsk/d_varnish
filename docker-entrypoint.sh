#!/bin/bash
set -e

service varnish start
varnish-agent -c 6085 -H /var/www/html/varnish-dashboard/
tailf /etc/varnish/default.vcl