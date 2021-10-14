#!bin/bash

#Use this script to set server name

printf "Set server name..."
sed -i 's/@SERVERNAME_HERE@/${1}/g' /etc/nginx/nginx.conf
printf "Done."