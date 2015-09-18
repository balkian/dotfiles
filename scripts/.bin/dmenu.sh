#!/bin/sh
#http://unix.stackexchange.com/questions/50539/inconsistent-behaviour-of-wmctrl-i-a-win 

# source dmenu config file if it exists
if [ -f $HOME/.dmenurc ]; then
    . $HOME/.dmenurc
else
    DMENU='dmenu -i'
fi

# get list of all windows, and their count
wmctrl_output=$(wmctrl -lx)
win_count=$(echo "$wmctrl_output" | wc -l)
# get rid of the hostname and the number in the 2nd column
hostname=$(uname -n)
win_list=$(echo "$wmctrl_output" | \
    sed -r -e 's/[^@]'$hostname'//' | \
    sed -r -e 's/ [0-9][0-9]? / /')

# select a window ($target) and extract its id ($target_id)
target=$(echo "$win_list" | $DMENU -l $win_count -p "Switch to: ")
target_id=$(echo "$target" | cut -d' ' -f1)

# switch to target window
cmd="wmctrl -i -a \"$target_id\""
eval "$cmd"

