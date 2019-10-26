BEGIN { FS="[ :=/\"]*"
        OFS=""
      }

/.*Address:.*/ { print  " \"",$6 ":" $7 ":" $8 ":" $9 ":" $10 ":" $11 "\": {" }

/.*Frequency:.*/ { print " \"Frequency\" : \"", $3 $4 "\"," }

/.*Quality=.*/ { print " \"Quality\" : \"", $3 "/" $4 "\"," }

/.*Signal\ level=.*/ { print " \"Signal_level\" : \"", $7 $8 "\"," }

/.*Encryption\ key:.*/ { enc=$4
                         if ( enc == "off")
                           print " \"Encryption\" : \"",  $4 "\"," 
                        }

/.*ESSID:.*/ {
              if ( $3 ~ "^.*\"$") print " \" Essid\" : \"", $3 "\""
              else gsub(" ","<space>"); print " \"Essid\" : \"", $2 "\""
#               else FS="\""; print " \"Essid\" : \"", $2 "\""
              if ( enc == "off" ) printf "},"
              else printf ","
              }

/.*IEEE.*/ { if (enc == "on")
               print " \"Encryption\" : ", "\"" $5 "\"},"
           }




