#!/usr/bin/env bash

USERNAME="fabio.ewerton"
HOST="100.127.0.2"

for host in {1..10}; do
    if ping -c 3 -W 3 -q $HOST > /dev/null; then

        echo -e "\n\e[32m[INFO] - Equipamento $HOST esta Online!\e[0m"
        
        sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$HOST \
        "logout user $USERNAME"

    else 
        echo -e "\e[31m[INFO] - Equipamento $HOST NÃO esta Online!\e[0m"
    fi


    # JUST SEPARATOR
    echo
    for _ in $( seq 15 ); do echo -n "##### "; done
    echo   
done
