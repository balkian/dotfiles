#!/bin/sh


if command -v rofi >/dev/null 2>&1;
then
    program="rofi -show window -combi-hide-mode-prefix -combi-modi drun,run -theme .bin/rofi-slate-theme.rasi"
else
    program="i3-winmenu.py"
fi

$program "$@"

