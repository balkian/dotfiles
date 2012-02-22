#!/bin/bash
# Script to copy/link Cuevana files to your home directory or play them with your default video player.
# Tested only with one cuevana instance at a time.
# The video can be played, but it's deleted when the flash player is closed (unless you copied it).
# @author: balkian

destfile="$HOME/VideoCuevana$$"
info=($(lsof -p `pgrep -f flashplugin` | grep -i /tmp/flash | awk '{print $2; print $9}'))
dir="/proc/${info[0]}/fd"
file=${info[1]}
#echo "pid" $pid
#echo "file" $file
fdn=$(ls -l  $dir | grep $file | awk '{print $8}')
sel=$(zenity --list --radiolist --text "Select action" --column "pick" --column "Option" TRUE "play" FALSE "copy" FALSE "link")
case $sel in 
	play)
	xdg-open $dir/$fdn
	;;
	link)
	ln -s $dir/$fdn $destfile && echo "Video linked successfully to $destfile." && echo "Enjoy"
	;;
	copy)
	cp $dir/$fdn $destfile && echo "Video copied successfully to $destfile." && echo "Enjoy"
	;;
esac
