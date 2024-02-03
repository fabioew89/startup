#!/usr/bin/env bash

echo 'username?'
read TAC_USERNAME

echo 'password?'
read TAC_PASS

for host in {1..5}; do
    sshpass -p $TAC_PASS ssh $TAC_USERNAME@100.127.0.$host 'sh run hostname ; show ip ospf neighbor | incl 100.127.0'
    echo " "
done
