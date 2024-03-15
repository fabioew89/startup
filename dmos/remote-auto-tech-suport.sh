#!/usr/bin/env bash

username='fabio.ewerton'
tech_suporte_dir="$HOME/$(date +%Y-%m-%d)/tech-support/"

for host in 100.127.0.{27..27} ; do

    if ping -c 3 -q $host > /dev/null; then
        echo -e "\e[32m\n[INFO] - Tech Support Extraido com sucesso do Equipamento "$host"\e[0m"
        
        output=$(sshpass -f password ssh -o StrictHostKeyChecking=no "$username"@"$host" \
        "sh run hostname ; show tech-support")

        output_hostname=$(echo "$output" | grep -i 'hostname' | cut -d ' ' -f 2)

        [[ -d "$tech_suporte_dir" ]] || mkdir -p "$tech_suporte_dir"

        echo "$output" > "$tech_suporte_dir/$output_hostname.txt"

    else
        echo -e "\e[31m\n[INFO] - Equipamento "$host" NÃO esta pingando\e[0m"
    fi

    echo
    for i in $( seq 15 ); do
        echo -n "#####"
    done
    echo
done
