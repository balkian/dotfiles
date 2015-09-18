#!/bin/bash
# Script to copy Cuevana files to your home directory.
# Tested only with one cuevana instance at a time.
# @author: balkian

destfile="$HOME/VideoCuevana$$"
info=($(lsof -c /npview/i | grep -i /tmp/flash | awk '{print $2; print $9}'))
dir="/proc/${info[0]}/fd"
file=${info[1]}
#echo "pid" $pid
#echo "file" $file
fdn=$(ls -l  $dir | grep $file | awk '{print $8}')
cp $dir/$fdn $destfile && echo "Video copied successfully to $destfile." && echo "Enjoy"
