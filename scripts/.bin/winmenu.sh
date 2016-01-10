#!/bin/sh


if command -v rofi >/dev/null 2>&1;
then
    program="rofi -show window"
else
    program="i3-winmenu.py"
fi

$program "$@"

