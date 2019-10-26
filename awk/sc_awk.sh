#!/bin/bash
# smega 2019

CARD='wlan0'
COMMAND=$(iwlist ${CARD} scan)
IFS=$'\n'

echo "{"
#echo "$COMMAND" | awk -f sc.awk
output=$(echo "$COMMAND" | awk -f sc.awk)
echo $output | awk '{print substr($0, 1, length($0)-1)}'
echo "}"


