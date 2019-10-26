#!/bin/sed

s/.*Address:\ *\([a-zA-Z0-9]\+:[a-zA-Z0-9]\+:[a-zA-Z0-9]\+:[a-zA-Z0-9]\+:[a-zA-Z0-9]\+:[a-zA-Z0-9]\+\).*/\1/p
s/.*Frequency:\ *\([0-9]\+\.[0-9]\+\ *[a-zA-Z]\+\).*/\1/p
s/.*Quality=\([0-9]\+\/[0-9]\+\).*/\1/p
s/.*Signal\ level=\(-[0-9]\+\).*/\1/p
s/.*Encryption\ *key:\(on\|off\).*/\1/p
s/.*ESSID:\"\(.*\)\".*/\1/p
s/.*IE.*\/\([a-zA-Z]\+\)\ *.*/\1/p
