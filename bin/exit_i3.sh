#!/bin/bash
while [ "$select" != "NO" -a "$select" != "YES" ]; do
    select=$(echo -e 'NO\nYES' | dmenu -fn "-*-cure-medium-*-*-*-11-*-*-*-*-*-*-*" -nb "#101010" -nf "#5f5f5f" -sb "#191919" -sf "#c72f62" -i -p "Do you really want to exit?");
    [ -z "$select" ] && exit 0
done
[ "$select" = "NO" ] && exit 0
i3-msg exit

##!/bin/sh
#lock() {
    #i3lock
#}

#case "$1" in
    #lock)
        #lock
        #;;
    #logout)
        #i3-msg exit
        #;;
    #suspend)
        #lock && systemctl suspend
        #;;
    #hibernate)
        #lock && systemctl hibernate
        #;;
    #reboot)
        #systemctl reboot
        #;;
    #shutdown)
        #systemctl poweroff
        #;;
    #*)
        #echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        #exit 2
#esac

#exit 0
