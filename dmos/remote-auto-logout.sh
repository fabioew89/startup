#!/usr/bin/env bash

USERNAME="fabio.ewerton"
HOST="172.24.128.132"

for host in {1..3}; do
    if ping -c 3 -q $HOST > /dev/null; then

        echo -e "\n\e[32m[INFO] - Equipamento $HOST esta Online!\e[0m"
        
        sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$HOST \
        "logout user $USERNAME"

    else 
        echo -e "\e[31m[INFO] - Equipamento $HOST NÃO esta Online!\e[0m"
    fi


    echo
    for i in $( seq 10 ); do
        echo -n "DATACOM"
    done
    echo
done
