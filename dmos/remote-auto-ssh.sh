#!/usr/bin/env bash

username="fabio.ewerton"

for host in {24..27}; do
    echo ''
    sshpass -f password ssh -o StrictHostKeyChecking=no "$username"@172.25.4.$host 'sh run hostname'
    
    echo ''
    for i in $( seq 15 ); do
        echo -n "#####"
    done
    
    echo ''
    sleep 2
done


