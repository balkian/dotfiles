#!/bin/bash
OLD_VALUE=$(xfconf-query -c xfwm4 -p /general/cycle_workspaces)

if [ $OLD_VALUE == "true" ]; then
  echo 'will now disable workspace cycling'
  NEW_VALUE="false"
fi

if [ $OLD_VALUE == "false" ]; then
  echo 'will now turn on workspace cycling'
  NEW_VALUE="true"
fi

xfconf-query -c xfwm4 -p /general/cycle_workspaces -s $NEW_VALUE
