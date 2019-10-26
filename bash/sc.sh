#!/bin/bash
#smega 2019
#requires jq and bash version 4+

CARD='wlan0'
COMMAND=$(iwlist ${CARD} scan)
IFS=$'\n'


declare -A regexes
regexes=(\
         ["Address"]="Address:\ *(.*)" \
         ["Frequency"]="Frequency:(.*)\ \(Channel" \
         ["Quality"]="Quality=(.*)\ Signal" \
         ["Signal_level"]="Signal\ level=(.*)" \
         ["Encryption"]="Encryption key:(.*)" \
         ["Essid"]="ESSID:\"(.*)\"" \
         ["Wpa"]="IEEE.+/(.*)\ *Version" \
        )

data="{}"

for line in $COMMAND; do
  if [[ $line =~ ${regexes["Address"]} ]]; then
    address=${BASH_REMATCH[1]}
  else
    for key in "${!regexes[@]}"; do
      [[ $line =~ ${regexes[$key]} ]] && \
      value=${BASH_REMATCH[1]} && \
      data=$(echo $data | jq --arg address "$address" --arg key "$key" --arg value "$value" '.[$address][$key] |= .+ $value')
    done
  fi
done

echo "$data"



