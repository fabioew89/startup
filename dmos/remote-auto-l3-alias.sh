#!/usr/bin/env bash

for host in {1..80}; do
    sshpass -f password ssh -o StrictHostKeyChecking=no "fabio.ewerton"@100.127.0.$host  < "config/config-dmos-alias.md"
    echo " "
    echo "##################################################"
    echo " "
done
