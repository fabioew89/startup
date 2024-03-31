#!/usr/bin/env bash

USERNAME="fabio.ewerton"
DATE="$(date +%F | sed s/-//g)"
# COMMAND="show running-config"
DEVICE_MODEL='DM4360'

### FUNCTIONS ###

ssh_device(){
    sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$host "sh run lldp"
}
get_hostname(){
    output_hostname="$( sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$host \
        "show running-config hostname" | grep -i 'hostname' | cut -d ' ' -f 2)"    
}
get_device_model(){
    output_device_model="$( sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$host \
        "show platform" | awk 'NR==3 { print $2 }')"
}

for host in 100.127.0.{1..90}; do
    
    get_hostname
    get_device_model

    if ping -c 3 -q $host > /dev/null; then

        echo -e "\e[32m\n[INFO] - Get information about $output_hostname - $host\e[0m\n"

        if [ $output_device_model == $DEVICE_MODEL ]; then
            output=$(ssh_device)
        else
            echo -e "\e[31m\n[INFO] - Another Device\e[0m"

        fi

        echo  "$output"
        
    else
        echo -e "\e[31m\n[INFO] - Equipamento "$host" - "$output_hostname" NÃO esta pingando\e[0m"
    fi

    echo
    for _ in $( seq 15 ); do
        echo -n "##### "
    done
    echo

done
