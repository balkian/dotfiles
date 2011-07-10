#!/bin/bash
cd $(dirname $(dirname $0))
eclipse/eclipse -vm jre1.6.0_20/bin/ || failed=1
if [ $failed -eq 1 ]; then

	zenity --warning --title "Error executing eclipse's launcher" --text "Eclipse couldn't be found in $(pwd), please, modify $0 script to point to the right location" || exit
	file=$(zenity --file-selection --title "Select the right executable");
	vm=$(zenity --file-selection --title "Select virtual machine");

	echo $file;
	if [ -n "$file" ]; then
		if [ -n "$vm" ]; then
			virt=" -vm $vm";
		fi
	$file $virt
	fi
fi
