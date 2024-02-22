#!/usr/bin/env bash

USERNAME="fabio.ewerton"
HOST="100.127.0.3"

for host in {1..3}; do
    sshpass -f password ssh -o StrictHostKeyChecking=no "$USERNAME"@"$HOST" \
    "logout user "$USERNAME" ; who" # "config/config-dmos-logout.md"
    echo ""
    echo "##################################################"
    echo ""
    sleep 2
done
