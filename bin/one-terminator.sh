#!/bin/bash
pgrep -u "$USER" gnome-terminal | grep -qv "$$"
if [ "$?" == "0" ]; then
 WID=`xdotool search --class "terminator" | head -1`
 xdotool windowfocus $WID
 xdotool key ctrl+shift+t
 #wmctrl -i -a $WID
else
 /usr/bin/gnome-terminal
fi
