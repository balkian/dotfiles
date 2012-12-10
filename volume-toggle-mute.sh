#!/bin/sh
pacmd dump|awk --non-decimal-data '$1~/set-sink-mute/{system ("pacmd "$1" "$2" "($3=="yes"?"no":"yes"))}'
