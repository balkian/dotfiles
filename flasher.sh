#!/bin/bash
# Script to copy/link Cuevana files to your home directory or play them with your default video player.
# Tested only with one cuevana instance at a time.
# The video can be played, but it's deleted when the flash player is closed (unless you copied it).
# @author: balkian

if [ -z "$1" ]; then
    PLAYER=parole;
else
    PLAYER=$1;
fi

destfile="$HOME/VideoCuevana$$"
# PID1=$(pgrep -f flash)
# info=($(lsof -p $PID1 | grep -i /tmp/flash | awk '{print $2; print $9}'))
# dir="/proc/${info[0]}/fd"
# file=${info[1]}
# #echo "pid" $pid
# #echo "file" $file
# fdn=$(ls -l  $dir | grep $file | awk '{print $9}')
files=$(sudo lsof 2>/dev/null | grep "Pepper Data" | awk '{gsub(/[a-z]/,"",$4);print "/proc/"$2"/fd/"$4}' | uniq -u)

echo "Files:" $files
for file in $files; do

    sel=$(zenity --list --radiolist --text "Select action for: $file" --column "pick" --column "Option" TRUE "play" FALSE "copy" FALSE "link")
    case $sel in 
        play)
            sudo $PLAYER $file
            ;;
        link)
            ln -s $file $destfile && echo "Video linked successfully to $destfile." && echo "Enjoy"
            ;;
        copy)
            cp $file $destfile && echo "Video copied successfully to $destfile." && echo "Enjoy"
            ;;
    esac

done;
