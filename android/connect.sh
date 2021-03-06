#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "" ]; then
	echo "usage : connect.sh RSA_FILE SERVER_IP [PORT]"
	echo "        connect.sh --pwd SERVER_IP [PORT]"
	exit
fi

ID_RSA=$1
SERVER_IP_OR_DOMAIN=$2
SERVER_PORT=$3

umount tmpfs
mkdir -p tmpfs
mount -t tmpfs tmpfs tmpfs

if [ $ID_RSA == "--pwd" ]; then
    exec bash ssh-vpn.sh $ID_RSA $SERVER_IP_OR_DOMAIN $SERVER_PORT    
else
    cp $ID_RSA tmpfs/id_rsa
    chmod 600 tmpfs/id_rsa

    exec bash ssh-vpn.sh tmpfs/id_rsa $SERVER_IP_OR_DOMAIN $SERVER_PORT
fi

