#!/usr/bin/env bash

USERNAME="fabio.ewerton"
COMMAND="show running-config hostname ; show running-config alias"

ssh_output(){
  sshpass -f password ssh -o StrictHostKeyChecking=no \
  "$USERNAME"@100.127.0."$host" < "config/config-dmos-alias.md"
}

for host in {1..110}; do
  ssh_output

  # JUST SEPARATOR
  echo
  for _ in $( seq 15 ); do echo -n "##### "; done
  echo   
  break
done
