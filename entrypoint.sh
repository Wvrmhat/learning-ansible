#!/bin/sh

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then 
	echo "Generating SSH keys"
	ssh-keygen -A
	
fi 

exec "$@"

