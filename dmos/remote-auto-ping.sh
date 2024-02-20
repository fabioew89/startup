#!/usr/bin/env bash

for x in {1..100}; do
  if ping -c 3 -W 1 "172.25.8.$x" > ; then
    echo 'pingando'
    else
      echo 'não esta pingando'
  fi
done

#caixinha
# cat macs.md | sed s/-/:/g | tr '[:upper:]' '[:lower:]'