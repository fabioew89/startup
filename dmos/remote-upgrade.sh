#!/usr/bin/env bash

username="fabio.ewerton"
command="show running-config hostname ;\
         show firmware"

ssh_output(){
    ssh_output=$(sshpass -f password ssh -o StrictHostKeyChecking=no "$username"@"$ip_host" "$command")
    get_device_hostname=$(echo "$ssh_output" | grep -i hostname | cut -d ' ' -f 2)
    get_device_firmware=$(echo "$ssh_output" | tail -2)
}

for ip_host in 100.127.0.{60..79}; do
    if ping -c 3 -q -W 3 "$ip_host" > /dev/null; then
        echo -e "\e[32m\n[INFO] - Geting information about "$get_device_hostname" - "$ip_host"\e[0m\n"
        
        ssh_output
        
        echo "$get_device_hostname"
        echo "$get_device_firmware"

    else
        echo -e "\e[31m\n[INFO] - Sorry, better luck next time "$ip_host"\e[0m"
    fi

    break

    # JUST SEPARATOR
    echo
    for _ in $( seq 15 ); do
        echo -n "##### "
    done
    echo   
done