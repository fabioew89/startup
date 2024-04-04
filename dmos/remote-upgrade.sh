#!/usr/bin/env bash

USERNAME="fabio.ewerton"
COMMAND="show running-config hostname ;\
         show firmware"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

ssh_output(){
    ssh_output="$(sshpass -f password ssh -o StrictHostKeyChecking=no "$USERNAME"@"$ip_host" "$COMMAND")"
    get_device_hostname="$(echo "$ssh_output" | grep -i hostname | cut -d ' ' -f 2)"
    get_device_firmware="$(echo "$ssh_output" | tail -2)"
    get_device_firmware_version="$(echo "$ssh_output" | grep Active | cut -d "." -f 1)"
}

firmware_check_version(){
    # get_device_firmware_version_int="$(echo "$get_device_firmware_version" | awk '{print int($0)}')"

    if [ "$get_device_firmware_version" -ge 9 ]; then
        echo -e "${GREEN}\natualizado 😍${ENDCOLOR}"
    elif [ "$get_device_firmware_version" -le 8 ]; then
        echo -e "${YELLOW}\nPrecisa de atualização 😒${ENDCOLOR}"
    else
        echo -e "${RED}\nPrecisa de atualização urgente 🥵${ENDCOLOR}"
    fi
}


for ip_host in 100.127.0.{1..100}; do
    if ping -c 3 -q -W 3 "$ip_host" > /dev/null; then
        ssh_output
        echo -e "${GREEN}\n[INFO] - Geting information about "$get_device_hostname" - "$ip_host"${ENDCOLOR}\n\
        \n$get_device_hostname\n$get_device_firmware"
        firmware_check_version
    else
        echo -e "${YELLOW}\n[INFO] - Sorry, better luck next time "$ip_host"${ENDCOLOR}"
    fi

    # JUST SEPARATOR
    echo
    for _ in $( seq 15 ); do
        echo -n "##### "
    done
    echo   
done