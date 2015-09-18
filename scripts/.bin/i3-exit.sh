#!/bin/bash

case "$1" in
    lock)
        xautolock -locknow
            ;;
    logout)
        while [ "$select" != "NO" -a "$select" != "YES" ]; do
            select=$(echo -e 'NO\nYES' | dmenu -fn "-*-cure-medium-*-*-*-11-*-*-*-*-*-*-*" -nb "#101010" -nf "#5f5f5f" -sb "#191919" -sf "#c72f62" -i -p "Do you really want to exit?");
                [ -z "$select" ] && exit 0
            done
            [ "$select" = "NO" ] && exit 0
            i3-msg exit
        ;;
    suspend)
        xautolock -locknow
        dbus-send --system --print-reply --dest="org.freedesktop.login1" /org/freedesktop/login1 org.freedesktop.login1.Manager.Suspend boolean:true # XFCE4-power settings
        ;;
    hibernate)
        xautolock -locknow
        dbus-send --system --print-reply --dest="org.freedesktop.login1" /org/freedesktop/login1 org.freedesktop.login1.Manager.Hibernate boolean:true # XFCE4-power settings
        ;;
    reboot)
        dbus-send --system --print-reply --dest="org.freedesktop.login1" /org/freedesktop/login1 org.freedesktop.login1.Manager.Reboot boolean:true # XFCE4-power settings
        ;;
    shutdown)
        dbus-send --system --print-reply --dest="org.freedesktop.login1" /org/freedesktop/login1 org.freedesktop.login1.Manager.PowerOff boolean:true # XFCE4-power settings
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
