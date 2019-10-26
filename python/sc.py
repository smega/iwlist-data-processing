#!/usr/bin/python3
#smega 2019

import os
import re
import json

#scan
CARD = "wlan0"
scanlist = os.popen(f"iwlist {CARD} scan").read().split("\n")

#lines you want to extract from iwlist output
regexes = {
#          "Cell" : ".*Cell\ *(\d+).*",
          "Address" : ".*Address: (.{2}:.{2}:.{2}:.{2}:.{2}:.{2}).*",
          "Frequency" : ".*Frequency:(\d+\.\d+).*",
          "Quality" : ".*Quality=(\d+/\d+).*",
          "Signal_level" : ".*Signal\ level=(-\d+).*",
          "Encryption" : ".*Encryption\ key:(on|off).*",
          "Essid" : ".*ESSID:\"(.*)\".*",
          "WPA" : ".*IE.*/(\D*\d*)\ *.*"
          }

accesspoints = {}
tempmatch = ''

for line in scanlist:
  for key in regexes:
    match = re.search(regexes[key],line)
    if match:
      if key == "Address":
        accesspoints[match[1]] = {}
        tempmatch = match[1]
      else:
        if key == "WPA" and match[1]:
          accesspoints[tempmatch]["Encryption"] = match[1]
        else:
          accesspoints[tempmatch][key] = match[1]

print(json.dumps(accesspoints))
