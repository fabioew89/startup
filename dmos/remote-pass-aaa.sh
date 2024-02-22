#!/usr/bin/env bash

# DM4610
# Host: dm4610-demo.datacom.com.br
# Usuário: demo-user
# Senha: demodemo

# TAC_USERNAME="fabio.ewerton"
TAC_USERNAME="demo-user"

for host in {1..5}; do
    sshpass -p "demodemo" ssh -o StrictHostKeyChecking=no "$TAC_USERNAME"@"dm4610-demo.datacom.com.br" < "config-dmos-aaa.md"
    echo " "
    # echo "##################################################"
    # sleep 2
done




