#!/usr/bin/env bash

USERNAME="fabio.ewerton"
DATE="$(date +%F | sed s/-//g)"
COMMAND="sh run mpls"

for hostname in 100.127.0.{10..20}; do

    output_hostname="$( sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$hostname \
            "sh run hostname" | grep -i 'hostname' | cut -d ' ' -f 2)"
    
    output_hostname_file=$DATE-$output_hostname

    if ping -c 3 -q $hostname > /dev/null; then

        echo -e "\e[32m\n[INFO] - Extraindo informações do host "$hostname" - "$output_hostname"\e[0m\n"

        output=$(sshpass -f password ssh -o StrictHostKeyChecking=no $USERNAME@$hostname \
            "$COMMAND | nomore | save "$output_hostname_file" ; 
            copy file "$output_hostname_file" tftp://143.137.92.139/V8C4rxp9cM-incoming/tech-support/ ;
            file delete "$output_hostname_file"")

        echo  "$output_hostname"
        echo  "$output"

    else
        echo -e "\e[31m\n[INFO] - Equipamento "$hostname" - "$output_hostname" NÃO esta pingando\e[0m"
    fi

    echo
    for _ in $( seq 10 ); do
        echo -n "DATACOM "
    done
    echo

done
