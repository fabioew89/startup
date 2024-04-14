#!/usr/bin/env bash

USERNAME="fabio.ewerton"
COMMAND="show running-config hostname ;\
         show running-config aaa"
# shellcheck disable=SC2016
aaa_pass_admin=$(cat password | awk 'NR == 2')
# shellcheck disable=SC2016
aaa_pass_tacacs=$(cat password | awk 'NR == 3')

RED="\e[31;1m"
GREEN="\e[32;1m"
YELLOW="\e[33;1m"
RESET="\e[0m"

ssh_output(){
    ssh_output="$(sshpass -f password ssh -o StrictHostKeyChecking=no "$USERNAME"@"$ip_host" "$COMMAND")"
    get_device_hostname="$(echo "$ssh_output" | awk 'NR==1 { print $2 }')"
    get_device_aaa_pass_admin=$(echo "$ssh_output" | grep -i password | awk '{ print $2 }')
    get_device_aaa_pass_tacacs=$(echo "$ssh_output" | grep -i shared | awk '{ print $2 }')
}

# firmware_check_version(){
#     [ $get_device_firmware_version -ge 8 ] && \
#     echo -e "${GREEN}\nUp to date! 😁${RESET}" || \
#     echo -e "${YELLOW}\nNeeds updating! 😭${RESET}"
# }


for ip_host in 100.127.0.{1..100}; do
    if ping -c 3 -q -W 3 "$ip_host" > /dev/null; then
       
        ssh_output

        echo -e "\n${GREEN}[INFO] - Geting information about $get_device_hostname - $ip_host${RESET}"
        # echo -e "\n$get_device_hostname\n$get_device_aaa_pass_admin\n$get_device_aaa_pass_tac"

        if [ "$get_device_aaa_pass_admin" == "$aaa_pass_admin" ] && \
           [ "$get_device_aaa_pass_tacacs" == "$aaa_pass_tacacs" ]; then
            
            echo -e "${GREEN}Tacacs configura corretamente${RESET}"
            echo -e "$get_device_aaa_pass_admin\n$get_device_aaa_pass_tacacs"
            
        else

            echo -e "${RED}fora de padrão${RESET}"
            echo -e "$get_device_aaa_pass_admin\n$get_device_aaa_pass_tacacs"
        fi
        
    else
        echo -e "${RED}\n[INFO] - Sorry, better luck next time $ip_host${RESET}"
    fi

    # JUST SEPARATOR
    echo
    for _ in $(seq 15); do
        echo -n "##### "
    done
    echo
done