#!/usr/bin/env bash

username='fabio.ewerton'
hostname='100.127.0.27'
date="$(date +%Y-%m-%d)"
tech_support_dir="$HOME/$date/tech-support/"
output_hostname="$( sshpass -f password ssh -o StrictHostKeyChecking=no $username@$hostname \
                    "sh run hostname" | grep -i 'hostname' | cut -d ' ' -f 2)"

output=$(sshpass -f password ssh -o StrictHostKeyChecking=no $username@$hostname \
    "show running-config aaa | nomore | save $date-$output_hostname ; 
    file delete $date-$output_hostname")

echo "$output"

# [[ -d "$tech_support_dir" ]] || mkdir -p "$tech_support_dir"

# if ping -c 3 -q $hostname > /dev/null; then
#     echo -e "\e[32m\n[INFO] - Extraindo informações do host "$hostname"\e[0m"

#     echo "$output" > "$tech_support_dir/$output_hostname.txt"

# else
#     echo -e "\e[31m\n[INFO] - Equipamento "$hostname" NÃO esta pingando\e[0m"
# fi

echo
for i in $( seq 15 ); do
    echo -n "#####"
done
echo
