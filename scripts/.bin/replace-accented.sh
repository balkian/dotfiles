#!/bin/sh
 
# Note: input should end with a newline
 
LINES=''
while read LINE; do
        echo $LINE | sed 's/á/a/g' | sed 's/Á/A/g' | sed 's/é/e/g' | sed 's/É/E/g' | sed 's/í/i/g' | sed 's/Í/I/g' | sed 's/ó/o/g' | sed 's/Ó/O/g' | sed 's/ú/u/g' | sed 's/Ú/U/g' | sed 's/ñ/n/g' | sed 's/Ñ/N/g' | sed 's/ü/u/g' | sed 's/Ü/U/g'
done

exit 0
