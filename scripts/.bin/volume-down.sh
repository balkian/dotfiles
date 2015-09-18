#!/bin/sh
pacmd dump|awk --non-decimal-data '$1~/set-sink-volume/{system ("pacmd "$1" "$2" "$3-1000)}'
