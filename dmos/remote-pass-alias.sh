#!/usr/bin/env bash

TAC_USERNAME="fabio.ewerton"

for host in {1..5}; do
    sshpass -f password ssh -o StrictHostKeyChecking=no "$TAC_USERNAME"@100.127.0.$host "sh run host" # < "config-dmos-alias.md"
    echo " "
    echo "##################################################"
    # sleep 2
done
