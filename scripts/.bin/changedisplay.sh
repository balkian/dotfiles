#!/bin/bash
# Author: Andrew Martin
# Credit: http://ubuntuforums.org/showthread.php?t=1309247
echo "Enter the primary display from the following:"			# prompt for the display
xrandr --prop | grep "[^dis]connected" | cut --delimiter=" " -f1	# query connected monitors
 
read choice								# read the users's choice of monitor
 
xrandr --output $choice --primary					# set the primary monitor



