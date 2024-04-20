#!/usr/bin/env bash

for host in {73..74}; do
    sshpass -f password ssh -o StrictHostKeyChecking=no "fabio.ewerton"@100.127.0.$host  < "config/config-dmos-cluster-intlink.md"

    # JUST SEPARATOR
    echo
    for _ in $(seq 15); do
        echo -n "##### "
    done
    echo
done
