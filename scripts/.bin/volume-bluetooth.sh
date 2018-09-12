#!/bin/bash
DEV="hci0/dev_00_A0_C6_95_DE_E8"

currentvol=`dbus-send --system --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$DEV/fd2 org.freedesktop.DBus.Properties.Get string:org.bluez.MediaTransport1 string:Volume | cut -d" " -f 12`


increment() {
    newvol=$(($currentvol + 5))
    dbus-send --system --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$DEV/fd2 org.freedesktop.DBus.Properties.Set string:org.bluez.MediaTransport1 string:Volume variant:uint16:$newvol
}

decrement() {
    newvol=$(($currentvol - 5))
    dbus-send --system --type=method_call --print-reply=literal --dest=org.bluez /org/bluez/$DEV/fd2 org.freedesktop.DBus.Properties.Set string:org.bluez.MediaTransport1 string:Volume variant:uint16:$newvol
}

$1
