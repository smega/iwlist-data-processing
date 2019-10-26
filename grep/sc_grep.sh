#!/bin/bash
#smega 2019
#requires jq

CARD='wlan0'
COMMAND=$(iwlist ${CARD} scan)
IFS=$'\n'

declare -A regexes
regexes=(\
         ["Address"]="(?<=Address:\ ).*(?=$)" \
         ["Frequency"]="(?<=Frequency:).*(?=\ \(Channel)" \
         ["Quality"]="(?<=Quality=).*(?=\ Signal)" \
         ["Signal_level"]="(?<=Signal\ level=).*(?=$)" \
         ["Encryption"]="(?<=Encryption key:).*(?=$)" \
         ["Essid"]="(?<=ESSID:\").*(?=\")" \
         ["Wpa"]="IEEE.+/\K.*(?=\ Version)" \
        )

data="{}"


for line in $COMMAND; do
  for key in "${!regexes[@]}"; do
    match=$(echo $line | grep -Po "${regexes[$key]}")
    if [ $match ]; then
      if [ $key == "Address" ]; then
        address=$match
      else
        value=$match
        data=$(echo $data | jq --arg address "$address" --arg key "$key" --arg value "$value" '.[$address][$key] |= .+ $value')
      fi
    fi
  done
done

echo "$data"
