#!/bin/bash
# smega 2019

CARD='wlan0'
COMMAND=$(iwlist ${CARD} scan)
IFS=$'\n'

for line in $COMMAND; do
  echo $line | sed -n -f sc.sed
done
