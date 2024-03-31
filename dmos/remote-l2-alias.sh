#!/usr/bin/env bash

for host in {1..254}; do
    sshpass -f password ssh -o StrictHostKeyChecking=no "fabio.ewerton"@172.25.8.$host  < "config/config-dmos-alias.md"
    echo " "
    echo "##################################################"
    echo " "
done
